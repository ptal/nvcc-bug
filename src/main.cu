#include <vector>
#include "ecuda/ecuda.hpp"

__global__
// NOTE: no problem with reference `ecuda::vector<double>&`
void reverseVector(typename ecuda::vector<double>::kernel_argument vec)
{}

int main( int argc, char* argv[] )
{
  ecuda::vector<double> deviceVector;
  reverseVector<<<1,1>>>(deviceVector);
  cudaDeviceSynchronize();
  return 0;
}
