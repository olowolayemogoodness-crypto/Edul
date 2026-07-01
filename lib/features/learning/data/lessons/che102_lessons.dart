// lib/features/learning/data/lessons/che102_lessons.dart

Map<String, dynamic> getCHE102LessonData(String lessonId) {
  switch (lessonId) {
    case 'che102_u1_1':
      return {
        'content': '''# Historical Background of Organic Chemistry

## The Pre-1800s Era: Vitalism Theory

Before the 19th century, scientists believed:
✗ Organic compounds required a "vital force"
✗ Impossible to synthesize organic compounds in laboratory
✗ Organic chemistry separate from inorganic chemistry
✗ Compounds from living organisms had special properties

**Why This Made Sense Then:**
- Most known organic compounds came from plants/animals
- No one had successfully made them synthetically
- Seemed like living things had special chemistry

## Friedrich Wöhler's Revolutionary Discovery (1828)

**The Breakthrough:**
- Synthesized **urea** from ammonium cyanate
- Both starting material and product were well-known compounds
- First time an organic compound was made WITHOUT living system
- Simple chemical transformation, no vital force needed

**Impact:**
✓ Disproved vitalism theory completely
✓ Showed organic compounds follow SAME chemical laws as inorganic
✓ Proved organic synthesis was possible
✓ Established organic chemistry as legitimate field

## Modern Definition of Organic Chemistry

**Current Definition:**
Organic chemistry = Chemistry of **carbon and its compounds**

**Why Carbon is Special:**
✓ Four valence electrons (sp³ hybridization)
✓ Forms four covalent bonds
✓ Can form single, double, triple bonds
✓ Can bond to itself (chain formation)
✓ Forms stable compounds with H, N, O, S, halogens
✓ Unique ability to form diverse structures

**Scope Today:**
- All carbon compounds studied
- EXCEPT: Carbon oxides (CO, CO₂), carbonates, cyanides (historical exceptions)

## Development Timeline

**1830s-1860s:**
- Discovery of functional groups
- Recognition of structural isomerism
- Development of nomenclature

**1919:**
- IUPAC nomenclature standardized
- Systematic naming system established

**Modern Era:**
- Mechanism-based understanding
- Electronic theory application
- Spectroscopic structure determination
- Synthetic strategies and synthesis
- Polymer and biomolecule chemistry

## Why Organic Chemistry Matters

✓ All living things are carbon-based
✓ Medicines, plastics, textiles, fuels all organic
✓ Understanding biological processes
✓ Drug design and development
✓ Materials science and nanotechnology''',
        'questions': [
          {
            'question': 'Vitalism theory claimed:',
            'options': ['Organic compounds need vital force', 'Organic synthesis impossible in lab', 'Living organisms have special chemistry', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Wöhler\'s 1828 achievement was:',
            'options': ['First organic synthesis', 'Synthesized urea', 'Disproved vitalism', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Carbon\'s special feature:',
            'options': ['Forms 4 bonds', 'Forms multiple bond types', 'Bonds to itself', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'IUPAC nomenclature standardized in:',
            'options': ['1800', '1919', '1928', '1950'],
            'correct': 1,
          },
          {
            'question': 'Modern organic chemistry includes:',
            'options': ['Mechanism understanding', 'Spectroscopy', 'Biomolecules', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u1_2':
      return {
        'content': '''# Purification Methods for Organic Compounds

## Crystallization: Cooling to Purity

**Process:**
1. Dissolve compound in hot solvent
2. Cool solution to lower temperature
3. Desired compound precipitates as crystals
4. Filter crystals and dry

**Best For:**
- Solid organic compounds
- Compounds with different solubility at different temperatures

**Advantages:**
✓ Simple and effective
✓ Removes impurities with different solubility
✓ Good purity achieved
✓ No complex equipment needed

**Disadvantages:**
✗ Cannot use for liquids
✗ Some compounds don't crystallize well

## Recrystallization: Ultra-High Purity

Repeated crystallization from different solvents:
- Purifies already-crystalline compound
- Removes soluble impurities
- Improves crystal quality
- Tests purity via melting point

**Melting Point as Purity Test:**
- Pure compound: Sharp melting point
- Impure compound: Broad range (depression)

## Distillation: Separation by Boiling Point

**Simple Distillation:**
- Separates liquids with different boiling points
- Heats mixture, vapors condense separately

**Fractional Distillation:**
- For complex mixtures with similar boiling points
- Used in petroleum refining
- Multiple separation stages

**Vacuum Distillation:**
- For heat-sensitive compounds
- Lower pressure lowers boiling point
- Prevents decomposition

**Advantages:**
✓ Separates volatiles from non-volatiles
✓ Based on well-understood principle
✓ Can achieve good separation

## Chromatography: Separation by Polarity

**Paper Chromatography:**
- Separates by differential solubility
- Rf values show relative mobility
- Simple, inexpensive

**Thin-Layer Chromatography (TLC):**
- Faster than paper chromatography
- Better resolution and sensitivity
- More common in labs

**Gas Chromatography (GC):**
- For volatile compounds
- Separation based on boiling point
- Quantitative analysis possible

**Liquid Chromatography (HPLC):**
- High performance
- Separates complex mixtures
- Good for non-volatile compounds

**Principle:**
All separate by differential adsorption/partition between mobile and stationary phases

## Solvent Extraction: Based on Solubility

**Liquid-Liquid Extraction:**
- Separate liquid phases based on polarity
- Compound dissolves in preferred solvent

**Solid-Liquid Extraction:**
- Dissolve solid in appropriate solvent
- Separate by filtration

**Advantages:**
✓ Simple process
✓ Based on solubility differences
✓ Can concentrate compounds''',
        'questions': [
          {
            'question': 'Crystallization works by:',
            'options': ['Temperature change', 'Solubility difference', 'Cooling solution', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Recrystallization achieves:',
            'options': ['Higher purity', 'Better crystals', 'Tests purity', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Distillation separates by:',
            'options': ['Boiling point', 'Volatility', 'Molecular weight', 'Both A and B'],
            'correct': 3,
          },
          {
            'question': 'TLC advantage over paper chromatography:',
            'options': ['Faster', 'Better resolution', 'More sensitive', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Melting point sharp indicates:',
            'options': ['High purity', 'Narrow range', 'Pure compound', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u1_3':
      return {
        'content': '''# Qualitative Analysis & Functional Group Tests

## Combustion Analysis: Determining Elements

**Process:**
Burn organic compound completely:
- Carbon → CO₂ (colorless gas)
- Hydrogen → H₂O (clear liquid condensate)
- Nitrogen → NOₓ (detected by color)
- Oxygen → Calculated by difference

**Result:**
- Percentage composition of C, H, N, O
- Used with molar mass to find molecular formula

## IR Spectroscopy: Identifying Functional Groups

**Key Absorption Ranges:**

**O-H Stretch:** 3200-3600 cm⁻¹ (broad if H-bonded)
- Alcohols, phenols, carboxylic acids

**N-H Stretch:** 3300-3500 cm⁻¹
- Primary amines, secondary amines, amides

**C≡N Stretch:** 2200-2260 cm⁻¹
- Nitriles (sharp, distinctive)

**C=O Stretch:** 1700-1750 cm⁻¹ (carbonyl frequency)
- Aldehydes, ketones, carboxylic acids, esters

**C=C Stretch:** 1600-1680 cm⁻¹
- Alkenes, aromatic compounds

**C-H Stretch:** 2800-3000 cm⁻¹
- All organic compounds

**Fingerprint Region:** 1300-1500 cm⁻¹
- Unique to each compound

## Specific Functional Group Tests

**Halogen Test (Silver Nitrate):**
- Halide + AgNO₃ → Silver halide precipitate
- White (AgCl), pale yellow (AgBr), yellow (AgI)

**Carbonyl Test (2,4-DNP):**
- Aldehyde or ketone + 2,4-DNP → Yellow/red precipitate
- Positive: Both aldehydes and ketones

**Aldehyde vs Ketone Distinction:**

**Tollens Test (Silver Mirror):**
- Aldehyde: Positive (silver mirror forms)
- Ketone: Negative

**Fehling Test (Brick Red):**
- Aldehyde: Positive (brick-red Cu₂O precipitate)
- Ketone: Negative

**Carboxylic Acid Test (Litmus):**
- Acid + Litmus → Blue litmus turns red
- Also: Neutralization with NaOH

**Amine Test (Hinsberg):**
- Primary, secondary, tertiary amines differentiated
- Color reactions with specific reagents

**Alkene Test (Br₂ in CCl₄):**
- Alkene + Br₂ → Decolorizes orange solution
- Changes to colorless (addition reaction)

**Alkyne Test (KMnO₄):**
- Alkyne + KMnO₄ → Decolorizes purple solution
- Both alkenes and alkynes positive

## Melting Point Determination

**Procedure:**
- Heat compound until it melts
- Record exact temperature range

**Interpretation:**
- Sharp melting point = Pure compound
- Broad range = Impure compound
- Mixture depression = Presence of impurity

**Uses:**
- Quality control
- Identification (compare with standards)
- Purity assessment

## Solubility Tests: Functional Group Clues

**Water Solubility:**
- Polar compounds: Alcohols, carboxylic acids, amines
- Nonpolar compounds: Hydrocarbons, esters

**Acid/Base Solubility:**
- Soluble in acid: Amines (form salts)
- Soluble in base: Carboxylic acids, phenols
- Indicates ionizable functional groups

**Organic Solvent Solubility:**
- Most organic compounds soluble in organic solvents
- Polarity matching principle

## Structure Elucidation Strategy

**Step 1:** Combustion analysis → Molecular formula
**Step 2:** Calculate degree of unsaturation
**Step 3:** IR spectroscopy → Functional groups
**Step 4:** NMR analysis → Structure confirmation
**Step 5:** Mass spectrometry → Molecular weight verification
**Step 6:** Compare with known compounds''',
        'questions': [
          {
            'question': 'Combustion test indicates:',
            'options': ['Carbon present', 'Hydrogen present', 'Nitrogen presence', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'IR carbonyl stretch appears at:',
            'options': ['1200-1300', '1700-1750', '2200-2260', '3200-3600'],
            'correct': 1,
          },
          {
            'question': 'Tollens test distinguishes:',
            'options': ['Aldehyde from ketone', 'Forms silver mirror', 'Aldehyde positive', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Br₂ in CCl₄ test for:',
            'options': ['Alkene present', 'Decolorizes solution', 'Addition reaction', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Sharp melting point means:',
            'options': ['High purity', 'Pure compound', 'No impurities', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u2_1':
      return {
        'content': '''# Aliphatic Hydrocarbons

## Alkanes: Saturated Hydrocarbons

**General Formula:** CₙH₂ₙ₊₂ (acyclic)

**Characteristics:**
✓ Only single C-C bonds (saturated)
✓ All bonds sigma (σ) bonds
✓ No pi (π) bonds
✓ Nonpolar, hydrophobic
✓ Generally unreactive

**Examples:**
- Methane (CH₄): Smallest alkane
- Ethane (C₂H₆)
- Propane (C₃H₈)
- Butane (C₄H₁₀)

**Homologous Series:**
- Each alkane differs by CH₂
- ~14 kcal/mol difference in stability
- Similar chemical properties
- Different physical properties

**Reactions:**
- Substitution (free radical, electrophilic)
- Combustion (burning)
- Cracking (breaking bonds at high temperature)

**Uses:**
✓ Fuels (gasoline, diesel, natural gas)
✓ Lubricants and oils
✓ Solvents

## Cycloalkanes: Ring Structures

**General Formula:** CₙH₂ₙ

**Types:**
- Cyclopropane (3-membered): Highly strained
- Cyclobutane (4-membered): Strained
- Cyclopentane (5-membered): Relatively unstable
- Cyclohexane (6-membered): Most stable

**Cyclohexane Conformations:**
- Chair conformation: Most stable
- Boat conformation: Less stable
- Ring flipping: Rapid interconversion

**Axial and Equatorial Positions:**
- Axial: Perpendicular to ring plane
- Equatorial: Along ring plane
- Equatorial more favorable (less steric hindrance)
- Bulky groups prefer equatorial

**Stability Order:** Cyclohexane > Cyclopentane > Cyclobutane > Cyclopropane

## Alkenes: Unsaturated with C=C

**General Formula:** CₙH₂ₙ

**Characteristics:**
✓ One C=C double bond
✓ One σ bond and one π bond
✓ Highly reactive (π bond reactivity)
✓ Addition reactions typical

**Examples:**
- Ethene (ethylene, C₂H₄)
- Propene (C₃H₆)
- Butene isomers (C₄H₈)

**Geometric Isomerism (E/Z):**
- Cis: Similar groups on same side
- Trans: Similar groups on opposite sides
- Restricted rotation around C=C
- Different properties and reactivity

**Reactions:**
- Addition: Br₂, H₂, HX, H₂O
- Oxidation: KMnO₄, O₃ (ozonolysis)
- Polymerization: Forms polymers

## Alkynes: Triple Bond C≡C

**General Formula:** CₙH₂ₙ₋₂

**Characteristics:**
✓ Triple bond (one σ, two π)
✓ Linear geometry
✓ Very reactive
✓ Multiple addition possible

**Examples:**
- Ethyne (acetylene, C₂H₂)
- Propyne (C₃H₄)
- Butyne isomers (C₄H₆)

**Terminal vs Internal:**
- Terminal: Triple bond at end
- Internal: Triple bond in middle
- Terminal alkynes have acidic H

**Reactions:**
- Multiple additions (Br₂, HX repeated)
- Hydration to carbonyl compounds
- Polymerization

**Uses:**
✓ Welding (acetylene)
✓ Synthesis of other compounds
✓ Industrial chemicals

**Comparison Summary:**

| Type | Formula | Bonds | Reactivity |
|------|---------|-------|-----------|
| Alkane | CₙH₂ₙ₊₂ | σ only | Low |
| Alkene | CₙH₂ₙ | σ + π | High |
| Alkyne | CₙH₂ₙ₋₂ | σ + 2π | Very High |''',
        'questions': [
          {
            'question': 'Alkane formula is:',
            'options': ['CₙH₂ₙ', 'CₙH₂ₙ₊₂', 'CₙH₂ₙ₋₂', 'CₙHₙ'],
            'correct': 1,
          },
          {
            'question': 'Cyclohexane most stable form:',
            'options': ['Boat', 'Chair', 'Planar', 'Linear'],
            'correct': 1,
          },
          {
            'question': 'Alkene contains:',
            'options': ['C=C double bond', 'One π bond', 'Unsaturated', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Geometric isomerism requires:',
            'options': ['Double bond', 'Different groups', 'Restricted rotation', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Alkyne reactivity due to:',
            'options': ['Triple bond', 'Two π bonds', 'High strain', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u2_2':
      return {
        'content': '''# Aromatic Hydrocarbons

## Benzene: The Aromatic Standard

**Structure:**
- Six-membered carbon ring (C₆H₆)
- Hexagonal planar structure
- All C-C bonds equivalent
- Bond length 1.40 Å (between single 1.54 Å and double 1.34 Å)

**Bonding:**
- Three σ bonds per carbon
- Delocalized π electrons above and below ring
- Resonance between two structures
- Unusual stability (aromaticity)

## Aromaticity: The Hückel Rule

**Requirements for Aromatic Compound:**
✓ Cyclic structure
✓ Planar geometry
✓ Continuous conjugation
✓ 4n+2 π electrons (n = integer)

**Examples:**
- Benzene (6 electrons): Aromatic ✓
- Cyclobutadiene (4 electrons): Antiaromatic ✗
- Naphthalene (10 electrons): Aromatic ✓

**Stability Source:**
- Extra stability from delocalization
- Unusual resistance to addition reactions
- Prefer substitution over addition

## Substituted Benzenes

**Monosubstituted (one group):**
- Toluene (methylbenzene, C₆H₅CH₃)
- Aniline (aminobenzene, C₆H₅NH₂)
- Phenol (hydroxybenzene, C₆H₅OH)

**Disubstituted (two groups):**
- **Ortho (1,2-)**: Adjacent positions
- **Meta (1,3-)**: One position between
- **Para (1,4-)**: Opposite positions

Example: Xylene isomers (dimethylbenzene)
- Ortho-xylene
- Meta-xylene
- Para-xylene

## Polycyclic Aromatics

**Naphthalene (C₁₀H₈):**
- Two fused benzene rings
- 10 π electrons (aromatic)
- Common in coal tar

**Anthracene (C₁₄H₁₀):**
- Three fused rings in line
- 14 π electrons (aromatic)
- Fluorescent

**Pyrene (C₁₆H₁₀):**
- Four fused rings
- Highly aromatic
- PAH (polycyclic aromatic hydrocarbon)

## Aromatic Reactions

**Substitution (Electrophilic):**
- Nitration: Produces NO₂ group
- Halogenation: Produces halide
- Friedel-Crafts: Adds alkyl/acyl groups
- Sulfonation: Adds SO₃H group

**Why Substitution?**
- Addition would destroy aromaticity
- Substitution preserves aromaticity
- Energetically favorable

**Reactivity and Directing Effects:**
- Electron-donating groups (OH, NH₂): Activate ring
- Electron-withdrawing groups (NO₂, CN): Deactivate
- Determines substitution positions

## Comparison: Alkene vs Benzene

| Property | Alkene | Benzene |
|----------|--------|---------|
| Unsaturation | π bonds present | π electrons |
| Addition | Readily | Resistant |
| Stability | Lower | Higher |
| Reactions | Addition | Substitution |
| Bromine test | Decolorizes | No decolorization |

**Key Difference:**
- Alkenes: Reactive, add Br₂
- Benzene: Stable, resists addition, substitutes instead

## Resonance in Benzene

- Two resonance structures
- Actual structure is hybrid
- Electrons delocalized
- More stable than single or double bonds
- Explains 1.40 Å bond length
- Explains aromaticity''',
        'questions': [
          {
            'question': 'Benzene C-C bond length:',
            'options': ['1.54 Å', '1.34 Å', '1.40 Å', 'Variable'],
            'correct': 2,
          },
          {
            'question': 'Hückel rule for aromaticity:',
            'options': ['4n π electrons', '4n+2 π electrons', '2n+1 π electrons', 'No pattern'],
            'correct': 1,
          },
          {
            'question': 'Benzene undergoes:',
            'options': ['Addition readily', 'Substitution reaction', 'Loses aromaticity', 'Decolorizes Br₂'],
            'correct': 1,
          },
          {
            'question': 'Ortho position means:',
            'options': ['Adjacent (1,2-)', 'One between (1,3-)', 'Opposite (1,4-)', 'Random'],
            'correct': 0,
          },
          {
            'question': 'Naphthalene contains:',
            'options': ['One benzene ring', 'Two fused rings', '10 π electrons', 'Both B and C'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u2_3':
      return {
        'content': '''# Structure Determination Techniques

## Molecular Formula from Analysis

**Combustion Analysis:**
1. Burn compound completely
2. Measure CO₂ and H₂O produced
3. Calculate C and H percentages
4. Find O by difference (if present)
5. Calculate empirical formula (lowest ratio)
6. Use molar mass to find molecular formula

**Degree of Unsaturation (DBE):**
Formula: DBE = (2C + 2 + N - H - X) / 2

Interpretation:
- DBE = 1: One double bond OR one ring
- DBE = 2: Two double bonds, one triple bond, or one ring + one double bond
- DBE = 4: Benzene ring
- Helps determine structure type

## Infrared (IR) Spectroscopy

**Key Functional Group Frequencies:**

**O-H Stretch:** 3200-3600 cm⁻¹
- Broad (H-bonded alcohols)
- Sharp (free phenol)

**N-H Stretch:** 3300-3500 cm⁻¹
- Primary amines: Two bands
- Secondary amines: One band

**C≡N (Nitrile):** 2200-2260 cm⁻¹
- Sharp, distinctive peak

**C=O (Carbonyl):** 1700-1750 cm⁻¹
- Aldehydes, ketones, esters
- Most important region
- Different compounds show variations

**C=C:** 1600-1680 cm⁻¹
- Alkenes, aromatic compounds
- Often weak or hidden

**Fingerprint Region:** 1300-1500 cm⁻¹
- Unique to each compound
- Complex patterns
- Used for identification

## Nuclear Magnetic Resonance (¹H NMR)

**Chemical Shift (δ):**
- Measured in ppm (parts per million)
- Indicates hydrogen environment
- Different groups at different positions

**Typical δ Values:**
- Alkyl H: 0.9-2.0 ppm
- Allylic H: 1.7-2.5 ppm
- Benzylic H: 2.3-2.5 ppm
- α to carbonyl: 2.1-2.5 ppm
- Alkene H: 5.0-7.0 ppm
- Aromatic H: 7.0-8.0 ppm

**Integration:**
- Area under peak = relative number of hydrogens
- Tells how many H at each position

**Splitting Patterns (n+1 Rule):**
- n = number of neighboring hydrogens
- Produces n+1 lines in spectrum
- Reveals connectivity

**Common Patterns:**
- Singlet (s): No neighbors
- Doublet (d): One neighbor
- Triplet (t): Two neighbors
- Quartet (q): Three neighbors

## ¹³C NMR and DEPT

**¹³C NMR:**
- Shows carbon skeleton
- Each carbon different position
- Number of signals = number of different carbons

**DEPT (Distortionless Enhancement by Polarization Transfer):**
- Distinguishes carbon types
- CH₃: Points up
- CH₂: Points down
- CH: Points up
- Quaternary C: Absent

## Mass Spectrometry (MS)

**Molecular Ion Peak [M]⁺:**
- Gives molecular weight
- Highest m/z value
- Helps confirm molecular formula

**Fragmentation Patterns:**
- Breaks into smaller fragments
- Shows structure clues
- Different bonds break differently

**Common Losses:**
- Loss of 18: H₂O (alcohol, carboxylic acid)
- Loss of 28: CO (carbonyl compound)
- Loss of 44: CO₂ (carboxylic acid)

**Base Peak:**
- Most intense fragment
- Most stable fragment ion
- Often most informative

## Structure Elucidation Strategy

**Step 1:** Determine molecular formula
**Step 2:** Calculate degree of unsaturation
**Step 3:** Analyze IR (functional groups)
**Step 4:** Analyze ¹H NMR (hydrogen positions)
**Step 5:** Analyze ¹³C NMR (carbon positions)
**Step 6:** Consider fragmentation pattern (MS)
**Step 7:** Propose structure
**Step 8:** Verify with spectroscopic data

**Example Approach:**
- C₄H₈O with one degree of unsaturation
- IR shows C=O at 1715 cm⁻¹ (carbonyl)
- NMR patterns show specific positions
- Structure could be butanone or butanal
- Tollens test distinguishes them''',
        'questions': [
          {
            'question': 'Empirical formula represents:',
            'options': ['Simplest ratio', 'Actual composition', 'Basis for molecular', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'IR C=O stretch at:',
            'options': ['1200-1300', '1700-1750', '2200-2260', '3200-3600'],
            'correct': 1,
          },
          {
            'question': 'NMR chemical shift indicates:',
            'options': ['Hydrogen environment', 'Number of H atoms', 'Connectivity', 'Both A and C'],
            'correct': 3,
          },
          {
            'question': 'Splitting pattern (n+1) from:',
            'options': ['Adjacent carbons', 'Neighboring hydrogens', 'Functional groups', 'Molecular weight'],
            'correct': 1,
          },
          {
            'question': 'MS base peak is:',
            'options': ['Molecular ion', 'Most stable fragment', 'Most intense peak', 'Both B and C'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u3_1':
      return {
        'content': '''# Electronic Theory in Organic Chemistry

## Atomic Orbitals and Bonding

**Orbital Types:**
- **s orbitals**: Spherical, low energy
- **p orbitals**: Dumbbell-shaped, higher energy
- **d orbitals**: Complex geometry, even higher
- **f orbitals**: Rare in organic chemistry

**Hybridization in Carbon:**

**sp³ Hybridization:**
- Four sigma bonds
- Tetrahedral geometry (109.5°)
- All single bonds (alkanes)
- Example: Methane (CH₄)

**sp² Hybridization:**
- Three sigma bonds, one pi bond
- Trigonal planar (120°)
- Double bonds (alkenes, benzene carbons)
- Example: Ethene (C₂H₄)

**sp Hybridization:**
- Two sigma bonds, two pi bonds
- Linear geometry (180°)
- Triple bonds (alkynes)
- Example: Ethyne (C₂H₂)

## Sigma and Pi Bonds

**Sigma Bonds (σ):**
- Head-on orbital overlap
- Strongest covalent bonds
- Allow free rotation
- Present in all bonds
- Examples: C-C, C-H, C-O

**Pi Bonds (π):**
- Side-by-side orbital overlap
- Weaker than sigma bonds
- Restrict rotation
- Only in double/triple bonds
- From unhybridized p orbitals
- Examples: C=C, C=O, C≡C

**Double Bond = σ + π**
**Triple Bond = σ + 2π**

## Electronegativity and Polarity

**Electronegativity:**
- Ability to attract electrons
- Increases across period
- Decreases down group
- Affects bond character

**Bond Polarity:**
- Nonpolar covalent: Similar electronegativity (C-C, C-H)
- Polar covalent: Different electronegativity (C-O, C-N)
- Ionic: Very different (M-Cl)

**Dipole Moments:**
- Measure of polarity
- Vector quantity (direction matters)
- Affects molecular properties
- Important for intermolecular forces

## Resonance Structures

**Definition:**
- Multiple Lewis structures for same compound
- Electrons delocalized across structure
- Reality is hybrid of structures

**Examples:**
- Benzene: Two resonance forms
- Carboxylate ion: Two equivalent forms
- Amide: Resonance stabilization

**Key Points:**
✓ Only electrons move (not atoms)
✓ Formal charges unchanged
✓ Actual structure is average
✓ Resonance increases stability

## Aromaticity and Hückel Rule

**Aromatic Compounds:**
- Special stability from delocalization
- Follow Hückel rule: 4n+2 π electrons
- Examples: Benzene (6), naphthalene (10)

**Antiaromatic:**
- Destabilized by electron delocalization
- 4n π electrons
- Example: Cyclobutadiene (4)

**Non-aromatic:**
- No delocalization benefit
- Normal reactivity

## Inductive and Resonance Effects

**Inductive Effect:**
- Through-space/bond electron withdrawal
- Electronegativity differences
- Decreases with distance
- Affects acidity/basicity

**Resonance Effect:**
- Through π system
- Electron donation/withdrawal
- Long range
- Overrides inductive in many cases

**Electron-Donating Groups:**
- -OH, -NH₂, -OR, -NR₂
- Stabilize positive charge
- Increase reactivity toward electrophiles

**Electron-Withdrawing Groups:**
- -NO₂, -CN, -C(=O)R, -X
- Stabilize negative charge
- Decrease reactivity toward electrophiles

## Molecular Orbital Theory

**HOMO (Highest Occupied MO):**
- Source of electrons
- Determines reactivity as nucleophile

**LUMO (Lowest Unoccupied MO):**
- Receptor of electrons
- Determines reactivity as electrophile

**Frontier Orbital Theory:**
- Interactions between HOMO and LUMO
- Predicts reaction outcomes
- Explains regio- and stereoselectivity''',
        'questions': [
          {
            'question': 'sp³ produces:',
            'options': ['Tetrahedral', '109.5° angle', 'Four σ bonds', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'sp² produces:',
            'options': ['Trigonal planar', '120° angles', 'σ + π bonds', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Pi bonds allow:',
            'options': ['Free rotation', 'Side-by-side overlap', 'Restricted rotation', 'Both B and C'],
            'correct': 3,
          },
          {
            'question': 'Resonance increases:',
            'options': ['Stability', 'Delocalization', 'Bond length avg', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Electron-withdrawing groups:',
            'options': ['Decrease reactivity', 'Stabilize negative charge', 'Inductive effect', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u3_2':
      return {
        'content': '''# Organic Functional Groups

## Hydroxyl Group (-OH)

**In Alcohols:**
- Can be primary (RCH₂OH), secondary (R₂CHOH), tertiary (R₃COH)
- Polar, form hydrogen bonds
- Soluble in water
- Undergo oxidation and esterification

**In Phenols (Ar-OH):**
- More acidic than alcohols (pKa ~10)
- Aromatic ring stabilizes negative charge
- Form salts with bases
- Different reactivity from alcohols

## Carbonyl Group (C=O)

**In Aldehydes (RCHO):**
- Carbon at terminal position
- Reactive to nucleophiles
- Easily oxidized to carboxylic acids
- React with Tollens, Fehling

**In Ketones (R₂CO):**
- Carbon at internal position
- Less reactive than aldehydes
- Not easily oxidized
- Negative Tollens, Fehling tests

**Carbonyl Reactivity:**
- Susceptible to nucleophilic addition
- C=O bond polarity drives reactions
- Varied reactivity based on substituents

## Carboxylic Acids (-COOH)

**Properties:**
- Weakly acidic (pKa ~4-5)
- Form hydrogen-bonded dimers
- Undergo esterification with alcohols
- Can be decarboxylated

**Reactions:**
- Acid-base: Form salts with bases
- Esterification: With alcohols (acid catalyst)
- Reduction: To primary alcohols
- Formation: From aldehydes, primary alcohols

## Esters (-COO-)

**Formation:**
- Carboxylic acid + Alcohol → Ester + Water
- Fischer esterification (acid-catalyzed)
- Reversible reaction

**Properties:**
- Pleasant odors (many esters)
- Lower boiling than parent acids
- Undergo hydrolysis (acid or base)
- Biological importance (fats, oils)

**Saponification:**
- Base hydrolysis of esters
- Forms soap (salt of carboxylic acid)
- Used in detergent production

## Ether (-O-)

**Properties:**
- Relatively unreactive
- Excellent solvents (diethyl ether)
- Nonpolar to moderately polar
- Some toxic (anesthetic properties)

**Reactions:**
- Cleavage with strong acids (HBr, HI)
- Few other typical reactions
- Useful as protective groups

## Amine (-N)

**Types:**
- Primary (RNH₂): One alkyl group
- Secondary (R₂NH): Two alkyl groups
- Tertiary (R₃N): Three alkyl groups

**Properties:**
- Nucleophilic
- Basic (accept proton)
- Form salts with acids
- Hydrogen bonding (primary, secondary)

**Biological Role:**
- Amino acids contain amino groups
- Neurotransmitters are amines
- DNA bases contain amino groups

## Amide (-CONH-)

**Structure:**
- Carbonyl + amine (C=O-N)
- Resonance stabilized
- Rigid C-N bond (partial double bond)

**Properties:**
- Secondary structure in proteins (peptide bonds)
- Lower reactivity than esters
- Undergo hydrolysis slowly
- More stable than esters

**Peptide Bonds:**
- Link amino acids in proteins
- Between carboxyl of one AA and amino of next
- Rigid, planar structure

## Halide (-X)

**Halogens:** F, Cl, Br, I

**Effects:**
- Increase polarity (C-X polar)
- Increase molecular weight
- Undergo nucleophilic substitution (Cl, Br, I)
- Affect adjacent hydrogen acidity

**Reactivity Order:** F > Cl > Br > I (for bond strength)
**Leaving Group Ability:** I > Br > Cl > F (opposite!)

## Other Important Groups

**Nitrile (-C≡N):**
- Triple bond to nitrogen
- Polar compounds
- Hydrolyzed to carboxylic acids
- Can be reduced to amines

**Nitro (-NO₂):**
- Strong electron-withdrawing
- Explosive in some compounds
- Reduced to amines
- Increases acidity of adjacent H

**Thiol (-SH):**
- Sulfur analog of alcohol
- More acidic than alcohols
- Form disulfide bonds (proteins)
- Reducing agent

**Sulfide (-S-):**
- Sulfur analog of ether
- Can be oxidized to sulfoxide or sulfone
- Present in some amino acids

**Disulfide (-S-S-):**
- Covalent cross-link in proteins
- Important for protein structure
- Can be reduced to thiols''',
        'questions': [
          {
            'question': 'Primary alcohols oxidize to:',
            'options': ['Ketones', 'Aldehydes', 'Carboxylic acids', 'Both B and C'],
            'correct': 3,
          },
          {
            'question': 'Carboxylic acids pKa ~:',
            'options': ['2', '4-5', '7', '10'],
            'correct': 1,
          },
          {
            'question': 'Esters formed by:',
            'options': ['Acid + Alcohol', 'Fischer esterification', 'Acid-catalyzed', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Amides in proteins are:',
            'options': ['Peptide bonds', 'Link amino acids', 'Rigid structure', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Disulfide bonds (-S-S-):',
            'options': ['In proteins', 'Cross-link structure', 'Reducible', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'che102_u3_3':
      return {
        'content': '''# Periodicity & Intermolecular Forces

## Periodic Table Organization

**Structure:**
- 118 known elements
- Arranged by atomic number
- 7 periods (rows)
- 8 main groups, 18 total (IUPAC 1-18 numbering)

**Block Classification:**
- **s block**: Groups 1-2 (alkali, alkaline earth)
- **p block**: Groups 13-18 (main group nonmetals)
- **d block**: Groups 3-12 (transition metals)
- **f block**: Lanthanides, Actinides

## Periodic Trends

**Atomic Size:**
- Decreases across period (left to right)
- Increases down group (top to bottom)
- Ionic radius affected by charge

**Ionization Energy:**
- Increases across period
- Decreases down group
- Gap after filled shells (big jump)

**Electronegativity:**
- Increases across period
- Decreases down group
- F highest (4.0), alkali metals lowest

**Electron Affinity:**
- Generally increases across period
- Halogens highest (want one more electron)
- Noble gases very low (don't want electrons)

## Valence Electrons

**Definition:** Electrons in outermost shell

**Importance:**
- Determine chemical properties
- Determine bonding
- Group number = valence electrons (main groups)
- All in group share similar chemistry

## Metal, Nonmetal, Metalloid Classification

**Metals:**
- Ductile and malleable
- Conduct electricity (valence electrons mobile)
- Lustrous
- Lose electrons (form cations)
- Examples: Fe, Cu, Al

**Nonmetals:**
- Brittle
- Insulators (mostly)
- Varied properties
- Gain electrons (form anions)
- Examples: O, N, Cl

**Metalloids:**
- Intermediate properties
- Semiconductors (conduct partially)
- Examples: Si, As, Sb

## Hydrogen Bonding

**What is It:**
- Dipole-dipole between H and N, O, or F
- H is bonded to highly electronegative atom
- Partial positive H attracts lone pair

**Properties:**
- Strongest intermolecular force (except ionic/covalent)
- Accounts for unusual water properties
- Affects boiling points significantly

**Examples:**
- Water (H₂O): Extensive H-bonding
- Alcohols (R-OH): H-bonding
- DNA base pairing: H-bonding

## Other Intermolecular Forces

**Dipole-Dipole:**
- Between polar molecules
- Weaker than hydrogen bonds
- Depend on molecular polarity

**London Dispersion:**
- Weakest intermolecular force
- Between all molecules (especially nonpolar)
- Increase with molar mass
- Increase with surface area

**Ionic Bonds:**
- Electrostatic between cations/anions
- Strongest intermolecular force
- High melting points
- Conduct when molten/dissolved

## Solid Types and Their Properties

**Ionic Solids:**
- Hard and brittle
- High melting points
- Conduct electricity when molten
- Often soluble in polar solvents
- Example: NaCl

**Molecular Solids:**
- Held by weak intermolecular forces
- Soft, low melting points
- Often volatile
- Examples: Ice, dry ice, naphthalene

**Covalent Network Solids:**
- Atoms bonded throughout structure
- Extremely hard
- Very high melting points
- Example: Diamond, SiO₂

**Metallic Solids:**
- Metal atoms in lattice
- Delocalized valence electrons
- Conduct electricity
- Malleable and ductile
- Examples: Fe, Cu, Al

## Factors Affecting Melting/Boiling Points

**Intermolecular Force Strength:**
- Stronger forces → higher melting/boiling points
- Ionic > Hydrogen bonding > Dipole-dipole > Dispersion

**Molar Mass:**
- For same type of force, higher mass → higher boiling point
- Dispersion forces correlate with molecular weight

**Molecular Shape:**
- Surface area affects interactions
- Branched vs straight chain
- Compact vs linear

**Hydrogen Bonding:**
- Dramatically increases boiling point
- OH, NH, HF groups
- Water exceptional due to extensive H-bonding

**Polarity:**
- Polar molecules higher boiling point
- Dipole-dipole interactions
- Affects solubility patterns''',
        'questions': [
          {
            'question': 'Atomic size trend:',
            'options': ['Increases across period', 'Increases down group', 'Random', 'Constant'],
            'correct': 1,
          },
          {
            'question': 'Electronegativity increases:',
            'options': ['Across period', 'Down group', 'Both directions', 'No trend'],
            'correct': 0,
          },
          {
            'question': 'Halogens most reactive because:',
            'options': ['Want one more electron', 'Highest electron affinity', 'Need to complete shell', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Hydrogen bonding requires:',
            'options': ['H bonded to N, O, or F', 'Partial charge separation', 'Lone pair on acceptor', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Boiling point highest for:',
            'options': ['Strongest intermolecular forces', 'Higher molar mass', 'Hydrogen bonding present', 'All contribute'],
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