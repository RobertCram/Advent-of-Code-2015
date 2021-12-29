module Day05

# https://adventofcode.com/2015/day/5

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    data = split(data, '\n')
end

function threevowels(word)
    length(filter(c -> c in "aeiou", word)) >= 3
end

function twiceinarow(word)
    sum(map(i -> word[i] == word[i+1], 1:length(word)-1)) != 0
end

function excludesforbidden(word)
    sum(map(forbidden -> occursin(forbidden, word), ["ab", "cd", "pq", "xy"])) == 0
end

function isoverlapping(word, pair)
    first = findfirst(pair, word)
    last = findlast(pair, word) 
    last <= first .+ 1
end

function containstwopairs(word)
    pairs = unique(map(i -> (word[i] * word[i+1]), 1:length(word)-1))
    sum(map(pair -> !isoverlapping(word, pair), pairs)) > 0
end

function containssandwich(word)
    sum(map(i -> word[i] == word[i+2], 1:length(word)-2)) != 0
end

function solvepart1(words)
    isnice(word) = excludesforbidden(word) && threevowels(word) && twiceinarow(word)
    sum(map(word -> isnice(word), words))
end

function solvepart2(words)
    isnice(word) = containstwopairs(word) && containssandwich(word)
    sum(map(word -> isnice(word), words))
end

puzzles = [
    Puzzle(05, "test 1", "input-test1.txt", solvepart1, 2),
    Puzzle(05, "deel 1", solvepart1, 258),
    Puzzle(05, "test 2", "input-test2.txt", solvepart2, 3),
    Puzzle(05, "deel 2", solvepart2, 53)
]

printresults(puzzles)

end