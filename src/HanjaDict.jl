module HanjaDict

export 사전

using HDF5, JLD

사전 = load("dict.jld")["dict"]

end
