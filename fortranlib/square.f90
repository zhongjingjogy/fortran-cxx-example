module square_mod
    
    implicit none
    
    private
    public :: square
    
    contains
    
    function square(x) result(y)
        real, intent(in) :: x
        real :: y
        
        y = x * x
    end function square
    
end module square_mod