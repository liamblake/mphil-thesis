
using Random

using Distributions
using PyPlot

function wiener_realisations()
    #### Realisations of the Wiener process in 1D and 2D ####
    Random.seed!(12402345)
    N = 5

    dt = 0.001
    tspan = 0:dt:3

    fig_1d, ax_1d = subplots()
    xlabel(L"t")
    ylabel(L"W_t")

    fig_2d, ax_2d = subplots()
    xlabel(L"W_t^{(1)}")
    ylabel(L"W_t^{(2)}")

    for n in 1:N
        W1 = Vector{Float64}(undef, length(tspan))
        W2 = Array{Float64}(undef, 2, length(tspan))
        W1[1] = 0.0
        W2[:, 1] .= 0.0

        d = Normal(0, sqrt(dt))

        for (i, t) in enumerate(tspan[2:end])
            W1[i+1] = W1[i] + rand(d)
            W2[1, i+1] = W2[1, i] + rand(d)
            W2[2, i+1] = W2[2, i] + rand(d)
        end

        ax_1d.plot(tspan, W1, linewidth=0.75)

        # Only plot one realisation of the 2D process - too cluttered otherwise
        if n == 1
            ax_2d.plot(W2[1, :], W2[2, :], "k-", linewidth=0.75)
        end
    end


    fig_1d.savefig("wiener_realisations_1d.pdf", bbox_inches="tight")
    fig_2d.savefig("wiener_realisations_2d.pdf", bbox_inches="tight")

end
