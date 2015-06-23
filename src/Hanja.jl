module Hanja

export 사전고르기
export 한자찾기, 독음으로찾기
export 한글보기, 정체보기, 간체보기
export 한자옆에한글보기, 한글옆에한자보기, 한자옆에간체보기, 간체옆에정체보기, 간체옆에정체보기


type 한자타입
  코드::UInt16
  정체::String
  간체::String
  독음::String
  획수::Int
end

현재사전 = nothing
function 사전고르기(M::Symbol)
  eval(:(using $M))
  global 현재사전 = eval(:($M.사전))
end

if nothing == 현재사전
  사전고르기(:HanjaDictSample)
end

사전에서(한자::String) = 한자타입(현재사전[한자]...)

function 한자찾기(한자::String)
  사전에서(한자)
end

function 독음으로찾기(찾을독음::String)
  결과 = []
  for (한자, (코드,정체,간체,독음,획수)) in 현재사전
    if contains(독음, 찾을독음)
      push!(결과, 한자)
    end
  end
  결과
end

for (func, block) in [
    (:한글보기, 글자-> 한자찾기(글자).독음),
    (:정체보기, 글자-> begin
      한자 = 한자찾기(글자)
      isempty(한자.정체) ? 글자 : 한자.정체
    end),
    (:간체보기, 글자-> begin
      한자 = 한자찾기(글자)
      isempty(한자.간체) ? 글자 : 한자.간체
    end),
  ]
  @eval begin
    function $(func)(문장::String)
      결과 = []
      for 글자 in split(문장, "")
        if haskey(현재사전, 글자)
          push!(결과, $block(글자))
        else
          push!(결과, 글자)
        end
      end
      join(결과)
    end
  end
end

for (func, block) in [
    (:한자옆에한글보기, (결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(글자)
      push!(결과, 글자)
      단어에추가(한자.독음)
    end),
    (:한글옆에한자보기, (결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(글자)
      push!(결과, 한자.독음)
      단어에추가(글자)
    end),
    (:한자옆에간체보기, (결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(글자)
      push!(결과, 글자)
      단어에추가(isempty(한자.간체) ? 글자 : 한자.간체)
    end),
    (:간체옆에정체보기, (결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(글자)
      push!(결과, isempty(한자.간체) ? 글자 : 한자.간체)
      단어에추가(isempty(한자.정체) ? 글자 : 한자.정체)
    end),
  ]
  @eval begin
    function $(func)(문장::String)
      결과 = []
      찾음 = false
      단어 = []
      function 단어에추가(대상)
        push!(단어, 대상)
        찾음 = true
      end
      function 찾은단어넣기()
        if 찾음
          push!(결과, "($(join(단어)))")
          찾음 = false
          단어 = []
        end
      end
      for 글자 in split(문장, "")
        if haskey(현재사전, 글자)
          $block(결과, 글자, 단어에추가)
        else
          찾은단어넣기()
          push!(결과, 글자)
        end
      end
      찾은단어넣기()
      join(결과)
    end
  end
end


using Base.Test
氣 = 한자찾기("氣")
@test 0x6c23 == 氣.코드
@test "氣" == 氣.정체
@test "气" == 氣.간체
@test "기" == 氣.독음
@test 10 == 氣.획수
@test ["氣", "气"] == 독음으로찾기("기")
@test "기천" == 한글보기("氣天")
@test "氣天" == 정체보기("气天")
@test "气天" == 간체보기("氣天")
@test "氣天(기천)" == 한자옆에한글보기("氣天")
@test "기천(氣天)" == 한글옆에한자보기("氣天")
@test "氣天(气天)" == 한자옆에간체보기("氣天")
@test "气天(氣天)" == 간체옆에정체보기("氣天")
@test "气天(氣天)" == 간체옆에정체보기("气天")
@test "기천수련" == 한글보기("氣天수련")
@test "氣天(기천)수련" == 한자옆에한글보기("氣天수련")


# 사전고르기(:HanjaDict)
# @test "기무천연" == 한글보기("氣武天然")

end # module
