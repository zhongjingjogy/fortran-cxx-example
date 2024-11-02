module string_splitter
    use iso_c_binding
    implicit none
    private
    public :: split_by_comma, split_by_comma_c

contains
    function split_by_comma(input_string, max_parts) result(parts)
        character(len=*), intent(in) :: input_string
        integer, intent(in) :: max_parts
        character(len=:), allocatable :: parts(:)
        
        integer :: i, start_pos, end_pos, num_parts, str_len
        logical :: in_part
        
        ! Count number of parts
        num_parts = 1
        str_len = len_trim(input_string)
        
        do i = 1, str_len
            if (input_string(i:i) == ',') then
                num_parts = num_parts + 1
            end if
        end do
        
        ! Limit number of parts to max_parts if specified
        num_parts = min(num_parts, max_parts)
        
        ! Allocate result array
        allocate(character(len=str_len) :: parts(num_parts))
        
        ! Split the string
        start_pos = 1
        end_pos = 1
        in_part = .true.
        i = 1
        
        do while (i <= num_parts)
            ! Find end of current part
            do while (end_pos <= str_len)
                if (input_string(end_pos:end_pos) == ',') then
                    parts(i) = trim(adjustl(input_string(start_pos:end_pos-1)))
                    start_pos = end_pos + 1
                    end_pos = start_pos
                    i = i + 1
                    exit
                end if
                end_pos = end_pos + 1
            end do
            
            ! Handle last part
            if (i <= num_parts) then
                if (end_pos > str_len) then
                    parts(i) = trim(adjustl(input_string(start_pos:str_len)))
                    i = i + 1
                end if
            end if
        end do
    end function split_by_comma

    ! C-binding wrapper function
    subroutine split_by_comma_c(input_str, input_len, max_parts, output_array, output_sizes, actual_num_parts) &
            bind(C, name="split_by_comma_c")
        use iso_c_binding
        implicit none
        
        ! Input parameters
        integer(c_int), value, intent(in) :: input_len, max_parts
        character(kind=c_char), intent(in) :: input_str(input_len)
        ! Output parameters
        character(kind=c_char), intent(out) :: output_array(max_parts * 1024)  ! Assuming max 1024 chars per string
        integer(c_int), intent(out) :: output_sizes(max_parts)
        integer(c_int), intent(out) :: actual_num_parts
        
        ! Local variables
        character(len=:), allocatable :: f_input_str
        character(len=:), allocatable :: parts(:)
        integer :: i, j, part_len
        
        ! Convert C string array to Fortran string
        allocate(character(len=input_len) :: f_input_str)
        do i = 1, input_len
            f_input_str(i:i) = input_str(i)
        end do
        
        ! Call the Fortran function
        parts = split_by_comma(f_input_str, max_parts)
        actual_num_parts = size(parts)
        
        ! Convert result back to C format
        output_array = ' '  ! Initialize with spaces
        do i = 1, actual_num_parts
            part_len = len_trim(parts(i))
            output_sizes(i) = part_len
            
            ! Copy each character
            do j = 1, part_len
                output_array((i-1)*1024 + j) = parts(i)(j:j)
            end do
            ! Add null terminator for C strings
            output_array((i-1)*1024 + part_len + 1) = c_null_char
        end do
        
        deallocate(f_input_str)
    end subroutine split_by_comma_c
end module string_splitter
