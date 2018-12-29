module Hanja

const 한자사전 = Dict

struct 한자타입
  코드::UInt16
  정체::String
  간체::String
  독음::String
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

export 사전가져오기
include("dict.jl")

end # module
