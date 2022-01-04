module Day12

# https://adventofcode.com/2015/day/12

include("./../aoc.jl")

using .AOC

using JSON

function AOC.processinput(data)
    data
end

function sumnumbers(json)
    captures = map(m -> m.captures, eachmatch(r"(-?[0-9]+)", json))
    sum(parse.(Int, (collect(Iterators.flatten(captures)))))    
end

function copywithoutred(value)
    value
end

function copywithoutred(values::Array)
    result = []
    for value in values
        push!(result, copywithoutred(value))
    end
    result
end

function copywithoutred(d::Dict)
    result = Dict()
    "red" in values(d) && return result
    for p in d
        push!(result, p[1] => copywithoutred(p[2]))
    end
    result
end

function solvepart1(json)
    sumnumbers(json)
end

function solvepart2(json)
    dictionary = copywithoutred(JSON.parse(json))    
    sumnumbers(JSON.json(dictionary))
end

puzzles = [
    Puzzle(12, "test 1", "input-test1.txt", solvepart1, 18),
    Puzzle(12, "deel 1", solvepart1, 111754),
    Puzzle(12, "test 2", "input-test2.txt", solvepart2, 16),
    Puzzle(12, "deel 2", solvepart2, 65402)
]

printresults(puzzles)

end