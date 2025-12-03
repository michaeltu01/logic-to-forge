#lang forge/froglet

-- Entities
abstract sig Person {
  house: one Int,
  mother: one Mother,
  child: one Child,
  vacation: one Vacation,
  genre: one Genre
}

one sig Bob, Arnold, Carol, Alice, Peter, Eric extends Person {}

abstract sig Mother {}
one sig Sarah, Janelle, Aniya, Kailyn, Holly, Penny extends Mother {}

abstract sig Child {}
one sig Fred, Samantha, Bella, Meredith, AliceChild, Timothy extends Child {}

abstract sig Vacation {}
one sig City, Mountain, Camping, Beach, Cruise, Cultural extends Vacation {}

abstract sig Genre {}
one sig Romance, Mystery, HistoricalFiction, ScienceFiction, Biography, Fantasy extends Genre {}

pred validHouses {
  all p: Person | p.house >= 1 and p.house <= 6
  all disj p1, p2: Person | p1.house != p2.house
}

pred uniqueAttributes {
  all disj p1, p2: Person | {
    p1.mother != p2.mother
    p1.child != p2.child
    p1.vacation != p2.vacation
    p1.genre != p2.genre
  }
}

pred clues {
  -- 1. Beach lover not in house 2
  all p: Person | p.vacation = Beach implies p.house != 2
  
  -- 2. Fantasy lover left of Peter
  all p: Person | p.genre = Fantasy implies p.house < Peter.house
  
  -- 3. Sarah's child prefers city breaks
  all p: Person | p.mother = Sarah implies p.vacation = City
  
  -- 4. Camping lover right of Peter
  all p: Person | p.vacation = Camping implies p.house > Peter.house
  
  -- 5. Cruise lover's child is Meredith
  all p: Person | p.vacation = Cruise implies p.child = Meredith
  
  -- 6. One house between Timothy's mother and Eric
  all p: Person | p.child = Timothy implies subtract[Eric.house, p.house] = 2 or subtract[p.house, Eric.house] = 2
  
  -- 7. Janelle not in house 2
  all p: Person | p.mother = Janelle implies p.house != 2
  
  -- 8. Fred's mother left of Eric
  all p: Person | p.child = Fred implies p.house < Eric.house
  
  -- 9. Cultural tour lover in house 4
  all p: Person | p.vacation = Cultural implies p.house = 4
  
  -- 10. Janelle not in house 1
  all p: Person | p.mother = Janelle implies p.house != 1
  
  -- 11. Holly right of historical fiction lover
  all p1, p2: Person | (p1.mother = Holly and p2.genre = HistoricalFiction) implies p1.house > p2.house
  
  -- 12. Bella's mother left of Alice
  all p: Person | p.child = Bella implies p.house < Alice.house
  
  -- 13. Arnold right of fantasy lover
  all p: Person | p.genre = Fantasy implies Arnold.house > p.house
  
  -- 14. Mystery lover in house 4
  all p: Person | p.genre = Mystery implies p.house = 4
  
  -- 15. AliceChild's mother enjoys camping
  all p: Person | p.child = AliceChild implies p.vacation = Camping
  
  -- 16. Kailyn's child likes cruises
  all p: Person | p.mother = Kailyn implies p.vacation = Cruise
  
  -- 17. Two houses between fantasy lover and Aniya's child
  all p1, p2: Person | (p1.genre = Fantasy and p2.mother = Aniya) implies 
    (subtract[p2.house, p1.house] = 3 or subtract[p1.house, p2.house] = 3)
  
  -- 18. Carol loves fantasy
  Carol.genre = Fantasy
  
  -- 19. Cruise lover loves biography
  all p: Person | p.vacation = Cruise implies p.genre = Biography
  
  -- 20. Fantasy lover in house 3
  all p: Person | p.genre = Fantasy implies p.house = 3
  
  -- 21. Aniya's child loves romance
  all p: Person | p.mother = Aniya implies p.genre = Romance
  
  -- 22. Janelle not in house 4
  all p: Person | p.mother = Janelle implies p.house != 4
  
  -- 23. Fred's mother not in house 4
  all p: Person | p.child = Fred implies p.house != 4
  
  -- 24. Biography lover not in house 2
  all p: Person | p.genre = Biography implies p.house != 2
  
  -- 25. Two houses between Holly's child and Eric
  all p: Person | p.mother = Holly implies 
    (subtract[Eric.house, p.house] = 3 or subtract[p.house, Eric.house] = 3)
}

pred zebraPuzzle {
  validHouses
  uniqueAttributes
  clues
}

run {zebraPuzzle} for exactly 6 Person

/**

Prompt:

You are an expert at Forge, a lightweight formal methods language used in education at Brown University. It's a fork of Alloy with similarities but also differences, so be careful to use the FORGE syntax, NOT Alloy.

Generate a Forge model for the Zebra puzzle (aka Einstein puzzle) below. 

---
There are 6 houses, numbered 1 to 6 from left to right, as seen from across the street. Each house is occupied by a different person. Each house has a unique attribute for each of the following characteristics: - Each person has a unique name: Bob, Arnold, Carol, Alice, Peter, Eric - The mothers' names in different houses are unique: Sarah, Janelle, Aniya, Kailyn, Holly, Penny - Each mother is accompanied by their child: Fred, Samantha, Bella, Meredith, Alice, Timothy - Each person prefers a unique type of vacation: city, mountain, camping, beach, cruise, cultural - People have unique favorite book genres: romance, mystery, historical fiction, science fiction, biography, fantasy ## Clues: 1. The person who loves beach vacations is not in the second house. 2. The person who loves fantasy books is somewhere to the left of Peter. 3. The person whose mother's name is Sarah is the person who prefers city breaks. 4. The person who enjoys camping trips is somewhere to the right of Peter. 5. The person who likes going on cruises is the person's child is named Meredith. 6. There is one house between the person who is the mother of Timothy and Eric. 7. The person whose mother's name is Janelle is not in the second house. 8. The person's child is named Fred is somewhere to the left of Eric. 9. The person who goes on cultural tours is in the fourth house. 10. The person whose mother's name is Janelle is not in the first house. 11. The person whose mother's name is Holly is somewhere to the right of the person who loves historical fiction books. 12. The person's child is named Bella is somewhere to the left of Alice. 13. Arnold is somewhere to the right of the person who loves fantasy books. 14. The person who loves mystery books is in the fourth house. 15. The person's child is named Alice is the person who enjoys camping trips. 16. The person whose mother's name is Kailyn is the person who likes going on cruises. 17. There are two houses between the person who loves fantasy books and The person whose mother's name is Aniya. 18. The person who loves fantasy books is Carol. 19. The person who likes going on cruises is the person who loves biography books. 20. The person who loves fantasy books is in the third house. 21. The person whose mother's name is Aniya is the person who loves romance books. 22. The person whose mother's name is Janelle is not in the fourth house. 23. The person's child is named Fred is not in the fourth house. 24. The person who loves biography books is not in the second house. 25. There are two houses between The person whose mother's name is Holly and Eric.
---

*/