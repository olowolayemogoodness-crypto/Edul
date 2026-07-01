import '../../../../quiz/domain/models/quiz_question.dart';

class DifferentialCalculusQuestions {
  static const String subjectName = 'Differential Calculus';
  
  static final List<QuizQuestion> allQuestions = [
    // Domain and Range (Q1-Q25)
    QuizQuestion(question: 'Find the domain of f(x) = 1/(x-2)', options: ['All real numbers', 'x ≠ 2', 'x > 2', 'x < 2'], correctIndex: 1, explanation: 'The function is undefined when the denominator equals zero. So x ≠ 2.'),
    QuizQuestion(question: 'Find the domain of f(x) = √(x+5)', options: ['x ≥ -5', 'x > -5', 'All real numbers', 'x ≤ -5'], correctIndex: 0, explanation: 'Square root requires non-negative argument. So x + 5 ≥ 0, which means x ≥ -5.'),
    QuizQuestion(question: 'Find the range of f(x) = x² for x ∈ ℝ', options: ['All real numbers', '[0, ∞)', '(-∞, 0]', '[1, ∞)'], correctIndex: 1, explanation: 'Squares of all real numbers are non-negative, and all non-negative values are achievable.'),
    QuizQuestion(question: 'What is the domain of f(x) = log(x-3)?', options: ['x > 3', 'x ≥ 3', 'All real numbers', 'x < 3'], correctIndex: 0, explanation: 'Logarithm requires positive argument. So x - 3 > 0, which means x > 3.'),
    QuizQuestion(question: 'Find the domain of f(x) = 1/(x²-4)', options: ['x ≠ 2, -2', 'All real numbers', 'x > 2', 'x < -2'], correctIndex: 0, explanation: 'x² - 4 = 0 when x = ±2. So the domain is all reals except x ≠ 2, -2.'),
    QuizQuestion(question: 'What is the range of f(x) = 1/x?', options: ['All real numbers except 0', 'All real numbers', '(0, ∞)', '[-1, 1]'], correctIndex: 0, explanation: '1/x can take any real value except 0, since 1/x = 0 has no solution.'),
    QuizQuestion(question: 'Find the domain of f(x) = √(4-x²)', options: ['[-2, 2]', '(-2, 2)', 'All real numbers', '[0, 4]'], correctIndex: 0, explanation: '4 - x² ≥ 0 means x² ≤ 4, so -2 ≤ x ≤ 2, which is [-2, 2].'),
    QuizQuestion(question: 'What is the range of f(x) = |x|?', options: ['All real numbers', '[0, ∞)', '(-∞, 0]', '[-1, 1]'], correctIndex: 1, explanation: 'Absolute values are always non-negative, and all non-negative values are achievable.'),
    QuizQuestion(question: 'Find the domain of f(x) = 1/√(x-1)', options: ['x > 1', 'x ≥ 1', 'All real numbers', 'x < 1'], correctIndex: 0, explanation: 'We need x - 1 > 0 (strictly greater because it\'s in denominator), so x > 1.'),
    QuizQuestion(question: 'What is the domain of f(x) = ln(x²)?', options: ['x ≠ 0', 'x > 0', 'All real numbers', 'x < 0'], correctIndex: 0, explanation: 'x² > 0 for all x ≠ 0, so the domain is all real numbers except 0.'),
    QuizQuestion(question: 'Find the range of f(x) = 2^x', options: ['All real numbers', '(0, ∞)', '[-2, 2]', '[1, ∞)'], correctIndex: 1, explanation: '2^x is always positive and can approach 0 but never equals 0, and grows without bound.'),
    QuizQuestion(question: 'What is the domain of f(x) = 1/(x²+1)?', options: ['All real numbers', 'x ≠ 1', 'x > 0', 'x < 0'], correctIndex: 0, explanation: 'x² + 1 is always at least 1, never zero. So the domain is all real numbers.'),
    QuizQuestion(question: 'Find the range of f(x) = -x²', options: ['(-∞, 0]', '[0, ∞)', 'All real numbers', '[-1, 1]'], correctIndex: 0, explanation: '-x² is always non-positive. Maximum is 0 (when x=0), minimum approaches -∞.'),
    QuizQuestion(question: 'What is the domain of f(x) = √(x²-9)?', options: ['[-3, 3]', '(-3, 3)', '(-∞, -3] ∪ [3, ∞)', '(-∞, -3) ∪ (3, ∞)'], correctIndex: 2, explanation: 'x² - 9 ≥ 0 means x² ≥ 9, so x ≤ -3 or x ≥ 3.'),
    QuizQuestion(question: 'Find the range of f(x) = sin(x)', options: ['[-1, 1]', 'All real numbers', '(0, 1)', '(-1, 0)'], correctIndex: 0, explanation: 'Sine oscillates between -1 and 1 for all real x.'),
    QuizQuestion(question: 'What is the domain of f(x) = arcsin(x)?', options: ['[-1, 1]', 'All real numbers', '[0, 1]', '(0, 1)'], correctIndex: 0, explanation: 'arcsin is defined only for x in [-1, 1].'),
    QuizQuestion(question: 'Find the range of f(x) = cos(x) + 3', options: ['[-1, 1]', '[2, 4]', '[3, 4]', '[0, 3]'], correctIndex: 1, explanation: 'cos(x) ranges in [-1, 1], so cos(x) + 3 ranges in [2, 4].'),
    QuizQuestion(question: 'What is the domain of f(x) = √(2x-1)?', options: ['x ≥ 1/2', 'x > 1/2', 'All real numbers', 'x ≤ 1/2'], correctIndex: 0, explanation: '2x - 1 ≥ 0 means 2x ≥ 1, so x ≥ 1/2.'),
    QuizQuestion(question: 'Find the range of f(x) = e^x', options: ['(0, ∞)', 'All real numbers', '[-∞, ∞]', '[0, 1]'], correctIndex: 0, explanation: 'e^x is always positive, approaches 0 as x→-∞, and grows without bound as x→∞.'),
    QuizQuestion(question: 'What is the domain of f(x) = tan(x)?', options: ['All real numbers', 'x ≠ nπ/2 (n odd)', 'x ≠ nπ', 'x > 0'], correctIndex: 1, explanation: 'tan(x) = sin(x)/cos(x) is undefined when cos(x) = 0, which occurs at x = nπ/2 for odd n.'),
    QuizQuestion(question: 'Find the range of f(x) = log(x)', options: ['(0, ∞)', 'All real numbers', '[0, ∞)', '[-1, 1]'], correctIndex: 1, explanation: 'log(x) can take any real value as x ranges over (0, ∞).'),
    QuizQuestion(question: 'What is the domain of f(x) = 1/(ln x)?', options: ['x > 0, x ≠ 1', 'x > 0', 'x ≠ 0', 'All real numbers'], correctIndex: 0, explanation: 'ln(x) requires x > 0, and we need ln(x) ≠ 0, which means x ≠ 1.'),
    QuizQuestion(question: 'Find the range of f(x) = 1/(1+x²)', options: ['(0, 1]', '(0, ∞)', '[0, 1]', 'All real numbers'], correctIndex: 0, explanation: '1 + x² ≥ 1, so 1/(1+x²) ≤ 1. As x→±∞, it approaches 0 but never reaches it.'),
    QuizQuestion(question: 'What is the domain of f(x) = √(ln x)?', options: ['x ≥ 1', 'x > 1', 'x > 0', 'All real numbers'], correctIndex: 0, explanation: 'We need ln(x) ≥ 0, which means x ≥ 1.'),
    QuizQuestion(question: 'Find the range of f(x) = 3sin(x) - 2', options: ['[-5, 1]', '[-1, 1]', '[0, 3]', 'All real numbers'], correctIndex: 0, explanation: 'sin(x) ranges in [-1, 1], so 3sin(x) ranges in [-3, 3], thus 3sin(x) - 2 ranges in [-5, 1].'),

    // Types of Functions (Q26-Q50)
    QuizQuestion(question: 'Which is a polynomial function?', options: ['f(x) = sin(x)', 'f(x) = 3x³ - 2x² + 5', 'f(x) = e^x', 'f(x) = log(x)'], correctIndex: 1, explanation: 'Polynomial functions are sums of powers of x with constant coefficients.'),
    QuizQuestion(question: 'What is the degree of the polynomial f(x) = 4x⁵ - 3x² + 2?', options: ['5', '2', '3', '4'], correctIndex: 0, explanation: 'The degree is the highest power of x, which is 5.'),
    QuizQuestion(question: 'Which function is exponential?', options: ['f(x) = x²', 'f(x) = 2^x', 'f(x) = log(x)', 'f(x) = x^2'], correctIndex: 1, explanation: 'Exponential functions have the form f(x) = a^x where a > 0.'),
    QuizQuestion(question: 'For f(x) = a^x where a > 1, the function is:', options: ['Decreasing', 'Increasing', 'Constant', 'Periodic'], correctIndex: 1, explanation: 'Exponential functions with base > 1 are strictly increasing.'),
    QuizQuestion(question: 'Which is a trigonometric function?', options: ['f(x) = e^x', 'f(x) = ln(x)', 'f(x) = sin(x)', 'f(x) = 2^x'], correctIndex: 2, explanation: 'sin, cos, tan, and related functions are trigonometric.'),
    QuizQuestion(question: 'The period of sin(x) is:', options: ['π', '2π', 'π/2', '1'], correctIndex: 1, explanation: 'sin(x + 2π) = sin(x) for all x.'),
    QuizQuestion(question: 'Which function is logarithmic?', options: ['f(x) = 10^x', 'f(x) = log₂(x)', 'f(x) = cos(x)', 'f(x) = x³'], correctIndex: 1, explanation: 'Logarithmic functions have the form f(x) = logₐ(x).'),
    QuizQuestion(question: 'The derivative of sin(x) is:', options: ['cos(x)', '-sin(x)', '-cos(x)', 'tan(x)'], correctIndex: 0, explanation: 'd/dx[sin(x)] = cos(x).'),
    QuizQuestion(question: 'For exponential f(x) = a^x, if 0 < a < 1, the function is:', options: ['Increasing', 'Decreasing', 'Constant', 'Periodic'], correctIndex: 1, explanation: 'Exponential functions with 0 < base < 1 are strictly decreasing.'),
    QuizQuestion(question: 'The derivative of cos(x) is:', options: ['sin(x)', '-sin(x)', 'cos(x)', 'sec(x)'], correctIndex: 1, explanation: 'd/dx[cos(x)] = -sin(x).'),
    QuizQuestion(question: 'Which is an even function?', options: ['f(x) = x³', 'f(x) = x²', 'f(x) = sin(x)', 'f(x) = tan(x)'], correctIndex: 1, explanation: 'Even functions satisfy f(-x) = f(x). x² is even: (-x)² = x².'),
    QuizQuestion(question: 'Which is an odd function?', options: ['f(x) = x²', 'f(x) = cos(x)', 'f(x) = x³', 'f(x) = 1'], correctIndex: 2, explanation: 'Odd functions satisfy f(-x) = -f(x). x³ is odd: (-x)³ = -x³.'),
    QuizQuestion(question: 'The period of cos(x) is:', options: ['π', '2π', 'π/2', '∞'], correctIndex: 1, explanation: 'cos(x + 2π) = cos(x) for all x.'),
    QuizQuestion(question: 'For f(x) = ln(x), the base is:', options: ['10', 'e', '2', 'x'], correctIndex: 1, explanation: 'ln(x) is the natural logarithm with base e ≈ 2.71828.'),
    QuizQuestion(question: 'The derivative of e^x is:', options: ['x·e^(x-1)', 'e^x', '1', 'x'], correctIndex: 1, explanation: 'd/dx[e^x] = e^x (unique property of exponential base e).'),
    QuizQuestion(question: 'Which is a rational function?', options: ['f(x) = (x²+1)/(x-2)', 'f(x) = e^x', 'f(x) = √x', 'f(x) = sin(x)'], correctIndex: 0, explanation: 'Rational functions are ratios of polynomials.'),
    QuizQuestion(question: 'The period of tan(x) is:', options: ['π', '2π', 'π/2', '∞'], correctIndex: 0, explanation: 'tan(x + π) = tan(x) for all x where tan is defined.'),
    QuizQuestion(question: 'For f(x) = log₂(x), what is f(8)?', options: ['2', '3', '4', '8'], correctIndex: 1, explanation: 'log₂(8) = 3 because 2³ = 8.'),
    QuizQuestion(question: 'Which function is unbounded?', options: ['f(x) = sin(x)', 'f(x) = x²', 'f(x) = 1/(1+x²)', 'f(x) = arctan(x)'], correctIndex: 1, explanation: 'x² grows without bound as x→±∞. Others are bounded.'),
    QuizQuestion(question: 'The derivative of ln(x) is:', options: ['1/x', 'x', 'log(x)', '1'], correctIndex: 0, explanation: 'd/dx[ln(x)] = 1/x.'),
    QuizQuestion(question: 'For f(x) = 3^x, what is f(2)?', options: ['6', '9', '27', '8'], correctIndex: 1, explanation: '3² = 9.'),
    QuizQuestion(question: 'Which function has a vertical asymptote at x = 0?', options: ['f(x) = 1/x', 'f(x) = x²', 'f(x) = sin(x)', 'f(x) = e^x'], correctIndex: 0, explanation: '1/x → ±∞ as x → 0, creating a vertical asymptote.'),
    QuizQuestion(question: 'The derivative of tan(x) is:', options: ['sec²(x)', 'cot(x)', '-csc²(x)', 'sec(x)tan(x)'], correctIndex: 0, explanation: 'd/dx[tan(x)] = sec²(x).'),
    QuizQuestion(question: 'For f(x) = 5·2^x, f(0) equals:', options: ['5', '10', '2', '0'], correctIndex: 0, explanation: 'f(0) = 5·2⁰ = 5·1 = 5.'),
    QuizQuestion(question: 'Which is NOT a polynomial?', options: ['f(x) = x² - 3x + 2', 'f(x) = 7', 'f(x) = √x', 'f(x) = 5x³'], correctIndex: 2, explanation: '√x = x^(1/2) has a non-integer exponent, so it\'s not a polynomial.'),

    // Limits (Q51-Q75)
    QuizQuestion(question: 'Find lim(x→2) (3x - 1)', options: ['5', '6', '7', '8'], correctIndex: 0, explanation: 'lim(x→2) (3x - 1) = 3(2) - 1 = 5.'),
    QuizQuestion(question: 'Find lim(x→3) (x² + 2x)', options: ['15', '18', '20', '21'], correctIndex: 0, explanation: 'lim(x→3) (x² + 2x) = 9 + 6 = 15.'),
    QuizQuestion(question: 'Evaluate lim(x→1) (x³ - 1)/(x - 1)', options: ['0', '1', '3', 'Does not exist'], correctIndex: 2, explanation: 'This is 0/0 form. Factor: (x³-1)/(x-1) = (x-1)(x²+x+1)/(x-1) = x²+x+1 → 3.'),
    QuizQuestion(question: 'Find lim(x→0) sin(x)/x', options: ['0', '1', '∞', 'Does not exist'], correctIndex: 1, explanation: 'This is a standard limit: lim(x→0) sin(x)/x = 1.'),
    QuizQuestion(question: 'Evaluate lim(x→∞) 5x²/(2x² + 3x)', options: ['5/2', '2/5', '∞', '0'], correctIndex: 0, explanation: 'Divide numerator and denominator by x²: lim = 5/2.'),
    QuizQuestion(question: 'Find lim(x→2) (x² - 4)/(x - 2)', options: ['0', '2', '4', 'Does not exist'], correctIndex: 2, explanation: 'Factor: (x² - 4)/(x - 2) = (x-2)(x+2)/(x-2) = x+2 → 4.'),
    QuizQuestion(question: 'Evaluate lim(x→0⁺) 1/x', options: ['0', '1', '+∞', '-∞'], correctIndex: 2, explanation: 'As x approaches 0 from the right (positive side), 1/x → +∞.'),
    QuizQuestion(question: 'Find lim(x→0⁻) 1/x', options: ['0', '1', '+∞', '-∞'], correctIndex: 3, explanation: 'As x approaches 0 from the left (negative side), 1/x → -∞.'),
    QuizQuestion(question: 'Evaluate lim(x→∞) (x³ - 5x)/(2x³ + 1)', options: ['1/2', '5/2', '0', '∞'], correctIndex: 0, explanation: 'Divide by x³: lim = 1/2.'),
    QuizQuestion(question: 'Find lim(x→1) (x² - 1)/(x² - 3x + 2)', options: ['0', '-2', '2', 'Does not exist'], correctIndex: 1, explanation: 'Factor: (x²-1)/(x²-3x+2) = (x-1)(x+1)/[(x-1)(x-2)] = (x+1)/(x-2) → 2/(-1) = -2.'),
    QuizQuestion(question: 'Evaluate lim(x→0) (cos(x) - 1)/x', options: ['0', '1', '-1', 'Does not exist'], correctIndex: 0, explanation: 'This limit equals 0. Can be shown using L\'Hôpital\'s rule or Taylor series.'),
    QuizQuestion(question: 'Find lim(x→∞) (1 + 1/x)^x', options: ['e', '1', '∞', '0'], correctIndex: 0, explanation: 'This is the definition of e ≈ 2.71828.'),
    QuizQuestion(question: 'Evaluate lim(x→π) sin(x)', options: ['0', '1', '-1', 'Does not exist'], correctIndex: 0, explanation: 'lim(x→π) sin(x) = sin(π) = 0.'),
    QuizQuestion(question: 'Find lim(x→0) (e^x - 1)/x', options: ['0', '1', 'e', 'Does not exist'], correctIndex: 1, explanation: 'This is a standard limit: lim(x→0) (e^x - 1)/x = 1.'),
    QuizQuestion(question: 'Evaluate lim(x→2) √(x + 2)', options: ['√2', '2', '2√2', '4'], correctIndex: 1, explanation: 'lim(x→2) √(x + 2) = √4 = 2.'),
    QuizQuestion(question: 'Find lim(x→∞) e^(-x)', options: ['0', '1', 'e', '∞'], correctIndex: 0, explanation: 'As x→∞, e^(-x) = 1/e^x → 0.'),
    QuizQuestion(question: 'Evaluate lim(x→3) (2x + 1)/(x - 1)', options: ['7/2', '3', '2', '∞'], correctIndex: 0, explanation: 'lim(x→3) (2x + 1)/(x - 1) = 7/2.'),
    QuizQuestion(question: 'Find lim(x→1⁻) ln(x)', options: ['0', '1', '-∞', 'Does not exist'], correctIndex: 2, explanation: 'As x approaches 1 from the left, ln(x) → -∞.'),
    QuizQuestion(question: 'Evaluate lim(x→∞) ln(x)/x', options: ['0', '1', '∞', 'e'], correctIndex: 0, explanation: 'Polynomial grows faster than logarithm. ln(x)/x → 0.'),
    QuizQuestion(question: 'Find lim(x→π/2) tan(x)', options: ['0', '1', '+∞', '-∞'], correctIndex: 2, explanation: 'As x→π/2⁻, tan(x)→+∞. As x→π/2⁺, tan(x)→-∞. Right limit is +∞.'),
    QuizQuestion(question: 'Evaluate lim(x→0) tan(x)/x', options: ['0', '1', '∞', 'Does not exist'], correctIndex: 1, explanation: 'Similar to sin(x)/x, this limit is 1.'),
    QuizQuestion(question: 'Find lim(x→-∞) 5^x', options: ['0', '5', '∞', 'Does not exist'], correctIndex: 0, explanation: 'As x→-∞, 5^x = 1/5^(-x) → 0.'),
    QuizQuestion(question: 'Evaluate lim(x→4) (x - 4)/(√x - 2)', options: ['4', '2', '0', 'Does not exist'], correctIndex: 0, explanation: 'Rationalize: (x-4)/(√x-2)·(√x+2)/(√x+2) = (x-4)(√x+2)/(x-4) = √x+2 → 4.'),
    QuizQuestion(question: 'Find lim(x→0) x·sin(1/x)', options: ['0', '1', '∞', 'Does not exist'], correctIndex: 0, explanation: '|sin(1/x)| ≤ 1, so |x·sin(1/x)| ≤ |x| → 0 by squeeze theorem.'),
    QuizQuestion(question: 'Evaluate lim(x→∞) (√(x² + 1) - x)', options: ['0', '1', '∞', 'Does not exist'], correctIndex: 0, explanation: 'Rationalize: multiply by conjugate to get 1/(√(x²+1)+x) → 0.'),

    // Continuity and Discontinuity (Q76-Q100)
    QuizQuestion(question: 'A function is continuous at x=c if:', options: ['f(c) exists', 'lim(x→c) f(x) exists', 'lim(x→c) f(x) = f(c)', 'All of above'], correctIndex: 3, explanation: 'Continuity requires all three conditions: function value exists, limit exists, and they are equal.'),
    QuizQuestion(question: 'Which function is continuous everywhere?', options: ['f(x) = 1/x', 'f(x) = x²', 'f(x) = tan(x)', 'f(x) = 1/(x-1)'], correctIndex: 1, explanation: 'f(x) = x² is a polynomial and continuous everywhere. Others have discontinuities.'),
    QuizQuestion(question: 'f(x) = (x² - 1)/(x - 1) has a ___ discontinuity at x=1', options: ['Removable', 'Jump', 'Infinite', 'Oscillating'], correctIndex: 0, explanation: 'The limit exists (equals 2) but f(1) is undefined. This is removable.'),
    QuizQuestion(question: 'The discontinuity at x=0 for f(x) = 1/x is:', options: ['Removable', 'Jump', 'Infinite', 'Oscillating'], correctIndex: 2, explanation: '1/x→±∞ as x→0, creating an infinite (vertical asymptote) discontinuity.'),
    QuizQuestion(question: 'For f(x) = |x|/x, the left limit at x=0 is:', options: ['0', '1', '-1', 'Does not exist'], correctIndex: 2, explanation: 'For x < 0: |x|/x = -x/x = -1.'),
    QuizQuestion(question: 'For f(x) = |x|/x, the right limit at x=0 is:', options: ['0', '1', '-1', 'Does not exist'], correctIndex: 1, explanation: 'For x > 0: |x|/x = x/x = 1.'),
    QuizQuestion(question: 'At x=0, f(x) = |x|/x has a ___ discontinuity', options: ['Removable', 'Jump', 'Infinite', 'None'], correctIndex: 1, explanation: 'Left and right limits differ (-1 vs 1), creating a jump discontinuity.'),
    QuizQuestion(question: 'Which property does NOT define continuity at x=c?', options: ['f(c) exists', 'f is differentiable at c', 'lim f(x) = f(c)', 'lim f(x) exists'], correctIndex: 1, explanation: 'Continuity doesn\'t require differentiability (e.g., f(x)=|x| is continuous but not differentiable at 0).'),
    QuizQuestion(question: 'If f is continuous at c and g is continuous at f(c), then:', options: ['g∘f is continuous at c', 'f∘g is continuous at c', 'Both', 'Neither'], correctIndex: 0, explanation: 'Composition of continuous functions is continuous.'),
    QuizQuestion(question: 'The function f(x) = ⌊x⌋ (floor function) is:', options: ['Continuous everywhere', 'Discontinuous at integers', 'Discontinuous everywhere', 'Continuous only at 0'], correctIndex: 1, explanation: 'Floor function has jump discontinuities at all integer values.'),
    QuizQuestion(question: 'For f(x) = sin(1/x) as x→0, the discontinuity is:', options: ['Removable', 'Jump', 'Infinite', 'Oscillating'], correctIndex: 3, explanation: 'sin(1/x) oscillates wildly as x→0, creating an oscillating discontinuity.'),
    QuizQuestion(question: 'A continuous function on [a,b] is:', options: ['Bounded', 'Attains its max', 'Attains its min', 'All of above'], correctIndex: 3, explanation: 'Extreme Value Theorem: continuous functions on closed intervals are bounded and attain extrema.'),
    QuizQuestion(question: 'If f is continuous at c and f(c) ≠ 0, then:', options: ['f(x) ≠ 0 in neighborhood of c', 'f is differentiable at c', 'f is decreasing at c', 'lim(x→c) f(x) = 0'], correctIndex: 0, explanation: 'By continuity and f(c)≠0, there exists a neighborhood where f(x)≠0.'),
    QuizQuestion(question: 'For f(x) = e^x, at all points:', options: ['Continuous', 'Differentiable', 'Increasing', 'All of above'], correctIndex: 3, explanation: 'e^x is continuous, differentiable, and strictly increasing everywhere.'),
    QuizQuestion(question: 'The Intermediate Value Theorem requires:', options: ['f continuous on [a,b]', 'f(a) ≠ f(b)', 'f differentiable', 'f monotonic'], correctIndex: 0, explanation: 'IVT only requires continuity on a closed interval.'),
    QuizQuestion(question: 'For f(x) = cos(x), on ℝ:', options: ['Always continuous', 'Discontinuous at x=nπ', 'Discontinuous at x=nπ/2', 'Never continuous'], correctIndex: 0, explanation: 'Cosine is continuous everywhere.'),
    QuizQuestion(question: 'A piecewise function can be continuous if:', options: ['Pieces are continuous', 'Pieces connect at breaks', 'Limit = function value at break', 'All of above'], correctIndex: 3, explanation: 'All three conditions ensure piecewise continuity.'),
    QuizQuestion(question: 'If f has a jump discontinuity at c:', options: ['Left and right limits differ', 'Limit doesn\'t exist', 'Function not defined at c', 'a and b'], correctIndex: 3, explanation: 'Jump discontinuity means left and right limits exist but differ, and f may not be defined at c.'),
    QuizQuestion(question: 'For continuity at boundary point c of domain:', options: ['Two-sided limit not required', 'One-sided limit sufficient', 'Must satisfy limit = f(c)', 'b or c'], correctIndex: 3, explanation: 'At boundary points, one-sided limits and continuity are checked appropriately.'),
    QuizQuestion(question: 'The function f(x) = √(x-1) is continuous on:', options: ['All ℝ', '[1, ∞)', '(1, ∞)', 'ℝ \\ {1}'], correctIndex: 1, explanation: 'Square root is defined and continuous on [1, ∞).'),
    QuizQuestion(question: 'If lim(x→c) f(x) exists but ≠ f(c):', options: ['Removable discontinuity', 'Jump discontinuity', 'Infinite discontinuity', 'No discontinuity'], correctIndex: 0, explanation: 'Removable discontinuity: limit exists but doesn\'t equal function value.'),
    QuizQuestion(question: 'The function f(x) = ln(x) is continuous on:', options: ['All ℝ', '(0, ∞)', '[0, ∞)', '(-∞, 0)'], correctIndex: 1, explanation: 'ln(x) is defined and continuous on (0, ∞).'),
    QuizQuestion(question: 'For a function to be continuous on [a,b]:', options: ['Must be differentiable', 'Must be increasing', 'Must satisfy definition at all points', 'Must be monotonic'], correctIndex: 2, explanation: 'Continuity requires the definition to be satisfied at each point.'),
    QuizQuestion(question: 'A function with finitely many jump discontinuities on [a,b]:', options: ['Is integrable', 'Is continuous', 'Is differentiable', 'Increases monotonically'], correctIndex: 0, explanation: 'Functions with finitely many discontinuities are still Riemann integrable.'),
    QuizQuestion(question: 'If f is continuous on [a,b] and differentiable on (a,b):', options: ['f\' exists at endpoints', 'Mean Value Theorem applies', 'f is increasing', 'f is bounded above'], correctIndex: 1, explanation: 'Mean Value Theorem requires exactly these conditions.'),
  ];

  /// Shuffle and get a subset of questions
  static List<QuizQuestion> getRandomQuestions({int count = 10}) {
    final shuffled = List<QuizQuestion>.from(allQuestions)..shuffle();
    return shuffled.take(count).toList();
  }

  /// Get all available topics
  static List<String> getAllTopics() {
    return [
      'Domain and Range',
      'Types of Functions',
      'Limits',
      'Continuity and Discontinuity',
    ];
  }
}