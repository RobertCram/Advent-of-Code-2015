 module Day23
 
 # https://adventofcode.com/2015/day/23
 
 include("./../aoc.jl")
 
 using .AOC

 using Match

@enum Register a b none

struct Code
    instruction::String
    register::Register
    offset::Integer
end

Code(i::AbstractString, r::AbstractString, o::AbstractString) = Code(i, r == "a" || r == "a," ? a : ( r == "" ? none : b), parse(Int64, o))

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
    println(code)
    @match code begin
        Code("hlf", a, _) => begin computer.a ÷= 2 end
        Code("hlf", b, _) => begin computer.b ÷= 2 end
        Code("tpl", a, _) => begin computer.a *= 3 end
        Code("tpl", b, _) => begin computer.b *= 3 end
        Code("inc", a, _) => begin println("inc a called!"); computer.a += 1 end
        Code("inc", b, _) => begin println("inc b called!"); computer.b += 1 end
        Code("jie", a, offset) => begin computer.a % 2 == 0 && (computer.pp += offset-1) end
        Code("jie", b, offset) => begin computer.b % 2 == 0 && (computer.pp += offset-1) end
        Code("jio", a, offset) => begin computer.a == 1 && (computer.pp += offset-1) end
        Code("jio", b, offset) => begin computer.b == 1 && (computer.pp += offset-1) end
        Code("jmp", _, offset) => begin computer.pp += offset-1 end
    end
    computer.pp += 1
end

function run(codelist::AbstractArray)
    computer = Computer()
    # while computer.pp <= length(codelist)
    while computer.pp <= 44
            println(computer)
        run(computer, codelist[computer.pp])
    end
    computer
end

function solvepart1(codelist)
    run(codelist).b
end

function solvepart2(program)
    "nog te bepalen" 
end

puzzles = [
    # Puzzle(23, "test 1", "input-test1.txt", solvepart1, 0),
    Puzzle(23, "deel 1", solvepart1, nothing),
    # Puzzle(23, "test 2", "input-test1.txt", solvepart2, nothing),
    # Puzzle(23, "deel 2", solvepart2, nothing)
]

printresults(puzzles)

end