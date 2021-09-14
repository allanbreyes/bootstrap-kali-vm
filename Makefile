VM_NAME  ?= kali
VM_SNAP  ?= initial
SNAPSHOT := VBoxManage snapshot $(VM_NAME)

.PHONY: all
all: secrets box snapshot

.PHONY: box
box:
	@vagrant up

.PHONY: secrets
secrets: secrets/id_ed25519
secrets: secrets/key.asc
secrets: secrets/pass.txt

.PHONY: snapshot
snapshot:
	@if ! $(SNAPSHOT) list | grep -q $(VM_SNAP); then \
			$(SNAPSHOT) take $(VM_SNAP); \
		fi

secrets/id_ed25519:
	@ssh-keygen -t ed25519 -f "$@" -C "nobody@nowhere" -N ""

secrets/key.asc:
	@gpg --full-gen-key
	@gpg --list-keys
	@read -p "ID: " id; gpg --export-secret-key --armor $$id > "$@"
	@chmod 400 "$@"

secrets/pass.txt:
	@printf "($(VM_NAME)) "
	@mkpasswd -m sha-512 > "$@"
	@chmod 400 "$@"
