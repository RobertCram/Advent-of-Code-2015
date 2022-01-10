module Day20

# https://adventofcode.com/2015/day/2

include("./../aoc.jl")

using .AOC

using Primes, Combinatorics

function AOC.processinput(data)
    parse(Int, data)
end

function factors(n)
    f = factor(Vector, n)
    [1, unique(map(a -> reduce(*, a), collect(combinations(f))))...]
end

function sumoffactors(n, maxdeliveries)
    fmax = maxdeliveries === nothing ? 0 : (n-1) ÷ maxdeliveries
    sum(filter(f -> f > fmax, factors(n)))
end

function solve(target, presents, maxdeliveries = nothing)
    house = 0
    while true
        housepresents =  presents * sumoffactors(house, maxdeliveries)
        housepresents >= target && break
        house = house + 2
    end
    house
end

function solvepart1(target)
    solve(target, 10)    
end

function solvepart2(target)
    solve(target, 11, 50)    
end

puzzles = [
    Puzzle(20, "test 1", "input-test1.txt", solvepart1, 8),
    Puzzle(20, "deel 1", solvepart1, 831600),
    Puzzle(20, "deel 2", solvepart2, 884520)
]

printresults(puzzles)

end