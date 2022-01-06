module Day15

# https://adventofcode.com/2015/day/15

include("./../aoc.jl")

using .AOC

function processline(line)
    parts = split(line)
    (name = parts[1][1:end-1], properties = [parse(Int, parts[3][1:end-1]), parse(Int, parts[5][1:end-1]), parse(Int, parts[7][1:end-1]), parse(Int, parts[9][1:end-1]), parse(Int, parts[11])])
end

function AOC.processinput(data)
    data = split(data, '\n')
    processline.(data)
end

function fixedsumpermutations(n, k)
    range(n, k, i, a) = i == k ? (n-sum(a):n-sum(a)) : 1:n-sum(a)-k+i
    result = [Int[]]
    for i in 1:k    
        result = Iterators.flatten(map(a -> map(i -> push!(copy(a), i), range(n, k, i, a)), result))
    end
    collect(result)
end

function getscore(input, caloriefilter = c -> true)
    properties = [input[i].properties[j] for i in 1:length(input), j in 1:5]
    cookies = [v' * properties for v in fixedsumpermutations(100, length(input))]
    cookies = filter(cookie -> length(cookie[cookie .<= 0]) == 0 && caloriefilter(cookie[5]), cookies)
    maximum(map(cookie -> reduce(*, cookie[1:end-1], init=1), cookies))
end

function solvepart1(input)
    getscore(input)
end

function solvepart2(input)
    getscore(input, c -> c == 500)
end

puzzles = [
    Puzzle(15, "test 1", "input-test1.txt", solvepart1, 62842880),
    Puzzle(15, "deel 1", solvepart1, 18965440),
    Puzzle(15, "deel 2", solvepart2, 15862900),
]

printresults(puzzles)

end