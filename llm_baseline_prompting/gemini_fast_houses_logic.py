def validate(solution: Solution) -> None:
    # --- Constraint Helper Functions (Provided by the Solver) ---
    # immediatelyBefore(a, b): asserts that a is immediately before b (position_a + 1 == position_b)
    # somewhereBefore(a, b): asserts that a is somewhere before b (position_a < position_b)
    # nondet(collection): selects an element from the collection

    # --- Utility Definitions ---
    # Helper to find houses based on their attributes
    def find_house_by_attr(attr_name, attr_value):
        house = nondet(solution.houses)
        assume(getattr(house, attr_name) == attr_value)
        return house

    # --- Clues 1-25 (Asserting relationships based on puzzle rules) ---

    # 1. The person who loves beach vacations is not in the second house.
    beach_house = find_house_by_attr("vacation", "beach")
    assert beach_house.position != 2

    # 2. The person who loves fantasy books is somewhere to the left of Peter.
    fantasy_house = find_house_by_attr("bookGenre", "fantasy")
    peter_house = find_house_by_attr("personName", "Peter")
    assert somewhereBefore(fantasy_house, peter_house)

    # 3. The person whose mother's name is Sarah is the person who prefers city breaks.
    sarah_house = find_house_by_attr("motherName", "Sarah")
    assert sarah_house.vacation == "city"

    # 4. The person who enjoys camping trips is somewhere to the right of Peter.
    camping_house = find_house_by_attr("vacation", "camping")
    assert somewhereBefore(peter_house, camping_house)

    # 5. The person who likes going on cruises is the person's child is named Meredith.
    cruise_house = find_house_by_attr("vacation", "cruise")
    assert cruise_house.childName == "Meredith"

    # 6. There is one house between the person who is the mother of Timothy and Eric.
    timothy_house = find_house_by_attr("childName", "Timothy")
    eric_house = find_house_by_attr("personName", "Eric")
    assert abs(timothy_house.position - eric_house.position) == 2

    # 7. The person whose mother's name is Janelle is not in the second house.
    janelle_house = find_house_by_attr("motherName", "Janelle")
    assert janelle_house.position != 2

    # 8. The person's child is named Fred is somewhere to the left of Eric.
    fred_house = find_house_by_attr("childName", "Fred")
    assert somewhereBefore(fred_house, eric_house)

    # 9. The person who goes on cultural tours is in the fourth house.
    cultural_house = find_house_by_attr("vacation", "cultural")
    assert cultural_house.position == 4

    # 10. The person whose mother's name is Janelle is not in the first house.
    assert janelle_house.position != 1 # Use existing janelle_house variable

    # 11. The person whose mother's name is Holly is somewhere to the right of the person who loves historical fiction books.
    holly_house = find_house_by_attr("motherName", "Holly")
    hist_fic_house = find_house_by_attr("bookGenre", "historical fiction")
    assert somewhereBefore(hist_fic_house, holly_house)

    # 12. The person's child is named Bella is somewhere to the left of Alice.
    bella_house = find_house_by_attr("childName", "Bella")
    alice_person_house = find_house_by_attr("personName", "Alice")
    assert somewhereBefore(bella_house, alice_person_house)

    # 13. Arnold is somewhere to the right of the person who loves fantasy books.
    arnold_house = find_house_by_attr("personName", "Arnold")
    assert somewhereBefore(fantasy_house, arnold_house) # Use existing fantasy_house variable

    # 14. The person who loves mystery books is in the fourth house.
    mystery_house = find_house_by_attr("bookGenre", "mystery")
    assert mystery_house.position == 4

    # 15. The person's child is named Alice is the person who enjoys camping trips.
    alice_child_house = find_house_by_attr("childName", "Alice")
    assert alice_child_house.vacation == "camping"

    # 16. The person whose mother's name is Kailyn is the person who likes going on cruises.
    kailyn_house = find_house_by_attr("motherName", "Kailyn")
    assert kailyn_house.vacation == "cruise"

    # 17. There are two houses between the person who loves fantasy books and The person whose mother's name is Aniya.
    aniya_house = find_house_by_attr("motherName", "Aniya")
    assert abs(fantasy_house.position - aniya_house.position) == 3 # Use existing fantasy_house variable

    # 18. The person who loves fantasy books is Carol.
    assert fantasy_house.personName == "Carol" # Use existing fantasy_house variable

    # 19. The person who likes going on cruises is the person who loves biography books.
    biography_house = find_house_by_attr("bookGenre", "biography")
    assert biography_house.vacation == "cruise"

    # 20. The person who loves fantasy books is in the third house.
    assert fantasy_house.position == 3 # Use existing fantasy_house variable

    # 21. The person whose mother's name is Aniya is the person who loves romance books.
    romance_house = find_house_by_attr("bookGenre", "romance")
    assert aniya_house.bookGenre == "romance" # Use existing aniya_house variable

    # 22. The person whose mother's name is Janelle is not in the fourth house.
    assert janelle_house.position != 4 # Use existing janelle_house variable

    # 23. The person's child is named Fred is not in the fourth house.
    assert fred_house.position != 4 # Use existing fred_house variable

    # 24. The person who loves biography books is not in the second house.
    assert biography_house.position != 2 # Use existing biography_house variable

    # 25. There are two houses between The person whose mother's name is Holly and Eric.
    assert abs(holly_house.position - eric_house.position) == 3 # Use existing holly_house and eric_house variables

    # --- Inferred Constraints from House Position Clues ---
    # From Clue 9 and 14:
    assert cultural_house.position == mystery_house.position # Both are in House 4
    assert cultural_house.vacation == "cultural"
    assert mystery_house.bookGenre == "mystery"

    # From Clue 5, 16, and 19 (The Cruise House):
    assert cruise_house.childName == "Meredith"
    assert cruise_house.motherName == "Kailyn"
    assert cruise_house.bookGenre == "biography"