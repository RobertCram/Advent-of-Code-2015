module Day06

include("./../aoc.jl")

using .AOC

function processpoint(point)
    parse.(Int, split(point, ','))
end

function processline(line)
    parts = split.(line)
    length(parts) == 4 && return (command = :toggle, topleft = processpoint(parts[2]), bottomright = processpoint(parts[4]))
    parts[2] == "on" && return (command = :on, topleft = processpoint(parts[3]), bottomright = processpoint(parts[5]))
    parts[2] == "off" && return (command = :off, topleft = processpoint(parts[3]), bottomright = processpoint(parts[5]))
end

function AOC.processinput(data)
    data = split(data, '\n')
    data = processline.(data)
end

function solvepart1(instructions)
    lights = [0 for i in 1:1000, j in 1:1000]
    for i in instructions
        xrange = i.topleft[2]+1:i.bottomright[2]+1
        yrange = i.topleft[1]+1:i.bottomright[1]+1
        i.command == :on && (lights[xrange, yrange] .= 1)
        i.command == :toggle && (lights[xrange, yrange] .⊻= 1)
        i.command == :off && (lights[xrange, yrange] .= 0)
    end    
    sum(lights)
end

function solvepart2(instructions)
    lights = [0 for i in 1:1000, j in 1:1000]
    for i in instructions
        xrange = i.topleft[2]+1:i.bottomright[2]+1
        yrange = i.topleft[1]+1:i.bottomright[1]+1
        i.command == :on && (lights[xrange, yrange] .+= 1)
        i.command == :toggle && (lights[xrange, yrange] .+= 2)
        i.command == :off && (lights[xrange, yrange] .-= 1)
        lights[lights .< 0] .= 0
    end    
    sum(lights)
end

puzzles = [
    Puzzle(06, "test 1", "input-test1.txt", solvepart1, 1000000 - 1000 - 4),
    Puzzle(06, "deel 1", solvepart1, 400410),
    Puzzle(06, "test 2", "input-test1.txt", solvepart2, 1000000 + 2000 - 4),
    Puzzle(06, "deel 2", solvepart2, 15343601)
]

printresults(puzzles)

end