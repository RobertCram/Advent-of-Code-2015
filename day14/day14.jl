module Day14

# https://adventofcode.com/2015/day/14

include("./../aoc.jl")

using .AOC


function processline(line)
    parts = split(line)
    (name = parts[1], speed = parse(Int, parts[4]), flytime = parse(Int, parts[7]), resttime = parse(Int, parts[14]))
end

function AOC.processinput(data)
    data = split(data, '\n')
    processline.(data)    
end

function distancetravelled(reindeerinfo, second)
    cycle = reindeerinfo.flytime + reindeerinfo.resttime
    mod(second - 1, cycle) + 1 <= reindeerinfo.flytime ? reindeerinfo.speed : 0
end

function scoring!(distances, points)
    maxdistance = maximum(values(distances))
    for d in distances
        d[2] == maxdistance && (points[d[1]] = get(points, d[1], 0) + 1)
    end
    points
end

function race(input, seconds)
    scores = Dict()
    results = Dict()
    for second in 1:seconds
        distances = map(i -> (i.name, distancetravelled(i, second)), input)
        reduce((r, distance) -> (r[distance[1]] = get(r, distance[1], 0) + distance[2]; r), distances, init = results)
        scores = scoring!(results, scores)
    end    
    maximum(values(results)), maximum(values(scores))
end

function solvepart1(input)
    race(input, 2503)[1]
end

function solvepart2(input)
    race(input, 2503)[2]
end

puzzles = [
    Puzzle(14, "test 1", "input-test1.txt", input -> race(input, 1000)[1], 1120),
    Puzzle(14, "deel 1", solvepart1, 2660),
    Puzzle(14, "test 2", "input-test1.txt", input -> race(input, 1000)[2], 689),
    Puzzle(14, "deel 2", solvepart2, 1256)
]

printresults(puzzles)

end