module Day09

# https://adventofcode.com/2015/day/9

include("./../aoc.jl")

using .AOC

using Combinatorics

function processline(line)
    destinations, distance = split(line, " = ")
    destination1, destination2 = split(destinations, " to ")
    [((from = destination1, to = destination2), parse(Int, distance)), ((from = destination2, to = destination1), parse(Int, distance))]
end

function AOC.processinput(data)
    data = split(data, '\n')
    data = collect(Iterators.flatten(map(line -> processline(line), data)))
    reduce((distances, (path, distance)) -> (distances[path] = distance; distances), data, init=Dict{NamedTuple, Int}())
end

function pathlength(distances, path)
    length(path) <= 1 && return 0
    sum(map(i -> distances[(from = path[i], to = path[i+1])], 1:length(path)-1))
end

function getpathlengths(distances)
    destinations = unique(map(path -> path.from, collect(keys(distances))))
    map(path -> pathlength(distances, path), permutations(destinations))
end

function solvepart1(distances)   
    minimum(getpathlengths(distances))
end

function solvepart2(distances)
    maximum(getpathlengths(distances))
end

puzzles = [
    Puzzle(09, "test 1", "input-test1.txt", solvepart1, 605),
    Puzzle(09, "deel 1", solvepart1, 141),
    Puzzle(09, "test 2", "input-test1.txt", solvepart2, 982),
    Puzzle(09, "deel 2", solvepart2, 736)
]

printresults(puzzles)

end