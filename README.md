# Hanja

Linux, OSX: [![Build Status](https://api.travis-ci.org/wookay/Hanja.jl.svg?branch=master)](https://travis-ci.org/wookay/Hanja.jl)
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/jf1dn55yc0u4q2dt?svg=true)](https://ci.appveyor.com/project/wookay/Hanja.jl)
[![Coverage Status](https://coveralls.io/repos/wookay/Hanja.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/wookay/Hanja.jl?branch=master)

```
~/work/Hanja.jl master$ cd src/
~/work/Hanja.jl/src master$ julia
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
   _ _   _| |_  __ _   |  Type "help()" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.4.0-dev+6767 (2015-08-16 13:41 UTC)
 _/ |\__'_|_|_|\__'_|  |  Commit e637e75 (0 days old master)
|__/                   |  x86_64-apple-darwin14.4.0

julia> using Hanja

julia> 氣 = 한자찾기("氣")
Hanja.한자타입(0x6c23,"氣","气","기",10)

julia> 氣.코드
0x6c23

julia> 氣.정체
"氣"

julia> 氣.간체
"气"

julia> 氣.독음
"기"

julia> 氣.획수
10
```

```
["氣", "气"] == 독음으로찾기("기")
"기천" == 한글보기("氣天")
"氣天" == 정체보기("气天")
"气天" == 간체보기("氣天")
"氣天(기천)" == 한자옆에한글보기("氣天")
"기천(氣天)" == 한글옆에한자보기("氣天")
"氣天(气天)" == 한자옆에간체보기("氣天")
"气天(氣天)" == 간체옆에정체보기("氣天")
"气天(氣天)" == 간체옆에정체보기("气天")
"기천수련" == 한글보기("氣天수련")
"氣天(기천)수련" == 한자옆에한글보기("氣天수련")
```

```
Pkg.add("HDF5")
Pkg.add("JLD")
사전불러오기()
"기무천연" == 한글보기("氣武天然")
```
