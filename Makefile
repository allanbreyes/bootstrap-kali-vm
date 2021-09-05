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
secrets: secrets/gpg/key.asc

.PHONY: snapshot
snapshot:
	@if ! $(SNAPSHOT) list | grep -q $(VM_SNAP); then \
			$(SNAPSHOT) take $(VM_SNAP); \
		fi

secrets/ssh/id_ed25519:
	@mkdir -p ./secrets/ssh
	@ssh-keygen -t ed25519 -f "$@" -C "nobody@nowhere" -N ""

secrets/gpg/key.asc:
	@mkdir -p ./secrets/gpg
	@gpg --full-gen-key
	@gpg --list-keys
	@read -p "ID: " id; gpg --export-secret-key --armor $$id > "$@"
	@chmod 400 "$@"
