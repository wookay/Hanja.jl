module Hanja

__precompile__(true)

typealias 한자사전 Dict

type 한자타입
  코드::UInt16
  정체::AbstractString
  간체::AbstractString
  독음::AbstractString
  획수::Int
end

export 한자찾기
export 독음으로찾기
export 한글보기
export 정체보기
export 간체보기
export 한자옆에한글보기
export 한글옆에한자보기
export 한자옆에간체보기
export 간체옆에정체보기
export 간체옆에정체보기
include("finder.jl")

export 사전불러오기
include("dict.jl")

end # module
