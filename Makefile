#Replace this with your github.com/<username>/<repository> name
GO_MODULE := github.com/pushpendras21/protobuf-grpc

.PHONY: clean
clean:
ifeq ($(OS),Windows_NT)
  if exist "protogen" rd /s /q protogen
  mkdir protogen\go
  else {
	rm -rF ./protogen/go
  endif
  }


.PHONY: protoc-go
protoc-go:
	protoc --go_opt=module=$(GO_MODULE) --go_out=. \
	--go-grpc_opt=module=$(GO_MODULE) --go-grpc_out=. \
	./proto/hello/*.proto ./proto/payment/*.proto ./proto/transaction/*.proto \
	./proto/bank/*.proto ./proto/bank/type/*.proto \
	./proto/resilience/*.proto


.PHONY: build
build: clean protoc-go


.PHONY: pipeline-init
pipeline-init:
  sudo apt-get install -y protobuf-compiler golang-goprotobuf-dev
  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
