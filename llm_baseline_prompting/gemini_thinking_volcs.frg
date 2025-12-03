#lang forge

/* Data Types (Signatures) */
abstract sig Name {}
one sig N_Bob, N_Arnold, N_Carol, N_Alice, N_Peter, N_Eric extends Name {}

abstract sig Mother {}
one sig M_Sarah, M_Janelle, M_Aniya, M_Kailyn, M_Holly, M_Penny extends Mother {}

abstract sig Child {}
one sig C_Fred, C_Samantha, C_Bella, C_Meredith, C_Alice, C_Timothy extends Child {}

abstract sig Vacation {}
one sig V_City, V_Mountain, V_Camping, V_Beach, V_Cruise, V_Cultural extends Vacation {}

abstract sig Book {}
one sig B_Romance, B_Mystery, B_Historical, B_SciFi, B_Biography, B_Fantasy extends Book {}

/* The House Object */
sig House {
    id: one Int,
    name: one Name,
    mother: one Mother,
    child: one Child,
    vacation: one Vacation,
    book: one Book
}

/* Helper Predicates */

pred leftOf[h1: House, h2: House] {
    h1.id < h2.id
}

pred rightOf[h1: House, h2: House] {
    h1.id > h2.id
}

// Exactly n houses BETWEEN h1 and h2. 
// Distance must be n + 1. 
// We use manual OR logic instead of 'abs' to ensure compatibility.
pred housesBetween[h1: House, h2: House, n: Int] {
    subtract[h1.id, h2.id] = add[n, 1] 
    or 
    subtract[h2.id, h1.id] = add[n, 1]
}

/* Main Constraint Predicate */
pred zebraPuzzle {
    // 1. Structural Constraints
    #House = 6
    
    // Indices are 1 through 6
    House.id = {i: Int | i >= 1 and i <= 6}
    
    // Bijectivity: No two houses share the same attribute
    all n: Name     | one h: House | h.name = n
    all m: Mother   | one h: House | h.mother = m
    all c: Child    | one h: House | h.child = c
    all v: Vacation | one h: House | h.vacation = v
    all b: Book     | one h: House | h.book = b
    
    // Ensure IDs are unique per house (Fixed the parsing error here)
    all h1, h2: House | h1 != h2 implies h1.id != h2.id

    // 2. The Puzzle Clues
    
    // 1. The person who loves beach vacations is not in the second house.
    all h: House | h.vacation = V_Beach implies h.id != 2

    // 2. The person who loves fantasy books is somewhere to the left of Peter.
    all h1, h2: House | (h1.book = B_Fantasy and h2.name = N_Peter) implies leftOf[h1, h2]

    // 3. The person whose mother's name is Sarah is the person who prefers city breaks.
    all h: House | h.mother = M_Sarah iff h.vacation = V_City

    // 4. The person who enjoys camping trips is somewhere to the right of Peter.
    all h1, h2: House | (h1.vacation = V_Camping and h2.name = N_Peter) implies rightOf[h1, h2]

    // 5. The person who likes going on cruises is the person's child is named Meredith.
    all h: House | h.vacation = V_Cruise iff h.child = C_Meredith

    // 6. There is one house between the person who is the mother of Timothy and Eric.
    all h1, h2: House | (h1.child = C_Timothy and h2.name = N_Eric) implies housesBetween[h1, h2, 1]

    // 7. The person whose mother's name is Janelle is not in the second house.
    all h: House | h.mother = M_Janelle implies h.id != 2

    // 8. The person's child is named Fred is somewhere to the left of Eric.
    all h1, h2: House | (h1.child = C_Fred and h2.name = N_Eric) implies leftOf[h1, h2]

    // 9. The person who goes on cultural tours is in the fourth house.
    all h: House | h.vacation = V_Cultural implies h.id = 4

    // 10. The person whose mother's name is Janelle is not in the first house.
    all h: House | h.mother = M_Janelle implies h.id != 1

    // 11. The person whose mother's name is Holly is somewhere to the right of the person who loves historical fiction books.
    all h1, h2: House | (h1.mother = M_Holly and h2.book = B_Historical) implies rightOf[h1, h2]

    // 12. The person's child is named Bella is somewhere to the left of Alice.
    all h1, h2: House | (h1.child = C_Bella and h2.name = N_Alice) implies leftOf[h1, h2]

    // 13. Arnold is somewhere to the right of the person who loves fantasy books.
    all h1, h2: House | (h1.name = N_Arnold and h2.book = B_Fantasy) implies rightOf[h1, h2]

    // 14. The person who loves mystery books is in the fourth house.
    all h: House | h.book = B_Mystery implies h.id = 4

    // 15. The person's child is named Alice is the person who enjoys camping trips.
    all h: House | h.child = C_Alice iff h.vacation = V_Camping

    // 16. The person whose mother's name is Kailyn is the person who likes going on cruises.
    all h: House | h.mother = M_Kailyn iff h.vacation = V_Cruise

    // 17. There are two houses between the person who loves fantasy books and The person whose mother's name is Aniya.
    all h1, h2: House | (h1.book = B_Fantasy and h2.mother = M_Aniya) implies housesBetween[h1, h2, 2]

    // 18. The person who loves fantasy books is Carol.
    all h: House | h.book = B_Fantasy iff h.name = N_Carol

    // 19. The person who likes going on cruises is the person who loves biography books.
    all h: House | h.vacation = V_Cruise iff h.book = B_Biography

    // 20. The person who loves fantasy books is in the third house.
    all h: House | h.book = B_Fantasy implies h.id = 3

    // 21. The person whose mother's name is Aniya is the person who loves romance books.
    all h: House | h.mother = M_Aniya iff h.book = B_Romance

    // 22. The person whose mother's name is Janelle is not in the fourth house.
    all h: House | h.mother = M_Janelle implies h.id != 4

    // 23. The person's child is named Fred is not in the fourth house.
    all h: House | h.child = C_Fred implies h.id != 4

    // 24. The person who loves biography books is not in the second house.
    all h: House | h.book = B_Biography implies h.id != 2

    // 25. There are two houses between The person whose mother's name is Holly and Eric.
    all h1, h2: House | (h1.mother = M_Holly and h2.name = N_Eric) implies housesBetween[h1, h2, 2]
}

/* Execution */
run zebraPuzzle for exactly 6 House, 4 Int