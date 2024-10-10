# Fortran-C++ Integration Example

This project demonstrates how to wrap a simple Fortran function for use in C++.

## Project Structure

- `src/square.f90`: Fortran module containing a function to calculate the square of a number.
- `src/FortranWrapper.hpp`: C++ header file declaring the wrapper for the Fortran function.
- `src/FortranWrapper.cpp`: C++ source file implementing the wrapper function.
- `src/main.cpp`: C++ main file demonstrating the usage of the wrapped Fortran function.
- `CMakeLists.txt`: Top-level CMake configuration file.
- `src/CMakeLists.txt`: CMake configuration file for the source directory.

## Building the Project

To build the project, follow these steps:

1. Create a build directory:
   ```
   mkdir build
   cd build
   ```

2. Run CMake:
   ```
   cmake ..
   ```

3. Build the project:
   ```
   cmake --build .
   ```

## Running the Example

After building, you can run the example by executing:

```
./bin/fortran_cxx_example
```

This will calculate the square of 5 using the Fortran function and display the result.

## How it Works

1. The Fortran module `square_mod` in `square.f90` defines a function `square` that calculates the square of a number.
2. `FortranWrapper.hpp` declares the C++ wrapper function and the external Fortran function with C linkage.
3. `FortranWrapper.cpp` implements the C++ wrapper function, which calls the Fortran function.
4. `main.cpp` demonstrates how to use the wrapped Fortran function in C++ code.
5. The CMake files set up the project to compile and link the Fortran and C++ code together.

This example shows how you can integrate Fortran code into a C++ project, allowing you to use existing Fortran libraries or write performance-critical parts in Fortran while using them seamlessly in a C++ application.