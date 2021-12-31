module Day08

# https://adventofcode.com/2015/day/8

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = split(data, '\n')
end

function countsubstrings(substring, string)
    (i = findfirst(substring, string)) === nothing && return 0
    return 1 + countsubstrings(substring, string[i[end]+1:end])
end

function countandreplace(substring, string)
    countsubstrings(substring, string), replace(string, substring => "")    
end

function countescaped(string)
    string = string[2:end-1]
    count1, string = countandreplace("\\\\", string)
    count2, string = countandreplace("\\\"", string)
    count3 = countsubstrings("\\x", string)
    2 + count1 + count2 + 3 * count3
end

function countescapables(string)
    count1 = countsubstrings("\"", string)
    count2 = countsubstrings("\\", string)
    2 + count1 + count2
end

function solvepart1(strings)
    sum(map(s -> countescaped(s), strings))
end

function solvepart2(strings)
    sum(map(s -> countescapables(s), strings))
end

puzzles = [
    Puzzle(08, "test 1", "input-test1.txt", solvepart1, 22),
    Puzzle(08, "deel 1", solvepart1, 1371),
    Puzzle(08, "test 2", "input-test1.txt", solvepart2, 34),
    Puzzle(08, "deel 2", solvepart2, 2117)
]

printresults(puzzles)

end