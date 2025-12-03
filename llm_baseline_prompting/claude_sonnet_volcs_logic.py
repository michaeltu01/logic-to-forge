def validate(solution: Solution) -> None:
    # Clue: The volcanologist monitoring a volcano with a Very high activity level is in the second position.
    assert solution.volcanologists[1].activity == "very high"
    
    # Clue: The scientist studying the Supervolcano is in the third position.
    assert solution.volcanologists[2].volcano == "supervolcano"
    
    # Clue: The scientist who is monitoring the Lava dome volcano is immediately after the scientist studying the Supervolcano.
    supervolcano_scientist = nondet(solution.volcanologists)
    assume(supervolcano_scientist.volcano == "supervolcano")
    lavadome_scientist = nondet(solution.volcanologists)
    assume(lavadome_scientist.volcano == "lavadome")
    assert immediatelyBefore(supervolcano_scientist, lavadome_scientist)
    
    # Clue: The volcanologist who is monitoring the Scoria cone volcano is observing a Fluctuating activity level.
    scoriacone_scientist = nondet(solution.volcanologists)
    assume(scoriacone_scientist.volcano == "scoriacone")
    assert scoriacone_scientist.activity == "fluctuating"
    
    # Clue: Lauren is in the second position.
    assert solution.volcanologists[1].name == "Lauren"
    
    # Clue: The scientist observing a volcano with a Stable activity level is next to Samantha.
    stable_scientist = nondet(solution.volcanologists)
    assume(stable_scientist.activity == "stable")
    samantha = nondet(solution.volcanologists)
    assume(samantha.name == "Samantha")
    assert immediatelyBefore(stable_scientist, samantha) or immediatelyBefore(samantha, stable_scientist)
    
    # Clue: The volcanologist studying the Submarine volcano is immediately after the scientist using the Yellow laptop.
    yellow_laptop_scientist = nondet(solution.volcanologists)
    assume(yellow_laptop_scientist.laptop == "yellow")
    submarine_scientist = nondet(solution.volcanologists)
    assume(submarine_scientist.volcano == "submarine")
    assert immediatelyBefore(yellow_laptop_scientist, submarine_scientist)
    
    # Clue: The volcanologist monitoring a volcano with an Increasing activity level is immediately after the scientist using the Pink laptop.
    pink_laptop_scientist = nondet(solution.volcanologists)
    assume(pink_laptop_scientist.laptop == "pink")
    increasing_scientist = nondet(solution.volcanologists)
    assume(increasing_scientist.activity == "increasing")
    assert immediatelyBefore(pink_laptop_scientist, increasing_scientist)
    
    # Clue: Emily is immediately after the volcanologist who is using the Purple laptop.
    purple_laptop_scientist = nondet(solution.volcanologists)
    assume(purple_laptop_scientist.laptop == "purple")
    emily = nondet(solution.volcanologists)
    assume(emily.name == "Emily")
    assert immediatelyBefore(purple_laptop_scientist, emily)
    
    # Clue: Lauren is immediately before Emily.
    lauren = nondet(solution.volcanologists)
    assume(lauren.name == "Lauren")
    emily2 = nondet(solution.volcanologists)
    assume(emily2.name == "Emily")
    assert immediatelyBefore(lauren, emily2)