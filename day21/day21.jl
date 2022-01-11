module Day21

# https://adventofcode.com/2015/day/21

include("./../aoc.jl")

using .AOC

using Combinatorics

# (damage, armor, cost)

Weapons = [
    (4, 0, 8),
    (5, 0, 10),
    (6, 0, 25),
    (7, 0, 40),
    (8, 0, 74),
]

Armor = [
    (0, 1, 13),
    (0, 2, 31),
    (0, 3, 53),
    (0, 4, 75),
    (0, 5, 102),
]

Rings = [
    (1, 0 , 25),
    (2, 0 , 50),
    (3, 0 , 100),
    (0, 1, 20),
    (0, 2, 40),
    (0, 3, 80),
]

struct Player
    hitpoints::Int
    damage::Int
    armor::Int    
end

struct Game
    p1::Player
    p2::Player
end

function AOC.processinput(data)
    data = split(data, '\n')
    Player(parse.(Int, map(a -> a[end], split.(data)))...)
end

function getitemcombos()
    itemcombos = map(weapon -> [weapon], Weapons)
    itemcombos = collect(Iterators.flatten(map(c -> map(a -> a === nothing ? c : push!(copy(c), a), [nothing, Armor...]), itemcombos)))
    rings = [combinations(Rings, 2)..., combinations(Rings, 1)..., []]
    collect(Iterators.flatten(map(c -> map(a -> [copy(c)..., a...], rings), itemcombos)))
end

function attack(attacker, defender)
    defender = Player(defender.hitpoints - max(1, attacker.damage - defender.armor), defender.damage, defender.armor)
    attacker, defender
end

function playround(game::Game)
    p1, p2 = attack(game.p1, game.p2)
    p2.hitpoints <= 0 && return Game(p1, p2)
    p2, p1 = attack(p2, p1)
    p1.hitpoints <= 0 && return Game(p1, p2)
    return Game(p1, p2)
end

function play(game::Game)
    while game.p1.hitpoints > 0 && game.p2.hitpoints > 0
        game = playround(game)
    end
    game
end

function sum(combo::Array{Tuple{Int, Int, Int}})
    d, a, c = 0, 0, 0
    for i in 1:length(combo)
        d += combo[i][1]
        a += combo[i][2]
        c += combo[i][3]
    end
    (d, a, c)
end

function solvepart1(boss)
    combos = sum.(getitemcombos())
    wongames = filter(combo -> play(Game(Player(100, combo[1], combo[2]), boss)).p1.hitpoints > 0, combos)
    sort(wongames, by = c -> c[3])[begin][3]
end

function solvepart2(boss)
    combos = sum.(getitemcombos())
    lostgames = filter(combo -> play(Game(Player(100, combo[1], combo[2]), boss)).p2.hitpoints > 0, combos)
    sort(lostgames, by = c -> c[3])[end][3]
end

puzzles = [
    Puzzle(21, "test 1", "input-test1.txt", boss -> play(Game(Player(8, 5, 5), boss)).p1.hitpoints, 2),
    Puzzle(21, "deel 1", solvepart1, 111),
    Puzzle(21, "deel 2", solvepart2, 188)
]

printresults(puzzles)

end