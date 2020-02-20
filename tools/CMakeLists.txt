include(test.cmake)
add_library(benchmark_tools STATIC benchmark_tools.f90)
target_include_directories(benchmark_tools PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
