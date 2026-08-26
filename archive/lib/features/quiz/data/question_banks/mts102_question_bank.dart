// lib/features/quiz/data/question_banks/mts102_question_bank.dart
//
// Additional MTS102 (Introductory Mathematics II) quiz questions,
// sourced from the 420-question PDF quiz bank (20 questions per
// fine-grained topic, 21 topics). These are ADDED ON TOP OF the
// original 5 questions per topic in mts102_lessons.dart (not a
// replacement) -- see topic_question_source.dart for how the two
// sources are merged.
//
// Keyed by the same lessonId used in subjects_data.dart and
// mts102_lessons.dart (e.g. 'mts102_u1_1').

List<Map<String, dynamic>> getMTS102ExtraQuestions(String lessonId) {
  switch (lessonId) {
    case 'mts102_u1_1': // Function Basics
      return [
        {
          'question': 'Which of the following relations is a function?',
          'options': ['{(1,2),(2,2),(2,3)}', '{(1,2),(1,3),(2,4)}', '{(0,1),(0,2),(1,3)}', '{(1,2),(2,3),(3,4)}'],
          'correct': 3,
        },
        {
          'question': 'If f(x) = 2x + 3, what is f(4)?',
          'options': ['7', '14', '11', '10'],
          'correct': 2,
        },
        {
          'question': 'If f(x) = x2 - 1, what is f(-3)?',
          'options': ['-8', '-10', '10', '8'],
          'correct': 3,
        },
        {
          'question': 'Which test determines if a graph represents a function?',
          'options': ['Horizontal line test', 'Slope test', 'Vertical line test', 'Symmetry test'],
          'correct': 2,
        },
        {
          'question': 'If f(x) = 3x - 5, find x such that f(x) = 4.',
          'options': ['4', '-3', '1', '3'],
          'correct': 3,
        },
        {
          'question': 'What is the value of f(0) if f(x) = 5x2 + 2x - 7?',
          'options': ['7', '-2', '0', '-7'],
          'correct': 3,
        },
        {
          'question': 'A function that assigns each input to itself is called:',
          'options': ['an inverse function', 'a constant function', 'the identity function', 'a quadratic function'],
          'correct': 2,
        },
        {
          'question': 'If g(x) = 1/x, what is the value g cannot take at x = 0?',
          'options': ['g(0) = 0', 'g(0) = -1', 'g(0) is undefined', 'g(0) = 1'],
          'correct': 2,
        },
        {
          'question': 'If f(x) = x + 2 and f(a) = 9, what is a?',
          'options': ['7', '9', '11', '4.5'],
          'correct': 0,
        },
        {
          'question': 'Which of these is NOT a function of x?',
          'options': ['y = x2', 'y = |x|', 'x = y2', 'y = 3x'],
          'correct': 2,
        },
        {
          'question': 'If f(x) = 4x2, find f(-2).',
          'options': ['8', '-16', '-8', '16'],
          'correct': 3,
        },
        {
          'question': 'The set of all possible inputs of a function is its:',
          'options': ['image', 'codomain', 'range', 'domain'],
          'correct': 3,
        },
        {
          'question': 'If h(x) = 2x - 1 and h(k) = 5, find k.',
          'options': ['5', '2', '3', '4'],
          'correct': 2,
        },
        {
          'question': 'Which pair represents a one-to-one function?',
          'options': ['f(x) = |x|', 'f(x) = x2 - 4', 'f(x) = x2', 'f(x) = x'],
          'correct': 3,
        },
        {
          'question': 'If f(x) = -2x + 6, what is f(1) + f(2)?',
          'options': ['6', '4', '10', '8'],
          'correct': 0,
        },
        {
          'question': 'A function where f(-x) = f(x) for all x is called:',
          'options': ['neither', 'even', 'linear', 'odd'],
          'correct': 1,
        },
        {
          'question': 'A function where f(-x) = -f(x) for all x is called:',
          'options': ['even', 'periodic', 'constant', 'odd'],
          'correct': 3,
        },
        {
          'question': 'If f(x) = x3, is f even, odd, or neither?',
          'options': ['even', 'constant', 'odd', 'neither'],
          'correct': 2,
        },
        {
          'question': 'If f(x) = x2 + 1, is f even, odd, or neither?',
          'options': ['constant', 'neither', 'odd', 'even'],
          'correct': 3,
        },
        {
          'question': 'What is the output called in a function y = f(x)?',
          'options': ['the dependent variable', 'the independent variable', 'the domain', 'the coefficient'],
          'correct': 0,
        },
      ];

    case 'mts102_u1_2': // Domain and Range
      return [
        {
          'question': 'What is the domain of f(x) = 1 / (x + 1)?',
          'options': ['All real numbers except x = 4', 'All real numbers except x = -2', 'All real numbers except x = -3', 'All real numbers except x = -1'],
          'correct': 3,
        },
        {
          'question': 'What is the domain of f(x) = ln(x - 5)?',
          'options': ['x > 5', 'x ≥ 5', 'x > 7', 'x < 5'],
          'correct': 0,
        },
        {
          'question': 'What is the domain of f(x) = sqrt(x - 4)?',
          'options': ['x ≤ 4', 'x ≥ 6', 'x ≥ 4', 'x > 4'],
          'correct': 2,
        },
        {
          'question': 'What is the domain of f(x) = 1 / (x - 6)?',
          'options': ['All real numbers except x = -1', 'All real numbers except x = 0', 'All real numbers except x = -2', 'All real numbers except x = 6'],
          'correct': 3,
        },
        {
          'question': 'What is the domain of f(x) = 1 / (x - 4)?',
          'options': ['All real numbers except x = 0', 'All real numbers except x = -4', 'All real numbers except x = 4', 'All real numbers except x = 1'],
          'correct': 2,
        },
        {
          'question': 'What is the domain of f(x) = ln(x - 2)?',
          'options': ['x > 2', 'x < 2', 'x ≥ 2', 'x > 1'],
          'correct': 0,
        },
        {
          'question': 'What is the domain of f(x) = sqrt(x + 3)?',
          'options': ['x ≤ -3', 'x > -3', 'x ≥ -3', 'x ≥ -1'],
          'correct': 2,
        },
        {
          'question': 'What is the domain of f(x) = 1 / (x + 4)?',
          'options': ['All real numbers except x = 6', 'All real numbers except x = 4', 'All real numbers except x = 0', 'All real numbers except x = -4'],
          'correct': 3,
        },
        {
          'question': 'What is the domain of f(x) = ln(x - 1)?',
          'options': ['x < 1', 'x > 0', 'x ≥ 1', 'x > 1'],
          'correct': 3,
        },
        {
          'question': 'What is the domain of f(x) = sqrt(x + 4)?',
          'options': ['x ≥ -6', 'x ≤ -4', 'x > -4', 'x ≥ -4'],
          'correct': 3,
        },
        {
          'question': 'What is the domain of f(x) = ln(x - 6)?',
          'options': ['x > 8', 'x < 6', 'x ≥ 6', 'x > 6'],
          'correct': 3,
        },
        {
          'question': 'What is the domain of f(x) = 1 / (x - 5)?',
          'options': ['All real numbers except x = -5', 'All real numbers except x = 6', 'All real numbers except x = 5', 'All real numbers except x = 1'],
          'correct': 2,
        },
        {
          'question': 'What is the domain of f(x) = ln(x + 4)?',
          'options': ['x < -4', 'x ≥ -4', 'x > -4', 'x > -5'],
          'correct': 2,
        },
        {
          'question': 'What is the domain of f(x) = ln(x + 2)?',
          'options': ['x > -2', 'x > -4', 'x < -2', 'x ≥ -2'],
          'correct': 0,
        },
        {
          'question': 'What is the range of f(x) = (x + 2)2 - 2?',
          'options': ['y ≤ -2', 'all real numbers', 'y ≥ -2', 'y ≥ -1'],
          'correct': 2,
        },
        {
          'question': 'What is the range of f(x) = 2(x + 5)2 - 4?',
          'options': ['all real numbers', 'y ≥ -3', 'y ≥ -4', 'y ≤ -4'],
          'correct': 2,
        },
        {
          'question': 'What is the range of f(x) = 3(x + 4)2 + 3?',
          'options': ['y ≥ 3', 'y ≤ 3', 'all real numbers', 'y ≥ 5'],
          'correct': 0,
        },
        {
          'question': 'What is the range of f(x) = 2(x - 3)2 - 3?',
          'options': ['y ≥ -3', 'y ≥ -5', 'all real numbers', 'y ≤ -3'],
          'correct': 0,
        },
        {
          'question': 'What is the range of f(x) = 2(x + 4)2 - 4?',
          'options': ['y ≥ -4', 'all real numbers', 'y ≤ -4', 'y ≥ -6'],
          'correct': 0,
        },
        {
          'question': 'What is the range of f(x) = 4(x + 5)2 + 5?',
          'options': ['all real numbers', 'y ≥ 6', 'y ≤ 5', 'y ≥ 5'],
          'correct': 3,
        },
      ];

    case 'mts102_u1_3': // Function Operations
      return [
        {
          'question': 'Given f(x) = 1x - 2 and g(x) = 2x - 2, find (f o g)(-2) = f(g(-2)).',
          'options': ['-7', '-10', '-8', '-9'],
          'correct': 2,
        },
        {
          'question': 'Given f(x) = 4x + 3 and g(x) = 1x - 5, find (f+g)(-3).',
          'options': ['-20', '-17', '-19', '-16'],
          'correct': 1,
        },
        {
          'question': 'Given f(x) = 4x - 1 and g(x) = 4x - 1, find (f o g)(2) = f(g(2)).',
          'options': ['29', '30', '27', '28'],
          'correct': 2,
        },
        {
          'question': 'Given f(x) = 2x - 5 and g(x) = 5x + 3, find (f+g)(2).',
          'options': ['9', '12', '11', '14'],
          'correct': 1,
        },
        {
          'question': 'Given f(x) = 1x + 3 and g(x) = 1x - 3, find (f+g)(1).',
          'options': ['0', '5', '2', '-1'],
          'correct': 2,
        },
        {
          'question': 'Given f(x) = 5x + 4 and g(x) = 1x + 4, find (f+g)(0).',
          'options': ['7', '10', '8', '11'],
          'correct': 2,
        },
        {
          'question': 'Given f(x) = 2x - 1 and g(x) = 4x - 3, find (f·g)(0).',
          'options': ['0', '2', '4', '3'],
          'correct': 3,
        },
        {
          'question': 'Given f(x) = 5x - 1 and g(x) = 2x + 0, find (f+g)(-2).',
          'options': ['-16', '-15', '-17', '-14'],
          'correct': 1,
        },
        {
          'question': 'Given f(x) = 5x - 1 and g(x) = 1x - 3, find (f·g)(-3).',
          'options': ['96', '99', '93', '98'],
          'correct': 0,
        },
        {
          'question': 'Given f(x) = 5x - 2 and g(x) = 3x - 2, find (f·g)(1).',
          'options': ['4', '0', '2', '3'],
          'correct': 3,
        },
        {
          'question': 'Given f(x) = 3x - 5 and g(x) = 1x + 0, find (f-g)(2).',
          'options': ['-1', '2', '-3', '-2'],
          'correct': 0,
        },
        {
          'question': 'Given f(x) = 5x - 5 and g(x) = 1x - 4, find (f-g)(1).',
          'options': ['2', '3', '5', '0'],
          'correct': 1,
        },
        {
          'question': 'Given f(x) = 1x - 1 and g(x) = 3x - 5, find (f·g)(-2).',
          'options': ['33', '36', '31', '30'],
          'correct': 0,
        },
        {
          'question': 'Given f(x) = 5x - 3 and g(x) = 2x - 3, find (f-g)(0).',
          'options': ['-2', '0', '3', '-3'],
          'correct': 1,
        },
        {
          'question': 'Given f(x) = 3x - 3 and g(x) = 1x + 1, find (f+g)(3).',
          'options': ['8', '11', '10', '9'],
          'correct': 2,
        },
        {
          'question': 'Given f(x) = 1x + 5 and g(x) = 2x + 1, find (f·g)(-1).',
          'options': ['-4', '-7', '-5', '-1'],
          'correct': 0,
        },
        {
          'question': 'Given f(x) = 1x - 4 and g(x) = 3x - 3, find (f·g)(-3).',
          'options': ['84', '81', '86', '85'],
          'correct': 0,
        },
        {
          'question': 'Given f(x) = 4x + 4 and g(x) = 5x - 4, find (f o g)(1) = f(g(1)).',
          'options': ['5', '6', '8', '7'],
          'correct': 2,
        },
        {
          'question': 'Given f(x) = 3x + 1 and g(x) = 1x + 5, find (f·g)(1).',
          'options': ['24', '27', '23', '21'],
          'correct': 0,
        },
        {
          'question': 'Given f(x) = 4x + 0 and g(x) = 4x - 1, find (f-g)(-2).',
          'options': ['-1', '1', '2', '4'],
          'correct': 1,
        },
      ];

    case 'mts102_u2_1': // Graph Basics
      return [
        {
          'question': 'Where does the graph of y = 3x - 6 cross the x-axis?',
          'options': ['x = 3', 'x = 2', 'x = -2', 'x = 6'],
          'correct': 1,
        },
        {
          'question': 'Where does the graph of y = 3x - 6 cross the y-axis?',
          'options': ['y = -6', 'y = 6', 'y = 3', 'y = 0'],
          'correct': 0,
        },
        {
          'question': 'What is the slope of the line through (1,2) and (3,8)?',
          'options': ['3', '6', '2', '1/3'],
          'correct': 0,
        },
        {
          'question': 'A line with a slope of 0 is:',
          'options': ['horizontal', 'undefined', 'diagonal', 'vertical'],
          'correct': 0,
        },
        {
          'question': 'A vertical line has a slope that is:',
          'options': ['negative', 'undefined', 'positive', 'zero'],
          'correct': 1,
        },
        {
          'question': 'What is the y-intercept of y = -2x + 7?',
          'options': ['7', '-2', '2', '-7'],
          'correct': 0,
        },
        {
          'question': 'Which point lies on the line y = 2x + 1?',
          'options': ['(0,0)', '(1,1)', '(3,5)', '(2,5)'],
          'correct': 3,
        },
        {
          'question': 'The graph of y = x2 is symmetric about:',
          'options': ['neither axis', 'the origin', 'the y-axis', 'the x-axis'],
          'correct': 2,
        },
        {
          'question': 'The graph of y = x3 is symmetric about:',
          'options': ['the y-axis', 'the x-axis', 'neither', 'the origin'],
          'correct': 3,
        },
        {
          'question': 'What shape is the graph of a linear function?',
          'options': ['a parabola', 'a straight line', 'a hyperbola', 'a curve'],
          'correct': 1,
        },
        {
          'question': 'What is the minimum point of y = x2 called?',
          'options': ['the asymptote', 'the vertex', 'the intercept', 'the focus'],
          'correct': 1,
        },
        {
          'question': 'Two lines with the same slope but different intercepts are:',
          'options': ['parallel', 'identical', 'perpendicular', 'intersecting'],
          'correct': 0,
        },
        {
          'question': 'Two lines are perpendicular if the product of their slopes is:',
          'options': ['undefined', '1', '-1', '0'],
          'correct': 2,
        },
        {
          'question': 'What is the slope of a line parallel to y = 4x - 1?',
          'options': ['1/4', '-1/4', '-4', '4'],
          'correct': 3,
        },
        {
          'question': 'What is the slope of a line perpendicular to y = 2x + 3?',
          'options': ['-1/2', '-2', '1/2', '2'],
          'correct': 0,
        },
        {
          'question': 'A horizontal asymptote describes graph behavior as:',
          'options': ['x → 0', 'x is undefined', 'y → 0', 'x → ±∞'],
          'correct': 3,
        },
        {
          'question': 'The graph of y = |x| looks like:',
          'options': ['a parabola', 'a horizontal line', 'a straight diagonal line', 'a V-shape'],
          'correct': 3,
        },
        {
          'question': 'What are the coordinates of the origin?',
          'options': ['(0,0)', '(1,1)', '(0,1)', '(1,0)'],
          'correct': 0,
        },
        {
          'question': 'If a graph passes through quadrants I and III only with a straight line through origin, its slope is:',
          'options': ['positive', 'negative', 'zero', 'undefined'],
          'correct': 0,
        },
        {
          'question': 'The x-intercept of a graph is where:',
          'options': ['y = x', 'x = 0', 'y = 0', 'x = y'],
          'correct': 2,
        },
      ];

    case 'mts102_u2_2': // Transformations
      return [
        {
          'question': 'How does the graph of y = 2f(x) compare to y = f(x)?',
          'options': ['vertically stretched by a factor of 2', 'vertically compressed by a factor of 2', 'shifted up by 2 units', 'horizontally stretched by a factor of 2'],
          'correct': 0,
        },
        {
          'question': 'How does the graph of y = f(x + 3) compare to y = f(x)?',
          'options': ['shifted down by 3 units', 'shifted right by 3 units', 'shifted up by 3 units', 'shifted left by 3 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x - 2) compare to y = f(x)?',
          'options': ['shifted left by 2 units', 'shifted right by 2 units', 'shifted up by 2 units', 'shifted down by 2 units'],
          'correct': 1,
        },
        {
          'question': 'How does the graph of y = f(x + 1) compare to y = f(x)?',
          'options': ['shifted left by 1 units', 'shifted up by 1 units', 'shifted right by 1 units', 'shifted down by 1 units'],
          'correct': 0,
        },
        {
          'question': 'How does the graph of y = 4f(x) compare to y = f(x)?',
          'options': ['horizontally stretched by a factor of 4', 'vertically stretched by a factor of 4', 'shifted up by 4 units', 'vertically compressed by a factor of 4'],
          'correct': 1,
        },
        {
          'question': 'How does the graph of y = f(-x) compare to y = f(x)?',
          'options': ['shifted right', 'shifted left', 'reflected across the x-axis', 'reflected across the y-axis'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x - 4) compare to y = f(x)?',
          'options': ['shifted down by 4 units', 'shifted up by 4 units', 'shifted left by 4 units', 'shifted right by 4 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x) + 3 compare to y = f(x)?',
          'options': ['shifted down by 3 units', 'shifted right by 3 units', 'shifted left by 3 units', 'shifted up by 3 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x) + 2 compare to y = f(x)?',
          'options': ['shifted down by 2 units', 'shifted right by 2 units', 'shifted left by 2 units', 'shifted up by 2 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x + 2) compare to y = f(x)?',
          'options': ['shifted right by 2 units', 'shifted down by 2 units', 'shifted up by 2 units', 'shifted left by 2 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = 3f(x) compare to y = f(x)?',
          'options': ['vertically compressed by a factor of 3', 'shifted up by 3 units', 'vertically stretched by a factor of 3', 'horizontally stretched by a factor of 3'],
          'correct': 2,
        },
        {
          'question': 'How does the graph of y = f(x - 3) compare to y = f(x)?',
          'options': ['shifted down by 3 units', 'shifted up by 3 units', 'shifted left by 3 units', 'shifted right by 3 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x) - 6 compare to y = f(x)?',
          'options': ['shifted up by 6 units', 'shifted right by 6 units', 'shifted left by 6 units', 'shifted down by 6 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x) - 4 compare to y = f(x)?',
          'options': ['shifted right by 4 units', 'shifted left by 4 units', 'shifted up by 4 units', 'shifted down by 4 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = f(x) - 3 compare to y = f(x)?',
          'options': ['shifted down by 3 units', 'shifted left by 3 units', 'shifted right by 3 units', 'shifted up by 3 units'],
          'correct': 0,
        },
        {
          'question': 'How does the graph of y = f(x) + 5 compare to y = f(x)?',
          'options': ['shifted left by 5 units', 'shifted down by 5 units', 'shifted right by 5 units', 'shifted up by 5 units'],
          'correct': 3,
        },
        {
          'question': 'How does the graph of y = -f(x) compare to y = f(x)?',
          'options': ['shifted up', 'shifted down', 'reflected across the x-axis', 'reflected across the y-axis'],
          'correct': 2,
        },
        {
          'question': 'How does the graph of y = f(x) - 1 compare to y = f(x)?',
          'options': ['shifted up by 1 units', 'shifted left by 1 units', 'shifted down by 1 units', 'shifted right by 1 units'],
          'correct': 2,
        },
        {
          'question': 'How does the graph of y = f(x) + 4 compare to y = f(x)?',
          'options': ['shifted up by 4 units', 'shifted right by 4 units', 'shifted down by 4 units', 'shifted left by 4 units'],
          'correct': 0,
        },
        {
          'question': 'How does the graph of y = f(x + 5) compare to y = f(x)?',
          'options': ['shifted left by 5 units', 'shifted right by 5 units', 'shifted up by 5 units', 'shifted down by 5 units'],
          'correct': 0,
        },
      ];

    case 'mts102_u2_3': // Curve Analysis
      return [
        {
          'question': 'For f(x) = x3 - 3x, on which interval is f decreasing?',
          'options': ['(-1, 1)', '(-∞, -1)', '(1, ∞)', '(-2, 2)'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 - 48x, on which interval is f increasing?',
          'options': ['(4, ∞)', '(-∞, -4) and (4, ∞)', '(-∞, -4)', '(-5, 5)'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 27x, on which interval is f decreasing?',
          'options': ['(-4, 4)', '(-∞, -3)', '(3, ∞)', '(-3, 3)'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = -x3 + 75x, on which interval is f decreasing?',
          'options': ['(-∞, -5)', '(-∞, -5) and (5, ∞)', '(-6, 6)', '(5, ∞)'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 48x, on which interval is f decreasing?',
          'options': ['(4, ∞)', '(-4, 4)', '(-∞, -4)', '(-5, 5)'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = -x3 + 3x, on which interval is f decreasing?',
          'options': ['(-∞, -1) and (1, ∞)', '(-2, 2)', '(1, ∞)', '(-∞, -1)'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = -x3 + 48x, on which interval is f increasing?',
          'options': ['(-4, 4)', '(4, ∞)', '(-∞, -4)', '(-5, 5)'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = -x3 + 12x, on which interval is f increasing?',
          'options': ['(-2, 2)', '(-3, 3)', '(2, ∞)', '(-∞, -2)'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = -x3 + 75x, on which interval is f increasing?',
          'options': ['(-∞, -5)', '(-6, 6)', '(-5, 5)', '(5, ∞)'],
          'correct': 2,
        },
        {
          'question': 'For f(x) = -x3 + 27x, on which interval is f decreasing?',
          'options': ['(3, ∞)', '(-∞, -3)', '(-4, 4)', '(-∞, -3) and (3, ∞)'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = -x3 + 27x, on which interval is f increasing?',
          'options': ['(-∞, -3)', '(-4, 4)', '(3, ∞)', '(-3, 3)'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x3 - 12x, on which interval is f decreasing?',
          'options': ['(-3, 3)', '(2, ∞)', '(-∞, -2)', '(-2, 2)'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = -x3 + 12x, on which interval is f decreasing?',
          'options': ['(-∞, -2)', '(-∞, -2) and (2, ∞)', '(-3, 3)', '(2, ∞)'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 27x, on which interval is f increasing?',
          'options': ['(-∞, -3)', '(-∞, -3) and (3, ∞)', '(-4, 4)', '(3, ∞)'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 12x, on which interval is f increasing?',
          'options': ['(2, ∞)', '(-∞, -2) and (2, ∞)', '(-3, 3)', '(-∞, -2)'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 75x, on which interval is f decreasing?',
          'options': ['(-5, 5)', '(-6, 6)', '(5, ∞)', '(-∞, -5)'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = -x3 + 48x, on which interval is f decreasing?',
          'options': ['(-5, 5)', '(-∞, -4)', '(4, ∞)', '(-∞, -4) and (4, ∞)'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x3 - 3x, on which interval is f increasing?',
          'options': ['(-∞, -1)', '(1, ∞)', '(-2, 2)', '(-∞, -1) and (1, ∞)'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x3 - 75x, on which interval is f increasing?',
          'options': ['(-∞, -5) and (5, ∞)', '(-∞, -5)', '(-6, 6)', '(5, ∞)'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = -x3 + 3x, on which interval is f increasing?',
          'options': ['(1, ∞)', '(-2, 2)', '(-∞, -1)', '(-1, 1)'],
          'correct': 3,
        },
      ];

    case 'mts102_u3_1': // Limit Concept
      return [
        {
          'question': 'The limit of f(x) as x approaches a describes:',
          'options': ['the area under f near x = a', 'the slope of f at x = a', 'the value of f at x = a only', 'the value f(x) approaches as x gets close to a'],
          'correct': 3,
        },
        {
          'question': 'A limit exists at x = a if:',
          'options': ['f(a) is defined', 'the left-hand and right-hand limits are equal', 'f is continuous everywhere', 'f(a) = 0'],
          'correct': 1,
        },
        {
          'question': 'If lim(x→a) f(x) = L, this means:',
          'options': ['f(x) gets arbitrarily close to L as x approaches a', 'f(a) = L always', 'L is the maximum of f', 'f is undefined at a'],
          'correct': 0,
        },
        {
          'question': 'A one-sided limit from the left is denoted:',
          'options': ['lim(x→a-) f(x)', 'lim(x→0) f(x)', 'lim(x→a+) f(x)', 'lim(x→∞) f(x)'],
          'correct': 0,
        },
        {
          'question': 'If the left-hand limit and right-hand limit at a point differ, the limit:',
          'options': ['does not exist', 'is infinite', 'equals the average of the two', 'equals zero'],
          'correct': 0,
        },
        {
          'question': 'lim(x→∞) 1/x equals:',
          'options': ['∞', 'undefined', '0', '1'],
          'correct': 2,
        },
        {
          'question': 'A limit describes behavior of a function:',
          'options': ['only when the function is continuous', 'only at the point itself', 'near a point, not necessarily at it', 'only for polynomials'],
          'correct': 2,
        },
        {
          'question': 'If f(x) is undefined at x = a but the limit exists, we say the function has a:',
          'options': ['infinite discontinuity', 'removable discontinuity', 'vertical asymptote', 'jump discontinuity'],
          'correct': 1,
        },
        {
          'question': 'The notation lim(x→a) f(x) = ∞ means:',
          'options': ['f(a) equals infinity', 'the limit is exactly a large number', 'f(x) grows without bound as x approaches a', 'f is undefined everywhere'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an indeterminate form?',
          'options': ['0/0', '1/0', '1/1', '0/1'],
          'correct': 0,
        },
        {
          'question': 'A limit at infinity describes the function\'s:',
          'options': ['concavity', 'end behavior', 'value at x = 0', 'slope at a point'],
          'correct': 1,
        },
        {
          'question': 'If lim(x→2-) f(x) = 3 and lim(x→2+) f(x) = 3, then lim(x→2) f(x) equals:',
          'options': ['0', 'does not exist', '3', '6'],
          'correct': 2,
        },
        {
          'question': 'The squeeze theorem is used to:',
          'options': ['prove continuity only', 'find derivatives', 'compute integrals', 'find a limit by bounding a function between two others'],
          'correct': 3,
        },
        {
          'question': 'If a function is not defined at x = a, can a limit still exist there?',
          'options': ['No, never', 'Only if f(a)=0', 'Only for polynomials', 'Yes, if nearby values approach a fixed number'],
          'correct': 3,
        },
        {
          'question': 'A vertical asymptote at x = a typically means:',
          'options': ['the limit as x→a is ±∞', 'the function is constant near a', 'f(a) = 0', 'the limit equals a'],
          'correct': 0,
        },
        {
          'question': 'lim(x→0) c (where c is a constant) equals:',
          'options': ['undefined', '0', 'c', '1'],
          'correct': 2,
        },
        {
          'question': 'The formal (epsilon-delta) definition of a limit involves:',
          'options': ['making f(x) arbitrarily close to L by restricting x near a', 'computing f(a) directly', 'finding the derivative', 'graphing the function only'],
          'correct': 0,
        },
        {
          'question': 'If lim(x→a) f(x) = L and lim(x→a) g(x) = M, then lim(x→a)[f(x)+g(x)] equals:',
          'options': ['L - M', 'LM', 'L/M', 'L + M'],
          'correct': 3,
        },
        {
          'question': 'If lim(x→a) f(x) = L and c is constant, lim(x→a) c·f(x) equals:',
          'options': ['c - L', 'c·L', 'L/c', 'c + L'],
          'correct': 1,
        },
        {
          'question': 'Which best describes lim(x→0) sin(x)/x?',
          'options': ['It equals infinity', 'It is undefined', 'It equals 0', 'It equals 1, a well-known standard limit'],
          'correct': 3,
        },
      ];

    case 'mts102_u3_2': // Evaluating Limits
      return [
        {
          'question': 'Evaluate lim(x→2) [(x2 - 5x + 6)/(x - 2)].',
          'options': ['-2', '-3', '1', '-1'],
          'correct': 3,
        },
        {
          'question': 'Evaluate lim(x→0) [3x3 + 4x2 - 2x - 6].',
          'options': ['-3', '-7', '-10', '-6'],
          'correct': 3,
        },
        {
          'question': 'Evaluate lim(x→-2) [-2x3 - x2 - 5x - 6].',
          'options': ['20', '16', '14', '19'],
          'correct': 1,
        },
        {
          'question': 'Evaluate lim(x→-4) [(x2 + 2x - 8)/(x + 4)].',
          'options': ['-6', '-7', '-5', '-9'],
          'correct': 0,
        },
        {
          'question': 'Evaluate lim(x→2) [(x2 + x - 6)/(x - 2)].',
          'options': ['5', '2', '3', '4'],
          'correct': 0,
        },
        {
          'question': 'Evaluate lim(x→2) [-3x2 + 3].',
          'options': ['-12', '-8', '-9', '-6'],
          'correct': 2,
        },
        {
          'question': 'Evaluate lim(x→-3) [3x2 + 2x - 3].',
          'options': ['17', '16', '20', '18'],
          'correct': 3,
        },
        {
          'question': 'Evaluate lim(x→-2) [5x2 - 5x - 4].',
          'options': ['28', '24', '26', '30'],
          'correct': 2,
        },
        {
          'question': 'Evaluate lim(x→1) [(x2 + 3x - 4)/(x - 1)].',
          'options': ['4', '5', '2', '7'],
          'correct': 1,
        },
        {
          'question': 'Evaluate lim(x→1) [-5x3 + 4x2 - 5x + 3].',
          'options': ['0', '-3', '1', '-7'],
          'correct': 1,
        },
        {
          'question': 'Evaluate lim(x→-2) [(x2 - 2x - 8)/(x + 2)].',
          'options': ['-7', '-9', '-5', '-6'],
          'correct': 3,
        },
        {
          'question': 'Evaluate lim(x→-1) [2x3 + 2x2 + 2x + 3].',
          'options': ['1', '3', '2', '-1'],
          'correct': 0,
        },
        {
          'question': 'Evaluate lim(x→1) [-x2 - 5x + 2].',
          'options': ['-6', '-1', '-4', '-3'],
          'correct': 2,
        },
        {
          'question': 'Evaluate lim(x→-2) [(x2 - 4)/(x + 2)].',
          'options': ['-4', '-7', '-1', '-2'],
          'correct': 0,
        },
        {
          'question': 'Evaluate lim(x→-3) [(x2 - x - 12)/(x + 3)].',
          'options': ['-4', '-6', '-7', '-5'],
          'correct': 2,
        },
        {
          'question': 'Evaluate lim(x→1) [(x2 - 1)/(x - 1)].',
          'options': ['0', '-1', '2', '3'],
          'correct': 2,
        },
        {
          'question': 'Evaluate lim(x→2) [5x3 + 5x2 - 3x + 1].',
          'options': ['55', '59', '54', '56'],
          'correct': 0,
        },
        {
          'question': 'Evaluate lim(x→1) [2x3 + 6x2 - 2x + 6].',
          'options': ['11', '12', '15', '10'],
          'correct': 1,
        },
        {
          'question': 'Evaluate lim(x→4) [(x2 - 6x + 8)/(x - 4)].',
          'options': ['1', '3', '0', '2'],
          'correct': 3,
        },
        {
          'question': 'Evaluate lim(x→1) [6x2 + 4x - 1].',
          'options': ['10', '9', '5', '7'],
          'correct': 1,
        },
      ];

    case 'mts102_u3_3': // Continuity
      return [
        {
          'question': 'Is f(x) = 2x2 + 3x - 6 continuous at x = 3?',
          'options': ['No, there is a vertical asymptote there', 'Cannot be determined', 'No, there is a jump discontinuity there', 'Yes, since it is a polynomial, defined everywhere'],
          'correct': 3,
        },
        {
          'question': 'Is g(x) = 1/(x - -2) continuous at x = -2?',
          'options': ['Yes, since the limit exists there', 'Yes, all rational functions are continuous everywhere', 'No, g is undefined at that point', 'Cannot be determined'],
          'correct': 2,
        },
        {
          'question': 'Is f(x) = -2x2 - 5x - 6 continuous at x = -1?',
          'options': ['Yes, since it is a polynomial, defined everywhere', 'No, there is a jump discontinuity there', 'No, there is a vertical asymptote there', 'Cannot be determined'],
          'correct': 0,
        },
        {
          'question': 'Is g(x) = 1/(x - -3) continuous at x = -3?',
          'options': ['Yes, all rational functions are continuous everywhere', 'Cannot be determined', 'Yes, since the limit exists there', 'No, g is undefined at that point'],
          'correct': 3,
        },
        {
          'question': 'Is f(x) = 2x2 - 6x + 4 continuous at x = 2?',
          'options': ['Cannot be determined', 'Yes, since it is a polynomial, defined everywhere', 'No, there is a jump discontinuity there', 'No, there is a vertical asymptote there'],
          'correct': 1,
        },
        {
          'question': 'Is g(x) = 1/(x - 1) continuous at x = 1?',
          'options': ['Cannot be determined', 'Yes, all rational functions are continuous everywhere', 'Yes, since the limit exists there', 'No, g is undefined at that point'],
          'correct': 3,
        },
        {
          'question': 'Is f(x) = -6x2 - x + 2 continuous at x = -2?',
          'options': ['Yes, since it is a polynomial, defined everywhere', 'Cannot be determined', 'No, there is a vertical asymptote there', 'No, there is a jump discontinuity there'],
          'correct': 0,
        },
        {
          'question': 'Is f(x) = 5x2 - 4x + 6 continuous at x = 3?',
          'options': ['Cannot be determined', 'No, there is a jump discontinuity there', 'No, there is a vertical asymptote there', 'Yes, since it is a polynomial, defined everywhere'],
          'correct': 3,
        },
        {
          'question': 'Is f(x) = -2x2 - 3x - 6 continuous at x = -4?',
          'options': ['Cannot be determined', 'No, there is a vertical asymptote there', 'No, there is a jump discontinuity there', 'Yes, since it is a polynomial, defined everywhere'],
          'correct': 3,
        },
        {
          'question': 'Is f(x) = x2 + 2x + 1 continuous at x = 4?',
          'options': ['No, there is a jump discontinuity there', 'Cannot be determined', 'No, there is a vertical asymptote there', 'Yes, since it is a polynomial, defined everywhere'],
          'correct': 3,
        },
        {
          'question': 'Is g(x) = 1/(x - 0) continuous at x = 0?',
          'options': ['Cannot be determined', 'No, g is undefined at that point', 'Yes, all rational functions are continuous everywhere', 'Yes, since the limit exists there'],
          'correct': 1,
        },
        {
          'question': 'Is f(x) = x2 + 5 continuous at x = 1?',
          'options': ['No, there is a vertical asymptote there', 'Yes, since it is a polynomial, defined everywhere', 'No, there is a jump discontinuity there', 'Cannot be determined'],
          'correct': 1,
        },
        {
          'question': 'Is g(x) = 1/(x - 3) continuous at x = 3?',
          'options': ['Cannot be determined', 'Yes, all rational functions are continuous everywhere', 'No, g is undefined at that point', 'Yes, since the limit exists there'],
          'correct': 2,
        },
        {
          'question': 'Is f(x) = -x2 + 4x - 2 continuous at x = -3?',
          'options': ['Yes, since it is a polynomial, defined everywhere', 'No, there is a jump discontinuity there', 'No, there is a vertical asymptote there', 'Cannot be determined'],
          'correct': 0,
        },
        {
          'question': 'A function is continuous at x = a if:',
          'options': ['f(a) is defined, the limit exists, and they are equal', 'the graph is a straight line', 'f(a) = 0', 'f is a polynomial'],
          'correct': 0,
        },
        {
          'question': 'A removable discontinuity can often be \'fixed\' by:',
          'options': ['multiplying by zero', 'redefining the function at that single point', 'changing the domain entirely', 'adding a constant everywhere'],
          'correct': 1,
        },
        {
          'question': 'A jump discontinuity occurs when:',
          'options': ['the left and right limits exist but are different', 'the function is undefined everywhere', 'the function is a straight line', 'the limit is infinite'],
          'correct': 0,
        },
        {
          'question': 'An infinite discontinuity is associated with:',
          'options': ['a hole in the graph', 'a vertical asymptote', 'a horizontal line', 'a jump in value'],
          'correct': 1,
        },
        {
          'question': 'Every polynomial function is continuous:',
          'options': ['nowhere', 'only at x = 0', 'only where it equals zero', 'everywhere on its domain (all real numbers)'],
          'correct': 3,
        },
        {
          'question': 'A rational function is discontinuous where:',
          'options': ['its numerator equals zero', 'its denominator equals zero', 'it crosses the y-axis', 'it crosses the x-axis'],
          'correct': 1,
        },
      ];

    case 'mts102_u4_1': // Derivative Basics
      return [
        {
          'question': 'Find f\'(x) if f(x) = -4x + 3.',
          'options': ['-4', '-4x - 5', '2x - 6', '5x + 6'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = x2 + 3x - 6.',
          'options': ['2x + 3', '2x2 + 6x - 5', '2x2 - x - 1', '4x2 - 4x + 4'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = -x2 + 4x - 2.',
          'options': ['3x2 + 2', '6x2 - 4x + 1', '-3x2 - 5x - 6', '-2x + 4'],
          'correct': 3,
        },
        {
          'question': 'Find f\'(x) if f(x) = 2x3 - 3x2 + 3x - 2.',
          'options': ['6x2 - 6x + 3', '6x3 + x2 - 3x - 5', '6x3 + x2 - 5x + 6', '-4x3 - 5x2 + x - 4'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = -5x3 + 2x2 + 2x - 2.',
          'options': ['-x3 + 2x2 - 3x - 5', '6x3 + 4x2 - 4x + 6', '-15x2 + 4x + 2', '-2x3 - 4x2 + 5x + 5'],
          'correct': 2,
        },
        {
          'question': 'Find f\'(x) if f(x) = -6x2 - x + 2.',
          'options': ['-12x - 1', '4x2 - x + 1', '3x2 - 4x + 3', '-5x2 - 5x - 2'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = x3 + 6x2 + 3.',
          'options': ['-5x3 + x2 + x + 4', '3x3 - x2 - 4x + 6', '3x2 + 12x', '-5x3 - 4x2 - x + 4'],
          'correct': 2,
        },
        {
          'question': 'Find f\'(x) if f(x) = -6x3 - 5x2 + 2x - 4.',
          'options': ['-2x3 - 5x2 - 2x - 3', '-2x3 - 4x2 - 4x - 1', '-18x2 - 10x + 2', '6x3 - 3x2 - x + 2'],
          'correct': 2,
        },
        {
          'question': 'Find f\'(x) if f(x) = 3x3 - 5x2 + 2x + 4.',
          'options': ['-4x3 + 3x2 + 3x - 4', '-4x3 + 4x2 + 3x + 5', '4x3 - x2 + 3x - 6', '9x2 - 10x + 2'],
          'correct': 3,
        },
        {
          'question': 'Find f\'(x) if f(x) = 4x3 - 2x2 + 4x - 3.',
          'options': ['12x2 - 4x + 4', '-2x3 + 4x2 - 2x + 1', '-6x3 + x2 + 4x + 2', '4x3 + 3x + 4'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = 2x2 - 5x + 5.',
          'options': ['4x - 5', 'x2 + x + 1', '-3x2 - x + 3', '-6x2 - 4x + 1'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = -x3 - 4x + 6.',
          'options': ['-x3 - 3x2 + x - 5', '-x3 + 2x2 + 2x - 5', '-2x3 + x2 - 3x - 4', '-3x2 - 4'],
          'correct': 3,
        },
        {
          'question': 'Find f\'(x) if f(x) = 4x2 - 3.',
          'options': ['8x', '6x2 - x - 3', '-4x2 - x + 3', '-4x2 + x + 2'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = -6x2 - 5x.',
          'options': ['-12x - 5', '3x2 + x - 3', '-3x2 + 3x - 1', '-6x2 - 6x - 2'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = 3x2 - 6x - 5.',
          'options': ['x2 - 4x - 2', '6x2 - x + 6', '6x - 6', 'x2 - x - 6'],
          'correct': 2,
        },
        {
          'question': 'Find f\'(x) if f(x) = 3x2 - 2x - 5.',
          'options': ['3x2 - 2x + 3', '5x2 + 3x - 5', '6x - 2', 'x2 + 2x + 1'],
          'correct': 2,
        },
        {
          'question': 'Find f\'(x) if f(x) = -x2 + 2x - 1.',
          'options': ['-2x + 2', '-6x2 - 6x - 6', '3x2 + 2', '-4x2 - 3x + 3'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = 3x2 + x - 4.',
          'options': ['6x + 1', '4x2 + 2x - 4', '-4x2 + 3', '-x2 + 3x - 1'],
          'correct': 0,
        },
        {
          'question': 'Find f\'(x) if f(x) = 3x3 + 2x2 + x + 5.',
          'options': ['x3 + 3x2 - 2x + 6', '4x3 - 2x2 + x - 6', '-x3 - x2 + 4x - 5', '9x2 + 4x + 1'],
          'correct': 3,
        },
        {
          'question': 'Find f\'(x) if f(x) = 5x2 + 6x + 6.',
          'options': ['4x2 + 3x - 3', '6x2 - 6x + 3', '10x + 6', '2x2 - 4x + 2'],
          'correct': 2,
        },
      ];

    case 'mts102_u4_2': // Differentiation Rules
      return [
        {
          'question': 'Using the product rule, find d/dx[(4x + 5)(-5x - 3)].',
          'options': ['-40x - 37', '-x', '-4x', '-6x + 1'],
          'correct': 0,
        },
        {
          'question': 'Using the chain rule, find d/dx[(4x - 4)^4].',
          'options': ['1024x3 - 3072x2 + 3072x - 1024', '-4x3 + 2x2 - 3x + 2', 'x3 - x2 - 4x + 1', '-x3 + 4x2 + x + 2'],
          'correct': 0,
        },
        {
          'question': 'Using the chain rule, find d/dx[(4x + 0)^4].',
          'options': ['1024x3', '3x3 - 2x2 - 3x - 2', '2x3 - 3x2 - 3x - 2', '-2x3 + 5x2 - 3x + 5'],
          'correct': 0,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(3x) / (x + 3)].',
          'options': ['(9) / (x2 + 6x + 9)', '(-9) / (x2 + 6x + 9)', '(9) / (x2 + 6x + 11)', '(11) / (x2 + 6x + 9)'],
          'correct': 0,
        },
        {
          'question': 'Using the product rule, find d/dx[(-2x - 6)(-2x + 5)].',
          'options': ['-5x - 1', '2x + 4', '8x + 2', '-2x + 5'],
          'correct': 2,
        },
        {
          'question': 'Using the chain rule, find d/dx[(3x + 4)^4].',
          'options': ['-6x3 + 4x2 + 2x - 3', '6x3 + 3x2 - 3x - 3', '324x3 + 1296x2 + 1728x + 768', '-2x3 - 4x2 - 5x + 3'],
          'correct': 2,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(3x + 3) / (x + 3)].',
          'options': ['(8) / (x2 + 6x + 9)', '(-6) / (x2 + 6x + 9)', '(6) / (x2 + 6x + 9)', '(6) / (x2 + 6x + 11)'],
          'correct': 2,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(4x + 3) / (x + 1)].',
          'options': ['(1) / (x2 + 2x + 1)', '(3) / (x2 + 2x + 1)', '(1) / (x2 + 2x + 3)', '(-1) / (x2 + 2x + 1)'],
          'correct': 0,
        },
        {
          'question': 'Using the chain rule, find d/dx[(2x - 3)^4].',
          'options': ['6x3 - 6x2 - 4x', '4x3 - 3x2 + 2x + 5', '64x3 - 288x2 + 432x - 216', '-4x3 - 6x2 + 6'],
          'correct': 2,
        },
        {
          'question': 'Using the product rule, find d/dx[(-6x - 2)(4x + 3)].',
          'options': ['-2x + 1', '-5x - 1', '-48x - 26', '5x + 2'],
          'correct': 2,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(2x - 3) / (x - 1)].',
          'options': ['(1) / (x2 - 2x + 1)', '(3) / (x2 - 2x + 1)', '(-1) / (x2 - 2x + 1)', '(1) / (x2 - 2x + 3)'],
          'correct': 0,
        },
        {
          'question': 'Using the chain rule, find d/dx[(3x - 2)^2].',
          'options': ['-2x + 3', '5x + 6', '18x - 12', '6x - 1'],
          'correct': 2,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(3x - 3) / (x - 2)].',
          'options': ['(-3) / (x2 - 4x + 6)', '(3) / (x2 - 4x + 4)', '(-1) / (x2 - 4x + 4)', '(-3) / (x2 - 4x + 4)'],
          'correct': 3,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(3x - 1) / (x + 4)].',
          'options': ['(15) / (x2 + 8x + 16)', '(13) / (x2 + 8x + 16)', '(13) / (x2 + 8x + 18)', '(-13) / (x2 + 8x + 16)'],
          'correct': 1,
        },
        {
          'question': 'Using the quotient rule, find d/dx[(3x + 1) / (x + 4)].',
          'options': ['(11) / (x2 + 8x + 16)', '(11) / (x2 + 8x + 18)', '(13) / (x2 + 8x + 16)', '(-11) / (x2 + 8x + 16)'],
          'correct': 0,
        },
        {
          'question': 'Using the chain rule, find d/dx[(2x - 4)^4].',
          'options': ['-2x3 + 5x2 - 5x + 4', '64x3 - 384x2 + 768x - 512', '-5x3 + x2 - 2x - 4', 'x3 + 4x2 + 2x + 5'],
          'correct': 1,
        },
        {
          'question': 'Using the product rule, find d/dx[(-4x + 1)(-4x + 1)].',
          'options': ['6x + 3', '32x - 8', '-x', '6x + 2'],
          'correct': 1,
        },
        {
          'question': 'Using the product rule, find d/dx[(5x + 6)(4x + 6)].',
          'options': ['-5x + 2', '6x - 1', '2x + 2', '40x + 54'],
          'correct': 3,
        },
        {
          'question': 'Using the product rule, find d/dx[(3x + 2)(-3x + 3)].',
          'options': ['3x - 4', '3x + 1', '-4x - 1', '-18x + 3'],
          'correct': 3,
        },
        {
          'question': 'Using the chain rule, find d/dx[(4x + 3)^2].',
          'options': ['-6x + 1', '32x + 24', '3x + 1', '-4x + 2'],
          'correct': 1,
        },
      ];

    case 'mts102_u4_3': // Advanced Techniques
      return [
        {
          'question': 'Given x2 + y2 = 16, find dy/dx using implicit differentiation.',
          'options': ['y/x', '-y/x', 'x/y', '-x/y'],
          'correct': 3,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = 6x3 - 3x2 + 3x - 5.',
          'options': ['-x + 5', '-6x', '-5x + 2', '36x - 6'],
          'correct': 3,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = -2x3 - 4x + 6.',
          'options': ['-12x', '5x', '-4x + 6', '5x + 5'],
          'correct': 0,
        },
        {
          'question': 'Given x2 + y2 = 25, find dy/dx using implicit differentiation.',
          'options': ['x/y', 'y/x', '-y/x', '-x/y'],
          'correct': 3,
        },
        {
          'question': 'Find d/dx[ln(2x)].',
          'options': ['2/x', '2x', 'x/2', '1/(2x)'],
          'correct': 0,
        },
        {
          'question': 'Find d/dx[e^(3x)].',
          'options': ['32e^(3x)', 'e^(3x)', '3xe^(3x-1)', '3e^(3x)'],
          'correct': 3,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = -6x3 + 6x2 + 4x.',
          'options': ['4x + 6', '-3x - 5', '-6x - 3', '-36x + 12'],
          'correct': 3,
        },
        {
          'question': 'Given x2 + y2 = 4, find dy/dx using implicit differentiation.',
          'options': ['y/x', '-x/y', '-y/x', 'x/y'],
          'correct': 1,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = -4x3 + 2x2 - 2x - 3.',
          'options': ['4x + 6', '6x + 3', '-24x + 4', '-x + 3'],
          'correct': 2,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = 3x3 + 3x2 + 5x - 4.',
          'options': ['18x + 6', '5x + 4', '2x - 6', 'x + 2'],
          'correct': 0,
        },
        {
          'question': 'Find d/dx[ln(5x)].',
          'options': ['x/5', '1/(5x)', '5/x', '5x'],
          'correct': 2,
        },
        {
          'question': 'Given x2 + y2 = 9, find dy/dx using implicit differentiation.',
          'options': ['x/y', '-y/x', '-x/y', 'y/x'],
          'correct': 2,
        },
        {
          'question': 'Find d/dx[ln(3x)].',
          'options': ['x/3', '1/(3x)', '3/x', '3x'],
          'correct': 2,
        },
        {
          'question': 'Find d/dx[e^(4x)].',
          'options': ['4xe^(4x-1)', '42e^(4x)', 'e^(4x)', '4e^(4x)'],
          'correct': 3,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = 3x3 + 5x2 - 3x - 6.',
          'options': ['-2x', '5x + 3', '4x - 6', '18x + 10'],
          'correct': 3,
        },
        {
          'question': 'Find d/dx[ln(4x)].',
          'options': ['4/x', '1/(4x)', '4x', 'x/4'],
          'correct': 0,
        },
        {
          'question': 'Find d/dx[e^(2x)].',
          'options': ['2e^(2x)', 'e^(2x)', '2xe^(2x-1)', '22e^(2x)'],
          'correct': 0,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = x3 - 4x2 + 4x - 3.',
          'options': ['-4x - 6', '6x - 8', '-5x + 5', '-3x + 2'],
          'correct': 1,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = -6x3 + 2x2 + 5x - 2.',
          'options': ['3x - 2', '-6x + 2', '-36x + 4', '6x + 4'],
          'correct': 2,
        },
        {
          'question': 'Find f\'\'(x) if f(x) = 3x3 - 4x2 - 3x - 3.',
          'options': ['-2x - 1', '4x + 2', '18x - 8', '-2x + 6'],
          'correct': 2,
        },
      ];

    case 'mts102_u5_1': // Extrema
      return [
        {
          'question': 'For f(x) = x2 - 4x + 1, classify the critical point using the second derivative test.',
          'options': ['there is no extremum', 'x = 2 is a local minimum', 'x = 3 is a local minimum', 'x = 2 is a local maximum'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x2 - 4x + 4, classify the critical point using the second derivative test.',
          'options': ['x = 2 is a local maximum', 'there is no extremum', 'x = 3 is a local minimum', 'x = 2 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 2x, classify the critical point using the second derivative test.',
          'options': ['x = 1 is a local minimum', 'x = 2 is a local minimum', 'x = 1 is a local maximum', 'there is no extremum'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x2 - 2x + 4, classify the critical point using the second derivative test.',
          'options': ['x = 1 is a local maximum', 'there is no extremum', 'x = 2 is a local minimum', 'x = 1 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 2x + 1, classify the critical point using the second derivative test.',
          'options': ['x = 1 is a local minimum', 'x = 1 is a local maximum', 'x = 2 is a local minimum', 'there is no extremum'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x2 - 6x - 5, classify the critical point using the second derivative test.',
          'options': ['x = 3 is a local maximum', 'x = 4 is a local minimum', 'there is no extremum', 'x = 3 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 6x + 3, classify the critical point using the second derivative test.',
          'options': ['x = 4 is a local minimum', 'x = 3 is a local minimum', 'x = 3 is a local maximum', 'there is no extremum'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x2 - 2x - 1, classify the critical point using the second derivative test.',
          'options': ['x = 1 is a local maximum', 'x = 2 is a local minimum', 'there is no extremum', 'x = 1 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 6x, classify the critical point using the second derivative test.',
          'options': ['x = 4 is a local minimum', 'there is no extremum', 'x = 3 is a local maximum', 'x = 3 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 6x - 3, classify the critical point using the second derivative test.',
          'options': ['x = 3 is a local minimum', 'x = 3 is a local maximum', 'x = 4 is a local minimum', 'there is no extremum'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x2 - 4x + 6, classify the critical point using the second derivative test.',
          'options': ['there is no extremum', 'x = 2 is a local minimum', 'x = 3 is a local minimum', 'x = 2 is a local maximum'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x2 - 6x + 5, classify the critical point using the second derivative test.',
          'options': ['x = 3 is a local maximum', 'there is no extremum', 'x = 3 is a local minimum', 'x = 4 is a local minimum'],
          'correct': 2,
        },
        {
          'question': 'For f(x) = x2 - 4x - 3, classify the critical point using the second derivative test.',
          'options': ['there is no extremum', 'x = 3 is a local minimum', 'x = 2 is a local maximum', 'x = 2 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 4x - 6, classify the critical point using the second derivative test.',
          'options': ['x = 2 is a local minimum', 'there is no extremum', 'x = 2 is a local maximum', 'x = 3 is a local minimum'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x2 - 2x + 5, classify the critical point using the second derivative test.',
          'options': ['x = 2 is a local minimum', 'x = 1 is a local maximum', 'there is no extremum', 'x = 1 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 4x - 1, classify the critical point using the second derivative test.',
          'options': ['x = 2 is a local maximum', 'x = 3 is a local minimum', 'there is no extremum', 'x = 2 is a local minimum'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x2 - 2x - 5, classify the critical point using the second derivative test.',
          'options': ['x = 1 is a local minimum', 'x = 2 is a local minimum', 'there is no extremum', 'x = 1 is a local maximum'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x2 - 6x + 2, classify the critical point using the second derivative test.',
          'options': ['x = 3 is a local maximum', 'x = 4 is a local minimum', 'x = 3 is a local minimum', 'there is no extremum'],
          'correct': 2,
        },
        {
          'question': 'For f(x) = x2 - 4x - 2, classify the critical point using the second derivative test.',
          'options': ['x = 2 is a local maximum', 'x = 3 is a local minimum', 'x = 2 is a local minimum', 'there is no extremum'],
          'correct': 2,
        },
        {
          'question': 'For f(x) = x2 - 4x - 5, classify the critical point using the second derivative test.',
          'options': ['x = 3 is a local minimum', 'x = 2 is a local minimum', 'there is no extremum', 'x = 2 is a local maximum'],
          'correct': 1,
        },
      ];

    case 'mts102_u5_2': // Curve Sketching
      return [
        {
          'question': 'For f(x) = x3 + 6x, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = -1', 'x = 1', 'x = 2'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 + 3x + 1, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = -1', 'x = 2', 'x = 1'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 + 15x - 2, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 0', 'x = 1', 'x = 2'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 + 15x + 3, find the x-coordinate of the inflection point.',
          'options': ['x = 2', 'x = 0', 'x = -1', 'x = 1'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 + 9x - 2, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 0', 'x = 1', 'x = 2'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 + 6x + 5, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 1', 'x = 0', 'x = 2'],
          'correct': 2,
        },
        {
          'question': 'For f(x) = x3 - 6x - 1, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = 2', 'x = -1', 'x = 1'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 + 6x - 4, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = 1', 'x = -1', 'x = 2'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 + 15x + 1, find the x-coordinate of the inflection point.',
          'options': ['x = 1', 'x = 0', 'x = -1', 'x = 2'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 + 3x + 3, find the x-coordinate of the inflection point.',
          'options': ['x = 1', 'x = -1', 'x = 2', 'x = 0'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x3 + 3x - 3, find the x-coordinate of the inflection point.',
          'options': ['x = 2', 'x = 1', 'x = -1', 'x = 0'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x3 - 3x - 2, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = -1', 'x = 2', 'x = 1'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 + 6x + 2, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 0', 'x = 2', 'x = 1'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 + 9x - 4, find the x-coordinate of the inflection point.',
          'options': ['x = 2', 'x = 0', 'x = 1', 'x = -1'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 12x - 3, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = 2', 'x = 1', 'x = -1'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 - 12x + 2, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 0', 'x = 1', 'x = 2'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 - 3x - 5, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 1', 'x = 2', 'x = 0'],
          'correct': 3,
        },
        {
          'question': 'For f(x) = x3 - 12x + 5, find the x-coordinate of the inflection point.',
          'options': ['x = 2', 'x = 0', 'x = -1', 'x = 1'],
          'correct': 1,
        },
        {
          'question': 'For f(x) = x3 + 12x - 3, find the x-coordinate of the inflection point.',
          'options': ['x = 0', 'x = -1', 'x = 2', 'x = 1'],
          'correct': 0,
        },
        {
          'question': 'For f(x) = x3 - 9x + 5, find the x-coordinate of the inflection point.',
          'options': ['x = -1', 'x = 0', 'x = 1', 'x = 2'],
          'correct': 1,
        },
      ];

    case 'mts102_u5_3': // Analysis
      return [
        {
          'question': 'If f\'(x) > 0 on an interval, the function is:',
          'options': ['increasing on that interval', 'constant on that interval', 'undefined on that interval', 'decreasing on that interval'],
          'correct': 0,
        },
        {
          'question': 'If f\'(x) < 0 on an interval, the function is:',
          'options': ['increasing on that interval', 'constant on that interval', 'decreasing on that interval', 'concave up'],
          'correct': 2,
        },
        {
          'question': 'If f\'\'(x) > 0 on an interval, the graph is:',
          'options': ['linear', 'concave up', 'decreasing', 'concave down'],
          'correct': 1,
        },
        {
          'question': 'If f\'\'(x) < 0 on an interval, the graph is:',
          'options': ['concave up', 'increasing', 'linear', 'concave down'],
          'correct': 3,
        },
        {
          'question': 'A point where f\'(x) = 0 is called a:',
          'options': ['discontinuity', 'critical point', 'inflection point', 'asymptote'],
          'correct': 1,
        },
        {
          'question': 'An inflection point is where:',
          'options': ['the slope is zero', 'the function is at a maximum', 'concavity changes', 'the function is undefined'],
          'correct': 2,
        },
        {
          'question': 'The First Derivative Test is used to:',
          'options': ['classify critical points as max, min, or neither', 'find inflection points only', 'evaluate definite integrals', 'find the domain'],
          'correct': 0,
        },
        {
          'question': 'The Second Derivative Test uses the sign of f\'\'(c) to:',
          'options': ['determine if a critical point c is a max or min', 'find the domain of f', 'evaluate f(c) directly', 'find horizontal asymptotes'],
          'correct': 0,
        },
        {
          'question': 'If f\'(c) = 0 and f\'\'(c) = 0, the Second Derivative Test is:',
          'options': ['always an inflection point', 'always a maximum', 'always a minimum', 'inconclusive'],
          'correct': 3,
        },
        {
          'question': 'The Mean Value Theorem guarantees a point where:',
          'options': ['the function equals zero', 'the instantaneous rate of change equals the average rate of change', 'the function is at its maximum', 'the function is discontinuous'],
          'correct': 1,
        },
        {
          'question': 'A global (absolute) maximum is:',
          'options': ['any local peak', 'the highest value of f over its entire domain (or given interval)', 'the y-intercept', 'the value where f\'=0'],
          'correct': 1,
        },
        {
          'question': 'Rolle\'s Theorem is a special case of:',
          'options': ['the Extreme Value Theorem', 'the Mean Value Theorem', 'L\'Hôpital\'s Rule', 'the Squeeze Theorem'],
          'correct': 1,
        },
        {
          'question': 'If a continuous function changes sign over [a,b], the Intermediate Value Theorem guarantees:',
          'options': ['no roots', 'at least one root in (a,b)', 'an extremum in (a,b)', 'exactly one root'],
          'correct': 1,
        },
        {
          'question': 'A function is said to have a horizontal tangent where:',
          'options': ['f(x) = 0', 'f\'(x) = 0', 'f is undefined', 'f\'\'(x) = 0'],
          'correct': 1,
        },
        {
          'question': 'Concavity of a function relates to the sign of:',
          'options': ['the function value itself', 'the second derivative', 'the first derivative', 'the domain'],
          'correct': 1,
        },
        {
          'question': 'If f is increasing and concave down, its graph looks like:',
          'options': ['a straight line', 'rising but leveling off', 'falling steeply', 'a U-shape'],
          'correct': 1,
        },
        {
          'question': 'The slope of the tangent line at a point equals:',
          'options': ['the function value at that point', 'the derivative at that point', 'the average rate of change over the domain', 'the y-intercept'],
          'correct': 1,
        },
        {
          'question': 'L\'Hôpital\'s Rule is used to evaluate limits of the form:',
          'options': ['0/0 or ∞/∞', 'only limits at x=0', 'only limits of polynomials', 'any limit'],
          'correct': 0,
        },
        {
          'question': 'A saddle/inflection behavior with f\'(c)=0 but no sign change in f\' means c is:',
          'options': ['always a minimum', 'undefined', 'neither a max nor a min', 'always a maximum'],
          'correct': 2,
        },
        {
          'question': 'Analyzing a function\'s monotonicity means studying where it is:',
          'options': ['continuous or discontinuous', 'increasing or decreasing', 'even or odd', 'concave up or down'],
          'correct': 1,
        },
      ];

    case 'mts102_u6_1': // Antiderivatives
      return [
        {
          'question': 'Find the antiderivative: ∫ (-6x2 + x - 4) dx.',
          'options': ['-3x3 + 2x + 2 + C', '5x3 + x2 + 4 + C', '-2x3 + 1/2x2 - 4x + C', '2x3 + 5x + 1 + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (-6x3 + 6x2 + 6x - 3) dx.',
          'options': ['-2x4 - 6x3 - 2x2 - 3x + 2 + C', '6x4 + 6x3 + 6x2 + x + 2 + C', '-2x4 - 4x3 + 6x2 + x + 3 + C', '-3/2x4 + 2x3 + 3x2 - 3x + C'],
          'correct': 3,
        },
        {
          'question': 'Find the antiderivative: ∫ (3x2 - x + 2) dx.',
          'options': ['6x3 + 4x2 + 6x - 3 + C', '-6x3 + 6x2 + 5x + 1 + C', 'x3 - 1/2x2 + 2x + C', '3x3 - 3x2 - 5 + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (-x2 - 5x + 1) dx.',
          'options': ['-5x3 + 6x2 + 6x - 3 + C', '-3x3 + 6x2 + 5x + 3 + C', '-1/3x3 - 5/2x2 + x + C', '6x3 - x2 + 5x + 3 + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (-3x + 6) dx.',
          'options': ['-3/2x2 + 6x + C', '3x2 - 4x - 1 + C', '-6x2 + 3x - 1 + C', '3x2 - 2x + 3 + C'],
          'correct': 0,
        },
        {
          'question': 'Find the antiderivative: ∫ (5x3 - 5x2 - 4x + 6) dx.',
          'options': ['6x4 - 4x3 - 3x2 - 4x + 5 + C', 'x4 - 6x3 - 2x2 + 4x - 4 + C', '5/4x4 - 5/3x3 - 2x2 + 6x + C', '-x4 - 3x3 + 6x2 + 4x + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (x3 + x - 5) dx.',
          'options': ['2x4 + x3 - x2 + 3x - 6 + C', '5x4 + 6x3 + 6x2 - 5x + C', '3x4 + 5x3 - 2x2 + 5x - 1 + C', '1/4x4 + 1/2x2 - 5x + C'],
          'correct': 3,
        },
        {
          'question': 'Find the antiderivative: ∫ (5x3 + 5x2 - x - 5) dx.',
          'options': ['3x4 - 3x2 - 3 + C', '5/4x4 + 5/3x3 - 1/2x2 - 5x + C', '3x4 + 3x3 - 4x2 + 3x + 1 + C', '2x4 - 2x3 - x2 - 2x - 1 + C'],
          'correct': 1,
        },
        {
          'question': 'Find the antiderivative: ∫ (-5x + 4) dx.',
          'options': ['-5/2x2 + 4x + C', '-6x2 - 3 + C', '-4x2 + x + 1 + C', '2x2 - 6x - 5 + C'],
          'correct': 0,
        },
        {
          'question': 'Find the antiderivative: ∫ (-2x - 5) dx.',
          'options': ['-x2 - 5x + C', '5x2 - x - 2 + C', '-5x2 - x + 4 + C', '5x2 - 4x - 6 + C'],
          'correct': 0,
        },
        {
          'question': 'Find the antiderivative: ∫ (6x3 + 6x2 - 3x) dx.',
          'options': ['-3x4 + 2x3 + 4x2 + x - 6 + C', '5x4 - 5x3 + 5x2 - 5x - 6 + C', '-3x4 + x3 - 5x2 - 4x + 3 + C', '3/2x4 + 2x3 - 3/2x2 + C'],
          'correct': 3,
        },
        {
          'question': 'Find the antiderivative: ∫ (x + 5) dx.',
          'options': ['6x2 + 6x - 5 + C', '-3x2 - 5 + C', '-4x2 + x - 5 + C', '1/2x2 + 5x + C'],
          'correct': 3,
        },
        {
          'question': 'Find the antiderivative: ∫ (-4x2 + 6) dx.',
          'options': ['-4x3 + 4x2 + 4x - 4 + C', '-4/3x3 + 6x + C', '4x3 + 4x2 - 4x + 1 + C', '-5x3 + 2x2 + 3x - 6 + C'],
          'correct': 1,
        },
        {
          'question': 'Find the antiderivative: ∫ (6x3 - 4x2 + 3) dx.',
          'options': ['-4x4 + 6x3 - 5x2 + 3x + 5 + C', 'x4 - x3 - x + 6 + C', '3/2x4 - 4/3x3 + 3x + C', '5x4 + x3 - 3x2 - 5x - 5 + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (-5x3 - 3x2 + 2x + 3) dx.',
          'options': ['6x4 - 6x3 + 4x2 - 2x - 3 + C', '-5/4x4 - x3 + x2 + 3x + C', '4x4 + 5x3 + 3x2 - 2x + 6 + C', '3x4 + 3x3 + 2x2 - 3x + 5 + C'],
          'correct': 1,
        },
        {
          'question': 'Find the antiderivative: ∫ (2x) dx.',
          'options': ['3x2 - 6x - 1 + C', '-5x2 - 3x + 1 + C', 'x2 + C', '5x2 + 3x - 5 + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (x3 - x2 + 2x + 4) dx.',
          'options': ['1/4x4 - 1/3x3 + x2 + 4x + C', '-4x4 + 6x3 + x2 + 6x - 5 + C', '-3x4 - 6x3 - 6x2 + 6x + C', '-6x4 + 3x3 - 5x2 - 6x - 2 + C'],
          'correct': 0,
        },
        {
          'question': 'Find the antiderivative: ∫ (6x2 - 5) dx.',
          'options': ['2x3 - 5x + C', '-5x3 + 2x2 - 3x + 6 + C', '-4x3 - 2x2 - 5x - 2 + C', '5x3 + 2x2 + 2x + 3 + C'],
          'correct': 0,
        },
        {
          'question': 'Find the antiderivative: ∫ (4x2 + 4x + 6) dx.',
          'options': ['-2x3 + 5x2 + 5 + C', '5x3 + 4x2 + 4x - 5 + C', '4/3x3 + 2x2 + 6x + C', '-3x3 - 6x2 - 3x - 5 + C'],
          'correct': 2,
        },
        {
          'question': 'Find the antiderivative: ∫ (4x3 - 6x2 - 2x + 4) dx.',
          'options': ['-4x4 + x3 - x2 + 2x + 2 + C', '6x4 + 4x3 + 5x2 - 4x - 5 + C', 'x4 - 2x3 - x2 + 4x + C', '-6x4 + 5x3 - 4x2 + 5x - 6 + C'],
          'correct': 2,
        },
      ];

    case 'mts102_u6_2': // Integration Methods
      return [
        {
          'question': 'Using u-substitution, evaluate ∫ (2x + 0)^4 dx.',
          'options': ['(2x + 0)^4 / 8 + C', '(2x + 0)^5 / 5 + C', '(2x + 0)^5 / 12 + C', '(2x + 0)^5 / 10 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x + 0)^4 dx.',
          'options': ['(3x + 0)^4 / 12 + C', '(3x + 0)^5 / 17 + C', '(3x + 0)^5 / 5 + C', '(3x + 0)^5 / 15 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x + 3)^4 dx.',
          'options': ['(3x + 3)^5 / 17 + C', '(3x + 3)^5 / 5 + C', '(3x + 3)^5 / 15 + C', '(3x + 3)^4 / 12 + C'],
          'correct': 2,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (4x - 2)^3 dx.',
          'options': ['(4x - 2)^3 / 12 + C', '(4x - 2)^4 / 16 + C', '(4x - 2)^4 / 18 + C', '(4x - 2)^4 / 4 + C'],
          'correct': 1,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (4x - 3)^2 dx.',
          'options': ['(4x - 3)^3 / 3 + C', '(4x - 3)^2 / 8 + C', '(4x - 3)^3 / 14 + C', '(4x - 3)^3 / 12 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (2x - 4)^3 dx.',
          'options': ['(2x - 4)^4 / 10 + C', '(2x - 4)^4 / 8 + C', '(2x - 4)^4 / 4 + C', '(2x - 4)^3 / 6 + C'],
          'correct': 1,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (2x - 4)^4 dx.',
          'options': ['(2x - 4)^4 / 8 + C', '(2x - 4)^5 / 5 + C', '(2x - 4)^5 / 10 + C', '(2x - 4)^5 / 12 + C'],
          'correct': 2,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (2x + 2)^4 dx.',
          'options': ['(2x + 2)^5 / 12 + C', '(2x + 2)^5 / 10 + C', '(2x + 2)^5 / 5 + C', '(2x + 2)^4 / 8 + C'],
          'correct': 1,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (4x + 1)^2 dx.',
          'options': ['(4x + 1)^3 / 3 + C', '(4x + 1)^2 / 8 + C', '(4x + 1)^3 / 14 + C', '(4x + 1)^3 / 12 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (4x - 4)^3 dx.',
          'options': ['(4x - 4)^4 / 18 + C', '(4x - 4)^3 / 12 + C', '(4x - 4)^4 / 4 + C', '(4x - 4)^4 / 16 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x + 1)^2 dx.',
          'options': ['(3x + 1)^2 / 6 + C', '(3x + 1)^3 / 3 + C', '(3x + 1)^3 / 9 + C', '(3x + 1)^3 / 11 + C'],
          'correct': 2,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x + 1)^4 dx.',
          'options': ['(3x + 1)^5 / 5 + C', '(3x + 1)^4 / 12 + C', '(3x + 1)^5 / 15 + C', '(3x + 1)^5 / 17 + C'],
          'correct': 2,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (4x + 0)^2 dx.',
          'options': ['(4x + 0)^3 / 14 + C', '(4x + 0)^3 / 12 + C', '(4x + 0)^2 / 8 + C', '(4x + 0)^3 / 3 + C'],
          'correct': 1,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x + 3)^2 dx.',
          'options': ['(3x + 3)^3 / 9 + C', '(3x + 3)^3 / 11 + C', '(3x + 3)^2 / 6 + C', '(3x + 3)^3 / 3 + C'],
          'correct': 0,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (2x - 4)^2 dx.',
          'options': ['(2x - 4)^3 / 6 + C', '(2x - 4)^3 / 3 + C', '(2x - 4)^2 / 4 + C', '(2x - 4)^3 / 8 + C'],
          'correct': 0,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x - 3)^4 dx.',
          'options': ['(3x - 3)^5 / 5 + C', '(3x - 3)^5 / 17 + C', '(3x - 3)^4 / 12 + C', '(3x - 3)^5 / 15 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (4x + 2)^2 dx.',
          'options': ['(4x + 2)^2 / 8 + C', '(4x + 2)^3 / 14 + C', '(4x + 2)^3 / 3 + C', '(4x + 2)^3 / 12 + C'],
          'correct': 3,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (2x + 0)^3 dx.',
          'options': ['(2x + 0)^4 / 8 + C', '(2x + 0)^4 / 10 + C', '(2x + 0)^4 / 4 + C', '(2x + 0)^3 / 6 + C'],
          'correct': 0,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (3x + 3)^3 dx.',
          'options': ['(3x + 3)^4 / 14 + C', '(3x + 3)^3 / 9 + C', '(3x + 3)^4 / 12 + C', '(3x + 3)^4 / 4 + C'],
          'correct': 2,
        },
        {
          'question': 'Using u-substitution, evaluate ∫ (2x - 3)^2 dx.',
          'options': ['(2x - 3)^2 / 4 + C', '(2x - 3)^3 / 3 + C', '(2x - 3)^3 / 8 + C', '(2x - 3)^3 / 6 + C'],
          'correct': 3,
        },
      ];

    case 'mts102_u6_3': // Definite Integrals
      return [
        {
          'question': 'Evaluate the definite integral: ∫ from 2 to 4 of (-x2 - 5) dx.',
          'options': ['-89/3', '-86/3', '-74/3', '-83/3'],
          'correct': 1,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 2 to 4 of (-4x + 6) dx.',
          'options': ['-10', '-13', '-12', '-16'],
          'correct': 2,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 2 to 4 of (x2 + 2x - 6) dx.',
          'options': ['44/3', '56/3', '59/3', '50/3'],
          'correct': 1,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 1 of (2x - 5) dx.',
          'options': ['-4', '-6', '-5', '-8'],
          'correct': 0,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 1 to 2 of (4x + 3) dx.',
          'options': ['8', '5', '9', '6'],
          'correct': 2,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 1 of (-5x2 - 6x + 1) dx.',
          'options': ['-11/3', '-23/3', '-2/3', '1/3'],
          'correct': 0,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 2 of (-x - 3) dx.',
          'options': ['-7', '-10', '-4', '-8'],
          'correct': 3,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 1 to 2 of (2x2 + 2) dx.',
          'options': ['11/3', '20/3', '23/3', '29/3'],
          'correct': 1,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 2 to 3 of (5x + 6) dx.',
          'options': ['37/2', '41/2', '43/2', '45/2'],
          'correct': 0,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 1 to 4 of (-2x2 - 4x - 6) dx.',
          'options': ['-89', '-91', '-94', '-90'],
          'correct': 3,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 3 of (-4x - 5) dx.',
          'options': ['-33', '-34', '-37', '-32'],
          'correct': 0,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 2 to 4 of (-4x2 - 4x - 3) dx.',
          'options': ['-314/3', '-326/3', '-320/3', '-308/3'],
          'correct': 0,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 1 of (2x - 6) dx.',
          'options': ['-1', '-9', '-6', '-5'],
          'correct': 3,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 2 of (-x + 5) dx.',
          'options': ['6', '4', '8', '5'],
          'correct': 2,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 1 to 3 of (4x2 - 5x - 1) dx.',
          'options': ['50/3', '32/3', '38/3', '47/3'],
          'correct': 2,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 2 of (5x + 3) dx.',
          'options': ['17', '16', '12', '14'],
          'correct': 1,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 2 to 3 of (4x - 1) dx.',
          'options': ['13', '9', '7', '6'],
          'correct': 1,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 0 to 3 of (-x - 1) dx.',
          'options': ['-21/2', '-7/2', '-11/2', '-15/2'],
          'correct': 3,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 1 to 3 of (6x - 5) dx.',
          'options': ['14', '17', '10', '11'],
          'correct': 0,
        },
        {
          'question': 'Evaluate the definite integral: ∫ from 1 to 3 of (x + 1) dx.',
          'options': ['10', '3', '6', '9'],
          'correct': 2,
        },
      ];

    case 'mts102_u7_1': // Area Problems
      return [
        {
          'question': 'Find the area under y = x + 2 from x = 0 to x = 2.',
          'options': ['3', '7', '8', '6'],
          'correct': 3,
        },
        {
          'question': 'Find the area enclosed between y = -x2 + 1 and the x-axis.',
          'options': ['8/9', '2/3', '16/9', '4/3'],
          'correct': 3,
        },
        {
          'question': 'Find the area enclosed between y = -x2 + 3 and the x-axis.',
          'options': ['8*sqrt(3)/3', '4*sqrt(3)', '16*sqrt(3)/3', '2*sqrt(3)'],
          'correct': 1,
        },
        {
          'question': 'Find the area under y = x from x = 0 to x = 4.',
          'options': ['7', '8', '9', '11'],
          'correct': 1,
        },
        {
          'question': 'Find the area under y = x + 3 from x = 0 to x = 5.',
          'options': ['59/2', '47/2', '51/2', '55/2'],
          'correct': 3,
        },
        {
          'question': 'Find the area under y = 2x + 1 from x = 0 to x = 4.',
          'options': ['20', '17', '24', '21'],
          'correct': 0,
        },
        {
          'question': 'Find the area enclosed between y = -x2 + 2 and the x-axis.',
          'options': ['32*sqrt(2)/9', '8*sqrt(2)/3', '4*sqrt(2)/3', '16*sqrt(2)/9'],
          'correct': 1,
        },
        {
          'question': 'Find the area under y = 3x + 3 from x = 0 to x = 3.',
          'options': ['45/2', '53/2', '37/2', '51/2'],
          'correct': 0,
        },
        {
          'question': 'Find the area under y = 4x from x = 0 to x = 3.',
          'options': ['15', '22', '18', '16'],
          'correct': 2,
        },
        {
          'question': 'Find the area under y = x + 3 from x = 0 to x = 2.',
          'options': ['7', '8', '11', '6'],
          'correct': 1,
        },
        {
          'question': 'Find the area under y = 4x + 3 from x = 0 to x = 4.',
          'options': ['40', '48', '44', '45'],
          'correct': 2,
        },
        {
          'question': 'Find the area under y = 2x from x = 0 to x = 2.',
          'options': ['4', '5', '1', '6'],
          'correct': 0,
        },
        {
          'question': 'Find the area under y = 4x + 2 from x = 0 to x = 3.',
          'options': ['28', '25', '24', '20'],
          'correct': 2,
        },
        {
          'question': 'Find the area under y = 2x + 2 from x = 0 to x = 5.',
          'options': ['37', '36', '38', '35'],
          'correct': 3,
        },
        {
          'question': 'Find the area under y = x + 1 from x = 0 to x = 3.',
          'options': ['23/2', '7/2', '13/2', '15/2'],
          'correct': 3,
        },
        {
          'question': 'Find the area under y = x + 1 from x = 0 to x = 4.',
          'options': ['14', '16', '12', '10'],
          'correct': 2,
        },
        {
          'question': 'Find the area under y = 3x from x = 0 to x = 5.',
          'options': ['67/2', '75/2', '71/2', '73/2'],
          'correct': 1,
        },
        {
          'question': 'Find the area under y = 3x + 3 from x = 0 to x = 2.',
          'options': ['10', '12', '16', '8'],
          'correct': 1,
        },
        {
          'question': 'Find the area under y = 3x + 2 from x = 0 to x = 4.',
          'options': ['36', '34', '32', '35'],
          'correct': 2,
        },
        {
          'question': 'Find the area under y = x + 3 from x = 0 to x = 4.',
          'options': ['20', '18', '16', '24'],
          'correct': 0,
        },
      ];

    case 'mts102_u7_2': // Volume Problems
      return [
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 4x about the x-axis from x = 1 to x = 2.',
          'options': ['56π/3', '112π/3', '115π/3', '224π/3'],
          'correct': 1,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 5x about the x-axis from x = 1 to x = 4.',
          'options': ['1050π', '1225·2^(2/21)·3^(25/91)·5^(253/273)·7^(227/273)/24', '525π', '525π/2'],
          'correct': 2,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 3x about the x-axis from x = 0 to x = 4.',
          'options': ['192π', '193π', '96π', '384π'],
          'correct': 0,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 5x about the x-axis from x = 0 to x = 3.',
          'options': ['225π/2', '450π', '226π', '225π'],
          'correct': 3,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 2x about the x-axis from x = 1 to x = 5.',
          'options': ['496π/3', '499π/3', '992π/3', '248π/3'],
          'correct': 0,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 5x about the x-axis from x = 1 to x = 5.',
          'options': ['1550π/3', '3103π/3', '6200π/3', '3100π/3'],
          'correct': 3,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 5x about the x-axis from x = 0 to x = 4.',
          'options': ['1603π/3', '1600π/3', '800π/3', '3200π/3'],
          'correct': 1,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 4x about the x-axis from x = 1 to x = 5.',
          'options': ['3968π/3', '992π/3', '1987π/3', '1984π/3'],
          'correct': 3,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 2x about the x-axis from x = 0 to x = 4.',
          'options': ['512π/3', '256π/3', '259π/3', '128π/3'],
          'correct': 1,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 3x about the x-axis from x = 0 to x = 1.',
          'options': ['3π/2', '3π', '6π', '4π'],
          'correct': 1,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = x about the x-axis from x = 0 to x = 3.',
          'options': ['9π/2', '10π', '18π', '9π'],
          'correct': 3,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = x about the x-axis from x = 0 to x = 2.',
          'options': ['8π/3', '11π/3', '4π/3', '16π/3'],
          'correct': 0,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 2x about the x-axis from x = 0 to x = 1.',
          'options': ['4π/3', '7π/3', '8π/3', '2π/3'],
          'correct': 0,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 3x about the x-axis from x = 0 to x = 2.',
          'options': ['48π', '12π', '24π', '25π'],
          'correct': 2,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 2x about the x-axis from x = 0 to x = 2.',
          'options': ['64π/3', '35π/3', '16π/3', '32π/3'],
          'correct': 3,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = x about the x-axis from x = 1 to x = 2.',
          'options': ['7π/3', '14π/3', '7π/6', '10π/3'],
          'correct': 0,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 5x about the x-axis from x = 0 to x = 1.',
          'options': ['50π/3', '28π/3', '25π/6', '25π/3'],
          'correct': 3,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = x about the x-axis from x = 0 to x = 4.',
          'options': ['32π/3', '64π/3', '128π/3', '67π/3'],
          'correct': 1,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 3x about the x-axis from x = 1 to x = 2.',
          'options': ['42π', '21π', '22π', '21π/2'],
          'correct': 1,
        },
        {
          'question': 'Using the disk method, find the volume generated by rotating y = 4x about the x-axis from x = 0 to x = 1.',
          'options': ['32π/3', '19π/3', '16π/3', '8π/3'],
          'correct': 2,
        },
      ];

    case 'mts102_u7_3': // Real-World Apps
      return [
        {
          'question': 'A ball\'s height is h(t) = -16t2 + 64t. At what time does it reach maximum height?',
          'options': ['t = 4 seconds', 't = 1 second', 't = 2 seconds', 't = 3 seconds'],
          'correct': 2,
        },
        {
          'question': 'If position s(t) = t2 - 4t, what is the velocity at t = 3?',
          'options': ['3', '2', '-1', '6'],
          'correct': 1,
        },
        {
          'question': 'If cost C(x) = 5x + 200 (in dollars for x units), what is the marginal cost?',
          'options': ['5', '200', '1/5', '5x'],
          'correct': 0,
        },
        {
          'question': 'A rectangle has perimeter 40. If width = x, express length in terms of x.',
          'options': ['40 - x', '2x', '20 - x', 'x - 20'],
          'correct': 2,
        },
        {
          'question': 'If revenue R(x) = 50x - x2, at what x is revenue maximized?',
          'options': ['x = 0', 'x = 50', 'x = 25', 'x = 100'],
          'correct': 2,
        },
        {
          'question': 'A tank drains so that volume V(t) = 500 - 20t. When is the tank empty?',
          'options': ['t = 20', 't = 5', 't = 25', 't = 500'],
          'correct': 2,
        },
        {
          'question': 'If a population grows as P(t) = 100e^(0.05t), what is P(0)?',
          'options': ['0', '105', '0.05', '100'],
          'correct': 3,
        },
        {
          'question': 'Speed is the derivative of which quantity with respect to time?',
          'options': ['mass', 'acceleration', 'force', 'position'],
          'correct': 3,
        },
        {
          'question': 'Acceleration is the derivative of which quantity with respect to time?',
          'options': ['mass', 'distance', 'velocity', 'position'],
          'correct': 2,
        },
        {
          'question': 'If profit P(x) = -2x2 + 40x - 50, find the number of units x that maximizes profit.',
          'options': ['x = 5', 'x = 40', 'x = 20', 'x = 10'],
          'correct': 3,
        },
        {
          'question': 'The total distance traveled equals the definite integral of:',
          'options': ['speed over the time interval', 'position over the time interval', 'acceleration over the time interval', 'force over the time interval'],
          'correct': 0,
        },
        {
          'question': 'A company\'s marginal revenue is the derivative of:',
          'options': ['total cost', 'profit margin', 'total revenue', 'fixed cost'],
          'correct': 2,
        },
        {
          'question': 'If a rock is dropped, height h(t) = 100 - 16t2. When does it hit the ground?',
          'options': ['t = 100', 't = 16', 't = 2.5', 't = 5'],
          'correct': 2,
        },
        {
          'question': 'Optimization problems in calculus typically use which tool to find max/min values?',
          'options': ['derivatives set equal to zero', 'integrals only', 'the domain only', 'limits only'],
          'correct': 0,
        },
        {
          'question': 'If the rate of water flow is r(t) liters/min, total water added over [0,T] is:',
          'options': ['r(T) - r(0)', '∫ from 0 to T of r(t) dt', 'r(T) alone', 'the derivative of r at T'],
          'correct': 1,
        },
        {
          'question': 'A box\'s volume is V(x) = x(10-2x)(10-2x) for side cutouts x. This models:',
          'options': ['a straight-line distance problem', 'a related-rates problem', 'a limit problem', 'an open-top box optimization problem'],
          'correct': 3,
        },
        {
          'question': 'In related rates problems, we typically differentiate an equation with respect to:',
          'options': ['volume', 'time', 'area', 'position'],
          'correct': 1,
        },
        {
          'question': 'If A = πr^2 and dr/dt = 3, related rates gives dA/dt in terms of:',
          'options': ['r (since dA/dt = 2πr·dr/dt)', 'A only', 'a constant only', 't only'],
          'correct': 0,
        },
        {
          'question': 'The average value of a function f(x) on [a,b] is given by:',
          'options': ['f(b) - f(a)', '(1/(b-a)) ∫ from a to b of f(x) dx', 'the maximum value of f on [a,b]', 'f(a) + f(b)) / 2'],
          'correct': 1,
        },
        {
          'question': 'If fuel efficiency depends on speed, the optimal speed problem is typically solved using:',
          'options': ['guesswork', 'calculus optimization (derivatives)', 'only graphing', 'algebra alone'],
          'correct': 1,
        },
      ];

    default:
      return [];
  }
}