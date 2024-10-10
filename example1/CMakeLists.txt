add_subdirectory(fortranlib)

add_executable(example1 "")

target_sources(example1 PRIVATE main.cpp)

target_link_libraries(example1 PUBLIC fortranlib)
