#include <cstdio>
#include <cfenv>
#include <cassert>

__device__ __host__ float ru_cast(long long x) {
  #ifdef __CUDA_ARCH__
    printf("In ru_cast(%ld): %f\n", x, __ll2float_ru(x));
    return __ll2float_ru(x);
  #else
    int r = std::fesetround(FE_UPWARD);
    assert(r == 0);
    return static_cast<float>(x);
  #endif
}

// This works:
// __global__ void run_utility_op_gpu(float* res, long long input) {

// Not this:
__global__ void run_utility_op_gpu(float* res, int input) {
  *res = ru_cast(input);
}

int main() {
  int int_not_float = 100000001;
  float cpu_result = ru_cast(int_not_float);
  float* gpu_result;
  cudaMallocManaged(&gpu_result, sizeof(float));
  run_utility_op_gpu<<<1, 1>>>(gpu_result, int_not_float);
  cudaDeviceSynchronize();
  float expect = 100000008.0f;
  printf("Rounding up of int(%d) is expected to be %f\n", int_not_float, expect);
  printf("Rounding up of int(%d) on CPU is %f\n", int_not_float, cpu_result);
  printf("Rounding up of int(%d) on GPU is %f\n", int_not_float, *gpu_result);
  return 0;
}