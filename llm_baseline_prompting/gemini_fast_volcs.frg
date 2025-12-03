// --- Signatures (Data Types) ---

// Define the 4 discrete positions for the volcanologists.
// The `enum` keyword ensures these are ordered and distinct.
enum Pos { Pos1, Pos2, Pos3, Pos4 }

// Define the sets for each property (Volcanologist attributes)
sig Name {}
one sig Emily, Kimberly, Lauren, Samantha extends Name {}

sig Laptop {}
one sig green, pink, purple, yellow extends Laptop {}

sig Volcano {}
one sig lavadome, scoriacone, submarine, supervolcano extends Volcano {}

sig Activity {}
one sig fluctuating, increasing, stable, veryhigh extends Activity {}

// --- Volcanologist Signature (The Core Model) ---

// Define a Volcanologist as a position, with a unique Name, Laptop, Volcano, and Activity.
// The fields below define the relationships. Since 'one' is not used, it defaults to a set of relationships.
sig Volcanologist {
    name: Name,
    laptop: Laptop,
    volcano: Volcano,
    activity: Activity
}

// Map the four positions to the four Volcanologists. This defines the ordering.
// `one` ensures exactly one Volcanologist is at each position.
fact PositionMap {
    Pos -> one Volcanologist
}

// --- Universal Constraints (Ensuring the Puzzle Structure) ---

// 1. Each property must be unique across all 4 Volcanologists.
// (I.e., no two volcanologists have the same name, laptop, etc.)
fact Uniqueness {
    all v1, v2 : Volcanologist | v1 != v2 => {
        v1.name != v2.name
        v1.laptop != v2.laptop
        v1.volcano != v2.volcano
        v1.activity != v2.activity
    }
}

// 2. Ensure every single defined value is used exactly once.
fact Totality {
    Name = Volcanologist.name and
    Laptop = Volcanologist.laptop and
    Volcano = Volcanologist.volcano and
    Activity = Volcanologist.activity
}

// --- Utility Functions for Ordering ---

// Function to get the Volcanologist at a specific position.
fun vol_at (p: Pos): Volcanologist {
    p.(PositionMap)
}

// Function to check if position 'p2' is immediately after position 'p1'.
fun is_immediately_after (p1, p2: Pos): bool {
    p1 = Pos1 && p2 = Pos2 or
    p1 = Pos2 && p2 = Pos3 or
    p1 = Pos3 && p2 = Pos4
}

// --- Puzzle Clues (The Logic) ---

// Clue 1: The volcanologist monitoring a volcano with a Very high activity level is in the second position.
fact Clue1 {
    vol_at(Pos2).activity = veryhigh
}

// Clue 2: The scientist studying the Supervolcano is in the third position.
fact Clue2 {
    vol_at(Pos3).volcano = supervolcano
}

// Clue 3: The scientist who is monitoring the Lava dome volcano is immediately after the scientist studying the Supervolcano.
fact Clue3 {
    // Supervolcano is at Pos3 (from Clue 2). The position after Pos3 is Pos4.
    vol_at(Pos4).volcano = lavadome
}

// Clue 4: The volcanologist who is monitoring the Scoria cone volcano is observing a Fluctuating activity level.
fact Clue4 {
    some v: Volcanologist |
        v.volcano = scoriacone and v.activity = fluctuating
}

// Clue 5: Lauren is in the second position.
fact Clue5 {
    vol_at(Pos2).name = Lauren
}

// Clue 6: The scientist observing a volcano with a Stable activity level is next to Samantha.
// This means Stable is immediately before or immediately after Samantha.
fact Clue6 {
    some p_s: Pos, p_st: Pos |
        vol_at(p_s).name = Samantha and vol_at(p_st).activity = stable and (
            is_immediately_after(p_s, p_st) or is_immediately_after(p_st, p_s)
        )
}

// Clue 7: The volcanologist studying the Submarine volcano is immediately after the scientist using the Yellow laptop.
fact Clue7 {
    some p_y: Pos, p_sub: Pos |
        vol_at(p_y).laptop = yellow and vol_at(p_sub).volcano = submarine and
        is_immediately_after(p_y, p_sub)
}

// Clue 8: The volcanologist monitoring a volcano with an Increasing activity level is immediately after the scientist using the Pink laptop.
fact Clue8 {
    some p_p: Pos, p_inc: Pos |
        vol_at(p_p).laptop = pink and vol_at(p_inc).activity = increasing and
        is_immediately_after(p_p, p_inc)
}

// Clue 9: Emily is immediately after the volcanologist who is using the Purple laptop.
fact Clue9 {
    some p_pur: Pos, p_e: Pos |
        vol_at(p_pur).laptop = purple and vol_at(p_e).name = Emily and
        is_immediately_after(p_pur, p_e)
}

// Clue 10: Lauren is immediately before Emily.
fact Clue10 {
    some p_l: Pos, p_e: Pos |
        vol_at(p_l).name = Lauren and vol_at(p_e).name = Emily and
        is_immediately_after(p_l, p_e)
}

// --- Run Command ---

// Instruct Forge to find a solution (an instance that satisfies all facts).
// Since the exact count of Volcanologists is 4, we don't need to specify a scope
// for the main signatures, but we ensure all values are used.
// The solver will find the assignment of attributes to the Volcanologist at each position.
run {}