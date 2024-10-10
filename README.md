# Hybrid C++/Fortran project & Call Fortran from C++ in CMake Project

Somewhere else has a comprehensive one, e.g., [CMake Cookbook](https://github.com/dev-cafe/cmake-cookbook) and here you are a simple one.

Two examples of calling Fortran from C++ are being examined. They tries to expose the following Fortran functions to C++:

```fortran
module square_mod
    use, intrinsic :: iso_c_binding, only: c_float
    implicit none
    
    private
    public :: c_square
    public :: square
    public :: square_with_binding
    
    contains

    ! navie fortran function without binding
    function square(x)
        real(c_float), value :: x
        real(c_float) :: square
        
        square = x * x
    end function square

    function square_with_binding(x) bind(C, name="square_with_binding")
        real(c_float), value :: x
        real(c_float) :: square_with_binding
        
        square_with_binding = square(x)
    end function square_with_binding

    ! fortran function with binding
    function c_square(x) bind(C, name="c_square")
        real(c_float), value :: x
        real(c_float) :: c_square
        
        print *, "Fortran: Received input", x
        c_square = x * x
        print *, "Fortran: Calculated result", c_square
    end function c_square
    
end module square_mod
```

## Example 1

Fortran itselfs provides a module to interface with C, e.g., `iso_c_binding`. The practice is to add `bind(C, name="square_with_binding")` to the Fortran functions that are to be exposed to C/C++. Note that `iso_c_binding` should be used in the Fortran source code.

## Example 2

The second is to use the FortranCInterface CMake module. The Fortran source code is not modified. Instead, the CMakeLists.txt is modified to include the FortranCInterface module and to specify the symbols to be exported.
