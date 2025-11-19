# logic-to-forge
An LLM-backed agent that converts natural language to Forge using an intermediate representation in Python.

Currently in the process of migrating to this repository. View the current working repository [here](https://github.com/michaeltu01/polymath).

## Architecture
### 1. Natural Language -> Solution Format
The first step is to prompt the LLM to generate the solution format of the given [Zebra Logic Puzzle](https://www.puzzles.wiki/wiki/Zebra_Puzzle). This is the template in which the instance produce by the Forge model will be transformed into.
### 2. Natural Language -> Logic.py
The second step is to convert the puzzle's natural language to an intermediary representation in Python. The primitives in this intermediate representation are largely inspired by the original research paper. These primitives are expressed to the LLM as rules in a prompt. The LLM can then construct a Python program that abides by these rules.
### 3. Logic.py -> Forge
Through static analysis of the Python program's concrete syntax tree (CST), a Forge model is constructed.
### 4. Forge -> Solution
The Forge model is then run by the Forge solver. An instance is retrieved from the solver. If an instance cannot be retrieved (i.e. the constraints are unsatisfiable), the LLM will be prompted to retry generating the constraints for the puzzle to resolve the conflicting constraints. The LLM is then tasked to convert the instance into the solution format it generated at the start of the pipeline.
