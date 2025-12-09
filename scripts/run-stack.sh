#!/usr/bin/env bash

# Interactive CLI to operate Docker Compose stacks at stacks/<server>/<stack>.
# Uses gum to pick server/stack/action, switches to the matching Docker context
# while running, then restores the default context.

set -euo pipefail

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STACKS_ROOT="${STACKS_ROOT:-${ROOT_DIR}/stacks}"

ensure_context_exists() {
  local context="$1"
  if ! docker context inspect "$context" >/dev/null 2>&1; then
    echo "Docker context '${context}' does not exist or is not accessible." >&2
    exit 1
  fi
}

choose_server() {
  local servers=()
  servers=($(find "$STACKS_ROOT" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))

  if (( ${#servers[@]} == 0 )); then
    echo "No servers with stacks found under ${STACKS_ROOT}" >&2
    exit 1
  fi

  printf '%s\n' "${servers[@]}" | gum choose --header 'Pick server'
}

choose_stack() {
  local server="$1"
  local stacks=()

  stacks=($(find "$STACKS_ROOT/$server" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))

  if (( ${#stacks[@]} == 0 )); then
    echo "Server ${server} has no stacks" >&2
    exit 1
  fi

  printf '%s\n' "${stacks[@]}" | gum choose --header "Pick stack on ${server}"
}

choose_action() {
  local actions=(
    "up|Start or update (docker compose up -d)"
    "restart|Restart containers (docker compose restart)"
    "pull|Pull images only (docker compose pull)"
    "ps|List services (docker compose ps)"
    "logs|Tail logs (docker compose logs -f)"
    "down|Stop and remove (docker compose down)"
  )

  local selected
  selected="$(printf '%s\n' "${actions[@]}" | gum choose --header 'Pick action')"
  [[ -n "$selected" ]] || exit 1
  echo "$selected"
}

build_command() {
  local action="$1"
  local compose_file="$2"
  case "$action" in
    up) CMD=(docker compose -f "$compose_file" up -d) ;;
    restart) CMD=(docker compose -f "$compose_file" restart) ;;
    pull) CMD=(docker compose -f "$compose_file" pull) ;;
    ps) CMD=(docker compose -f "$compose_file" ps) ;;
    logs) CMD=(docker compose -f "$compose_file" logs -f) ;;
    down) CMD=(docker compose -f "$compose_file" down) ;;
    *)
      echo "Unknown action: $action" >&2
      exit 1
      ;;
  esac
}

show_summary() {
  gum format -- <<EOF
# Stack runner
- Server: **${SERVER}**
- Stack: **${STACK}**
- Action: **${ACTION_LABEL}**
- Context: **${SERVER}**
- Compose: \`${COMPOSE_FILE}\`
- Command: \`$(printf '%q ' "${CMD[@]}")\`
EOF
}

cleanup() {
  gum style --foreground 212 "Switching context back to default..."
  docker context use default >/dev/null
}

main() {
  require_cmd gum
  require_cmd docker

  if [[ ! -d "$STACKS_ROOT" ]]; then
    echo "Stacks folder not found at ${STACKS_ROOT}" >&2
    exit 1
  fi

  SERVER="$(choose_server)"
  [[ -n "$SERVER" ]] || exit 1

  STACK="$(choose_stack "$SERVER")"
  [[ -n "$STACK" ]] || exit 1

  COMPOSE_FILE="${STACKS_ROOT}/${SERVER}/${STACK}/compose.yml"

  SELECTED_ACTION="$(choose_action)"
  ACTION_KEY="${SELECTED_ACTION%%|*}"
  ACTION_LABEL="${SELECTED_ACTION#*|}"

  build_command "$ACTION_KEY" "$COMPOSE_FILE"

  ensure_context_exists "$SERVER"

  show_summary
  gum confirm "Proceed?" || exit 0

  trap cleanup EXIT

  gum style --foreground 212 "Switching to context ${SERVER}..."
  docker context use "$SERVER" >/dev/null

  gum style --foreground 212 "Running: $(printf '%q ' "${CMD[@]}")"
  "${CMD[@]}"
}

main "$@"
