package main

import (
	caddycmd "github.com/caddyserver/caddy/v2/cmd"

	_ "github.com/infogulch/xtemplate-caddy"

	// Add xtemplate dot providers:
	_ "github.com/infogulch/xtemplate/providers"
	_ "github.com/infogulch/xtemplate/providers/nats"
	// Add other caddy modules:
	//_ "github.com/greenpau/caddy-security"
)

func main() {
	caddycmd.Main()
}
