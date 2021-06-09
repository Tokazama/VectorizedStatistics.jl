"""
```julia
vstd(A; dims=:, mean=nothing, corrected=true)
```
As `Statistics.var`, but vectorized: compute the variance of all elements in `A`,
optionally over dimensions specified by `dims`. A precomputed `mean` may optionally
be provided, which results in a somewhat faster calculation. If `corrected` is `true`,
then _Bessel's correction_ is applied.

## Examples
```julia
julia> using VectorizedStatistics

julia> A = [1 2; 3 4]
2×2 Matrix{Int64}:
 1  2
 3  4

julia> vstd(A, dims=1)
1×2 Matrix{Float64}:
 2.0  2.0

julia> vstd(A, dims=2)
2×1 Matrix{Float64}:
 0.5
 0.5
```
"""
vstd(A; dims=:, mean=nothing, corrected=true) = sqrt!(_vvar(mean, corrected, A, dims))
export vstd

sqrt!(x::Number) = sqrt(x)
function sqrt!(A::AbstractArray)
  @avx for i ∈ eachindex(A)
    A[i] = sqrt(A[i])
  end
  return A
end
