module Day16

# https://adventofcode.com/2015/day/16

include("./../aoc.jl")

using .AOC

Categories = Dict(
    "children" => 1,
    "cats" => 2,
    "samoyeds" => 3,
    "pomeranians" => 4,
    "akitas" => 5,
    "vizslas" => 6,
    "goldfish" => 7,
    "trees" => 8,
    "cars" => 9,
    "perfumes" => 10,
)

TickerTape = [3, 7, 2, 3, 0, 0, 5, 3, 2, 1]

function processline(line)
    parts = split(line)
    sue = parse(Int, parts[2][1:end-1])
    categories = zeros(Int, 10) .- 1
    categories[Categories[parts[3][1:end-1]]] = parse(Int, parts[4][1:end-1])
    categories[Categories[parts[5][1:end-1]]] = parse(Int, parts[6][1:end-1])
    categories[Categories[parts[7][1:end-1]]] = parse(Int, parts[8][1:end])
    (sue = sue, categories = categories)
end

function AOC.processinput(data)
    data = split(data, '\n')
    processline.(data)
end

function ismatch1(categories)
    sum(((categories .== -1) .| (categories .== TickerTape))) == 10
end

function ismatch2(categories)
    categories = copy(categories)
    match = categories[2] == -1 || (categories[2] > TickerTape[2])
    match = match && (categories[8] == -1 || (categories[8] > TickerTape[8]))
    match = match && (categories[4] == -1 || (categories[4] < TickerTape[4]))
    match = match && (categories[7] == -1 || (categories[7] < TickerTape[7]))
    categories[[2, 8, 4, 7]] .= -1
    match && sum(((categories .== -1) .| (categories .== TickerTape))) == 10     
end


function solvepart1(input)
    filter(i -> ismatch1(i.categories), input)[1].sue
end

function solvepart2(input)
    filter(i -> ismatch2(i.categories), input)[1].sue    
end

puzzles = [
    Puzzle(16, "deel 1", solvepart1, 213),
    Puzzle(16, "deel 2", solvepart2, 323)
]

printresults(puzzles)

end