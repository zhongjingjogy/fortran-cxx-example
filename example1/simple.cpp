#include <cstdlib>
#include <cfloat>
#include <iostream>
#include <cmath>
#include <cassert>

extern "C" {
    float c_square(float x);
    float square_with_binding(float x);
}

void test_square_with_binding() {
    float input = 5.0f;
    float result = square_with_binding(input);
    std::cout << "C++: The square of " << input << " is " << result << std::endl;
    assert(result == 25.0f);
}

void test_c_square() {
    float input = 5.0f;
    
    std::cout << "C++: About to call Fortran function with input " << input << std::endl;
    
    float result;
    try {
        result = c_square(input);
    } catch (...) {
        std::cerr << "C++: Exception caught while calling Fortran function" << std::endl;
    }
    
    if (std::isnan(result) || std::isinf(result)) {
        std::cerr << "C++: Invalid result returned from Fortran function" << std::endl;
    }
    
    std::cout << "C++: The square of " << input << " is " << result << std::endl;
    assert(result == 25.0f);
}

int main() {
    test_square_with_binding();
    test_c_square();
    return 0;
}