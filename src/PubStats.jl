module PubStats

using HTTP
using AbstractTrees
using Gumbo
using Dates

using CSV
using DataFrames
using DataFramesMeta
using PlotlyJS

export runupdate, genhtml

include("fetch.jl")
include("process.jl")
include("run.jl")
include("visualize.jl")

end # module
