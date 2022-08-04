 module Day23
 
 # https://adventofcode.com/2015/day/23
 
 include("./../aoc.jl")
 
 using .AOC

 using Match

struct Code
    instruction::String
    register::Symbol # first tried making this an @enum, but matching doesn't work on enums.
    offset::Integer
end

Code(i::AbstractString, r::AbstractString, o::AbstractString) = Code(i, r == "a" || r == "a," ? :a : ( r == "" ? :none : :b), parse(Int64, o))

mutable struct Computer
    pp::Integer
    a::Int64
    b::Int64
end

Computer() = Computer(1, 0, 0)

function AOC.processinput(data)
    data = split(data, '\n')     
    map(p -> Code(p...), map(s -> ((length(s) == 2 && push!(s, "1")); (s[1] == "jmp" && (s = [s[1], "", s[2]])); s), split.(data, " ")))
end

function run(computer, code::Code)
    @match code begin
        Code("hlf", :a, _) => begin computer.a ÷= 2 end
        Code("hlf", :b, _) => begin computer.b ÷= 2 end
        Code("tpl", :a, _) => begin computer.a *= 3 end
        Code("tpl", :b, _) => begin computer.b *= 3 end
        Code("inc", :a, _) => begin computer.a += 1 end
        Code("inc", :b, _) => begin computer.b += 1 end
        Code("jie", :a, offset) => begin computer.a % 2 == 0 && (computer.pp += offset-1) end
        Code("jie", :b, offset) => begin computer.b % 2 == 0 && (computer.pp += offset-1) end
        Code("jio", :a, offset) => begin computer.a == 1 && (computer.pp += offset-1) end
        Code("jio", :b, offset) => begin computer.b == 1 && (computer.pp += offset-1) end
        Code("jmp", _, offset) => begin computer.pp += offset-1 end
    end
    computer.pp += 1
end

function run(computer, codelist::AbstractArray)
    while computer.pp <= length(codelist)
        run(computer, codelist[computer.pp])
    end
    computer
end

function solve(codelist, startvalue = 0)
    computer = Computer()
    computer.a = startvalue
    run(computer, codelist).b
end

function solvepart1(codelist)
    solve(codelist)
end

function solvepart2(codelist)
    solve(codelist, 1)
end


puzzles = [
    Puzzle(23, "test 1", "input-test1.txt", solvepart1, 0),
    Puzzle(23, "deel 1", solvepart1, 184),
    Puzzle(23, "test 2", "input-test1.txt", solvepart2, 0),
    Puzzle(23, "deel 2", solvepart2, 231)
]

printresults(puzzles)

end