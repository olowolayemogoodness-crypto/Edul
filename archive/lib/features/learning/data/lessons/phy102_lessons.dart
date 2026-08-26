// lib/features/learning/data/lessons/phy102_lessons.dart

Map<String, dynamic> getPHY102LessonData(String lessonId) {
  switch (lessonId) {
    case 'phy102_u1_1':
      return {
        'content': '''# Electrostatics: Foundations

## Electric Charge

**What is Electric Charge?**
- Fundamental property of matter
- Two types: Positive (+) and Negative (-)
- Like charges repel, opposite charges attract

**Key Properties:**
✓ Quantized: Q = ne (n = integer, e = elementary charge)
✓ e = 1.6 × 10⁻¹⁹ Coulombs (C)
✓ Conserved: Total charge never created/destroyed
✓ Transferable: Moving electrons transfers charge

## Coulomb's Law

**The Force Between Charges:**

F = kq₁q₂/r²

Where:
- F = force between charges
- k = 9 × 10⁹ N·m²/C² (Coulomb's constant)
- q₁, q₂ = charges (Coulombs)
- r = distance between charges

**Important Features:**
✓ Inversely proportional to distance squared
✓ Proportional to product of charges
✓ Acts along line joining charges
✓ Repulsive (same charges) or Attractive (opposite charges)

**Example:**
If q₁ = 2 C, q₂ = 3 C, r = 1 m
F = 9 × 10⁹ × 2 × 3 / 1² = 54 × 10⁹ N (repulsive)

## Conductors vs Insulators

**Conductors:**
- Free electrons move easily
- Examples: Copper, Aluminum, Water with ions
- Charge redistributes quickly
- Allow current flow

**Insulators:**
- Bound electrons, difficult to move
- Examples: Rubber, Glass, Wood, Plastic
- Prevent current flow
- Resist charge movement

**Semiconductors:**
- Intermediate conductivity
- Can be doped (controlled conductivity)
- Silicon, Germanium
- Used in electronics

## Electrostatic Phenomena

**Induction:**
- Charge redistribution without contact
- Grounding: Connect to earth neutralizes charge
- Shielding: Conductors protect interior

**Corona Discharge:**
- High electric field ionizes air
- Visible glow around sharp points
- Example: Lightning rods

**Gauss's Law:**

Φₑ = Q_enclosed/ε₀

- ε₀ = 8.85 × 10⁻¹² C²/(N·m²)
- Useful for symmetric charge distributions
- Relates electric flux to enclosed charge''',
        'questions': [
          {
            'question': 'Elementary charge e equals:',
            'options': ['1.6 × 10⁻¹⁹ C', '9 × 10⁹ C', '3 × 10⁸ C', '4π × 10⁻⁷ C'],
            'correct': 0,
          },
          {
            'question': 'Coulomb\'s constant k equals:',
            'options': ['8.85 × 10⁻¹²', '9 × 10⁹', '3 × 10⁸', '4π × 10⁻⁷'],
            'correct': 1,
          },
          {
            'question': 'Coulomb\'s law force:',
            'options': ['Proportional to r²', 'Inversely proportional to r²', 'Independent of distance', 'Proportional to r'],
            'correct': 1,
          },
          {
            'question': 'Charge conservation means:',
            'options': ['Charge cannot be created', 'Charge cannot be destroyed', 'Total charge constant', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Conductors have:',
            'options': ['Bound electrons', 'Free electrons', 'No electrons', 'Positive ions only'],
            'correct': 1,
          },
        ]
      };

    case 'phy102_u1_2':
      return {
        'content': '''# Electric Field and Potential

## Electric Field Definition

**What is Electric Field?**

E = F/q (Force per unit charge)

- Vector quantity (has magnitude and direction)
- Units: N/C or V/m
- Field lines point from positive to negative

**Field from Point Charge:**

E = kq/r² (radially outward if positive)

- Strength decreases with distance squared
- Independent of test charge
- Multiple fields vector add (superposition)

## Electric Potential

**What is Electric Potential?**

V = W/q (Work per unit charge)

- Scalar quantity (no direction)
- Units: Volts (V) = J/C
- Measured relative to reference (usually infinity)

**Potential from Point Charge:**

V = kq/r

- Decreases with distance
- Positive charge → positive potential
- Negative charge → negative potential

## Relationship Between E and V

**The Connection:**

E = -dV/dr

- Electric field points from high to low potential
- Steeper potential gradient → stronger field
- Field direction perpendicular to equipotential surfaces

## Equipotential Surfaces

**What are Equipotential Surfaces?**
- Points at same potential
- Perpendicular to electric field lines
- No work done moving charge on equipotential
- Concentric spheres around point charge

**Important Property:**
✓ No electric field component along equipotential
✓ Movement along equipotential requires no work
✓ Useful for visualizing fields

## Capacitance

**Definition:**

C = Q/V (Charge per unit potential)

- Units: Farads (F)
- Larger capacitor stores more charge at given voltage
- Depends on geometry

**Parallel Plate Capacitor:**

C = ε₀A/d

- A = plate area
- d = plate separation
- Proportional to area, inversely to distance

**Energy Stored:**

U = ½QV = ½CV² = ½Q²/C

- Energy in electric field
- Released when discharged

## Capacitors in Circuits

**Series Connection:**
1/C_total = 1/C₁ + 1/C₂ + ...
- Total capacitance less than any individual
- Same charge on all

**Parallel Connection:**
C_total = C₁ + C₂ + ...
- Total capacitance is sum
- Same voltage across all

## Dielectric Materials

**Effect of Dielectrics:**
- Increase capacitance by factor κ (dielectric constant)
- Reduce electric field inside
- Allow higher voltage ratings

**Polarization:**
- Molecules align in electric field
- Reduces net field
- Creates opposing field

**Energy Density:**

u = ½ε₀E²

- Energy per unit volume in field
- Distributed throughout space''',
        'questions': [
          {
            'question': 'Electric field units:',
            'options': ['N/C', 'V/m', 'Both are correct', 'J/C'],
            'correct': 2,
          },
          {
            'question': 'Electric potential is:',
            'options': ['Vector quantity', 'Scalar quantity', 'Same as field', 'Has direction'],
            'correct': 1,
          },
          {
            'question': 'Relationship E = -dV/dr means:',
            'options': ['Field from potential', 'Potential from field', 'Field opposes potential', 'Unrelated quantities'],
            'correct': 0,
          },
          {
            'question': 'Equipotential surfaces are:',
            'options': ['Parallel to field lines', 'Perpendicular to field lines', 'Coincide with field lines', 'Random orientation'],
            'correct': 1,
          },
          {
            'question': 'Capacitor energy formula:',
            'options': ['U = ½QV', 'U = ½CV²', 'U = ½Q²/C', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'phy102_u1_3':
      return {
        'content': '''# Current Electricity

## Electric Current

**Definition:**

I = Q/t (Charge flow rate)

- Units: Amperes (A) = Coulombs/second
- Conventional current: Direction of positive charge flow
- Electron flow: Opposite to conventional current

**Drift Velocity:**
- Actual speed of electrons is very slow
- Signal travels much faster (electromagnetic wave speed)

## Ohm's Law

**The Fundamental Relationship:**

V = IR

- V = voltage across element
- I = current through element
- R = resistance

**Resistance Formula:**

R = ρL/A

- ρ = resistivity (material property)
- L = length of conductor
- A = cross-sectional area

**Conductivity:**
σ = 1/ρ (inverse of resistivity)

## Temperature Dependence

**Resistance and Temperature:**

ρ(T) = ρ₀[1 + α(T - T₀)]

- α = temperature coefficient of resistivity
- Most metals: Resistance increases with temperature
- Thermistors: Resistance decreases with temperature
- Superconductors: Zero resistance below critical temperature

## Electrical Power

**Power Formulas:**

P = VI (Basic)
P = I²R (Current dissipation)
P = V²/R (Voltage dissipation)

- Units: Watts (W)
- All three equivalent

**Heat Generated:**

Q = I²Rt

- Heat in resistor (Joule heating)
- Energy dissipated as heat

**Energy Consumption:**

E = Pt (in Joules)
E = Pt/3.6 × 10⁶ (in kWh)

## EMF and Internal Resistance

**Electromotive Force (EMF):**
- ε = maximum potential difference (open circuit)
- "Pushing force" for charges
- Property of source, not circuit element

**Internal Resistance:**
- r = resistance within battery/source
- Causes voltage drop under load

**Terminal Voltage:**

V = ε - Ir

- Less than EMF when current flows
- Depends on current through source

## Kirchhoff's Laws

**Voltage Law (Loop Law):**
- Sum of voltages around closed loop = 0
- Energy conservation
- Apply to find unknown voltages

**Current Law (Junction Law):**
- Current in = Current out at junction
- Charge conservation
- Apply to find unknown currents

## Series and Parallel

**Series Circuits:**
- Same current through all
- Voltages add: V_total = V₁ + V₂ + ...
- Resistances add: R_total = R₁ + R₂ + ...

**Parallel Circuits:**
- Same voltage across all
- Currents add: I_total = I₁ + I₂ + ...
- 1/R_total = 1/R₁ + 1/R₂ + ...

**Circuit Measurement:**
✓ Ammeter (measures current): Low resistance, series connection
✓ Voltmeter (measures voltage): High resistance, parallel connection
✓ Ohmmeter (measures resistance): Contains battery, disconnects circuit''',
        'questions': [
          {
            'question': 'Current units:',
            'options': ['Volts', 'Amperes', 'Ohms', 'Watts'],
            'correct': 1,
          },
          {
            'question': 'Ohm\'s law V = IR means:',
            'options': ['Voltage from resistance', 'Voltage from current', 'Voltage across element', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Temperature effect on metal resistance:',
            'options': ['Increases with temperature', 'Decreases with temperature', 'No change', 'Depends on metal'],
            'correct': 0,
          },
          {
            'question': 'Power P = I²R represents:',
            'options': ['Heat dissipated', 'Joule heating', 'Resistor heating', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Terminal voltage V = ε - Ir means:',
            'options': ['EMF reduced by internal resistance', 'Current-dependent voltage', 'Always less than EMF', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'phy102_u2_1':
      return {
        'content': '''# Magnetic Field and Forces

## Magnetic Field Basics

**What is Magnetic Field?**
- Exerts force on moving charges
- B field: Magnetic flux density (Tesla, T)
- H field: Magnetic field intensity (A/m)
- Source: Magnets, currents, moving charges

**Magnetic Field Lines:**
- Represent field direction
- Point from North to South pole
- Never cross
- Form closed loops

## Lorentz Force

**Force on Moving Charge:**

F = qv × B

- Perpendicular to both v and B
- Magnitude: F = qvB sin θ
- Maximum when v ⊥ B

**Direction (Right-Hand Rule):**
- Fingers point along velocity
- Curl toward field direction
- Thumb points in force direction

**Force on Current-Carrying Wire:**

F = BIL

- I = current through wire
- L = length in field
- Perpendicular to both I and B

## Torque on Current Loop

**Torque Calculation:**

τ = NIAB sin θ

- N = number of turns
- A = loop area
- θ = angle with field
- Maximum when loop perpendicular to field

**Applications:**
✓ Motors: Convert electrical to mechanical energy
✓ Galvanometer: Measures small currents
✓ Moving coil speakers

## Sources of Magnetic Field

**Natural and Created:**
✓ Permanent magnets: Aligned atomic dipoles
✓ Current-carrying conductors: Magnetic field around wire
✓ Electromagnets: Coils with current
✓ Earth: Planetary magnetic field

## Biot-Savart Law

**Magnetic Field from Current Element:**

dB = (μ₀I/4π) × (dl × r̂)/r²

- μ₀ = 4π × 10⁻⁷ T·m/A (permeability)
- Integration gives total field
- Used for arbitrary current distributions

## Ampere's Law

**For Symmetric Distributions:**

∮B·dl = μ₀I_enclosed

**Applications:**

**Straight Wire:**
B = μ₀I/(2πr)
- Field circles around wire
- Decreases with distance

**Solenoid:**
B = μ₀nI
- n = turns per unit length
- Uniform field inside
- Used in electromagnets

## Magnetic Materials

**Classification:**

**Diamagnetic:**
- Weakly repelled by field
- All materials show some diamagnetism
- No permanent magnetic moment

**Paramagnetic:**
- Weakly attracted to field
- Unpaired electrons
- Temporary alignment

**Ferromagnetic:**
- Strongly attracted to field
- Retain magnetism (permanent magnets)
- Aligned electron spins
- Examples: Iron, Cobalt, Nickel

**Permeability:**
μ = μ₀μᵣ (μᵣ = relative permeability)

## Electromagnetic Induction

**Faraday's Law:**

ε = -dΦ_B/dt

- Changing flux induces EMF
- Negative sign from Lenz's law

**Magnetic Flux:**

Φ_B = BA cos θ

- Units: Weber (Wb)
- Depends on field strength and area angle

**Lenz's Law:**
- Induced EMF opposes the change
- Energy conservation
- Current direction opposes flux change''',
        'questions': [
          {
            'question': 'Magnetic field units:',
            'options': ['Tesla (T)', 'Weber (Wb)', 'Henry (H)', 'Ampere (A)'],
            'correct': 0,
          },
          {
            'question': 'Lorentz force direction:',
            'options': ['Along velocity', 'Along field', 'Perpendicular to both', 'Random'],
            'correct': 2,
          },
          {
            'question': 'Force on current wire F = BIL requires:',
            'options': ['Wire perpendicular to field', 'Wire parallel to field', 'Any angle', 'Depends on current'],
            'correct': 0,
          },
          {
            'question': 'Magnetic field inside solenoid:',
            'options': ['B = μ₀nI', 'B = μ₀I/(2πr)', 'B = kq/r²', 'B = 0'],
            'correct': 0,
          },
          {
            'question': 'Ferromagnetic material shows:',
            'options': ['Weak attraction', 'Strong attraction', 'Permanent magnetism', 'Both B and C'],
            'correct': 3,
          },
        ]
      };

    case 'phy102_u2_2':
      return {
        'content': '''# Self and Mutual Inductance

## Self-Inductance

**Definition:**

L = NΦ/I

- L = inductance (Henry, H)
- N = number of turns
- Φ = magnetic flux
- Relates flux change to current change

**Back EMF:**

ε = -L(dI/dt)

- Opposes applied voltage
- Slows current change
- Energy storage effect

**Energy Stored:**

U = ½LI²

- Magnetic energy in inductor
- Released when current stops

## Mutual Inductance

**Definition:**

M₁₂ = Φ₁₂/I₂

- Flux in coil 1 per unit current in coil 2
- Basis for transformers
- Couples circuits

**Transformer Equation:**

Vs/Vp = Ns/Np

- Secondary/Primary voltage ratio
- Turns ratio
- Step-up (Ns > Np): Increases voltage
- Step-down (Ns < Np): Decreases voltage

## Transformer Operation

**Ideal Transformer:**
- 100% efficiency (no losses)
- Power input = Power output
- Ps = Pp, so Is/Ip = Np/Ns

**Real Transformer Losses:**
- Copper loss: I²R in windings
- Iron loss: Hysteresis and eddy currents
- Efficiency: 95-99%

**Power Transmission:**
- Step up voltage for transmission (reduce current)
- Reduces I²R losses
- Step down for household use
- Enables long-distance power transfer

## RL Circuits

**Circuit with Resistance and Inductance:**
- Inductor opposes current change
- Back EMF = -L(dI/dt)
- Current grows exponentially to terminal value

**Time Constant:**
τ = L/R

- Determines response speed
- After 5τ: ~99% of final value

## AC Circuits with Inductance

**Inductive Reactance:**

XL = ωL = 2πfL

- ω = angular frequency
- Resistance-like behavior
- Increases with frequency

**Phase Relationship:**
- Voltage leads current by 90°
- Pure inductor: maximum phase shift''',
        'questions': [
          {
            'question': 'Self-inductance units:',
            'options': ['Farad (F)', 'Henry (H)', 'Tesla (T)', 'Weber (Wb)'],
            'correct': 1,
          },
          {
            'question': 'Back EMF ε = -L(dI/dt) means:',
            'options': ['Opposes current change', 'Inductor resists changes', 'Stores energy', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Transformer equation Vs/Vp = Ns/Np gives:',
            'options': ['Voltage ratio', 'Turns ratio', 'Current ratio', 'Power ratio'],
            'correct': 0,
          },
          {
            'question': 'Step-up transformer has:',
            'options': ['Ns > Np', 'Ns < Np', 'Ns = Np', 'No relation'],
            'correct': 0,
          },
          {
            'question': 'Ideal transformer efficiency:',
            'options': ['50%', '90%', '100%', '99%'],
            'correct': 2,
          },
        ]
      };

    case 'phy102_u2_3':
      return {
        'content': '''# Electromagnetic Waves

## Maxwell's Equations

**The Four Foundations:**

1. Gauss's Law: ∮E·dA = Q/ε₀
2. No Monopoles: ∮B·dA = 0
3. Faraday's Law: ∮E·dl = -dΦ_B/dt
4. Ampere-Maxwell: ∮B·dl = μ₀I + μ₀ε₀dΦ_E/dt

**Prediction:**
- Changing electric field creates magnetic field
- Changing magnetic field creates electric field
- Self-sustaining waves: Electromagnetic waves!

## EM Wave Properties

**Field Relationships:**
✓ E and B perpendicular to each other
✓ Both perpendicular to propagation direction
✓ In phase, equal amplitudes (E/B = c)
✓ Transverse waves

**Speed of Light:**

c = 3 × 10⁸ m/s

c = 1/√(μ₀ε₀)

- Same in all reference frames (vacuum)
- Independent of source motion
- Fundamental constant

## Wave Equation

**The Wave Relationship:**

c = fλ

- c = speed
- f = frequency
- λ = wavelength
- Always valid for EM waves in vacuum

**Frequency and Period:**
f = 1/T

## Energy in EM Waves

**Energy Density:**

u = ½(ε₀E² + B²/μ₀)

- Energy per unit volume
- From electric and magnetic fields
- Equal contributions

**Intensity (Average Power per Area):**

I = ½ε₀cE₀²

- Units: W/m²
- Proportional to E² amplitude

**Poynting Vector:**

S = E × B/μ₀

- Magnitude: energy flow rate
- Direction: wave propagation
- Units: W/m²

## Radiation Pressure

**Momentum Transfer:**

P = I/c

- Pressure from electromagnetic waves
- Double if completely reflected
- Used in optical tweezers, solar sails

**Physical Basis:**
- Photons carry momentum p = E/c
- Transfer momentum to surface

## EM Spectrum

**Order by Wavelength (longest to shortest):**

1. **Radio**: 10⁰ to 10⁻³ m (lowest frequency)
2. **Microwave**: 10⁻³ to 10⁻¹ m
3. **Infrared**: 10⁻⁶ to 10⁻³ m
4. **Visible**: 400-700 nm (human eye)
5. **Ultraviolet**: 10⁻⁸ to 10⁻⁷ m
6. **X-ray**: 10⁻¹² to 10⁻⁸ m
7. **Gamma**: < 10⁻¹² m (highest frequency)

**Energy Relationship:**
E = hf (higher frequency → higher energy)

## Polarization

**Definition:**
- Direction of E field oscillation
- Perpendicular to wave propagation

**Types:**
- Unpolarized: Random polarization
- Linearly polarized: Single plane
- Circularly polarized: Rotating E field

**Polarizers:**
- Select one polarization direction
- Malus's Law: I = I₀ cos²θ
- Reduces intensity

## Doppler Effect

**Frequency Shift with Motion:**

f' = f(v + v_obs)/(v - v_src)

- **Redshift**: Source receding (f decreases)
- **Blueshift**: Source approaching (f increases)
- Applies to all waves
- Astrophysics: Galaxy motion determination''',
        'questions': [
          {
            'question': 'Maxwell\'s equations predict:',
            'options': ['EM waves exist', 'Light is EM wave', 'Wave speed = c', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'EM wave propagation requires:',
            'options': ['E and B perpendicular', 'Both perpendicular to direction', 'Transverse wave', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Speed of light c =:',
            'options': ['3 × 10⁸ m/s', 'fλ', '1/√(μ₀ε₀)', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Intensity proportional to:',
            'options': ['E', 'E²', 'E³', 'E⁻¹'],
            'correct': 1,
          },
          {
            'question': 'Visible light wavelength range:',
            'options': ['100-200 nm', '400-700 nm', '1-10 μm', '10-100 nm'],
            'correct': 1,
          },
        ]
      };

    case 'phy102_u3_1':
      return {
        'content': '''# EM Wave Applications

## Radio and Television

**AM Radio (Amplitude Modulation):**
- Modulates amplitude of carrier wave
- Constant frequency
- Long wavelength (easy diffraction around obstacles)
- Susceptible to electrical noise

**FM Radio (Frequency Modulation):**
- Modulates frequency of carrier
- Constant amplitude
- Less susceptible to noise
- Better audio quality

**Television:**
- Video: Amplitude modulated
- Audio: Frequency modulated
- Transmitted over allocated frequency bands
- Satellite and terrestrial transmission

## Microwave Applications

**Microwave Ovens:**
- Frequency: ~2.45 GHz
- Excite polar molecules (water, fats)
- Molecular rotation produces heat
- Selective heating (water-rich areas hottest)

**Radar (Radio Detection and Ranging):**
- Sends EM pulse
- Detects reflected signal
- Measures distance: d = ct/2
- Determines direction and speed (Doppler)
- Applications: Weather, navigation, speed detection

**WiFi and Mobile:**
- Microwave frequencies
- Modulated digital signals
- Wireless data transmission
- Base stations and routers

## Infrared Applications

**Thermal Imaging:**
- Detects heat radiation (IR)
- Longer wavelength than visible
- Used in security, medicine, building inspection
- Each object emits IR based on temperature

**Fiber Optic Communication:**
- Uses visible light or near-IR
- Travels through glass fiber
- Total internal reflection confines light
- Long distance, high bandwidth
- Immune to electromagnetic interference

**Heating:**
- Heat lamps
- Industrial heating
- Food cooking/warming

## Visible Light Applications

**Photosynthesis:**
- Energy source for life
- Absorption by chlorophyll
- Creates chemical energy (ATP, glucose)

**Vision:**
- Visible light detection by eye
- Rod and cone cells
- Signal processing in brain

**Optical Communications:**
- Fiber optics
- Laser communication
- Underwater communication

## Ultraviolet Applications

**Sterilization:**
- UV light kills microorganisms
- Damages DNA, prevents reproduction
- Water purification
- Medical equipment sterilization

**Fluorescence:**
- UV absorbed by material
- Material re-emits visible light
- Used in detection, security
- Fluorescent lamps

**Medical Therapy:**
- Skin conditions treatment
- Psoriasis, vitiligo
- Vitamin D synthesis (skin)

## X-Ray Applications

**Medical Imaging:**
- Radiography: Bone/tissue imaging
- CT scans: Cross-sectional images
- Fluoroscopy: Real-time imaging
- Penetrates soft tissue, absorbed by bone

**Crystallography:**
- Determines crystal structure
- X-rays diffract through crystals
- Reveals atomic arrangement
- Drug development, materials research

**Security Screening:**
- Airport baggage checks
- Detects concealed objects
- Non-destructive inspection

**Therapy:**
- Cancer treatment
- Radiation therapy uses X-rays
- Kills cancer cells

## Gamma Ray Applications

**Medical Imaging:**
- PET scans: Positron emission
- SPECT: Single photon detection
- Functional imaging of organs

**Sterilization:**
- Food preservation
- Medical device sterilization
- Kills microorganisms and prevents spoilage

**Cancer Therapy:**
- Radiotherapy
- Gamma knife: Focused radiation
- Destroys tumor cells

## Antenna Theory

**Dipole Antenna:**
- Simple radiator and receiver
- Perpendicular to signal
- Half-wavelength typical
- Omnidirectional pattern

**Parabolic Antenna:**
- Focuses waves
- Increased gain and directionality
- Used in radar and satellite communication
- Reflector concentrates waves

**Antenna Gain:**
- Directivity and efficiency
- Compared to isotropic radiator
- Measured in decibels (dB)
- Higher gain = narrower beam

## Electromagnetic Shielding

**Faraday Cage:**
- Conductor mesh blocks external fields
- Prevents electromagnetic interference (EMI)
- Laboratory use for sensitive equipment
- MRI rooms use shielding

**Cable Shielding:**
- Coaxial cable: Inner conductor + outer shield
- Shields from external interference
- Reduces crosstalk between cables
- Improves signal quality''',
        'questions': [
          {
            'question': 'AM radio modulates:',
            'options': ['Amplitude', 'Frequency', 'Phase', 'Wavelength'],
            'correct': 0,
          },
          {
            'question': 'FM radio advantage:',
            'options': ['Lower noise', 'Better quality', 'Longer range', 'Both A and B'],
            'correct': 3,
          },
          {
            'question': 'Microwave oven frequency:',
            'options': ['1 GHz', '2.45 GHz', '5 GHz', '10 GHz'],
            'correct': 1,
          },
          {
            'question': 'Fiber optic data transmitted by:',
            'options': ['Radio waves', 'Microwaves', 'Visible light/IR', 'X-rays'],
            'correct': 2,
          },
          {
            'question': 'UV sterilization kills microbes by:',
            'options': ['Heat', 'DNA damage', 'Ionization', 'Both B and C'],
            'correct': 3,
          },
        ]
      };

    case 'phy102_u3_2':
      return {
        'content': '''# Motors, Generators, and Transformers

## DC Motors

**Operating Principle:**
- Magnetic force on current-carrying coil
- Commutator reverses current direction
- Rotates continuously

**Torque Production:**

τ = BIAL sin θ

- B = magnetic field
- I = current
- A = coil area
- L = effective wire length (simplification)

**Commutator:**
- Split ring contacts
- Reverses current every half rotation
- Maintains constant rotation direction
- Keeps torque in same direction

**DC Motor Efficiency:**
- Mechanical power output / Electrical power input
- Typically 80-95%
- Losses: Friction, eddy currents, copper resistance

## AC Motors

**Operation:**
- Rotating magnetic field from phase-shifted currents
- Induces current in rotor
- Rotor follows rotating field

**Three-Phase Power:**
- Three sinusoidal currents, 120° apart
- Smoother power delivery
- More efficient than single-phase
- Standard for industrial power

**AC Motor Types:**
- Synchronous: Rotor locks to field frequency
- Asynchronous (Induction): Rotor slightly slower than field

## Electric Generators

**Basic Principle:**
- Mechanical energy → Electrical energy
- Faraday's law of induction
- Rotating coil in magnetic field

**AC Generator:**
- Rotating coil produces sinusoidal voltage
- ε = NABω sin ωt
- Frequency = rotation frequency

**DC Generator:**
- Uses commutator to rectify output
- Pulsed DC voltage
- More complex than AC generator
- Used in some applications

**Generator Efficiency:**
- Typical efficiency 85-95%
- Losses from friction and resistance

## Transformer Operation

**Basic Principle:**
- Transfer power between circuits
- Change voltage/current
- No moving parts

**Transformer Equation:**

Vs/Vp = Ns/Np
Is/Ip = Np/Ns

- V = voltage
- I = current
- N = number of turns
- s = secondary, p = primary

**Step-Up Transformer:**
- Ns > Np
- Increases voltage
- Decreases current (power constant)
- Used for power transmission

**Step-Down Transformer:**
- Ns < Np
- Decreases voltage
- Increases current
- Used for household supply from transmission lines

## Ideal vs Real Transformers

**Ideal Transformer:**
- 100% efficiency
- Ps = Pp (power in = power out)
- Equation: Vs/Vp = Ns/Np

**Real Transformer Losses:**
- Copper loss: I²R in windings
- Iron loss: Hysteresis (B-H loop area)
- Eddy currents in core
- Overall efficiency: 95-99%

## Power Transmission

**Three-Phase System:**
- Three alternating voltages, 120° apart
- More efficient than single-phase
- Standard for power distribution

**Transmission Process:**
1. Generator creates voltage (kilovolts)
2. Step-up transformer (increases voltage, decreases current)
3. Long-distance transmission (minimizes I²R losses)
4. Step-down transformer (decreases voltage for homes)
5. Distribution to consumers

**Power Factor:**

cos φ = Real Power / Apparent Power

- Accounts for phase difference between V and I
- Reactive power (inductors, capacitors)
- Affects actual power consumption

**Power Factor Correction:**
- Capacitors reduce phase angle
- Reduces apparent power drawn
- Saves energy and reduces losses''',
        'questions': [
          {
            'question': 'DC motor uses commutator to:',
            'options': ['Reverse current', 'Maintain rotation', 'Switch brushes', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'AC motor frequency:',
            'options': ['50 Hz', '60 Hz', 'Determined by supply', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Generator converts:',
            'options': ['Electrical to mechanical', 'Mechanical to electrical', 'Electrical to heat', 'Light to electrical'],
            'correct': 1,
          },
          {
            'question': 'Transformer voltage equation relates:',
            'options': ['Voltage ratio', 'Turns ratio', 'Both same', 'Power ratio'],
            'correct': 2,
          },
          {
            'question': 'Power transmission uses step-up to:',
            'options': ['Increase power', 'Increase voltage', 'Reduce losses', 'Both B and C'],
            'correct': 3,
          },
        ]
      };

    case 'phy102_u3_3':
      return {
        'content': '''# Applied Physics: Modern Applications

## Photoelectric Effect

**Einstein's Equation:**

hf = Φ + KEmax

- h = Planck's constant (6.63 × 10⁻³⁴ J·s)
- f = frequency of light
- Φ = work function (material-dependent)
- KEmax = maximum kinetic energy of ejected electron

**Key Points:**
✓ Light energy used to: Overcome work function + give kinetic energy
✓ Threshold frequency: f₀ = Φ/h (minimum to eject electrons)
✓ No electrons ejected below threshold, regardless of intensity
✓ Photon energy must exceed work function

**Applications:**
- Photodiodes: Light detection
- Phototransistors: Amplified detection
- Image sensors: Digital cameras, phones
- Solar cells: Photovoltaic effect

## Semiconductor Applications

**Diode:**
- P-n junction
- One-way current flow (forward vs reverse)
- Rectification (AC → DC)
- Depletion region prevents reverse current

**Transistor:**
- Bipolar Junction Transistor (BJT)
- Amplification of signals
- Switching (digital)
- Base current controls collector current

**Field Effect Transistor (FET):**
- Gate voltage controls channel
- Faster than BJT
- Used in modern integrated circuits

**Logic Gates:**
- Transistor-based Boolean operations
- AND, OR, NOT gates
- Foundation of digital electronics

**Integrated Circuits:**
- Millions/billions of transistors on single chip
- Microprocessors, memory
- Modern computing and devices

## Solar Cells

**Photovoltaic Effect:**
- Light generates EMF
- Opposite to photoelectric (charge separation, not emission)

**P-N Junction:**
- P-type (holes) and N-type (electrons)
- Depletion region separates charges
- Built-in electric field creates voltage

**Efficiency:**
- Typically 15-20% for commercial cells
- Depends on material (silicon, gallium arsenide)
- Limited by thermodynamic factors

**Applications:**
- Power generation (rooftops, solar farms)
- Satellite power
- Remote applications
- Grid integration growing

## Electron Behavior

**Cathode Ray Tube (CRT):**
- Electron gun: Accelerates electrons
- Deflection: Electric or magnetic fields
- Screen: Fluorescent coating, emits light
- Basis for old TV and computer displays

**Electron Beam Applications:**
- X-ray production
- Electron microscopy
- Vacuum tubes
- Old technology, largely replaced

**X-Ray Production:**
- High-speed electrons hit metal target
- Sudden deceleration produces X-rays
- Bremsstrahlung: Braking radiation
- Characteristic X-rays from electron knockoff

## Thermionic Emission

**Basic Phenomenon:**
- Electrons emitted from heated metal
- Temperature dependent
- Richardson equation describes emission

**Applications:**
- Vacuum tubes (old technology)
- Electron microscopes
- X-ray sources
- Mostly replaced by semiconductors

## Bioelectromagnetism

**Biological EM Phenomena:**
- Nerve impulses: Ion gradients create voltage
- Muscle contraction: Neural signals
- ECG: Heart electrical activity (0.5-4 mV)
- EEG: Brain electrical activity (10-100 μV)

**Medical Applications:**
- ECG monitoring: Heart health
- EEG monitoring: Brain activity, seizures
- Electrical stimulation therapy
- Tissue regeneration

## Electrostatic Phenomena

**Electrostatic Precipitator:**
- Removes particulates (dust, pollution)
- Ionizes particles with corona
- Electric field attracts to collection plate
- Used in air pollution control

**Inkjet Printer:**
- Charges ink droplets
- Electric field deflects droplets
- Positions on paper
- Precise pattern control

**Electrostatic Motor:**
- Coulomb force between charged plates
- Simple, no moving conductors
- Rarely used (weak force)

**Capacitive Sensors:**
- Detect nearby objects
- Change in capacitance
- Touchscreen technology
- Proximity detection

## Electromagnetic Compatibility (EMC)

**EMI Shielding:**
- Prevents electromagnetic interference
- Faraday cage principle
- Frequency-dependent effectiveness
- Critical for sensitive electronics

**Grounding:**
- Provides return path for currents
- Safety (prevents shocks)
- Reduces noise
- Equalizes potential

**Cable Management:**
- Separate power and signal cables
- Minimize loop areas
- Twisted pairs reduce radiation
- Shielded cables for sensitive signals

**Device Isolation:**
- Physical separation
- Reduces coupling
- Filters on inputs/outputs
- Critical in medical/laboratory equipment''',
        'questions': [
          {
            'question': 'Photoelectric Einstein equation:',
            'options': ['hf = Φ + KE', 'E = hf', 'E = mc²', 'P = VI'],
            'correct': 0,
          },
          {
            'question': 'Photoelectric threshold frequency:',
            'options': ['Depends on intensity', 'Minimum to eject electrons', 'Depends on material', 'Both B and C'],
            'correct': 3,
          },
          {
            'question': 'Solar cell photovoltaic efficiency:',
            'options': ['5-10%', '15-20%', '50%', '90%'],
            'correct': 1,
          },
          {
            'question': 'X-ray production requires:',
            'options': ['High-speed electrons', 'Target metal', 'Sudden deceleration', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'ECG measures:',
            'options': ['Brain activity', 'Heart electrical activity', 'Muscle contraction', 'Nerve impulses'],
            'correct': 1,
          },
        ]
      };

    case 'phy102_u5_1':
      return {
        'content': '''# Electric Current

## What is Electric Current?

**Definition:**
Electric current is the rate of flow of electric charge through a conductor.

I = Q/t

Where:
- I = current (Amperes, A)
- Q = charge (Coulombs, C)
- t = time (seconds, s)

**Key Facts:**
✓ Conventional current flows from + to − (opposite to electron flow)
✓ 1 Ampere = 1 Coulomb per second
✓ Current is a scalar quantity
✓ Requires a closed circuit to flow continuously

## Types of Current

**Direct Current (DC):**
- Flows in one direction only
- Produced by batteries, solar cells
- Used in electronic devices
- Voltage is constant with time

**Alternating Current (AC):**
- Direction reverses periodically
- Frequency = 50 Hz (Nigeria/UK) or 60 Hz (USA)
- Produced by generators/alternators
- Used in mains electricity supply

## Current Carriers

**In metallic conductors:**
- Free electrons are the charge carriers
- Move from − to + terminal
- Drift velocity is very slow (~mm/s)
- But electric field propagates at near light speed

**In electrolytes:**
- Positive and negative ions both carry charge
- Used in batteries and electroplating

**In semiconductors:**
- Both electrons and holes carry charge

## Measuring Current

**Ammeter:**
- Connected in SERIES with the circuit
- Has very LOW resistance (ideally zero)
- Never connect in parallel — damages the meter
- Symbol: A in a circle

## Current Density

J = I/A

Where:
- J = current density (A/m²)
- A = cross-sectional area of conductor

**Drift velocity relationship:**
I = nAve_d

Where:
- n = number of charge carriers per unit volume
- A = cross-sectional area
- v_d = drift velocity
- e = electron charge (1.6 × 10⁻¹⁹ C)

## Key Formulas Summary

| Quantity | Formula | Unit |
|---|---|---|
| Current | I = Q/t | Ampere (A) |
| Charge | Q = It | Coulomb (C) |
| Current density | J = I/A | A/m² |
| Drift velocity | v_d = I/nAe | m/s |
''',
        'questions': [
          {
            'question': 'Electric current is defined as:',
            'options': ['Charge per unit volume', 'Rate of flow of charge', 'Voltage per unit resistance', 'Power per unit time'],
            'correct': 1,
          },
          {
            'question': 'The SI unit of electric current is:',
            'options': ['Coulomb', 'Volt', 'Ampere', 'Ohm'],
            'correct': 2,
          },
          {
            'question': 'Conventional current flows from:',
            'options': ['Negative to positive terminal', 'Positive to negative terminal', 'Inside the battery only', 'Depends on resistance'],
            'correct': 1,
          },
          {
            'question': 'An ammeter is connected in:',
            'options': ['Parallel with the load', 'Series with the load', 'Either series or parallel', 'Diagonal to the circuit'],
            'correct': 1,
          },
          {
            'question': 'If 10 C of charge flows through a wire in 2 seconds, the current is:',
            'options': ['20 A', '0.2 A', '5 A', '12 A'],
            'correct': 2,
          },
        ]
      };

    case 'phy102_u5_2':
      return {
        'content': '''# Resistance and Resistors

## What is Resistance?

**Definition:**
Resistance is the opposition a material offers to the flow of electric current.

R = V/I    (Ohm's Law)

Where:
- R = resistance (Ohms, Ω)
- V = potential difference (Volts, V)
- I = current (Amperes, A)

**1 Ohm** = 1 Volt per Ampere

## Ohm's Law

**Statement:**
The current through a conductor is directly proportional to the potential difference across it, provided temperature and other physical conditions remain constant.

V = IR

**Ohmic vs Non-Ohmic conductors:**
- **Ohmic:** V–I graph is a straight line (e.g. metallic resistors at constant temperature)
- **Non-Ohmic:** V–I graph is curved (e.g. diodes, filament bulbs, thermistors)

## Factors Affecting Resistance

R = ρL/A

Where:
- ρ = resistivity of material (Ω·m)
- L = length of conductor (m)
- A = cross-sectional area (m²)

**Effect of each factor:**
✓ Longer wire → higher resistance
✓ Thicker wire → lower resistance
✓ Higher resistivity material → higher resistance
✓ Higher temperature → higher resistance (for metals)

## Resistivity Values

| Material | Resistivity (Ω·m) | Type |
|---|---|---|
| Silver | 1.6 × 10⁻⁸ | Conductor |
| Copper | 1.7 × 10⁻⁸ | Conductor |
| Aluminium | 2.8 × 10⁻⁸ | Conductor |
| Silicon | 640 | Semiconductor |
| Glass | 10¹⁰–10¹⁴ | Insulator |

## Temperature Effect

**For metals:**
R_T = R₀(1 + αT)

Where:
- R₀ = resistance at 0°C
- α = temperature coefficient of resistance
- T = temperature change (°C)

**Key points:**
✓ Resistance of metals increases with temperature
✓ Resistance of semiconductors decreases with temperature
✓ Superconductors have zero resistance below critical temperature

## Types of Resistors

**Fixed resistors:** Carbon composition, wire-wound
**Variable resistors:** Rheostat (2 terminals), Potentiometer (3 terminals)
**Special resistors:** Thermistor (temperature-sensitive), LDR (light-sensitive)

## Key Formulas

| Formula | What it gives |
|---|---|
| R = V/I | Resistance from Ohm's Law |
| R = ρL/A | Resistance from geometry |
| R_T = R₀(1 + αT) | Temperature dependence |
''',
        'questions': [
          {
            'question': 'Ohm\'s Law states that current is proportional to:',
            'options': ['Resistance', 'Power', 'Potential difference', 'Charge'],
            'correct': 2,
          },
          {
            'question': 'Resistance of a wire increases when its length is:',
            'options': ['Decreased', 'Increased', 'Doubled in area', 'Cooled down'],
            'correct': 1,
          },
          {
            'question': 'A conductor has resistivity ρ, length L, area A. Its resistance is:',
            'options': ['ρA/L', 'ρL/A', 'ρ/LA', 'LA/ρ'],
            'correct': 1,
          },
          {
            'question': 'As temperature increases, resistance of a metal:',
            'options': ['Decreases', 'Stays the same', 'Increases', 'First increases then decreases'],
            'correct': 2,
          },
          {
            'question': 'A 12 V battery drives 3 A through a resistor. Its resistance is:',
            'options': ['36 Ω', '4 Ω', '0.25 Ω', '9 Ω'],
            'correct': 1,
          },
        ]
      };

    case 'phy102_u5_3':
      return {
        'content': '''# Electrical Power and Energy

## Electrical Power

**Definition:**
Power is the rate at which electrical energy is converted to other forms of energy.

P = VI = I²R = V²/R

Where:
- P = power (Watts, W)
- V = voltage (Volts, V)
- I = current (Amperes, A)
- R = resistance (Ohms, Ω)

**1 Watt** = 1 Joule per second = 1 Volt × 1 Ampere

## Electrical Energy

E = Pt = VIt = I²Rt = V²t/R

Where:
- E = energy (Joules, J)
- t = time (seconds, s)

**Commercial unit of energy:**
1 kilowatt-hour (kWh) = 3.6 × 10⁶ J = 3.6 MJ

Used by electricity companies for billing.

## Power Dissipation in Resistors

**Heat produced (Joule's Law):**
Q = I²Rt

Where:
- Q = heat generated (Joules)
- I = current (A)
- R = resistance (Ω)
- t = time (s)

**Applications:**
✓ Electric heaters, irons, toasters use this effect
✓ Filament bulbs — heat causes light emission
✓ Fuses — melt when excess current generates too much heat
✓ Unwanted in motors, transformers (efficiency loss)

## Power Ratings

**Every electrical device has a power rating:**
- 60 W bulb: converts 60 J every second
- 2 kW kettle: converts 2000 J every second

**From rating, find operating current:**
I = P/V

Example: 60 W bulb on 240 V mains:
I = 60/240 = 0.25 A

## Efficiency

η = (Useful power output / Total power input) × 100%

**Power loss in transmission lines:**
P_loss = I²R_line

This is why high-voltage transmission is used — same power, lower current, much less loss.

## EMF and Internal Resistance

**A real battery has internal resistance (r):**

Terminal voltage: V = E − Ir

Where:
- E = EMF (electromotive force) of battery
- I = current drawn
- r = internal resistance
- V = terminal (output) voltage

**Maximum power transfer theorem:**
Maximum power is transferred to external load R when R = r (internal resistance)

## Key Formulas

| Formula | Application |
|---|---|
| P = VI | Power from V and I |
| P = I²R | Power dissipated in resistor |
| P = V²/R | Power from V and R |
| E = Pt | Energy from power and time |
| V = E − Ir | Terminal voltage of battery |
''',
        'questions': [
          {
            'question': 'Electrical power is given by:',
            'options': ['P = IR', 'P = VI', 'P = V/I', 'P = I/V'],
            'correct': 1,
          },
          {
            'question': 'The commercial unit of electrical energy is:',
            'options': ['Watt', 'Joule', 'Kilowatt-hour', 'Coulomb'],
            'correct': 2,
          },
          {
            'question': 'Heat produced in a resistor R carrying current I for time t is:',
            'options': ['IRt', 'I²Rt', 'IR²t', 'It/R'],
            'correct': 1,
          },
          {
            'question': 'A 100 W bulb operates on 200 V. The current through it is:',
            'options': ['2 A', '0.5 A', '20 A', '0.05 A'],
            'correct': 1,
          },
          {
            'question': 'Terminal voltage of a battery is less than EMF because of:',
            'options': ['External resistance', 'Internal resistance voltage drop', 'Capacitance', 'Inductance'],
            'correct': 1,
          },
        ]
      };

    case 'phy102_u5_4':
      return {
        'content': '''# Resistors in Series and Parallel

## Series Circuits

**Connection:** Resistors connected end-to-end, same current through all.

**Total resistance:**
R_total = R₁ + R₂ + R₃ + ...

**Key properties:**
✓ Same current flows through all resistors: I = I₁ = I₂ = I₃
✓ Voltages add up: V = V₁ + V₂ + V₃
✓ Total resistance is always greater than any individual resistor
✓ If one component fails (open circuit), whole circuit stops

**Voltage divider:**
V₁/V₂ = R₁/R₂

Voltage across each resistor is proportional to its resistance.

## Parallel Circuits

**Connection:** Both ends of each resistor connected to the same two nodes.

**Total resistance:**
1/R_total = 1/R₁ + 1/R₂ + 1/R₃ + ...

**Special case — two resistors in parallel:**
R_total = R₁R₂/(R₁ + R₂)

**Key properties:**
✓ Same voltage across all resistors: V = V₁ = V₂ = V₃
✓ Currents add up: I = I₁ + I₂ + I₃
✓ Total resistance is always less than any individual resistor
✓ If one branch fails, others continue working

**Current divider (two resistors):**
I₁/I₂ = R₂/R₁

Current splits inversely proportional to resistance.

## Comparison Table

| Property | Series | Parallel |
|---|---|---|
| Current | Same everywhere | Splits at junction |
| Voltage | Splits across each | Same across each |
| Total R | Increases | Decreases |
| Failure | All stop | Others continue |
| Use | Christmas lights (old style), fuses | Household wiring |

## Mixed Circuits

**Strategy to solve:**
1. Identify series and parallel groups
2. Simplify parallel groups first → single equivalent R
3. Then add remaining series resistors
4. Use V = IR to find current and voltages

**Example:**
R₁ = 6 Ω in series with (R₂ = 4 Ω parallel with R₃ = 4 Ω)
- Parallel part: R₂₃ = 4×4/(4+4) = 2 Ω
- Total: R = 6 + 2 = 8 Ω

## Power in Combinations

**Series:** Device with highest resistance dissipates most power
**Parallel:** Device with lowest resistance dissipates most power

P = V²/R → for same V, smaller R gives more power
P = I²R → for same I, larger R gives more power

## Practical Applications

**Series:** Fuse (protection), voltage dividers, sensor circuits
**Parallel:** Household outlets, car electrical systems, battery banks
''',
        'questions': [
          {
            'question': 'In a series circuit, which quantity is the same through all components?',
            'options': ['Voltage', 'Power', 'Current', 'Resistance'],
            'correct': 2,
          },
          {
            'question': 'Two 6 Ω resistors in parallel give a total resistance of:',
            'options': ['12 Ω', '6 Ω', '3 Ω', '1 Ω'],
            'correct': 2,
          },
          {
            'question': 'In a parallel circuit, the voltage across each branch is:',
            'options': ['Different for each branch', 'The same', 'Zero', 'Depends on resistance'],
            'correct': 1,
          },
          {
            'question': 'Three 9 Ω resistors in series give a total resistance of:',
            'options': ['3 Ω', '9 Ω', '27 Ω', '18 Ω'],
            'correct': 2,
          },
          {
            'question': 'Household electrical appliances are connected in parallel because:',
            'options': ['It uses less current', 'Each gets full supply voltage independently', 'It reduces total resistance to zero', 'Series connection is more complex'],
            'correct': 1,
          },
        ]
      };

    case 'phy102_u5_5':
      return {
        'content': '''# Kirchhoff's Laws

## Why We Need Kirchhoff's Laws

Ohm's Law alone cannot solve complex circuits with multiple loops and branches. Kirchhoff's Laws (KCL and KVL) provide a systematic method for any circuit, no matter how complex.

## Kirchhoff's Current Law (KCL)

**Statement:**
The algebraic sum of all currents at any junction (node) in a circuit equals zero.

ΣI_in = ΣI_out

Or equivalently: ΣI = 0 at any node

**Physical basis:** Conservation of electric charge — charge cannot accumulate at a junction.

**Sign convention:**
- Currents entering a node: positive (+)
- Currents leaving a node: negative (−)

**Example:**
If I₁ = 5 A and I₂ = 3 A enter a node, and I₃ leaves:
I₃ = I₁ + I₂ = 8 A

## Kirchhoff's Voltage Law (KVL)

**Statement:**
The algebraic sum of all EMFs and potential drops around any closed loop in a circuit equals zero.

ΣEMF = ΣIR    (around any closed loop)

Or: ΣV = 0 around any closed loop

**Physical basis:** Conservation of energy — energy gained from EMF sources equals energy dissipated in resistors.

**Sign convention:**
- Traverse in direction of current through resistor → voltage DROP (negative)
- Traverse against current through resistor → voltage RISE (positive)
- Traverse from − to + through EMF source → voltage RISE (positive)
- Traverse from + to − through EMF source → voltage DROP (negative)

## Applying Kirchhoff's Laws — Method

**Step-by-step approach:**
1. Label all branch currents with assumed directions
2. Apply KCL at each independent node
3. Apply KVL around each independent loop
4. Solve the simultaneous equations
5. Negative answer means assumed direction was wrong

**Number of equations needed:**
- KCL equations: (nodes − 1)
- KVL equations: number of independent loops
- Total equations = number of unknown currents

## Worked Example

**Two-loop circuit with:**
- E₁ = 12 V (loop 1), E₂ = 6 V (loop 2)
- R₁ = 2 Ω, R₂ = 4 Ω, R₃ = 6 Ω

**At node A (KCL):** I₁ = I₂ + I₃

**Loop 1 (KVL):** 12 = 2I₁ + 4I₂
**Loop 2 (KVL):** 6 = 4I₂ − 6I₃

Solving simultaneously gives I₁, I₂, I₃.

## Applications

✓ Analysing bridge circuits (Wheatstone bridge)
✓ Finding unknown currents in multi-branch networks
✓ Circuit design and fault-finding
✓ Essential for electronics and electrical engineering

## Common Mistakes to Avoid

✗ Forgetting signs when traversing loops
✗ Not assigning a current to every branch
✗ Using more equations than unknowns
✗ Mixing up KCL and KVL — KCL is for nodes, KVL is for loops

## Summary

| Law | Based on | Applies to | Equation |
|---|---|---|---|
| KCL | Charge conservation | Nodes/junctions | ΣI = 0 |
| KVL | Energy conservation | Closed loops | ΣV = 0 |
''',
        'questions': [
          {
            'question': 'Kirchhoff\'s Current Law is based on conservation of:',
            'options': ['Energy', 'Momentum', 'Charge', 'Power'],
            'correct': 2,
          },
          {
            'question': 'KCL states that at any junction, the sum of currents is:',
            'options': ['Maximum', 'Minimum', 'Zero', 'Equal to the EMF'],
            'correct': 2,
          },
          {
            'question': 'Kirchhoff\'s Voltage Law is based on conservation of:',
            'options': ['Charge', 'Energy', 'Mass', 'Current'],
            'correct': 1,
          },
          {
            'question': 'KVL states that around any closed loop, the sum of voltages is:',
            'options': ['Equal to the supply voltage', 'Zero', 'Equal to total current', 'Maximum'],
            'correct': 1,
          },
          {
            'question': 'KCL applies to circuit:',
            'options': ['Loops', 'Nodes/junctions', 'Resistors only', 'Voltage sources only'],
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