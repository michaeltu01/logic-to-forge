#lang forge

-- Define the possible values for each attribute
abstract sig Laptop {}
one sig Green, Pink, Purple, Yellow extends Laptop {}

abstract sig Name {}
one sig Emily, Kimberly, Lauren, Samantha extends Name {}

abstract sig Volcano {}
one sig Lavadome, Scoriacone, Submarine, Supervolcano extends Volcano {}

abstract sig Activity {}
one sig Fluctuating, Increasing, Stable, VeryHigh extends Activity {}

-- A Volcanologist has all four attributes
sig Volcanologist {
    laptop: one Laptop,
    name: one Name,
    volcano: one Volcano,
    activity: one Activity,
    position: one Int
}

pred validPuzzle {
    -- Exactly 4 volcanologists
    #Volcanologist = 4
    
    -- Positions are 1, 2, 3, 4
    all v: Volcanologist | v.position >= 1 and v.position <= 4
    
    -- Each position is used exactly once
    all i: Int | (i >= 1 and i <= 4) implies (one v: Volcanologist | v.position = i) -- NOTE: made this one edit to wrap expression in parenthesis
    
    -- Each laptop, name, volcano, and activity is assigned to exactly one volcanologist
    all l: Laptop | one v: Volcanologist | v.laptop = l
    all n: Name | one v: Volcanologist | v.name = n
    all vo: Volcano | one v: Volcanologist | v.volcano = vo
    all a: Activity | one v: Volcanologist | v.activity = a
    
    -- Clue 1: The volcanologist monitoring a volcano with Very high activity is in position 2
    one v: Volcanologist | v.activity = VeryHigh and v.position = 2
    
    -- Clue 2: The scientist studying the Supervolcano is in position 3
    one v: Volcanologist | v.volcano = Supervolcano and v.position = 3
    
    -- Clue 3: The scientist studying the Lava dome is immediately after the scientist studying the Supervolcano
    one v1, v2: Volcanologist | 
        v1.volcano = Supervolcano and v2.volcano = Lavadome and v2.position = add[v1.position, 1]
    
    -- Clue 4: The volcanologist monitoring the Scoria cone has Fluctuating activity
    one v: Volcanologist | v.volcano = Scoriacone and v.activity = Fluctuating
    
    -- Clue 5: Lauren is in position 2
    one v: Volcanologist | v.name = Lauren and v.position = 2
    
    -- Clue 6: The scientist observing Stable activity is next to Samantha
    one v1, v2: Volcanologist | 
        v1.activity = Stable and v2.name = Samantha and 
        (v2.position = add[v1.position, 1] or v2.position = subtract[v1.position, 1])
    
    -- Clue 7: The volcanologist studying Submarine is immediately after the scientist using Yellow laptop
    one v1, v2: Volcanologist | 
        v1.laptop = Yellow and v2.volcano = Submarine and v2.position = add[v1.position, 1]
    
    -- Clue 8: The volcanologist monitoring Increasing activity is immediately after the scientist using Pink laptop
    one v1, v2: Volcanologist | 
        v1.laptop = Pink and v2.activity = Increasing and v2.position = add[v1.position, 1]
    
    -- Clue 9: Emily is immediately after the volcanologist using Purple laptop
    one v1, v2: Volcanologist | 
        v1.laptop = Purple and v2.name = Emily and v2.position = add[v1.position, 1]
    
    -- Clue 10: Lauren is immediately before Emily
    one v1, v2: Volcanologist | 
        v1.name = Lauren and v2.name = Emily and v2.position = add[v1.position, 1]
}

run {
    validPuzzle
} for exactly 4 Volcanologist

-- Predicate to display the solution nicely
pred showSolution {
    validPuzzle
}

run {
    showSolution
} for exactly 4 Volcanologist

/**

Prompt:

You are an expert at Forge, a lightweight formal methods language used in education at Brown University. It's a fork of Alloy with similarities but also differences, so be careful to use the FORGE syntax, NOT Alloy.

Generate a Forge model for the Zebra puzzle (aka Einstein puzzle) below. 

---
There are 4 volcanologists. Each volcanologist has a name, laptop color, volcano that they study, and the activity level of the volcano that they study. The possible values for each field are as follows: 

Laptop: green, pink, purple, yellow
Name: Emily, Kimberly, Lauren, Samantha
Volcano: lavadome, scoriacone, submarine, supervolcano        
Activity: fluctuating, increasing, stable, very high

Your task is to find the correct assignment of values to the 4 volcanologists in the correct order based on the following clues:

Clues:
    - The volcanologist monitoring a volcano with a Very high activity level is in the second position.
    - The scientist studying the Supervolcano is in the third position.
    - The scientist who is monitoring the Lava dome volcano is immediately after the scientist studying the Supervolcano.
    - The volcanologist who is monitoring the Scoria cone volcano is observing a Fluctuating activity level.
    - Lauren is in the second position.
    - The scientist observing a volcano with a Stable activity level is next to Samantha.
    - The volcanologist studying the Submarine volcano is immediately after the scientist using the Yellow laptop.
    - The volcanologist monitoring a volcano with an Increasing activity level is immediately after the scientist using the Pink laptop.
    - Emily is immediately after the volcanologist who is using the Purple laptop.
    - Lauren is immediately before Emily.
---

*/