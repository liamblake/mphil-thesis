using Random

using DifferentialEquations
using PyPlot

Random.seed!(1235)

function u(x, _, _)
    return sin(x)
end

function σ(_, _, _)
    return 1.0
end

N = 10
ts = 0:0.01:π
prob = SDEProblem(u, σ, 1.0, (0.0, π))
ens = EnsembleProblem(prob)
sol = solve(ens, EM(), trajectories=N, saveat=ts, dt=0.01)
rels = [sol[i].u for i in 1:N]

# Solution without noise
Fs = @. 2 * acot(exp(-ts) * cot(1 / 2))

rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
rcParams["text.usetex"] = true
rcParams["font.family"] = "serif"
rcParams["font.size"] = "14"

rcParams["image.cmap"] = "Purples"

# Legend
# rcParams["legend.facecolor"] = "white"
rcParams["legend.fancybox"] = false
rcParams["legend.framealpha"] = 1.0

begin
    fig, ax = subplots()
    ax.set_xlabel(L"t")
    ax.set_ylabel(L"x_t")

    for n in 1:N
        ax.plot(ts, rels[n], alpha=0.8)
    end

    ax.plot(ts, Fs, color="black")

    fig.set_size_inches(6, 3)
    fig.savefig("figures/ou_solution.pdf", bbox_inches="tight", dpi=600)
    close(fig)
end
