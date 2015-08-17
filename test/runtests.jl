push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "../src")

using Hanja
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

사전고르기(:HanjaDictSample)
