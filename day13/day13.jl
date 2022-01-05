module Day13

# https://adventofcode.com/2015/day/13

include("./../aoc.jl")

using .AOC

using Combinatorics

function processline(line)
    line = replace(line, "would gain " => "")
    line = replace(line, "would lose " => "-")
    line = replace(line, "happiness units by sitting next to " => "")
    name1, happiness, name2 = split(line)
    (name1 = name1, name2 = name2[1:end-1], happiness = parse(Int, happiness))
end

function AOC.processinput(data)
    data = split(data, '\n')
    data = processline.(data)
    Dict((value.name1, value.name2) => value.happiness for value in data)
end

function getnames(input)
    unique(map(key -> key[1], collect(keys(input))))
end

function gethappiness(input, seating)
    seating = copy(seating)
    push!(seating, seating[1])
    reduce((total, i) -> total += get(input, (seating[i], seating[i+1]), 0) + get(input, (seating[i+1], seating[i]), 0), 1:length(seating)-1, init=0)
end

function getmaximumhappiness(input, names)
    seatings = map(p -> push!(p, names[1]), collect(permutations(names[2:end])))
    maximum(map(seating -> gethappiness(input, seating), seatings))
end

function solvepart1(input)
    names = getnames(input)
    getmaximumhappiness(input, names)
end

function solvepart2(input)
    names = [getnames(input)..., "Robert"]
    getmaximumhappiness(input, names)
end

puzzles = [
    Puzzle(13, "test 1", "input-test1.txt", solvepart1, 330),
    Puzzle(13, "deel 1", solvepart1, 664),
    Puzzle(13, "deel 2", solvepart2, 640)
]

printresults(puzzles)

end