VM_NAME  ?= kali
VM_SNAP  ?= initial
SNAPSHOT := VBoxManage snapshot $(VM_NAME)

.PHONY: all
all: secrets box snapshot

.PHONY: box
box:
	@vagrant up

.PHONY: secrets
secrets: secrets/ssh/id_ed25519

.PHONY: snapshot
snapshot:
	@if ! $(SNAPSHOT) list | grep -q $(VM_SNAP); then \
			$(SNAPSHOT) take $(VM_SNAP); \
		fi

secrets/ssh/id_ed25519:
	@mkdir -p ./secrets/ssh
	@ssh-keygen -t ed25519 -f "$@" -C "nobody@nowhere" -N ""
