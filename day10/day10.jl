module Day10

# https://adventofcode.com/2015/day/10

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data
end

function next(input)    
    result = []
    currentc = ' '
    count = 0
    for c in input
        currentc != ' ' && currentc != c && (push!(result, "$(count)$(currentc)"); count = 0)
        currentc = c
        count += 1
    end
    join(result) * "$(count)$(currentc)"
end

function playgame(input, times)
    s = input
    map(i -> s = next(s), 1:times)[end]
end

function solvepart1(input)    
    length(playgame(input, 40))
end

function solvepart2(input)
    @time length(playgame(input, 50))
end

puzzles = [
    Puzzle(10, "test 1", "input-test1.txt", input -> playgame(input, 1), "312211"),
    Puzzle(10, "deel 1", solvepart1, 492982),
    Puzzle(10, "deel 2", solvepart2, 6989950)
]

printresults(puzzles)

end