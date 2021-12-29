module Day04

# https://adventofcode.com/2015/day/4

include("./../aoc.jl")

using .AOC

using MD5

function AOC.processinput(data)
    data
end

function findinteger(secret, numberofzeros)
    i = 1
    while true
        bytes2hex(md5("$(secret)$(i)"))[1:numberofzeros] == repeat("0", numberofzeros) && break
        i += 1
    end
    i
end

function solvepart1(secret)
    findinteger(secret, 5)
end

function solvepart2(secret)
    findinteger(secret, 6)
end

puzzles = [
    Puzzle(04, "test 1", "input-test1.txt", solvepart1, 609043),
    Puzzle(04, "deel 1", solvepart1, 117946),
    Puzzle(04, "deel 2", solvepart2, 3938038)
]

printresults(puzzles)

end