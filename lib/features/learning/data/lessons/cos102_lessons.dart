// lib/features/learning/data/lessons/cos102_lessons.dart
// COS 102 — Introduction to Problem Solving

Map<String, dynamic> getCOS102LessonData(String lessonId) {
  switch (lessonId) {
    case 'cos102_u1_1':
      return {
        'content': '''# Problem Solving Basics

## What is a Problem?

A **problem** exists when there is a gap between a current state and a desired goal state, and the path between them is not immediately obvious.

Every problem has:
- **Initial state** — where you are now
- **Goal state** — where you want to be
- **Operators** — actions that can change the state
- **Constraints** — limits on what you can do

## Types of Problems

**Well-defined problems** have a clear initial state, goal state, and operators.
Example: Sorting a list of numbers.

**Ill-defined problems** have vague goals, unclear starting conditions, or ambiguous rules.
Example: "Make this company more innovative."

## Pólya's Four-Step Framework

1. **Understand the Problem** — identify given data, unknowns, and conditions
2. **Devise a Plan** — select a strategy
3. **Carry Out the Plan** — execute carefully
4. **Look Back** — verify, check efficiency, reflect

## Problem Statement

A good problem statement includes:
✓ Current state (what is wrong and why)
✓ Goal state (measurable success criteria)
✓ Stakeholders affected
✓ Constraints and scope''',
        'questions': [
          {
            'question': 'Which element is NOT part of a problem\'s structure?',
            'options': ['Initial state', 'Goal state', 'Programming language', 'Operators'],
            'correct': 2,
          },
          {
            'question': 'Pólya\'s \'Look Back\' step involves:',
            'options': ['Re-reading the problem', 'Verifying the solution and reflecting on what was learned', 'Choosing a strategy', 'Identifying the unknowns'],
            'correct': 1,
          },
          {
            'question': 'An ill-defined problem is one where:',
            'options': ['The algorithm is unknown', 'The goal, initial state, or operators are not fully specified', 'The solution takes too long', 'No computer can solve it'],
            'correct': 1,
          },
          {
            'question': 'A strong problem statement must include:',
            'options': ['A list of all possible solutions', 'Measurable goal state, current state, and constraints', 'The programmer\'s name', 'The hardware specification'],
            'correct': 1,
          },
          {
            'question': 'Pólya\'s \'Devise a Plan\' step involves:',
            'options': ['Checking the answer', 'Selecting a strategy for solving the problem', 'Writing code', 'Collecting data'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u1_2':
      return {
        'content': '''# Information & Algorithms

## Data vs Information

**Data** = raw facts with no inherent meaning. Example: 37
**Information** = data processed to be meaningful. Example: "37°C — fever"

## Properties of an Algorithm

| Property | Meaning |
|---|---|
| Input | Zero or more values supplied |
| Output | At least one result produced |
| Definiteness | Each step precisely defined |
| Effectiveness | Each step is basic/executable |
| Finiteness | Terminates after finite steps |

## Algorithm vs Program

An algorithm is language-independent and for human understanding.
A program is expressed in a specific language for computer execution.

## Expressing Algorithms

1. Natural language — simple but ambiguous
2. Pseudocode — structured informal text
3. Flowchart — visual diagram with standard shapes''',
        'questions': [
          {
            'question': 'Which algorithm property means it must eventually stop?',
            'options': ['Definiteness', 'Effectiveness', 'Finiteness', 'Input'],
            'correct': 2,
          },
          {
            'question': 'Data differs from information in that information:',
            'options': ['Is always numerical', 'Is data that has been processed to be meaningful', 'Cannot be stored on a computer', 'Is always textual'],
            'correct': 1,
          },
          {
            'question': 'An algorithm that could run forever violates:',
            'options': ['Definiteness', 'Effectiveness', 'Finiteness', 'Input'],
            'correct': 2,
          },
          {
            'question': 'Which is NOT a valid way to express an algorithm?',
            'options': ['Pseudocode', 'Flowchart', 'Natural language', 'Machine code only'],
            'correct': 3,
          },
          {
            'question': 'Effectiveness as an algorithm property means:',
            'options': ['The algorithm is fast', 'Each step is basic enough to be carried out', 'The algorithm uses minimum memory', 'The algorithm always produces the optimal result'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u1_3':
      return {
        'content': '''# Computational Thinking

## Definition

Computational thinking is a problem-solving mindset drawing on concepts from computing — applicable in any field.

## The Four Pillars

**Decomposition**: Breaking complex problems into smaller sub-problems.
Example: Student portal = authentication + registration + grades + payments.

**Pattern Recognition**: Identifying similarities across problems.
Example: Sorting names and numbers use the same comparison logic.

**Abstraction**: Focusing on essentials, ignoring irrelevant detail.
Example: The London Underground map removes geography but keeps connections.

**Algorithmic Thinking**: Developing step-by-step repeatable solutions.
Example: Writing exact steps to calculate GPA for any number of courses.

## Why It Matters

✓ Applicable in every field
✓ Enables problem solving before knowing how to code
✓ Makes complex problems manageable
✓ Produces automatable solutions''',
        'questions': [
          {
            'question': 'Decomposition means:',
            'options': ['Deleting unnecessary code', 'Breaking a complex problem into smaller sub-problems', 'Identifying patterns', 'Writing step-by-step instructions'],
            'correct': 1,
          },
          {
            'question': 'The London Underground map is an example of:',
            'options': ['Pattern recognition', 'Abstraction — retaining essential structure while removing irrelevant detail', 'Decomposition', 'Algorithmic thinking'],
            'correct': 1,
          },
          {
            'question': 'Noticing sorting names and numbers use the same logic is:',
            'options': ['Abstraction', 'Decomposition', 'Pattern recognition', 'Algorithmic thinking'],
            'correct': 2,
          },
          {
            'question': 'Computational thinking is:',
            'options': ['Only for programmers', 'A problem-solving mindset applicable across many fields', 'The same as programming', 'Only for mathematicians'],
            'correct': 1,
          },
          {
            'question': 'Hiding implementation details behind a function name is:',
            'options': ['Decomposition', 'Pattern recognition', 'Abstraction', 'Algorithmic thinking'],
            'correct': 2,
          },
        ]
      };

    case 'cos102_u2_1':
      return {
        'content': '''# Decidability & Turing

## Alan Turing

Alan Turing (1912–1954) invented the Turing machine — a theoretical model that defines the limits of computation.

**Church-Turing Thesis**: Any problem that can be algorithmically solved can be solved by a Turing machine.

## Decidable vs Undecidable

**Decidable**: An algorithm exists that always gives correct YES/NO and terminates.
Example: "Is this number prime?"

**Undecidable**: No algorithm can always give the correct answer for all inputs.
Example: The Halting Problem.

## The Halting Problem

**Question**: Can we write program H that determines whether any program P halts or loops forever on input I?

**Turing's proof (1936)**: No. Using proof by contradiction — if H existed, you could construct a program that contradicts H's own output.

**Significance**: There are inherent limits to what computers can compute.''',
        'questions': [
          {
            'question': 'The Halting Problem asks:',
            'options': ['How long a program takes to run', 'Whether a given program will halt or loop forever on a given input', 'How many steps an algorithm uses', 'Whether a program is correct'],
            'correct': 1,
          },
          {
            'question': 'Turing proved the Halting Problem is undecidable using:',
            'options': ['Mathematical induction', 'Proof by contradiction', 'Big O notation', 'Empirical testing'],
            'correct': 1,
          },
          {
            'question': 'The Church-Turing Thesis states:',
            'options': ['All programs eventually terminate', 'Any algorithmically solvable problem can be solved by a Turing machine', 'Computers are faster than humans', 'All decidable problems run in polynomial time'],
            'correct': 1,
          },
          {
            'question': 'A decidable problem is one that:',
            'options': ['Requires exponential time', 'Has an algorithm that always terminates with a correct yes/no answer', 'Can only be solved by supercomputers', 'Has no known solution'],
            'correct': 1,
          },
          {
            'question': 'Which is an example of an undecidable problem?',
            'options': ['Sorting a list', 'Finding the shortest path', 'The Halting Problem', 'Searching a database'],
            'correct': 2,
          },
        ]
      };

    case 'cos102_u2_2':
      return {
        'content': '''# Complexity & Big O Notation

## Big O Notation

Describes how algorithm resource usage grows with input size n.

| Notation | Name | Example |
|---|---|---|
| O(1) | Constant | Array lookup |
| O(log n) | Logarithmic | Binary search |
| O(n) | Linear | Linear search |
| O(n log n) | Linearithmic | Merge sort |
| O(n²) | Quadratic | Bubble sort |
| O(2ⁿ) | Exponential | Brute-force TSP |

## Tractable vs Intractable

**Tractable**: Has a polynomial-time solution. Practically solvable.
**Intractable**: No polynomial solution known.

## P and NP

**P**: Problems solvable in polynomial time.
**NP**: Problems whose solutions can be *verified* in polynomial time.

**P vs NP**: The most important unsolved question in computer science — can every quickly-verifiable problem also be quickly solved?''',
        'questions': [
          {
            'question': 'O(n²) means the algorithm\'s time grows:',
            'options': ['Linearly', 'Proportional to the square of input size', 'Logarithmically', 'Exponentially'],
            'correct': 1,
          },
          {
            'question': 'Which time complexity is most efficient for large n?',
            'options': ['O(n²)', 'O(n log n)', 'O(log n)', 'O(2ⁿ)'],
            'correct': 2,
          },
          {
            'question': 'Binary search has time complexity:',
            'options': ['O(n)', 'O(n²)', 'O(log n)', 'O(1)'],
            'correct': 2,
          },
          {
            'question': 'A tractable problem has a:',
            'options': ['Constant time solution', 'Polynomial-time solution', 'Logarithmic space solution', 'Exponential time solution'],
            'correct': 1,
          },
          {
            'question': 'NP problems are those whose solutions can be:',
            'options': ['Found instantly', 'Verified in polynomial time', 'Never verified', 'Found in logarithmic time'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u2_3':
      return {
        'content': '''# Heuristics & Algorithm Properties

## What is a Heuristic?

A heuristic is a practical strategy that finds a good-enough solution without guaranteeing the optimal one. Used when exact algorithms are too slow.

## Common Heuristic Strategies

**Greedy**: Make the locally best choice at each step.
**Genetic algorithms**: Evolve solutions over generations.
**Simulated annealing**: Accept worse solutions occasionally to escape local optima.
**Ant colony optimisation**: Agents reinforce good paths with virtual pheromones.

## Correctness vs Optimality

**Correct**: Always produces a valid answer.
**Optimal**: Always produces the best possible answer.

A heuristic may be correct without being optimal.

## Space Complexity

Big O also measures memory usage:
- O(1) — constant space
- O(n) — grows with input''',
        'questions': [
          {
            'question': 'A heuristic differs from an exact algorithm because it:',
            'options': ['Always finds the optimal solution', 'Finds a good-enough solution without guaranteeing the best', 'Runs in exponential time', 'Only works on sorted data'],
            'correct': 1,
          },
          {
            'question': 'Simulated annealing occasionally accepts worse solutions to:',
            'options': ['Slow the search', 'Escape local optima and find better global solutions', 'Reduce memory', 'Match evolution'],
            'correct': 1,
          },
          {
            'question': 'The greedy approach makes:',
            'options': ['Random choices', 'The locally best choice at each step', 'The globally optimal choice always', 'Choices based on future states'],
            'correct': 1,
          },
          {
            'question': 'Ant colony optimisation is inspired by:',
            'options': ['Human problem solving', 'Ants depositing pheromones to reinforce optimal paths', 'Metal cooling', 'Genetic mutation'],
            'correct': 1,
          },
          {
            'question': 'Space complexity refers to:',
            'options': ['Physical storage hardware', 'How memory usage grows with input size', 'Number of variables declared', 'Size of the output'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u3_1':
      return {
        'content': '''# Abstraction & Analogy

## Abstraction

Stripping away unnecessary detail to focus on what matters.

**Data abstraction**: Represent complex data simply.
**Procedural abstraction**: Hide implementation inside a function.
**Problem abstraction**: Reveal underlying mathematical structure.

## Risk of Over-Abstraction

Removing essential details leads to incorrect solutions.
Example: Abstracting "temperature" to "above/below 37°C" loses the severity of 41°C.

## Analogy

Solving a new problem by mapping it to a previously solved one.

- **Source domain**: well-understood problem with known solution
- **Target domain**: new problem to solve
- **Mapping**: correspondence between both

## Examples

| Target | Analogy | Insight |
|---|---|---|
| Floyd's cycle detection | Fast/slow runner on circular track | Fast catches slow in a cycle |
| Memory hierarchy | Desk, filing cabinet, library | Frequently used items closest |

## False Analogy

A false analogy applies a source solution where the mapping doesn't hold — leads to wrong results.''',
        'questions': [
          {
            'question': 'Abstraction in problem solving means:',
            'options': ['Adding more detail', 'Focusing on essential information and ignoring irrelevant detail', 'Using metaphors', 'Writing abstract code'],
            'correct': 1,
          },
          {
            'question': 'Over-abstraction is dangerous because:',
            'options': ['It makes the problem harder', 'It may remove details essential to the correct solution', 'It speeds up the algorithm', 'It creates too many variables'],
            'correct': 1,
          },
          {
            'question': 'Floyd\'s cycle detection uses analogy by:',
            'options': ['Comparing cycles to loops', 'Modelling as a fast/slow runner on a circular track', 'Reducing to a graph problem', 'Using binary search'],
            'correct': 1,
          },
          {
            'question': 'A false analogy occurs when:',
            'options': ['The source has no solution', 'The structural correspondence between source and target breaks down', 'The analogy is too simple', 'The target is unsolvable'],
            'correct': 1,
          },
          {
            'question': 'Hiding implementation details behind a function name is:',
            'options': ['Data abstraction', 'Procedural abstraction', 'Problem abstraction', 'Pattern recognition'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u3_2':
      return {
        'content': '''# Brainstorming & Trial and Error

## Brainstorming (Osborn, 1953)

Four rules:
1. **Defer judgment** — no criticism during idea generation
2. **Quantity over quality** — generate as many ideas as possible
3. **Free-wheeling** — wild ideas welcome
4. **Build on others** — combine and improve

## Variants

**Brainwriting**: Write ideas silently, pass around.
**Mind mapping**: Ideas radiate from a central concept.
**SCAMPER**: Substitute, Combine, Adapt, Modify, Put to other uses, Eliminate, Reverse.
**Reverse brainstorming**: "How could I cause this problem?" then reverse answers.

## Trial and Error

**Random**: No record, may repeat failures, inefficient.
**Systematic**: Tracks attempts, each failure eliminates options, converges efficiently.

Scientific method = structured trial and error with controlled variables and falsifiable hypotheses.

## Confounding Variables

When two factors change simultaneously, you cannot isolate the cause. Always change one variable at a time.''',
        'questions': [
          {
            'question': 'Osborn\'s first rule of brainstorming is:',
            'options': ['Evaluate each idea immediately', 'Defer all judgment during idea generation', 'Work alone', 'Focus only on practical ideas'],
            'correct': 1,
          },
          {
            'question': 'Systematic trial and error is better than random because:',
            'options': ['It always finds optimal solutions', 'Each failure eliminates possibilities, preventing repeated attempts', 'It requires less time', 'It needs no problem statement'],
            'correct': 1,
          },
          {
            'question': 'A confounding variable is dangerous because:',
            'options': ['It makes results too accurate', 'Two factors change simultaneously, making it impossible to isolate the cause', 'It reduces test cases', 'It introduces randomness'],
            'correct': 1,
          },
          {
            'question': 'SCAMPER is a brainstorming tool that uses:',
            'options': ['Random word association', 'Structured prompts to modify existing ideas in different ways', 'Visual mind maps only', 'Competitive ranking'],
            'correct': 1,
          },
          {
            'question': 'Reverse brainstorming involves:',
            'options': ['Brainstorming individually', 'Asking how to cause the problem, then reversing those answers', 'Starting from the solution', 'Using a flowchart in reverse'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u3_3':
      return {
        'content': '''# Reduction & Problem Types

## Problem Reduction

Transform an unknown problem into a known one whose solution already exists.

Example: Exam scheduling → Graph colouring (exams = nodes, conflicts = edges, colours = time slots).

## Problem Classification

| Type | Definition | Example |
|---|---|---|
| Optimisation | Find the best solution | Shortest route |
| Decision | Yes/No answer | Does path exist? |
| Search | Find a valid solution | Valid timetable |
| Counting | Count valid solutions | Queens on chessboard |

## Divide and Conquer

1. **Divide**: Split into sub-problems
2. **Conquer**: Solve each recursively
3. **Combine**: Merge results

Examples: Merge sort O(n log n), Binary search O(log n).

## Recursion

A function that calls itself with smaller input. Must have a **base case** to terminate.''',
        'questions': [
          {
            'question': 'Reducing exam scheduling to graph colouring is useful because:',
            'options': ['Graph theory is simpler', 'Efficient graph colouring algorithms already exist and apply directly', 'It eliminates the need for computers', 'Graphs represent any problem'],
            'correct': 1,
          },
          {
            'question': 'Divide and conquer works by:',
            'options': ['Guessing and checking', 'Splitting into smaller instances, solving each, then combining', 'Making locally optimal choices', 'Reducing to a graph'],
            'correct': 1,
          },
          {
            'question': 'A decision problem requires:',
            'options': ['Finding the optimal value', 'A yes/no answer', 'Counting all valid solutions', 'Enumerating all possibilities'],
            'correct': 1,
          },
          {
            'question': 'Which is an optimisation problem?',
            'options': ['Is this number prime?', 'How many ways can queens be arranged?', 'Find the shortest route between two cities', 'Does a path exist from A to B?'],
            'correct': 2,
          },
          {
            'question': 'Recursion requires a base case to:',
            'options': ['Make the function faster', 'Prevent infinite self-calls and ensure termination', 'Allow multiple return values', 'Enable parallel processing'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u4_1':
      return {
        'content': '''# Lateral Thinking & Means-End Analysis

## Lateral Thinking (de Bono)

Approaching problems from unexpected angles, challenging assumptions.

**Provocation (PO)**: State an impossible idea to break patterns.
**Random entry**: Introduce an unrelated concept, find connections.
**Six Thinking Hats**: Explore from six perspectives — facts (white), emotions (red), caution (black), optimism (yellow), creativity (green), process (blue).

## Means-End Analysis

Systematically reduce the gap between current state and goal state.

### MEA Steps
1. Identify current state and goal state
2. Find largest difference
3. Apply operator that reduces it
4. If preconditions not met, create sub-goal
5. Repeat until current = goal

**GPS (Newell & Simon, 1957)**: First AI implementation of MEA.

## Comparison

| Lateral Thinking | MEA |
|---|---|
| Divergent, creative | Convergent, systematic |
| Ill-defined problems | Well-defined problems |
| No fixed structure | Algorithmic structure |''',
        'questions': [
          {
            'question': 'De Bono\'s provocation technique involves:',
            'options': ['Researching competitors', 'Stating an intentionally impossible idea to break thinking patterns', 'Testing the obvious first', 'Asking customers what they want'],
            'correct': 1,
          },
          {
            'question': 'Means-End Analysis works by:',
            'options': ['Listing all solutions', 'Repeatedly reducing the difference between current and goal state', 'Working backwards only', 'Splitting into two equal halves'],
            'correct': 1,
          },
          {
            'question': 'GPS (Newell & Simon) was significant because:',
            'options': ['It was fastest computer of its time', 'It demonstrated MEA as a general AI problem-solving strategy', 'It proved P=NP', 'It introduced recursion'],
            'correct': 1,
          },
          {
            'question': 'Six Thinking Hats has participants:',
            'options': ['Rank ideas by feasibility', 'Explore a problem from six distinct perspectives simultaneously', 'Test solutions in order', 'Generate a flowchart automatically'],
            'correct': 1,
          },
          {
            'question': 'Lateral thinking is most useful for:',
            'options': ['Well-defined mathematical problems', 'Ill-defined creative problems where standard approaches have failed', 'Optimisation problems', 'Algorithm complexity analysis'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u4_2':
      return {
        'content': '''# Root Cause Analysis & Divide and Conquer

## Root Cause Analysis

Find the true underlying cause, not just the visible symptoms.

### Five Whys

Ask "Why?" repeatedly (typically 5 times) until you reach the root cause.

Example: Website down → server out of memory → memory leak → sessions not closed → bug in logout handler → **root cause: no unit test for logout**.

### Fishbone (Ishikawa) Diagram

Organises causes into categories (Methods, Machines, Materials, Manpower, etc.) branching from the effect. Visualises all potential causes simultaneously.

## Divide and Conquer

### Merge Sort O(n log n)
1. Divide array into halves
2. Recursively sort each half
3. Merge sorted halves

### Binary Search O(log n)
1. Compare target to middle element
2. Search left or right half accordingly

## RCA vs D&C

- **RCA**: Decomposes a *cause chain* to find root
- **D&C**: Decomposes a *problem* into parallel sub-problems''',
        'questions': [
          {
            'question': 'The Five Whys technique aims to:',
            'options': ['Generate five possible solutions', 'Reach the root cause by repeatedly asking why', 'List the five most important symptoms', 'Test five different fixes'],
            'correct': 1,
          },
          {
            'question': 'A Fishbone diagram organises causes into:',
            'options': ['A timeline', 'Categories branching from the effect', 'A ranked list by probability', 'A flowchart of decisions'],
            'correct': 1,
          },
          {
            'question': 'Merge sort is O(n log n) because:',
            'options': ['It uses random pivots', 'It splits in half (log n levels) and merges linearly at each level', 'It sorts in place', 'It only works on small arrays'],
            'correct': 1,
          },
          {
            'question': 'Binary search requires the input to be:',
            'options': ['Random', 'Sorted', 'Unique', 'Numeric only'],
            'correct': 1,
          },
          {
            'question': 'Treating symptoms vs root cause analysis:',
            'options': ['Symptoms are more important', 'Treating symptoms gives temporary relief; RCA prevents recurrence', 'They are the same', 'RCA is only for medical problems'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u4_3':
      return {
        'content': '''# Reasoning & Proof

## Types of Reasoning

**Deductive**: General premises → specific conclusion. Guaranteed if premises are true.
Example: All humans are mortal. Socrates is human. → Socrates is mortal.

**Inductive**: Specific observations → general conclusion. Probable but not guaranteed.
Example: All observed crows are black → "All crows are black" (disproved by one white crow).

**Abductive**: Infers the most likely explanation.
Example: Database slow + disk 95% full → likely disk I/O bottleneck.

## Proof Techniques

**Direct proof**: Derive conclusion step by step from known facts.
**Proof by contradiction**: Assume the opposite, show it leads to contradiction.
**Mathematical induction**: Prove for base case, then prove n→n+1.

## Loop Invariants

A condition that holds before the loop, after every iteration, and at termination. Used to formally prove loop correctness.

Example: In insertion sort, "the first i elements are always sorted" is the invariant.''',
        'questions': [
          {
            'question': 'Deductive reasoning guarantees its conclusion because:',
            'options': ['It is based on many observations', 'If premises are true and logic valid, the conclusion must be true', 'It uses probability', 'It has been verified experimentally'],
            'correct': 1,
          },
          {
            'question': 'Proof by contradiction assumes:',
            'options': ['The conclusion is true', 'The opposite of what you want to prove, then shows a contradiction', 'All premises are false', 'The input is invalid'],
            'correct': 1,
          },
          {
            'question': 'A loop invariant holds:',
            'options': ['Only at loop start', 'Before and after every iteration, used to prove correctness', 'Only at termination', 'Only for while loops'],
            'correct': 1,
          },
          {
            'question': 'Inductive reasoning differs from deductive in that conclusions are:',
            'options': ['Always true', 'Probable but not guaranteed based on observed patterns', 'Based on axioms', 'Mathematically derived'],
            'correct': 1,
          },
          {
            'question': 'Abductive reasoning is used in:',
            'options': ['Mathematical proof', 'Debugging and diagnosis — inferring the most likely explanation', 'Sorting algorithms', 'Complexity analysis'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u5_1':
      return {
        'content': '''# Flowcharts

## What is a Flowchart?

A visual diagram representing an algorithm using standardised symbols connected by arrows.

## Standard Symbols

| Symbol | Shape | Purpose |
|---|---|---|
| Terminator | Oval | Start or End |
| Process | Rectangle | Action/calculation |
| Decision | Diamond | Yes/No branch |
| Input/Output | Parallelogram | Read/Display data |
| Connector | Circle | Continue on another page |
| Predefined Process | Rectangle + double lines | Subroutine call |
| Arrow | Line + arrowhead | Direction of flow |

## Flowchart Structures

**Sequence**: Steps one after another.
**Selection**: Diamond creates YES/NO branches.
**Iteration**: Arrow loops back to a previous step.

## Flowchart vs Pseudocode vs Code

All represent the same algorithm at different formality levels:
- Flowchart → visual logic
- Pseudocode → structured English
- Code → executable syntax

Draw the flowchart first, convert to pseudocode, then implement in code.''',
        'questions': [
          {
            'question': 'What shape is a decision point in a flowchart?',
            'options': ['Oval', 'Rectangle', 'Diamond', 'Parallelogram'],
            'correct': 2,
          },
          {
            'question': 'A parallelogram represents:',
            'options': ['A calculation', 'An input or output operation', 'A decision', 'Start or End'],
            'correct': 1,
          },
          {
            'question': 'The Start and End of a flowchart use:',
            'options': ['Rectangle', 'Diamond', 'Parallelogram', 'Oval'],
            'correct': 3,
          },
          {
            'question': 'Arrows in a flowchart show:',
            'options': ['Data values', 'The direction and sequence of flow', 'Time taken per step', 'Decision branches only'],
            'correct': 1,
          },
          {
            'question': 'Flowchart, pseudocode, and code represent:',
            'options': ['Different problems', 'The same algorithm at different levels of formality', 'Only simple algorithms', 'Different approaches to the same problem type'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u5_2':
      return {
        'content': '''# Pseudocode & Decision Trees

## Pseudocode

Structured informal language describing algorithm logic without strict syntax.

**Key constructs:**
```
IF score >= 50 THEN
    PRINT "Pass"
ELSE
    PRINT "Fail"
END IF

FOR i = 1 TO 10
    READ number
    SET total = total + number
END FOR

WHILE count < limit
    SET count = count + 1
END WHILE
```

## Decision Trees

A tree-structured model where:
- **Internal nodes** = tests/decisions on conditions
- **Branches** = outcomes (YES/NO or multiple values)
- **Leaf nodes** = final outcomes or classifications

**Example — Loan approval:**
```
Income > 50,000?
├── NO  → Rejected
└── YES → Credit score > 700?
              ├── NO  → Rejected
              └── YES → Approved
```

## Decision Tree vs Flowchart

| Decision Tree | Flowchart |
|---|---|
| Decisions and outcomes only | Full process including I/O and calculations |
| Used in AI/ML and business | Used in algorithm/program design |

## Design Workflow

Flowchart/Pseudocode → Code → Test → Reflect''',
        'questions': [
          {
            'question': 'Pseudocode is designed primarily for:',
            'options': ['Computer execution', 'Human readers to understand algorithm logic', 'Automatic code generation', 'Database storage'],
            'correct': 1,
          },
          {
            'question': 'In a decision tree, leaf nodes represent:',
            'options': ['Further decisions', 'The final outcome or classification', 'Variables', 'Loops'],
            'correct': 1,
          },
          {
            'question': 'A WHILE loop in pseudocode:',
            'options': ['Executes once only', 'Repeats while a condition is true', 'Calls a function', 'Skips a block if false'],
            'correct': 1,
          },
          {
            'question': 'Decision trees differ from flowcharts in that they:',
            'options': ['Show process steps and calculations', 'Focus purely on decisions and outcomes without process steps', 'Cannot have more than two branches', 'Are only used in mathematics'],
            'correct': 1,
          },
          {
            'question': 'The correct development workflow is:',
            'options': ['Code → Pseudocode → Test', 'Flowchart/Pseudocode → Code → Test', 'Test → Code → Pseudocode', 'Code directly without planning'],
            'correct': 1,
          },
        ]
      };

    case 'cos102_u5_3':
      return {
        'content': '''# VBA as a Problem-Solving Tool

## What is VBA?

**Visual Basic for Applications** — a programming language built into Microsoft Office (Excel, Word, Access) for automating tasks and implementing algorithms.

## Sub vs Function

```vba
' Sub: performs actions, no return value
Sub GreetUser()
    MsgBox "Welcome!"
End Sub

' Function: returns a value
Function Square(n As Integer) As Integer
    Square = n * n
End Function
```

## Control Structures

```vba
' If...Then...Else
If score >= 50 Then
    MsgBox "Pass"
Else
    MsgBox "Fail"
End If

' Select Case
Select Case grade
    Case "A": MsgBox "Excellent"
    Case "B": MsgBox "Good"
    Case Else: MsgBox "Below Average"
End Select

' For...Next
For i = 1 To 10
    total = total + Cells(i, 1).Value
Next i

' Do While...Loop
Do While count < 100
    count = count + 1
Loop
```

## I/O

```vba
name = InputBox("Enter your name:")
MsgBox "Hello, " & name
```

## VBA in the Problem-Solving Workflow

Flowchart → Pseudocode → VBA Code — all represent the same algorithm at increasing formality.''',
        'questions': [
          {
            'question': 'VBA stands for:',
            'options': ['Visual Basic Application', 'Visual Basic for Applications', 'Variable-Based Algorithm', 'Visual Binary Analysis'],
            'correct': 1,
          },
          {
            'question': 'A VBA Function procedure differs from a Sub in that it:',
            'options': ['Can only be called once', 'Returns a value usable in formulas or expressions', 'Cannot accept parameters', 'Runs automatically on open'],
            'correct': 1,
          },
          {
            'question': 'Which VBA structure checks a variable against many specific values?',
            'options': ['For...Next', 'Do While...Loop', 'If...Then only', 'Select Case'],
            'correct': 3,
          },
          {
            'question': 'InputBox in VBA is used to:',
            'options': ['Display a message', 'Prompt the user for input and capture the value', 'Format a worksheet', 'Create a chart'],
            'correct': 1,
          },
          {
            'question': 'Flowchart, pseudocode, and VBA code for the same problem:',
            'options': ['Solve different problems', 'Represent the same algorithm at increasing levels of formality', 'VBA always comes first', 'Only one is needed'],
            'correct': 1,
          },
        ]
      };

    default:
      return {
        'content': 'Lesson content coming soon...',
        'questions': []
      };
  }
}