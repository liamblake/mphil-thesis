"""
Generate some figures for the thesis.
"""

using Random

using Distributions
using PyPlot

function main()
	#### Realisations of the Wiener process in 1D ####
	N = 10

	dt = 0.001
	tspan = 0:dt:1

	W1 = Vector{Float64}(undef, length(tspan))
	W2 = Array{Float64}(undef, 2, length(tspan))
	W1[1] = 0.0
	W2[:, 1] .= 0.0

	d = Normal(0, sqrt(dt))

	for (i, t) in tspan[2:end]
		W1[i+1] = W1[i] + rand(d)
		W2[1, i+1] = W2[1, i] + rand(d)
		W2[2, i+1] = W2[2, i] + rand(d)
	end


end
