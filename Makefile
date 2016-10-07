# Use shadowsocks as command prefix to avoid name conflict
# Maybe ss-local/server is better because easier to type
PREFIX := shadowsocks
LOCAL := ./bin/$(PREFIX)-local
SERVER := ./bin/$(PREFIX)-server
CGO := CGO_ENABLED=1
GO_LDFLAGS=-ldflags "-w"

TAG=dev
IMAGE=dhub.yunpro.cn/shenshouer/distribute

build: ## build the go packages
	@echo "$@"
	
clean:
	@echo "$@"
	rm -f $(LOCAL) $(SERVER) $(TEST)

$(LOCAL): shadowsocks/*.go cmd/$(PREFIX)-local/*.go
	mkdir -p ./bin; $(CGO) GOOS=linux go build -a -installsuffix cgo ${GO_LDFLAGS} -o ./bin/$(PREFIX)-local ./cmd/$(PREFIX)-local/local.go

$(SERVER): shadowsocks/*.go cmd/$(PREFIX)-server/*.go
	mkdir -p ./bin; $(CGO) GOOS=linux go build -a -installsuffix cgo ${GO_LDFLAGS} -o ./bin/$(PREFIX)-server ./cmd/$(PREFIX)-server/server.go

server: $(SERVER)

local: $(LOCAL)