# .bin
BIN_ROOT=$(PWD)/.bin
export PATH:=$(PATH):$(BIN_ROOT)

# os
BASE_OS_NAME := $(shell go env GOOS)
BASE_OS_ARCH := $(shell go env GOARCH)

XTEM_CADDY_NAME=xtemplate-caddy_$(BASE_OS_NAME)_$(BASE_OS_ARCH)
ifeq ($(OS_NAME),windows)
	XTEM_CADDY_NAME=xtemplate-caddy_$(BASE_OS_NAME)_$(BASE_OS_ARCH).exe
endif


print:
	@echo ""
	@echo "BASE_OS_NAME:        $(BASE_OS_NAME)"
	@echo "BASE_OS_ARCH:        $(BASE_OS_ARCH)"
	@echo "XTEM_CADDY_NAME:     $(XTEM_CADDY_NAME)"

ci-all: print xtemcaddy-bin


xtemcaddy-bin:
	cd $(PWD)/example && go build -o $(BIN_ROOT)/$(XTEM_CADDY_NAME) .
xtemcaddy-bin-cgo:
	cd $(PWD)/example && GOFLAGS='-tags="sqlite_json"' CGO_ENABLED=1 go build -o $(BIN_ROOT)/$(XTEM_CADDY_NAME) .
xtemcaddy-run:
	cd $(PWD)/example && $(XTEM_CADDY_NAME) run --config CaddyFile
	# http://localhost:8080
	# https://localhost:8080
xtemcaddy-start:
	cd $(PWD)/example && $(XTEM_CADDY_NAME) start --config CaddyFile
	# http://localhost:8080
	# https://localhost:8080