add_library(fortranlib STATIC
    square.f90
    split_with_comma.f90
    populate_structure.f90
)

add_executable(test_split_with_comma test_split_with_comma.f90)
target_link_libraries(test_split_with_comma fortranlib)
