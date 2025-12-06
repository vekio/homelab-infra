ANSIBLE_PLAYBOOK ?= ansible-playbook
export ANSIBLE_CONFIG := ansible/ansible.cfg
ANSIBLE_VARS := --extra-vars @ansible/vars.yml

.PHONY: update sudo harden docker deploy setup_host

# update: Perform apt upgrade and basic housekeeping.
update:
	@echo "🛠️  Running host update..."
	$(ANSIBLE_PLAYBOOK) ansible/playbooks/update_host.yml $(ANSIBLE_VARS)

# sudo: Manage passwordless sudo drop-ins.
sudo:
	@echo "🧾  Configuring sudoers..."
	$(ANSIBLE_PLAYBOOK) ansible/playbooks/setup_passwordless_sudo.yml $(ANSIBLE_VARS) --ask-become-pass

# harden: Apply SSH hardening profile.
harden:
	@echo "🛡️  Applying SSH hardening..."
	$(ANSIBLE_PLAYBOOK) ansible/playbooks/secure_ssh.yml $(ANSIBLE_VARS)

# docker: Install/upgrade Docker Engine stack.
docker:
	@echo "🐳  Installing/updating Docker..."
	$(ANSIBLE_PLAYBOOK) ansible/playbooks/setup_docker_engine.yml $(ANSIBLE_VARS)

# deploy: Render and sync every catalog service on each host.
deploy:
	@echo "🚀  Deploying all catalog services..."
	$(ANSIBLE_PLAYBOOK) ansible/playbooks/deploy_all_services.yml $(ANSIBLE_VARS)

setup_host: sudo update harden docker
