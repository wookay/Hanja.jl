# Hanja

Linux, OSX: [![Build Status](https://api.travis-ci.org/wookay/Hanja.jl.svg?branch=master)](https://travis-ci.org/wookay/Hanja.jl)
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/jf1dn55yc0u4q2dt?svg=true)](https://ci.appveyor.com/project/wookay/Hanja.jl)
[![Coverage Status](https://coveralls.io/repos/wookay/Hanja.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/wookay/Hanja.jl?branch=master)

```julia
Pkg.clone("https://github.com/wookay/Hanja.jl")
```

```julia
using Hanja

사전 = Dict(
  "氣" => (0x6c23, "氣", "气", "기", 10),
  "气" => (0x6c14, "氣", "气", "기", 4),
  "天" => (0x5929, "",   "",   "천", 4),
)

氣 = 한자찾기(사전, "氣")
using Base.Test
@test 0x6c23 == 氣.코드
@test "氣" == 氣.정체
@test "气" == 氣.간체
@test "기" == 氣.독음
@test 10 == 氣.획수
@test ["氣", "气"] == 독음으로찾기(사전, "기")
@test "기천" == 한글보기(사전, "氣天")
@test "氣天" == 정체보기(사전, "气天")
@test "气天" == 간체보기(사전, "氣天")
@test "氣天(기천)" == 한자옆에한글보기(사전, "氣天")
@test "기천(氣天)" == 한글옆에한자보기(사전, "氣天")
@test "氣天(气天)" == 한자옆에간체보기(사전, "氣天")
@test "气天(氣天)" == 간체옆에정체보기(사전, "氣天")
@test "气天(氣天)" == 간체옆에정체보기(사전, "气天")
@test "기천수련" == 한글보기(사전, "氣天수련")
@test "氣天(기천)수련" == 한자옆에한글보기(사전, "氣天수련")


# Pkg.add("JLD")
사전 = 사전가져오기()
@test "기무천연" == 한글보기(사전, "氣武天然")
```
