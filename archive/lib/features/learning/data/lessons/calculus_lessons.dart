// lib/features/learning/data/lessons/calculus_lessons.dart

Map<String, dynamic> getCalculusLessonData(String lessonId) {
  switch (lessonId) {
    case 'dr_1':
      return {
        'content': '''# Finding Domain

Think of a function as a **vending machine**:
• **Domain**: The coins you're allowed to put in
• **Range**: The snacks you can actually get out

## Real-Life Analogy
A movie theater ticket machine accepts ages 0-120. That's the domain!

## The 3 Common Troublemakers

**Case A: Fractions (Denominator ≠ 0)**
You can never divide by zero.

Example: f(x) = 1/(x-2)
• Set denominator ≠ 0: x - 2 ≠ 0
• Domain: All real numbers except x = 2
• Write as: (-∞, 2) ∪ (2, ∞)

**Case B: Square Roots (No Negatives)**
Can't take √ of negative numbers.

Example: f(x) = √(x-5)
• Set inside ≥ 0: x - 5 ≥ 0
• Domain: x ≥ 5
• Write as: [5, ∞)

**Case C: Logarithms (Positive Only)**
Can only take log of numbers > 0.

Example: f(x) = ln(x)
• Set inside > 0: x > 0
• Domain: x > 0
• Write as: (0, ∞)

## Quick Tips
💡 No fraction/square root/log? Domain = All real numbers
💡 Always graph to visualize the domain''',
        'questions': [
          {
            'question': 'Find the domain of f(x) = 1/(x-2)',
            'options': ['All real numbers', 'x ≠ 2', 'x > 2', 'x < 2'],
            'correct': 1,
          },
          {
            'question': 'Find the domain of f(x) = √(x+5)',
            'options': ['x ≥ -5', 'x > -5', 'All real numbers', 'x ≤ -5'],
            'correct': 0,
          },
          {
            'question': 'What is the domain of f(x) = log(x-3)?',
            'options': ['x > 3', 'x ≥ 3', 'All real numbers', 'x < 3'],
            'correct': 0,
          },
          {
            'question': 'Find the domain of f(x) = 1/(x²-4)',
            'options': ['x ≠ 2, -2', 'All real numbers', 'x > 2', 'x < -2'],
            'correct': 0,
          },
          {
            'question': 'What is the domain of f(x) = 1/(x²+1)?',
            'options': ['All real numbers', 'x ≠ 1', 'x > 0', 'x < 0'],
            'correct': 0,
          },
        ]
      };

    case 'dr_2':
      return {
        'content': '''# Finding Range

## What is Range?
**Range** = All possible output values (y-values) a function can produce

Think: Domain is input, Range is output!

## Real-Life Analogy
A soda machine:
• Input (Domain): Which button you press (A1, A2, B3, etc.)
• Output (Range): The sodas available (Coke, Sprite, Orange)

## Finding Range: 3 Methods

**Method 1: Look at the Graph**
Range is how far the graph goes **up and down** (vertically).

**Method 2: Solve for x in terms of y**
Example: f(x) = x² + 2
• y = x² + 2
• x² = y - 2
• Since x² ≥ 0, then y - 2 ≥ 0
• Range: y ≥ 2 or [2, ∞)

**Method 3: Know the Patterns**
• Polynomial (no fraction): Range = All real numbers (usually)
• Fraction with constant top: y ≠ 0
• Square root: y ≥ 0 (outputs are positive)
• Exponential aˣ: y > 0 (always positive)
• Sine/Cosine: y ∈ [-1, 1]

## Examples
f(x) = x² → Range: [0, ∞) (parabola opens up)
f(x) = -x² → Range: (-∞, 0] (parabola opens down)
f(x) = sin(x) → Range: [-1, 1] (oscillates between)
f(x) = eˣ → Range: (0, ∞) (exponential curves up)''',
        'questions': [
          {
            'question': 'Find the range of f(x) = x² for x ∈ ℝ',
            'options': ['All real numbers', '[0, ∞)', '(-∞, 0]', '[1, ∞)'],
            'correct': 1,
          },
          {
            'question': 'What is the range of f(x) = 1/x?',
            'options': ['All real numbers except 0', 'All real numbers', '(0, ∞)', '[-1, 1]'],
            'correct': 0,
          },
          {
            'question': 'What is the range of f(x) = |x|?',
            'options': ['All real numbers', '[0, ∞)', '(-∞, 0]', '[-1, 1]'],
            'correct': 1,
          },
          {
            'question': 'Find the range of f(x) = 2^x',
            'options': ['All real numbers', '(0, ∞)', '[-2, 2]', '[1, ∞)'],
            'correct': 1,
          },
          {
            'question': 'Find the range of f(x) = -x²',
            'options': ['(-∞, 0]', '[0, ∞)', 'All real numbers', '[-1, 1]'],
            'correct': 0,
          },
        ]
      };

    case 'dr_3':
      return {
        'content': '''# Domain Restrictions

## What Are Restrictions?
Some functions can't accept ALL real numbers as input.

These are the **restricted domains** (where the function "breaks").

## The Big 3 Restrictions

**1️⃣ Denominator ≠ 0**
Division by zero = undefined

f(x) = 1/(x² - 4)
• Set x² - 4 = 0
• (x - 2)(x + 2) = 0
• x = 2 or x = -2
• Domain: All reals except 2 and -2
• Write: (-∞, -2) ∪ (-2, 2) ∪ (2, ∞)

**2️⃣ Square Root ≥ 0**
Can't take √ of negative

f(x) = √(x² - 9)
• Set x² - 9 ≥ 0
• (x - 3)(x + 3) ≥ 0
• Domain: (-∞, -3] ∪ [3, ∞)

**3️⃣ Logarithm > 0**
Can only log positive numbers

f(x) = ln(2x - 1)
• Set 2x - 1 > 0
• 2x > 1
• x > 1/2
• Domain: (1/2, ∞)

## Multi-Restriction Example
f(x) = √(x-1) / (x² - 4)

Restrictions:
• Square root: x - 1 ≥ 0 → x ≥ 1
• Denominator: x² - 4 ≠ 0 → x ≠ ±2

Combined Domain: [1, 2) ∪ (2, ∞)''',
        'questions': [
          {
            'question': 'Find the domain of f(x) = 1/(x²-4)',
            'options': ['x ≠ 2, -2', 'All real numbers', 'x > 2', 'x < -2'],
            'correct': 0,
          },
          {
            'question': 'What is the domain of f(x) = √(4-x²)',
            'options': ['[-2, 2]', '(-2, 2)', 'All real numbers', '[0, 4]'],
            'correct': 0,
          },
          {
            'question': 'Find the domain of f(x) = 1/√(x-1)',
            'options': ['x > 1', 'x ≥ 1', 'All real numbers', 'x < 1'],
            'correct': 0,
          },
          {
            'question': 'What is the domain of f(x) = ln(x²)?',
            'options': ['x ≠ 0', 'x > 0', 'All real numbers', 'x < 0'],
            'correct': 0,
          },
          {
            'question': 'What is the domain of f(x) = √(x²-9)?',
            'options': ['[-3, 3]', '(-3, 3)', '(-∞, -3] ∪ [3, ∞)', '(-∞, -3) ∪ (3, ∞)'],
            'correct': 2,
          },
        ]
      };

    case 'tf_1':
      return {
        'content': '''# Polynomial Functions

## What is a Polynomial?
A polynomial is a function made of terms with variables raised to whole number powers.

f(x) = aₙxⁿ + aₙ₋₁xⁿ⁻¹ + ... + a₁x + a₀

## Examples
- f(x) = 2x³ + 3x² - x + 5 (cubic)
- f(x) = x² - 4x + 3 (quadratic)
- f(x) = 2x + 1 (linear)

## Key Properties
- Domain: ALL real numbers ℝ
- Range: Depends on degree
- Continuous everywhere
- No breaks or jumps

## Degree Matters
- Degree 1: Linear (straight line)
- Degree 2: Quadratic (parabola)
- Degree 3: Cubic (S-shape)
- Degree 4+: Complex shapes''',
        'questions': [
          {
            'question': 'What is the domain of f(x) = x³ - 2x + 1?',
            'options': ['All real numbers', 'x > 0', 'x ≠ 0', '[0, ∞)'],
            'correct': 0,
          },
          {
            'question': 'Which is a polynomial?',
            'options': ['f(x) = 1/x', 'f(x) = √x', 'f(x) = 2x² + 3x - 1', 'f(x) = sin(x)'],
            'correct': 2,
          },
          {
            'question': 'What degree is f(x) = 5x⁴ - 3x² + 2?',
            'options': ['2', '3', '4', '5'],
            'correct': 2,
          },
          {
            'question': 'What is the range of f(x) = x²?',
            'options': ['All real numbers', '[0, ∞)', '(-∞, 0]', '[1, ∞)'],
            'correct': 1,
          },
          {
            'question': 'Are polynomials continuous?',
            'options': ['No', 'Yes, everywhere', 'Only at integers', 'Only for even degree'],
            'correct': 1,
          },
        ]
      };

    case 'tf_2':
      return {
        'content': '''# Exponential Functions

## What is Exponential?
f(x) = aˣ where a > 0, a ≠ 1

The variable is in the EXPONENT!

## Examples
- f(x) = 2ˣ (common exponential)
- f(x) = eˣ (natural exponential)
- f(x) = (1/2)ˣ (decay)

## Key Properties
- Domain: ALL real numbers ℝ
- Range: (0, ∞) - always positive!
- Passes through (0, 1)
- Horizontal asymptote at y = 0

## Growth vs Decay
- If a > 1: Exponential GROWTH (curves up)
- If 0 < a < 1: Exponential DECAY (curves down)

## Real-World Uses
- Population growth
- Radioactive decay
- Compound interest
- COVID-19 spread''',
        'questions': [
          {
            'question': 'What is the domain of f(x) = 3ˣ?',
            'options': ['All real numbers', '(0, ∞)', '[1, ∞)', 'x > 0'],
            'correct': 0,
          },
          {
            'question': 'What is the range of f(x) = 2ˣ?',
            'options': ['All real numbers', '(0, ∞)', '[0, ∞)', '(-∞, 1)'],
            'correct': 1,
          },
          {
            'question': 'What point does eˣ pass through?',
            'options': ['(0, 0)', '(0, 1)', '(1, e)', '(1, 0)'],
            'correct': 1,
          },
          {
            'question': 'Is f(x) = (1/3)ˣ growth or decay?',
            'options': ['Growth', 'Decay', 'Neither', 'Both'],
            'correct': 1,
          },
          {
            'question': 'What is the horizontal asymptote of 2ˣ?',
            'options': ['y = 1', 'y = 0', 'y = 2', 'No asymptote'],
            'correct': 1,
          },
        ]
      };

    case 'tf_3':
      return {
        'content': '''# Trigonometric Functions

## The Three Main Functions
- sin(x) - Sine
- cos(x) - Cosine
- tan(x) - Tangent

## Sine and Cosine
f(x) = sin(x) and f(x) = cos(x)

Domain: ALL real numbers ℝ
Range: [-1, 1]
Period: 2π

## Tangent
f(x) = tan(x)

Domain: ALL reals EXCEPT x = π/2 + nπ
Range: ALL real numbers ℝ
Period: π

## Key Values
- sin(0) = 0, cos(0) = 1
- sin(π/2) = 1, cos(π/2) = 0
- sin(π) = 0, cos(π) = -1

## Real-World Uses
- Sound waves
- Light waves
- Pendulum motion
- Circular motion''',
        'questions': [
          {
            'question': 'What is the domain of sin(x)?',
            'options': ['All real numbers', '[-1, 1]', '[0, 2π]', '(0, ∞)'],
            'correct': 0,
          },
          {
            'question': 'What is the range of cos(x)?',
            'options': ['All real numbers', '[-1, 1]', '[0, 1]', '(0, ∞)'],
            'correct': 1,
          },
          {
            'question': 'What is the period of sin(x)?',
            'options': ['π', '2π', 'π/2', '1'],
            'correct': 1,
          },
          {
            'question': 'Where is tan(x) undefined?',
            'options': ['Nowhere', 'x = π/2 + nπ', 'x = nπ', 'x = 0'],
            'correct': 1,
          },
          {
            'question': 'What is sin(π/2)?',
            'options': ['0', '1', '-1', 'undefined'],
            'correct': 1,
          },
        ]
      };

    case 'lim_1':
      return {
        'content': '''# Limit Concept

## What is a Limit?
A limit describes what value a function approaches as x gets close to some number.

lim (x→a) f(x) = L

"As x approaches a, f(x) approaches L"

## Visual Example
Think of walking toward a door:
- You get closer and closer
- But you don't necessarily reach it
- The limit is where you're heading

## Left vs Right Limits
- Left limit: x → a⁻ (from left)
- Right limit: x → a⁺ (from right)

For a limit to exist: left limit = right limit

## Important Cases
- f(a) might not exist
- But the limit might still exist!
- That's the power of limits

## Real-World
- Speed at an instant (calculus)
- Approaching a stopping point
- Asymptotic behavior''',
        'questions': [
          {
            'question': 'What does lim(x→2) f(x) = 5 mean?',
            'options': ['f(2) = 5', 'f(x) approaches 5 as x approaches 2', 'x = 5', 'The function is continuous'],
            'correct': 1,
          },
          {
            'question': 'Can a limit exist if f(a) is undefined?',
            'options': ['No', 'Yes', 'Only sometimes', 'Never'],
            'correct': 1,
          },
          {
            'question': 'For a limit to exist at a point, what must be true?',
            'options': ['f(a) must exist', 'Left limit = Right limit', 'f is continuous', 'f is differentiable'],
            'correct': 1,
          },
          {
            'question': 'What is lim(x→0) 1/x?',
            'options': ['0', '1', 'Does not exist', 'Infinity'],
            'correct': 2,
          },
          {
            'question': 'Can the limit value be different from f(a)?',
            'options': ['No', 'Yes', 'Only for continuous functions', 'Never'],
            'correct': 1,
          },
        ]
      };

    case 'lim_2':
      return {
        'content': '''# Evaluating Limits

## Method 1: Direct Substitution
Just plug in the value!

lim(x→2) (3x + 1) = 3(2) + 1 = 7

Works when there's no 0/0 problem.

## Method 2: Factoring
If you get 0/0, try factoring.

lim(x→2) (x² - 4)/(x - 2)
= lim(x→2) (x-2)(x+2)/(x-2)
= lim(x→2) (x + 2) = 4

## Method 3: Conjugate Multiply
For square roots:

lim(x→0) √(x+1) - 1 / x
Multiply by conjugate!

## Method 4: L'Hôpital's Rule
If 0/0 or ∞/∞:
lim f(x)/g(x) = lim f'(x)/g'(x)

## Common Mistakes
❌ Don't just assume 0/0 = undefined
❌ Always simplify first
❌ Check from both sides''',
        'questions': [
          {
            'question': 'Evaluate: lim(x→1) (2x + 3)',
            'options': ['2', '3', '5', 'undefined'],
            'correct': 2,
          },
          {
            'question': 'lim(x→3) (x² - 9)/(x - 3) = ?',
            'options': ['6', '0', 'undefined', '9'],
            'correct': 0,
          },
          {
            'question': 'What does 0/0 mean in limits?',
            'options': ['Limit doesn\'t exist', 'Indeterminate - need more work', 'Answer is 0', 'Answer is ∞'],
            'correct': 1,
          },
          {
            'question': 'Can you use direct substitution if you don\'t get 0/0?',
            'options': ['No', 'Yes', 'Only sometimes', 'Never'],
            'correct': 1,
          },
          {
            'question': 'When should you factor?',
            'options': ['Always', 'When you get 0/0', 'Never', 'Only for polynomials'],
            'correct': 1,
          },
        ]
      };

    case 'lim_3':
      return {
        'content': '''# Limits at Infinity

## What Does ∞ Mean?
Not a number! It means "unbounded growth"

lim(x→∞) f(x) = L means f(x) approaches L as x gets HUGE

## Horizontal Asymptotes
If lim(x→∞) f(x) = L, then y = L is a horizontal asymptote.

## Rational Functions
For f(x) = (aₙxⁿ + ...) / (bₘxᵐ + ...)

Compare degrees:
- n < m: limit = 0
- n = m: limit = aₙ/bₘ
- n > m: limit = ±∞

## Examples
- lim(x→∞) 1/x = 0 (denominator wins)
- lim(x→∞) (3x² + 1)/(2x² - 1) = 3/2 (same degree)
- lim(x→∞) x³/x² = ∞ (numerator wins)

## Exponentials
- lim(x→∞) eˣ = ∞
- lim(x→∞) e⁻ˣ = 0''',
        'questions': [
          {
            'question': 'lim(x→∞) 1/x = ?',
            'options': ['1', '0', '∞', 'undefined'],
            'correct': 1,
          },
          {
            'question': 'What is lim(x→∞) (2x + 1)/(3x - 2)?',
            'options': ['0', '2/3', '1', 'undefined'],
            'correct': 1,
          },
          {
            'question': 'When does lim(x→∞) polynomial = ∞?',
            'options': ['Always', 'Never', 'Only if degree ≥ 1 and leading coefficient > 0', 'Only for cubic'],
            'correct': 2,
          },
          {
            'question': 'What is the horizontal asymptote of y = (x² + 1)/(x² - 1)?',
            'options': ['y = 0', 'y = 1', 'y = -1', 'No asymptote'],
            'correct': 1,
          },
          {
            'question': 'lim(x→∞) (1 + 1/x)ˣ = ?',
            'options': ['1', 'e', '∞', '0'],
            'correct': 1,
          },
        ]
      };

    case 'cont_1':
      return {
        'content': '''# Continuity Definition

## What is Continuous?
A function is continuous at a point if:

1. f(a) exists
2. lim(x→a) f(x) exists
3. lim(x→a) f(x) = f(a)

All three must be TRUE!

## Intuitively
You can draw the graph without lifting your pencil at that point.

## Continuous Everywhere
- All polynomials
- eˣ, sin(x), cos(x)
- √x (on its domain)
- 1/x (except at x = 0)

## NOT Continuous
- 1/x at x = 0 (undefined)
- Jump functions (step functions)
- Functions with holes

## Visual Test
- No holes ✓
- No jumps ✓
- No vertical asymptotes ✓

## Why It Matters
Continuous functions are "nice" to work with in calculus.''',
        'questions': [
          {
            'question': 'For f to be continuous at x = a, what must equal f(a)?',
            'options': ['Nothing', 'lim(x→a) f(x)', 'f(a-1)', 'The derivative'],
            'correct': 1,
          },
          {
            'question': 'Is f(x) = 1/x continuous everywhere?',
            'options': ['Yes', 'No', 'Only on positive numbers', 'Only at integers'],
            'correct': 1,
          },
          {
            'question': 'Which is continuous everywhere on its domain?',
            'options': ['1/x', '√x', 'x³ - 2x + 1', 'tan(x)'],
            'correct': 2,
          },
          {
            'question': 'Can a function be continuous but not differentiable?',
            'options': ['No', 'Yes', 'Only at corners', 'Only for odd functions'],
            'correct': 1,
          },
          {
            'question': 'What is NOT needed for continuity?',
            'options': ['f(a) exists', 'The limit exists', 'Limit = f(a)', 'The derivative exists'],
            'correct': 3,
          },
        ]
      };

    case 'cont_2':
      return {
        'content': '''# Discontinuity Types

## Removable Discontinuity
A HOLE in the graph.

lim(x→a) f(x) exists BUT ≠ f(a)

Example: f(x) = (x² - 4)/(x - 2) at x = 2
Limit exists but f(2) is undefined.

Can be "fixed" by redefining f(a).

## Jump Discontinuity
Left limit ≠ Right limit

Example: f(x) = {1 if x < 0; 2 if x ≥ 0}
The function JUMPS at x = 0.

Cannot be removed!

## Infinite Discontinuity
Function goes to ±∞ (vertical asymptote)

Example: f(x) = 1/x at x = 0
Limit = ∞, not a number.

## Summary
- Removable: Can "fix" it
- Jump: Forever broken
- Infinite: Goes to ∞

## Visual Test
- Hole = Removable
- Jump = Not removable
- Vertical line = Infinite''',
        'questions': [
          {
            'question': 'What type is a HOLE in the graph?',
            'options': ['Jump', 'Removable', 'Infinite', 'Continuous'],
            'correct': 1,
          },
          {
            'question': 'Can a removable discontinuity be fixed?',
            'options': ['No', 'Yes, by redefining the function', 'Only sometimes', 'Never'],
            'correct': 1,
          },
          {
            'question': 'What causes a jump discontinuity?',
            'options': ['Left limit ≠ Right limit', 'Function goes to ∞', 'f(a) undefined', 'Vertical asymptote'],
            'correct': 0,
          },
          {
            'question': 'Which discontinuity involves a vertical asymptote?',
            'options': ['Removable', 'Jump', 'Infinite', 'All of them'],
            'correct': 2,
          },
          {
            'question': 'Is a jump discontinuity removable?',
            'options': ['Yes', 'No', 'Only for linear functions', 'Always'],
            'correct': 1,
          },
        ]
      };

    case 'der_1':
      return {
        'content': '''# Rate of Change Concepts

## What is Rate of Change?
How fast something changes over time or space.

**Average Rate of Change**: Change over an interval
**Instantaneous Rate of Change**: Change at one exact moment

## Average Rate of Change

From x = a to x = b:

Average Rate = [f(b) - f(a)] / (b - a)

This is the slope of the SECANT line connecting two points.

## Instantaneous Rate of Change

At one moment x = c:

Instantaneous Rate = f'(c) = the derivative

This is the slope of the TANGENT line at that point.

## Real-World Examples
• **Distance → Velocity**: How fast are you going RIGHT NOW?
• **Position → Speed**: Speedometer shows instantaneous rate
• **Temperature → Rate of cooling**: How fast does soup cool?
• **Population → Growth rate**: How fast population grows

## Key Difference
• Average: Over an interval (whole trip)
• Instantaneous: At a moment (one second)''',
        'questions': [
          {
            'question': 'The average rate of change from x=a to x=b is:',
            'options': ['f(b)-f(a)', '[f(b)-f(a)]/(b-a)', '[f(a)-f(b)]/(a-b)', 'f(b)/f(a)'],
            'correct': 1,
          },
          {
            'question': 'The instantaneous rate of change at x=c is found by:',
            'options': ['Average rate at c', 'The derivative f\'(c)', 'The tangent line slope at c', 'Both b and c'],
            'correct': 3,
          },
          {
            'question': 'Graphically, average rate of change is the slope of:',
            'options': ['Tangent line', 'Secant line', 'Vertical line', 'Horizontal line'],
            'correct': 1,
          },
          {
            'question': 'Instantaneous rate of change measures:',
            'options': ['How fast position changes at one moment', 'Velocity in physics', 'The derivative value', 'All of the above'],
            'correct': 3,
          },
          {
            'question': 'For distance s(t)=t², the instantaneous rate of change at t=3 is:',
            'options': ['6', '9', '3', '2'],
            'correct': 0,
          },
        ]
      };

    case 'der_2':
      return {
        'content': '''# Limit Definition & Derivative

## The Limit Definition of Derivative

f'(x) = lim(h→0) [f(x+h) - f(x)] / h

This is THE most important formula in calculus!

## Step by Step
1. Plug in (x+h): f(x+h)
2. Subtract original: f(x+h) - f(x)
3. Divide by h: [f(x+h) - f(x)] / h
4. Take limit as h→0

## Example: f(x) = x²
• f(x+h) = (x+h)² = x² + 2xh + h²
• f(x+h) - f(x) = 2xh + h²
• [2xh + h²] / h = 2x + h
• lim(h→0) (2x + h) = 2x
• So f'(x) = 2x ✓

## Geometric Meaning

f'(c) = slope of tangent line at (c, f(c))

The tangent line "just touches" the curve at one point.

## Differentiability Requirements

For f to be differentiable at c:
✓ f must be continuous at c
✓ f'(c) exists and is finite
✓ No corners or cusps at c

## Key Insight

A function can be CONTINUOUS but NOT DIFFERENTIABLE (at corners).''',
        'questions': [
          {
            'question': 'The limit definition of derivative is:',
            'options': ['f\'(x) = [f(x+h)-f(x)]/h', 'f\'(x) = lim(h→0) [f(x+h)-f(x)]/h', 'f\'(x) = [f(x)-f(0)]/x', 'f\'(x) = f(x+1)-f(x)'],
            'correct': 1,
          },
          {
            'question': 'Using f(x)=x², find f\'(2) using the limit definition:',
            'options': ['4', '2', '8', 'Cannot determine'],
            'correct': 0,
          },
          {
            'question': 'The derivative f\'(c) geometrically represents:',
            'options': ['Slope of tangent line at (c,f(c))', 'Slope of secant line', 'The value f(c)', 'The point (c,f(c))'],
            'correct': 0,
          },
          {
            'question': 'For f(x)=3x+2, the derivative is:',
            'options': ['0', '3', '2', '3x'],
            'correct': 1,
          },
          {
            'question': 'A function can be continuous but not differentiable at:',
            'options': ['Corner points', 'Cusps', 'Vertical tangent points', 'All of the above'],
            'correct': 3,
          },
        ]
      };

    case 'der_3':
      return {
        'content': '''# Differentiation Rules

## Power Rule
d/dx[x^n] = n·x^(n-1)

Example: d/dx[x³] = 3x²

## Product Rule
d/dx[f·g] = f'·g + f·g'

"First times derivative of second + second times derivative of first"

Example: d/dx[x²·sin(x)] = 2x·sin(x) + x²·cos(x)

## Quotient Rule
d/dx[f/g] = (f'·g - f·g') / g²

"Low d-high minus high d-low, square the bottom"

Example: d/dx[x/sin(x)]

## Chain Rule (MOST IMPORTANT!)
d/dx[f(g(x))] = f'(g(x))·g'(x)

"Derivative of outside times derivative of inside"

Example: d/dx[sin(x²)] = cos(x²)·2x

## Trig Derivatives
• d/dx[sin(x)] = cos(x)
• d/dx[cos(x)] = -sin(x)
• d/dx[tan(x)] = sec²(x)

## Exponential & Logarithm
• d/dx[e^x] = e^x
• d/dx[ln(x)] = 1/x
• d/dx[a^x] = a^x·ln(a)

## Key Strategy
Identify the rule type FIRST, then apply!''',
        'questions': [
          {
            'question': 'Power Rule: d/dx[x^n] =',
            'options': ['x^(n-1)', 'nx^(n-1)', 'n·x^n', '(n-1)x'],
            'correct': 1,
          },
          {
            'question': 'Product Rule: d/dx[f·g] =',
            'options': ['f\'·g\'', 'f\'·g + f·g\'', 'f·g\'', '(f·g)\''],
            'correct': 1,
          },
          {
            'question': 'Quotient Rule: d/dx[f/g] =',
            'options': ['(f\'·g - f·g\')/g²', '(f·g\' - f\'·g)/g²', '(f\'-g\')/g', '(f/g)\''],
            'correct': 0,
          },
          {
            'question': 'Chain Rule: d/dx[f(g(x))] =',
            'options': ['f\'(x)·g\'(x)', 'f\'(g(x))·g\'(x)', 'f(g\'(x))', 'f\'(g)'],
            'correct': 1,
          },
          {
            'question': 'd/dx[sin(x)] =',
            'options': ['cos(x)', '-cos(x)', 'sin(x)', 'tan(x)'],
            'correct': 0,
          },
        ]
      };

    case 'der_4':
      return {
        'content': '''# Applications of Derivatives

## Critical Points

Where f'(x) = 0 or f'(x) is undefined

At critical points, the function might have:
• Local maximum
• Local minimum
• Inflection point

## Second Derivative Test

f''(x) tells us about concavity:
• f''(x) > 0: Concave UP ∪
• f''(x) < 0: Concave DOWN ∩

If f'(c) = 0:
• f''(c) < 0 → Local MAXIMUM
• f''(c) > 0 → Local MINIMUM
• f''(c) = 0 → Test fails, investigate further

## Optimization Problems

Finding MAXIMUM or MINIMUM values:

1. Find critical points: f'(x) = 0
2. Evaluate f at critical points and endpoints
3. Compare values to find max/min

Real-world: Maximize profit, minimize cost, etc.

## Related Rates Problems

When multiple variables change together, differentiate with respect to TIME:

Example: Ladder sliding down wall
• dx/dt = rate wall moves
• dy/dt = rate top slides
• Both related by Pythagorean theorem

Differentiate: 2x(dx/dt) + 2y(dy/dt) = 0

## Curve Analysis

Use derivatives to:
✓ Find increasing/decreasing intervals
✓ Locate extrema
✓ Identify concavity
✓ Sketch accurate graphs''',
        'questions': [
          {
            'question': 'Critical points occur where:',
            'options': ['f\'(x) = 0', 'f\'(x) is undefined', 'f might have extrema', 'All of the above'],
            'correct': 3,
          },
          {
            'question': 'The Second Derivative Test uses f\'\'(x) to determine:',
            'options': ['Concavity (up/down)', 'Local extrema (max/min)', 'Points of inflection', 'All of the above'],
            'correct': 3,
          },
          {
            'question': 'If f\'(c)=0 and f\'\'(c)<0, then x=c is a:',
            'options': ['Local maximum', 'Local minimum', 'Inflection point', 'Critical point (indeterminate)'],
            'correct': 0,
          },
          {
            'question': 'Optimization problems use derivatives to find:',
            'options': ['Maximum and minimum values', 'Critical points', 'Global extrema', 'All of the above'],
            'correct': 3,
          },
          {
            'question': 'In related rates problems, we differentiate with respect to:',
            'options': ['x', 'y', 'time t', 'The constant'],
            'correct': 2,
          },
        ]
      };

    case 'int_1':
      return {
        'content': '''# Area Under Curve & Riemann Sums

## Riemann Sums: Approximating Area

Idea: Use rectangles to estimate area under a curve

Area ≈ (width of each rectangle) × (height of each rectangle)

Sum all rectangles for total approximation.

## Left Riemann Sum

Use LEFT endpoint of each subinterval for height

Generally UNDERESTIMATES area (for increasing functions)

## Right Riemann Sum

Use RIGHT endpoint of each subinterval for height

Generally OVERESTIMATES area (for increasing functions)

## Midpoint Rule

Use MIDPOINT of each subinterval

More accurate than Left or Right!

## The Limit Process

As width of rectangles → 0:
• Number of rectangles → ∞
• Approximation → EXACT area
• This is the DEFINITE INTEGRAL!

lim(n→∞) Riemann Sum = ∫[a to b] f(x)dx

## Visual Picture

Think of rectangles getting thinner and thinner until they perfectly match the curve.

## Key Insight

Integration is really about finding area by infinite summation!''',
        'questions': [
          {
            'question': 'Riemann Sums approximate area by using:',
            'options': ['Rectangles', 'Trapezoids', 'Parabolas', 'Only a'],
            'correct': 3,
          },
          {
            'question': 'As the width of rectangles in a Riemann Sum approaches zero:',
            'options': ['Approximation becomes worse', 'Approximation becomes exact (integral)', 'The limit equals the integral', 'Both b and c'],
            'correct': 3,
          },
          {
            'question': 'A Left Riemann Sum uses:',
            'options': ['Left endpoint of each subinterval', 'Right endpoint', 'Midpoint', 'Average of endpoints'],
            'correct': 0,
          },
          {
            'question': 'A Right Riemann Sum uses:',
            'options': ['Left endpoint', 'Right endpoint of each subinterval', 'Midpoint', 'Both endpoints'],
            'correct': 1,
          },
          {
            'question': 'For continuous functions, Riemann Sums converge to:',
            'options': ['The antiderivative', 'The definite integral', 'The derivative', 'Infinity'],
            'correct': 1,
          },
        ]
      };

    case 'int_2':
      return {
        'content': '''# Fundamental Theorem of Calculus (FTC)

## The BIG IDEA

Differentiation and Integration are INVERSE operations!

## FTC Part 1

If F(x) is an antiderivative of f(x), then:

d/dx[∫ f(t)dt] = f(x)

"Derivative of integral = original function"

## FTC Part 2 (Main Part)

To compute a definite integral:

∫[a to b] f(x)dx = F(b) - F(a)

Where F is any antiderivative of f.

## Why This Matters

Before FTC: Use Riemann Sums (tedious!)
After FTC: Just find antiderivative and plug in endpoints!

## Example: ∫[0 to 2] 3x² dx

Step 1: Find antiderivative F(x) = x³
Step 2: Evaluate at endpoints: F(2) - F(0) = 8 - 0 = 8
Answer: 8 ✓

## Step-by-Step Process

1. Find antiderivative F(x)
2. Evaluate F at upper limit: F(b)
3. Evaluate F at lower limit: F(a)
4. Subtract: F(b) - F(a)

## Notation

∫[a to b] f(x)dx = F(x)|[a to b] = F(b) - F(a)

The vertical bar means "evaluate at the endpoints"''',
        'questions': [
          {
            'question': 'The Fundamental Theorem of Calculus (FTC) Part 1 states:',
            'options': ['d/dx[∫f(t)dt] = f(x)', 'Differentiation and integration are inverse operations', 'Both a and b', 'The integral equals the sum'],
            'correct': 2,
          },
          {
            'question': 'FTC Part 2 states: ∫[a to b] f(x)dx =',
            'options': ['f(b) - f(a)', 'F(b) - F(a) where F\'=f', '[f(b) + f(a)]/2', 'f(x)|[a to b]'],
            'correct': 1,
          },
          {
            'question': 'The FTC connects:',
            'options': ['Derivatives and integrals', 'Local and global properties', 'Rates and accumulation', 'All of the above'],
            'correct': 3,
          },
          {
            'question': 'To use FTC Part 2, we need:',
            'options': ['An antiderivative F', 'To evaluate F at endpoints', 'Both a and b', 'The derivative f'],
            'correct': 2,
          },
          {
            'question': '∫[0 to 2] 3x² dx using FTC equals:',
            'options': ['8', '6', '12', '4'],
            'correct': 0,
          },
        ]
      };

    case 'int_3':
      return {
        'content': '''# Indefinite vs Definite Integrals

## Indefinite Integral: ∫f(x)dx

Represents: FAMILY of antiderivatives

Result: A FUNCTION (plus constant +C)

Example: ∫ 2x dx = x² + C

Why +C? Because d/dx[x² + 5] = 2x too!
Any constant disappears when differentiating.

## Constant of Integration +C

Represents all possible antiderivatives

Each curve is same shape, just shifted vertically

## Definite Integral: ∫[a to b] f(x)dx

Represents: Net signed AREA under curve

Result: A NUMBER (not a function!)

Example: ∫[0 to 3] 2x dx = [x²]|[0 to 3] = 9 - 0 = 9

NO +C because we're evaluating specific points!

## Key Differences

| Aspect | Indefinite | Definite |
|--------|-----------|----------|
| Notation | ∫f(x)dx | ∫[a to b] f(x)dx |
| Result | Function family | Single number |
| +C ? | YES | NO |
| Meaning | Antiderivative | Area |

## Process Comparison

**Indefinite:**
∫ 5x⁴ dx = x⁵ + C

**Definite:**
∫[1 to 2] 5x⁴ dx = [x⁵]|[1 to 2] = 32 - 1 = 31

## Area Interpretation

Definite integral = signed area (above axis positive, below axis negative)''',
        'questions': [
          {
            'question': 'An indefinite integral ∫f(x)dx represents:',
            'options': ['Area under curve', 'Family of antiderivatives', 'Always includes +C', 'Both b and c'],
            'correct': 3,
          },
          {
            'question': 'The constant of integration +C in ∫f(x)dx represents:',
            'options': ['The left endpoint', 'Arbitrary constant from antiderivative', 'Always equals zero', 'The right endpoint'],
            'correct': 1,
          },
          {
            'question': 'A definite integral ∫[a to b] f(x)dx represents:',
            'options': ['Net signed area between curve and x-axis', 'A number (not a function)', 'F(b) - F(a)', 'All of the above'],
            'correct': 3,
          },
          {
            'question': '∫ 5 dx =',
            'options': ['5x', '5x + C', '5', '0'],
            'correct': 1,
          },
          {
            'question': '∫[1 to 3] 2x dx =',
            'options': ['2x²|[1 to 3]', '9 - 1 = 8', '[x²]|[1 to 3]', '8'],
            'correct': 3,
          },
        ]
      };

    case 'int_4':
      return {
        'content': '''# Integration Techniques

## U-Substitution (Reverse Chain Rule)

For ∫ f(g(x))·g'(x) dx:

Step 1: Let u = g(x)
Step 2: Then du = g'(x)dx
Step 3: Rewrite integral in terms of u
Step 4: Integrate ∫ f(u) du
Step 5: Substitute back x

Example: ∫ 2x·sin(x²) dx
• u = x², du = 2x dx
• ∫ sin(u) du = -cos(u) + C
• = -cos(x²) + C ✓

## Integration by Parts

For products: ∫ u dv = uv - ∫ v du

Choose u and dv strategically (LIATE rule)

Example: ∫ x·e^x dx
• u = x, dv = e^x dx
• du = dx, v = e^x
• = xe^x - ∫ e^x dx = xe^x - e^x + C ✓

## Trigonometric Integrals

Use identities:
• sin²(x) + cos²(x) = 1
• sin(2x) = 2sin(x)cos(x)
• Power reduction: sin²(x) = (1-cos(2x))/2

## Partial Fractions

For rational functions P(x)/Q(x):

1. Factor denominator
2. Break into simpler fractions
3. Integrate each piece

Example: 1/(x²-1) = 1/(x-1)(x+1)

## Choosing the Right Technique

• Product inside? Try Integration by Parts
• Composition? Try U-Substitution
• Fraction of polynomials? Try Partial Fractions
• Trig functions? Use identities or substitution''',
        'questions': [
          {
            'question': 'U-Substitution is the reverse of:',
            'options': ['Power Rule', 'Chain Rule', 'Product Rule', 'Quotient Rule'],
            'correct': 1,
          },
          {
            'question': 'For ∫ 2x·sin(x²) dx, we use:',
            'options': ['u = x²', 'u = sin(x²)', 'Direct integration', 'du = 2x dx'],
            'correct': 0,
          },
          {
            'question': 'Integration by Parts uses:',
            'options': ['∫u dv = uv - ∫v du', 'Reverse of Product Rule', 'Choose u and dv strategically', 'All of the above'],
            'correct': 3,
          },
          {
            'question': 'For ∫ x·e^x dx, we use:',
            'options': ['U-substitution', 'Integration by Parts', 'Direct integration', 'Factoring'],
            'correct': 1,
          },
          {
            'question': 'Partial Fractions decomposition is used for:',
            'options': ['Rational functions (P/Q)', 'Integrating quotient of polynomials', 'Breaking into simpler fractions', 'All of the above'],
            'correct': 3,
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