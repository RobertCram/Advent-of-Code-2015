module Day03

# https://adventofcode.com/2015/day/3

include("./../aoc.jl")

using .AOC

Directions = Dict(
    '^' => [0,1],
    '>' => [1,0],
    'v' => [0,-1],
    '<' => [-1,0],    
)

function AOC.processinput(data)
    map(d -> Directions[d], collect(data))
end

function solvepart1(directions)
    houses = [[0, 0], cumsum(directions)...]
    length(unique(houses))
end

function solvepart2(directions)
    santamask = [mod(i,2) == 1 for i in 1:length(directions)]
    robomask = .!santamask
    santadirections = directions[santamask]
    robodirections = directions[robomask]
    houses = [[0,0], cumsum(santadirections)..., cumsum(robodirections)...]
    length(unique(houses))
end

puzzles = [
    Puzzle(03, "test 1", "input-test1.txt", solvepart1, 4),
    Puzzle(03, "deel 1", solvepart1, 2592),
    Puzzle(03, "test 2", "input-test1.txt", solvepart2, 3),
    Puzzle(03, "deel 2", solvepart2, 2360)
]

printresults(puzzles)

end