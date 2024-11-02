module structure_handler
    use iso_c_binding
    implicit none

    ! Define the structure
    type, bind(C) :: test_structure
        real(c_float) :: single_float
        integer(c_int) :: single_int
        real(c_float) :: float_array(5)
        integer(c_int) :: int_array(3)
        character(kind=c_char) :: single_string(100)  ! Fixed-length string
        character(kind=c_char) :: string_array(4 * 100)  ! 4 strings, each 100 chars
    end type test_structure

    type, bind(C) :: test_structure_dynamic
        integer(c_int) :: dimension
        type(c_ptr) :: float_array     ! Dynamic float array
        type(c_ptr) :: int_array       ! Dynamic integer array
        type(c_ptr) :: string_array    ! Dynamic string array
        integer(c_int) :: num_strings  ! Number of strings
        real(c_float) :: single_float
        integer(c_int) :: single_int
        character(kind=c_char) :: single_string(100)
    end type test_structure_dynamic

    public :: test_structure, test_structure_dynamic, populate_structure_c, create_dynamic_structure_c

contains
    subroutine populate_structure_c(struct) bind(C, name="populate_structure_c")
        type(test_structure), intent(out) :: struct
        
        ! Local variables
        integer :: i
        character(len=100) :: temp_str
        
        ! Populate single float and int
        struct%single_float = 3.14159
        struct%single_int = 42
        
        ! Populate float array
        do i = 1, 5
            struct%float_array(i) = i * 1.1
        end do
        
        ! Populate integer array
        do i = 1, 3
            struct%int_array(i) = i * 10
        end do
        
        ! Populate single string
        temp_str = "Hello from Fortran!"
        do i = 1, len_trim(temp_str)
            struct%single_string(i) = temp_str(i:i)
        end do
        struct%single_string(len_trim(temp_str) + 1) = c_null_char
        
        ! Populate string array
        ! String 1
        temp_str = "First string"
        do i = 1, len_trim(temp_str)
            struct%string_array(i) = temp_str(i:i)
        end do
        struct%string_array(len_trim(temp_str) + 1) = c_null_char
        
        ! String 2
        temp_str = "Second string"
        do i = 1, len_trim(temp_str)
            struct%string_array(100 + i) = temp_str(i:i)
        end do
        struct%string_array(100 + len_trim(temp_str) + 1) = c_null_char
        
        ! String 3
        temp_str = "Third string"
        do i = 1, len_trim(temp_str)
            struct%string_array(200 + i) = temp_str(i:i)
        end do
        struct%string_array(200 + len_trim(temp_str) + 1) = c_null_char
        
        ! String 4
        temp_str = "Fourth string"
        do i = 1, len_trim(temp_str)
            struct%string_array(300 + i) = temp_str(i:i)
        end do
        struct%string_array(300 + len_trim(temp_str) + 1) = c_null_char
        
    end subroutine populate_structure_c

    subroutine create_dynamic_structure_c(struct, dim, num_str) bind(C, name="create_dynamic_structure_c")
        type(test_structure_dynamic), intent(inout) :: struct
        integer(c_int), value, intent(in) :: dim
        integer(c_int), value, intent(in) :: num_str
        
        ! Local variables
        integer :: i
        real(c_float), pointer :: float_arr(:)
        integer(c_int), pointer :: int_arr(:)
        character(kind=c_char), pointer :: str_arr(:)
        character(len=100) :: temp_str

        ! Set dimensions
        struct%dimension = dim
        struct%num_strings = num_str

        ! Allocate and initialize float array
        allocate(float_arr(dim))
        do i = 1, dim
            float_arr(i) = i * 1.1
        end do
        struct%float_array = c_loc(float_arr(1))

        ! Allocate and initialize integer array
        allocate(int_arr(dim))
        do i = 1, dim
            int_arr(i) = i * 10
        end do
        struct%int_array = c_loc(int_arr(1))

        ! Allocate and initialize string array
        allocate(str_arr(num_str * 100))  ! Each string can be up to 100 chars
        do i = 1, num_str
            write(temp_str, '(A,I0)') "String #", i
            call copy_string_to_array(temp_str, str_arr, (i-1)*100 + 1)
        end do
        struct%string_array = c_loc(str_arr(1))

        ! Initialize other members
        struct%single_float = 3.14159
        struct%single_int = 42
        
        ! Initialize single string
        temp_str = "Hello from Dynamic Structure!"
        call copy_string_to_array(temp_str, struct%single_string, 1)
    end subroutine create_dynamic_structure_c

    ! Helper subroutine to copy Fortran string to C-style char array
    subroutine copy_string_to_array(src, dest, start_pos)
        character(len=*), intent(in) :: src
        character(kind=c_char), intent(out) :: dest(*)
        integer, intent(in) :: start_pos
        integer :: i, length

        length = len_trim(src)
        do i = 1, length
            dest(start_pos + i - 1) = src(i:i)
        end do
        dest(start_pos + length) = c_null_char
    end subroutine copy_string_to_array

end module structure_handler
