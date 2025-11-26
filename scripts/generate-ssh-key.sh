#!/usr/bin/env bash

set -euo pipefail

SOURCE_HOST="$(hostname)"
SOURCE_USER="$USER"

# Ensure ~/.ssh exists with safe permissions
SSH_DIR="$HOME/.ssh"
if [[ ! -d "$SSH_DIR" ]]; then
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
fi

echo "=== SSH key generator ==="

# ---- Form ----
DEST_HOST=$(gum input --placeholder "Enter destination host name (e.g., atlas)")
DEST_USER=$(gum input --placeholder "Enter destination user (e.g., admin)")
DEST_IP=$(gum input --placeholder "Destination IP (e.g., 192.168.1.50)")
DEST_DOMAIN=$(gum input --placeholder "Optional destination domain (e.g., atlas.home.local)")

# ---- Build key name and comment ----
KEY_NAME="id_ed25519_${DEST_HOST}_${DEST_USER}"
KEY_PATH="${SSH_DIR}/${KEY_NAME}"
KEY_COMMENT="${SOURCE_HOST} -> ${DEST_USER}@${DEST_HOST}"

gum confirm "Create key: $KEY_NAME ? (comment: '$KEY_COMMENT')" || exit 1

# ---- Create SSH key ----
ssh-keygen -t ed25519 \
  -C "${KEY_COMMENT}" \
  -f "${KEY_PATH}" \
  -N ""

# ---- Create SSH config entry ----
SSH_CONFIG="${SSH_DIR}/config"

if [[ ! -f "$SSH_CONFIG" ]]; then
  touch "$SSH_CONFIG"
fi
chmod 600 "$SSH_CONFIG"
CONFIG_ENTRY=$(cat <<EOF

Host ${DEST_HOST} ${DEST_DOMAIN} ${DEST_IP}
    HostName ${DEST_IP}
    User ${DEST_USER}
    IdentityFile ${KEY_PATH}
    IdentitiesOnly yes

EOF
)

echo
gum style --foreground 212 "Key generated:"
echo "  ${KEY_PATH}"
echo "  ${KEY_PATH}.pub"
echo
gum style --foreground 212 "Entry added to ~/.ssh/config:"
echo "${CONFIG_ENTRY}"

# ---- Optional copy SSH key to remote server ----
if gum confirm "Copy the public key to server ${DEST_HOST} as ${DEST_USER}?"; then
    ssh-copy-id -i "${KEY_PATH}.pub" "${DEST_USER}@${DEST_HOST}"
    gum style --foreground 212 "Key installed successfully on ${DEST_USER}@${DEST_HOST}"
else
    gum style --foreground 214 "You can copy it later with:"
    echo "ssh-copy-id -i ${KEY_PATH}.pub ${DEST_USER}@${DEST_HOST}"
fi
