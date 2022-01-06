module Day17

# https://adventofcode.com/2015/day/17

include("./../aoc.jl")

using .AOC

using Combinatorics

function AOC.processinput(data)
    data = split(data, '\n')
    parse.(Int, data)
end

function configurations(containers, volume)
    configurations = []
    for i in 1:length(containers)
        push!(configurations, filter(c -> sum(c) == volume, collect(combinations(containers, i))))
    end
    collect(Iterators.flatten(configurations))
end

function leastcontainersconfigurations(containers, volume)
    configs = configurations(containers, volume)
    leastcontainers = minimum(map(config -> length(config), configs))
    filter(config -> length(config) == leastcontainers, configs)
end

function solvepart1(containers)
    length(configurations(containers, 150))
end

function solvepart2(containers)
    length(leastcontainersconfigurations(containers, 150))
end

puzzles = [
    Puzzle(17, "test 1", "input-test1.txt", containers -> length(configurations(containers, 25)), 4),
    Puzzle(17, "deel 1", solvepart1, 654),
    Puzzle(17, "test 2", "input-test1.txt", containers -> length(leastcontainersconfigurations(containers, 25)), 3),
    Puzzle(17, "deel 2", solvepart2, 57)
]

printresults(puzzles)

end