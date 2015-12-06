using JLD

function 사전불러오기(path::AbstractString, key::AbstractString="dict")
  return load(path)[key]
end
