add_subdirectory(fortranlib)
# add_subdirectory(cxxbinding)

# include(FortranCInterface)
# FortranCInterface_VERIFY(CXX)

add_executable(test "")

target_sources(test PRIVATE main.cpp)

target_link_libraries(test PUBLIC fortranlib)
