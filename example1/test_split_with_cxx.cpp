#include <iostream>
#include <string>
#include <cassert>
#include <cstring>

extern "C" {
    void split_by_comma_c(const char* input_str, int input_len, int max_parts,
                         char* output_array, int* output_sizes, int* actual_num_parts);
}

void print_result(const char* output_array, const int* output_sizes, int actual_num_parts) {
    std::cout << "Found " << actual_num_parts << " parts:" << std::endl;
    for (int i = 0; i < actual_num_parts; ++i) {
        std::string part(output_array + i * 1024, output_sizes[i]);
        std::cout << "Part " << i + 1 << ": '" << part << "'" << std::endl;
    }
    std::cout << std::endl;
}

void test_basic_split() {
    std::cout << "Test 1: Basic splitting test" << std::endl;
    
    const char* test_str = "apple,banana, orange,grape";
    const int max_parts = 4;
    char output_array[max_parts * 1024];
    int output_sizes[max_parts];
    int actual_num_parts;

    split_by_comma_c(test_str, strlen(test_str), max_parts, 
                    output_array, output_sizes, &actual_num_parts);

    assert(actual_num_parts == 4 && "Expected 4 parts");
    print_result(output_array, output_sizes, actual_num_parts);
}

void test_empty_parts() {
    std::cout << "Test 2: Empty parts test" << std::endl;
    
    const char* test_str = "a,,b,";
    const int max_parts = 4;
    char output_array[max_parts * 1024];
    int output_sizes[max_parts];
    int actual_num_parts;

    split_by_comma_c(test_str, strlen(test_str), max_parts, 
                    output_array, output_sizes, &actual_num_parts);

    assert(actual_num_parts == 4 && "Expected 4 parts");
    print_result(output_array, output_sizes, actual_num_parts);
}

void test_max_parts_limit() {
    std::cout << "Test 3: Max parts limit test" << std::endl;
    
    const char* test_str = "1,2,3,4,5,6";
    const int max_parts = 3;
    char output_array[max_parts * 1024];
    int output_sizes[max_parts];
    int actual_num_parts;

    split_by_comma_c(test_str, strlen(test_str), max_parts, 
                    output_array, output_sizes, &actual_num_parts);

    assert(actual_num_parts == 3 && "Expected 3 parts");
    print_result(output_array, output_sizes, actual_num_parts);
}

int main() {
    try {
        test_basic_split();
        test_empty_parts();
        test_max_parts_limit();
        
        std::cout << "All tests completed successfully!" << std::endl;
        return 0;
    }
    catch (const std::exception& e) {
        std::cerr << "Test failed: " << e.what() << std::endl;
        return 1;
    }
}
