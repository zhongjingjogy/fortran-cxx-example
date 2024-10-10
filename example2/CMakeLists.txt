add_subdirectory(cxxbinding)

add_executable(example2 "")

target_sources(example2 PRIVATE main.cpp)

target_link_libraries(example2 PUBLIC cxxbinding)
