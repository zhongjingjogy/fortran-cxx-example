include(FortranCInterface)

FortranCInterface_VERIFY(CXX)

FortranCInterface_HEADER(
  fc_mangle.h
  MACRO_NAMESPACE "FC_"
  SYMBOLS
    square_mod:square
  )

add_library(cxxbinding "")

target_sources(cxxbinding
  PRIVATE
    FortranWrapper.cpp
  )

target_link_libraries(cxxbinding
  PUBLIC
    fortranlib
)

target_include_directories(cxxbinding
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  )
