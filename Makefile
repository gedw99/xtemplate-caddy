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
XTEM_CADDY_BIN=$(BIN_ROOT)/$(XTEM_CADDY_NAME)
XTEM_CADDYFILE=$(PWD)/example/Caddyfile


print:
	@echo ""
	@echo "BASE_OS_NAME:        $(BASE_OS_NAME)"
	@echo "BASE_OS_ARCH:        $(BASE_OS_ARCH)"
	@echo "XTEM_CADDY_NAME:     $(XTEM_CADDY_NAME)"
	@echo "XTEM_CADDY_BIN:      $(XTEM_CADDY_BIN)"
	@echo "XTEM_CADDYFILE:      $(XTEM_CADDYFILE)"
	
# for local only.
all: print xtemcaddy-bin
# for CI only
ci-all: print xtemcaddy-bin xtemcaddy-test

xtemcaddy-bin:
	cd $(PWD)/example && go get -v -t -d ./...
	cd $(PWD)/example && go build -o $(BIN_ROOT)/$(XTEM_CADDY_NAME) .
xtemcaddy-bin-cgo:
	# build with CGO in order to use the sqlite3 db driver and enable the sqlite_json build tag to get json funcs
	cd $(PWD)/example && GOFLAGS='-tags="sqlite_json"' CGO_ENABLED=1 go build -o $(BIN_ROOT)/$(XTEM_CADDY_NAME) .
xtemcaddy-run:
	cd $(PWD)/example && $(XTEM_CADDY_NAME) run --config Caddyfile
	# http://localhost:8080
	# https://localhost:8080
xtemcaddy-test: xtemcaddy-start xtemcaddy-stop
xtemcaddy-start:
	$(XTEM_CADDY_BIN) start --config $(XTEM_CADDYFILE)
	#cd $(PWD)/example && $(XTEM_CADDY_BIN) start --config Caddyfile
	# http://localhost:8080
	# https://localhost:8080
xtemcaddy-stop:
	$(XTEM_CADDY_BIN) stop --config $(XTEM_CADDYFILE)
	#cd $(PWD)/example && $(XTEM_CADDY_BIN) stop --config Caddyfile
