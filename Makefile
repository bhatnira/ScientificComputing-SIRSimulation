# ===================================================================
# Makefile for SIR Epidemic Simulation
# Scientific Computing Project
# ===================================================================

# Compiler and tools
CXX = g++
CXXFLAGS = -std=c++14 -Wall -Wextra -Wpedantic -O2
DEBUGFLAGS = -g -DDEBUG -O0
LDFLAGS = 

# Directories
SRCDIR = .
OBJDIR = obj
BINDIR = .

# Target executable
TARGET = sir_simulation

# Source files and headers
SOURCES = Person.cpp Population.cpp SIRSimulation.cpp
HEADERS = Person.h Population.h Simulation.h
OBJECTS = $(SOURCES:.cpp=.o)

# Version info
VERSION = 1.0.0

# ===================================================================
# Build targets
# ===================================================================

# Default target
.DEFAULT_GOAL := all
all: $(TARGET)

# Build the executable
$(TARGET): $(OBJECTS)
	@echo "Linking $(TARGET)..."
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^
	@echo "Build complete: $(TARGET)"

# Build object files
%.o: %.cpp $(HEADERS)
	@echo "Compiling $<..."
	$(CXX) $(CXXFLAGS) -c $< -o $@

# ===================================================================
# Development targets
# ===================================================================

# Debug build
debug: CXXFLAGS += $(DEBUGFLAGS)
debug: clean $(TARGET)
	@echo "Debug build complete"

# Release build with optimizations
release: CXXFLAGS += -O3 -DNDEBUG
release: clean $(TARGET)
	@echo "Release build complete"

# ===================================================================
# Execution targets
# ===================================================================

# Run the simulation
run: $(TARGET)
	@echo "Running SIR simulation..."
	@echo "=================================="
	./$(TARGET)

# Run with specific parameters (example)
run-large: $(TARGET)
	@echo "Running large population simulation..."
	./$(TARGET) # Add parameter handling if implemented

# ===================================================================
# Maintenance targets
# ===================================================================

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -f $(OBJECTS) $(TARGET) *.dSYM
	@echo "Clean complete"

# Rebuild everything
rebuild: clean all

# Install (copy to system directory - customize as needed)
install: $(TARGET)
	@echo "Installing $(TARGET)..."
	# cp $(TARGET) /usr/local/bin/
	@echo "Install target not implemented - customize as needed"

# ===================================================================
# Code quality and documentation
# ===================================================================

# Format code (requires clang-format)
format:
	@echo "Formatting source code..."
	@if command -v clang-format >/dev/null 2>&1; then \
		clang-format -i $(SOURCES) $(HEADERS); \
		echo "Code formatting complete"; \
	else \
		echo "clang-format not found - install for code formatting"; \
	fi

# Static analysis (requires cppcheck)
analyze:
	@echo "Running static analysis..."
	@if command -v cppcheck >/dev/null 2>&1; then \
		cppcheck --enable=all --std=c++14 $(SOURCES); \
	else \
		echo "cppcheck not found - install for static analysis"; \
	fi

# Generate documentation (requires doxygen)
docs:
	@echo "Generating documentation..."
	@if command -v doxygen >/dev/null 2>&1; then \
		doxygen Doxyfile; \
	else \
		echo "doxygen not found - install for documentation generation"; \
	fi

# ===================================================================
# Information targets
# ===================================================================

# Show project information
info:
	@echo "SIR Epidemic Simulation v$(VERSION)"
	@echo "Compiler: $(CXX)"
	@echo "Flags: $(CXXFLAGS)"
	@echo "Sources: $(SOURCES)"
	@echo "Headers: $(HEADERS)"
	@echo "Target: $(TARGET)"

# Show help
help:
	@echo "SIR Epidemic Simulation Makefile"
	@echo "================================="
	@echo ""
	@echo "Build targets:"
	@echo "  all      - Build the simulation (default)"
	@echo "  debug    - Build with debug information"
	@echo "  release  - Build optimized release version"
	@echo ""
	@echo "Execution targets:"
	@echo "  run      - Build and run the simulation"
	@echo "  run-large- Run with large population settings"
	@echo ""
	@echo "Maintenance targets:"
	@echo "  clean    - Remove build artifacts"
	@echo "  rebuild  - Clean and rebuild"
	@echo "  install  - Install to system (customize first)"
	@echo ""
	@echo "Code quality targets:"
	@echo "  format   - Format code with clang-format"
	@echo "  analyze  - Run static analysis with cppcheck"
	@echo "  docs     - Generate documentation with doxygen"
	@echo ""
	@echo "Information targets:"
	@echo "  info     - Show project information"
	@echo "  help     - Show this help message"

# ===================================================================
# Special targets
# ===================================================================

.PHONY: all clean rebuild run debug release install format analyze docs info help run-large
