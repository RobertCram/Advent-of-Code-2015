module Day11

# https://adventofcode.com/2015/day/11

include("./../aoc.jl")

using .AOC

function AOC.processinput(data)
    map(password -> Int.(collect(password)) .- 97, split(data))
end

function hasstraightline(password)
    reduce((result, i) -> result || (password[i] == password[i+1] - 1 && password[i+1] == password[i+2] - 1), 1:length(password) - 2, init = false)
end 

function hastwopairs(password)
    indices = reduce((results, i) -> (password[i] == password[i+1] && push!(results, i); results), 1:length(password) - 1, init = [])
    length(unique(password[indices])) > 1
end

function skipconfusingletters!(password, confusingletters)
    (i = findfirst(c -> c in Int.(confusingletters) .- 97, password)) === nothing && return password    
    password[i] += 1; password[i+1:end] .= 0
    password
end

function getnextvalid(password)
    isvalidpassword(password) = hasstraightline(password) && hastwopairs(password)
    while true
        password = skipconfusingletters!(password, ['i', 'o', 'l'])
        password[8] = mod(password[8] + 1, 26)
        isvalidpassword(password) && break
        if password[8] == 0
            password[7] = mod(password[7] + 1, 26)
            if password[7] == 0
                password[6] = mod(password[6] + 1, 26)
                if password[6] == 0 
                    password[5] = mod(password[5] + 1, 26)
                    if password[5] == 0
                        password[4] = mod(password[4] + 1, 26)
                        if password[4] == 0
                            password[3] = mod(password[3] + 1, 26)
                            if password[3] == 0
                                password[2] = mod(password[2] + 1, 26)
                                if password[2] == 0
                                    password[1] = mod(password[1] + 1, 26)
                                end
                            end
                        end
                    end
                end
            end
        end        
    end
    join(Char.(password .+ 97))
end

function solvepart1(passwords)    
    map(password -> getnextvalid(password), passwords)
end

function solvepart2(passwords)    
    passwords = [Int.(collect("hepxxyzz")) .- 97]
    map(password -> getnextvalid(password), passwords)    
end

puzzles = [
    Puzzle(11, "test 1", "input-test1.txt", solvepart1, ["abcdffaa", "ghjaabcc"]),
    Puzzle(11, "deel 1", solvepart1, ["hepxxyzz"]),
    Puzzle(11, "deel 2", solvepart2, ["heqaabcc"])
]

printresults(puzzles)

end