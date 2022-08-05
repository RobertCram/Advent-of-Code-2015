module Day25

# https://adventofcode.com/2015/day/25

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = split(data, '\n')
    row, col = parse.(Int64, data)
    (row = row, col = col)
end

function rowcoltocardinal(row, col)
    r = (row - 1) * row ÷ 2 + 1 
    result = r
    for i in 1:col-1
        result += row + i
    end
    result
end

function solvepart1(input)
    code = 20151125
    for _ in 2:rowcoltocardinal(input.row, input.col)
        code = (code * 252533) % 33554393
    end
    code
end

function solvepart2(input)
    "nog te bepalen"
end

puzzles = [
    Puzzle(25, "test 1", "input-test1.txt", solvepart1, 1601130),
    Puzzle(25, "deel 1", solvepart1, 19980801),
]

printresults(puzzles)

end