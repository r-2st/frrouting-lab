SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
.NOTPARALLEL:
.DEFAULT_GOAL := help

ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
ROUTERS := frr_router1 frr_router2
ROUTER ?= frr_router1

BOLD := \033[1m
CYAN := \033[36m
GREEN := \033[32m
RESET := \033[0m

.PHONY: help workflow up down halt destroy reload provision status ssh ssh-router1 ssh-router2 clean

help: ## Show available targets
	@printf "$(BOLD)FRRouting Lab$(RESET)\n"
	printf "Usage: $(CYAN)make <target>$(RESET) [ROUTER=frr_router1|frr_router2]\n\n$(BOLD)Targets:$(RESET)\n"
	awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_-]+:.*## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	printf "\n$(BOLD)Typical workflow:$(RESET) Run $(GREEN)make workflow$(RESET) for the usual lab checklist.\n"

workflow: ## Print the usual lab lifecycle
	@printf "$(BOLD)Bring the lab up$(RESET)\n"
	printf "  make up                  # boot frr_router1 and frr_router2, provisioning FRR\n"
	printf "  make status              # confirm both routers are running\n\n"
	printf "$(BOLD)Work with the routers$(RESET)\n"
	printf "  make ssh-router1         # shell into frr_router1\n"
	printf "  make ssh-router2         # shell into frr_router2\n"
	printf "  make ssh ROUTER=<name>   # shell into an arbitrary router\n"
	printf "  make reload              # restart and re-run provisioning after config changes\n\n"
	printf "$(BOLD)Tear the lab down$(RESET)\n"
	printf "  make halt                # stop both routers, keep disks\n"
	printf "  make destroy             # remove both routers\n"
	printf "  make clean               # destroy and remove local .vagrant state\n"

up: ## vagrant up (create/start both routers)
	@cd "$(ROOT)" && vagrant up

down: halt ## Alias for halt

halt: ## vagrant halt (stop both routers, keep disks)
	@cd "$(ROOT)" && vagrant halt

destroy: ## vagrant destroy -f (remove both routers)
	@cd "$(ROOT)" && vagrant destroy -f

reload: ## vagrant reload --provision (restart + re-run provisioning)
	@cd "$(ROOT)" && vagrant reload --provision

provision: ## vagrant provision (re-run provisioning on running routers)
	@cd "$(ROOT)" && vagrant provision

status: ## vagrant status
	@cd "$(ROOT)" && vagrant status

ssh: ## SSH into ROUTER (default frr_router1)
	@cd "$(ROOT)" && vagrant ssh "$(ROUTER)"

ssh-router1: ## SSH into frr_router1
	@cd "$(ROOT)" && vagrant ssh frr_router1

ssh-router2: ## SSH into frr_router2
	@cd "$(ROOT)" && vagrant ssh frr_router2

clean: destroy ## Destroy and remove local .vagrant state
	@rm -rf "$(ROOT)/.vagrant"
