#include <iostream>
#include "FortranWrapper.hpp"

int main() {
    float input = 4.0f;
    float result = c_square(input);
    std::cout << "The square of " << input << " is " << result << std::endl;
    return 0;
}