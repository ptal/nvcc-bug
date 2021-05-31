#include <vector>
#include "ecuda/ecuda.hpp"

const std::size_t N = 100000;

__global__
void reverseVector( typename ecuda::vector<double>::kernel_argument vec )
{
  const std::size_t t = blockIdx.x*blockDim.x+threadIdx.x;
  if( t < (vec.size()/2) ) {
    const std::size_t u = vec.size()-t-1;
    ecuda::swap( vec[t], vec[u] );
  }
}

int main( int argc, char* argv[] )
{
  const std::size_t THREADS = 512;
  ecuda::vector<double> deviceVector( N );
  std::vector<double> hostVector( N );
  // ... initialize host vector values
  ecuda::copy( hostVector.begin(), hostVector.end(), deviceVector.begin() );
  CUDA_CALL_KERNEL_AND_WAIT( reverseVector<<<((N+THREADS-1)/THREADS),THREADS>>>( deviceVector ) );
  ecuda::copy( deviceVector.begin(), deviceVector.end(), hostVector.begin() );
  // ... host vector now contains result
  return 0;
}
