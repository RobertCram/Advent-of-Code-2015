module Day02

# https://adventofcode.com/2015/day/2

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = split(data, '\n')
    map(d -> parse.(Int, split(d, 'x')), data)
end

function wrappingpaperneeded(dimensions)
    l, w, h = dimensions
    surfaces = [l * w, w * h, h * l]
    2 * sum(surfaces) + minimum(surfaces)
end

function ribbonneeded(dimensions)
    l, w, h = sort(dimensions)
    2 * (l + w) + l * w * h
end

function solvepart1(dimensions)
    sum(map(d -> wrappingpaperneeded(d), dimensions))
end

function solvepart2(dimensions)
    sum(map(d -> ribbonneeded(d), dimensions))
end

puzzles = [
    Puzzle(02, "test 1", "input-test1.txt", solvepart1, 101),
    Puzzle(02, "deel 1", solvepart1, 1606483),
    Puzzle(02, "test 2", "input-test1.txt", solvepart2, 48),
    Puzzle(02, "deel 2", solvepart2, 3842356)
]

printresults(puzzles)

end