// lib/features/learning/data/lessons/mts104_lessons.dart

Map<String, dynamic> getMTS104LessonData(String lessonId) {
  switch (lessonId) {
    case 'mts104_u1_1':
      return {
        'content': '''# Introduction to Vectors

## Vector Definition and Representation

**What is a Vector?**
- Quantity with both magnitude and direction
- Represented as arrow with length and direction
- Differs from scalar (which has magnitude only)

**Vector Notation:**
- Bold: **v** or v with arrow
- Coordinate form: v = (a, b) or v = ⟨a, b⟩
- i-j notation: v = ai + bj
- Column vector: v = [a; b]

**Magnitude (Length):**
|v| = √(a² + b²)

**Direction:**
θ = tan⁻¹(b/a) from x-axis

## Vector Operations

**Vector Addition:**
u + v = (u₁ + v₁, u₂ + v₂)

Properties:
✓ Commutative: u + v = v + u
✓ Associative: (u + v) + w = u + (v + w)
Graphical: Parallelogram or triangle rule

**Vector Subtraction:**
u - v = (u₁ - v₁, u₂ - v₂)
u - v = u + (-v)

**Scalar Multiplication:**
kv = (ka, kb)
|kv| = |k||v|
If k > 0: Same direction
If k < 0: Opposite direction

**Dot Product (Scalar Product):**
u · v = u₁v₁ + u₂v₂
u · v = |u||v|cos θ

Properties:
✓ Commutative: u · v = v · u
✓ Result is scalar (number)
✓ If u · v = 0: Orthogonal (perpendicular)

## Cross Product (3D Vectors)

**Definition:**
u × v produces vector perpendicular to both

**Calculation:**
```
u × v = |i  j  k|
        |u₁ u₂ u₃|
        |v₁ v₂ v₃|
```

**Magnitude:**
|u × v| = |u||v|sin θ

**Properties:**
✓ Non-commutative: u × v = -(v × u)
✓ Result is vector
✓ Right-hand rule for direction

## Unit Vectors

**Definition:**
Vector with magnitude = 1
û = v/|v|

**Standard Unit Vectors:**
i = (1, 0, 0)
j = (0, 1, 0)
k = (0, 0, 1)

**Applications:**
✓ Direction indicators
✓ Breaking vectors into components
✓ Basis for coordinate system

## Special Vector Properties

**Vector Equality:**
Two vectors equal if same magnitude and direction
u = v means u₁ = v₁ and u₂ = v₂

**Parallel Vectors:**
One is scalar multiple of other
v = ku for some constant k

**Collinear Vectors:**
Lie on same line
All parallel vectors are collinear

**Coplanar Vectors:**
Lie in same plane
Can be expressed as linear combinations of two vectors

## Component Form Advantages

**Easy Operations:**
- Addition/subtraction component-wise
- Multiplication by scalar simple
- Magnitude from Pythagorean theorem

**Physical Interpretation:**
- Horizontal and vertical components
- Independent directions
- Simplifies problem-solving

## Magnitude and Direction

**From Components to Magnitude:**
|v| = √(a² + b²)

**From Components to Angle:**
θ = tan⁻¹(b/a)
Note: Must consider quadrant

**From Magnitude and Angle to Components:**
a = |v|cos θ
b = |v|sin θ

## Applications in Physics

**Displacement:**
Vector from initial to final position

**Velocity:**
Rate of change of position

**Force:**
Push or pull with direction

**Acceleration:**
Rate of change of velocity''',
        'questions': [
          {
            'question': 'Vector is quantity with:',
            'options': ['Magnitude only', 'Direction only', 'Magnitude and direction', 'Neither'],
            'correct': 2,
          },
          {
            'question': 'Magnitude of (3, 4):',
            'options': ['3', '4', '5', '7'],
            'correct': 2,
          },
          {
            'question': 'Direction of (1, 1):',
            'options': ['30°', '45°', '60°', '90°'],
            'correct': 1,
          },
          {
            'question': 'u + v commutative means:',
            'options': ['u + v = v - u', 'u + v = v + u', 'u + v = 0', 'u + v = 2u'],
            'correct': 1,
          },
          {
            'question': 'Dot product u · v = 0 when:',
            'options': ['Parallel', 'Perpendicular', 'Same direction', 'Opposite direction'],
            'correct': 1,
          },
        ]
      };

    case 'mts104_u1_2':
      return {
        'content': '''# Applications of Vectors

## Velocity and Acceleration

**Velocity:**
- Rate of change of position
- v = dr/dt
- Vector quantity (magnitude and direction)
- Components: Horizontal and vertical
- Air resistance modeled as vector opposing motion

**Acceleration:**
- Rate of change of velocity
- a = dv/dt
- Vector quantity
- Can change magnitude or direction
- Constant acceleration simplifies analysis

## Force and Motion

**Force Concepts:**
- Vector quantity (measured in Newtons)
- Weight: W = mg (always downward)
- Normal force: Perpendicular to surface
- Friction: Opposes motion
- Tension: Along rope or cable

**Equilibrium Condition:**
Object at rest or constant velocity:
Net force = 0 vector
ΣF = 0, ΣF_x = 0, ΣF_y = 0

## Projectile Motion

**Initial Velocity Components:**
v_x = v₀cos θ (horizontal, constant)
v_y = v₀sin θ (vertical, changes)

**Horizontal Motion:**
x = v₀cos θ · t
Constant velocity (no acceleration)

**Vertical Motion:**
y = v₀sin θ · t - ½gt²
Constant acceleration: -g downward

**Time of Flight:**
t = 2v₀sin θ / g

**Range (Horizontal Distance):**
R = v₀²sin(2θ) / g
Maximum at θ = 45°

**Maximum Height:**
h = (v₀sin θ)² / (2g)
Depends only on vertical component

## Resultant Forces

**Combining Multiple Forces:**

**Graphical Method:**
- Draw vectors tip-to-tail
- Resultant connects start to end
- Parallelogram rule for two forces

**Component Method:**
- Add x-components: ΣF_x
- Add y-components: ΣF_y
- Resultant: R = √((ΣF_x)² + (ΣF_y)²)

**Direction:**
tan θ = ΣF_y / ΣF_x

## Resolving Forces

**Breaking Into Components:**
F_x = F cos θ
F_y = F sin θ

**Advantages:**
✓ Simplifies calculations
✓ Perpendicular components independent
✓ Easier for equilibrium analysis

## Work and Energy

**Work Definition:**
W = F · d = |F||d|cos θ
- Scalar result
- Positive if force aids motion
- Zero if perpendicular

**Kinetic Energy:**
KE = ½m|v|²
Depends on speed squared

**Potential Energy:**
PE = mgh (gravitational)
Relative to reference level

**Power:**
P = W/t = F · v
Rate of energy transfer

## Momentum and Impulse

**Momentum:**
p = mv
Vector quantity
Change: Δp = F·Δt

**Impulse:**
J = F·Δt = Δp
Change in momentum

**Conservation:**
Total momentum conserved if no external forces
Applies to collisions and interactions

## Relative Velocity

**Definition:**
v_AB = v_A - v_B (A relative to B)

**Applications:**
- Navigation and tracking
- Wind and water current problems
- Coordinate system transformation
- Component-wise subtraction

## Navigation Problems

**Bearing:**
Direction measured from north

**Velocity Addition:**
- Boat velocity relative to water
- Water current velocity
- Ground velocity = vector sum

**Heading vs Track:**
- Heading: Direction of motion through medium
- Track: Actual path over ground
- Current affects track

## Equilibrium Analysis

**Conditions for Equilibrium:**
✓ Sum of all forces = 0
✓ ΣF_x = 0, ΣF_y = 0
✓ Static equilibrium: No acceleration
✓ Dynamic equilibrium: Constant velocity

**Finding Unknown Forces:**
- Use component equations
- Solve system of equations
- Check for realistic values''',
        'questions': [
          {
            'question': 'Projectile launched at 45° has:',
            'options': ['Equal components', 'Max range', 'Max time of flight', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Time of flight formula:',
            'options': ['2v₀cosθ/g', '2v₀sinθ/g', 'v₀²/g', 'v₀/g'],
            'correct': 1,
          },
          {
            'question': 'Maximum height depends on:',
            'options': ['Horizontal component', 'Vertical component', 'Total velocity', 'Launch angle'],
            'correct': 1,
          },
          {
            'question': 'In equilibrium, net force:',
            'options': ['Maximum', 'Minimum', 'Zero', 'Increasing'],
            'correct': 2,
          },
          {
            'question': 'Work W = F·d when force perpendicular:',
            'options': ['Maximum', 'Minimum', 'Zero', 'Equals F/d'],
            'correct': 2,
          },
        ]
      };

    case 'mts104_u1_3':
      return {
        'content': '''# Geometry of a Circle

## Circle Definition and Equation

**Circle Definition:**
Set of all points equidistant from a center point
Distance from center = radius (r)

**Standard Form (Center at h, k):**
(x - h)² + (y - k)² = r²

**At Origin (h = 0, k = 0):**
x² + y² = r²

**General Form:**
x² + y² + 2gx + 2fy + c = 0

**From General to Standard:**
Center: (-g, -f)
Radius: √(g² + f² - c)

## Circle Properties

**Circumference:**
C = 2πr

**Area:**
A = πr²

**Diameter:**
d = 2r

**Arc Length:**
s = rθ (θ in radians)

**Sector Area:**
A = ½r²θ (θ in radians)

## Tangent Lines

**Tangent Definition:**
Line touching circle at exactly one point

**Key Property:**
Tangent perpendicular to radius at point of tangency

**From External Point:**
- Exactly two tangents
- Equal length from point to tangent points
- Angle between tangents related to radius

**Tangent Line Equation:**
For circle (x - h)² + (y - k)² = r²
At point (x₀, y₀):
(x₀ - h)(x - h) + (y₀ - k)(y - k) = r²

## Chords

**Chord Definition:**
Line segment joining two points on circle

**Key Properties:**
✓ Perpendicular from center bisects chord
✓ Equal chords equidistant from center
✓ Longer chords closer to center

**Chord Length:**
L = 2r·sin(θ/2) where θ is central angle

**Distance from Center to Chord:**
d = r·cos(θ/2)

## Secant Lines

**Secant Definition:**
Line intersecting circle at two points

**Power of a Point:**
For any secant through external point P:
PA · PB = constant
Where A, B are intersection points

**Intersecting Chords:**
If chords intersect inside circle:
PA · PB = PC · PD

## Circle-Line Intersection

**Possible Cases:**
- No intersection: Distance d > r (line outside)
- Tangent: Distance d = r (one intersection)
- Secant: Distance d < r (two intersections)

**Distance from Point to Line:**
d = |ax₀ + by₀ + c| / √(a² + b²)

## Concentric Circles

**Definition:**
Two or more circles with same center, different radii

**Annular Region:**
Area between two circles:
A = π(R² - r²)
Where R > r

## Inscribed and Circumscribed

**Inscribed Circle:**
- Circle inside polygon
- Tangent to all sides
- Center = incenter of polygon

**Circumscribed Circle:**
- Circle outside polygon
- Passes through all vertices
- Center = circumcenter of polygon

**Regular Polygons:**
- Both inscribed and circumscribed
- Center is same point
- Symmetric properties

## Finding Circle Equations

**Given Three Points:**
- Set up system of three equations
- Solve for center (h, k) and radius r
- Substitute into standard form

**Given Center and Radius:**
- Use standard form directly
- (x - h)² + (y - k)² = r²

**Given Diameter Endpoints:**
- Center = midpoint of diameter
- Radius = half distance between endpoints

**Given Tangent Condition:**
- Distance from center to tangent line = radius
- Use distance formula

## Polar Form of Circle

**Standard Polar Forms:**

**Diameter along x-axis:**
r = 2a cos θ

**Diameter along y-axis:**
r = 2a sin θ

**General Form:**
r = 2a(cos θ cos α + sin θ sin α)

## Applications of Circles

**In Physics:**
- Circular motion
- Orbital paths
- Wave propagation

**In Engineering:**
- Wheel and bearing design
- Pipe sizing
- Circular structure geometry

**In Navigation:**
- Coverage areas
- Distance calculations
- Radar and sonar ranges''',
        'questions': [
          {
            'question': 'Circle equation (x-2)² + (y+3)² = 16 center:',
            'options': ['(2,3)', '(2,-3)', '(-2,-3)', '(-2,3)'],
            'correct': 1,
          },
          {
            'question': 'Circumference with radius 5:',
            'options': ['5π', '10π', '25π', '2.5π'],
            'correct': 1,
          },
          {
            'question': 'Tangent to circle is:',
            'options': ['Parallel to radius', 'Perpendicular to radius', 'Equal to radius', 'Makes 45°'],
            'correct': 1,
          },
          {
            'question': 'Tangents from external point:',
            'options': ['One', 'Two', 'Infinite', 'None'],
            'correct': 1,
          },
          {
            'question': 'Arc length s = rθ needs θ in:',
            'options': ['Degrees', 'Radians', 'Revolutions', 'Any unit'],
            'correct': 1,
          },
        ]
      };

    case 'mts104_u2_1':
      return {
        'content': '''# Conic Sections

## Classification of Conics

**Eccentricity (e) Determines Type:**
- Circle: e = 0
- Ellipse: 0 < e < 1
- Parabola: e = 1
- Hyperbola: e > 1
- Degenerate: Point, line, or two lines

## Ellipse

**Definition:**
Sum of distances from any point to two foci = 2a (constant)

**Standard Equation:**
(x²/a²) + (y²/b²) = 1 where a > b

**Key Elements:**
- Semi-major axis: a (longest)
- Semi-minor axis: b (shortest)
- Foci: (±c, 0) where c² = a² - b²
- Eccentricity: e = c/a
- Center: (0, 0)

**Properties:**
✓ Area: A = πab
✓ Perimeter: P ≈ π(a + b)
✓ Vertices: (±a, 0) and (0, ±b)

**Parametric Form:**
x = a cos θ
y = b sin θ

## Parabola

**Definition:**
Distance to focus = distance to directrix

**Vertex Form:**
(x - h)² = 4p(y - k)

**Standard Form (vertex at origin):**
y² = 4px (opens right/left)
x² = 4py (opens up/down)

**Key Elements:**
- Focus: (p, 0) or (0, p)
- Directrix: x = -p or y = -p
- Vertex: (0, 0)
- Axis of symmetry: Vertical or horizontal
- Opens: Up, down, left, or right

**Parametric Form:**
x = t²
y = 2pt

**Applications:**
✓ Reflectors (parabolic mirrors)
✓ Projectile motion
✓ Antenna design

## Hyperbola

**Definition:**
Difference of distances from any point to two foci = 2a (constant)

**Standard Equation:**
(x²/a²) - (y²/b²) = 1

**Key Elements:**
- Vertices: (±a, 0)
- Foci: (±c, 0) where c² = a² + b²
- Asymptotes: y = ±(b/a)x
- Eccentricity: e = c/a
- Center: (0, 0)

**Conjugate Hyperbola:**
xy = constant (rectangular hyperbola)
Asymptotes are perpendicular
e = √2

**Parametric Form:**
x = a sec θ
y = b tan θ

## General Conic Equation

**Standard Form:**
Ax² + Bxy + Cy² + Dx + Ey + F = 0

**Discriminant Test:**
B² - 4AC < 0: Ellipse (or circle, point)
B² - 4AC = 0: Parabola (or line)
B² - 4AC > 0: Hyperbola (or two lines)

## Eccentricity Properties

**Circle:**
e = 0 (no foci)

**Ellipse:**
e → 0: More circular
e → 1: More elongated

**Parabola:**
e = 1 (special case)

**Hyperbola:**
e > 1 (greater separation)

## Focus-Directrix Property

**Universal Definition:**
For any conic:
e = (distance to focus) / (distance to directrix)

**Same Property for All Conics:**
- Same curve regardless of foci locations
- Eccentricity determines shape
- Defines all conics uniformly

## Polar Form of Conics

**Unified Polar Equation:**
r = l / (1 + e cos θ)

Where:
- l = semi-latus rectum
- e = eccentricity
- Different curves based on e value

**Orbital Mechanics:**
- Describes planetary orbits
- Comet trajectories
- Satellite paths

## Conic Transformations

**Translation:**
Replace x with (x - h), y with (y - k)

**Rotation:**
Use rotation formulas to eliminate Bxy term

**Standard Position:**
Axes along major axes of conic
Simplifies analysis

## Parametric Representations

**Advantages:**
✓ Easier to trace curves
✓ Useful for calculations
✓ Physical interpretations

**Examples:**
- Circle: x = r cos t, y = r sin t
- Ellipse: x = a cos t, y = b sin t
- Parabola: x = t², y = 2pt
- Hyperbola: x = a sec t, y = b tan t''',
        'questions': [
          {
            'question': 'Eccentricity of circle:',
            'options': ['0', '0.5', '1', 'Infinity'],
            'correct': 0,
          },
          {
            'question': 'Ellipse (x²/25) + (y²/9) = 1 has a:',
            'options': ['3', '5', '4', '25'],
            'correct': 1,
          },
          {
            'question': 'Parabola y² = 8x has focus at:',
            'options': ['(1,0)', '(2,0)', '(4,0)', '(8,0)'],
            'correct': 1,
          },
          {
            'question': 'Hyperbola asymptotes for (x²/9)-(y²/4)=1:',
            'options': ['y=±(4/3)x', 'y=±(2/3)x', 'y=±(3/2)x', 'y=±x'],
            'correct': 1,
          },
          {
            'question': 'B²-4AC = 0 indicates:',
            'options': ['Ellipse', 'Parabola', 'Hyperbola', 'Circle'],
            'correct': 1,
          },
        ]
      };

    case 'mts104_u2_2':
      return {
        'content': '''# Dynamics (I): Kinematics

## Motion Fundamentals

**Motion Definition:**
Change of position with time
Depends on reference frame

**Distance vs Displacement:**
- Distance: Total path length (scalar)
- Displacement: Change in position (vector)
- Same only if straight-line motion

**Speed vs Velocity:**
- Speed: Distance/time (scalar)
- Velocity: Displacement/time (vector)
- Average: Over time interval
- Instantaneous: At specific moment

## Acceleration

**Definition:**
a = dv/dt (rate of change of velocity)

**Vector Quantity:**
Has magnitude and direction
Can change magnitude or direction

**Constant Acceleration:**
v = u + at
s = ut + ½at²
v² = u² + 2as

## Kinematic Equations

**First Equation:**
v = u + at
Relates: velocity, initial velocity, acceleration, time

**Second Equation:**
s = ut + ½at²
Relates: displacement, initial velocity, acceleration, time

**Third Equation:**
v² = u² + 2as
Relates: velocity, initial velocity, acceleration, displacement

**Fourth Equation:**
s = (u + v)t/2
Average velocity method

**Fifth Equation:**
s = vt - ½at²
From final velocity perspective

## Graphical Analysis

**Displacement-Time Graph:**
- Slope = velocity
- Straight line = constant velocity
- Parabolic curve = constant acceleration

**Velocity-Time Graph:**
- Slope = acceleration
- Straight line = constant acceleration
- Area under curve = displacement

**Acceleration-Time Graph:**
- Area under curve = change in velocity

## Vertical Motion

**Gravity Acceleration:**
g = 9.8 m/s² (downward)

**Equations Apply:**
Same kinematic equations with a = g

**Time Symmetry:**
Time to go up = time to come down (same height)

**Velocity Change:**
Changes by gt each second

**Displacement in nth Second:**
u + g(n - ½)

## Free Fall

**Only Gravity Acts:**
Air resistance neglected

**From Rest:**
h = ½gt²
v = gt
No initial velocity

**Terminal Velocity:**
Gravity balanced by air resistance
Constant final velocity

## Relative Motion

**Relative Velocity:**
v_AB = v_A - v_B
A's velocity relative to B

**Vector Subtraction:**
Component-wise operations

**Coordinate Transformation:**
Velocity in different reference frames

## Circular Motion

**Angular Quantities:**
- Angular displacement: θ (radians)
- Angular velocity: ω = dθ/dt
- Angular acceleration: α = dω/dt

**Linear-Angular Relations:**
- Linear velocity: v = rω
- Linear acceleration: a = rα (tangential)
- Centripetal acceleration: a_c = v²/r = rω²

**Uniform Circular Motion:**
Constant speed around circle

**Period and Frequency:**
- Period: T = 2π/ω
- Frequency: f = 1/T = ω/(2π)

## Applications

**Projectile Motion:**
Combines vertical (acceleration) and horizontal (constant velocity)

**Circular Motion:**
Constant angular velocity or acceleration

**Simple Harmonic Motion:**
Periodic motion with restoring force

## Problem-Solving Strategy

**For Constant Acceleration:**
1. Identify known and unknown quantities
2. Choose appropriate kinematic equation
3. Substitute values
4. Solve algebraically
5. Check units and reasonableness

**For Vertical Motion:**
Use same equations with a = g (or -g)

**For Circular Motion:**
Convert between linear and angular quantities''',
        'questions': [
          {
            'question': 'Displacement vs distance:',
            'options': ['Same always', 'Vectors vs scalar', 'Path-dependent', 'Both equal for straight line'],
            'correct': 3,
          },
          {
            'question': 'Average velocity:',
            'options': ['Distance/time', 'Displacement/time', 'Speed/time', 'Acceleration/time'],
            'correct': 1,
          },
          {
            'question': 'v² = u² + 2as uses:',
            'options': ['Time', 'No time', 'Constant a', 'Both B and C'],
            'correct': 3,
          },
          {
            'question': 'Free fall time from height h:',
            'options': ['t = √(h/g)', 't = √(2h/g)', 't = h/g', 't = h/2g'],
            'correct': 1,
          },
          {
            'question': 'Centripetal acceleration directed:',
            'options': ['Outward', 'Tangent', 'Toward center', 'Downward'],
            'correct': 2,
          },
        ]
      };

    case 'mts104_u2_3':
      return {
        'content': '''# Dynamics (II): Forces and Newton's Laws

## Newton's Laws of Motion

**First Law:**
Object at rest stays at rest
Object in motion stays in motion
Unless acted upon by net force
Inertia: Resistance to change in motion

**Second Law:**
F = ma (Net force = mass × acceleration)
Vector equation: F⃗ = ma⃗
Components: F_x = ma_x, F_y = ma_y
Fundamental equation of motion

**Third Law:**
For every action, there is equal opposite reaction
Forces occur in pairs
Same magnitude, opposite direction
Act on different objects
Cannot cancel each other

## Types of Forces

**Gravitational Force:**
- Weight: W = mg
- Always downward
- Causes free fall acceleration

**Normal Force:**
- Perpendicular to surface
- On horizontal: N = mg
- On incline: N = mg cos θ
- Prevents objects from passing through

**Friction Force:**
- Opposes motion
- Kinetic: f = μ_k N (moving)
- Static: f ≤ μ_s N (stationary, maximum)
- Usually μ_s > μ_k

**Tension Force:**
- Transmitted through rope
- Same throughout massless rope
- Acts along rope direction
- Cannot push, only pull

**Spring Force:**
- F = -kx (Hooke's Law)
- k = spring constant
- x = displacement from equilibrium
- Restoring force (negative sign)

## Equilibrium Analysis

**Static Equilibrium:**
- Object at rest
- Net force = 0: ΣF = 0
- No acceleration

**Conditions:**
✓ ΣF_x = 0
✓ ΣF_y = 0
✓ Object remains at rest

## Connected Bodies

**System Connected by Rope:**
- Apply Newton's second law to each object
- Or to system as whole
- Internal forces: Between connected objects
- External forces: From environment

**Atwood Machine:**
Unequal masses connected by rope over pulley
Acceleration: a = (m₁ - m₂)g / (m₁ + m₂)
Tension: T = 2m₁m₂g / (m₁ + m₂)

## Inclined Plane

**Component Analysis:**
- Parallel to plane: mg sin θ
- Perpendicular: mg cos θ
- Normal force: N = mg cos θ
- Friction: f = μ mg cos θ

**Motion Along Plane:**
Net force: F_net = mg sin θ - f
Acceleration: a = g(sin θ - μ cos θ)

## Circular Motion Forces

**Centripetal Force:**
F_c = mv²/r = mrω²
Directed toward center

**Providers of Centripetal Force:**
- Tension (vertical circle)
- Friction (horizontal)
- Gravity (orbital motion)
- Normal force (banking)

**Conical Pendulum:**
- Tension has vertical and horizontal components
- Vertical: T cos θ = mg
- Horizontal: T sin θ = mv²/r
- Angle: tan θ = v²/(rg)

**Banking Angle:**
tan θ = v²/(rg)
Friction may provide additional force

## Work and Energy

**Work Definition:**
W = F · s = Fs cos θ
- Positive: Force aids motion
- Negative: Force opposes motion
- Zero: Force perpendicular

**Kinetic Energy:**
KE = ½mv²
- Always positive
- Increases with velocity squared

**Potential Energy:**
PE = mgh (gravitational)
- Reference level needed
- Can be negative
- Relative quantity

**Work-Energy Theorem:**
W_net = ΔKE
Net work equals change in kinetic energy

**Energy Conservation:**
E = KE + PE = constant
In conservative force field, total mechanical energy conserved

## Power

**Definition:**
P = W/t = F · v
- Rate of energy transfer
- Units: Watts (W) = J/s
- Average: P_avg = W_total/t_total
- Instantaneous: P = F⃗ · v⃗

## Momentum and Impulse

**Momentum:**
p = mv
Vector quantity
Related to force: F = dp/dt

**Impulse:**
J = F·Δt = Δp
Change in momentum

**Impulse-Momentum Theorem:**
FΔt = mΔv
Force-time equals momentum change

**Conservation of Momentum:**
Total momentum conserved if no external forces
Applies to collisions and interactions

## Collisions

**Elastic Collision:**
- Momentum conserved
- Kinetic energy conserved
- Objects separate after collision

**Inelastic Collision:**
- Momentum conserved
- Kinetic energy lost (heat, deformation)
- Objects may stick together

**Perfectly Inelastic:**
- Objects stick together
- Maximum energy loss (consistent with momentum conservation)
- One final object after collision''',
        'questions': [
          {
            'question': 'Newton\'s Second Law F = ma means:',
            'options': ['All forces equal', 'Force is acceleration', 'Net force causes acceleration', 'Force equals mass'],
            'correct': 2,
          },
          {
            'question': 'Normal force on incline 30°:',
            'options': ['mg', 'mg sin 30°', 'mg cos 30°', 'mg tan 30°'],
            'correct': 2,
          },
          {
            'question': 'Static vs kinetic friction:',
            'options': ['Usually μ_s > μ_k', 'Usually μ_k > μ_s', 'Always equal', 'No relationship'],
            'correct': 0,
          },
          {
            'question': 'Centripetal force directed:',
            'options': ['Outward', 'Tangent', 'Toward center', 'Downward'],
            'correct': 2,
          },
          {
            'question': 'Work W = F·s·cos θ is zero when:',
            'options': ['F = 0', 'θ = 0°', 'θ = 90°', 'θ = 180°'],
            'correct': 2,
          },
        ]
      };

    case 'mts104_u3_1':
      return {
        'content': '''# Oscillation and Resonance

## Simple Harmonic Motion (SHM)

**Definition:**
Motion where restoring force proportional to displacement

**Force:**
F = -kx
Negative sign: Restoring (opposes displacement)

**Equation of Motion:**
a = -ω²x where ω = √(k/m)

**Displacement Equation:**
x = A cos(ωt + φ)
- A = amplitude (maximum displacement)
- ω = angular frequency
- φ = phase constant
- t = time

**Velocity in SHM:**
v = -Aω sin(ωt + φ)
Maximum: v_max = Aω (at equilibrium)

**Acceleration in SHM:**
a = -Aω² cos(ωt + φ)
Maximum: a_max = Aω² (at extremes)

## Period and Frequency

**Period:**
T = 2π/ω = 2π√(m/k)
Time for one complete oscillation

**Frequency:**
f = 1/T = ω/(2π)
Oscillations per unit time

**Angular Frequency:**
ω = 2πf = 2π/T
Radians per unit time

## Energy in SHM

**Kinetic Energy:**
KE = ½mv² = ½mA²ω² sin²(ωt + φ)

**Potential Energy:**
PE = ½kx² = ½kA² cos²(ωt + φ)

**Total Mechanical Energy:**
E = KE + PE = ½kA² = constant
Energy oscillates between kinetic and potential

**Energy Transfer:**
- At extremes: All potential
- At equilibrium: All kinetic

## Simple Pendulum

**Period:**
T = 2π√(L/g)
L = length
g = gravitational acceleration

**Properties:**
- Independent of mass
- Depends on length only
- Small angle approximation

## Damped Oscillation

**Damping Force:**
Friction reduces amplitude
Energy dissipated as heat

**Types of Damping:**

**Underdamped:**
- Oscillates with decreasing amplitude
- Eventually stops
- Oscillations visible initially

**Critically Damped:**
- Returns to equilibrium fastest
- No oscillation
- Optimal damping

**Overdamped:**
- Slowly returns to equilibrium
- No oscillation
- Slower than critical

## Forced Oscillation and Resonance

**Driven Oscillation:**
External force applied to oscillator
Frequency may differ from natural frequency

**Resonance:**
Driving frequency equals natural frequency
Maximum amplitude response
Can be dangerous

**Amplitude Response:**
- Sharp peak at resonance
- Depends on damping
- Wider peak with less damping

**Applications:**
- Vibration absorption
- Energy transfer
- Mechanical amplification

## Resonance Phenomena

**Examples:**
- Bridge collapse from marching troops
- Radio tuning to specific frequency
- Microwave heating water molecules
- Earthquake damage

**Preventing Resonance:**
- Damping (shock absorbers)
- Change natural frequency
- Avoid driving frequency
- Isolation systems

## Mathematical Description

**Differential Equation:**
m(d²x/dt²) + b(dx/dt) + kx = F₀cos(ωt)

**Terms:**
- m(d²x/dt²): Inertial force
- b(dx/dt): Damping force
- kx: Restoring force
- F₀cos(ωt): Driving force

**Solution Form:**
- Transient: Dies out
- Steady-state: Oscillates at driving frequency
- At resonance: Very large amplitude''',
        'questions': [
          {
            'question': 'Simple harmonic motion has:',
            'options': ['F = kx', 'F = -kx', 'No restoring force', 'Constant force'],
            'correct': 1,
          },
          {
            'question': 'SHM amplitude A in x = Acos(ωt):',
            'options': ['Maximum displacement', 'Frequency', 'Phase', 'Energy'],
            'correct': 0,
          },
          {
            'question': 'Maximum velocity in SHM:',
            'options': ['Aω', 'Aω²', 'A/ω', 'A'],
            'correct': 0,
          },
          {
            'question': 'Period of pendulum depends on:',
            'options': ['Mass', 'Length', 'Amplitude', 'Both A and B'],
            'correct': 1,
          },
          {
            'question': 'Resonance occurs when:',
            'options': ['Any force applied', 'Driving frequency = natural', 'Amplitude small', 'No damping'],
            'correct': 1,
          },
        ]
      };

    case 'mts104_u3_2':
      return {
        'content': '''# Rotation and Angular Motion

## Rotational Dynamics Fundamentals

**Torque (τ):**
τ = r × F (vector)
τ = rF sin θ
Magnitude: Perpendicular force component × radius

**Moment of Inertia (I):**
Rotational analog of mass
I = Σ(m_i r_i²)
Units: kg·m²
Depends on: Shape, mass distribution, axis

**Rotational Newton's Second Law:**
τ = Iα
Torque equals inertia times angular acceleration

## Angular Kinematics

**Relations to Linear:**
- Angular velocity: ω = v/r
- Angular acceleration: α = a/r
- Tangential velocity: v = rω
- Tangential acceleration: a_t = rα

**Constant Angular Acceleration:**
ω = ω₀ + αt
θ = ω₀t + ½αt²
ω² = ω₀² + 2αθ

## Angular Momentum

**Definition:**
L = r × p = Iω
Angular momentum = inertia × angular velocity

**Conservation:**
L = constant if no external torque
Applies to rotating systems

**Spin and Orbital:**
Particles have both orbital and spin angular momentum
Total conserved in isolated system

## Rotational Kinetic Energy

**Definition:**
KE_rot = ½Iω²
Analogous to ½mv²

**Total Energy:**
For rolling object: E = ½mv² + ½Iω²
Includes both translational and rotational

## Parallel Axis Theorem

**Formula:**
I = I_cm + md²
I about axis = I about center of mass + md²

**d = Distance Between Axes:**
Allows calculating I about any parallel axis

**Applications:**
- Compound objects
- Different rotation axes
- Simplifies calculations

## Work and Power in Rotation

**Work:**
W = τθ
Torque × angular displacement

**Power:**
P = τω
Power = torque × angular velocity
Analogous to P = Fv

## Gyroscopic Precession

**Spinning Object:**
Resists change in direction of spin axis

**Precession:**
Spin axis rotates around different axis
Precession rate: Ω = τ/L

**Applications:**
- Navigation (gyroscope)
- Stability (spinning top)
- Angular momentum conservation

## Rotational vs Translational

**Correspondence:**
- Force ↔ Torque
- Mass ↔ Moment of inertia
- Linear velocity ↔ Angular velocity
- Linear momentum ↔ Angular momentum
- KE = ½mv² ↔ KE = ½Iω²

**Advantages:**
- Use same principles
- Easier analysis
- Common physics patterns

## Common Moments of Inertia

**Point Mass at Distance r:**
I = mr²

**Solid Cylinder (about axis):**
I = ½mr²

**Solid Sphere (about diameter):**
I = (2/5)mr²

**Thin Rod (about center):**
I = (1/12)mL²

**Thin Hoop:**
I = mr²

## Rolling Motion

**Combined Motion:**
- Translational: v_cm
- Rotational: ω

**No-Slip Condition:**
v_cm = rω

**Energy:**
E_total = ½mv_cm² + ½Iω²

**Down Incline:**
Different accelerations for different shapes
Depends on moment of inertia

## Fixed Axis Rotation

**Simple Case:**
Object rotates about fixed axis
All points move in circles
Angular velocity same for all points''',
        'questions': [
          {
            'question': 'Torque τ = r × F produces:',
            'options': ['Linear motion', 'Angular acceleration', 'Linear force', 'Equilibrium'],
            'correct': 1,
          },
          {
            'question': 'Moment of inertia is:',
            'options': ['Like mass', 'Rotation resistance', 'Depends on axis', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Rotational KE = ½Iω² is:',
            'options': ['Same as translational', 'Analogous to ½mv²', 'Only for spheres', 'No potential'],
            'correct': 1,
          },
          {
            'question': 'Angular momentum conserved when:',
            'options': ['Force applied', 'No external torque', 'Object spins', 'Velocity changes'],
            'correct': 1,
          },
          {
            'question': 'Parallel axis theorem: I = I_cm + md² where d is:',
            'options': ['Mass distance', 'Axis separation', 'Radius', 'Height'],
            'correct': 1,
          },
        ]
      };

    case 'mts104_u3_3':
      return {
        'content': '''# Advanced Applications: Orbital Mechanics

## Orbital Motion

**Centripetal Force from Gravity:**
Gravitational force provides centripetal force

**Force Balance:**
GMm/r² = mv²/r

**Orbital Velocity:**
v = √(GM/r)
Depends on central mass and radius

**Orbital Period:**
T = 2πr/v = 2π√(r³/GM)
Kepler's third law relationship

## Circular Orbits

**Stable Circular Orbit:**
- Constant speed v = √(GM/r)
- Constant radius r
- Period T = 2π√(r³/GM)

**Energy:**
- Kinetic: KE = ½mv² = GMm/(2r)
- Potential: PE = -GMm/r
- Total: E = -GMm/(2r)

**Orbital Mechanics:**
- Satellite orbits
- Planetary motion
- Star systems

## Escape Velocity

**Definition:**
Minimum velocity to escape gravitational field

**Energy Approach:**
½mv_esc² = GMm/R

**Escape Velocity:**
v_esc = √(2GM/R)
Independent of object mass

**Examples:**
- Earth: 11.2 km/s
- Moon: 2.4 km/s
- Black hole: > speed of light

## Reduced Mass System

**Two-Body Problem:**
Two masses orbiting common center

**Reduced Mass:**
μ = m₁m₂/(m₁ + m₂)

**Advantages:**
- Converts to one-body problem
- Relative motion simplified
- Easier calculations

## Kepler's Laws

**First Law:**
Orbits are ellipses (or circles)
Focus at one focus

**Second Law:**
Equal areas swept in equal times
Angular momentum conserved

**Third Law:**
T² ∝ r³
Period related to orbital radius

## Coriolis and Centrifugal Forces

**Rotating Reference Frame:**
Non-inertial frame effects

**Centrifugal Force:**
Fictitious force: F_cf = mω²r
Outward from rotation axis

**Coriolis Force:**
Fictitious force: F_cor = 2m(v × ω)
Deflects moving objects

**Applications:**
- Weather patterns
- Projectile motion
- Rotating machinery

## Center of Mass Motion

**System of Particles:**
r_cm = Σ(m_i r_i) / Σm_i
v_cm = Σ(m_i v_i) / Σm_i

**External Force:**
F_ext = M_total · a_cm
Sum of external forces accelerates center of mass

**Internal Forces:**
Cancel out in center of mass analysis
Reduce problem to single effective particle

## Collision Problems

**Elastic Collision:**
- Momentum conserved
- Kinetic energy conserved
- Can calculate final velocities

**Inelastic Collision:**
- Momentum conserved
- Kinetic energy lost
- Objects may stick

**Reduced Mass:**
Useful for relative motion analysis

## Energy Considerations

**Conservative Forces:**
Total mechanical energy conserved
Gravitational, elastic spring forces

**Work-Energy:**
Work equals change in kinetic energy
Relates forces to motion

**Efficiency:**
Mechanical advantage
Energy losses

## Coupled Systems

**Multiple Objects:**
Connected by forces or constraints
Analyze as system or individually
Internal vs external forces

**Applications:**
- Coupled pendulums
- Gear systems
- Linked mechanisms
- Multi-body dynamics

## Problem-Solving Strategies

**For Orbital Motion:**
1. Identify gravitational or centripetal force
2. Apply force balance
3. Use appropriate equations
4. Account for reference frames

**For Energy:**
1. Identify conservative and non-conservative forces
2. Apply energy conservation
3. Use work-energy theorem
4. Check units and limits

**For Rotating Systems:**
1. Calculate moment of inertia
2. Determine torques
3. Apply rotational equations
4. Use angular-linear relationships''',
        'questions': [
          {
            'question': 'Orbital velocity v = √(GM/r) depends on:',
            'options': ['Only object mass', 'Central mass and radius', 'Orbital period', 'All of above'],
            'correct': 1,
          },
          {
            'question': 'Kepler\'s third law T² ∝ r³ relates:',
            'options': ['Period to radius', 'Velocity to radius', 'Force to radius', 'Mass to radius'],
            'correct': 0,
          },
          {
            'question': 'Escape velocity v_esc = √(2GM/R):',
            'options': ['Depends on object mass', 'Independent of object mass', 'Depends on shape', 'Only for Earth'],
            'correct': 1,
          },
          {
            'question': 'Reduced mass μ = m₁m₂/(m₁+m₂):',
            'options': ['Actual mass', 'Useful for two-body', 'Conserved quantity', 'Neither A nor B'],
            'correct': 1,
          },
          {
            'question': 'Coriolis force in rotating frame:',
            'options': ['Real force', 'Fictitious force', 'Deflects moving objects', 'Both B and C'],
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