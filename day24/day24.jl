module Day24

# https://adventofcode.com/2015/day/24

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = parse.(Int64, split(data, '\n'))
end

function getgroups(availableweights, targetweight, groups = [], weights = [])
    targetweight == 0 && return push!(groups, weights)
    (targetweight < 0 || length(availableweights) == 0) && return groups
    (availableweights[begin] > targetweight) && return groups
    for (i, weight) in enumerate(availableweights)        
        groups = getgroups(availableweights[i+1:end], targetweight - weight, groups, push!(copy(weights), weight))
    end
    groups
end

function solve(weights, groups)
    weight = sum(weights) ÷ groups
  
    remainingweights = weights
    groups1 = getgroups(remainingweights, weight)
    groups1 = map(t -> t[3], sort(map(g-> (length(g), reduce(*, g), g), groups1)))

    for group1 in groups1
        remainingweights = setdiff(remainingweights, group1)
        groups2 = getgroups(remainingweights, weight)
        for group2 in groups2
            remainingweights = setdiff(remainingweights, group2)
            groups3 = getgroups(remainingweights, weight)  
            groups == 3 && length(groups3) > 0 && return reduce(*, group1)
            groups == 4 && for group3 in groups3
                remainingweights = setdiff(remainingweights, group3)
                groups4 = getgroups(remainingweights, weight)  
                length(groups4) > 0 && return reduce(*, group1)
            end
        end
    end
end

function solvepart1(weights)
    solve(weights, 3)
end

function solvepart2(weights)
    solve(weights, 4)
end

puzzles = [
    Puzzle(24, "test 1", "input-test1.txt", solvepart1, 99),
    Puzzle(24, "deel 1", solvepart1, 11266889531),
    Puzzle(24, "test 2", "input-test1.txt", solvepart2, 44),
    Puzzle(24, "deel 2", solvepart2, 77387711)
]

printresults(puzzles)

end