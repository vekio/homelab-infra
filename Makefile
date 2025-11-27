ANSIBLE_PLAYBOOK ?= ansible-playbook
export ANSIBLE_CONFIG := $(CURDIR)/ansible/ansible.cfg
PLAYBOOK_DIR := ansible/playbooks
VARS_FILE := ansible/vars.yml
INVENTORY := ansible/inventory.yml
ANSIBLE_ARGS := -i $(INVENTORY) -e @$(VARS_FILE)

.PHONY: hello prepare sudo harden docker all

hello:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_DIR)/hello_world.yml $(ANSIBLE_ARGS)

prepare:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_DIR)/prepare_host.yml $(ANSIBLE_ARGS)

sudo:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_DIR)/configure_sudo.yml $(ANSIBLE_ARGS)

harden:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_DIR)/harden_ssh.yml $(ANSIBLE_ARGS)

docker:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_DIR)/install_docker.yml $(ANSIBLE_ARGS)

all: hello prepare sudo harden docker
