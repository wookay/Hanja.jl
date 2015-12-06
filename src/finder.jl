function 한자찾기(사전::한자사전, 한자::AbstractString)
  한자타입(사전[한자]...)
end

function 독음으로찾기(사전::한자사전, 찾을독음::AbstractString)
  결과 = []
  for (한자, (코드,정체,간체,독음,획수)) in 사전
    if contains(독음, 찾을독음)
      push!(결과, 한자)
    end
  end
  결과
end

for (func, block) in [
    (:한글보기, (사전,글자) -> 한자찾기(사전, 글자).독음),
    (:정체보기, (사전,글자) -> begin
      한자 = 한자찾기(사전, 글자)
      isempty(한자.정체) ? 글자 : 한자.정체
    end),
    (:간체보기, (사전,글자) -> begin
      한자 = 한자찾기(사전, 글자)
      isempty(한자.간체) ? 글자 : 한자.간체
    end),
  ]
  @eval begin
    function $(func)(사전::한자사전, 문장::AbstractString)
      결과 = []
      for 글자 in split(문장, "")
        if haskey(사전, 글자)
          push!(결과, $block(사전, 글자))
        else
          push!(결과, 글자)
        end
      end
      join(결과)
    end
  end
end

for (func, block) in [
    (:한자옆에한글보기, (사전, 결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(사전, 글자)
      push!(결과, 글자)
      단어에추가(한자.독음)
    end),
    (:한글옆에한자보기, (사전, 결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(사전, 글자)
      push!(결과, 한자.독음)
      단어에추가(글자)
    end),
    (:한자옆에간체보기, (사전, 결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(사전, 글자)
      push!(결과, 글자)
      단어에추가(isempty(한자.간체) ? 글자 : 한자.간체)
    end),
    (:간체옆에정체보기, (사전, 결과, 글자, 단어에추가) -> begin
      한자 = 한자찾기(사전, 글자)
      push!(결과, isempty(한자.간체) ? 글자 : 한자.간체)
      단어에추가(isempty(한자.정체) ? 글자 : 한자.정체)
    end),
  ]
  @eval begin
    function $(func)(사전::한자사전, 문장::AbstractString)
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
        if haskey(사전, 글자)
          $block(사전, 결과, 글자, 단어에추가)
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
