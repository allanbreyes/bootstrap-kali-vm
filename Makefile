VM_NAME  ?= kali
VM_SNAP  ?= initial
SNAPSHOT := VBoxManage snapshot $(VM_NAME)

.PHONY: all
all: box snapshot

.PHONY: box
box:
	@vagrant up

.PHONY: snapshot
snapshot:
	@if ! $(SNAPSHOT) list | grep -q $(VM_SNAP); then \
			$(SNAPSHOT) take $(VM_SNAP); \
		fi