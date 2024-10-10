#include "FortranWrapper.hpp"

float c_square(float x) {
    return ::square_mod_square(x);
}