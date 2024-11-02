add_executable(example1 simple.cpp)
target_link_libraries(example1 PUBLIC fortranlib)

add_executable(test_split_with_cxx test_split_with_cxx.cpp)
target_link_libraries(test_split_with_cxx PRIVATE fortranlib)

add_executable(test_structure test_structure.cpp)
target_link_libraries(test_structure PRIVATE fortranlib)
