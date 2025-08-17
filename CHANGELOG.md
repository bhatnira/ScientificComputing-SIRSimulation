# Changelog

All notable changes to the SIR Epidemic Simulation project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-08-17

### Added
- Complete refactoring of monolithic `Simulation.cpp` into modular architecture
- `Person` class with clean state management and const-correct interfaces
- `Population` class with smart pointer memory management and RAII principles
- `SIRSimulation` orchestrator class with configuration management
- `SimulationConfig` structure with parameter validation and default values
- Comprehensive Doxygen-style documentation for all classes and methods
- Professional Makefile with multiple build targets and code quality tools
- MIT License for open-source distribution
- `.gitignore` file for clean repository management
- Detailed README.md with usage examples, scientific background, and contribution guidelines

### Enhanced
- Memory safety using `std::unique_ptr` instead of raw pointers
- Exception handling with proper error messages and parameter validation
- Output formatting with aligned columns and percentage calculations
- Early termination detection when epidemic naturally ends
- Const-correctness throughout the codebase
- Modern C++14 features and best practices

### Improved
- Code organization with clear separation of concerns
- Function and variable naming for better readability
- Documentation with mathematical background and epidemiological context
- Build system with debug, release, and analysis targets
- Error handling with informative exception messages

### Fixed
- Memory leaks from original raw pointer implementation
- Inconsistent naming conventions
- Missing parameter validation
- Poor code structure and maintainability issues

### Technical Details
- **Architecture**: Modular design with Person -> Population -> Simulation hierarchy
- **Memory Management**: RAII with smart pointers, no manual memory management
- **Error Handling**: Exception-based validation with detailed error messages
- **Performance**: O(n×d) time complexity with efficient algorithms
- **Documentation**: Complete API documentation with usage examples
- **Standards Compliance**: C++14 standard with modern best practices

### Compatibility
- Requires C++14 compliant compiler (g++, clang++)
- Compatible with Unix-like systems (Linux, macOS, WSL)
- No external dependencies beyond standard library

### Migration Notes
- Original `Simulation.cpp` replaced with modular architecture
- API changes: Configuration now uses `SimulationConfig` structure
- Enhanced error handling may throw exceptions for invalid parameters
- Output format improved with better alignment and statistics

---

## Future Versions (Planned)

### [1.1.0] - Planned
- Command-line argument parsing for runtime parameter configuration
- CSV output format for data analysis
- Basic visualization output (plotting preparation)
- Unit test framework integration

### [1.2.0] - Planned  
- Vaccination strategies and SEIR model extension
- Age-structured population demographics
- Spatial transmission models
- Performance optimizations for very large populations

### [2.0.0] - Planned
- GUI interface for interactive parameter adjustment
- Real-time epidemic curve visualization
- Parameter estimation from real data
- Multi-threaded simulation for large-scale studies
