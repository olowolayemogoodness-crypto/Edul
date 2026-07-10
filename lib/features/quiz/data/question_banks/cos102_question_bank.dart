// lib/features/quiz/data/question_banks/cos102_question_bank.dart
//
// COS 102 (Introduction to Problem Solving) quiz question bank.
// Sources:
//   - COS102_Objective_Questions_Weeks1-5.docx: 224 unique MCQs
//     extracted after deduplicating ~8x repetitions per concept.
//   - 75 new questions generated covering: flowchart shapes &
//     functions, flowchart mechanics, pseudocode structure,
//     pseudocode/flowchart/programming-language relationships,
//     decision trees, and VBA as a problem-solving tool.
//
// Keyed by lessonId matching subjects_data.dart (e.g. 'cos102_u1_1').

List<Map<String, dynamic>> getCOS102ExtraQuestions(String lessonId) {
  switch (lessonId) {
    case 'cos102_u1_1': // Problem Solving Basics
      return [
        {
          'question': 'Which of the following best describes Data?',
          'options': ['Understand the Problem, Devise a Plan, Carry Out the Plan, and Look Back', 'raw facts, figures, or symbols that have no meaning by themselves', 'the Pólya step of identifying the given data, the unknowns, and the conditions', 'the constraints and available actions that can change the state'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Information?',
          'options': ['data that has been processed, organised, or structured to make it meaningful', 'a way of approaching problems that draws on concepts fundamental to computing', 'the constraints and available actions that can change the state', 'the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Algorithm?',
          'options': ['understanding what a user really needs, which may differ from what they initially ask for', 'a problem where the initial state, goal state, and operators are all clearly specified', 'the constraints and available actions that can change the state', 'a finite sequence of well-defined, unambiguous steps that solves a specific problem'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Program?',
          'options': ['a problem where the initial state, goal state, and operators are all clearly specified', 'the final stage – where you want to be or the solution you want to achieve', 'an algorithm expressed in a language that a computer can execute', 'a finite sequence of well-defined, unambiguous steps that solves a specific problem'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Problem?',
          'options': ['identifying a problem because something is not working as expected', 'a situation with a clear initial state and goal state where the path between them is not obvious', 'understanding what a user really needs, which may differ from what they initially ask for', 'the Pólya step of executing the chosen strategy with care, checking each step'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Initial state?',
          'options': ['a finite sequence of well-defined, unambiguous steps that solves a specific problem', 'a problem where the initial state, goal state, and operators are all clearly specified', 'the beginning state – where you are now, what you know, or what you have', 'the people affected by a problem and its solution'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Goal state?',
          'options': ['the final stage – where you want to be or the solution you want to achieve', 'the Pólya step of executing the chosen strategy with care, checking each step', 'the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned', 'the Pólya step of selecting a strategy, such as an algorithm or breaking into subproblems'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Obstacle/Challenge?',
          'options': ['the people affected by a problem and its solution', 'identifying a problem because something is not working as expected', 'what the existing situation is and why it is unsatisfactory', 'the constraints and available actions that can change the state'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Observation of symptoms?',
          'options': ['a problem where the initial state, goal state, and operators are all clearly specified', 'the final stage – where you want to be or the solution you want to achieve', 'raw facts, figures, or symbols that have no meaning by themselves', 'identifying a problem because something is not working as expected'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Needs analysis?',
          'options': ['raw facts, figures, or symbols that have no meaning by themselves', 'identifying a problem because something is not working as expected', 'identifying a problem because a stakeholder expresses a desire for a new capability', 'a concise, unambiguous description of the issue to be addressed'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Opportunities (problem identification)?',
          'options': ['identifying a problem by recognising a task could be done better, faster, or cheaper', 'identifying a problem because something is not working as expected', 'a finite sequence of well-defined, unambiguous steps that solves a specific problem', 'the beginning state – where you are now, what you know, or what you have'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Requirement elicitation?',
          'options': ['understanding what a user really needs, which may differ from what they initially ask for', 'the Pólya step of identifying the given data, the unknowns, and the conditions', 'a problem where the goal, initial state, or allowable operations are not fully specified', 'the Pólya step of executing the chosen strategy with care, checking each step'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Problem statement?',
          'options': ['the beginning state – where you are now, what you know, or what you have', 'a way of approaching problems that draws on concepts fundamental to computing', 'the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned', 'a concise, unambiguous description of the issue to be addressed'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Current state (problem statement element)?',
          'options': ['the Pólya step of identifying the given data, the unknowns, and the conditions', 'data that has been processed, organised, or structured to make it meaningful', 'what the existing situation is and why it is unsatisfactory', 'understanding what a user really needs, which may differ from what they initially ask for'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Stakeholders?',
          'options': ['a situation with a clear initial state and goal state where the path between them is not obvious', 'the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned', 'the people affected by a problem and its solution', 'the Pólya step of executing the chosen strategy with care, checking each step'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best illustrates the difference between data and information?',
          'options': ['37 is data; "37°C is a fever" is information', '37 is information; "37°C is a fever" is data', 'Both are the same thing expressed differently', 'Data is always numerical; information is always textual'],
          'correct': 0,
        },
        {
          'question': 'A problem statement that says "the system is slow" is weak because it:',
          'options': ['Uses informal language', 'Lacks a measurable goal state and success criteria', 'Does not mention stakeholders by name', 'Is written in passive voice'],
          'correct': 1,
        },
        {
          'question': 'Which of Pólya\'s four steps is most focused on checking whether the answer is correct and can be extended?',
          'options': ['Understand the Problem', 'Devise a Plan', 'Carry Out the Plan', 'Look Back'],
          'correct': 3,
        },
      ];
    case 'cos102_u1_2': // Information & Algorithms
      return [
        {
          'question': 'Which of the following best describes Routine (well-defined) problem?',
          'options': ['identifying a problem because a stakeholder expresses a desire for a new capability', 'a problem where the initial state, goal state, and operators are all clearly specified', 'a situation with a clear initial state and goal state where the path between them is not obvious', 'a finite sequence of well-defined, unambiguous steps that solves a specific problem'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Non-routine (ill-defined) problem?',
          'options': ['data that has been processed, organised, or structured to make it meaningful', 'Understand the Problem, Devise a Plan, Carry Out the Plan, and Look Back', 'a problem where the goal, initial state, or allowable operations are not fully specified', 'understanding what a user really needs, which may differ from what they initially ask for'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Computational thinking?',
          'options': ['the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned', 'identifying a problem by recognising a task could be done better, faster, or cheaper', 'identifying a problem because something is not working as expected', 'a way of approaching problems that draws on concepts fundamental to computing'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Pólya’s four steps?',
          'options': ['the people affected by a problem and its solution', 'identifying a problem because something is not working as expected', 'Understand the Problem, Devise a Plan, Carry Out the Plan, and Look Back', 'the final stage – where you want to be or the solution you want to achieve'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Understand the Problem?',
          'options': ['identifying a problem because something is not working as expected', 'an algorithm expressed in a language that a computer can execute', 'the Pólya step of identifying the given data, the unknowns, and the conditions', 'the constraints and available actions that can change the state'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Devise a Plan?',
          'options': ['the Pólya step of executing the chosen strategy with care, checking each step', 'the Pólya step of selecting a strategy, such as an algorithm or breaking into subproblems', 'a concise, unambiguous description of the issue to be addressed', 'the Pólya step of identifying the given data, the unknowns, and the conditions'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Carry Out the Plan?',
          'options': ['identifying a problem by recognising a task could be done better, faster, or cheaper', 'the Pólya step of executing the chosen strategy with care, checking each step', 'the constraints and available actions that can change the state', 'identifying a problem because something is not working as expected'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Look Back?',
          'options': ['a way of approaching problems that draws on concepts fundamental to computing', 'identifying a problem by recognising a task could be done better, faster, or cheaper', 'the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned', 'Understand the Problem, Devise a Plan, Carry Out the Plan, and Look Back'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “raw facts, figures, or symbols that have no meaning by themselves”?',
          'options': ['Devise a Plan', 'Program', 'Information', 'Data'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “data that has been processed, organised, or structured to make it meaningful”?',
          'options': ['Initial state', 'Information', 'Program', 'Carry Out the Plan'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a finite sequence of well-defined, unambiguous steps that solves a specific problem”?',
          'options': ['Initial state', 'Information', 'Carry Out the Plan', 'Algorithm'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “an algorithm expressed in a language that a computer can execute”?',
          'options': ['Needs analysis', 'Program', 'Carry Out the Plan', 'Problem'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a situation with a clear initial state and goal state where the path between them is not obvious”?',
          'options': ['Routine (well-defined) problem', 'Problem', 'Understand the Problem', 'Requirement elicitation'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “the beginning state – where you are now, what you know, or what you have”?',
          'options': ['Initial state', 'Goal state', 'Carry Out the Plan', 'Routine (well-defined) problem'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the final stage – where you want to be or the solution you want to achieve”?',
          'options': ['Pólya’s four steps', 'Information', 'Goal state', 'Look Back'],
          'correct': 2,
        },
        {
          'question': 'Which property of an algorithm states that it must eventually stop after a finite number of steps?',
          'options': ['Definiteness', 'Effectiveness', 'Finiteness', 'Input'],
          'correct': 2,
        },
        {
          'question': 'An algorithm is described as "effective" when:',
          'options': ['It always produces output', 'Its steps are basic enough to be carried out with pen and paper', 'It terminates in polynomial time', 'It uses the minimum number of steps'],
          'correct': 1,
        },
        {
          'question': 'What distinguishes a program from an algorithm?',
          'options': ['A program has inputs; an algorithm does not', 'A program is an algorithm expressed in a language a computer can execute', 'An algorithm is faster than a program', 'Programs are always written in high-level languages'],
          'correct': 1,
        },
      ];
    case 'cos102_u1_3': // Computational Thinking
      return [
        {
          'question': 'Which term is best described as: “the constraints and available actions that can change the state”?',
          'options': ['Obstacle/Challenge', 'Initial state', 'Non-routine (ill-defined) problem', 'Routine (well-defined) problem'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “identifying a problem because something is not working as expected”?',
          'options': ['Observation of symptoms', 'Needs analysis', 'Program', 'Routine (well-defined) problem'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “identifying a problem because a stakeholder expresses a desire for a new capability”?',
          'options': ['Needs analysis', 'Requirement elicitation', 'Obstacle/Challenge', 'Stakeholders'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “identifying a problem by recognising a task could be done better, faster, or cheaper”?',
          'options': ['Data', 'Initial state', 'Opportunities (problem identification)', 'Computational thinking'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “understanding what a user really needs, which may differ from what they initially ask for”?',
          'options': ['Devise a Plan', 'Stakeholders', 'Requirement elicitation', 'Computational thinking'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “a concise, unambiguous description of the issue to be addressed”?',
          'options': ['Obstacle/Challenge', 'Observation of symptoms', 'Computational thinking', 'Problem statement'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “what the existing situation is and why it is unsatisfactory”?',
          'options': ['Stakeholders', 'Computational thinking', 'Goal state', 'Current state (problem statement element)'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “the people affected by a problem and its solution”?',
          'options': ['Stakeholders', 'Observation of symptoms', 'Data', 'Routine (well-defined) problem'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a problem where the initial state, goal state, and operators are all clearly specified”?',
          'options': ['Understand the Problem', 'Needs analysis', 'Look Back', 'Routine (well-defined) problem'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a problem where the goal, initial state, or allowable operations are not fully specified”?',
          'options': ['Problem', 'Needs analysis', 'Understand the Problem', 'Non-routine (ill-defined) problem'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a way of approaching problems that draws on concepts fundamental to computing”?',
          'options': ['Computational thinking', 'Data', 'Algorithm', 'Obstacle/Challenge'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “Understand the Problem, Devise a Plan, Carry Out the Plan, and Look Back”?',
          'options': ['Pólya’s four steps', 'Algorithm', 'Routine (well-defined) problem', 'Obstacle/Challenge'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the Pólya step of identifying the given data, the unknowns, and the conditions”?',
          'options': ['Understand the Problem', 'Problem', 'Goal state', 'Observation of symptoms'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the Pólya step of selecting a strategy, such as an algorithm or breaking into subproblems”?',
          'options': ['Current state (problem statement element)', 'Initial state', 'Routine (well-defined) problem', 'Devise a Plan'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “the Pólya step of executing the chosen strategy with care, checking each step”?',
          'options': ['Non-routine (ill-defined) problem', 'Problem statement', 'Stakeholders', 'Carry Out the Plan'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “the Pólya step of evaluating the solution, checking efficiency, and reflecting on what was learned”?',
          'options': ['Look Back', 'Current state (problem statement element)', 'Opportunities (problem identification)', 'Routine (well-defined) problem'],
          'correct': 0,
        },
        {
          'question': 'Which of the four pillars of computational thinking involves breaking a complex problem into smaller, manageable parts?',
          'options': ['Abstraction', 'Pattern recognition', 'Decomposition', 'Algorithmic thinking'],
          'correct': 2,
        },
        {
          'question': 'A student notices that sorting names and sorting numbers use the same underlying comparison strategy. This is an example of:',
          'options': ['Abstraction', 'Pattern recognition', 'Decomposition', 'Debugging'],
          'correct': 1,
        },
        {
          'question': 'Which computational thinking skill is being applied when a programmer hides implementation details behind a function name?',
          'options': ['Pattern recognition', 'Abstraction', 'Decomposition', 'Algorithmic thinking'],
          'correct': 1,
        },
      ];
    case 'cos102_u2_1': // Decidability & Turing
      return [
        {
          'question': 'Which of the following best describes Solvable (decidable) problem?',
          'options': ['determining whether an arbitrary program will halt or run forever on a given input', 'a method for computing the GCD of two integers by repeated modulus operations', 'a problem for which an algorithm exists that always terminates with the correct output', 'an algorithm that makes the locally optimal choice at each step'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Unsolvable (undecidable) problem?',
          'options': ['a finite sequence of instructions guaranteed to produce correct output and terminate', 'a problem for which no algorithm can possibly exist', 'running time of the form O(k^n), considered intractable', 'a method for computing the GCD of two integers by repeated modulus operations'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Entscheidungsproblem?',
          'options': ['Hilbert’s 1928 decision problem asking whether mathematics could be completely automated', 'a method for computing the GCD of two integers by repeated modulus operations', 'the one or more results an algorithm produces', 'the zero or more quantities given to an algorithm before it begins'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Turing machine?',
          'options': ['the zero or more quantities given to an algorithm before it begins', 'notation describing how time or space requirements scale with input size', 'a theoretical device with an infinite tape, a head, and a finite set of states and transitions', 'the property that an algorithm must always terminate after a finite number of steps'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Church-Turing thesis?',
          'options': ['a technique used by chess programs to prune unpromising search lines', 'the claim that anything computable can be computed by a Turing machine', 'a problem solvable by an algorithm whose running time grows polynomially with input size', 'a method for computing the GCD of two integers by repeated modulus operations'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes The Halting Problem?',
          'options': ['determining whether an arbitrary program will halt or run forever on a given input', 'a technique used by chess programs to prune unpromising search lines', 'the zero or more quantities given to an algorithm before it begins', 'the claim that anything computable can be computed by a Turing machine'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Tractable problem?',
          'options': ['an O(log n) algorithm for finding a target in a sorted array', 'the property that each step of an algorithm must be precisely and unambiguously defined', 'an algorithm that makes the locally optimal choice at each step', 'a problem solvable by an algorithm whose running time grows polynomially with input size'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Intractable problem?',
          'options': ['a problem whose best known algorithm requires exponential or worse time growth', 'a technique used by chess programs to prune unpromising search lines', 'a finite sequence of instructions guaranteed to produce correct output and terminate', 'whether every problem verifiable in polynomial time is also solvable in polynomial time'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Big O notation?',
          'options': ['an experience-based technique for finding satisfactory, but not guaranteed optimal, solutions', 'a finite sequence of instructions guaranteed to produce correct output and terminate', 'notation describing how time or space requirements scale with input size', 'a method for computing the GCD of two integers by repeated modulus operations'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Polynomial time?',
          'options': ['running time of the form O(n^k) for constant k, considered tractable', 'the property that operations must be basic enough to be carried out with pencil and paper', 'Hilbert’s 1928 decision problem asking whether mathematics could be completely automated', 'a problem solvable by an algorithm whose running time grows polynomially with input size'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Exponential time?',
          'options': ['running time of the form O(k^n), considered intractable', 'an experience-based technique for finding satisfactory, but not guaranteed optimal, solutions', 'the claim that anything computable can be computed by a Turing machine', 'the one or more results an algorithm produces'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes P vs NP question?',
          'options': ['running time of the form O(k^n), considered intractable', 'whether every problem verifiable in polynomial time is also solvable in polynomial time', 'an O(log n) algorithm for finding a target in a sorted array', 'the property that each step of an algorithm must be precisely and unambiguously defined'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes NP class?',
          'options': ['problems whose proposed solutions can be verified in polynomial time', 'a problem solvable by an algorithm whose running time grows polynomially with input size', 'a problem whose best known algorithm requires exponential or worse time growth', 'a finite sequence of instructions guaranteed to produce correct output and terminate'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Algorithm (formal)?',
          'options': ['a problem for which no algorithm can possibly exist', 'problems whose proposed solutions can be verified in polynomial time', 'the zero or more quantities given to an algorithm before it begins', 'a finite sequence of instructions guaranteed to produce correct output and terminate'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Heuristic?',
          'options': ['an experience-based technique for finding satisfactory, but not guaranteed optimal, solutions', 'running time of the form O(n^k) for constant k, considered tractable', 'Hilbert’s 1928 decision problem asking whether mathematics could be completely automated', 'the zero or more quantities given to an algorithm before it begins'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Finiteness?',
          'options': ['the property that an algorithm must always terminate after a finite number of steps', 'an algorithm that makes the locally optimal choice at each step', 'determining whether an arbitrary program will halt or run forever on a given input', 'a finite sequence of instructions guaranteed to produce correct output and terminate'],
          'correct': 0,
        },
        {
          'question': 'The Halting Problem proves that:',
          'options': ['All programs eventually terminate', 'No general algorithm can determine whether any arbitrary program halts', 'Computers cannot solve mathematical problems', 'Recursive programs never halt'],
          'correct': 1,
        },
        {
          'question': 'Turing\'s theoretical model that established the limits of what computers can compute is called:',
          'options': ['The Church machine', 'The Turing machine', 'The Von Neumann machine', 'The Babbage engine'],
          'correct': 1,
        },
        {
          'question': 'A problem is "undecidable" if:',
          'options': ['It takes too long to solve', 'No algorithm exists that always produces the correct answer and terminates', 'It requires exponential time', 'It cannot be expressed mathematically'],
          'correct': 1,
        },
      ];
    case 'cos102_u2_2': // Complexity & Big O
      return [
        {
          'question': 'Which of the following best describes Definiteness?',
          'options': ['the property that each step of an algorithm must be precisely and unambiguously defined', 'determining whether an arbitrary program will halt or run forever on a given input', 'an algorithm that makes the locally optimal choice at each step', 'a problem solvable by an algorithm whose running time grows polynomially with input size'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Input (algorithm property)?',
          'options': ['the property that an algorithm must always terminate after a finite number of steps', 'a method for computing the GCD of two integers by repeated modulus operations', 'the zero or more quantities given to an algorithm before it begins', 'the claim that anything computable can be computed by a Turing machine'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Output (algorithm property)?',
          'options': ['notation describing how time or space requirements scale with input size', 'problems whose proposed solutions can be verified in polynomial time', 'the one or more results an algorithm produces', 'a problem whose best known algorithm requires exponential or worse time growth'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Effectiveness?',
          'options': ['the property that operations must be basic enough to be carried out with pencil and paper', 'a finite sequence of instructions guaranteed to produce correct output and terminate', 'the claim that anything computable can be computed by a Turing machine', 'a problem for which an algorithm exists that always terminates with the correct output'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Euclid’s Algorithm?',
          'options': ['a finite sequence of instructions guaranteed to produce correct output and terminate', 'an experience-based technique for finding satisfactory, but not guaranteed optimal, solutions', 'a method for computing the GCD of two integers by repeated modulus operations', 'a problem whose best known algorithm requires exponential or worse time growth'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Binary search?',
          'options': ['a problem solvable by an algorithm whose running time grows polynomially with input size', 'an algorithm that makes the locally optimal choice at each step', 'an O(log n) algorithm for finding a target in a sorted array', 'a problem for which an algorithm exists that always terminates with the correct output'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Greedy algorithm?',
          'options': ['a problem solvable by an algorithm whose running time grows polynomially with input size', 'an algorithm that makes the locally optimal choice at each step', 'a method for computing the GCD of two integers by repeated modulus operations', 'the one or more results an algorithm produces'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Alpha-beta pruning?',
          'options': ['determining whether an arbitrary program will halt or run forever on a given input', 'an algorithm that makes the locally optimal choice at each step', 'a technique used by chess programs to prune unpromising search lines', 'problems whose proposed solutions can be verified in polynomial time'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “a problem for which an algorithm exists that always terminates with the correct output”?',
          'options': ['Turing machine', 'Solvable (decidable) problem', 'NP class', 'Entscheidungsproblem'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a problem for which no algorithm can possibly exist”?',
          'options': ['Solvable (decidable) problem', 'NP class', 'Effectiveness', 'Unsolvable (undecidable) problem'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “Hilbert’s 1928 decision problem asking whether mathematics could be completely automated”?',
          'options': ['Alpha-beta pruning', 'Tractable problem', 'Exponential time', 'Entscheidungsproblem'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a theoretical device with an infinite tape, a head, and a finite set of states and transitions”?',
          'options': ['Turing machine', 'Polynomial time', 'Big O notation', 'Input (algorithm property)'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the claim that anything computable can be computed by a Turing machine”?',
          'options': ['Finiteness', 'Solvable (decidable) problem', 'Church-Turing thesis', 'Alpha-beta pruning'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “determining whether an arbitrary program will halt or run forever on a given input”?',
          'options': ['NP class', 'The Halting Problem', 'Unsolvable (undecidable) problem', 'Output (algorithm property)'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a problem solvable by an algorithm whose running time grows polynomially with input size”?',
          'options': ['Alpha-beta pruning', 'Solvable (decidable) problem', 'Tractable problem', 'The Halting Problem'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “a problem whose best known algorithm requires exponential or worse time growth”?',
          'options': ['Definiteness', 'Intractable problem', 'The Halting Problem', 'Algorithm (formal)'],
          'correct': 1,
        },
        {
          'question': 'Big O notation O(n²) means the algorithm\'s running time grows:',
          'options': ['Linearly with input size', 'Proportional to the square of the input size', 'Exponentially with input size', 'Logarithmically with input size'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is the most efficient time complexity for a sorting algorithm in the worst case?',
          'options': ['O(n²)', 'O(n log n)', 'O(2ⁿ)', 'O(n!)'],
          'correct': 1,
        },
        {
          'question': 'A tractable problem is one that:',
          'options': ['Can be solved by humans without computers', 'Has a polynomial-time algorithm solution', 'Has an exact mathematical proof', 'Can be solved in constant time'],
          'correct': 1,
        },
      ];
    case 'cos102_u2_3': // Heuristics & Algorithm Properties
      return [
        {
          'question': 'Which term is best described as: “notation describing how time or space requirements scale with input size”?',
          'options': ['Big O notation', 'Effectiveness', 'Euclid’s Algorithm', 'Turing machine'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “running time of the form O(n^k) for constant k, considered tractable”?',
          'options': ['Greedy algorithm', 'Tractable problem', 'Polynomial time', 'Input (algorithm property)'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “running time of the form O(k^n), considered intractable”?',
          'options': ['Tractable problem', 'Effectiveness', 'Heuristic', 'Exponential time'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “whether every problem verifiable in polynomial time is also solvable in polynomial time”?',
          'options': ['P vs NP question', 'The Halting Problem', 'Effectiveness', 'Polynomial time'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “problems whose proposed solutions can be verified in polynomial time”?',
          'options': ['Euclid’s Algorithm', 'The Halting Problem', 'NP class', 'Binary search'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “a finite sequence of instructions guaranteed to produce correct output and terminate”?',
          'options': ['Effectiveness', 'Algorithm (formal)', 'NP class', 'Turing machine'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “an experience-based technique for finding satisfactory, but not guaranteed optimal, solutions”?',
          'options': ['Heuristic', 'Turing machine', 'NP class', 'Polynomial time'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the property that an algorithm must always terminate after a finite number of steps”?',
          'options': ['Algorithm (formal)', 'Exponential time', 'Polynomial time', 'Finiteness'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “the property that each step of an algorithm must be precisely and unambiguously defined”?',
          'options': ['Euclid’s Algorithm', 'Definiteness', 'Unsolvable (undecidable) problem', 'Finiteness'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “the zero or more quantities given to an algorithm before it begins”?',
          'options': ['Input (algorithm property)', 'NP class', 'Polynomial time', 'Euclid’s Algorithm'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the one or more results an algorithm produces”?',
          'options': ['Greedy algorithm', 'Effectiveness', 'Unsolvable (undecidable) problem', 'Output (algorithm property)'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “the property that operations must be basic enough to be carried out with pencil and paper”?',
          'options': ['The Halting Problem', 'Effectiveness', 'Alpha-beta pruning', 'Unsolvable (undecidable) problem'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a method for computing the GCD of two integers by repeated modulus operations”?',
          'options': ['Solvable (decidable) problem', 'Euclid’s Algorithm', 'Entscheidungsproblem', 'Unsolvable (undecidable) problem'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “an O(log n) algorithm for finding a target in a sorted array”?',
          'options': ['Entscheidungsproblem', 'Church-Turing thesis', 'Heuristic', 'Binary search'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “an algorithm that makes the locally optimal choice at each step”?',
          'options': ['Greedy algorithm', 'Heuristic', 'Binary search', 'NP class'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a technique used by chess programs to prune unpromising search lines”?',
          'options': ['Algorithm (formal)', 'Alpha-beta pruning', 'Greedy algorithm', 'Unsolvable (undecidable) problem'],
          'correct': 1,
        },
        {
          'question': 'A heuristic differs from an exact algorithm in that a heuristic:',
          'options': ['Always finds the optimal solution', 'Finds a good-enough solution without guaranteeing the best one', 'Runs in exponential time', 'Only works on sorted data'],
          'correct': 1,
        },
        {
          'question': 'NP problems are those whose solutions can be:',
          'options': ['Found in polynomial time', 'Verified in polynomial time, though not necessarily found quickly', 'Never verified', 'Only solved by quantum computers'],
          'correct': 1,
        },
        {
          'question': 'The P vs NP question asks whether:',
          'options': ['All problems can be parallelised', 'Every problem whose solution can be quickly verified can also be quickly solved', 'Polynomial time equals non-polynomial time', 'Computers can solve all mathematical problems'],
          'correct': 1,
        },
      ];
    case 'cos102_u3_1': // Abstraction & Analogy
      return [
        {
          'question': 'Which of the following best describes Abstraction?',
          'options': ['representing exam scheduling as assigning time-slot colours to course nodes', 'attempts varied in a structured way, where each failure eliminates a class of possibilities', 'an analogy-based algorithm using two pointers at different speeds to detect a cycle', 'filtering out unnecessary details to focus on the essential features of a problem'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Analogy?',
          'options': ['encoding hard problems like Sudoku or planning as Boolean satisfiability', 'solving a new problem by recognising its similarity to a previously solved problem', 'an analogy-based algorithm using two pointers at different speeds to detect a cycle', 'designing a class such as Student with only the attributes relevant to the system'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Brainstorming?',
          'options': ['solving a problem by transforming it into another problem for which a solution is already known', 'a creative technique for generating many diverse ideas while suspending judgment', 'making successive attempts, observing outcomes, and adjusting until a solution is found', 'a heuristic inspired by ants depositing pheromone trails to find shortest paths'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Trial and error?',
          'options': ['making successive attempts, observing outcomes, and adjusting until a solution is found', 'a systematic, evidence-based technique for diagnosing problems and evaluating solutions', 'using feedback from each trial to steer subsequent attempts toward promising regions', 'solving a new problem by recognising its similarity to a previously solved problem'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Hypothesis testing?',
          'options': ['attempts made haphazardly with no memory of past failures', 'an abstraction of a pile of plates supporting push, pop, and peek', 'a systematic, evidence-based technique for diagnosing problems and evaluating solutions', 'removing details that are actually essential to a correct solution'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Reduction?',
          'options': ['solving a problem by transforming it into another problem for which a solution is already known', 'attempts varied in a structured way, where each failure eliminates a class of possibilities', 'a classic abstraction example that discards geography for schematic clarity', 'a creative technique for generating many diverse ideas while suspending judgment'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Random trial and error?',
          'options': ['attempts made haphazardly with no memory of past failures', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence', 'representing exam scheduling as assigning time-slot colours to course nodes', 'aim for quantity, withhold criticism, welcome wild ideas, combine and improve ideas'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Systematic trial and error?',
          'options': ['representing exam scheduling as assigning time-slot colours to course nodes', 'a danger where superficial similarities lead to an incorrect solution, e.g. Ptolemaic epicycles', 'attempts varied in a structured way, where each failure eliminates a class of possibilities', 'attempts made haphazardly with no memory of past failures'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Informed trial and error?',
          'options': ['a danger where superficial similarities lead to an incorrect solution, e.g. Ptolemaic epicycles', 'a systematic, evidence-based technique for diagnosing problems and evaluating solutions', 'using feedback from each trial to steer subsequent attempts toward promising regions', 'an abstraction of a pile of plates supporting push, pop, and peek'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Osborn’s brainstorming principles?',
          'options': ['a reduction of median-finding to the selection problem, running in linear time', 'making successive attempts, observing outcomes, and adjusting until a solution is found', 'a classic abstraction example that discards geography for schematic clarity', 'aim for quantity, withhold criticism, welcome wild ideas, combine and improve ideas'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Confirmation bias?',
          'options': ['removing details that are actually essential to a correct solution', 'a reduction of median-finding to the selection problem, running in linear time', 'making successive attempts, observing outcomes, and adjusting until a solution is found', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Confounding variable?',
          'options': ['a variable that makes a test result misleading because two things were changed at once', 'aim for quantity, withhold criticism, welcome wild ideas, combine and improve ideas', 'filtering out unnecessary details to focus on the essential features of a problem', 'the abstracted form of a delivery route optimisation problem'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes London Underground map?',
          'options': ['an analogy-based algorithm using two pointers at different speeds to detect a cycle', 'designing a class such as Student with only the attributes relevant to the system', 'using feedback from each trial to steer subsequent attempts toward promising regions', 'a classic abstraction example that discards geography for schematic clarity'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Object-oriented class abstraction?',
          'options': ['solving a new problem by recognising its similarity to a previously solved problem', 'encoding hard problems like Sudoku or planning as Boolean satisfiability', 'designing a class such as Student with only the attributes relevant to the system', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Stack data structure?',
          'options': ['attempts varied in a structured way, where each failure eliminates a class of possibilities', 'failing to remove enough clutter, leaving a problem too complex to analyse', 'an abstraction of a pile of plates supporting push, pop, and peek', 'removing details that are actually essential to a correct solution'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Floyd’s cycle detection?',
          'options': ['removing details that are actually essential to a correct solution', 'a systematic, evidence-based technique for diagnosing problems and evaluating solutions', 'an analogy-based algorithm using two pointers at different speeds to detect a cycle', 'a creative technique for generating many diverse ideas while suspending judgment'],
          'correct': 2,
        },
        {
          'question': 'The London Underground map is a classic example of abstraction because it:',
          'options': ['Shows exact geographic distances between stations', 'Removes geographic detail while preserving the connection structure needed by travellers', 'Was the first map ever computerised', 'Uses colour coding which is the essence of abstraction'],
          'correct': 1,
        },
        {
          'question': 'Over-abstraction in problem solving means:',
          'options': ['Adding too many irrelevant details', 'Removing details that are actually essential to the correct solution', 'Using too many variables', 'Making the problem unnecessarily complex'],
          'correct': 1,
        },
        {
          'question': 'Floyd\'s cycle detection algorithm is an example of solving a problem by:',
          'options': ['Reduction to a known problem', 'Analogy — modelling the cycle-detection problem like a fast/slow runner on a track', 'Brainstorming new approaches', 'Trial and error'],
          'correct': 1,
        },
      ];
    case 'cos102_u3_2': // Brainstorming & Trial-Error
      return [
        {
          'question': 'Which of the following best describes Ant colony optimisation?',
          'options': ['a creative technique for generating many diverse ideas while suspending judgment', 'a heuristic inspired by ants depositing pheromone trails to find shortest paths', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence', 'an abstraction of a pile of plates supporting push, pop, and peek'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes False analogy?',
          'options': ['a reduction of median-finding to the selection problem, running in linear time', 'a danger where superficial similarities lead to an incorrect solution, e.g. Ptolemaic epicycles', 'using feedback from each trial to steer subsequent attempts toward promising regions', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Vehicle Routing Problem (VRP)?',
          'options': ['aim for quantity, withhold criticism, welcome wild ideas, combine and improve ideas', 'a classic abstraction example that discards geography for schematic clarity', 'the abstracted form of a delivery route optimisation problem', 'an abstraction of a pile of plates supporting push, pop, and peek'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Over-abstraction?',
          'options': ['failing to remove enough clutter, leaving a problem too complex to analyse', 'a variable that makes a test result misleading because two things were changed at once', 'a heuristic inspired by ants depositing pheromone trails to find shortest paths', 'removing details that are actually essential to a correct solution'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Under-abstraction?',
          'options': ['a systematic, evidence-based technique for diagnosing problems and evaluating solutions', 'a variable that makes a test result misleading because two things were changed at once', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence', 'failing to remove enough clutter, leaving a problem too complex to analyse'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes SAT solvers as reduction targets?',
          'options': ['encoding hard problems like Sudoku or planning as Boolean satisfiability', 'solving a problem by transforming it into another problem for which a solution is already known', 'failing to remove enough clutter, leaving a problem too complex to analyse', 'designing a class such as Student with only the attributes relevant to the system'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Quickselect?',
          'options': ['a reduction of median-finding to the selection problem, running in linear time', 'a danger where superficial similarities lead to an incorrect solution, e.g. Ptolemaic epicycles', 'removing details that are actually essential to a correct solution', 'the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Graph colouring reduction?',
          'options': ['representing exam scheduling as assigning time-slot colours to course nodes', 'solving a new problem by recognising its similarity to a previously solved problem', 'a heuristic inspired by ants depositing pheromone trails to find shortest paths', 'a classic abstraction example that discards geography for schematic clarity'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “filtering out unnecessary details to focus on the essential features of a problem”?',
          'options': ['Ant colony optimisation', 'Analogy', 'Trial and error', 'Abstraction'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “solving a new problem by recognising its similarity to a previously solved problem”?',
          'options': ['Abstraction', 'Systematic trial and error', 'Trial and error', 'Analogy'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a creative technique for generating many diverse ideas while suspending judgment”?',
          'options': ['Quickselect', 'Brainstorming', 'Abstraction', 'Analogy'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “making successive attempts, observing outcomes, and adjusting until a solution is found”?',
          'options': ['Trial and error', 'Brainstorming', 'Confirmation bias', 'Floyd’s cycle detection'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a systematic, evidence-based technique for diagnosing problems and evaluating solutions”?',
          'options': ['Analogy', 'Brainstorming', 'Confounding variable', 'Hypothesis testing'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “solving a problem by transforming it into another problem for which a solution is already known”?',
          'options': ['Abstraction', 'Brainstorming', 'Reduction', 'Vehicle Routing Problem (VRP)'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “attempts made haphazardly with no memory of past failures”?',
          'options': ['Trial and error', 'Abstraction', 'Random trial and error', 'Stack data structure'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “attempts varied in a structured way, where each failure eliminates a class of possibilities”?',
          'options': ['Systematic trial and error', 'Quickselect', 'Graph colouring reduction', 'Abstraction'],
          'correct': 0,
        },
        {
          'question': 'Osborn\'s first rule of brainstorming states that during idea generation you should:',
          'options': ['Evaluate each idea immediately', 'Defer all judgment and criticism until later', 'Focus only on practical ideas', 'Work individually, not in groups'],
          'correct': 1,
        },
        {
          'question': 'Systematic trial and error is superior to random trial and error because:',
          'options': ['It always finds the optimal solution', 'Each failed attempt eliminates a class of possibilities, preventing repeated attempts', 'It requires less time overall', 'It does not need a problem statement'],
          'correct': 1,
        },
        {
          'question': 'In hypothesis testing, a confounding variable is dangerous because:',
          'options': ['It makes results too accurate', 'It causes two factors to change simultaneously, making it impossible to isolate the cause', 'It reduces the number of test cases', 'It introduces randomness into systematic testing'],
          'correct': 1,
        },
      ];
    case 'cos102_u3_3': // Reduction & Problem Types
      return [
        {
          'question': 'Which term is best described as: “using feedback from each trial to steer subsequent attempts toward promising regions”?',
          'options': ['Informed trial and error', 'Graph colouring reduction', 'Hypothesis testing', 'Over-abstraction'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “aim for quantity, withhold criticism, welcome wild ideas, combine and improve ideas”?',
          'options': ['Hypothesis testing', 'Osborn’s brainstorming principles', 'False analogy', 'Floyd’s cycle detection'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “the tendency to seek evidence that confirms a hypothesis while ignoring disconfirming evidence”?',
          'options': ['Confirmation bias', 'Random trial and error', 'Object-oriented class abstraction', 'Informed trial and error'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a variable that makes a test result misleading because two things were changed at once”?',
          'options': ['Confounding variable', 'Vehicle Routing Problem (VRP)', 'Systematic trial and error', 'Quickselect'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a classic abstraction example that discards geography for schematic clarity”?',
          'options': ['Vehicle Routing Problem (VRP)', 'Osborn’s brainstorming principles', 'London Underground map', 'Informed trial and error'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “designing a class such as Student with only the attributes relevant to the system”?',
          'options': ['Vehicle Routing Problem (VRP)', 'Brainstorming', 'Object-oriented class abstraction', 'Random trial and error'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “an abstraction of a pile of plates supporting push, pop, and peek”?',
          'options': ['Under-abstraction', 'Quickselect', 'Stack data structure', 'Ant colony optimisation'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “an analogy-based algorithm using two pointers at different speeds to detect a cycle”?',
          'options': ['Confounding variable', 'Abstraction', 'Quickselect', 'Floyd’s cycle detection'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a heuristic inspired by ants depositing pheromone trails to find shortest paths”?',
          'options': ['Brainstorming', 'Confounding variable', 'Object-oriented class abstraction', 'Ant colony optimisation'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a danger where superficial similarities lead to an incorrect solution, e.g. Ptolemaic epicycles”?',
          'options': ['False analogy', 'Hypothesis testing', 'Analogy', 'Over-abstraction'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “the abstracted form of a delivery route optimisation problem”?',
          'options': ['Systematic trial and error', 'Brainstorming', 'Random trial and error', 'Vehicle Routing Problem (VRP)'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “removing details that are actually essential to a correct solution”?',
          'options': ['SAT solvers as reduction targets', 'Reduction', 'Floyd’s cycle detection', 'Over-abstraction'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “failing to remove enough clutter, leaving a problem too complex to analyse”?',
          'options': ['Under-abstraction', 'Random trial and error', 'Trial and error', 'Stack data structure'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “encoding hard problems like Sudoku or planning as Boolean satisfiability”?',
          'options': ['Under-abstraction', 'SAT solvers as reduction targets', 'Trial and error', 'Stack data structure'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a reduction of median-finding to the selection problem, running in linear time”?',
          'options': ['Quickselect', 'Systematic trial and error', 'Hypothesis testing', 'London Underground map'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “representing exam scheduling as assigning time-slot colours to course nodes”?',
          'options': ['Systematic trial and error', 'Graph colouring reduction', 'Over-abstraction', 'Reduction'],
          'correct': 1,
        },
        {
          'question': 'Reducing exam scheduling to a graph colouring problem is useful because:',
          'options': ['Graph theory is easier to understand', 'Efficient graph colouring algorithms already exist and can be directly applied', 'It eliminates the need for a computer', 'Graphs can represent any real-world problem'],
          'correct': 1,
        },
        {
          'question': 'When using analogy as a problem-solving technique, the greatest risk is:',
          'options': ['Solving the problem too quickly', 'A false analogy where superficial similarity leads to an incorrect solution', 'Over-simplifying the target problem', 'Spending too long finding a suitable source problem'],
          'correct': 1,
        },
        {
          'question': 'Ant colony optimisation is best described as:',
          'options': ['An exact algorithm for finding shortest paths', 'A heuristic inspired by ants depositing pheromones that approximates optimal routes', 'A divide and conquer technique', 'A proof-based method for network problems'],
          'correct': 1,
        },
      ];
    case 'cos102_u4_1': // Lateral Thinking & Means-End
      return [
        {
          'question': 'Which of the following best describes Lateral thinking?',
          'options': ['breaking a problem into smaller subproblems, solving recursively, then combining results', 'a creative approach, coined by Edward de Bono, that breaks free from linear thinking', 'reducing the gap between current and goal state by applying operators that cut differences', 'using intentionally false or impossible statements to jolt the mind out of its rut'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Means-end analysis?',
          'options': ['a creative approach, coined by Edward de Bono, that breaks free from linear thinking', 'identifying the fundamental underlying cause of a problem rather than its symptoms', 'reducing the gap between current and goal state by applying operators that cut differences', 'an RCA-driven review focused on systemic causes rather than individual blame'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Method of focal objects?',
          'options': ['a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)', 'forcing a connection between a focal problem and randomly chosen unrelated objects', 'systematically investigating existing sources and prior art before building something new', 'using a matrix (Zwicky box) to systematically explore all possible solution combinations'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Morphological analysis?',
          'options': ['a divide and conquer algorithm using pivot partitioning, average-case O(n log n)', 'using a matrix (Zwicky box) to systematically explore all possible solution combinations', 'breaking a problem into smaller subproblems, solving recursively, then combining results', 'a classic example where mirrors reduced perceived, not actual, waiting time'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Research (as a technique)?',
          'options': ['a top-down deductive approach using Boolean logic to combine failure events', 'an early AI program by Newell and Simon based on means-end analysis', 'a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)', 'systematically investigating existing sources and prior art before building something new'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Root cause analysis (RCA)?',
          'options': ['a classic example where mirrors reduced perceived, not actual, waiting time', 'identifying the fundamental underlying cause of a problem rather than its symptoms', 'using intentionally false or impossible statements to jolt the mind out of its rut', 'a divide and conquer algorithm with recurrence T(n) = 2T(n/2) + O(n), yielding O(n log n)'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Proof?',
          'options': ['reducing the gap between current and goal state by applying operators that cut differences', 'using a matrix (Zwicky box) to systematically explore all possible solution combinations', 'a divide and conquer algorithm achieving about O(n^2.807) instead of O(n^3)', 'establishing the truth of a statement through logical deduction from accepted axioms'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Divide and conquer?',
          'options': ['a top-down deductive approach using Boolean logic to combine failure events', 'a classic puzzle illustrating means-end analysis through recursive subgoal generation', 'a divide and conquer algorithm with recurrence T(n) = 2T(n/2) + O(n), yielding O(n log n)', 'breaking a problem into smaller subproblems, solving recursively, then combining results'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Provocation (lateral thinking)?',
          'options': ['using intentionally false or impossible statements to jolt the mind out of its rut', 'using a matrix (Zwicky box) to systematically explore all possible solution combinations', 'reducing the gap between current and goal state by applying operators that cut differences', 'a matrix listing parameters and possible values used in morphological analysis'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes The hotel elevator problem?',
          'options': ['breaking a problem into smaller subproblems, solving recursively, then combining results', 'systematically investigating existing sources and prior art before building something new', 'a classic example where mirrors reduced perceived, not actual, waiting time', 'a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes General Problem Solver (GPS)?',
          'options': ['a divide and conquer algorithm with recurrence T(n) = 2T(n/2) + O(n), yielding O(n log n)', 'reducing the gap between current and goal state by applying operators that cut differences', 'a visual RCA tool categorising causes into groups such as Methods and Machines', 'an early AI program by Newell and Simon based on means-end analysis'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Tower of Hanoi?',
          'options': ['identifying the fundamental underlying cause of a problem rather than its symptoms', 'establishing the truth of a statement through logical deduction from accepted axioms', 'a classic puzzle illustrating means-end analysis through recursive subgoal generation', 'a divide and conquer algorithm achieving about O(n^2.807) instead of O(n^3)'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes The Five Whys?',
          'options': ['a creative approach, coined by Edward de Bono, that breaks free from linear thinking', 'a root cause analysis technique of repeatedly asking ‘why’ to reach the root cause', 'forcing a connection between a focal problem and randomly chosen unrelated objects', 'systematically investigating existing sources and prior art before building something new'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Fishbone (Ishikawa) diagram?',
          'options': ['a visual RCA tool categorising causes into groups such as Methods and Machines', 'using a matrix (Zwicky box) to systematically explore all possible solution combinations', 'forcing a connection between a focal problem and randomly chosen unrelated objects', 'moving from specific observations to a probable, but not guaranteed, conclusion'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Fault Tree Analysis (FTA)?',
          'options': ['a divide and conquer algorithm with recurrence T(n) = 2T(n/2) + O(n), yielding O(n log n)', 'a visual RCA tool categorising causes into groups such as Methods and Machines', 'a top-down deductive approach using Boolean logic to combine failure events', 'establishing the truth of a statement through logical deduction from accepted axioms'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Deductive reasoning?',
          'options': ['moving from specific observations to a probable, but not guaranteed, conclusion', 'a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)', 'a condition proven true before and after each loop iteration, used to verify correctness', 'moving from general principles to a specific, guaranteed conclusion'],
          'correct': 3,
        },
        {
          'question': 'Edward de Bono\'s concept of "provocation" in lateral thinking involves:',
          'options': ['Asking senior colleagues for ideas', 'Using intentionally impossible or absurd statements to break established thinking patterns', 'Researching what competitors have done', 'Testing multiple solutions simultaneously'],
          'correct': 1,
        },
        {
          'question': 'Means-end analysis solves problems by:',
          'options': ['Listing all possible solutions', 'Repeatedly identifying and reducing the difference between the current state and the goal state', 'Starting from the goal and working backwards only', 'Dividing the problem into exactly two halves'],
          'correct': 1,
        },
        {
          'question': 'The General Problem Solver (GPS) by Newell and Simon was significant because:',
          'options': ['It was the first computer to pass the Turing test', 'It demonstrated that means-end analysis could be implemented as a general AI problem-solving strategy', 'It solved the Halting Problem', 'It introduced the concept of recursion'],
          'correct': 1,
        },
      ];
    case 'cos102_u4_2': // Root Cause & Divide-Conquer
      return [
        {
          'question': 'Which of the following best describes Inductive reasoning?',
          'options': ['a creative approach, coined by Edward de Bono, that breaks free from linear thinking', 'moving from specific observations to a probable, but not guaranteed, conclusion', 'using intentionally false or impossible statements to jolt the mind out of its rut', 'establishing the truth of a statement through logical deduction from accepted axioms'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Loop invariant?',
          'options': ['a divide and conquer algorithm using pivot partitioning, average-case O(n log n)', 'a condition proven true before and after each loop iteration, used to verify correctness', 'establishing the truth of a statement through logical deduction from accepted axioms', 'forcing a connection between a focal problem and randomly chosen unrelated objects'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Merge sort?',
          'options': ['a divide and conquer algorithm achieving about O(n^2.807) instead of O(n^3)', 'a classic example where mirrors reduced perceived, not actual, waiting time', 'a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)', 'a divide and conquer algorithm with recurrence T(n) = 2T(n/2) + O(n), yielding O(n log n)'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Quicksort?',
          'options': ['a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)', 'a divide and conquer algorithm using pivot partitioning, average-case O(n log n)', 'forcing a connection between a focal problem and randomly chosen unrelated objects', 'a creative approach, coined by Edward de Bono, that breaks free from linear thinking'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Strassen’s Matrix Multiplication?',
          'options': ['an early AI program by Newell and Simon based on means-end analysis', 'a root cause analysis technique of repeatedly asking ‘why’ to reach the root cause', 'a divide and conquer algorithm achieving about O(n^2.807) instead of O(n^3)', 'identifying the fundamental underlying cause of a problem rather than its symptoms'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Fast Fourier Transform (FFT)?',
          'options': ['breaking a problem into smaller subproblems, solving recursively, then combining results', 'a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)', 'establishing the truth of a statement through logical deduction from accepted axioms', 'identifying the fundamental underlying cause of a problem rather than its symptoms'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Zwicky box?',
          'options': ['establishing the truth of a statement through logical deduction from accepted axioms', 'a matrix listing parameters and possible values used in morphological analysis', 'a divide and conquer algorithm achieving about O(n^2.807) instead of O(n^3)', 'reducing the gap between current and goal state by applying operators that cut differences'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Blameless post-mortem?',
          'options': ['an RCA-driven review focused on systemic causes rather than individual blame', 'moving from general principles to a specific, guaranteed conclusion', 'breaking a problem into smaller subproblems, solving recursively, then combining results', 'moving from specific observations to a probable, but not guaranteed, conclusion'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a creative approach, coined by Edward de Bono, that breaks free from linear thinking”?',
          'options': ['Loop invariant', 'Proof', 'Lateral thinking', 'Divide and conquer'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “reducing the gap between current and goal state by applying operators that cut differences”?',
          'options': ['Blameless post-mortem', 'The hotel elevator problem', 'Means-end analysis', 'Inductive reasoning'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “forcing a connection between a focal problem and randomly chosen unrelated objects”?',
          'options': ['Method of focal objects', 'Merge sort', 'Fishbone (Ishikawa) diagram', 'Research (as a technique)'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “using a matrix (Zwicky box) to systematically explore all possible solution combinations”?',
          'options': ['Morphological analysis', 'Merge sort', 'Root cause analysis (RCA)', 'Deductive reasoning'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “systematically investigating existing sources and prior art before building something new”?',
          'options': ['Method of focal objects', 'Fishbone (Ishikawa) diagram', 'Research (as a technique)', 'Proof'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “identifying the fundamental underlying cause of a problem rather than its symptoms”?',
          'options': ['General Problem Solver (GPS)', 'Root cause analysis (RCA)', 'Merge sort', 'Proof'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “establishing the truth of a statement through logical deduction from accepted axioms”?',
          'options': ['General Problem Solver (GPS)', 'Loop invariant', 'Proof', 'The hotel elevator problem'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “breaking a problem into smaller subproblems, solving recursively, then combining results”?',
          'options': ['Divide and conquer', 'Lateral thinking', 'Fault Tree Analysis (FTA)', 'Morphological analysis'],
          'correct': 0,
        },
        {
          'question': 'A Fishbone (Ishikawa) diagram organises potential causes of a problem into:',
          'options': ['A timeline of events', 'Categories such as Methods, Machines, Materials, and Manpower branching from the effect', 'A ranked list by probability', 'A flowchart of decision points'],
          'correct': 1,
        },
        {
          'question': 'The Five Whys technique is most effective when:',
          'options': ['Applied to well-defined mathematical problems', 'Repeatedly asking "why" to dig past symptoms and reach the true root cause of a failure', 'Combined with brainstorming to generate many causes simultaneously', 'Used before defining the problem statement'],
          'correct': 1,
        },
        {
          'question': 'Merge sort is a classic example of divide and conquer because it:',
          'options': ['Uses a pivot element to partition', 'Recursively splits arrays in half, sorts each half independently, then merges the sorted halves', 'Makes locally optimal choices at each step', 'Requires no extra memory'],
          'correct': 1,
        },
      ];
    case 'cos102_u4_3': // Reasoning & Proof
      return [
        {
          'question': 'Which term is best described as: “using intentionally false or impossible statements to jolt the mind out of its rut”?',
          'options': ['Deductive reasoning', 'Blameless post-mortem', 'General Problem Solver (GPS)', 'Provocation (lateral thinking)'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a classic example where mirrors reduced perceived, not actual, waiting time”?',
          'options': ['Proof', 'The hotel elevator problem', 'Fishbone (Ishikawa) diagram', 'Loop invariant'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “an early AI program by Newell and Simon based on means-end analysis”?',
          'options': ['The hotel elevator problem', 'Lateral thinking', 'General Problem Solver (GPS)', 'Fault Tree Analysis (FTA)'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “a classic puzzle illustrating means-end analysis through recursive subgoal generation”?',
          'options': ['Tower of Hanoi', 'Inductive reasoning', 'Fault Tree Analysis (FTA)', 'Root cause analysis (RCA)'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a root cause analysis technique of repeatedly asking ‘why’ to reach the root cause”?',
          'options': ['The hotel elevator problem', 'The Five Whys', 'Quicksort', 'Zwicky box'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a visual RCA tool categorising causes into groups such as Methods and Machines”?',
          'options': ['General Problem Solver (GPS)', 'Fishbone (Ishikawa) diagram', 'Tower of Hanoi', 'Inductive reasoning'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a top-down deductive approach using Boolean logic to combine failure events”?',
          'options': ['Morphological analysis', 'Proof', 'Provocation (lateral thinking)', 'Fault Tree Analysis (FTA)'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “moving from general principles to a specific, guaranteed conclusion”?',
          'options': ['Deductive reasoning', 'General Problem Solver (GPS)', 'Quicksort', 'Zwicky box'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “moving from specific observations to a probable, but not guaranteed, conclusion”?',
          'options': ['Divide and conquer', 'Inductive reasoning', 'Merge sort', 'Blameless post-mortem'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “a condition proven true before and after each loop iteration, used to verify correctness”?',
          'options': ['Loop invariant', 'Fast Fourier Transform (FFT)', 'Strassen’s Matrix Multiplication', 'The hotel elevator problem'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a divide and conquer algorithm with recurrence T(n) = 2T(n/2) + O(n), yielding O(n log n)”?',
          'options': ['Merge sort', 'Fault Tree Analysis (FTA)', 'The hotel elevator problem', 'Strassen’s Matrix Multiplication'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a divide and conquer algorithm using pivot partitioning, average-case O(n log n)”?',
          'options': ['Quicksort', 'Zwicky box', 'General Problem Solver (GPS)', 'Tower of Hanoi'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a divide and conquer algorithm achieving about O(n^2.807) instead of O(n^3)”?',
          'options': ['Divide and conquer', 'Fast Fourier Transform (FFT)', 'Inductive reasoning', 'Strassen’s Matrix Multiplication'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “a divide and conquer algorithm computing the discrete Fourier transform in O(n log n)”?',
          'options': ['Fast Fourier Transform (FFT)', 'Fishbone (Ishikawa) diagram', 'Zwicky box', 'Blameless post-mortem'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a matrix listing parameters and possible values used in morphological analysis”?',
          'options': ['Means-end analysis', 'Loop invariant', 'Zwicky box', 'Fault Tree Analysis (FTA)'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “an RCA-driven review focused on systemic causes rather than individual blame”?',
          'options': ['Tower of Hanoi', 'Blameless post-mortem', 'Root cause analysis (RCA)', 'Lateral thinking'],
          'correct': 1,
        },
        {
          'question': 'Deductive reasoning guarantees its conclusion because:',
          'options': ['It is based on many observations', 'If the premises are true and the logic is valid, the conclusion must be true', 'It uses probability theory', 'It has been verified experimentally'],
          'correct': 1,
        },
        {
          'question': 'Inductive reasoning differs from deductive reasoning in that inductive conclusions are:',
          'options': ['Always true', 'Probable but not guaranteed, based on observed patterns', 'Based on axioms', 'Derived mathematically'],
          'correct': 1,
        },
        {
          'question': 'A loop invariant is a condition that must hold:',
          'options': ['Only at the start of a loop', 'Before and after every iteration of a loop, used to prove correctness', 'Only when the loop terminates', 'Only for while loops, not for loops'],
          'correct': 1,
        },
      ];
    case 'cos102_u5_1': // Flowcharts
      return [
        {
          'question': 'Which of the following best describes Understand the Problem (in depth)?',
          'options': ['associating each solution technique with the stage where it is most useful', 'the quality of handling invalid input gracefully', 'structuring an algorithm into well-organised sub-algorithms or functions', 'building a complete, accurate, precise mental model of what is given and required'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Devise a Plan (in depth)?',
          'options': ['the engineering virtue of keeping an algorithm simple to understand and maintain', 'testing, verifying correctness, analysing efficiency, and reflecting for generalisation', 'selecting the strategy or approach, such as analogy, reduction, or divide and conquer', 'a design methodology working from general modules to specific, single-responsibility functions'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Carry Out the Plan (in depth)?',
          'options': ['an input at the boundary or extreme of the expected range that must be tested', 'starting with a coarse description and repeatedly breaking steps into detailed sub-steps', 'executing the strategy through stepwise refinement into pseudocode or code', 'the engineering virtue of keeping an algorithm simple to understand and maintain'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Look Back (in depth)?',
          'options': ['structuring an algorithm into well-organised sub-algorithms or functions', 'testing, verifying correctness, analysing efficiency, and reflecting for generalisation', 'using imperative verbs, numbered steps, and explicit variables before coding', 'an example rule: divisible by 400 is leap; else by 100 is not; else by 4 is leap'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes Stepwise refinement?',
          'options': ['a design methodology working from general modules to specific, single-responsibility functions', 'a dummy placeholder implementation used to test high-level flow before full implementation', 'starting with a coarse description and repeatedly breaking steps into detailed sub-steps', 'associating each solution technique with the stage where it is most useful'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Top-down design?',
          'options': ['a design methodology working from general modules to specific, single-responsibility functions', 'using imperative verbs, numbered steps, and explicit variables before coding', 'a dummy placeholder implementation used to test high-level flow before full implementation', 'testing, verifying correctness, analysing efficiency, and reflecting for generalisation'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Stub?',
          'options': ['a dummy placeholder implementation used to test high-level flow before full implementation', 'an algorithm pattern that generalises easily to finding the maximum of n numbers', 'using imperative verbs, numbered steps, and explicit variables before coding', 'associating each solution technique with the stage where it is most useful'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Edge case?',
          'options': ['an input at the boundary or extreme of the expected range that must be tested', 'a dummy placeholder implementation used to test high-level flow before full implementation', 'testing, verifying correctness, analysing efficiency, and reflecting for generalisation', 'associating each solution technique with the stage where it is most useful'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Leap year algorithm?',
          'options': ['an example rule: divisible by 400 is leap; else by 100 is not; else by 4 is leap', 'the worked walkthrough example applying all four Pólya steps', 'starting with a coarse description and repeatedly breaking steps into detailed sub-steps', 'selecting the strategy or approach, such as analogy, reduction, or divide and conquer'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Factorial algorithm?',
          'options': ['testing, verifying correctness, analysing efficiency, and reflecting for generalisation', 'an example rule: divisible by 400 is leap; else by 100 is not; else by 4 is leap', 'an example showing the need to explicitly handle the n = 0 base case for definiteness', 'building a complete, accurate, precise mental model of what is given and required'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Mapping techniques to Pólya stages?',
          'options': ['structuring an algorithm into well-organised sub-algorithms or functions', 'associating each solution technique with the stage where it is most useful', 'the engineering virtue of keeping an algorithm simple to understand and maintain', 'the quality of handling invalid input gracefully'],
          'correct': 1,
        },
        {
          'question': 'In a standard flowchart, an oval (terminator) shape is used to represent:',
          'options': ['A decision point', 'The start or end of a process', 'A process or calculation step', 'Input or output operations'],
          'correct': 1,
        },
        {
          'question': 'A diamond shape in a flowchart represents:',
          'options': ['A process step such as a calculation', 'A decision point where the flow branches based on a yes/no condition', 'The start or end of the algorithm', 'Data input from the user'],
          'correct': 1,
        },
        {
          'question': 'A rectangle (process box) in a flowchart is used to represent:',
          'options': ['A decision or condition', 'An action, calculation, or processing step', 'The beginning or end of the algorithm', 'Data flowing between processes'],
          'correct': 1,
        },
        {
          'question': 'A parallelogram in a standard flowchart represents:',
          'options': ['A subprocess that is defined elsewhere', 'An input or output operation (e.g. reading from keyboard or printing to screen)', 'A decision point', 'A loop back to a previous step'],
          'correct': 1,
        },
        {
          'question': 'Arrows in a flowchart represent:',
          'options': ['Decision branches only', 'The sequence and direction of flow between steps', 'Data values being stored', 'The time taken by each step'],
          'correct': 1,
        },
        {
          'question': 'A predefined process symbol (rectangle with double vertical lines) in a flowchart means:',
          'options': ['A repeated loop', 'A call to a subroutine or function defined elsewhere', 'The termination of the program', 'A conditional branch'],
          'correct': 1,
        },
        {
          'question': 'A connector circle in a flowchart is used when:',
          'options': ['A loop is detected', 'The flowchart continues on another page or from another point to avoid crossing arrows', 'Two parallel processes must synchronise', 'The algorithm has reached a decision'],
          'correct': 1,
        },
        {
          'question': 'What shape would you use to represent "Print the result to the screen" in a flowchart?',
          'options': ['Oval', 'Diamond', 'Rectangle', 'Parallelogram'],
          'correct': 3,
        },
        {
          'question': 'A flowchart for "calculate tax if income > 50,000" would require which shape at the income check?',
          'options': ['Parallelogram', 'Rectangle', 'Diamond', 'Oval'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is a key advantage of using a flowchart before writing code?',
          'options': ['It generates code automatically', 'It makes the logic visually clear and identifies errors before coding begins', 'It defines the programming language to use', 'It replaces the need for pseudocode entirely'],
          'correct': 1,
        },
        {
          'question': 'Flowcharts, pseudocode, and programming languages all serve to:',
          'options': ['Run directly on a computer processor', 'Express the logic of an algorithm, each at a different level of formality', 'Replace the need for problem analysis', 'Generate documentation automatically'],
          'correct': 1,
        },
        {
          'question': 'Which statement best describes the relationship between a flowchart and pseudocode?',
          'options': ['Flowcharts are more precise than pseudocode', 'Both represent the same algorithm — a flowchart visually, pseudocode in structured English text', 'Pseudocode can only be used for simple programs', 'Flowcharts are only used in business, not computing'],
          'correct': 1,
        },
      ];
    case 'cos102_u5_2': // Pseudocode & Decision Trees
      return [
        {
          'question': 'Which of the following best describes KISS principle?',
          'options': ['the quality of handling invalid input gracefully', 'an algorithm pattern that generalises easily to finding the maximum of n numbers', 'selecting the strategy or approach, such as analogy, reduction, or divide and conquer', 'the engineering virtue of keeping an algorithm simple to understand and maintain'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Robustness (of an algorithm)?',
          'options': ['the quality of handling invalid input gracefully', 'testing, verifying correctness, analysing efficiency, and reflecting for generalisation', 'an example rule: divisible by 400 is leap; else by 100 is not; else by 4 is leap', 'associating each solution technique with the stage where it is most useful'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes Modularity?',
          'options': ['using imperative verbs, numbered steps, and explicit variables before coding', 'executing the strategy through stepwise refinement into pseudocode or code', 'the quality of handling invalid input gracefully', 'structuring an algorithm into well-organised sub-algorithms or functions'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Natural language algorithm description?',
          'options': ['a design methodology working from general modules to specific, single-responsibility functions', 'structuring an algorithm into well-organised sub-algorithms or functions', 'using imperative verbs, numbered steps, and explicit variables before coding', 'a dummy placeholder implementation used to test high-level flow before full implementation'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Find the Largest of Three Numbers?',
          'options': ['starting with a coarse description and repeatedly breaking steps into detailed sub-steps', 'testing, verifying correctness, analysing efficiency, and reflecting for generalisation', 'the worked walkthrough example applying all four Pólya steps', 'selecting the strategy or approach, such as analogy, reduction, or divide and conquer'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Running maximum approach?',
          'options': ['an algorithm pattern that generalises easily to finding the maximum of n numbers', 'an example rule: divisible by 400 is leap; else by 100 is not; else by 4 is leap', 'the engineering virtue of keeping an algorithm simple to understand and maintain', 'a design methodology working from general modules to specific, single-responsibility functions'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “building a complete, accurate, precise mental model of what is given and required”?',
          'options': ['Stepwise refinement', 'Top-down design', 'Understand the Problem (in depth)', 'Leap year algorithm'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “selecting the strategy or approach, such as analogy, reduction, or divide and conquer”?',
          'options': ['Look Back (in depth)', 'Devise a Plan (in depth)', 'Factorial algorithm', 'Top-down design'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “executing the strategy through stepwise refinement into pseudocode or code”?',
          'options': ['Find the Largest of Three Numbers', 'Carry Out the Plan (in depth)', 'Stub', 'Factorial algorithm'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “testing, verifying correctness, analysing efficiency, and reflecting for generalisation”?',
          'options': ['Leap year algorithm', 'Natural language algorithm description', 'Look Back (in depth)', 'Stub'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “starting with a coarse description and repeatedly breaking steps into detailed sub-steps”?',
          'options': ['Mapping techniques to Pólya stages', 'Devise a Plan (in depth)', 'Stepwise refinement', 'Robustness (of an algorithm)'],
          'correct': 2,
        },
        {
          'question': 'Pseudocode is best described as:',
          'options': ['Invalid code that crashes the compiler', 'Structured informal language that describes an algorithm\'s logic without strict syntax rules', 'A compiled programming language', 'A flowchart written in words'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is a characteristic of good pseudocode?',
          'options': ['It must compile without errors', 'It uses imperative verbs, clear variable names, and numbered steps to describe logic precisely', 'It is identical to the final code', 'It requires a specific programming language syntax'],
          'correct': 1,
        },
        {
          'question': 'Pseudocode uses "IF...THEN...ELSE" to represent:',
          'options': ['A loop that repeats', 'A decision structure where different actions occur based on a condition', 'A function call', 'Data input from a user'],
          'correct': 1,
        },
        {
          'question': 'A WHILE loop in pseudocode means:',
          'options': ['Execute the block once only', 'Repeat the block of steps as long as the given condition remains true', 'Skip the block if a condition is false', 'Call a subroutine repeatedly'],
          'correct': 1,
        },
        {
          'question': 'What is the main difference between pseudocode and a programming language?',
          'options': ['Pseudocode is faster to execute', 'Pseudocode has no strict syntax and cannot be run by a computer; it is for human understanding', 'Programming languages are easier to read', 'Pseudocode can only represent sequential algorithms'],
          'correct': 1,
        },
        {
          'question': 'A decision tree is a tool used to:',
          'options': ['Sort data in ascending order', 'Model decisions and their possible consequences as a branching tree structure', 'Draw flowcharts automatically', 'Compress data for storage'],
          'correct': 1,
        },
        {
          'question': 'In a decision tree, each internal (non-leaf) node represents:',
          'options': ['A final outcome or result', 'A test or decision on a feature or condition', 'A loop back to the root', 'An input operation'],
          'correct': 1,
        },
        {
          'question': 'The leaf nodes at the ends of a decision tree represent:',
          'options': ['Further decisions to be made', 'The final classification, action, or outcome', 'Loop conditions', 'Variables to be initialised'],
          'correct': 1,
        },
        {
          'question': 'How does a decision tree differ from a flowchart?',
          'options': ['A decision tree can only have two branches per node', 'A decision tree focuses purely on decisions and outcomes without process steps; a flowchart shows the full process flow including calculations and I/O', 'Flowcharts are used in data science; decision trees are used in programming', 'They are identical tools with different names'],
          'correct': 1,
        },
        {
          'question': 'A decision tree used to decide loan approval (income > threshold AND credit score > threshold) would have how many leaf nodes at minimum?',
          'options': ['1', '2', '3', '4'],
          'correct': 3,
        },
        {
          'question': 'Which of the following sequences correctly represents the typical problem-solving design workflow?',
          'options': ['Code → Pseudocode → Flowchart → Test', 'Flowchart/Pseudocode → Code → Test → Reflect', 'Test → Code → Pseudocode', 'Code directly, no planning needed'],
          'correct': 1,
        },
        {
          'question': 'Converting pseudocode to a programming language is relatively straightforward because:',
          'options': ['They use the same syntax', 'Pseudocode mirrors programming constructs (IF/ELSE, WHILE, FOR) in plain language, making translation systematic', 'Compilers can read pseudocode directly', 'Pseudocode is already a subset of Python'],
          'correct': 1,
        },
      ];
    case 'cos102_u5_3': // VBA as a Problem-Solving Tool
      return [
        {
          'question': 'Which term is best described as: “a design methodology working from general modules to specific, single-responsibility functions”?',
          'options': ['Top-down design', 'Mapping techniques to Pólya stages', 'Carry Out the Plan (in depth)', 'Find the Largest of Three Numbers'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “a dummy placeholder implementation used to test high-level flow before full implementation”?',
          'options': ['Top-down design', 'Stub', 'Running maximum approach', 'Find the Largest of Three Numbers'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “an input at the boundary or extreme of the expected range that must be tested”?',
          'options': ['KISS principle', 'Natural language algorithm description', 'Edge case', 'Find the Largest of Three Numbers'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “an example rule: divisible by 400 is leap; else by 100 is not; else by 4 is leap”?',
          'options': ['Leap year algorithm', 'Robustness (of an algorithm)', 'Carry Out the Plan (in depth)', 'Modularity'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “an example showing the need to explicitly handle the n = 0 base case for definiteness”?',
          'options': ['Leap year algorithm', 'Factorial algorithm', 'Natural language algorithm description', 'Stepwise refinement'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “associating each solution technique with the stage where it is most useful”?',
          'options': ['Natural language algorithm description', 'Leap year algorithm', 'Mapping techniques to Pólya stages', 'Robustness (of an algorithm)'],
          'correct': 2,
        },
        {
          'question': 'Which term is best described as: “the engineering virtue of keeping an algorithm simple to understand and maintain”?',
          'options': ['Carry Out the Plan (in depth)', 'KISS principle', 'Stepwise refinement', 'Edge case'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “the quality of handling invalid input gracefully”?',
          'options': ['Robustness (of an algorithm)', 'Carry Out the Plan (in depth)', 'Running maximum approach', 'Modularity'],
          'correct': 0,
        },
        {
          'question': 'Which term is best described as: “structuring an algorithm into well-organised sub-algorithms or functions”?',
          'options': ['Edge case', 'Modularity', 'Top-down design', 'Stub'],
          'correct': 1,
        },
        {
          'question': 'Which term is best described as: “using imperative verbs, numbered steps, and explicit variables before coding”?',
          'options': ['Look Back (in depth)', 'Stub', 'Robustness (of an algorithm)', 'Natural language algorithm description'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “the worked walkthrough example applying all four Pólya steps”?',
          'options': ['Robustness (of an algorithm)', 'Natural language algorithm description', 'Stepwise refinement', 'Find the Largest of Three Numbers'],
          'correct': 3,
        },
        {
          'question': 'Which term is best described as: “an algorithm pattern that generalises easily to finding the maximum of n numbers”?',
          'options': ['Carry Out the Plan (in depth)', 'Stepwise refinement', 'Stub', 'Running maximum approach'],
          'correct': 3,
        },
        {
          'question': 'VBA stands for:',
          'options': ['Visual Basic Application', 'Visual Basic for Applications', 'Variable-Based Algorithm', 'Visual Binary Analysis'],
          'correct': 1,
        },
        {
          'question': 'VBA is primarily used as a problem-solving tool within:',
          'options': ['Web browsers', 'Microsoft Office applications such as Excel, Word, and Access', 'Mobile app development', 'Operating system kernels'],
          'correct': 1,
        },
        {
          'question': 'In VBA, a Sub procedure is used to:',
          'options': ['Return a value to the calling code', 'Perform a series of actions without returning a value', 'Declare a variable', 'Create a new worksheet'],
          'correct': 1,
        },
        {
          'question': 'A VBA Function procedure differs from a Sub in that a Function:',
          'options': ['Can only be called once', 'Returns a value that can be used in a formula or expression', 'Does not accept parameters', 'Runs automatically when the workbook opens'],
          'correct': 1,
        },
        {
          'question': 'Which VBA statement is used to make a decision based on a condition?',
          'options': ['For...Next', 'Do...While', 'If...Then...Else', 'Select...End Select only'],
          'correct': 2,
        },
        {
          'question': 'In VBA, a For...Next loop is used to:',
          'options': ['Repeat a block of code a specific number of times', 'Repeat until a condition becomes true', 'Call a subroutine repeatedly', 'Handle errors in code'],
          'correct': 0,
        },
        {
          'question': 'Which VBA loop structure repeats as long as a condition remains true?',
          'options': ['For...Next', 'Do While...Loop', 'Select Case', 'With...End With'],
          'correct': 1,
        },
        {
          'question': 'In VBA, the MsgBox function is used to:',
          'options': ['Read input from a cell', 'Display a message dialog box to the user', 'Send email from Excel', 'Format a worksheet'],
          'correct': 1,
        },
        {
          'question': 'The InputBox function in VBA allows you to:',
          'options': ['Style a text input field in Word', 'Prompt the user for input and capture the entered value', 'Read data from a file automatically', 'Create a dropdown list in Excel'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes how VBA relates to problem solving?',
          'options': ['VBA replaces the need for algorithm design', 'VBA allows users to automate repetitive tasks and implement algorithms directly within Office applications, making it a practical problem-solving tool', 'VBA is only used for data visualisation', 'VBA is a standalone programming language unrelated to Office'],
          'correct': 1,
        },
        {
          'question': 'A VBA macro that automatically formats and totals a monthly sales report is solving a problem through:',
          'options': ['Reduction', 'Automation of a routine, well-defined task using an implemented algorithm', 'Lateral thinking', 'Root cause analysis'],
          'correct': 1,
        },
        {
          'question': 'In VBA, declaring a variable with "Dim x As Integer" means:',
          'options': ['x can hold any data type', 'x is reserved to hold whole number values within a specific range', 'x is a constant that cannot change', 'x is accessible from any module in the workbook'],
          'correct': 1,
        },
        {
          'question': 'Which VBA structure is most appropriate when checking a variable against many possible values?',
          'options': ['For...Next', 'Do While...Loop', 'If...Then...Else if used once', 'Select Case'],
          'correct': 3,
        },
        {
          'question': 'A VBA Sub that reads student marks from an Excel range and prints "Pass" or "Fail" uses which two key programming constructs?',
          'options': ['Recursion and abstraction', 'A loop (to iterate through students) and an If statement (to check the mark threshold)', 'Functions and sorting algorithms', 'Classes and objects'],
          'correct': 1,
        },
        {
          'question': 'What is the relationship between a flowchart, pseudocode, and VBA code for the same problem?',
          'options': ['They are three completely different representations with nothing in common', 'The flowchart shows the visual logic, pseudocode translates that to structured text, and VBA code implements it in a syntax a computer can run — all three describe the same algorithm at increasing levels of formality', 'VBA code is always written before the flowchart', 'Only one of the three is needed to solve a problem'],
          'correct': 1,
        },
      ];
    default:
      return [];
  }
}