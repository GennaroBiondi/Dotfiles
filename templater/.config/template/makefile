# Detect OS
ifeq ($(OS),Windows_NT)
    INSTALL_DIR := $(USERPROFILE)/bin
    EXE_EXT := .exe
else
    INSTALL_DIR := $(HOME)/.local/bin
    EXE_EXT :=
endif

PROGRAM_NAME := program

SRC := $(shell find src -name "*.cpp")
OBJ_DIR := obj
OBJ := $(patsubst src/%.cpp,$(OBJ_DIR)/%.o,$(SRC))
INCLUDE := -Isrc

CXX := g++

CFLAGS_DEBUG := -Wall -Wextra -pedantic-errors -std=c++23 -g $(INCLUDE)
CFLAGS_RELEASE := -O3 -flto -DNDEBUG -std=c++23 -march=native $(INCLUDE)

BIN := bin/$(PROGRAM_NAME)-debug$(EXE_EXT)
BIN_RELEASE := bin/$(PROGRAM_NAME)$(EXE_EXT)

all: debug

debug: $(BIN)

release: $(BIN_RELEASE)

$(BIN): $(OBJ) | bin
	$(CXX) $(OBJ) $(CFLAGS_DEBUG) -o $(BIN)

$(BIN_RELEASE): $(OBJ) | bin
	$(CXX) $(OBJ) $(CFLAGS_RELEASE) -o $(BIN_RELEASE)

$(OBJ_DIR)/%.o: src/%.cpp | $(OBJ_DIR)
	$(CXX) $(CFLAGS_DEBUG) -c $< -o $@

bin:
	mkdir -p bin

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

run: debug
	./$(BIN)

build: release
	@echo "Installing to $(INSTALL_DIR)"
	@mkdir -p $(INSTALL_DIR)
	install -Dm755 $(BIN_RELEASE) $(INSTALL_DIR)/$(PROGRAM_NAME)$(EXE_EXT)
	@echo "Installed $(PROGRAM_NAME) to $(INSTALL_DIR)"

clean:
	rm -rf $(OBJ_DIR) $(BIN) $(BIN_RELEASE)rm -rf $(OBJ_DIR) $(BIN) $(BIN_RELEASE)
