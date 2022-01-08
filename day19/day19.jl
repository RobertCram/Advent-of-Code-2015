module Day19

# https://adventofcode.com/2015/day/19

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    replacements, start = split(data, "\n\n")
    replacements = split.(split(replacements, "\n"), " => ")
    replacements = [replacement[1] => replacement[2] for replacement in replacements]
    (replacements = replacements, start = start)
end

function newmolecules(molecule, replacement)
    results = []
    indices = findall(replacement[1], molecule)
    for index in indices 
        result = molecule[1:index[begin] - 1] * replacement[2]
        index[end] < length(molecule) && (result *= molecule[index[end] + 1:end])
        push!(results, result)
    end
    results
end

function newmolecules(molecule, replacements::AbstractArray)
    unique(collect(Iterators.flatten(map(replacement -> newmolecules(molecule, replacement), replacements))))
end

function dfs(molecule, replacements, target, depth = 0, minimumdepth = typemax(Int))
    (molecule == target) && return min(depth, minimumdepth)
    molecules = newmolecules(molecule, replacements)    
    isempty(molecules) && return min(depth, minimumdepth)
    for molecule in molecules                 
        return dfs(molecule, replacements, target, depth + 1, minimumdepth)
    end
end

function solvepart1(input)
    # using BFS
    length(newmolecules(input.start, input.replacements))
end

function solvepart2(input)
    # using DFS (from result to start)
    replacements = map(replacement -> replacement[2] => replacement[1], input.replacements)
    dfs(input.start, replacements, "e")
end

puzzles = [
    Puzzle(19, "test 1", "input-test1.txt", solvepart1, 7),
    Puzzle(19, "deel 1", solvepart1, 518),
    Puzzle(19, "test 2", "input-test2.txt", solvepart2, 6),
    Puzzle(19, "deel 2", solvepart2, 200)
]

printresults(puzzles)

end