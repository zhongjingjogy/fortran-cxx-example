#include <iostream>
#include <cstring>
#include <cassert>

// Define the same structure in C++
struct TestStructure {
    float single_float;
    int single_int;
    float float_array[5];
    int int_array[3];
    char single_string[100];
    char string_array[4][100];
};

// Dynamic structure definition
struct TestStructureDynamic {
    int dimension;
    float* float_array;
    int* int_array;
    char* string_array;
    int num_strings;
    float single_float;
    int single_int;
    char single_string[100];
};

// Declare the Fortran function
extern "C" {
    void populate_structure_c(TestStructure* struct_ptr);
    void create_dynamic_structure_c(TestStructureDynamic* struct_ptr, int dim, int num_str);
}

void print_structure(const TestStructure& s) {
    std::cout << "Single float: " << s.single_float << std::endl;
    std::cout << "Single int: " << s.single_int << std::endl;
    
    std::cout << "Float array: ";
    for (int i = 0; i < 5; ++i) {
        std::cout << s.float_array[i] << " ";
    }
    std::cout << std::endl;
    
    std::cout << "Integer array: ";
    for (int i = 0; i < 3; ++i) {
        std::cout << s.int_array[i] << " ";
    }
    std::cout << std::endl;
    
    std::cout << "Single string: " << s.single_string << std::endl;
    
    std::cout << "String array:" << std::endl;
    for (int i = 0; i < 4; ++i) {
        std::cout << "  [" << i << "]: " << s.string_array[i] << std::endl;
    }
}

void print_dynamic_structure(const TestStructureDynamic& s) {
    std::cout << "Dimension: " << s.dimension << std::endl;
    std::cout << "Number of strings: " << s.num_strings << std::endl;
    
    std::cout << "Single float: " << s.single_float << std::endl;
    std::cout << "Single int: " << s.single_int << std::endl;
    
    std::cout << "Float array: ";
    for (int i = 0; i < s.dimension; ++i) {
        std::cout << s.float_array[i] << " ";
    }
    std::cout << std::endl;
    
    std::cout << "Integer array: ";
    for (int i = 0; i < s.dimension; ++i) {
        std::cout << s.int_array[i] << " ";
    }
    std::cout << std::endl;
    
    std::cout << "Single string: " << s.single_string << std::endl;
    
    std::cout << "String array:" << std::endl;
    for (int i = 0; i < s.num_strings; ++i) {
        std::cout << "  [" << i << "]: " << (s.string_array + i * 100) << std::endl;
    }
}

void test_dynamic_structure() {
    TestStructureDynamic test_struct;
    
    // Create and populate the dynamic structure with dimension 5 and 3 strings
    create_dynamic_structure_c(&test_struct, 5, 3);
    
    // Print and verify the results
    std::cout << "\nDynamic Structure contents:" << std::endl;
    print_dynamic_structure(test_struct);
    
    // Verify some values
    assert(test_struct.dimension == 5);
    assert(test_struct.num_strings == 3);
    assert(test_struct.single_int == 42);
    assert(abs(test_struct.single_float - 3.14159) < 0.0001);
    
    // Clean up (Note: In real code, you'd need proper memory management)
    delete[] test_struct.float_array;
    delete[] test_struct.int_array;
    delete[] test_struct.string_array;
}

int main() {
    TestStructure test_struct;
    
    // Call Fortran function to populate the structure
    populate_structure_c(&test_struct);
    
    // Print and verify the results
    std::cout << "Structure contents:" << std::endl;
    print_structure(test_struct);
    
    // Verify some values
    assert(test_struct.single_int == 42);
    assert(abs(test_struct.single_float - 3.14159) < 0.0001);
    assert(strcmp(test_struct.single_string, "Hello from Fortran!") == 0);
    
    // Test dynamic structure
    test_dynamic_structure();
    
    std::cout << "\nAll tests passed successfully!" << std::endl;
    return 0;
} 