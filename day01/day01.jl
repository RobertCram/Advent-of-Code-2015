module Day01

# https://adventofcode.com/2015/day/1

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    map(direction -> direction =='(' ? 1 : -1, collect(data))
end

function solvepart1(directions)
    sum(directions)
end

function solvepart2(directions)
    floors = cumsum(directions)
    findfirst(floor -> floor == -1, floors)
end

puzzles = [
    Puzzle(01, "test 1", "input-test1.txt", solvepart1, 3),
    Puzzle(01, "deel 1", solvepart1, 138),
    Puzzle(01, "test 2", "input-test1.txt", solvepart2, 1),
    Puzzle(01, "deel 2", solvepart2, 1771)
]

printresults(puzzles)

end