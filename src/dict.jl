function 사전가져오기(
    path::AbstractString=normpath(Pkg.dir("Hanja"), "data/dict.jld"),
    key::AbstractString="dict")
  @eval using JLD
  return load(path, key)
end
