#include <cstdlib>
#include <cfloat>
#include <iostream>
#include <cmath>

extern "C" {
    float c_square(float x);
}

int main() {
    float input = 5.0f;
    
    std::cout << "C++: About to call Fortran function with input " << input << std::endl;
    
    float result;
    try {
        result = c_square(input);
    } catch (...) {
        std::cerr << "C++: Exception caught while calling Fortran function" << std::endl;
        return 1;
    }
    
    if (std::isnan(result) || std::isinf(result)) {
        std::cerr << "C++: Invalid result returned from Fortran function" << std::endl;
        return 1;
    }
    
    std::cout << "C++: The square of " << input << " is " << result << std::endl;
    return 0;
}