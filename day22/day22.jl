module Day22

# https://adventofcode.com/2015/day/22

include("./../aoc.jl")

using .AOC


abstract type AbstractPlayer
end

struct Wizard <: AbstractPlayer
    hitpoints::Int
    armor::Int    
    mana::Int
    spendmana::Int
end

Wizard(hitpoints, mana) = Wizard(hitpoints, 0, mana, 0)

struct Boss <: AbstractPlayer
    hitpoints::Int
    damage::Int
end

struct Game
    p1::AbstractPlayer
    p2::AbstractPlayer
    effects::AbstractArray{Tuple{Any, Int64, String}}
    finished::Bool
end

Game(p1, p2) = Game(p1, p2, [], false)

function magicmissile(game)
    Game(game.p1, Boss(game.p2.hitpoints - 4, game.p2.damage), game.effects, game.finished)
end

function drain(game)
    Game(Wizard(game.p1.hitpoints + 2, game.p1.armor, game.p1.mana, game.p1.spendmana), Boss(game.p2.hitpoints - 2, game.p2.damage), game.effects, game.finished)
end

function shield(game)
    Game(Wizard(game.p1.hitpoints, game.p1.armor + 7, game.p1.mana, game.p1.spendmana), game.p2, game.effects, game.finished)
end

function poison(game)
    Game(game.p1, Boss(game.p2.hitpoints - 3, game.p2.damage), game.effects, game.finished)
end

function recharge(game)
    Game(Wizard(game.p1.hitpoints, game.p1.armor, game.p1.mana + 101, game.p1.spendmana), game.p2, game.effects, game.finished)
end

Effects = Dict(
    "Magic Missile" => ((magicmissile, 1, "Magic Missile"), 53),
    "Drain" => ((drain, 1, "Drain"), 73),
    "Shield" => ((shield, 6, "Shield"), 113), 
    "Poison" => ((poison, 6, "Poison"), 173),
    "Recharge" => ((recharge, 5, "Recharge"), 229),
)

function AOC.processinput(data)
    data = split(data, '\n')
    Boss(map(c -> parse(Int, c[end]), split.(data))...)
end

function isfinished(game)    
    game.p1.hitpoints <= 0 && return true
    game.p2.hitpoints <= 0 && return true
    return false
end

function possiblespells(game)
    spells = setdiff(keys(Effects), map(e -> e[3], game.effects))
    collect(filter(spell -> Effects[spell][2] <= game.p1.mana, spells))
end

function possiblegames(game)
    spells = possiblespells(game)
    map(spell -> playboss(playwizard(Game(game.p1, game.p2, game.effects, game.finished), spell)), spells)
end

function possiblegames(games::AbstractArray, minimummana)
    games = collect(Iterators.flatten(map(game -> possiblegames(game), games)))
    games = filter(game -> game.p1.spendmana < minimummana, games)
    filter(game -> !game.finished, games), filter(game -> game.finished && game.p1.hitpoints > 0, games)
end

function cast(game, spell)
    effect = Effects[spell]
    push!(game.effects, effect[1])
    Game(Wizard(game.p1.hitpoints, game.p1.armor, game.p1.mana - effect[2], game.p1.spendmana + effect[2]), game.p2, game.effects, game.finished)
end

function applyeffects(game)
    for effect in game.effects
        game = effect[1](game)
    end
    Game(game.p1, game.p2, filter(e -> e[2]>0, map(e -> (e[1], e[2]-1, e[3]), game.effects)), isfinished(game))
end

function playwizard(game, spell)
    game.finished && return game
    game = applyeffects(game)
    game.finished && return game
    cast(game, spell)
end

function playboss(game)
    game.finished && return game
    game = applyeffects(game)
    game.finished && return game
    Game(Wizard(game.p1.hitpoints - maximum([game.p2.damage - game.p1.armor, 1]), game.p1.armor, game.p1.mana, game.p1.spendmana), game.p2, game.effects, isfinished(game))
end

function play(game::Game)
    println(game)
    minimummana = typemax(Int)
    allwins = []
    games = [game]
    while !isempty(games)
        println(minimummana)
        games, wins = possiblegames(games, minimummana)
        !isempty(wins) && push!(allwins, wins...)
        !isempty(allwins) && (minimummana = minimum([minimummana, sort(map(game -> game.p1.spendmana, allwins))[begin]])) 
    end
    minimummana
end


function solvepart1(boss)
    game = Game(Wizard(50, 500), boss)
end

function solvepart2(input)
    "nog te bepalen"
end

puzzles = [
    Puzzle(22, "test 1", "input-test1.txt", boss -> play(Game(Wizard(10, 250), boss)), 226),
    Puzzle(22, "test 2", "input-test2.txt", boss -> play(Game(Wizard(10, 250), boss)), 641),
    # Puzzle(22, "deel 1", "input.txt", boss -> play(Game(Wizard(50, 500), boss)), nothing),
    # Puzzle(22, "test 2", "input-test1.txt", solvepart2, nothing),
    # Puzzle(22, "deel 2", solvepart2, nothing)
]

printresults(puzzles)

end