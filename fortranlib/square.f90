module square_mod
    use, intrinsic :: iso_c_binding, only: c_float
    implicit none
    
    private
    public :: c_square
    
    contains
    
    function c_square(x) bind(C, name="c_square")
        real(c_float), value :: x
        real(c_float) :: c_square
        
        print *, "Fortran: Received input", x
        c_square = x * x
        print *, "Fortran: Calculated result", c_square
    end function c_square
    
end module square_mod