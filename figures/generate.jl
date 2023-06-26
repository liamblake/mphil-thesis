"""
Generate some figures for the thesis.
"""

using PyPlot

function main()
    # Set some universal PyPlot parameters, for consistent figures
    rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
    rcParams["text.usetex"] = true
    rcParams["font.family"] = "serif"
    rcParams["font.size"] = "12"

    include("wiener_realisations.jl")
    wiener_realisations()
end

main()
