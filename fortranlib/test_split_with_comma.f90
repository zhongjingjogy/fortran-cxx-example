program test_split_with_comma
    use string_splitter
    use iso_c_binding
    implicit none

    ! Test variables
    character(len=:), allocatable :: parts(:)
    character(kind=c_char) :: c_output_array(4 * 1024)  ! For 4 parts max, 1024 chars each
    integer(c_int) :: output_sizes(4), actual_num_parts
    character(len=100) :: test_str
    integer :: i

    ! Test 1: Basic Fortran function test
    write(*,*) "Test 1: Basic splitting test"
    parts = split_by_comma("apple,banana, orange,grape", 4)
    if (size(parts) /= 4) then
        write(*,*) "Error: Expected 4 parts, got ", size(parts)
        stop 1
    endif
    write(*,*) "Parts found:", size(parts)
    do i = 1, size(parts)
        write(*,*) "Part", i, ":", trim(parts(i))
    end do

    ! Test 2: C binding test
    write(*,*) ""
    write(*,*) "Test 2: C binding test"
    test_str = "apple,banana, orange,grape"
    call split_by_comma_c(test_str, len_trim(test_str), 4, c_output_array, output_sizes, actual_num_parts)
    
    if (actual_num_parts /= 4) then
        write(*,*) "Error: Expected 4 parts, got ", actual_num_parts
        stop 1
    endif
    
    write(*,*) "Parts found:", actual_num_parts
    do i = 1, actual_num_parts
        write(*,*) "Part", i, ":", c_output_array((i-1)*1024 + 1 : (i-1)*1024 + output_sizes(i))
    end do

    ! Test 3: Empty parts test
    write(*,*) ""
    write(*,*) "Test 3: Empty parts test"
    parts = split_by_comma("a,,b,", 4)
    if (size(parts) /= 4) then
        write(*,*) "Error: Expected 4 parts, got ", size(parts)
        stop 1
    endif
    write(*,*) "Parts found:", size(parts)
    do i = 1, size(parts)
        write(*,*) "Part", i, ":", trim(parts(i)), "|"
    end do

    ! Test 4: Max parts limit test
    write(*,*) ""
    write(*,*) "Test 4: Max parts limit test"
    parts = split_by_comma("1,2,3,4,5,6", 3)
    if (size(parts) /= 3) then
        write(*,*) "Error: Expected 3 parts, got ", size(parts)
        stop 1
    endif
    write(*,*) "Parts found:", size(parts)
    do i = 1, size(parts)
        write(*,*) "Part", i, ":", trim(parts(i))
    end do

    write(*,*) ""
    write(*,*) "All tests completed successfully!"

end program test_split_with_comma
