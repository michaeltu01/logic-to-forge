#lang forge

open util/sequences

-- DATA STRUCTURES
        
abstract sig Laptop {}
one sig Green extends Laptop {}
one sig Pink extends Laptop {}
one sig Purple extends Laptop {}
one sig Yellow extends Laptop {}
abstract sig Name {}
one sig Emily extends Name {}
one sig Kimberly extends Name {}
one sig Lauren extends Name {}
one sig Samantha extends Name {}
abstract sig Volcano {}
one sig Lavadome extends Volcano {}
one sig Scoriacone extends Volcano {}
one sig Submarine extends Volcano {}
one sig Supervolcano extends Volcano {}
abstract sig Activity {}
one sig Fluctuating extends Activity {}
one sig Increasing extends Activity {}
one sig Stable extends Activity {}
one sig Veryhigh extends Activity {}

sig Volcanologist {
    laptop: one Laptop,
    name: one Name,
    volcano: one Volcano,
    activity: one Activity
}
one sig Solution {
    volcanologists: pfunc Int->Volcanologist
}


-- HELPER PREDICATES

pred wellformed {
    #{Solution.volcanologists} = 4
    all l: Laptop | some laptop.l
    all a: Activity | some activity.a
    all v: Volcano | some volcano.v
    all n: Name | some name.n
    all v: Volcanologist | some volcanologists.v
    isSeqOf[Solution.volcanologists, Volcanologist]
}

pred immediatelyBefore[a, b: Volcanologist] {
    Solution.volcanologists[add[(Solution.volcanologists).a, 1]] = b
}

pred somewhereBefore[a, b: Volcanologist] {
    Solution.volcanologists.a < Solution.volcanologists.b
}


-- SOLUTION CONSTRAINTS

pred solution {
    some very_high_volcanologist, supervolcano_volcanologist, lava_dome_volcanologist, scoria_cone_volcanologist, lauren_volcanologist, stable_volcanologist, samantha_volcanologist, yellow_laptop_volcanologist, submarine_volcanologist, pink_laptop_volcanologist, increasing_activity_volcanologist, purple_laptop_volcanologist, emily_volcanologist: Volcanologist | {
        // Constraint: The volcanologist monitoring a volcano with a Very high activity level is in the second position.
        very_high_volcanologist = Solution.volcanologists[1]
        very_high_volcanologist.activity = Veryhigh

        // Constraint: The scientist studying the Supervolcano is in the third position.
        supervolcano_volcanologist = Solution.volcanologists[2]
        supervolcano_volcanologist.volcano = Supervolcano

        // Constraint: The scientist who is monitoring the Lava dome volcano is immediately after the scientist studying the Supervolcano.
        lava_dome_volcanologist.volcano = Lavadome
        immediatelyBefore[supervolcano_volcanologist, lava_dome_volcanologist]

        // Constraint: The volcanologist who is monitoring the Scoria cone volcano is observing a Fluctuating activity level.
        scoria_cone_volcanologist.volcano = Scoriacone
        scoria_cone_volcanologist.activity = Fluctuating

        // Constraint: Lauren is in the second position.
        lauren_volcanologist = Solution.volcanologists[1]
        lauren_volcanologist.name = Lauren

        // Constraint: The scientist observing a volcano with a Stable activity level is next to Samantha.
        stable_volcanologist.activity = Stable
        samantha_volcanologist.name = Samantha
        immediatelyBefore[samantha_volcanologist, stable_volcanologist] or immediatelyBefore[stable_volcanologist, samantha_volcanologist]

        // Constraint: The volcanologist studying the Submarine volcano is immediately after the scientist using the Yellow laptop.
        yellow_laptop_volcanologist.laptop = Yellow
        submarine_volcanologist.volcano = Submarine
        immediatelyBefore[yellow_laptop_volcanologist, submarine_volcanologist]

        // Constraint: The volcanologist monitoring a volcano with an Increasing activity level is immediately after the scientist using the Pink laptop.
        pink_laptop_volcanologist.laptop = Pink
        increasing_activity_volcanologist.activity = Increasing
        immediatelyBefore[pink_laptop_volcanologist, increasing_activity_volcanologist]

        // Constraint: Emily is immediately after the volcanologist who is using the Purple laptop.
        purple_laptop_volcanologist.laptop = Purple
        emily_volcanologist.name = Emily
        immediatelyBefore[purple_laptop_volcanologist, emily_volcanologist]

        // Constraint: Lauren is immediately before Emily.
        immediatelyBefore[lauren_volcanologist, emily_volcanologist]
    }
}

// run { solution and wellformed }
assert { solution and wellformed } is sat
