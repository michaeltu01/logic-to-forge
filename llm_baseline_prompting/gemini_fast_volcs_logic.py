def validate(solution: Solution) -> None:
    # Clue 1: The volcanologist monitoring a volcano with a Very high activity level is in the second position.
    assert solution.volcanologists[1].activity == "very high"

    # Clue 2: The scientist studying the Supervolcano is in the third position.
    assert solution.volcanologists[2].volcano == "supervolcano"

    # Clue 3: The scientist who is monitoring the Lava dome volcano is immediately after the scientist studying the Supervolcano.
    supervolcano_scientist = solution.volcanologists[2] # Already fixed by Clue 2
    lavadome_scientist = nondet(solution.volcanologists)
    assume(lavadome_scientist.volcano == "lavadome")
    assert immediatelyBefore(supervolcano_scientist, lavadome_scientist) # Must be in position 3, so Lavadome must be in position 4.

    # Clue 4: The volcanologist who is monitoring the Scoria cone volcano is observing a Fluctuating activity level.
    scoriacone_scientist = nondet(solution.volcanologists)
    assume(scoriacone_scientist.volcano == "scoriacone")
    assert scoriacone_scientist.activity == "fluctuating"

    # Clue 5: Lauren is in the second position.
    assert solution.volcanologists[1].name == "Lauren"

    # Clue 6: The scientist observing a volcano with a Stable activity level is next to Samantha.
    stable_scientist = nondet(solution.volcanologists)
    assume(stable_scientist.activity == "stable")
    samantha_scientist = nondet(solution.volcanologists)
    assume(samantha_scientist.name == "Samantha")
    # "Next to" means immediately before or immediately after
    assert immediatelyBefore(stable_scientist, samantha_scientist) or immediatelyBefore(samantha_scientist, stable_scientist)

    # Clue 7: The volcanologist studying the Submarine volcano is immediately after the scientist using the Yellow laptop.
    yellow_laptop_scientist = nondet(solution.volcanologists)
    assume(yellow_laptop_scientist.laptop == "yellow")
    submarine_scientist = nondet(solution.volcanologists)
    assume(submarine_scientist.volcano == "submarine")
    assert immediatelyBefore(yellow_laptop_scientist, submarine_scientist)

    # Clue 8: The volcanologist monitoring a volcano with an Increasing activity level is immediately after the scientist using the Pink laptop.
    pink_laptop_scientist = nondet(solution.volcanologists)
    assume(pink_laptop_scientist.laptop == "pink")
    increasing_activity_scientist = nondet(solution.volcanologists)
    assume(increasing_activity_scientist.activity == "increasing")
    assert immediatelyBefore(pink_laptop_scientist, increasing_activity_scientist)

    # Clue 9: Emily is immediately after the volcanologist who is using the Purple laptop.
    purple_laptop_scientist = nondet(solution.volcanologists)
    assume(purple_laptop_scientist.laptop == "purple")
    emily_scientist = nondet(solution.volcanologists)
    assume(emily_scientist.name == "Emily")
    assert immediatelyBefore(purple_laptop_scientist, emily_scientist)

    # Clue 10: Lauren is immediately before Emily.
    lauren_scientist = solution.volcanologists[1] # Already fixed by Clue 5
    # emily_scientist is already defined in Clue 9
    assert immediatelyBefore(lauren_scientist, emily_scientist)