module Day24

# https://adventofcode.com/2015/day/24

include("./../aoc.jl")

using .AOC

struct Sleigh
    passenger::AbstractArray{Integer}
    compartment1::AbstractArray{Integer}
    compartment2::AbstractArray{Integer}
end

function AOC.processinput(data)
    data = parse.(Int64, split(data, '\n'))
end

function getgroup(groups, weights, availableweights, targetweight)
    targetweight == 0 && (push!(groups, weights); return)
    (targetweight < 0 || length(availableweights) == 0) && return
    for (i, weight) in enumerate(availableweights)
        getgroup(groups, push!(copy(weights), weight), availableweights[i+1:end], targetweight - weight)
    end
end

function getgroups(avalaibleweights, targetweight)
    groups = []
    getgroup(groups, [], avalaibleweights, targetweight)
    groups
end


function solvepart1(weights)
    weight = sum(weights) ÷ 3
    getgroups(weights, weight)
end

function solvepart2(weights)
    weights
end

puzzles = [
    Puzzle(24, "test 1", "input-test1.txt", solvepart1, 99),
    # Puzzle(24, "deel 1", solvepart1, nothing),
    # Puzzle(24, "test 2", "input-test1.txt", solvepart2, nothing),
    # Puzzle(24, "deel 2", solvepart2, nothing)
]

printresults(puzzles)

end