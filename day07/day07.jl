module Day07

# https://adventofcode.com/2015/day/7

include("./../aoc.jl")

using .AOC

function processline(line)
    input, output = split(line, " -> ")
    parts = split(input)
    length(parts) == 1 && tryparse(Int, parts[1]) === nothing && return (command = :assign, input1 = parts[1], input2 = nothing, output = output, vars=[parts[1]])
    length(parts) == 1 && return (command = :assign, input1 = parse(Int, parts[1]), input2 = nothing, output = output, vars = [])
    length(parts) == 2 && return (command = :not, input1 = parts[2], input2 = nothing, output = output, vars = [parts[2]])
    length(parts) == 3 && tryparse(Int, parts[1]) === nothing && tryparse(Int, parts[3]) === nothing && return (command = Symbol(lowercase(parts[2])), input1 = parts[1], input2 = parts[3], output = output, vars = [parts[1], parts[3]])
    length(parts) == 3 && tryparse(Int, parts[1]) === nothing && return (command = Symbol(lowercase(parts[2])), input1 = parts[1], input2 = parse(Int, parts[3]), output = output, vars=[parts[1]])
    length(parts) == 3 && tryparse(Int, parts[3]) === nothing && return (command = Symbol(lowercase(parts[2])), input1 = parse(Int, parts[1]), input2 = parts[3], output = output, vars=[parts[3]])
    length(parts) == 3 && return (command = Symbol(lowercase(parts[2])), input1 = parse(Int, parts[1]), input2 = parse(Int, parts[3]), output = output, vars=[])
end

function AOC.processinput(data)
    data = split(data, '\n')
    data = processline.(data)
end

function evaluate!(wires, circuit)
    command, input1, input2, output = circuit
    getvar(input) = get(wires, input, input)
    command == :assign && (wires[output] = getvar(input1))
    command == :not && (wires[output] = Int(~UInt16(getvar(input1))))
    command == :lshift && (wires[output] = getvar(input1) << getvar(input2))
    command == :rshift && (wires[output] = getvar(input1) >> getvar(input2))
    command == :and && (wires[output] = getvar(input1) & getvar(input2))
    command == :or && (wires[output] = getvar(input1) | getvar(input2))
end

function runcircuit(connections, wire)
    wires = Dict()
    while true
        previouswires = copy(wires)
        evaluateconnection!(circuit) = evaluate!(wires, circuit)
        evaluatables = filter(c -> isempty(setdiff(c.vars, keys(wires))), connections)
        evaluateconnection!.(evaluatables)
        haskey(previouswires, wire) && wires[wire] == previouswires[wire] && break
    end
    wires[wire]
end

function solvepart1(connections)
    runcircuit(connections, "a")
end

function solvepart2(connections)
    connections = filter(c -> c.output != "b", connections)
    push!(connections, (command = :assign, input1 = 16076, input2 = nothing, output = "b", vars=[]))
    runcircuit(connections, "a")
end

puzzles = [
    Puzzle(07, "test 1", "input-test1.txt", x -> runcircuit(x, "h"), 65412),
    Puzzle(07, "deel 1", solvepart1, 16076),
    Puzzle(07, "deel 2", solvepart2, 2797)
]

printresults(puzzles)

end