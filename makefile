############################################
#        COMMON PROTO CODE GENERATION      #
############################################

PROTO_DIR := proto
GEN_DIR := gen

# Ensure these exist
GO_GEN_DIR := $(GEN_DIR)/inventory/go
RUBY_GEN_DIR := $(GEN_DIR)/order/ruby
JAVA_GEN_DIR := $(GEN_DIR)/payments/java

############################################
#                HELP TARGET                #
############################################

help:
	@echo ""
	@echo "Usage:"
	@echo "  make all           - Generate all languages (Go, Ruby, Java)"
	@echo "  make go            - Generate Go code for Inventory service"
	@echo "  make ruby          - Generate Ruby code for Order service"
	@echo "  make java          - Generate Java code for Payments service"
	@echo "  make clean         - Remove all generated code"
	@echo ""

############################################
#          DIRECTORY PREPARATION           #
############################################

prepare:
	mkdir -p $(GO_GEN_DIR)
	mkdir -p $(RUBY_GEN_DIR)
	mkdir -p $(JAVA_GEN_DIR)

############################################
#         GO CODEGEN (Inventory)           #
############################################

go: prepare
	protoc -I $(PROTO_DIR) \
	  --go_out=$(GO_GEN_DIR) --go-grpc_out=$(GO_GEN_DIR) \
	  $(PROTO_DIR)/inventory/*.proto $(PROTO_DIR)/transport/*.proto
	@echo "✔ Go code generated at $(GO_GEN_DIR)"

############################################
#         RUBY CODEGEN (Order)             #
############################################

ruby: prepare
	protoc -I $(PROTO_DIR) \
	  --ruby_out=$(RUBY_GEN_DIR) --grpc-ruby_out=$(RUBY_GEN_DIR) \
	  $(PROTO_DIR)/order/*.proto $(PROTO_DIR)/transport/*.proto
	@echo "✔ Ruby code generated at $(RUBY_GEN_DIR)"

############################################
#         JAVA CODEGEN (Payments)          #
############################################

java: prepare
	protoc -I $(PROTO_DIR) \
	  --java_out=$(JAVA_GEN_DIR) --grpc-java_out=$(JAVA_GEN_DIR) \
	  $(PROTO_DIR)/payments/*.proto $(PROTO_DIR)/transport/*.proto
	@echo "✔ Java code generated at $(JAVA_GEN_DIR)"

############################################
#             ALL LANGUAGES               #
############################################

all: go ruby java
	@echo ""
	@echo "🎉 ALL CODE GENERATED SUCCESSFULLY!"
	@echo ""

############################################
#                  CLEAN                   #
############################################

clean:
	rm -rf $(GEN_DIR)
	@echo "🧹 Cleaned generated files!"

