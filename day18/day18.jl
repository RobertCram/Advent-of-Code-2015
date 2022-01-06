module Day18

# https://adventofcode.com/2015/day/18

include("./../aoc.jl")

using .AOC

Directions = [
    CartesianIndex(0,1),
    CartesianIndex(1,0),
    CartesianIndex(0,-1),
    CartesianIndex(-1, 0),
    CartesianIndex(1, 1),
    CartesianIndex(-1, 1),
    CartesianIndex(1, -1),
    CartesianIndex(-1, -1),
]

function AOC.processinput(data)
    data = split(data, '\n')
    [data[i][j] == '#' ? 1 : 0 for i in 1:length(data), j in 1:length(data[1])]
end

function onmap(size, point)
    rows, cols = size
    point[1] > 0 && point[1] <= rows && point[2] > 0 && point[2] <= cols
end

function neighbours(size, index)
    filter(point -> onmap(size, point), map(d -> index + d, Directions))
end

function corners(size)
    [CartesianIndex(1,1), CartesianIndex(size[1],1), CartesianIndex(1,size[2]), CartesianIndex(size[1], size[2])]
end

function step(config; stuckcornerlights = false)
    sz = size(config)
    stuckcornerlights && (config[corners(sz)] .= 1)
    map(CartesianIndices(config)) do i
        n = sum(config[neighbours(sz, i)])
        stuckcornerlights && i in corners(sz) && return 1
        config[i] == 1 && return n in [2, 3] ? 1 : 0
        config[i] == 0 && return n == 3 ? 1 : 0
    end
end

function step(config, numberofsteps; stuckcornerlights = false)
    foreach(_ -> config = step(config; stuckcornerlights), 1:numberofsteps)
    config
end

function solvepart1(initialconfig)
    sum(step(initialconfig, 100))
end

function solvepart2(initialconfig)
    sum(step(initialconfig, 100, stuckcornerlights = true))
end

puzzles = [
    Puzzle(18, "test 1", "input-test1.txt", initialconfig -> sum(step(initialconfig, 4)), 4),
    Puzzle(18, "deel 1", solvepart1, 768),
    Puzzle(18, "test 2", "input-test1.txt", initialconfig -> sum(step(initialconfig, 5, stuckcornerlights = true)), 17),
    Puzzle(18, "deel 2", solvepart2, 781)
]

printresults(puzzles)

end