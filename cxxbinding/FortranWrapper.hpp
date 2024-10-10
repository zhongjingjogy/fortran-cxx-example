#pragma once

#include "fc_mangle.h"

extern "C" {
    // Declare the Fortran function with C linkage and proper name mangling
    float square_mod_square(float x);
}

// C++ wrapper function
float c_square(float x);