#lang forge

-- Define the signature for volcanologists
sig Volcanologist {
    name: one Name,
    laptop: one Laptop,
    volcano: one Volcano,
    activity: one Activity,
    position: one Int
}

-- Define abstract signatures for properties
abstract sig Name {}
one sig Emily, Kimberly, Lauren, Samantha extends Name {}

abstract sig Laptop {}
one sig Green, Pink, Purple, Yellow extends Laptop {}

abstract sig Volcano {}
one sig LavaDome, ScoriaCone, Submarine, Supervolcano extends Volcano {}

abstract sig Activity {}
one sig Fluctuating, Increasing, Stable, VeryHigh extends Activity {}

-- Constraints
pred puzzle {
    -- There are exactly 4 volcanologists in positions 1-4
    #{v: Volcanologist} = 4
    all v: Volcanologist | v.position >= 1 and v.position <= 4
    
    -- All positions are unique
    all disj v1, v2: Volcanologist | v1.position != v2.position
    
    -- All names are unique
    all disj v1, v2: Volcanologist | v1.name != v2.name
    
    -- All laptops are unique
    all disj v1, v2: Volcanologist | v1.laptop != v2.laptop
    
    -- All volcanoes are unique
    all disj v1, v2: Volcanologist | v1.volcano != v2.volcano
    
    -- All activities are unique
    all disj v1, v2: Volcanologist | v1.activity != v2.activity
    
    -- Clue 1: The volcanologist monitoring VeryHigh activity is in position 2
    (one v: Volcanologist | v.activity = VeryHigh) => 
        (one v: Volcanologist | v.activity = VeryHigh and v.position = 2)
    
    -- Clue 2: Supervolcano is in position 3
    (one v: Volcanologist | v.volcano = Supervolcano) =>
        (one v: Volcanologist | v.volcano = Supervolcano and v.position = 3)
    
    -- Clue 3: LavaDome is immediately after Supervolcano (position 4)
    (one v: Volcanologist | v.volcano = Supervolcano) =>
        (one v: Volcanologist | v.volcano = LavaDome and v.position = 4)
    
    -- Clue 4: ScoriaCone has Fluctuating activity
    (one v: Volcanologist | v.volcano = ScoriaCone) =>
        (one v: Volcanologist | v.volcano = ScoriaCone and v.activity = Fluctuating)
    
    -- Clue 5: Lauren is in position 2
    (one v: Volcanologist | v.name = Lauren) =>
        (one v: Volcanologist | v.name = Lauren and v.position = 2)
    
    -- Clue 6: Stable activity is next to Samantha
    (one v: Volcanologist | v.activity = Stable) => {
        (one v: Volcanologist | v.activity = Stable and 
            (one s: Volcanologist | s.name = Samantha and 
                (v.position = s.position + 1 or v.position = s.position - 1)))
    }
    
    -- Clue 7: Submarine is immediately after Yellow laptop
    (one v: Volcanologist | v.laptop = Yellow) => {
        (one v: Volcanologist | v.laptop = Yellow and
            (one s: Volcanologist | s.volcano = Submarine and s.position = v.position + 1))
    }
    
    -- Clue 8: Increasing activity is immediately after Pink laptop
    (one v: Volcanologist | v.laptop = Pink) => {
        (one v: Volcanologist | v.laptop = Pink and
            (one s: Volcanologist | s.activity = Increasing and s.position = v.position + 1))
    }
    
    -- Clue 9: Emily is immediately after Purple laptop
    (one v: Volcanologist | v.name = Emily) => {
        (one v: Volcanologist | v.name = Emily and
            (one s: Volcanologist | s.laptop = Purple and s.position = v.position - 1))
    }
    
    -- Clue 10: Lauren is immediately before Emily
    (one v: Volcanologist | v.name = Lauren and one e: Volcanologist | e.name = Emily) =>
        (one v: Volcanologist | v.name = Lauren and
            (one e: Volcanologist | e.name = Emily and e.position = v.position + 1))
}

run puzzle