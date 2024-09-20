.PHONY: clean

BIN_DIR = .bin
SRC_DIR = src

TARGET = app.elf
COMPILER = g++
EXTERNAL = external

SOURCE_FILES := \
	$(wildcard $(SRC_DIR)/*.cpp)\
	$(wildcard $(SRC_DIR)/*/*.cpp)

OBJECT_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(BIN_DIR)/%.o,$(SOURCE_FILES))

CFLAGS = -pedantic -Iinclude
LDFLAGS =

RM = rm -f
MKDIR = mkdir -p

$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BIN_DIR)
	@$(MKDIR) $(dir $@)
	@$(COMPILER) -c -o $@ $< $(CFLAGS)
	$(info [$(COMPILER)] Compilling $< -> $@...)

$(TARGET): $(OBJECT_FILES)
	@$(COMPILER) -o $@ $^ $(LDFLAGS)
	$(info Generating $(TARGET) executable...)

$(BIN_DIR):
	@$(MKDIR) $(BIN_DIR)
	$(info Generate bin directory...)

clean:
	@$(RM) $(TARGET) $(OBJECT_FILES)
	@$(RM) -rf $(BIN_DIR)
	$(info Cleaning...)

