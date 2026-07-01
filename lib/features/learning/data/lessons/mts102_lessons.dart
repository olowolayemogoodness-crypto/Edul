// lib/features/learning/data/lessons/mts102_lessons.dart

Map<String, dynamic> getMTS102LessonData(String lessonId) {
  switch (lessonId) {
    case 'mts102_u1_1':
      return {
        'content': '''# Function Basics

## What Is a Function of a Real Variable?

A function of a real variable is a rule that assigns to each real number x in a specified set (called the domain) exactly one real number y, called the output or image. We write this as f: ℝ → ℝ, or simply y = f(x). The set of all outputs is called the range or codomain.

Functions are the backbone of all quantitative science. Every time an engineer calculates voltage from current (V = IR), a pharmacist models drug concentration over time, or a physicist describes projectile motion, they are using functions of real variables.

## Key Concepts

**Domain and Range**: The domain is the set of allowable inputs. For f(x) = √x, the domain is x ≥ 0 because negative inputs produce non-real outputs.

**Types of Functions**: Linear, Quadratic, Polynomial, Rational, Trigonometric, Exponential, and Logarithmic.

**Composite Functions**: If g(x) = x² and f(x) = √x, then f(g(x)) = √(x²) = |x|.

**Inverse Functions**: f⁻¹ undoes f. If f(x) = 2x + 3, then f⁻¹(x) = (x − 3)/2.

**Even and Odd Functions**: f(x) is even if f(−x) = f(x); odd if f(−x) = −f(x).''',
        'questions': [
          {
            'question': 'Define a function of a real variable and state the conditions a rule must satisfy to qualify as a function.',
            'options': ['A rule that assigns multiple outputs to each input', 'A rule that assigns exactly one output to each input in the domain', 'A rule that assigns outputs to inputs randomly', 'A rule that always has an inverse'],
            'correct': 1,
          },
          {
            'question': 'Given f(x) = 3x² − 2x + 1, find f(2).',
            'options': ['5', '9', '11', '13'],
            'correct': 2,
          },
          {
            'question': 'Determine the domain of f(x) = 1/(x² − 4).',
            'options': ['All real numbers', 'All real numbers except x = 2', 'All real numbers except x = ±2', 'x ≥ 0'],
            'correct': 2,
          },
          {
            'question': 'If f(x) = 2x + 5 and g(x) = x² − 1, what is (f ∘ g)(x)?',
            'options': ['2x² + 3', '2x² + 2x + 3', '(2x + 5)(x² − 1)', '2(x² − 1) + 5'],
            'correct': 3,
          },
          {
            'question': 'Show that f(x) = x³ is an odd function by checking f(−x) = −f(x).',
            'options': ['f(−x) = −x³ = −f(x) ✓', 'f(−x) = x³ = f(x)', 'The function is even', 'The function is neither even nor odd'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u1_2':
      return {
        'content': '''# Domain and Range

## Understanding Domain

The domain of a function is the complete set of possible input values (x-values) for which the function is defined.

To find the domain, identify restrictions:
- Division by zero: denominators cannot equal zero
- Square roots of negatives: arguments must be non-negative for real numbers
- Logarithms: arguments must be positive

## Understanding Range

The range is the set of all possible output values (y-values). Finding the range requires analyzing the function's behavior and checking for maximum or minimum values.

## Finding Domain and Range

For f(x) = √(9 − x²):
- Domain: 9 − x² ≥ 0, so x² ≤ 9, giving −3 ≤ x ≤ 3
- Range: Maximum value is 3 (when x = 0), minimum is 0 (when x = ±3), so 0 ≤ y ≤ 3''',
        'questions': [
          {
            'question': 'Find the domain and range of f(x) = √(9 − x²).',
            'options': ['Domain: −3 ≤ x ≤ 3, Range: 0 ≤ y ≤ 3', 'Domain: x ≥ 0, Range: y ≥ 0', 'Domain: all reals, Range: 0 ≤ y ≤ 3', 'Domain: x ≥ 3, Range: y ≤ 0'],
            'correct': 0,
          },
          {
            'question': 'State the domain of f(x) = ln(x² − 5x + 6).',
            'options': ['All real numbers', 'x < 2 or x > 3', 'x ≤ 2 or x ≥ 3', '2 < x < 3'],
            'correct': 1,
          },
          {
            'question': 'Classify the following as functions or not: y² = x',
            'options': ['Function', 'Not a function (multiple outputs for some x)', 'Function only when y ≥ 0', 'Depends on domain'],
            'correct': 1,
          },
          {
            'question': 'Find the range of f(x) = (x − 2)² + 3.',
            'options': ['All real numbers', 'y ≥ 3', 'y ≤ 3', '2 ≤ y ≤ 3'],
            'correct': 1,
          },
          {
            'question': 'A phone plan charges 5,000 naira per month plus 20 per minute of calls. The domain represents:',
            'options': ['Time interval [0, ∞)', 'Number of minutes [0, ∞)', 'Cost in naira', 'Price per minute'],
            'correct': 1,
          },
        ]
      };

    case 'mts102_u1_3':
      return {
        'content': '''# Function Operations and Inverses

## Composite Functions

Composition combines two functions: (f ∘ g)(x) = f(g(x)). We apply g first, then apply f to the result.

Example: If g(x) = x² and f(x) = √x, then (f ∘ g)(x) = √(x²) = |x|.

## Inverse Functions

An inverse function f⁻¹ reverses the action of f. If f(x) = 2x + 3, then f⁻¹(x) = (x − 3)/2.

Inverses exist only for one-to-one (injective) functions where each output corresponds to exactly one input.

## Finding an Inverse

1. Write y = f(x)
2. Solve for x in terms of y
3. Swap x and y
4. The result is f⁻¹(x)''',
        'questions': [
          {
            'question': 'Determine whether f(x) = x³ − x is one-to-one using the horizontal line test.',
            'options': ['One-to-one (passes horizontal line test)', 'Not one-to-one (fails horizontal line test)', 'Cannot be determined', 'Always passes the test'],
            'correct': 1,
          },
          {
            'question': 'Find the inverse of f(x) = (3x − 1)/(x + 2).',
            'options': ['f⁻¹(x) = (2x + 1)/(3 − x)', 'f⁻¹(x) = (−2x − 1)/(x − 3)', 'f⁻¹(x) = (x + 1)/(x − 3)', 'No inverse exists'],
            'correct': 0,
          },
          {
            'question': 'Two functions are f(x) = x + 1 and g(x) = x² − x − 2. Solve f(x) = g(x).',
            'options': ['x = −1 or x = 3', 'x = 1 or x = −3', 'x = 2 or x = −1', 'No solution'],
            'correct': 0,
          },
          {
            'question': 'If f(x) = |x| and g(x) = x − 3, what is (f ∘ g)(1)?',
            'options': ['2', '−2', '4', '−4'],
            'correct': 0,
          },
          {
            'question': 'Determine whether h(x) = x⁴ − 6x² + 1 is even, odd, or neither.',
            'options': ['Even', 'Odd', 'Neither', 'Cannot be determined'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u2_1':
      return {
        'content': '''# Graph Basics and Intercepts

## Understanding Graphs

The graph of a function f is the set of all points (x, f(x)) in the Cartesian plane. A graph visually shows how output values change as input values change.

## Finding Intercepts

**X-Intercepts (Zeros)**: Points where the graph crosses the x-axis. Found by solving f(x) = 0.

Example: For f(x) = x² − 4, set x² − 4 = 0, giving x = ±2.

**Y-Intercept**: The point where the graph crosses the y-axis, found by evaluating f(0).

Example: For f(x) = 2x − 3, f(0) = −3, so the y-intercept is (0, −3).

## Vertical Line Test

A curve is the graph of a function if and only if every vertical line intersects the curve at most once.''',
        'questions': [
          {
            'question': 'Find the x- and y-intercepts of f(x) = x³ − 3x² − x + 3.',
            'options': ['x-intercepts: −1, 1, 3; y-intercept: 3', 'x-intercepts: 1, 3; y-intercept: −3', 'x-intercepts: −1, 1, 3; y-intercept: −3', 'y-intercept only: (0, 3)'],
            'correct': 0,
          },
          {
            'question': 'Sketch the graph of f(x) = 2x − 3. What is the slope?',
            'options': ['Slope = 2, y-intercept = −3', 'Slope = −3, y-intercept = 2', 'Slope = −2, y-intercept = 3', 'Slope = 3, y-intercept = −2'],
            'correct': 0,
          },
          {
            'question': 'Plot f(x) = x² − 4x + 3. Find the vertex and axis of symmetry.',
            'options': ['Vertex: (2, −1), Axis: x = 2', 'Vertex: (2, 1), Axis: x = 2', 'Vertex: (−2, 1), Axis: x = −2', 'Vertex: (1, −1), Axis: x = 1'],
            'correct': 0,
          },
          {
            'question': 'What is the vertical line test used for?',
            'options': ['To find intercepts', 'To determine if a curve represents a function', 'To find the slope', 'To determine asymptotes'],
            'correct': 1,
          },
          {
            'question': 'A company profit curve is P(x) = −x² + 10x − 16. Find the maximum profit.',
            'options': ['Profit = 9 at x = 5', 'Profit = 16 at x = 2', 'Profit = −16 at x = 0', 'No maximum exists'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u2_2':
      return {
        'content': '''# Transformations and Asymptotes

## Function Transformations

Transformations modify the parent graph systematically:

**Vertical Shifts**: f(x) + k shifts the graph up k units (k > 0) or down (k < 0).

**Horizontal Shifts**: f(x − h) shifts right h units (h > 0) or left (h < 0).

**Reflections**: −f(x) reflects over the x-axis; f(−x) reflects over the y-axis.

**Vertical Scaling**: c·f(x) stretches (c > 1) or compresses (0 < c < 1) vertically.

## Asymptotes

**Vertical Asymptotes**: Occur where the function approaches ±∞, typically where the denominator is zero.

**Horizontal Asymptotes**: Describe long-run behavior as x → ±∞. Found by comparing degrees of numerator and denominator in rational functions.''',
        'questions': [
          {
            'question': 'State the transformations that map y = x² onto y = −(x + 2)² + 5.',
            'options': ['Shift left 2, reflect over x-axis, shift up 5', 'Shift right 2, reflect over y-axis, shift up 5', 'Shift left 2, reflect over y-axis, shift up 5', 'Shift down 5, shift left 2, reflect'],
            'correct': 0,
          },
          {
            'question': 'What is the horizontal asymptote of f(x) = (3x² + 1)/(x² − 2)?',
            'options': ['y = 3', 'y = 1', 'y = −2', 'y = 0'],
            'correct': 0,
          },
          {
            'question': 'Find the vertical asymptotes of f(x) = (x + 1)/((x − 2)(x + 3)).',
            'options': ['x = 2 and x = −3', 'x = −1 only', 'x = 0 and x = 1', 'No vertical asymptotes'],
            'correct': 0,
          },
          {
            'question': 'Describe how the graph of g(x) = 2sin(3x − π) differs from f(x) = sin(x).',
            'options': ['Horizontal compression by 1/3, horizontal shift right π/3, vertical stretch by 2', 'Vertical stretch by 2, period change', 'Both A and B', 'Only vertical stretch'],
            'correct': 2,
          },
          {
            'question': 'Graph f(x) = 1/x and describe behavior as x → 0⁺ and x → 0⁻.',
            'options': ['As x → 0⁺, f(x) → +∞; as x → 0⁻, f(x) → −∞', 'As x → 0⁺, f(x) → −∞; as x → 0⁻, f(x) → +∞', 'As x → 0⁺, f(x) → 0; as x → 0⁻, f(x) → 0', 'Both sides approach infinity with same sign'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u2_3':
      return {
        'content': '''# Curve Analysis

## Symmetry and Even/Odd Functions

**Even Functions**: f(−x) = f(x) — symmetric about the y-axis.
Example: f(x) = x⁴ − 6x² + 1

**Odd Functions**: f(−x) = −f(x) — symmetric about the origin.
Example: f(x) = x³ − 3x

## Piecewise Functions

Functions defined by different rules on different intervals.

## Key Features to Identify

1. Continuity: Can we draw the graph without lifting our pen?
2. Discontinuities: Jump, removable (hole), or infinite (asymptote)
3. End behavior: What happens as x → ±∞?
4. Turning points: Where does the graph change direction?''',
        'questions': [
          {
            'question': 'Sketch the piecewise function: f(x) = { x + 1, x < 0; x², x ≥ 0 }.',
            'options': ['Line with slope 1 for x < 0; parabola for x ≥ 0', 'Parabola everywhere', 'Line everywhere', 'Two separate pieces with discontinuity'],
            'correct': 0,
          },
          {
            'question': 'On the same axes, sketch y = x² and y = x³. How many intersection points exist?',
            'options': ['0 intersections', '1 intersection at origin', '2 intersections', '3 intersections'],
            'correct': 2,
          },
          {
            'question': 'Describe the graph of f(x) = −√(x + 4).',
            'options': ['Domain: x ≥ −4; Range: y ≤ 0; reflected downward', 'Domain: x ≥ 0; Range: y ≥ 0; reflected upward', 'Domain: all reals; Range: y ≤ 0', 'Domain: x ≥ 4; Range: y ≤ 4'],
            'correct': 0,
          },
          {
            'question': 'A ball is thrown with height h(t) = −5t² + 30t. What is the maximum height?',
            'options': ['30 m', '45 m', '60 m', '90 m'],
            'correct': 1,
          },
          {
            'question': 'Describe the end behaviour of f(x) = −2x⁴ + x² − 7.',
            'options': ['As x → ±∞, f(x) → −∞', 'As x → ±∞, f(x) → +∞', 'As x → +∞, f(x) → +∞; as x → −∞, f(x) → −∞', 'The function is bounded'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u3_1':
      return {
        'content': '''# Limit Concept

## What is a Limit?

The limit of a function f(x) as x approaches a value c describes what output f(x) gets closer and closer to — even if f(c) itself is undefined at that point.

We write: lim(x→c) f(x) = L

This means for x values very close to c (but not equal to c), f(x) gets arbitrarily close to L.

## One-Sided Limits

**Left-Hand Limit**: lim(x→c⁻) f(x) — approaching c from values less than c

**Right-Hand Limit**: lim(x→c⁺) f(x) — approaching c from values greater than c

A two-sided limit exists only if both one-sided limits are equal.

## Evaluating Limits

For continuous functions, direct substitution works. For indeterminate forms (0/0 or ∞/∞), use factorization, rationalization, or L'Hôpital's Rule.''',
        'questions': [
          {
            'question': 'Evaluate lim(x→3) (x² − 9)/(x − 3) using factorisation.',
            'options': ['3', '6', 'undefined', '0'],
            'correct': 1,
          },
          {
            'question': 'Find lim(x→0) sin(x)/x. What theorem does this illustrate?',
            'options': ['Limit = 1; Squeeze Theorem', 'Limit = 0; L\'Hôpital\'s Rule', 'Limit = ∞; undefined', 'Limit = 1; Fundamental limit'],
            'correct': 3,
          },
          {
            'question': 'Determine lim(x→2⁺) f(x) and lim(x→2⁻) f(x) for f(x) = |x − 2|/(x − 2).',
            'options': ['Both equal 1', 'Right = 1, Left = −1', 'Right = −1, Left = 1', 'Both undefined'],
            'correct': 1,
          },
          {
            'question': 'Evaluate lim(x→∞) (5x³ − 2x)/(3x³ + x²).',
            'options': ['5/3', '1', '0', '∞'],
            'correct': 0,
          },
          {
            'question': 'For a population model P(t) = 1000/(1 + 9e^(−0.5t)), find lim(t→∞) P(t).',
            'options': ['0', '1000', '100', '∞'],
            'correct': 1,
          },
        ]
      };

    case 'mts102_u3_2':
      return {
        'content': '''# Evaluating Limits

## Algebraic Techniques

**Factorization**: Cancel common factors to remove indeterminate forms.

**Rationalization**: Multiply by conjugates to eliminate square roots.

**L'Hôpital's Rule**: If substitution gives 0/0 or ∞/∞, differentiate numerator and denominator separately.

**The Squeeze Theorem**: If g(x) ≤ f(x) ≤ h(x) near c and lim g = lim h = L, then lim f = L.

## Trigonometric Limits

Key limits to remember:
- lim(x→0) sin(x)/x = 1
- lim(x→0) (1 − cos x)/x² = 1/2
- lim(x→0) tan(x)/x = 1''',
        'questions': [
          {
            'question': 'Find lim(x→0) (1 − cos x)/x².',
            'options': ['0', '1/2', '1', '∞'],
            'correct': 1,
          },
          {
            'question': 'Use L\'Hôpital\'s Rule to evaluate lim(x→0) (eˣ − 1 − x)/x².',
            'options': ['0', '1/4', '1/2', '1'],
            'correct': 2,
          },
          {
            'question': 'Show that lim(x→0) x²sin(1/x) = 0 using the Squeeze Theorem.',
            'options': ['−|x| ≤ x²sin(1/x) ≤ |x|, and |x| → 0', '−x² ≤ x²sin(1/x) ≤ x², and x² → 0', 'Direct substitution gives 0', 'The limit does not exist'],
            'correct': 1,
          },
          {
            'question': 'Evaluate lim(x→0) tan(3x)/(5x).',
            'options': ['0', '1/5', '3/5', '3'],
            'correct': 2,
          },
          {
            'question': 'Find lim(x→−∞) (x² + x)/(2x² − 3).',
            'options': ['0', '1/2', '−1/2', '∞'],
            'correct': 1,
          },
        ]
      };

    case 'mts102_u3_3':
      return {
        'content': '''# Continuity

## Definition of Continuity

A function f is continuous at x = c if three conditions hold:
1. f(c) is defined
2. lim(x→c) f(x) exists
3. lim(x→c) f(x) = f(c)

Intuitively, continuity means you can draw the graph without lifting your pen.

## Types of Discontinuities

**Removable (Hole)**: The limit exists but either f(c) is undefined or doesn't equal the limit.

**Jump (Finite)**: Left and right limits exist but are unequal.

**Infinite (Vertical Asymptote)**: The limit approaches ±∞.

## Intermediate Value Theorem

If f is continuous on [a, b] and N is between f(a) and f(b), then there exists c in (a, b) such that f(c) = N.''',
        'questions': [
          {
            'question': 'Determine if f(x) = (x² − 1)/(x − 1) has a removable discontinuity at x = 1.',
            'options': ['Yes, with a hole at (1, 2)', 'No, it\'s undefined everywhere', 'Yes, with a jump', 'Cannot determine from given info'],
            'correct': 0,
          },
          {
            'question': 'A function f is defined as f(x) = { 2x + 1, x < 3; x² − 2, x ≥ 3 }. Is f continuous at x = 3?',
            'options': ['Yes, left and right limits equal 7', 'No, left limit = 7, right limit = 7... wait, yes', 'Yes, f is continuous', 'No, it has a jump discontinuity'],
            'correct': 2,
          },
          {
            'question': 'Find the value of k making f(x) = { kx² + 2, x ≤ 2; 3x + 1, x > 2 } continuous at x = 2.',
            'options': ['k = 1', 'k = 5/4', 'k = 3/4', 'k = 2'],
            'correct': 1,
          },
          {
            'question': 'Determine where f(x) = 1/(x² − x − 6) is discontinuous and classify each.',
            'options': ['Removable at x = 2, 3', 'Infinite discontinuities at x = 3 and x = −2', 'Jump discontinuity at x = 1', 'Continuous everywhere'],
            'correct': 1,
          },
          {
            'question': 'State the Intermediate Value Theorem.',
            'options': ['If f is continuous and N is between f(a) and f(b), then ∃c: f(c) = N', 'All functions have intermediate values', 'Discontinuous functions cannot have solutions', 'Only polynomial functions satisfy this'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u4_1':
      return {
        'content': '''# Rate of Change

## The Derivative as Instantaneous Rate of Change

The derivative f′(x) measures the instantaneous rate of change of f at x. It tells you how fast f(x) is changing at any given point.

Geometrically, f′(x) is the slope of the tangent line to the graph of f at that point.

## The Formal Definition

f′(x) = lim(h→0) [f(x+h) − f(x)]/h

This definition represents the limit of average rates of change as the interval shrinks to a point.

## Real-World Interpretations

**Physics**: If s(t) is position, then s′(t) is velocity.

**Economics**: If C(x) is total cost, then C′(x) is marginal cost.

**Medicine**: If C(t) is drug concentration, then C′(t) is the rate of change of concentration.''',
        'questions': [
          {
            'question': 'A stone is dropped with position s(t) = −4.9t². Find the velocity at t = 3 s.',
            'options': ['−9.8 m/s', '−14.7 m/s', '−29.4 m/s', '29.4 m/s'],
            'correct': 2,
          },
          {
            'question': 'Given f(x) = x², find f′(x) using the formal definition.',
            'options': ['f′(x) = 2x', 'f′(x) = x', 'f′(x) = 2', 'f′(x) = 1'],
            'correct': 0,
          },
          {
            'question': 'A car travels d(t) = t² km. Using limits, find the instantaneous speed at t = 3 seconds.',
            'options': ['1 km/s', '3 km/s', '6 km/s', '9 km/s'],
            'correct': 2,
          },
          {
            'question': 'What does f′(x) represent geometrically?',
            'options': ['The x-intercept', 'The y-intercept', 'The slope of the tangent line', 'The area under the curve'],
            'correct': 2,
          },
          {
            'question': 'In economics, if C(x) is total cost, what does C′(x) represent?',
            'options': ['Total revenue', 'Marginal cost', 'Fixed cost', 'Average cost'],
            'correct': 1,
          },
        ]
      };

    case 'mts102_u4_2':
      return {
        'content': '''# Differentiation Rules

## The Power Rule

d/dx (xⁿ) = nxⁿ⁻¹

## The Product Rule

d/dx [f·g] = f′g + fg′

## The Quotient Rule

d/dx [f/g] = (f′g − fg′)/g²

## The Chain Rule

d/dx [f(g(x))] = f′(g(x))·g′(x)

## Standard Derivatives

- d/dx (sin x) = cos x
- d/dx (cos x) = −sin x
- d/dx (eˣ) = eˣ
- d/dx (ln x) = 1/x

## Implicit Differentiation

Used when y is not isolated. Differentiate both sides with respect to x, treating y as a function of x.''',
        'questions': [
          {
            'question': 'Differentiate f(x) = 5x⁴ − 3x³ + 7x − 2.',
            'options': ['20x³ − 9x² + 7', '20x⁴ − 9x³ + 7', '5x⁵ − x⁴ + 7x²', '4x³ − 3x² + 1'],
            'correct': 0,
          },
          {
            'question': 'Find dy/dx if y = (3x² + 1)(x − 4) using the product rule.',
            'options': ['6x(x − 4) + 3x² + 1', '9x² − 24x + 1', '6x² − 24x + x − 4', 'Cannot use product rule'],
            'correct': 1,
          },
          {
            'question': 'Use the chain rule to find d/dx [sin(3x² + 1)].',
            'options': ['cos(3x² + 1)', '6x cos(3x² + 1)', 'sin(6x)', '3cos(6x)'],
            'correct': 1,
          },
          {
            'question': 'Find f′(x) if f(x) = e^(x² − 2x).',
            'options': ['e^(x² − 2x)', '(2x − 2)e^(x² − 2x)', 'e^(2x − 2)', 'x·e^(x² − 2x)'],
            'correct': 1,
          },
          {
            'question': 'Use implicit differentiation on x² + y² = 25 to find dy/dx.',
            'options': ['dy/dx = −x/y', 'dy/dx = x/y', 'dy/dx = −2x/(2y)', 'Cannot be differentiated'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u4_3':
      return {
        'content': '''# Differentiation Applications

## Finding Tangent Lines

The equation of the tangent line to f(x) at x = a is:
y − f(a) = f′(a)(x − a)

## Second Derivative

The second derivative f′′(x) measures how fast the first derivative is changing.

## Motion Applications

For a particle with position s(t):
- Velocity: v(t) = s′(t)
- Acceleration: a(t) = v′(t) = s′′(t)

## Related Rates

Problems where multiple variables change with respect to time.

## Optimization

Finding maximum and minimum values by setting f′(x) = 0 and using the Second Derivative Test.''',
        'questions': [
          {
            'question': 'Find the second derivative of f(x) = x⁴ − 3x² + 2.',
            'options': ['12x² − 6', '4x³ − 6x', '12x² + 6', '4x³ + 6x'],
            'correct': 0,
          },
          {
            'question': 'Find the equation of the tangent line to f(x) = x³ − 2x at x = 1.',
            'options': ['y = x − 2', 'y = x + 2', 'y = 2x − 3', 'y = −x'],
            'correct': 0,
          },
          {
            'question': 'A particle\'s position is s(t) = t³ − 6t² + 9t. When is it at rest?',
            'options': ['t = 1 and t = 3', 't = 0 only', 't = 2 only', 'Never'],
            'correct': 0,
          },
          {
            'question': 'Differentiate f(x) = x²·eˣ and evaluate f′(0).',
            'options': ['f′(0) = 0', 'f′(0) = 1', 'f′(0) = 2', 'f′(0) = e'],
            'correct': 0,
          },
          {
            'question': 'If y = (x² + 1)/(x² − 1), find dy/dx and state where it\'s undefined.',
            'options': ['dy/dx = −4x/(x² − 1)²; undefined at x = ±1', 'dy/dx = 2x/(x² − 1); undefined at x = 0', 'dy/dx defined everywhere', 'Only undefined at x = 1'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u5_1':
      return {
        'content': '''# Critical Points and Extrema

## Critical Points

A critical point occurs where f′(x) = 0 (horizontal tangent) or f′(x) is undefined.

## The Second Derivative Test

At a critical point c:
- If f′′(c) > 0, then f has a local minimum at c
- If f′′(c) < 0, then f has a local maximum at c
- If f′′(c) = 0, the test is inconclusive

## The First Derivative Test

Analyze the sign of f′ on either side of the critical point:
- If f′ changes from + to −, local maximum
- If f′ changes from − to +, local minimum

## Absolute Extrema

On a closed interval [a, b]:
1. Evaluate f at all critical points in (a, b)
2. Evaluate f at endpoints a and b
3. The largest value is the absolute maximum; smallest is the absolute minimum''',
        'questions': [
          {
            'question': 'Find the critical points of f(x) = x³ − 3x² + 2.',
            'options': ['x = 0 and x = 2', 'x = 1 and x = 3', 'x = 0 only', 'No critical points'],
            'correct': 0,
          },
          {
            'question': 'Use the Second Derivative Test to classify the critical points of f(x) = x⁴ − 8x².',
            'options': ['Local max at x = 0; local mins at x = ±2', 'Local min at x = 0; local maxs at x = ±2', 'All inflection points', 'No classification possible'],
            'correct': 0,
          },
          {
            'question': 'Find all local maxima and minima of f(x) = 2x³ − 9x² + 12x − 4.',
            'options': ['Max at x = 1; Min at x = 2', 'Min at x = 1; Max at x = 2', 'Only one critical point', 'No extrema exist'],
            'correct': 0,
          },
          {
            'question': 'Find the absolute maximum of f(x) = x³ − 3x on [−2, 3].',
            'options': ['At x = −2', 'At x = 1', 'At x = 3', 'At x = −1'],
            'correct': 2,
          },
          {
            'question': 'A company\'s profit is P(x) = −3x² + 180x − 500. Find the production level maximising profit.',
            'options': ['x = 30', 'x = 60', 'x = 90', 'x = 15'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u5_2':
      return {
        'content': '''# Concavity and Inflection Points

## Understanding Concavity

**Concave Up** (f′′ > 0): The graph bends upward like a cup ∪.

**Concave Down** (f′′ < 0): The graph bends downward like a cap ∩.

## Finding Regions of Concavity

1. Compute f′′(x)
2. Solve f′′(x) = 0 for potential inflection points
3. Test the sign of f′′ in each interval

## Inflection Points

An inflection point occurs where concavity changes (f′′ changes sign).

Not every point where f′′(x) = 0 is an inflection point — the concavity must actually change.

## The Second Derivative Test Revisited

At a critical point where f′(c) = 0:
- f′′(c) > 0 → local minimum (concave up)
- f′′(c) < 0 → local maximum (concave down)''',
        'questions': [
          {
            'question': 'Determine the intervals where f(x) = x³ − 6x² + 9x + 1 is increasing.',
            'options': ['(−∞, 1) and (3, ∞)', '(1, 3)', '(−∞, ∞)', 'Nowhere'],
            'correct': 0,
          },
          {
            'question': 'Find the inflection points of f(x) = x⁴ − 4x³ + 6.',
            'options': ['x = 1 and x = 2', 'x = 0 only', 'x = 2 only', 'No inflection points'],
            'correct': 0,
          },
          {
            'question': 'Determine where f(x) = xe^(−x) is concave up or down.',
            'options': ['Concave up for x < 1; Concave down for x > 1', 'Concave down for x < 2; Concave up for x > 2', 'Always concave up', 'Always concave down'],
            'correct': 1,
          },
          {
            'question': 'Find all points of inflection for f(x) = 3x⁵ − 5x³.',
            'options': ['x = ±1', 'x = 0 and x = ±1', 'x = 0 only', 'No inflection points'],
            'correct': 1,
          },
          {
            'question': 'Determine the intervals of concavity for f(x) = ln(x² + 1).',
            'options': ['Concave up everywhere', 'Concave down everywhere', 'Concave up for x > 0; Down for x < 0', 'Changes at x = 0'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u5_3':
      return {
        'content': '''# Complete Curve Sketching

## The Systematic Checklist

**Step 1 — Domain**: Identify where f(x) is defined.

**Step 2 — Intercepts**: Set x = 0 for y-intercept; set f(x) = 0 for x-intercepts.

**Step 3 — Symmetry**: Check if f is even, odd, or periodic.

**Step 4 — Asymptotes**: Vertical, horizontal, and oblique asymptotes.

**Step 5 — Increasing/Decreasing**: Find f′(x) = 0 (critical points).

**Step 6 — Local Extrema**: Apply First or Second Derivative Test.

**Step 7 — Concavity and Inflection**: f′′ > 0 → concave up; f′′ < 0 → concave down.''',
        'questions': [
          {
            'question': 'Using a complete curve-sketching analysis, sketch f(x) = x/(x² + 1).',
            'options': ['Odd function, max at x = 1, min at x = −1, horizontal asymptote y = 0', 'Even function, max at x = 0', 'No critical points', 'Vertical asymptotes at x = ±1'],
            'correct': 0,
          },
          {
            'question': 'Sketch f(x) = (x − 1)²(x + 2) showing all turning points and intercepts.',
            'options': ['Touches x-axis at x = 1, crosses at x = −2; Min at x = 1', 'Crosses at x = 1 and x = −2; Max at x = −1/3', 'Only one x-intercept', 'No critical points'],
            'correct': 0,
          },
          {
            'question': 'Sketch f(x) = (x² − 4)/(x² − 9) labelling all asymptotes and intercepts.',
            'options': ['Vertical at x = ±3; Horizontal y = 1; x-intercepts at ±2', 'Vertical at x = ±2; Horizontal y = 1', 'No asymptotes', 'Only one asymptote'],
            'correct': 0,
          },
          {
            'question': 'Sketch f(x) = x²·e^(−x) and identify all extrema and inflection points.',
            'options': ['Max at x = 2; Inflections at x = 2 ± √2', 'Min at x = 0; Max at x = 2', 'Only one critical point', 'No critical points'],
            'correct': 0,
          },
          {
            'question': 'A farmer has 200 m of fencing. Write the area as a function of width and find max area.',
            'options': ['A(w) = w(100 − w); Max at w = 50 m; Max area = 2500 m²', 'A(w) = 2w(100 − w); Max at w = 25 m', 'Linear increase with no maximum', 'Maximum is at boundary w = 100 m'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u6_1':
      return {
        'content': '''# Basic Integration

## What Is Integration?

Integration is the reverse process of differentiation. Given a function f(x), we seek a function F(x) such that F′(x) = f(x).

## The Power Rule for Integration

∫xⁿ dx = x^(n+1)/(n+1) + C, for n ≠ −1

## Special Cases

∫1/x dx = ln|x| + C

∫eˣ dx = eˣ + C

∫sin(x) dx = −cos(x) + C

∫cos(x) dx = sin(x) + C

## Definite Integrals

∫[a to b] f(x) dx = F(b) − F(a)

## The Fundamental Theorem of Calculus

Differentiation and integration are inverse operations.''',
        'questions': [
          {
            'question': 'Evaluate ∫(3x² − 2x + 5) dx.',
            'options': ['x³ − x² + 5x + C', '6x − 2 + C', '3x³ − 2x² + 5x + C', 'x³ − 2x² + 5x + C'],
            'correct': 0,
          },
          {
            'question': 'Find ∫(1/x) dx.',
            'options': ['ln(x) + C', 'ln|x| + C (x ≠ 0)', '1/x² + C', 'x + C'],
            'correct': 1,
          },
          {
            'question': 'Compute ∫₀² (x² + 3) dx using the Fundamental Theorem.',
            'options': ['8/3', '10', '14/3', '6'],
            'correct': 2,
          },
          {
            'question': 'Evaluate ∫sin(2x) dx.',
            'options': ['cos(2x) + C', '−cos(2x)/2 + C', '−sin(2x) + C', 'sin(2x)/2 + C'],
            'correct': 1,
          },
          {
            'question': 'Compute ∫₁⁴ √x dx.',
            'options': ['7/3', '14/3', '7', '28/3'],
            'correct': 1,
          },
        ]
      };

    case 'mts102_u6_2':
      return {
        'content': '''# Integration Methods

## Substitution (u-substitution)

When the integrand contains a composite function, substitution simplifies the integral.

## Integration by Parts

For products of functions, use ∫u dv = uv − ∫v du

## Partial Fractions

For rational functions, decompose into simpler fractions.

## Trigonometric Integrals

Use identities to simplify before integrating.''',
        'questions': [
          {
            'question': 'Use substitution to find ∫(2x)(x² + 1)⁴ dx.',
            'options': ['(x² + 1)⁵/5 + C', '(x² + 1)⁴ + C', '(2x)⁵/5 + C', 'x²(x² + 1)⁴ + C'],
            'correct': 0,
          },
          {
            'question': 'Evaluate ∫x·eˣ dx using integration by parts.',
            'options': ['x·eˣ − eˣ + C', 'x·eˣ + C', 'eˣ + C', '(x − 1)eˣ + C'],
            'correct': 3,
          },
          {
            'question': 'Find ∫(x² + 1)/(x³ + 3x) dx using substitution.',
            'options': ['ln|x³ + 3x| + C', '(1/3)ln|x³ + 3x| + C', 'ln|x² + 1| + C', '(x² + 1)²/(x³ + 3x) + C'],
            'correct': 1,
          },
          {
            'question': 'Compute ∫tan(x) dx by writing tan as sin/cos and using substitution.',
            'options': ['−ln|cos(x)| + C', 'ln|sin(x)| + C', 'ln|sec(x)| + C', 'tan²(x)/2 + C'],
            'correct': 0,
          },
          {
            'question': 'Evaluate ∫₀^(π/2) cos(x) dx.',
            'options': ['0', '1', 'π/2', '−1'],
            'correct': 1,
          },
        ]
      };

    case 'mts102_u6_3':
      return {
        'content': '''# Integration Applications

## Area Under a Curve

The area under f(x) from a to b is:
A = ∫[a to b] f(x) dx

## Area Between Curves

If f(x) ≥ g(x) on [a, b]:
A = ∫[a to b] [f(x) − g(x)] dx

## Work Done by a Force

Work = ∫F(x) dx

## Average Value of a Function

f_avg = (1/(b−a))·∫[a to b] f(x) dx

## Displacement vs Distance

If v(t) is velocity:
- Displacement = ∫v(t) dt
- Total distance = ∫|v(t)| dt''',
        'questions': [
          {
            'question': 'Find the area enclosed between f(x) = x² and g(x) = x + 2.',
            'options': ['9/2', '4', '5/2', '3'],
            'correct': 0,
          },
          {
            'question': 'Find the area between y = sin(x) and y = cos(x) for x ∈ [0, π/4].',
            'options': ['√2 − 1', '1 − √2/2', '2 − √2', '(√2 − 1)/2'],
            'correct': 0,
          },
          {
            'question': 'A velocity function is v(t) = 3t² − 12t + 9. Find the displacement for t ∈ [0, 4].',
            'options': ['12 m', '0 m', '−12 m', '24 m'],
            'correct': 1,
          },
          {
            'question': 'Find the average value of f(x) = sin(x) on [0, π].',
            'options': ['2/π', '1', 'π/2', '0'],
            'correct': 0,
          },
          {
            'question': 'A force on a spring is F(x) = 50x Newtons. Find work done compressing from 0 to 0.2 m.',
            'options': ['1 J', '2 J', '5 J', '10 J'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u7_1':
      return {
        'content': '''# Area Problems

## Area Between Two Curves

If f(x) ≥ g(x) on [a, b]:
A = ∫[a to b] [f(x) − g(x)] dx

## Finding Intersection Points

Before integrating, solve f(x) = g(x) to find the bounds.

## Economic Applications

Consumer surplus = Area between demand curve and market price line
Producer surplus = Area between market price line and supply curve''',
        'questions': [
          {
            'question': 'Find the area enclosed between f(x) = x² and g(x) = x + 2.',
            'options': ['9/2', '4', '5/2', '3'],
            'correct': 0,
          },
          {
            'question': 'Compute the area between y = sin(x) and y = cos(x) for x ∈ [0, π/4].',
            'options': ['√2 − 1', '1 − √2/2', '2 − √2', '(√2 − 1)/2'],
            'correct': 0,
          },
          {
            'question': 'Find the area between y = x² − 2x and y = −x² + 4.',
            'options': ['9', '18', '9/2', '27'],
            'correct': 0,
          },
          {
            'question': 'Find the area of the region bounded by y = ln(x), the x-axis, and x = e.',
            'options': ['e − 1', '1', '2', 'e'],
            'correct': 0,
          },
          {
            'question': 'Use integration to find the area of a circle of radius r.',
            'options': ['πr²', '2πr', 'πr', 'r²/π'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u7_2':
      return {
        'content': '''# Volume Problems

## Volume by Disk Method

Rotating y = f(x) around the x-axis from x = a to x = b:
V = π∫[a to b] [f(x)]² dx

## Volume by Shell Method

Rotating around the y-axis:
V = 2π∫[a to b] x·f(x) dx

## Solids with Known Cross-Sections

If the cross-section at position x has area A(x):
V = ∫[a to b] A(x) dx

## Volume of Cone

Height h, base radius r:
V = (1/3)πr²h''',
        'questions': [
          {
            'question': 'Find the volume of the solid formed by rotating y = √x around the x-axis from 0 to 4.',
            'options': ['4π', '8π', '16π', '2π'],
            'correct': 1,
          },
          {
            'question': 'Use the disk method to find volume of y = x² rotated around x-axis from 0 to 3.',
            'options': ['(243π)/5', '81π', '27π', '9π'],
            'correct': 0,
          },
          {
            'question': 'Use the shell method to find volume of y = x² rotated about y-axis from 0 to 2.',
            'options': ['8π', '16π', '4π', '32π'],
            'correct': 1,
          },
          {
            'question': 'Find the volume of the solid obtained by rotating y = 1/x from x = 1 to x = 3 about x-axis.',
            'options': ['π(2/3)', 'π(1/3)', 'π(1/2)', 'π(3/2)'],
            'correct': 0,
          },
          {
            'question': 'Find the volume of a cone with height 4 m and base radius 2 m.',
            'options': ['(16π)/3 m³', '8π m³', '4π m³', '2π m³'],
            'correct': 0,
          },
        ]
      };

    case 'mts102_u7_3':
      return {
        'content': '''# Real-World Applications

## Arc Length

The arc length of f(x) from x = a to x = b:
L = ∫[a to b] √(1 + [f′(x)]²) dx

## Surface Area

When rotating f(x) around the x-axis:
S = 2π∫[a to b] f(x)·√(1 + [f′(x)]²) dx

## Work and Energy

Work done by a variable force over distance:
W = ∫[a to b] F(x) dx

## Fluid Pressure on a Dam

Force on a vertical surface = ∫ pressure × area dh

## Profit and Revenue

If P′(t) = profit rate, total profit over [0, T]:
Total Profit = ∫[0 to T] P′(t) dt''',
        'questions': [
          {
            'question': 'Compute the arc length of f(x) = (2/3)x^(3/2) from x = 0 to x = 3.',
            'options': ['8', '9', '10', '11'],
            'correct': 0,
          },
          {
            'question': 'Find the area of a circle of radius r using integration (verify A = πr²).',
            'options': ['πr²', '2πr', 'πr', 'r²'],
            'correct': 0,
          },
          {
            'question': 'Rotate y = sin(x) for x ∈ [0, π] around x-axis and find the volume.',
            'options': ['π²/2', 'π²', 'π³/3', 'π/2'],
            'correct': 0,
          },
          {
            'question': 'Find work done stretching a spring from natural length by 0.5 m if k = 200 N/m.',
            'options': ['25 J', '50 J', '75 J', '100 J'],
            'correct': 0,
          },
          {
            'question': 'Profit rate is P′(t) = 100t − 2t² thousand naira/year. Total profit over 10 years:',
            'options': ['3333.33 thousand naira', '5000 thousand naira', '6666.67 thousand naira', '10000 thousand naira'],
            'correct': 0,
          },
        ]
      };

    default:
      return {
        'content': 'Lesson not found',
        'questions': []
      };
  }
}