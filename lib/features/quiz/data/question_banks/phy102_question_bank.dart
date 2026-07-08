// lib/features/quiz/data/question_banks/phy102_question_bank.dart
//
// Additional PHY102 (Physics II) quiz questions, sourced from three
// PDFs, ADDED ON TOP OF the existing questions in phy102_lessons.dart
// (append, not replace) -- see topic_question_source.dart for how
// sources merge:
//
//   1. A 175-question Current Electricity bank (35 Q x 5 subtopics)
//   2. A 100-question compendium covering Electrostatics + Current
//      Electricity, classified and split by topic
//   3. A 654-question Electromagnetism & Modern Physics bank covering
//      Magnetism, EM Waves, and Applied Physics (Motors/Generators/
//      Transformers, Modern Physics) -- only the 600 standard (non-
//      diagram) questions were kept; 54 diagram-based questions were
//      excluded (auto-generated diagrams weren't polished enough to
//      ship, same call made for BIO102's diagram questions). Source
//      PDF's answer key was heavily skewed (62% option B) -- fixed by
//      shuffling each question's options and recomputing the correct
//      index; content/correctness unaffected.
//
// phy102_u1_1 and phy102_u1_2 add to the existing Electrostatics
// lessons. phy102_u5_1 through phy102_u5_5 are BRAND NEW lessons
// (Current Electricity subtopics). phy102_u2_1, phy102_u2_2,
// phy102_u2_3, phy102_u3_1, phy102_u3_2, phy102_u3_3 (added from
// source #3 above) cover Magnetism, EM Waves, and Applied Physics --
// see subjects_data.dart for unit placement.

List<Map<String, dynamic>> getPHY102ExtraQuestions(String lessonId) {
  switch (lessonId) {
    case 'phy102_u1_1': // Charge and Coulomb's Law
      return [
        {
          'question': 'Two charges +2.0 uC and +3.0 uC are separated by 30.0 cm in a vacuum. What is the electrostatic force between them?',
          'options': ['0.3 N', '0.6 N', '0.9 N', '1.2 N'],
          'correct': 1,
        },
        {
          'question': 'How many electrons must be added to a neutral body to give it a net negative charge of 1.0 uC?',
          'options': ['6.25 x 10^9', '6.25 x 10^12', '6.25 x 10^15', '6.25 x 10^18'],
          'correct': 1,
        },
        {
          'question': 'If the distance between two point charges is doubled, the electrostatic force between them changes by a factor of:',
          'options': ['2', '4', '1/2', '1/4'],
          'correct': 3,
        },
        {
          'question': 'When a soap bubble is given a negative charge, its radius:',
          'options': ['Increases', 'Decreases', 'Remains unchanged', 'Becomes zero'],
          'correct': 0,
        },
        {
          'question': 'When two point charges are placed in a dielectric medium of dielectric constant K, the electrostatic force between them, compared to vacuum, is:',
          'options': ['Multiplied by K', 'Divided by K', 'Unchanged', 'Reduced to zero'],
          'correct': 1,
        },
        {
          'question': 'Two charges +1.0 uC and -3.0 uC are placed at a separation of 10.0 cm in a vacuum. The electrostatic force between them is:',
          'options': ['Attractive', 'Repulsive', 'Zero', 'Alternating'],
          'correct': 0,
        },
        {
          'question': 'The generation of static electricity by rubbing two different materials together is known as:',
          'options': ['Triboelectric charging', 'Conductive charging', 'Inductive charging', 'Dielectric polarization'],
          'correct': 0,
        },
        {
          'question': 'If a third positive charge is brought near two interacting positive charges, the electrostatic force between the original two charges:',
          'options': ['Increases', 'Decreases', 'Remains unchanged', 'Becomes zero'],
          'correct': 2,
        },
        {
          'question': 'The total net charge of an isolated physical system:',
          'options': ['Can increase over time', 'Can decrease over time', 'Remains constant', 'Fluctuates depending on the temperature'],
          'correct': 2,
        },
      ];

    case 'phy102_u1_2': // Electric Field and Potential
      return [
        {
          'question': 'What is the electric potential at a distance of 9.0 cm from a +1.0 uC point charge?',
          'options': ['1.0 x 10^4 V', '1.0 x 10^5 V', '1.0 x 10^6 V', '1.0 x 10^7 V'],
          'correct': 1,
        },
        {
          'question': 'A short electric dipole has a moment p = 1.0 x 10^-9 C·m. What is the electric field strength at a distance of 10.0 cm along its equatorial line?',
          'options': ['900 N/C', '4500 N/C', '9000 N/C', '18,000 N/C'],
          'correct': 2,
        },
        {
          'question': 'Which of the following physical quantities is a scalar field?',
          'options': ['Electric Field Intensity', 'Electric Potential', 'Electric Dipole Moment', 'Current Density'],
          'correct': 1,
        },
        {
          'question': 'An electric dipole of moment p is placed in a uniform electric field E. The dipole is in stable equilibrium when the angle between p and E is:',
          'options': ['0 degrees', '90 degrees', '180 degrees', '270 degrees'],
          'correct': 0,
        },
        {
          'question': 'What happens to the electric field between the plates of an isolated parallel-plate capacitor when a dielectric material of dielectric constant K is introduced?',
          'options': ['It increases by a factor of K.', 'It decreases by a factor of K.', 'It remains unchanged.', 'It becomes zero.'],
          'correct': 1,
        },
        {
          'question': 'A hollow conducting sphere of radius R is charged to a potential V. The electric potential at any point inside the sphere is:',
          'options': ['Zero', 'V', 'V/2', '2V'],
          'correct': 1,
        },
        {
          'question': 'The electric field at a point along the perpendicular bisector (equatorial point) of an electric dipole is:',
          'options': ['Parallel to the dipole moment vector p.', 'Anti-parallel to the dipole moment vector p.', 'Perpendicular to the dipole moment vector p.', 'Zero.'],
          'correct': 1,
        },
        {
          'question': 'The electric potential at any point on the equatorial plane of an electric dipole is:',
          'options': ['Constant and non-zero', 'Zero', 'Inversely proportional to r', 'Directly proportional to r^2'],
          'correct': 1,
        },
        {
          'question': 'An electric charge q is placed at the center of a sphere of radius R. If the radius is doubled, the net electric flux passing through the surface:',
          'options': ['Doubles', 'Halves', 'Remains unchanged', 'Becomes four times larger'],
          'correct': 2,
        },
        {
          'question': 'Three identical capacitors, each of capacitance 3.0 uF, are connected in parallel. What is their equivalent capacitance?',
          'options': ['1.0 uF', '3.0 uF', '6.0 uF', '9.0 uF'],
          'correct': 3,
        },
        {
          'question': 'The electric potential is given by V(x) = 5x^2 - 10x V. What is the electric field at x = 2.0 m?',
          'options': ['-10.0 N/C', '10.0 N/C', '-20.0 N/C', '20.0 N/C'],
          'correct': 0,
        },
        {
          'question': 'The electric field intensity at a perpendicular distance r from an infinitely long straight charged wire is proportional to:',
          'options': ['r', '1/r', '1/r^2', '1/r^3'],
          'correct': 1,
        },
        {
          'question': 'A point charge q is placed at one of the corners of a cube. What is the electric flux passing through one of the three faces adjacent to the charge?',
          'options': ['q/(6ε0)', 'q/(24ε0)', 'Zero', 'q/(8ε0)'],
          'correct': 2,
        },
        {
          'question': 'Two point charges +2.0 uC and -2.0 uC are separated by 10.0 cm. What is the electric potential at the midpoint of the line joining them?',
          'options': ['3.6 x 10^5 V', '-3.6 x 10^5 V', 'Zero', '1.8 x 10^5 V'],
          'correct': 2,
        },
        {
          'question': 'If a charge is shifted from an equipotential surface of potential V1 to another equipotential surface of potential V2, the net work done is:',
          'options': ['q(V2 - V1)', 'q(V1 - V2)', 'Zero', 'Infinite'],
          'correct': 0,
        },
        {
          'question': 'What is the SI unit of electric dipole moment?',
          'options': ['C/m', 'C·m', 'C·m^2', 'N/C'],
          'correct': 1,
        },
        {
          'question': 'The electric field intensity inside a charged solid conducting sphere at electrostatic equilibrium is:',
          'options': ['Constant and non-zero', 'Zero', 'Inversely proportional to r^2', 'Directly proportional to r'],
          'correct': 1,
        },
        {
          'question': 'An electric dipole is placed inside a closed spherical surface. The net electric flux passing through the surface is:',
          'options': ['q/ε0', '-q/ε0', 'Zero', '2q/ε0'],
          'correct': 2,
        },
        {
          'question': 'The electric field intensity at a point along the axis of a short electric dipole is E. If the distance from the dipole is doubled, the electric field becomes:',
          'options': ['E/2', 'E/4', 'E/8', 'E/16'],
          'correct': 2,
        },
        {
          'question': 'The electric field intensity at a distance r from an isolated point charge is proportional to:',
          'options': ['r', '1/r', '1/r^2', '1/r^3'],
          'correct': 2,
        },
        {
          'question': 'An electric dipole consists of charges +q and -q separated by a distance 2a. The electric field along the axis of this dipole at a distance r (r much greater than a) is proportional to:',
          'options': ['1/r', '1/r^2', '1/r^3', '1/r^4'],
          'correct': 2,
        },
        {
          'question': 'According to Gauss\'s Law, the net electric flux passing through a closed surface containing no net charge is:',
          'options': ['Infinite', 'Dependent on the shape of the surface', 'Zero', 'Equal to ε0'],
          'correct': 2,
        },
        {
          'question': 'A point charge q is placed at the center of a hemispherical surface. The electric flux passing through the curved surface of the hemisphere is:',
          'options': ['q/ε0', 'q/2ε0', 'q/4ε0', 'Zero'],
          'correct': 1,
        },
        {
          'question': 'When three identical capacitors, each of capacitance C, are connected in series, their equivalent capacitance is:',
          'options': ['3C', 'C', 'C/3', 'C/9'],
          'correct': 2,
        },
        {
          'question': 'The electrostatic potential energy of a system of two point charges, q1 and q2, separated by a distance r, is:',
          'options': ['kq1q2/r', 'kq1q2/r^2', 'kq1^2q2^2/r', 'kq1q2/2r'],
          'correct': 0,
        },
        {
          'question': 'The electric potential due to a short electric dipole at a point along its equatorial line is:',
          'options': ['Inversely proportional to r^2', 'Zero', 'Constant and non-zero', 'Directly proportional to r'],
          'correct': 1,
        },
        {
          'question': 'The electric field at a distance r from an infinitely large, thin non-conducting sheet carrying a uniform surface charge density σ is:',
          'options': ['σ/ε0', 'σ/2ε0', '2σ/ε0', 'Independent of r'],
          'correct': 1,
        },
        {
          'question': 'An electric dipole of moment p is placed in a uniform electric field E. The work done in rotating the dipole from the stable equilibrium position (0 degrees) to the unstable equilibrium position (180 degrees) is:',
          'options': ['pE', '2pE', 'Zero', '-2pE'],
          'correct': 1,
        },
        {
          'question': 'A capacitor of capacitance C is charged to a potential difference V. The energy stored in the capacitor is given by:',
          'options': ['(1/2)CV', '(1/2)CV^2', '(1/2)C^2V', 'CV^2'],
          'correct': 1,
        },
        {
          'question': 'When a positive test charge is released from rest in a uniform electric field, it moves toward a region of:',
          'options': ['Higher electric potential', 'Lower electric potential', 'Equal electric potential', 'Zero electric potential'],
          'correct': 1,
        },
        {
          'question': 'The potential at a point P due to a charge q is V. If the charge is doubled and the distance to the point is halved, the new potential at point P is:',
          'options': ['V', '2V', '4V', 'V/2'],
          'correct': 2,
        },
        {
          'question': 'What is the net charge on a charged capacitor?',
          'options': ['Q', '2Q', 'Zero', 'Q/2'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is true for electrostatic field lines?',
          'options': ['They always form closed loops.', 'They start on positive charges and end on negative charges.', 'They can intersect each other.', 'They are parallel to equipotential surfaces.'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is the SI unit of electric potential?',
          'options': ['Joule', 'Volt', 'Ampere', 'Ohm'],
          'correct': 1,
        },
        {
          'question': 'The self-energy of a thin conducting shell of radius R carrying a total charge Q is:',
          'options': ['kQ^2/2R', 'kQ^2/R', '3kQ^2/5R', '2kQ^2/3R'],
          'correct': 0,
        },
        {
          'question': 'The work done in rotating an electric dipole of moment p through an angle of 360 degrees from its starting position in a uniform electric field E is:',
          'options': ['pE', '2pE', 'Zero', '4pE'],
          'correct': 2,
        },
        {
          'question': 'The electric field at a point P just outside the surface of a charged conductor is:',
          'options': ['Zero', 'σ/ε0 and perpendicular to the surface', 'σ/2ε0 and parallel to the surface', 'σ/ε0 and parallel to the surface'],
          'correct': 1,
        },
        {
          'question': 'An electric dipole of moment p = 2.0 x 10^-9 C·m is placed in an electric field of E = 3.0 x 10^4 N/C. The torque acting on the dipole when it is aligned parallel to the field (0 degrees) is:',
          'options': ['6.0 x 10^-5 N·m', '-6.0 x 10^-5 N·m', 'Zero', '3.0 x 10^-5 N·m'],
          'correct': 2,
        },
        {
          'question': 'The expression E = -grad(V) relates the electric field to the:',
          'options': ['Charge density', 'Potential gradient', 'Permittivity', 'Flux density'],
          'correct': 1,
        },
        {
          'question': 'The work done per unit charge in moving a charge between two points in an electric field is the definition of:',
          'options': ['Electric force', 'Potential difference', 'Capacitance', 'Electric flux'],
          'correct': 1,
        },
        {
          'question': 'Electric field lines are always oriented relative to equipotential surfaces at an angle of:',
          'options': ['0 degrees', '45 degrees', '90 degrees', '180 degrees'],
          'correct': 2,
        },
        {
          'question': 'What is the net translational force acting on an electric dipole placed in a uniform external electric field?',
          'options': ['qE', '2qE', 'Zero', 'pE'],
          'correct': 2,
        },
        {
          'question': 'The self-energy of a uniformly charged solid non-conducting sphere of radius R and total charge Q is:',
          'options': ['kQ^2/2R', '3kQ^2/5R', 'kQ^2/R', '2kQ^2/3R'],
          'correct': 1,
        },
        {
          'question': 'The ratio of the permittivity of a medium to the permittivity of free space is called the:',
          'options': ['Absolute permittivity', 'Relative permittivity (Dielectric constant)', 'Conductive capacity', 'Polarizability'],
          'correct': 1,
        },
        {
          'question': 'The total electric potential at a point due to a group of point charges is the:',
          'options': ['Vector sum of individual potentials', 'Algebraic sum of individual potentials', 'Product of individual potentials', 'Geometric mean of individual potentials'],
          'correct': 1,
        },
        {
          'question': 'The torque experienced by an electric dipole in a uniform electric field is zero when the angle between p and E is:',
          'options': ['0 degrees or 180 degrees', '90 degrees', '270 degrees', '45 degrees'],
          'correct': 0,
        },
        {
          'question': 'Equipotential surfaces:',
          'options': ['Can intersect each other at any angle.', 'Can intersect each other only at 90 degrees.', 'Never intersect each other.', 'Are always flat sheets.'],
          'correct': 2,
        },
      ];

    case 'phy102_u5_1': // Electric Current
      return [
        {
          'question': 'Electric current is defined as the rate of flow of:',
          'options': ['electric power', 'electric field', 'electric charge', 'electric potential'],
          'correct': 2,
        },
        {
          'question': 'The SI unit of electric current is the:',
          'options': ['coulomb', 'volt', 'watt', 'ampere'],
          'correct': 3,
        },
        {
          'question': 'One ampere is equivalent to a flow of charge of:',
          'options': ['1 joule per second', '1 coulomb per second', '1 watt per second', '1 coulomb per volt'],
          'correct': 1,
        },
        {
          'question': 'Conventional current is taken to flow in the direction of motion of:',
          'options': ['protons only inside the wire', 'neutrons', 'positive charge', 'electrons'],
          'correct': 2,
        },
        {
          'question': 'In a metallic conductor, the actual charge carriers are:',
          'options': ['positive ions', 'free electrons', 'protons', 'neutrons'],
          'correct': 1,
        },
        {
          'question': 'Since electrons are negative, the direction of electron flow is:',
          'options': ['perpendicular to conventional current', 'undefined', 'opposite to conventional current', 'the same as conventional current'],
          'correct': 2,
        },
        {
          'question': 'An ammeter is connected in a circuit:',
          'options': ['in parallel', 'across the battery terminals only', 'in series and parallel simultaneously', 'in series'],
          'correct': 3,
        },
        {
          'question': 'An ideal ammeter has:',
          'options': ['negative resistance', 'zero (very low) internal resistance', 'the same resistance as the circuit', 'infinite resistance'],
          'correct': 1,
        },
        {
          'question': 'A material that allows current to flow easily is called a:',
          'options': ['insulator', 'semiconductor', 'conductor', 'dielectric'],
          'correct': 2,
        },
        {
          'question': 'A material that strongly resists the flow of current is called a:',
          'options': ['conductor', 'semiconductor', 'superconductor', 'insulator'],
          'correct': 3,
        },
        {
          'question': 'The elementary (smallest) unit of electric charge, carried by one electron, is approximately:',
          'options': ['3.0 x 10^8 C', '1.6 x 10^-19 C', '1.6 x 10^-16 C', '9.1 x 10^-31 C'],
          'correct': 1,
        },
        {
          'question': 'In a series circuit, the current at every point is:',
          'options': ['dependent only on the last resistor', 'different at each resistor', 'zero at the midpoint', 'the same throughout'],
          'correct': 3,
        },
        {
          'question': 'Drift velocity refers to the:',
          'options': ['instantaneous random thermal speed of electrons', 'speed at which the electric field itself propagates', 'average velocity of free electrons due to an applied electric field', 'speed of light in the conductor'],
          'correct': 2,
        },
        {
          'question': 'Without an applied electric field, free electrons in a conductor move:',
          'options': ['directly toward the positive terminal', 'at the speed of light', 'randomly with no net current', 'directly toward the negative terminal'],
          'correct': 2,
        },
        {
          'question': 'Current flows in a circuit only when there is a:',
          'options': ['open switch', 'a resistor of zero value', 'insulator connected across the battery', 'closed conducting path and a potential difference'],
          'correct': 3,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 4 A for 4 s?',
          'options': ['20 C', '16 C', '18 C', '14 C'],
          'correct': 1,
        },
        {
          'question': 'If a charge of 17 C flows through a wire in 1 s, what is the current?',
          'options': ['17 A', '18 A', '34 A', '16 A'],
          'correct': 0,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 1 A for 2 s?',
          'options': ['2 C', '0.5 C', '4 C', '6 C'],
          'correct': 0,
        },
        {
          'question': 'If a charge of 6 C flows through a wire in 8 s, what is the current?',
          'options': ['0.75 A', '1.75 A', '1.5 A', '0.1 A'],
          'correct': 0,
        },
        {
          'question': 'If a charge of 7 C flows through a wire in 4 s, what is the current?',
          'options': ['3.75 A', '0.75 A', '2.75 A', '1.75 A'],
          'correct': 3,
        },
        {
          'question': 'What is the total charge carried by 5 x 10^18 electrons? (charge of an electron = 1.6 x 10^-19 C)',
          'options': ['0.4 C', '1.6 C', '0.8 C', '0.96 C'],
          'correct': 2,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 1.5 A for 6 s?',
          'options': ['4.5 C', '9 C', '7 C', '13 C'],
          'correct': 1,
        },
        {
          'question': 'What is the total charge carried by 2 x 10^18 electrons? (charge of an electron = 1.6 x 10^-19 C)',
          'options': ['0.48 C', '0.64 C', '0.16 C', '0.32 C'],
          'correct': 3,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 2.5 A for 3 s?',
          'options': ['7.5 C', '5.5 C', '9.5 C', '11.5 C'],
          'correct': 0,
        },
        {
          'question': 'If a charge of 11 C flows through a wire in 1 s, what is the current?',
          'options': ['13 A', '12 A', '11 A', '22 A'],
          'correct': 2,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 4 A for 5 s?',
          'options': ['10 C', '24 C', '18 C', '20 C'],
          'correct': 3,
        },
        {
          'question': 'If a charge of 30 C flows through a wire in 2 s, what is the current?',
          'options': ['17 A', '30 A', '14 A', '15 A'],
          'correct': 3,
        },
        {
          'question': 'What is the total charge carried by 1 x 10^18 electrons? (charge of an electron = 1.6 x 10^-19 C)',
          'options': ['0.32 C', '0.08 C', '0 C', '0.16 C'],
          'correct': 3,
        },
        {
          'question': 'If a charge of 18 C flows through a wire in 4 s, what is the current?',
          'options': ['3.5 A', '5.5 A', '9 A', '4.5 A'],
          'correct': 3,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 5 A for 4 s?',
          'options': ['20 C', '18 C', '10 C', '24 C'],
          'correct': 0,
        },
        {
          'question': 'What is the total charge carried by 3 x 10^18 electrons? (charge of an electron = 1.6 x 10^-19 C)',
          'options': ['0.64 C', '0.32 C', '0.48 C', '0.24 C'],
          'correct': 2,
        },
        {
          'question': 'If a charge of 36 C flows through a wire in 8 s, what is the current?',
          'options': ['5.5 A', '9 A', '4.5 A', '3.5 A'],
          'correct': 2,
        },
        {
          'question': 'If a charge of 19 C flows through a wire in 5 s, what is the current?',
          'options': ['3.8 A', '7.6 A', '2.8 A', '4.8 A'],
          'correct': 0,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 1 A for 3 s?',
          'options': ['1 C', '3 C', '1.5 C', '7 C'],
          'correct': 1,
        },
        {
          'question': 'How much charge flows through a conductor carrying a current of 0.5 A for 5 s?',
          'options': ['4.5 C', '1.25 C', '0.5 C', '2.5 C'],
          'correct': 3,
        },
        {
          'question': 'In a copper conductor with cross-sectional area 1.0 x 10^-6 m^2, carrying a current of 2.0 A and a charge density n = 8.5 x 10^28 m^-3, what is the drift velocity of the electrons?',
          'options': ['1.47 x 10^-4 m/s', '2.94 x 10^-4 m/s', '4.41 x 10^-4 m/s', '5.88 x 10^-4 m/s'],
          'correct': 0,
        },
        {
          'question': 'The drift velocity of conduction electrons in a metal is typically on the order of:',
          'options': ['10^8 m/s', '10^6 m/s', '10^2 m/s', '10^-4 m/s'],
          'correct': 3,
        },
        {
          'question': 'The current density in a wire is defined as:',
          'options': ['Current per unit volume', 'Current per unit length', 'Current per unit cross-sectional area', 'Charge per unit area'],
          'correct': 2,
        },
        {
          'question': 'The average time interval between successive collisions of conduction electrons in a metal is called the:',
          'options': ['Collision time', 'Relaxation time', 'Drift time', 'Transition time'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is the fundamental SI unit for electric current?',
          'options': ['Volt', 'Ohm', 'Ampere', 'Coulomb'],
          'correct': 2,
        },
        {
          'question': 'The drift velocity of conduction electrons is directly proportional to the:',
          'options': ['Length of the conductor', 'Applied electric field strength', 'Cross-sectional area', 'Mass of the electron'],
          'correct': 1,
        },
        {
          'question': 'The random thermal speed of conduction electrons in a metal is:',
          'options': ['Much smaller than the drift velocity', 'Equal to the drift velocity', 'Much larger than the drift velocity', 'Zero at room temperature'],
          'correct': 2,
        },
        {
          'question': 'In a solid metallic conductor, the charge carriers are:',
          'options': ['Positive ions', 'Protons', 'Conduction electrons', 'Neutrons'],
          'correct': 2,
        },
      ];

    case 'phy102_u5_2': // Resistance and Resistors
      return [
        {
          'question': 'Ohm\'s Law states that, at constant temperature, current through a conductor is:',
          'options': ['independent of the potential difference', 'inversely proportional to the potential difference across it', 'directly proportional to the potential difference across it', 'proportional to the square of the potential difference'],
          'correct': 2,
        },
        {
          'question': 'The SI unit of resistance is the:',
          'options': ['farad', 'ampere', 'ohm', 'volt'],
          'correct': 2,
        },
        {
          'question': 'Electrical resistance is a measure of a material\'s opposition to:',
          'options': ['the flow of magnetic field', 'the flow of electric current', 'the storage of electric charge', 'the generation of electromotive force'],
          'correct': 1,
        },
        {
          'question': 'The resistance of a wire is directly proportional to its:',
          'options': ['conductivity', 'temperature only', 'length', 'cross-sectional area'],
          'correct': 2,
        },
        {
          'question': 'The resistance of a wire is inversely proportional to its:',
          'options': ['resistivity', 'length', 'voltage', 'cross-sectional area'],
          'correct': 3,
        },
        {
          'question': 'The property of a material that determines its inherent resistance per unit length and area is called:',
          'options': ['resistivity', 'capacitance', 'permittivity', 'conductivity only in metals'],
          'correct': 0,
        },
        {
          'question': 'For most metallic conductors, resistance ___ as temperature increases.',
          'options': ['decreases', 'becomes negative', 'increases', 'stays exactly constant'],
          'correct': 2,
        },
        {
          'question': 'A resistor that maintains a fixed resistance value is called a:',
          'options': ['variable resistor', 'rheostat', 'potentiometer', 'fixed resistor'],
          'correct': 3,
        },
        {
          'question': 'A resistor whose resistance can be adjusted is called a:',
          'options': ['capacitor', 'variable resistor (rheostat)', 'diode', 'fixed resistor'],
          'correct': 1,
        },
        {
          'question': 'Resistor color codes are used to indicate a resistor\'s:',
          'options': ['current direction', 'magnetic polarity', 'resistance value and tolerance', 'power source'],
          'correct': 2,
        },
        {
          'question': 'A material with zero electrical resistance at very low temperatures is called a:',
          'options': ['insulator', 'superconductor', 'dielectric', 'semiconductor'],
          'correct': 1,
        },
        {
          'question': 'Semiconductors have resistivity that is:',
          'options': ['between conductors and insulators', 'equal to superconductors', 'lower than conductors', 'higher than insulators'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is an example of a good electrical conductor?',
          'options': ['glass', 'wood', 'copper', 'rubber'],
          'correct': 2,
        },
        {
          'question': 'The graph of voltage (V) against current (I) for an ohmic conductor is:',
          'options': ['a straight line through the origin', 'a curve that flattens out', 'a straight line with negative slope', 'a circle'],
          'correct': 0,
        },
        {
          'question': 'A component that does NOT obey Ohm\'s Law is called:',
          'options': ['conductive', 'non-ohmic', 'resistive', 'ohmic'],
          'correct': 1,
        },
        {
          'question': 'A conductor has a potential difference of 15 V across it and carries a current of 1 A. What is its resistance?',
          'options': ['19 Ω', '15 Ω', '30 Ω', '13 Ω'],
          'correct': 1,
        },
        {
          'question': 'A conductor has a potential difference of 10 V across it and carries a current of 5 A. What is its resistance?',
          'options': ['6 Ω', '4 Ω', '2 Ω', '0.5 Ω'],
          'correct': 2,
        },
        {
          'question': 'A conductor has a potential difference of 4 V across it and carries a current of 4 A. What is its resistance?',
          'options': ['5 Ω', '3 Ω', '0.5 Ω', '1 Ω'],
          'correct': 3,
        },
        {
          'question': 'A resistor of 4 Ω is connected across a 18 V supply. What is the current through it?',
          'options': ['4.5 A', '6.5 A', '3.5 A', '5.5 A'],
          'correct': 0,
        },
        {
          'question': 'A resistor of 5 Ω is connected across a 24 V supply. What is the current through it?',
          'options': ['4.8 A', '5.8 A', '6.8 A', '2.4 A'],
          'correct': 0,
        },
        {
          'question': 'A conductor has a potential difference of 6 V across it and carries a current of 2.5 A. What is its resistance?',
          'options': ['0.5 Ω', '6.4 Ω', '4.8 Ω', '2.4 Ω'],
          'correct': 3,
        },
        {
          'question': 'A resistor of 3 Ω is connected across a 9 V supply. What is the current through it?',
          'options': ['5 A', '3 A', '2 A', '4 A'],
          'correct': 1,
        },
        {
          'question': 'A resistor of 5 Ω is connected across a 6 V supply. What is the current through it?',
          'options': ['1.2 A', '3.2 A', '0.2 A', '2.2 A'],
          'correct': 0,
        },
        {
          'question': 'A conductor has a potential difference of 10 V across it and carries a current of 0.5 A. What is its resistance?',
          'options': ['22 Ω', '20 Ω', '18 Ω', '40 Ω'],
          'correct': 1,
        },
        {
          'question': 'A wire has resistivity 2 x 10^-6 Ω·m, length 5 m, and cross-sectional area 5 x 10^-6 m². What is its resistance? (use R = ρL/A)',
          'options': ['3 Ω', '1 Ω', '5 Ω', '2 Ω'],
          'correct': 3,
        },
        {
          'question': 'What is the potential difference across a 3 Ω resistor carrying a current of 0.5 A?',
          'options': ['3.5 V', '1.5 V', '0.75 V', '0.5 V'],
          'correct': 1,
        },
        {
          'question': 'A wire has resistivity 4 x 10^-6 Ω·m, length 5 m, and cross-sectional area 1 x 10^-6 m². What is its resistance? (use R = ρL/A)',
          'options': ['23 Ω', '10 Ω', '20 Ω', '40 Ω'],
          'correct': 2,
        },
        {
          'question': 'A conductor has a potential difference of 4 V across it and carries a current of 2 A. What is its resistance?',
          'options': ['4 Ω', '6 Ω', '0.5 Ω', '2 Ω'],
          'correct': 3,
        },
        {
          'question': 'A wire has resistivity 1 x 10^-6 Ω·m, length 5 m, and cross-sectional area 5 x 10^-6 m². What is its resistance? (use R = ρL/A)',
          'options': ['2 Ω', '4 Ω', '0.5 Ω', '1 Ω'],
          'correct': 3,
        },
        {
          'question': 'A conductor has a potential difference of 5 V across it and carries a current of 2 A. What is its resistance?',
          'options': ['2.5 Ω', '0.5 Ω', '5 Ω', '6.5 Ω'],
          'correct': 0,
        },
        {
          'question': 'A resistor of 5 Ω is connected across a 9 V supply. What is the current through it?',
          'options': ['3.8 A', '0.9 A', '2.8 A', '1.8 A'],
          'correct': 3,
        },
        {
          'question': 'A conductor has a potential difference of 2 V across it and carries a current of 5 A. What is its resistance?',
          'options': ['0.8 Ω', '0.4 Ω', '4.4 Ω', '2.4 Ω'],
          'correct': 1,
        },
        {
          'question': 'A wire has resistivity 4 x 10^-6 Ω·m, length 10 m, and cross-sectional area 5 x 10^-6 m². What is its resistance? (use R = ρL/A)',
          'options': ['4 Ω', '9 Ω', '8 Ω', '16 Ω'],
          'correct': 2,
        },
        {
          'question': 'A resistor of 3 Ω is connected across a 24 V supply. What is the current through it?',
          'options': ['7 A', '9 A', '8 A', '10 A'],
          'correct': 2,
        },
        {
          'question': 'What is the potential difference across a 3 Ω resistor carrying a current of 2 A?',
          'options': ['10 V', '6 V', '3 V', '4 V'],
          'correct': 1,
        },
        {
          'question': 'If a wire of resistance R is stretched uniformly to twice its original length while maintaining a constant volume, what is its new resistance?',
          'options': ['R', '2R', '4R', '8R'],
          'correct': 2,
        },
        {
          'question': 'What is the SI unit of electrical conductivity?',
          'options': ['Ω·m', 'Ω^-1·m^-1', 'V/m', 'A/m^2'],
          'correct': 1,
        },
        {
          'question': 'A uniform wire of resistance 20.0 Ω is cut into four equal pieces, which are then connected in parallel. What is the equivalent resistance of this combination?',
          'options': ['1.25 Ω', '5.0 Ω', '10.0 Ω', '20.0 Ω'],
          'correct': 0,
        },
        {
          'question': 'With an increase in temperature, the electrical resistance of a metallic conductor:',
          'options': ['Increases', 'Decreases', 'Remains unchanged', 'First increases, then decreases'],
          'correct': 0,
        },
        {
          'question': 'With an increase in temperature, the resistivity of a semiconductor:',
          'options': ['Increases', 'Decreases', 'Remains unchanged', 'First decreases, then increases'],
          'correct': 1,
        },
        {
          'question': 'When a cylindrical conductor of length L and resistance R is stretched to twice its length, its resistivity:',
          'options': ['Doubles', 'Halves', 'Remains unchanged', 'Becomes four times larger'],
          'correct': 2,
        },
        {
          'question': 'Which of the following materials has a negative temperature coefficient of resistance?',
          'options': ['Copper', 'Silver', 'Silicon', 'Iron'],
          'correct': 2,
        },
        {
          'question': 'What is the SI unit of electrical resistance?',
          'options': ['Volt', 'Ampere', 'Ohm', 'Siemens'],
          'correct': 2,
        },
        {
          'question': 'The electrical conductivity of a material is the reciprocal of its:',
          'options': ['Resistance', 'Conductance', 'Resistivity', 'Capacitance'],
          'correct': 2,
        },
        {
          'question': 'A wire of resistivity ρ is stretched to twice its original length. Its new resistivity is:',
          'options': ['ρ', '2ρ', '4ρ', 'ρ/2'],
          'correct': 0,
        },
        {
          'question': 'Which of the following equations represents Ohm\'s Law in vector form?',
          'options': ['J = σE', 'E = ρJ', 'Both (A) and (B)', 'None of the above'],
          'correct': 2,
        },
        {
          'question': 'A cylindrical conductor has a resistance R. If its radius is doubled and its length is halved, the new resistance is:',
          'options': ['R/2', 'R/4', 'R/8', 'R/16'],
          'correct': 2,
        },
        {
          'question': 'In the relation J = σE, the parameter σ represents:',
          'options': ['Surface charge density', 'Electrical conductivity', 'Permittivity', 'Electrical resistance'],
          'correct': 1,
        },
        {
          'question': 'The specific resistance (resistivity) of a wire of length L and area A is:',
          'options': ['Proportional to L', 'Inversely proportional to A', 'Independent of L and A', 'Proportional to L/A'],
          'correct': 2,
        },
        {
          'question': 'In the linear resistance-temperature relation, the parameter R0 represents the resistance at:',
          'options': ['Absolute zero (0 K)', 'Room temperature (298 K)', 'The reference temperature T0', 'The boiling point of water'],
          'correct': 2,
        },
        {
          'question': 'Which of the following devices does not obey Ohm\'s Law?',
          'options': ['Copper wire', 'Semiconductor diode', 'Carbon resistor', 'Nichrome wire'],
          'correct': 1,
        },
      ];

    case 'phy102_u5_3': // Electrical Power
      return [
        {
          'question': 'Electrical power is defined as the rate at which:',
          'options': ['current reverses direction', 'charge is stored', 'electrical energy is converted or transferred', 'resistance changes'],
          'correct': 2,
        },
        {
          'question': 'The SI unit of electrical power is the:',
          'options': ['ampere', 'ohm', 'watt', 'joule'],
          'correct': 2,
        },
        {
          'question': 'The formula for electrical power in terms of voltage and current is:',
          'options': ['P = I/V', 'P = V/I', 'P = VI', 'P = V + I'],
          'correct': 2,
        },
        {
          'question': 'Using Ohm\'s Law, electrical power can also be written as:',
          'options': ['P = I²R', 'P = I - R', 'P = I/R', 'P = R/I'],
          'correct': 0,
        },
        {
          'question': 'Electrical power can also be expressed as:',
          'options': ['P = R/V²', 'P = V - R', 'P = V²/R', 'P = V·R'],
          'correct': 2,
        },
        {
          'question': 'The commercial unit of electrical energy used for billing is the:',
          'options': ['watt-second', 'kilowatt-hour', 'ampere-hour', 'joule'],
          'correct': 1,
        },
        {
          'question': 'One kilowatt-hour is equal to:',
          'options': ['1 joule', '3600 joules', '1000 joules', '3.6 x 10^6 joules'],
          'correct': 3,
        },
        {
          'question': 'The power rating on a light bulb (e.g., \'60 W\') indicates:',
          'options': ['the current it draws at all voltages', 'its resistance in ohms', 'the total energy it will ever use', 'the rate at which it converts electrical energy'],
          'correct': 3,
        },
        {
          'question': 'If two identical resistors are connected and power dissipated is measured, more power is dissipated in the one with:',
          'options': ['less voltage regardless of current', 'zero resistance always', 'more current flowing through it (for equal resistance)', 'less current flowing through it'],
          'correct': 2,
        },
        {
          'question': 'Electrical energy consumed is calculated using the formula:',
          'options': ['E = P + t', 'E = t/P', 'E = P/t', 'E = Pt'],
          'correct': 3,
        },
        {
          'question': 'A device rated \'100 W, 220 V\' when connected to 220 V draws a current of approximately:',
          'options': ['220 A', '0.45 A', '2.2 A', '100 A'],
          'correct': 1,
        },
        {
          'question': 'Which of the following has the greatest power rating typically?',
          'options': ['a wristwatch battery', 'an LED indicator light', 'an electric kettle', 'a small torch bulb'],
          'correct': 2,
        },
        {
          'question': 'If the voltage across a fixed resistor is doubled, the power dissipated:',
          'options': ['doubles', 'increases four-fold', 'is halved', 'stays the same'],
          'correct': 1,
        },
        {
          'question': 'If the current through a fixed resistor is doubled, the power dissipated:',
          'options': ['doubles', 'is halved', 'stays the same', 'increases four-fold'],
          'correct': 3,
        },
        {
          'question': 'The efficiency of an electrical appliance relates to the ratio of:',
          'options': ['useful energy output to total energy input', 'resistance to power', 'voltage to current', 'charge to time'],
          'correct': 0,
        },
        {
          'question': 'A current of 3 A flows through a 6 Ω resistor. What is the power dissipated?',
          'options': ['59 W', '54 W', '27 W', '64 W'],
          'correct': 1,
        },
        {
          'question': 'An appliance rated 1500 W runs for 2 hours. If electricity costs 50 units per kWh, what is the total cost?',
          'options': ['75', '100', '300', '150'],
          'correct': 3,
        },
        {
          'question': 'An appliance rated 1000 W runs for 2 hours. If electricity costs 60 units per kWh, what is the total cost?',
          'options': ['240', '170', '120', '70'],
          'correct': 2,
        },
        {
          'question': 'An appliance rated 1000 W runs for 5 hours. If electricity costs 70 units per kWh, what is the total cost?',
          'options': ['175', '300', '350', '700'],
          'correct': 2,
        },
        {
          'question': 'An appliance rated 1000 W is used for 1 hours. How much energy (in kWh) does it consume?',
          'options': ['2 kWh', '3 kWh', '0.1 kWh', '1 kWh'],
          'correct': 3,
        },
        {
          'question': 'A device operates at 10 V and draws a current of 1 A. What is the power consumed?',
          'options': ['5 W', '8 W', '10 W', '12 W'],
          'correct': 2,
        },
        {
          'question': 'A device operates at 6 V and draws a current of 2 A. What is the power consumed?',
          'options': ['12 W', '6 W', '10 W', '17 W'],
          'correct': 0,
        },
        {
          'question': 'An appliance rated 1000 W is used for 4 hours. How much energy (in kWh) does it consume?',
          'options': ['6 kWh', '3 kWh', '4 kWh', '2 kWh'],
          'correct': 2,
        },
        {
          'question': 'A device operates at 5 V and draws a current of 3 A. What is the power consumed?',
          'options': ['20 W', '15 W', '7.5 W', '13 W'],
          'correct': 1,
        },
        {
          'question': 'A current of 1 A flows through a 6 Ω resistor. What is the power dissipated?',
          'options': ['3 W', '16 W', '6 W', '1 W'],
          'correct': 2,
        },
        {
          'question': 'A device operates at 12 V and draws a current of 2 A. What is the power consumed?',
          'options': ['26 W', '29 W', '24 W', '12 W'],
          'correct': 2,
        },
        {
          'question': 'A device operates at 6 V and draws a current of 5 A. What is the power consumed?',
          'options': ['30 W', '35 W', '28 W', '32 W'],
          'correct': 0,
        },
        {
          'question': 'An appliance rated 500 W is used for 1 hours. How much energy (in kWh) does it consume?',
          'options': ['1.5 kWh', '0.5 kWh', '0.25 kWh', '0.1 kWh'],
          'correct': 1,
        },
        {
          'question': 'A current of 1 A flows through a 4 Ω resistor. What is the power dissipated?',
          'options': ['9 W', '4 W', '2 W', '1 W'],
          'correct': 1,
        },
        {
          'question': 'A resistor of 4 Ω is connected to a 10 V source. What is the power dissipated?',
          'options': ['22 W', '31 W', '12.5 W', '25 W'],
          'correct': 3,
        },
        {
          'question': 'A current of 2 A flows through a 4 Ω resistor. What is the power dissipated?',
          'options': ['16 W', '11 W', '26 W', '21 W'],
          'correct': 0,
        },
        {
          'question': 'A device operates at 20 V and draws a current of 5 A. What is the power consumed?',
          'options': ['102 W', '98 W', '105 W', '100 W'],
          'correct': 3,
        },
        {
          'question': 'An appliance rated 1500 W is used for 2 hours. How much energy (in kWh) does it consume?',
          'options': ['4 kWh', '2 kWh', '3 kWh', '1.5 kWh'],
          'correct': 2,
        },
        {
          'question': 'An appliance rated 500 W is used for 3 hours. How much energy (in kWh) does it consume?',
          'options': ['2.5 kWh', '1.5 kWh', '0.75 kWh', '0.5 kWh'],
          'correct': 1,
        },
        {
          'question': 'A resistor of 8 Ω is connected to a 10 V source. What is the power dissipated?',
          'options': ['15.5 W', '18.5 W', '12.5 W', '9.5 W'],
          'correct': 2,
        },
        {
          'question': 'A 100 W, 220 V bulb is connected to a 110 V power line. What is the actual power consumed by the bulb?',
          'options': ['25 W', '50 W', '75 W', '100 W'],
          'correct': 0,
        },
        {
          'question': 'The heat generated in a resistor of resistance R carrying a current I for a time t is given by:',
          'options': ['IRt', 'I^2Rt', 'I^2t/R', 'IR^2t'],
          'correct': 1,
        },
        {
          'question': 'A device that converts chemical energy into electrical energy is called an:',
          'options': ['Resistor', 'Capacitor', 'Electrochemical cell', 'Galvanometer'],
          'correct': 2,
        },
        {
          'question': 'If the current flowing through a fixed resistor is doubled, the power dissipated as heat:',
          'options': ['Doubles', 'Halves', 'Quadruples', 'Decreases by a factor of four'],
          'correct': 2,
        },
      ];

    case 'phy102_u5_4': // Resistors in Series and Parallel
      return [
        {
          'question': 'In a series circuit, the total (equivalent) resistance is:',
          'options': ['the reciprocal sum of the individual resistances', 'the sum of the individual resistances', 'always less than the smallest resistor', 'always equal to the largest resistor only'],
          'correct': 1,
        },
        {
          'question': 'In a series circuit, the current through each resistor is:',
          'options': ['the same throughout the circuit', 'zero at the last resistor', 'different depending on the resistor', 'proportional to the resistor\'s resistance'],
          'correct': 0,
        },
        {
          'question': 'In a series circuit, the total voltage supplied is:',
          'options': ['the same as the voltage across each resistor', 'the average of the voltage drops', 'the sum of the voltage drops across each resistor', 'the difference between the largest and smallest voltage drops'],
          'correct': 2,
        },
        {
          'question': 'In a parallel circuit, the voltage across each branch is:',
          'options': ['zero', 'proportional to each resistor\'s resistance', 'the same as the source voltage', 'different for each branch'],
          'correct': 2,
        },
        {
          'question': 'In a parallel circuit, the total current from the source equals:',
          'options': ['the current in the smallest resistor only', 'the sum of the currents in each branch', 'zero', 'the average of the branch currents'],
          'correct': 1,
        },
        {
          'question': 'The equivalent resistance of resistors in parallel is:',
          'options': ['equal to the average of the resistances', 'always greater than the largest individual resistance', 'always less than the smallest individual resistance', 'equal to the sum of the resistances'],
          'correct': 2,
        },
        {
          'question': 'Adding another resistor in series with existing resistors will:',
          'options': ['decrease the total resistance', 'increase the total resistance', 'reduce total resistance to zero', 'leave total resistance unchanged'],
          'correct': 1,
        },
        {
          'question': 'Adding another resistor in parallel with existing resistors will:',
          'options': ['increase total resistance to infinity', 'increase the total resistance', 'leave total resistance unchanged', 'decrease the total resistance'],
          'correct': 3,
        },
        {
          'question': 'If two equal resistors R are connected in parallel, the equivalent resistance is:',
          'options': ['R', 'R/2', '2R', 'R²'],
          'correct': 1,
        },
        {
          'question': 'If two equal resistors R are connected in series, the equivalent resistance is:',
          'options': ['2R', 'R', 'R/2', 'R²'],
          'correct': 0,
        },
        {
          'question': 'Household electrical appliances are usually wired in:',
          'options': ['a mixture that has no name', 'neither series nor parallel', 'series', 'parallel'],
          'correct': 3,
        },
        {
          'question': 'One disadvantage of connecting bulbs in series (e.g., old Christmas lights) is:',
          'options': ['each bulb gets full source voltage', 'brightness cannot be affected by adding more bulbs', 'if one bulb fails, the whole circuit is broken', 'the circuit uses more wire than parallel'],
          'correct': 2,
        },
        {
          'question': 'A voltage divider is typically built using resistors connected in:',
          'options': ['a short circuit', 'an open circuit', 'parallel', 'series'],
          'correct': 3,
        },
        {
          'question': 'A current divider is typically built using resistors connected in:',
          'options': ['parallel', 'a short circuit', 'series', 'an open circuit'],
          'correct': 0,
        },
        {
          'question': 'For resistors in parallel, the branch with the smallest resistance carries:',
          'options': ['exactly half the total current', 'the largest share of current', 'the smallest share of current', 'no current'],
          'correct': 1,
        },
        {
          'question': 'Resistors of 2 Ω, 5 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['4 Ω', '10 Ω', '13 Ω', '7 Ω'],
          'correct': 3,
        },
        {
          'question': 'Resistors of 5 Ω, 3 Ω, 10 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['1.58 Ω', '18 Ω', '24 Ω', '15 Ω'],
          'correct': 1,
        },
        {
          'question': 'Resistors of 2 Ω, 6 Ω, 10 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['1.3 Ω', '18 Ω', '24 Ω', '15 Ω'],
          'correct': 1,
        },
        {
          'question': 'Resistors of 3 Ω, 8 Ω, 4 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['18 Ω', '12 Ω', '21 Ω', '15 Ω'],
          'correct': 3,
        },
        {
          'question': 'Resistors of 5 Ω, 4 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['15 Ω', '2.22 Ω', '12 Ω', '9 Ω'],
          'correct': 3,
        },
        {
          'question': 'Resistors of 4 Ω, 4 Ω, 8 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['19 Ω', '1.6 Ω', '16 Ω', '22 Ω'],
          'correct': 2,
        },
        {
          'question': 'Resistors of 2 Ω, 2 Ω, 3 Ω are connected in series. What is the total (equivalent) resistance?',
          'options': ['4 Ω', '13 Ω', '10 Ω', '7 Ω'],
          'correct': 3,
        },
        {
          'question': 'Resistors of 4 Ω, 3 Ω, 6 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['1.33 Ω', '0.33 Ω', '13 Ω', '3.33 Ω'],
          'correct': 0,
        },
        {
          'question': 'Resistors of 2 Ω, 4 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['0.33 Ω', '1.33 Ω', '6 Ω', '3.33 Ω'],
          'correct': 1,
        },
        {
          'question': 'Resistors of 6 Ω, 3 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['9 Ω', '2 Ω', '3 Ω', '1 Ω'],
          'correct': 1,
        },
        {
          'question': 'Resistors of 6 Ω, 6 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['2 Ω', '12 Ω', '3 Ω', '5 Ω'],
          'correct': 2,
        },
        {
          'question': 'Resistors of 8 Ω, 3 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['2.18 Ω', '4.18 Ω', '3.18 Ω', '1.18 Ω'],
          'correct': 0,
        },
        {
          'question': 'Resistors of 12 Ω, 2 Ω, 2 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['0.92 Ω', '16 Ω', '1.92 Ω', '2.92 Ω'],
          'correct': 0,
        },
        {
          'question': 'Resistors of 4 Ω, 12 Ω are connected in parallel. What is the total (equivalent) resistance? (round to 2 d.p.)',
          'options': ['4 Ω', '5 Ω', '3 Ω', '2 Ω'],
          'correct': 2,
        },
        {
          'question': 'Two resistors R1 = 2 Ω and R2 = 6 Ω are connected in series across a 12 V supply. What is the voltage drop across R1?',
          'options': ['3 V', '9 V', '5 V', '7 V'],
          'correct': 0,
        },
        {
          'question': 'Two resistors R1 = 4 Ω and R2 = 2 Ω are connected in parallel, drawing a total current of 2 A from the source. What is the current through R1?',
          'options': ['1.67 A', '0.2 A', '0.67 A', '1.33 A'],
          'correct': 2,
        },
        {
          'question': 'Two resistors R1 = 6 Ω and R2 = 4 Ω are connected in parallel, drawing a total current of 2 A from the source. What is the current through R1?',
          'options': ['1.8 A', '1.2 A', '0.2 A', '0.8 A'],
          'correct': 3,
        },
        {
          'question': 'Two resistors R1 = 2 Ω and R2 = 2 Ω are connected in parallel, drawing a total current of 4 A from the source. What is the current through R1?',
          'options': ['2 A', '3 A', '4 A', '1 A'],
          'correct': 0,
        },
        {
          'question': 'Two resistors R1 = 6 Ω and R2 = 2 Ω are connected in parallel, drawing a total current of 4 A from the source. What is the current through R1?',
          'options': ['3 A', '0.2 A', '2 A', '1 A'],
          'correct': 3,
        },
        {
          'question': 'Two resistors R1 = 4 Ω and R2 = 2 Ω are connected in series across a 18 V supply. What is the voltage drop across R1?',
          'options': ['10 V', '12 V', '6 V', '14 V'],
          'correct': 1,
        },
        {
          'question': 'Two resistors, 3.0 Ω and 6.0 Ω, are connected in parallel. What is their equivalent resistance?',
          'options': ['2.0 Ω', '4.5 Ω', '9.0 Ω', '18.0 Ω'],
          'correct': 0,
        },
        {
          'question': 'Two resistors, 4.0 Ω and 12.0 Ω, are connected in parallel. What is their equivalent resistance?',
          'options': ['3.0 Ω', '8.0 Ω', '16.0 Ω', '48.0 Ω'],
          'correct': 0,
        },
        {
          'question': 'Three identical resistors, each of resistance R, are connected in parallel. What is their equivalent resistance?',
          'options': ['3R', 'R', 'R/3', 'R/9'],
          'correct': 2,
        },
        {
          'question': 'Three resistors of resistances 1.0 Ω, 2.0 Ω, and 3.0 Ω are connected in series. What is their equivalent resistance?',
          'options': ['0.54 Ω', '1.5 Ω', '3.0 Ω', '6.0 Ω'],
          'correct': 3,
        },
        {
          'question': 'Two resistors of resistances R1 and R2 are connected in parallel across a battery. The ratio of the currents flowing through them is:',
          'options': ['I1/I2 = R1/R2', 'I1/I2 = R2/R1', 'I1/I2 = 1', 'I1/I2 = R1^2/R2^2'],
          'correct': 1,
        },
        {
          'question': 'The equivalent resistance of n identical resistors connected in series is Rs, and their equivalent resistance when connected in parallel is Rp. The ratio Rs/Rp is:',
          'options': ['n', '1/n', 'n^2', '1/n^2'],
          'correct': 2,
        },
        {
          'question': 'For a given set of unequal resistors, the equivalent resistance of their series combination Rs and parallel combination Rp always satisfies:',
          'options': ['Rs < Rp', 'Rs > Rp', 'Rs = Rp', 'Rs·Rp = 1'],
          'correct': 1,
        },
      ];

    case 'phy102_u5_5': // Kirchhoff's Law
      return [
        {
          'question': 'Kirchhoff\'s Current Law (KCL) is based on the principle of conservation of:',
          'options': ['energy', 'momentum', 'electric charge', 'mass'],
          'correct': 2,
        },
        {
          'question': 'Kirchhoff\'s Voltage Law (KVL) is based on the principle of conservation of:',
          'options': ['charge', 'energy', 'momentum', 'mass'],
          'correct': 1,
        },
        {
          'question': 'Kirchhoff\'s Current Law states that at any junction, the sum of currents entering equals:',
          'options': ['the sum of currents leaving', 'the source voltage', 'the total resistance', 'zero always, regardless of direction'],
          'correct': 0,
        },
        {
          'question': 'Kirchhoff\'s Voltage Law states that around any closed loop, the sum of the EMFs equals:',
          'options': ['the total current', 'the sum of the potential drops', 'zero minus the total resistance', 'the average resistance'],
          'correct': 1,
        },
        {
          'question': 'KCL is also known as:',
          'options': ['Ohm\'s rule', 'the junction rule', 'the power rule', 'the loop rule'],
          'correct': 1,
        },
        {
          'question': 'KVL is also known as:',
          'options': ['the node rule', 'the loop rule', 'the resistivity rule', 'the junction rule'],
          'correct': 1,
        },
        {
          'question': 'At a junction where 3 A and 5 A enter, and one wire leaves, the current leaving the junction is:',
          'options': ['0 A', '15 A', '2 A', '8 A'],
          'correct': 3,
        },
        {
          'question': 'At a junction, if 10 A enters and two wires leave carrying 4 A and x A, then x equals:',
          'options': ['14 A', '6 A', '4 A', '10 A'],
          'correct': 1,
        },
        {
          'question': 'Kirchhoff\'s Laws are especially useful for analyzing circuits that:',
          'options': ['have no closed loops', 'contain no junctions', 'contain only a single resistor', 'cannot be simplified using simple series-parallel rules alone'],
          'correct': 3,
        },
        {
          'question': 'When applying KVL, a rise in potential (e.g., through an EMF source in the direction of travel) is generally taken as:',
          'options': ['zero', 'undefined', 'positive', 'negative'],
          'correct': 2,
        },
        {
          'question': 'When applying KVL, moving across a resistor in the direction of assumed current flow gives a potential:',
          'options': ['drop (negative contribution)', 'rise (positive contribution)', 'zero change', 'undefined change'],
          'correct': 0,
        },
        {
          'question': 'Kirchhoff\'s Laws apply to circuits containing:',
          'options': ['only parallel resistors', 'only a single battery and one resistor', 'both resistors and sources of EMF, including multiple loops', 'only resistors in series'],
          'correct': 2,
        },
        {
          'question': 'The number of independent loop equations needed to solve a circuit using KVL equals the number of:',
          'options': ['junctions in the circuit', 'independent closed loops in the circuit', 'resistors in the circuit', 'batteries in the circuit'],
          'correct': 1,
        },
        {
          'question': 'The number of independent equations needed from KCL is generally:',
          'options': ['equal to the number of loops', 'equal to the number of resistors', 'equal to the number of junctions', 'one fewer than the number of junctions'],
          'correct': 3,
        },
        {
          'question': 'Kirchhoff\'s Laws are consistent with, and can be used to derive, the rules for combining:',
          'options': ['resistors in series and parallel', 'only capacitors', 'only magnetic fields', 'only inductors'],
          'correct': 0,
        },
        {
          'question': 'At a circuit junction, a current of 12 A flows in, splitting into two outgoing wires. If one wire carries 5 A, what does the other carry?',
          'options': ['5 A', '12 A', '7 A', '10 A'],
          'correct': 2,
        },
        {
          'question': 'At a circuit junction, currents of 5 A and 10 A flow in, and only one wire carries current out. What is the outgoing current?',
          'options': ['11 A', '15 A', '5 A', '20 A'],
          'correct': 1,
        },
        {
          'question': 'At a circuit junction, currents of 2 A and 8 A flow in, and only one wire carries current out. What is the outgoing current?',
          'options': ['6 A', '13 A', '10 A', '15 A'],
          'correct': 2,
        },
        {
          'question': 'At a circuit junction, a current of 8 A flows in, splitting into two outgoing wires. If one wire carries 3 A, what does the other carry?',
          'options': ['2 A', '5 A', '8 A', '3 A'],
          'correct': 1,
        },
        {
          'question': 'At a circuit junction, currents of 6 A and 9 A flow in, and only one wire carries current out. What is the outgoing current?',
          'options': ['3 A', '11 A', '20 A', '15 A'],
          'correct': 3,
        },
        {
          'question': 'At a circuit junction, currents of 1 A and 6 A flow in, and only one wire carries current out. What is the outgoing current?',
          'options': ['12 A', '7 A', '3 A', '10 A'],
          'correct': 1,
        },
        {
          'question': 'At a circuit junction, currents of 4 A and 1 A flow in, and only one wire carries current out. What is the outgoing current?',
          'options': ['8 A', '3 A', '1 A', '5 A'],
          'correct': 3,
        },
        {
          'question': 'At a circuit junction, a current of 18 A flows in, splitting into two outgoing wires. If one wire carries 5 A, what does the other carry?',
          'options': ['13 A', '10 A', '5 A', '16 A'],
          'correct': 0,
        },
        {
          'question': 'At a circuit junction, a current of 12 A flows in, splitting into two outgoing wires. If one wire carries 11 A, what does the other carry?',
          'options': ['1 A', '11 A', '4 A', '12 A'],
          'correct': 0,
        },
        {
          'question': 'At a circuit junction, a current of 14 A flows in, splitting into two outgoing wires. If one wire carries 1 A, what does the other carry?',
          'options': ['13 A', '10 A', '14 A', '1 A'],
          'correct': 0,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 15 V and current 1 A, the voltage drops across two resistors are 4 V and 2 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['9 V', '6 V', '15 V', '12 V'],
          'correct': 0,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 20 V and current 1 A, the voltage drops across two resistors are 2 V and 1 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['23 V', '14 V', '17 V', '20 V'],
          'correct': 2,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 30 V and current 1 A, the voltage drops across two resistors are 3 V and 6 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['27 V', '18 V', '24 V', '21 V'],
          'correct': 3,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 20 V and current 1 A, the voltage drops across two resistors are 3 V and 2 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['12 V', '21 V', '20 V', '15 V'],
          'correct': 3,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 12 V and current 1 A, the voltage drops across two resistors are 3 V and 1 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['5 V', '11 V', '8 V', '12 V'],
          'correct': 2,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 12 V and current 2 A, the voltage drops across two resistors are 2 V and 2 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['11 V', '8 V', '14 V', '5 V'],
          'correct': 1,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 12 V and current 1 A, the voltage drops across two resistors are 3 V and 2 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['7 V', '13 V', '4 V', '12 V'],
          'correct': 0,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 18 V and current 1 A, the voltage drops across two resistors are 4 V and 4 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['7 V', '16 V', '10 V', '13 V'],
          'correct': 2,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 24 V and current 2 A, the voltage drops across two resistors are 4 V and 2 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['18 V', '15 V', '24 V', '21 V'],
          'correct': 0,
        },
        {
          'question': 'In a single-loop circuit with an EMF source of 12 V and current 1 A, the voltage drops across two resistors are 1 V and 2 V respectively. By Kirchhoff\'s Voltage Law, what is the drop across any remaining component in the loop?',
          'options': ['12 V', '9 V', '6 V', '15 V'],
          'correct': 1,
        },
        {
          'question': 'Which conservation law forms the physical basis for Kirchhoff\'s Current Law?',
          'options': ['Conservation of Energy', 'Conservation of Momentum', 'Conservation of Charge', 'Conservation of Mass'],
          'correct': 2,
        },
        {
          'question': 'Which conservation law forms the physical basis for Kirchhoff\'s Voltage Law?',
          'options': ['Conservation of Energy', 'Conservation of Charge', 'Conservation of Momentum', 'Conservation of Mass'],
          'correct': 0,
        },
        {
          'question': 'A potentiometer is a superior instrument for measuring electromotive force (EMF) because:',
          'options': ['It draws a large current from the cell.', 'It draws zero net current from the cell at the balance point.', 'It has low input resistance.', 'It directly measures internal resistance.'],
          'correct': 1,
        },
        {
          'question': 'The terminal potential difference of a cell of EMF E and internal resistance r delivering current I is given by:',
          'options': ['V = E + Ir', 'V = E - Ir', 'V = E', 'V = E/(1 + r)'],
          'correct': 1,
        },
        {
          'question': 'In a charging circuit, if a battery of EMF E is being charged by an external power supply, the terminal potential difference V across the battery is:',
          'options': ['V = E - Ir', 'V = E + Ir', 'V = E', 'V = Ir'],
          'correct': 1,
        },
        {
          'question': 'A balanced Wheatstone bridge consists of four arms with resistances P, Q, R, and S. The relationship between these resistances is:',
          'options': ['P·Q = R·S', 'P/Q = R/S', 'P + Q = R + S', 'P - Q = R - S'],
          'correct': 1,
        },
        {
          'question': 'The resistance of an ideal ammeter should be:',
          'options': ['Zero', 'Infinite', '1.0 Ω', '100.0 Ω'],
          'correct': 0,
        },
        {
          'question': 'The resistance of an ideal voltmeter should be:',
          'options': ['Zero', 'Infinite', '1.0 Ω', '100.0 Ω'],
          'correct': 1,
        },
        {
          'question': 'A cell of EMF E is connected in series with an external resistance R. If the current in the circuit is I, the power delivered to the external resistor is maximized when:',
          'options': ['R = r', 'R = 2r', 'R = r/2', 'R is much greater than r'],
          'correct': 0,
        },
      ];

    case 'phy102_u2_1': // Magnetic Fields and Forces
      return [
        {
          'question': 'The SI unit of magnetic field strength (magnetic flux density) is the?',
          'options': ['Weber', 'Tesla', 'Henry', 'Farad'],
          'correct': 1,
        },
        {
          'question': 'The SI unit of magnetic flux is the?',
          'options': ['Weber', 'Tesla', 'Henry', 'Ampere'],
          'correct': 0,
        },
        {
          'question': 'A moving charge in a magnetic field experiences a force called the?',
          'options': ['Electric force', 'Normal force', 'Gravitational force', 'Lorentz (magnetic) force'],
          'correct': 3,
        },
        {
          'question': 'The formula for the magnetic force on a moving charge is F = ?',
          'options': ['mv^2/r', 'qE + mg', 'qE', 'qvB sin(theta)'],
          'correct': 3,
        },
        {
          'question': 'The direction of the magnetic force on a positive charge moving in a magnetic field is found using the?',
          'options': ['Left-hand rule (for conventional current, right-hand rule is standard)', 'Ohm\'s law', 'Right-hand rule', 'Lenz\'s law only'],
          'correct': 2,
        },
        {
          'question': 'A charge moving parallel to a magnetic field experiences a magnetic force of?',
          'options': ['Negative value always', 'Zero', 'Half the maximum value', 'Maximum value'],
          'correct': 1,
        },
        {
          'question': 'A charge moving perpendicular to a magnetic field experiences a magnetic force that is?',
          'options': ['Maximum', 'Zero', 'Undefined', 'Negative always'],
          'correct': 0,
        },
        {
          'question': 'The magnetic force on a moving charge is always directed?',
          'options': ['Perpendicular to both velocity and the magnetic field', 'Opposite to velocity always', 'Parallel to the magnetic field', 'Parallel to velocity'],
          'correct': 0,
        },
        {
          'question': 'Because the magnetic force is always perpendicular to velocity, it does?',
          'options': ['Negative work', 'No work on the charge', 'Variable work depending on speed', 'Positive work'],
          'correct': 1,
        },
        {
          'question': 'A current-carrying wire placed in a magnetic field experiences a force given by F = ?',
          'options': ['V/R', 'qvB', 'IR', 'BIL sin(theta)'],
          'correct': 3,
        },
        {
          'question': 'The direction of the force on a current-carrying conductor in a magnetic field is given by?',
          'options': ['Fleming\'s left-hand rule', 'Lenz\'s law', 'Fleming\'s right-hand rule', 'Faraday\'s law'],
          'correct': 0,
        },
        {
          'question': 'Fleming\'s right-hand rule is primarily used to determine the direction of?',
          'options': ['Electric field lines', 'Force on a current-carrying conductor', 'Magnetic field around a wire', 'Induced current/EMF in a generator'],
          'correct': 3,
        },
        {
          'question': 'The magnetic field around a long straight current-carrying wire forms?',
          'options': ['No field is produced', 'Straight lines parallel to the wire', 'Concentric circles around the wire', 'Radial lines from the wire'],
          'correct': 2,
        },
        {
          'question': 'The strength of the magnetic field around a long straight wire is directly proportional to the?',
          'options': ['Voltage across the wire', 'Resistance of the wire', 'Current in the wire', 'Distance from the wire'],
          'correct': 2,
        },
        {
          'question': 'The strength of the magnetic field around a long straight wire is inversely proportional to the?',
          'options': ['Distance from the wire', 'Current', 'Voltage', 'Resistance'],
          'correct': 0,
        },
        {
          'question': 'The formula for the magnetic field at a distance r from a long straight current-carrying wire is B = ?',
          'options': ['mu0/I', '(mu0 I)/(2*pi*r)', 'mu0 I r', 'I/(2 pi r^2)'],
          'correct': 1,
        },
        {
          'question': 'The direction of the magnetic field around a straight current-carrying wire is given by?',
          'options': ['The right-hand grip (thumb) rule', 'Kirchhoff\'s law', 'Fleming\'s left-hand rule', 'Lenz\'s law'],
          'correct': 0,
        },
        {
          'question': 'A solenoid is best described as?',
          'options': ['A type of resistor', 'A type of capacitor', 'A coil of wire wound in many turns, producing a strong magnetic field when current flows', 'A single loop of wire'],
          'correct': 2,
        },
        {
          'question': 'The magnetic field inside a long solenoid is?',
          'options': ['Equal to the field outside', 'Zero', 'Strong and nearly uniform', 'Only present at the ends'],
          'correct': 2,
        },
        {
          'question': 'The magnetic field outside a long, ideal solenoid is approximately?',
          'options': ['Nearly zero', 'Twice the internal field', 'Equal to the field inside', 'Very strong'],
          'correct': 0,
        },
        {
          'question': 'The formula for the magnetic field inside a solenoid is B = ?',
          'options': ['n I / mu0', 'mu0 I / (2 pi r)', 'mu0 n I', 'mu0 I / (2r)'],
          'correct': 2,
        },
        {
          'question': 'In the solenoid field formula B = mu0 n I, \'n\' represents the?',
          'options': ['Total number of turns', 'Current', 'Number of turns per unit length', 'Resistance'],
          'correct': 2,
        },
        {
          'question': 'A magnetic field pattern similar to that of a bar magnet is produced by a?',
          'options': ['Solenoid', 'Resistor', 'Straight wire', 'Capacitor'],
          'correct': 0,
        },
        {
          'question': 'The region around a magnet or current-carrying conductor where magnetic effects can be detected is called the?',
          'options': ['Potential field', 'Electric field', 'Magnetic field', 'Gravitational field'],
          'correct': 2,
        },
        {
          'question': 'Magnetic field lines outside a bar magnet run from the?',
          'options': ['Both poles simultaneously in all directions', 'South pole to north pole', 'North pole to south pole', 'They do not have direction'],
          'correct': 2,
        },
        {
          'question': 'Inside a bar magnet, magnetic field lines run from?',
          'options': ['South pole to north pole', 'They stop entirely', 'North pole to south pole', 'They reverse direction randomly'],
          'correct': 0,
        },
        {
          'question': 'Magnetic field lines never do which of the following?',
          'options': ['Exist near current-carrying wires', 'Form closed loops', 'Point from N to S outside a magnet', 'Cross each other'],
          'correct': 3,
        },
        {
          'question': 'The magnetic force per unit length between two parallel current-carrying wires is used to define the SI unit of?',
          'options': ['Ohm', 'Ampere', 'Farad', 'Volt'],
          'correct': 1,
        },
        {
          'question': 'Two parallel wires carrying current in the same direction will?',
          'options': ['Attract each other', 'Have no force between them', 'Repel each other', 'Experience only a gravitational force'],
          'correct': 0,
        },
        {
          'question': 'Two parallel wires carrying current in opposite directions will?',
          'options': ['Repel each other', 'Attract each other', 'Have no force between them', 'Merge together'],
          'correct': 0,
        },
        {
          'question': 'A charged particle moving in a uniform magnetic field, with velocity perpendicular to the field, moves in a?',
          'options': ['Straight line', 'Parabolic path', 'Elliptical path only', 'Circular path'],
          'correct': 3,
        },
        {
          'question': 'The radius of the circular path of a charged particle in a magnetic field is given by r = ?',
          'options': ['mv^2/(qB)', 'qvB', 'qB/m', 'mv/(qB)'],
          'correct': 3,
        },
        {
          'question': 'Increasing the magnetic field strength on a charged particle moving in a circle will?',
          'options': ['Have no effect on the radius', 'Stop the particle entirely', 'Increase the radius of its path', 'Decrease the radius of its path'],
          'correct': 3,
        },
        {
          'question': 'Increasing the speed of a charged particle moving in a magnetic field (constant B) will?',
          'options': ['Decrease the radius', 'Cause the particle to stop', 'Increase the radius of its circular path', 'Have no effect on radius'],
          'correct': 2,
        },
        {
          'question': 'A device that uses magnetic fields to accelerate charged particles to high speeds in a circular path is called a?',
          'options': ['Solenoid', 'Transformer', 'Capacitor', 'Cyclotron'],
          'correct': 3,
        },
        {
          'question': 'A velocity selector uses combined electric and magnetic fields to allow only particles with a specific?',
          'options': ['Mass to pass', 'Velocity to pass', 'Temperature to pass', 'Charge to pass'],
          'correct': 1,
        },
        {
          'question': 'In a velocity selector, particles pass through undeflected when the electric force equals the?',
          'options': ['Normal force', 'Gravitational force', 'Magnetic force', 'Frictional force'],
          'correct': 2,
        },
        {
          'question': 'The condition for a velocity selector to allow undeflected passage is qE = ?',
          'options': ['qvB', 'qB/v', 'qv/B', 'q/(vB)'],
          'correct': 0,
        },
        {
          'question': 'A mass spectrometer uses magnetic fields to separate particles based on their?',
          'options': ['Mass-to-charge ratio', 'Colour', 'Temperature', 'Charge only'],
          'correct': 0,
        },
        {
          'question': 'The torque on a current-carrying loop placed in a magnetic field is given by tau = ?',
          'options': ['V/R', 'BIA sin(theta)', 'IR', 'BIA cos(theta)'],
          'correct': 1,
        },
        {
          'question': 'In the torque formula for a current loop, \'A\' represents the?',
          'options': ['Angle only', 'Area of the loop', 'Resistance', 'Current'],
          'correct': 1,
        },
        {
          'question': 'A current loop in a magnetic field experiences maximum torque when the plane of the loop is?',
          'options': ['Perpendicular to the field', 'Parallel to the field', 'Torque is always zero', 'At 45 degrees to the field'],
          'correct': 1,
        },
        {
          'question': 'A current loop in a magnetic field experiences zero torque when the plane of the loop is?',
          'options': ['Parallel to the field', 'Torque is never zero', 'At 45 degrees', 'Perpendicular to the field'],
          'correct': 3,
        },
        {
          'question': 'The magnetic dipole moment of a current loop is given by m = ?',
          'options': ['V/R', 'IA', 'qvB', 'I/A'],
          'correct': 1,
        },
        {
          'question': 'Ferromagnetic materials, such as iron, are characterised by?',
          'options': ['No interaction with magnetic fields', 'Weak repulsion from magnetic fields', 'Only repulsion, never attraction', 'Strong attraction to magnetic fields and the ability to be strongly magnetised'],
          'correct': 3,
        },
        {
          'question': 'Paramagnetic materials show?',
          'options': ['No response to magnetic fields at all', 'Strong permanent magnetisation', 'Strong repulsion from magnetic fields', 'Weak attraction to magnetic fields, with no permanent magnetisation'],
          'correct': 3,
        },
        {
          'question': 'Diamagnetic materials show?',
          'options': ['No properties related to magnetism', 'Strong attraction to magnetic fields', 'Strong permanent magnetism', 'Weak repulsion from magnetic fields'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an example of a ferromagnetic material?',
          'options': ['Aluminium (weakly paramagnetic)', 'Copper', 'Iron', 'Bismuth'],
          'correct': 2,
        },
        {
          'question': 'The temperature above which a ferromagnetic material loses its ferromagnetic properties is called the?',
          'options': ['Curie temperature', 'Melting point', 'Boiling point', 'Absolute zero'],
          'correct': 0,
        },
        {
          'question': 'Magnetic domains refer to?',
          'options': ['Regions with no magnetic properties', 'Small regions within a ferromagnetic material where atomic magnetic moments are aligned', 'Only regions found in non-magnetic materials', 'Individual atoms only'],
          'correct': 1,
        },
        {
          'question': 'In an unmagnetised piece of iron, the magnetic domains are?',
          'options': ['All aligned in the same direction', 'Aligned only at the poles', 'Absent entirely', 'Randomly oriented, cancelling out overall magnetic effect'],
          'correct': 3,
        },
        {
          'question': 'When a ferromagnetic material is magnetised, its domains become?',
          'options': ['More randomly oriented', 'Unaffected', 'Aligned in the same direction, producing a net magnetic field', 'Destroyed completely'],
          'correct': 2,
        },
        {
          'question': 'Earth\'s magnetic field is believed to be generated mainly by?',
          'options': ['Convective motion of molten iron in the outer core (geodynamo effect)', 'Radioactive decay in the crust', 'Magnetic rocks on the surface', 'Solar radiation'],
          'correct': 0,
        },
        {
          'question': 'Earth\'s magnetic north pole is actually a magnetic?',
          'options': ['South pole (attracting the north pole of a compass)', 'Neutral point', 'Point with no magnetic property', 'North pole'],
          'correct': 0,
        },
        {
          'question': 'A compass needle points towards Earth\'s geographic north because it aligns with?',
          'options': ['Earth\'s magnetic field', 'Earth\'s gravitational field', 'Earth\'s electric field', 'The sun\'s position'],
          'correct': 0,
        },
        {
          'question': 'The angle between the geographic north and magnetic north as indicated by a compass is called the?',
          'options': ['Magnetic declination', 'Magnetic latitude', 'Angle of dip', 'Angle of inclination'],
          'correct': 0,
        },
        {
          'question': 'The angle between the horizontal plane and the direction of Earth\'s magnetic field at a given location is called the?',
          'options': ['Magnetic latitude', 'Angle of dip (inclination)', 'Magnetic longitude', 'Magnetic declination'],
          'correct': 1,
        },
        {
          'question': 'At the magnetic poles, the angle of dip of Earth\'s magnetic field is approximately?',
          'options': ['90 degrees', '0 degrees', '45 degrees', '180 degrees'],
          'correct': 0,
        },
        {
          'question': 'At the magnetic equator, the angle of dip of Earth\'s magnetic field is approximately?',
          'options': ['45 degrees', '90 degrees', '180 degrees', '0 degrees'],
          'correct': 3,
        },
        {
          'question': 'The Hall effect refers to the?',
          'options': ['Attraction between two magnets', 'Production of a voltage across a current-carrying conductor placed in a magnetic field, perpendicular to both current and field', 'Generation of current without a battery', 'Loss of magnetism at high temperature'],
          'correct': 1,
        },
        {
          'question': 'The Hall effect is commonly used to determine the?',
          'options': ['Temperature of a conductor', 'Voltage of a battery only', 'Sign and density of charge carriers in a conductor', 'Resistance of a wire'],
          'correct': 2,
        },
        {
          'question': 'A magnetic field can be produced by all of the following EXCEPT?',
          'options': ['A current-carrying wire', 'A moving charge', 'A stationary charge', 'A permanent magnet'],
          'correct': 2,
        },
        {
          'question': 'Which of the following statements about magnetic monopoles is currently accepted in classical physics?',
          'options': ['All magnets have only one pole', 'Magnetic monopoles have not been experimentally confirmed to exist; magnets always have paired poles', 'Magnetic monopoles are the basis of all magnets', 'Magnetic monopoles have been definitively observed'],
          'correct': 1,
        },
        {
          'question': 'Cutting a bar magnet in half results in?',
          'options': ['A north pole only and a south pole only, each separate', 'Two smaller magnets, each with both a north and south pole', 'A single monopole', 'Complete loss of magnetism'],
          'correct': 1,
        },
        {
          'question': 'The magnetic force between two magnetic poles is described by an inverse relationship with the?',
          'options': ['Square of the distance between them', 'Current flowing', 'Resistance of the material', 'Product of pole strengths'],
          'correct': 0,
        },
        {
          'question': 'Like magnetic poles (e.g., north-north)?',
          'options': ['Have no interaction', 'Repel each other', 'Attract each other', 'Merge into one pole'],
          'correct': 1,
        },
        {
          'question': 'Unlike magnetic poles (e.g., north-south)?',
          'options': ['Attract each other', 'Cancel out completely', 'Repel each other', 'Have no interaction'],
          'correct': 0,
        },
        {
          'question': 'The magnetic flux through a surface is defined as the product of the magnetic field and the?',
          'options': ['Voltage', 'Current', 'Area perpendicular to the field', 'Resistance'],
          'correct': 2,
        },
        {
          'question': 'The formula for magnetic flux is Phi = ?',
          'options': ['BA sin(theta)', 'A/B', 'B/A', 'BA cos(theta)'],
          'correct': 3,
        },
        {
          'question': 'Magnetic flux is maximum when the magnetic field is?',
          'options': ['Zero', 'Parallel to the surface', 'Perpendicular to the surface', 'At 45 degrees to the surface'],
          'correct': 2,
        },
        {
          'question': 'Magnetic flux is zero when the magnetic field is?',
          'options': ['At any angle', 'Parallel to the surface (theta = 90 degrees)', 'Perpendicular to the surface', 'Always non-zero'],
          'correct': 1,
        },
        {
          'question': 'A galvanometer works based on the principle that a?',
          'options': ['Static charges create magnetic fields', 'Resistance changes with temperature', 'Magnetic field induces a voltage without current', 'Current-carrying coil in a magnetic field experiences a torque proportional to the current'],
          'correct': 3,
        },
        {
          'question': 'An ammeter is typically constructed by modifying a galvanometer with a?',
          'options': ['Capacitor', 'Series resistor (multiplier)', 'Parallel low resistance (shunt)', 'Diode'],
          'correct': 2,
        },
        {
          'question': 'A voltmeter is typically constructed by modifying a galvanometer with a?',
          'options': ['Series high resistance (multiplier)', 'Capacitor', 'Inductor only', 'Parallel low resistance (shunt)'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the magnetic field pattern between two parallel bar magnets placed with opposite poles facing each other?',
          'options': ['Random field lines with no pattern', 'Field lines that repel each other entirely', 'Nearly uniform field lines running from north to south between the poles', 'No field is produced'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the effect of increasing the number of turns in a current-carrying coil on the magnetic field it produces at its centre?',
          'options': ['The field decreases', 'The field becomes zero', 'The field increases proportionally with the number of turns', 'The field remains unchanged'],
          'correct': 2,
        },
        {
          'question': 'The magnetic field at the centre of a circular current-carrying loop is given by B = ?',
          'options': ['mu0 / (2 pi I)', 'mu0 I / (2R)', 'mu0 I R', 'mu0 R / I'],
          'correct': 1,
        },
        {
          'question': 'Which of the following materials would be most strongly attracted to a magnet?',
          'options': ['Glass', 'Plastic', 'Iron', 'Wood'],
          'correct': 2,
        },
        {
          'question': 'The permeability of a material describes its ability to?',
          'options': ['Support the formation of a magnetic field within itself', 'Store electric charge', 'Conduct electricity', 'Resist current flow'],
          'correct': 0,
        },
        {
          'question': 'Materials with high magnetic permeability, like soft iron, are often used as cores in?',
          'options': ['Batteries', 'Capacitors', 'Electromagnets and transformers, to strengthen the magnetic field', 'Resistors'],
          'correct': 2,
        },
        {
          'question': 'An electromagnet is best described as a magnet whose magnetic field is produced by?',
          'options': ['Friction', 'An electric current flowing through a coil, often wound around a soft iron core', 'Permanent alignment of domains only', 'Heat only'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is an advantage of an electromagnet over a permanent magnet?',
          'options': ['Its strength can be controlled and switched on/off by controlling the current', 'It requires no power source', 'Its magnetic field cannot be switched on or off', 'It never loses magnetism'],
          'correct': 0,
        },
        {
          'question': 'Which of these is a common application of electromagnets?',
          'options': ['Compasses', 'Permanent decorative magnets only', 'Solar panels', 'Electric bells, cranes for lifting scrap metal, and relays'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes magnetic shielding, used to protect sensitive equipment from external magnetic fields?',
          'options': ['A method with no practical use', 'Using magnets to increase field strength inside a region', 'Using materials of high magnetic permeability to redirect magnetic field lines away from a protected region', 'Only effective against electric fields'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best explains why a magnetic field does no work on a moving charged particle?',
          'options': ['The magnetic force is always parallel to velocity', 'The magnetic force is always perpendicular to velocity, so it changes direction but not speed', 'The magnetic force always opposes motion, doing negative work', 'Magnetic fields exert no force at all'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the motion of a charged particle entering a uniform magnetic field at an angle (not perpendicular or parallel) to the field?',
          'options': ['A straight line only', 'An elliptical path only', 'A stationary point', 'A helical (spiral) path'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the Van Allen radiation belts around Earth?',
          'options': ['Regions with no magnetic field at all', 'Layers of the atmosphere unrelated to magnetism', 'Regions of intense ultraviolet radiation', 'Regions where charged particles from the sun are trapped by Earth\'s magnetic field'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the aurora borealis (northern lights), related to Earth\'s magnetic field?',
          'options': ['A phenomenon caused by charged solar particles interacting with Earth\'s magnetic field and atmosphere near the poles', 'A reflection of sunlight off clouds', 'A type of lightning', 'A phenomenon unrelated to magnetism'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies the relationship between electricity and magnetism, first demonstrated experimentally by Hans Christian Oersted?',
          'options': ['Only permanent magnets can create magnetic fields', 'Electricity and magnetism are entirely unrelated phenomena', 'Electric currents produce magnetic fields', 'Magnetic fields cannot be produced by electric currents'],
          'correct': 2,
        },
        {
          'question': 'Which of the following correctly states the right-hand grip rule for a straight current-carrying wire?',
          'options': ['Use the left hand for current-carrying wires', 'Point the thumb in the direction of conventional current; the curled fingers show the direction of the magnetic field', 'Point the thumb in the direction of the magnetic field; fingers show current direction', 'The rule only applies to solenoids'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes why the magnetic force cannot change the kinetic energy of a charged particle?',
          'options': ['The force is always zero', 'The particle always loses energy due to friction', 'The force is always perpendicular to velocity, so it does zero work and cannot change speed/kinetic energy', 'The force is always parallel to displacement'],
          'correct': 2,
        },
        {
          'question': 'The SI unit of magnetic pole strength relates most directly to which of these quantities?',
          'options': ['Farad', 'Ohm', 'Volt', 'Ampere-metre'],
          'correct': 3,
        },
        {
          'question': 'Which of the following correctly describes a toroid, a type of magnetic coil?',
          'options': ['A type of permanent magnet with no coil', 'A solenoid bent into a closed loop (doughnut shape), confining the magnetic field mostly within the loop', 'A straight solenoid', 'A single circular loop only'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best explains why the magnetic field outside an ideal toroid is approximately zero?',
          'options': ['The field is entirely confined within the core of the toroid due to its closed loop geometry', 'Toroids produce no magnetic field at all', 'The field is always strongest outside the toroid', 'Toroids behave identically to straight wires'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains the difference between magnetic field strength (H) and magnetic flux density (B) in a material?',
          'options': ['They are always identical', 'B accounts for the magnetisation of the material itself, while H relates to the free current producing the field', 'There is no meaningful difference', 'H is only used in vacuum, B is only used in materials'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why a magnetic compass would not work reliably very close to a strong electromagnet?',
          'options': ['Electromagnets have no effect on compasses', 'Electromagnets cancel out all magnetic fields nearby', 'The electromagnet\'s field would dominate and distort the compass needle\'s alignment with Earth\'s field', 'Compasses only respond to gravity'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the concept of magnetic saturation in a ferromagnetic core?',
          'options': ['A point where the material loses all magnetism', 'A point where increasing the magnetising field no longer increases the material\'s magnetisation significantly', 'A point that occurs only in diamagnetic materials', 'A term unrelated to ferromagnetism'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes hysteresis in ferromagnetic materials, relevant to transformer and motor core design?',
          'options': ['The magnetisation of the material depends only on the current applied at that instant', 'The lagging of magnetisation behind the applied magnetic field, causing energy loss as heat during cyclic magnetisation', 'A property only seen in diamagnetic materials', 'A phenomenon unrelated to magnetism'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why soft iron (with low hysteresis loss) is preferred over hard steel for transformer cores?',
          'options': ['Hard steel is always a better conductor', 'Soft iron minimises energy loss due to hysteresis during rapid magnetisation/demagnetisation cycles in AC circuits', 'Hard steel has no hysteresis loss', 'Soft iron cannot be magnetised at all'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why a current balance experiment can be used to measure the force between current-carrying conductors and verify the relationship used to define the ampere?',
          'options': ['It measures gravitational force only', 'It measures electric field strength only', 'It has no relation to defining electrical units', 'It measures the magnetic force between parallel current-carrying wires, allowing calculation/verification of forces predicted by theory'],
          'correct': 3,
        },
      ];
    case 'phy102_u2_2': // Self and Mutual Inductance
      return [
        {
          'question': 'The SI unit of inductance is the?',
          'options': ['Weber', 'Farad', 'Tesla', 'Henry'],
          'correct': 3,
        },
        {
          'question': 'Self-inductance is best defined as the property of a circuit by which it opposes a change in?',
          'options': ['Capacitance', 'Resistance', 'Voltage', 'Current flowing through itself'],
          'correct': 3,
        },
        {
          'question': 'The formula relating induced EMF to self-inductance is EMF = ?',
          'options': ['L/I', 'IR', 'LI', '-L(dI/dt)'],
          'correct': 3,
        },
        {
          'question': 'The negative sign in the self-induction EMF formula reflects?',
          'options': ['Lenz\'s law (opposing the change producing it)', 'Newton\'s third law only', 'Ohm\'s law', 'Coulomb\'s law'],
          'correct': 0,
        },
        {
          'question': 'An increase in current through an inductor induces an EMF that?',
          'options': ['Aids the increase in current', 'Has no effect on the current', 'Instantly stops the current', 'Opposes the increase in current'],
          'correct': 3,
        },
        {
          'question': 'A decrease in current through an inductor induces an EMF that?',
          'options': ['Reverses the circuit\'s polarity permanently', 'Opposes the decrease (tries to maintain the current)', 'Has no effect', 'Aids the decrease'],
          'correct': 1,
        },
        {
          'question': 'Self-inductance of a coil depends on all of the following EXCEPT?',
          'options': ['Core material', 'Number of turns', 'Cross-sectional area', 'Colour of the wire'],
          'correct': 3,
        },
        {
          'question': 'The self-inductance of a long solenoid is given by L = ?',
          'options': ['mu0 I / l', 'mu0 A / n', 'mu0 n^2 A l', 'mu0 n A'],
          'correct': 2,
        },
        {
          'question': 'Increasing the number of turns on a solenoid, while keeping other factors constant, will?',
          'options': ['Increase its self-inductance', 'Decrease its self-inductance', 'Eliminate inductance entirely', 'Have no effect on inductance'],
          'correct': 0,
        },
        {
          'question': 'Mutual inductance describes the property where a changing current in one coil induces an?',
          'options': ['EMF in a neighbouring (nearby) coil', 'EMF in the same coil only', 'Electric field only, no EMF', 'No effect on any coil'],
          'correct': 0,
        },
        {
          'question': 'The formula relating the EMF induced in a secondary coil due to mutual inductance is EMF2 = ?',
          'options': ['I1 R', 'M/I1', 'M I1', '-M(dI1/dt)'],
          'correct': 3,
        },
        {
          'question': 'In the mutual inductance formula, \'M\' represents the?',
          'options': ['Self-inductance of the primary coil', 'Resistance', 'Magnetic flux only', 'Mutual inductance between the two coils'],
          'correct': 3,
        },
        {
          'question': 'Mutual inductance between two coils depends on all of the following EXCEPT?',
          'options': ['The colour of the wire insulation', 'Number of turns in each coil', 'Core material', 'Distance and orientation between the coils'],
          'correct': 0,
        },
        {
          'question': 'The mutual inductance between two coils is generally increased by?',
          'options': ['Moving the coils farther apart', 'Placing the coils closer together and aligning their axes', 'Reducing the number of turns', 'Removing any magnetic core'],
          'correct': 1,
        },
        {
          'question': 'Which of these devices operates primarily on the principle of mutual inductance?',
          'options': ['Diode', 'Resistor', 'Transformer', 'Capacitor'],
          'correct': 2,
        },
        {
          'question': 'The energy stored in an inductor carrying current I is given by U = ?',
          'options': ['LI', 'LI^2', '(1/2)L/I', '(1/2)LI^2'],
          'correct': 3,
        },
        {
          'question': 'Increasing the current through an inductor will cause the stored magnetic energy to?',
          'options': ['Remain constant', 'Become negative', 'Decrease', 'Increase (proportional to the square of current)'],
          'correct': 3,
        },
        {
          'question': 'An inductor in a circuit initially opposes a sudden change in current because of?',
          'options': ['Ohmic heating only', 'Capacitive reactance', 'The induced back-EMF due to self-inductance', 'Its resistance only'],
          'correct': 2,
        },
        {
          'question': 'In a circuit with an inductor, when current is suddenly switched on, the current?',
          'options': ['Rises gradually, opposed initially by the induced back-EMF', 'Rises instantly to maximum value', 'Oscillates chaotically with no pattern', 'Remains zero forever'],
          'correct': 0,
        },
        {
          'question': 'The time constant of an RL circuit (resistor-inductor series circuit) is given by tau = ?',
          'options': ['R/L', 'L/R', '1/(LR)', 'LR'],
          'correct': 1,
        },
        {
          'question': 'A larger time constant in an RL circuit means the current?',
          'options': ['Immediately reaches maximum', 'Never reaches a steady value', 'Takes longer to reach its final steady value', 'Reaches its final steady value more quickly'],
          'correct': 2,
        },
        {
          'question': 'When the switch is closed in an RL circuit, the current through the inductor grows according to an equation involving which mathematical function?',
          'options': ['Linear function', 'Sinusoidal function only', 'Exponential function (approaching a maximum asymptotically)', 'Logarithmic decrease'],
          'correct': 2,
        },
        {
          'question': 'When the switch is opened in an RL circuit (with current decaying), the current decreases according to?',
          'options': ['An exponential decay function', 'An instant drop to zero', 'A sinusoidal increase', 'A linear function'],
          'correct': 0,
        },
        {
          'question': 'Two coils are said to be inductively coupled when?',
          'options': ['A changing current in one coil induces an EMF in the other due to shared magnetic flux', 'They are connected only by resistors', 'They share no magnetic flux', 'They have no physical or magnetic relationship'],
          'correct': 0,
        },
        {
          'question': 'The coefficient of coupling (k) between two coils indicates?',
          'options': ['The fraction of magnetic flux from one coil that links with the other, ranging from 0 to 1', 'The physical distance between coils only', 'The voltage ratio only', 'The resistance between coils'],
          'correct': 0,
        },
        {
          'question': 'A coefficient of coupling of k = 1 between two coils indicates?',
          'options': ['Coils are electrically shorted', 'Perfect (ideal) magnetic coupling, with all flux from one coil linking the other', 'No magnetic coupling at all', 'An error in measurement'],
          'correct': 1,
        },
        {
          'question': 'The relationship between mutual inductance and the self-inductances of two coupled coils is given by M = ?',
          'options': ['L1 + L2', 'k * sqrt(L1 * L2)', 'L1 * L2', 'k / (L1 * L2)'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a step-up transformer in terms of mutual inductance principles?',
          'options': ['It has more turns in the primary coil than secondary, decreasing voltage', 'It has equal turns in both coils', 'It uses no magnetic coupling', 'It has more turns in the secondary coil than primary, increasing voltage'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes a step-down transformer?',
          'options': ['More turns in secondary than primary, increasing voltage', 'No mutual inductance involved', 'Equal turns, no voltage change', 'More turns in primary than secondary, decreasing voltage'],
          'correct': 3,
        },
        {
          'question': 'An inductor opposes changes in current, similar to how a capacitor opposes changes in?',
          'options': ['Current', 'Voltage', 'Power', 'Resistance'],
          'correct': 1,
        },
        {
          'question': 'The reactance of an inductor in an AC circuit is given by XL = ?',
          'options': ['R', '1/(2 pi f C)', 'V/I only for DC', '2 pi f L'],
          'correct': 3,
        },
        {
          'question': 'Inductive reactance increases with?',
          'options': ['Decreasing frequency', 'Increasing frequency', 'Zero frequency (DC)', 'Decreasing inductance'],
          'correct': 1,
        },
        {
          'question': 'In a purely inductive AC circuit, the current lags the voltage by?',
          'options': ['90 degrees', '0 degrees', '180 degrees', '45 degrees'],
          'correct': 0,
        },
        {
          'question': 'In a purely inductive AC circuit, the phase relationship between voltage and current is such that?',
          'options': ['Voltage and current are out of phase by 180 degrees', 'Voltage leads current by 90 degrees', 'Current leads voltage by 90 degrees', 'Voltage and current are in phase'],
          'correct': 1,
        },
        {
          'question': 'An inductor connected to a DC source (after reaching steady state) behaves like a?',
          'options': ['Short circuit (zero resistance to steady current)', 'Perfect insulator', 'Capacitor', 'Open circuit (infinite resistance)'],
          'correct': 0,
        },
        {
          'question': 'An inductor connected suddenly to a DC source initially behaves like a?',
          'options': ['Open circuit, opposing the initial surge of current', 'Short circuit', 'Resistor of fixed value only', 'Capacitor fully charged'],
          'correct': 0,
        },
        {
          'question': 'A capacitor connected suddenly to a DC source initially behaves like a?',
          'options': ['Short circuit, allowing maximum initial current', 'Resistor of fixed value', 'Open circuit', 'Inductor'],
          'correct': 0,
        },
        {
          'question': 'A capacitor connected to a DC source after reaching steady state behaves like a?',
          'options': ['Perfect conductor', 'Open circuit (fully charged, no current flows)', 'Inductor', 'Short circuit'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains eddy currents, relevant to inductors and transformer cores?',
          'options': ['Currents induced in a conductor by a changing magnetic field, circulating within the material and causing energy loss as heat', 'Currents unrelated to magnetic fields', 'Currents that flow only through resistors', 'Currents found only in insulators'],
          'correct': 0,
        },
        {
          'question': 'Laminated iron cores are used in transformers primarily to?',
          'options': ['Increase eddy current losses', 'Increase resistance to magnetic flux', 'Eliminate mutual inductance', 'Reduce eddy current losses by limiting the paths for induced currents'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes a choke (inductor) used in AC circuits?',
          'options': ['A component that blocks high-frequency AC while allowing DC to pass freely, due to its impedance increasing with frequency', 'A device that blocks only DC', 'A device with no frequency-dependent behaviour', 'A component identical to a resistor'],
          'correct': 0,
        },
        {
          'question': 'The total inductance of two inductors connected in series (assuming no mutual inductance) is given by Ltotal = ?',
          'options': ['L1 + L2', '1/L1 + 1/L2', 'L1 * L2 / (L1 + L2)', 'L1 - L2'],
          'correct': 0,
        },
        {
          'question': 'The total inductance of two inductors connected in parallel (assuming no mutual inductance) is given by 1/Ltotal = ?',
          'options': ['L1 * L2', '1/L1 + 1/L2', 'L1 - L2', 'L1 + L2'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why a rapidly changing current in a coil can produce sparking at a switch when the circuit is opened?',
          'options': ['Only resistors can cause sparking', 'Sparking occurs only in capacitive circuits', 'Sparking is unrelated to inductance', 'The sudden change in current induces a large back-EMF due to self-inductance, which can cause arcing'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the role of self-inductance in a fluorescent lamp\'s ballast circuit?',
          'options': ['It limits current surge and helps generate the high voltage needed to start the lamp', 'It only provides resistance', 'It stores charge like a capacitor', 'It has no functional role'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies an application that relies primarily on mutual inductance?',
          'options': ['Solar photovoltaic cells', 'Capacitive touchscreens', 'Resistor heating', 'Wireless (inductive) charging of devices'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes an induction coil (used historically to generate high-voltage sparks)?',
          'options': ['A device using self and mutual inductance with a rapidly interrupted primary current to induce a high voltage in a secondary coil', 'A device unrelated to electromagnetic induction', 'A device using only resistors', 'A capacitor-based device'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why increasing the core permeability (e.g., using iron instead of air) increases a coil\'s inductance?',
          'options': ['A higher permeability core concentrates and strengthens the magnetic flux for a given current, increasing inductance', 'Only air cores can produce inductance', 'Iron cores always decrease inductance', 'Permeability has no effect on inductance'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes an air-core inductor compared to an iron-core inductor of the same geometry?',
          'options': ['Both have identical inductance', 'Air-core inductors cannot function in circuits', 'The air-core inductor always has higher inductance', 'The air-core inductor generally has lower inductance due to lower permeability'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the term \'back EMF\' as related to self-inductance in a coil?',
          'options': ['An EMF induced in a coil that opposes the change in current causing it, consistent with Lenz\'s law', 'An EMF that aids any change in current', 'An EMF that only occurs in resistors', 'An EMF unrelated to inductance'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why transformers only work with alternating current (AC) and not with steady direct current (DC)?',
          'options': ['DC produces a stronger magnetic flux than AC', 'Transformers work equally well with DC and AC', 'Mutual inductance requires a continuously changing magnetic flux, which only occurs with a changing (AC) current', 'Mutual inductance is unrelated to changing flux'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the function of an RL low-pass filter circuit, using an inductor\'s frequency-dependent impedance?',
          'options': ['It allows low frequencies to pass more easily than high frequencies, since inductive reactance increases with frequency', 'It allows high frequencies to pass while blocking low frequencies', 'It blocks all frequencies equally', 'It has no frequency-dependent behaviour'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the phenomenon of \'flux linkage\' in the context of inductance?',
          'options': ['The resistance of a coil', 'The total magnetic flux linking all turns of a coil, calculated as N times the flux through one turn', 'The current flowing through a coil', 'A term unrelated to inductance'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why a solenoid with an iron core has significantly higher inductance than an identical air-core solenoid?',
          'options': ['Air always has higher permeability than iron', 'The iron core increases the permeability of the magnetic path, greatly enhancing magnetic flux for the same current', 'Iron has no effect on magnetic properties', 'Iron cores block all magnetic flux'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes why sudden interruption of current in a highly inductive circuit (like a relay coil) can damage nearby switch contacts or components?',
          'options': ['The rapid collapse of the magnetic field induces a very high transient voltage spike (back-EMF)', 'Voltage spikes only occur in capacitive circuits', 'Only resistive circuits generate voltage spikes', 'Interrupting current in an inductive circuit has no electrical effect'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes a flyback diode (freewheeling diode) used in circuits with inductive loads like relay coils?',
          'options': ['It provides a safe path for the induced current when the circuit is switched off, protecting other components from voltage spikes', 'It increases the voltage spike intentionally', 'It is only used in purely resistive circuits', 'It has no protective function'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why the primary and secondary coils of a transformer are usually wound around a common iron core?',
          'options': ['To eliminate the need for insulation', 'To minimise mutual inductance', 'To maximise electrical connection between the coils', 'To maximise mutual inductance by ensuring most magnetic flux from the primary links with the secondary coil'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes leakage flux in a transformer or coupled coil system?',
          'options': ['The portion of magnetic flux produced by one coil that does not link with the other coil, reducing coupling efficiency', 'Flux found only in resistors', 'A term unrelated to inductance', 'Flux that links both coils perfectly'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the ideal assumption of \'tight coupling\' (k close to 1) between coils in transformer analysis?',
          'options': ['Coupling has no effect on transformer performance', 'Almost all magnetic flux produced by the primary coil links with the secondary coil, minimising leakage flux', 'The coils are electrically connected directly', 'No flux links between the coils'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why an inductor\'s stored energy is associated with its magnetic field, similar to a capacitor\'s stored energy being associated with its electric field?',
          'options': ['Capacitors store energy only as heat', 'Both types of energy storage are unrelated to fields', 'Energy in an inductor is stored in the magnetic field generated by the current, analogous to electric field energy storage in a capacitor', 'Inductors store no energy at all'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies the unit conversion: 1 Henry equals?',
          'options': ['1 Ohm per second', '1 Volt-second per Ampere', '1 Ampere per Volt-second', '1 Coulomb per second'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why long cables or coils used at high frequencies can exhibit significant unwanted self-inductance effects?',
          'options': ['Self-inductance only matters at zero frequency', 'Self-inductance effects are negligible at all frequencies', 'Cables have no inductive properties', 'At high frequencies, the rate of change of current is greater, so induced back-EMF effects due to self-inductance become more significant'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes why toroidal (doughnut-shaped) inductors are often preferred in certain circuits over straight solenoid inductors?',
          'options': ['Toroids cannot be used with iron cores', 'Toroids always have lower inductance than solenoids', 'Toroids radiate more magnetic field than solenoids', 'Toroids confine the magnetic field almost entirely within the core, minimising electromagnetic interference with nearby components'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why two coils placed with their axes perpendicular to each other (at 90 degrees) typically have minimal mutual inductance?',
          'options': ['Only parallel coils can be inductively coupled at all', 'Perpendicular coils always maximise mutual inductance', 'Perpendicular orientation minimises the magnetic flux from one coil passing through the area of the other coil', 'Orientation has no effect on mutual inductance'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the working principle of a Tesla coil, which relies heavily on mutual inductance and resonance?',
          'options': ['It relies solely on capacitive coupling with no inductance', 'It has no relation to mutual inductance', 'It uses two magnetically coupled resonant circuits to generate very high AC voltages', 'It works using only resistors with no coupling'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why superconducting coils can maintain very high currents and strong magnetic fields with minimal energy loss?',
          'options': ['Superconductors have very high resistance', 'Superconductors cannot carry current', 'Superconductors eliminate inductance entirely', 'Superconductors have zero electrical resistance, eliminating resistive (I^2R) energy losses even at very high currents'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes Faraday\'s law of electromagnetic induction as it relates to self and mutual inductance?',
          'options': ['EMF is induced only by direct contact between circuits', 'Faraday\'s law applies only to permanent magnets', 'An induced EMF is produced in a circuit whenever the magnetic flux linked with it changes, with magnitude proportional to the rate of change of flux', 'Induced EMF is unrelated to flux change'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes Lenz\'s law in the context of self-inductance?',
          'options': ['Lenz\'s law is unrelated to inductance', 'Lenz\'s law applies only to mutual inductance, not self-inductance', 'The induced EMF always acts in a direction to aid the change producing it', 'The induced EMF always acts to oppose the change in current/flux that produces it, conserving energy'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why energy must be supplied to increase the current through an inductor?',
          'options': ['Increasing current in an inductor releases energy spontaneously', 'Energy is only needed for resistive heating, not for the inductor itself', 'No energy is needed to change current in an inductor', 'Energy is required to work against the induced back-EMF, which is then stored in the magnetic field'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes why an ideal inductor (with zero resistance) dissipates no power on average in a purely inductive AC circuit?',
          'options': ['Voltage and current are 90 degrees out of phase, so the average power delivered over a full cycle is zero', 'Power dissipation is unrelated to phase difference', 'Inductors always dissipate maximum power', 'Voltage and current are in phase, so average power is maximum'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes why real inductors (with some resistance) do dissipate some power, unlike ideal inductors?',
          'options': ['The resistive component of a real inductor causes I^2R heating losses, in addition to energy storage in the magnetic field', 'Real inductors store no magnetic energy', 'Power dissipation only occurs in capacitors', 'Real inductors have no resistance at all'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes an inductor used in an LC (inductor-capacitor) resonant circuit?',
          'options': ['LC circuits cannot oscillate', 'The inductor blocks all current in an LC circuit', 'Only resistors are needed for resonance', 'The inductor and capacitor exchange energy back and forth, oscillating at a characteristic resonant frequency'],
          'correct': 3,
        },
        {
          'question': 'The resonant frequency of an ideal LC circuit is given by f = ?',
          'options': ['1/(2 pi sqrt(LC))', 'LC', '2 pi sqrt(LC)', '1/(LC)'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why increasing either the inductance or capacitance in an LC circuit decreases its resonant frequency?',
          'options': ['Only capacitance affects resonant frequency', 'Both L and C appear in the denominator (under a square root) of the resonant frequency formula, so increasing either decreases the frequency', 'Increasing L or C always increases frequency', 'Resonant frequency is independent of L and C'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why transformers are essential for efficient long-distance electrical power transmission?',
          'options': ['Transformers have no role in power transmission', 'Transformers increase transmission losses', 'They allow voltage to be stepped up for transmission (reducing current and resistive losses) and stepped down for safe distribution', 'Transformers only work with DC power transmission'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why stepping up voltage before transmission reduces power loss in transmission lines?',
          'options': ['Voltage has no relation to current or power loss', 'Only resistance affects power loss, not voltage or current', 'Power loss (I^2R) decreases because current is reduced for the same power when voltage is increased', 'Power loss increases with higher voltage'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies the primary coil of a transformer as the coil that?',
          'options': ['Receives the induced EMF/output', 'Is always the coil with fewer turns', 'Is connected to the input AC power source', 'Has no role in mutual inductance'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies the secondary coil of a transformer as the coil that?',
          'options': ['Delivers the induced (output) EMF to the load', 'Has no magnetic coupling with the primary', 'Is connected to the input power source', 'Always has the same number of turns as the primary'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the transformer turns ratio, relating primary and secondary voltages? Vs/Vp = ?',
          'options': ['Np/Ns', '1/(Ns * Np)', 'Ns * Np', 'Ns/Np'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the relationship between current and turns ratio in an ideal transformer, assuming no power loss? Is/Ip = ?',
          'options': ['Ip/Vp', 'Np/Ns', 'Ns/Np', 'Ns * Np'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why an ideal transformer conserves power (Vp * Ip = Vs * Is)?',
          'options': ['Energy is created within the transformer', 'Transformers violate energy conservation', 'Power is always doubled by a transformer', 'Assuming no losses, the power input to the primary coil equals the power output from the secondary coil, by conservation of energy'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes copper losses in a real transformer?',
          'options': ['A term unrelated to transformer inefficiency', 'Energy loss due to the resistance of the primary and secondary windings, dissipated as heat (I^2R losses)', 'Losses due to magnetic flux leakage only', 'Losses that occur only in the core'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes iron (core) losses in a real transformer, including hysteresis and eddy current losses?',
          'options': ['Losses that only occur in air-core transformers', 'Energy losses occurring in the windings only', 'A term unrelated to transformer efficiency', 'Energy losses occurring in the magnetic core due to hysteresis and induced eddy currents'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why real transformers are not 100% efficient, despite the ideal transformer equations assuming no losses?',
          'options': ['Real transformers have zero resistance and zero core losses', 'Real transformers experience copper losses (resistive heating) and iron losses (hysteresis and eddy currents), reducing efficiency below 100%', 'Efficiency is unrelated to resistance or core losses', 'Real transformers always operate above 100% efficiency'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why a transformer cannot be used to step up or step down a constant DC voltage?',
          'options': ['Transformers work better with DC than AC', 'A constant DC current produces no changing magnetic flux, so no EMF is induced in the secondary coil via mutual inductance', 'DC voltage steps up perfectly well through a transformer', 'DC has no relationship to magnetic flux'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes an autotransformer, a specific type of transformer design?',
          'options': ['A transformer with no magnetic core', 'A transformer with completely separate primary and secondary windings', 'A transformer that only works with DC', 'A transformer using a single winding, with part of it shared between primary and secondary circuits'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes a variable inductor, such as one with a movable ferrite core?',
          'options': ['A capacitor with variable capacitance', 'A device unrelated to magnetic cores', 'An inductor with fixed inductance only', 'An inductor whose inductance can be adjusted by changing the position of a magnetic core within the coil'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes why bifilar winding (winding two wires together) is sometimes used to minimise unwanted self-inductance in resistors or precision components?',
          'options': ['The opposing current directions in the two closely wound wires largely cancel the net magnetic field, reducing inductance', 'It has no effect on inductance', 'It maximises inductance intentionally', 'It is used only in capacitors'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes why the mutual inductance between two coils is a reciprocal quantity (M12 = M21)?',
          'options': ['By the reciprocity theorem, the mutual inductance is the same regardless of which coil is considered the source, given ideal coupling conditions', 'The mutual inductance from coil 1 to coil 2 is always different from coil 2 to coil 1', 'Reciprocity does not apply to inductance', 'Mutual inductance only applies in one direction between coils'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the use of coupled inductors in RF (radio frequency) transformers used in communication devices?',
          'options': ['To transfer signals between circuit stages while providing impedance matching and electrical isolation via mutual inductance', 'Coupled inductors have no role in RF applications', 'RF transformers cannot use mutual inductance principles', 'RF transformers use only capacitors, not inductance'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly explains why increasing the cross-sectional area of a solenoid\'s core increases its self-inductance?',
          'options': ['Only the length of a solenoid affects inductance', 'Cross-sectional area has no effect on inductance', 'A larger cross-sectional area allows more magnetic flux to be generated for a given current, increasing inductance according to L = mu0 n^2 A l', 'Increasing area always decreases inductance'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why the length of a solenoid affects its self-inductance inversely, according to L = mu0 n^2 A l (where n = N/l)?',
          'options': ['Only current affects a solenoid\'s inductance', 'A longer solenoid, for a fixed number of turns, has fewer turns per unit length, generally reducing the field strength and thus inductance for the same total length assumption', 'Increasing length always increases inductance regardless of turns per length', 'Length has no effect on inductance at all'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why a coil\'s inductance is generally much higher when wound around a ferromagnetic core compared to a non-magnetic (e.g., wood or plastic) core?',
          'options': ['Ferromagnetic cores have much higher magnetic permeability, greatly enhancing the magnetic flux for the same current and turns', 'Ferromagnetic materials block all magnetic flux', 'Non-magnetic cores always produce stronger fields', 'Core material has no effect on inductance'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies why inductors are widely used in power supply filter circuits, often paired with capacitors?',
          'options': ['Only resistors are used in power supply filters', 'Inductors block low-frequency signals while allowing high-frequency signals to pass, the opposite of what is needed for filtering', 'Inductors have no filtering applications', 'Inductors help smooth out fluctuations in current, working with capacitors to filter out unwanted AC ripple from a DC output'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the term \'quality factor\' (Q) of an inductor, relevant to its efficiency in AC circuits?',
          'options': ['A term unrelated to inductors', 'A measure of how much resistive loss occurs relative to the inductive reactance, with higher Q indicating lower relative losses', 'A measure of an inductor\'s physical size only', 'A term describing only capacitors'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why wireless charging pads for phones rely on mutual inductance between two coils?',
          'options': ['Wireless charging uses direct electrical contact, not induction', 'Wireless charging relies solely on capacitive coupling', 'Mutual inductance has no role in wireless charging', 'A changing current in the transmitter coil induces a changing magnetic flux that links with the receiver coil, inducing a current to charge the device'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes why placing a phone precisely on a wireless charging pad improves charging efficiency?',
          'options': ['Proper alignment maximises the mutual inductance (coupling) between the transmitter and receiver coils', 'Only distance matters, not alignment', 'Wireless charging efficiency is unrelated to coil coupling', 'Alignment has no effect on charging efficiency'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why a step-up transformer used at a power plant increases voltage while decreasing current, keeping power roughly constant?',
          'options': ['Voltage and current both increase together in a step-up transformer', 'Following the ideal transformer power conservation relation Vp Ip = Vs Is, increasing voltage requires a proportional decrease in current for constant power', 'Power is not conserved in transformers', 'Step-up transformers increase both voltage and current'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why the primary and secondary windings of a transformer are electrically isolated from each other despite being magnetically coupled?',
          'options': ['They are connected by direct electrical wires', 'The windings must always touch to function', 'Isolation is impossible in transformers', 'They are linked only through the shared magnetic flux in the core, with no direct electrical (galvanic) connection between the windings'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the practical benefit of electrical isolation provided by transformers, in addition to voltage transformation?',
          'options': ['Isolation increases the risk of electric shock', 'Isolation has no practical benefit', 'Isolation only matters for step-down transformers', 'It provides safety by preventing direct electrical contact between circuits, useful in isolating sensitive equipment or providing ground isolation'],
          'correct': 3,
        },
      ];
    case 'phy102_u2_3': // EM Wave Properties
      return [
        {
          'question': 'Electromagnetic waves consist of oscillating?',
          'options': ['Only electric fields', 'Sound pressure waves', 'Only magnetic fields', 'Perpendicular oscillating electric and magnetic fields'],
          'correct': 3,
        },
        {
          'question': 'Electromagnetic waves are classified as?',
          'options': ['Transverse waves', 'Longitudinal waves', 'Neither transverse nor longitudinal', 'Mechanical waves requiring a medium'],
          'correct': 0,
        },
        {
          'question': 'Unlike sound waves, electromagnetic waves can travel through?',
          'options': ['Only air', 'Only solids', 'A vacuum (empty space)', 'Nothing at all'],
          'correct': 2,
        },
        {
          'question': 'The speed of electromagnetic waves in a vacuum is approximately?',
          'options': ['3 x 10^3 m/s', '3 x 10^10 m/s', '3 x 10^8 m/s', '3 x 10^5 m/s'],
          'correct': 2,
        },
        {
          'question': 'The speed of light in a vacuum is denoted by the symbol?',
          'options': ['f', 'v', 'c', 'lambda'],
          'correct': 2,
        },
        {
          'question': 'The relationship between the speed, frequency, and wavelength of a wave is given by c = ?',
          'options': ['f * lambda', 'f + lambda', 'f / lambda', 'f - lambda'],
          'correct': 0,
        },
        {
          'question': 'As the frequency of an electromagnetic wave increases (with constant speed c), its wavelength?',
          'options': ['Increases', 'Remains constant', 'Decreases', 'Becomes infinite'],
          'correct': 2,
        },
        {
          'question': 'In electromagnetic waves, the electric field and magnetic field oscillate?',
          'options': ['In the same direction as wave propagation', 'Perpendicular to each other and to the direction of wave propagation', 'Randomly with no fixed relationship', 'Parallel to each other but not to propagation direction'],
          'correct': 1,
        },
        {
          'question': 'Electromagnetic waves were first theoretically predicted by?',
          'options': ['Isaac Newton', 'Michael Faraday', 'James Clerk Maxwell', 'Albert Einstein'],
          'correct': 2,
        },
        {
          'question': 'Maxwell\'s equations unify the theories of?',
          'options': ['Gravity and motion', 'Electricity and magnetism', 'Thermodynamics and optics', 'Quantum mechanics and relativity'],
          'correct': 1,
        },
        {
          'question': 'The electromagnetic spectrum, arranged from lowest to highest frequency, generally begins with?',
          'options': ['Gamma rays', 'Radio waves', 'X-rays', 'Visible light'],
          'correct': 1,
        },
        {
          'question': 'The electromagnetic spectrum, arranged from lowest to highest frequency, generally ends with?',
          'options': ['Microwaves', 'Infrared', 'Gamma rays', 'Radio waves'],
          'correct': 2,
        },
        {
          'question': 'Which of these has the longest wavelength in the electromagnetic spectrum?',
          'options': ['Radio waves', 'Ultraviolet', 'Visible light', 'Gamma rays'],
          'correct': 0,
        },
        {
          'question': 'Which of these has the shortest wavelength in the electromagnetic spectrum?',
          'options': ['Radio waves', 'Microwaves', 'Gamma rays', 'Infrared'],
          'correct': 2,
        },
        {
          'question': 'Which of these has the highest frequency in the electromagnetic spectrum?',
          'options': ['Gamma rays', 'X-rays', 'Visible light', 'Radio waves'],
          'correct': 0,
        },
        {
          'question': 'Which of these has the highest photon energy in the electromagnetic spectrum?',
          'options': ['Microwaves', 'Infrared', 'Gamma rays', 'Radio waves'],
          'correct': 2,
        },
        {
          'question': 'The energy of an electromagnetic wave\'s photon is given by E = ?',
          'options': ['hc', 'h/f', 'h + f', 'hf'],
          'correct': 3,
        },
        {
          'question': 'In the photon energy formula E = hf, \'h\' represents?',
          'options': ['The wavelength', 'The speed of light', 'Planck\'s constant', 'The frequency'],
          'correct': 2,
        },
        {
          'question': 'As the frequency of a photon increases, its energy?',
          'options': ['Increases', 'Becomes zero', 'Remains constant', 'Decreases'],
          'correct': 0,
        },
        {
          'question': 'Visible light occupies which position in the electromagnetic spectrum, relative to infrared and ultraviolet?',
          'options': ['Below radio waves', 'Above gamma rays', 'Between infrared and ultraviolet', 'At the very lowest frequency end'],
          'correct': 2,
        },
        {
          'question': 'The approximate wavelength range of visible light is?',
          'options': ['1-10 metres', '1-10 nanometres', '400-700 metres', '400-700 nanometres'],
          'correct': 3,
        },
        {
          'question': 'Which colour of visible light has the longest wavelength?',
          'options': ['Red', 'Blue', 'Violet', 'Green'],
          'correct': 0,
        },
        {
          'question': 'Which colour of visible light has the shortest wavelength?',
          'options': ['Violet', 'Yellow', 'Orange', 'Red'],
          'correct': 0,
        },
        {
          'question': 'Infrared radiation has a wavelength that is generally?',
          'options': ['Longer than radio waves', 'Identical to visible light', 'Longer than visible light', 'Shorter than visible light'],
          'correct': 2,
        },
        {
          'question': 'Ultraviolet radiation has a wavelength that is generally?',
          'options': ['Longer than visible light', 'Longer than radio waves', 'Identical to infrared', 'Shorter than visible light'],
          'correct': 3,
        },
        {
          'question': 'X-rays have wavelengths that are generally?',
          'options': ['Longer than visible light', 'Shorter than ultraviolet light', 'Longer than radio waves', 'Equal to visible light'],
          'correct': 1,
        },
        {
          'question': 'Gamma rays are typically produced by?',
          'options': ['Ordinary light bulbs', 'Household electrical circuits', 'Nuclear reactions and radioactive decay', 'Sound sources'],
          'correct': 2,
        },
        {
          'question': 'Radio waves are commonly used for?',
          'options': ['Communication (broadcasting, radio, television)', 'Medical imaging', 'Cancer treatment primarily', 'Sterilising medical equipment'],
          'correct': 0,
        },
        {
          'question': 'Microwaves are commonly used for?',
          'options': ['Killing cancer cells directly as primary use', 'Radio broadcasting only', 'Producing visible light directly', 'Cooking food and radar/communication'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes polarisation of an electromagnetic wave?',
          'options': ['A property unique to sound waves', 'The restriction of the electric field\'s oscillation to a single plane', 'A change in wave frequency', 'A change in wave speed'],
          'correct': 1,
        },
        {
          'question': 'Unpolarised light contains electric field oscillations in?',
          'options': ['Only two perpendicular planes', 'Only one plane', 'Multiple planes, oriented randomly', 'No planes at all'],
          'correct': 2,
        },
        {
          'question': 'A polarising filter allows through light waves whose electric field oscillates?',
          'options': ['Only along the filter\'s transmission axis', 'None of the light at all', 'In all directions equally', 'Only perpendicular to the transmission axis'],
          'correct': 0,
        },
        {
          'question': 'Passing unpolarised light through a single polarising filter typically reduces its intensity by approximately?',
          'options': ['100%', '0%', '50%', '25%'],
          'correct': 2,
        },
        {
          'question': 'Two polarising filters with perpendicular transmission axes (crossed polarisers) will result in?',
          'options': ['Little to no light transmission', 'No effect on the light', 'Doubled light intensity', 'Maximum light transmission'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why polarised sunglasses reduce glare from reflective surfaces like water?',
          'options': ['They have no effect on polarised light', 'They increase the intensity of reflected light', 'They block horizontally polarised light, which is common in glare reflected off horizontal surfaces', 'They block all light equally'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the phenomenon of diffraction as it applies to electromagnetic waves?',
          'options': ['The complete blocking of waves by any obstacle', 'A change in wave frequency due to an obstacle', 'The bending of waves around obstacles or through openings', 'A phenomenon exclusive to sound waves'],
          'correct': 2,
        },
        {
          'question': 'Diffraction effects become more noticeable when the size of an obstacle or opening is?',
          'options': ['Completely unrelated to wavelength', 'Comparable to or smaller than the wavelength', 'Always exactly equal to the speed of light', 'Much larger than the wavelength'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes interference of electromagnetic waves?',
          'options': ['A phenomenon that only occurs with sound waves', 'The complete cancellation of all waves involved', 'A change in the speed of waves', 'The combination of two or more waves resulting in a new wave pattern, which can be constructive or destructive'],
          'correct': 3,
        },
        {
          'question': 'Constructive interference occurs when waves combine?',
          'options': ['Out of phase, cancelling each other', 'Only in a vacuum', 'Randomly, with unpredictable results', 'In phase, reinforcing each other to produce a larger amplitude'],
          'correct': 3,
        },
        {
          'question': 'Destructive interference occurs when waves combine?',
          'options': ['In phase, reinforcing each other', 'Only in solids', 'Out of phase, partially or completely cancelling each other', 'Only at the speed of light'],
          'correct': 2,
        },
        {
          'question': 'Young\'s double-slit experiment is a classic demonstration of which wave property of light?',
          'options': ['Reflection', 'Absorption', 'Polarisation only', 'Interference (and diffraction)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the Doppler effect as applied to electromagnetic waves, such as light from distant stars?',
          'options': ['A change in the speed of light due to motion', 'A change in observed frequency/wavelength due to relative motion between source and observer', 'A phenomenon exclusive to sound waves', 'An effect unrelated to motion'],
          'correct': 1,
        },
        {
          'question': 'When a light-emitting source moves away from an observer, the observed light is typically?',
          'options': ['Unchanged in wavelength', 'Red-shifted (longer wavelength)', 'Converted to sound waves', 'Blue-shifted (shorter wavelength)'],
          'correct': 1,
        },
        {
          'question': 'When a light-emitting source moves towards an observer, the observed light is typically?',
          'options': ['Red-shifted', 'Unchanged', 'Converted to radio waves', 'Blue-shifted (shorter wavelength)'],
          'correct': 3,
        },
        {
          'question': 'The redshift observed in light from distant galaxies is used as evidence for?',
          'options': ['No cosmological significance', 'A static, unchanging universe', 'An expanding universe', 'A shrinking universe'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes reflection of electromagnetic waves?',
          'options': ['Waves changing frequency upon striking a surface', 'Waves bouncing back after striking a surface', 'Waves passing completely through a medium', 'Waves being absorbed entirely'],
          'correct': 1,
        },
        {
          'question': 'The law of reflection states that the angle of incidence is?',
          'options': ['Always less than the angle of reflection', 'Always greater than the angle of reflection', 'Unrelated to the angle of reflection', 'Equal to the angle of reflection'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes refraction of electromagnetic waves?',
          'options': ['The bouncing of waves off a surface', 'The bending of waves as they pass from one medium to another due to a change in speed', 'The complete absorption of waves', 'A change in wave amplitude only'],
          'correct': 1,
        },
        {
          'question': 'The refractive index of a medium is a measure of how much it?',
          'options': ['Polarises light only', 'Reflects light only', 'Slows down and bends light compared to a vacuum', 'Absorbs light completely'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why a straw appears bent when placed in a glass of water, viewed from outside?',
          'options': ['Light refracts (bends) as it passes from water to air, due to a change in speed', 'The straw physically bends in water', 'Light is completely absorbed by water', 'Light diffracts around the straw'],
          'correct': 0,
        },
        {
          'question': 'The formula for refractive index n is given by n = ?',
          'options': ['c/v (speed of light in vacuum / speed in medium)', 'v/c', 'c * v', 'c - v'],
          'correct': 0,
        },
        {
          'question': 'Total internal reflection can occur when light travels from a?',
          'options': ['Vacuum to a vacuum', 'Less dense to a more dense medium at any angle', 'More dense to a less dense medium at an angle greater than the critical angle', 'Medium to itself'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains how optical fibres transmit light signals over long distances with minimal loss?',
          'options': ['Using absorption to store the signal', 'Using diffraction to scatter the signal', 'Using refraction to bend light out of the fibre', 'Using total internal reflection to repeatedly reflect light along the fibre\'s core'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the term \'coherent\' as applied to light waves, such as those produced by a laser?',
          'options': ['A term unrelated to wave properties', 'Waves with a constant phase relationship and typically a single frequency/wavelength', 'Waves that cannot interfere with each other', 'Waves with random, unrelated phases and frequencies'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes why laser light is often used in interference experiments, unlike ordinary light bulbs?',
          'options': ['Laser light is incoherent and unsuitable for interference', 'Laser light is highly coherent, producing stable and observable interference patterns', 'Laser light has no wave properties', 'Ordinary light bulbs produce more coherent light'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why the sky appears blue during the day, related to the scattering of sunlight?',
          'options': ['Blue light, having a shorter wavelength, is scattered more strongly by gas molecules in the atmosphere (Rayleigh scattering)', 'The sky has no relation to light scattering', 'Blue light is absorbed more than other colours', 'Red light is scattered more than blue light'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why sunsets often appear red or orange?',
          'options': ['Blue light is scattered out of the direct path over the longer atmospheric distance at sunset, leaving more red/orange light to reach the observer', 'Red light is scattered most strongly at all times', 'Atmospheric scattering has no wavelength dependence', 'The sun changes colour at sunset'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the term \'electromagnetic radiation\' in general?',
          'options': ['A term unrelated to energy transfer', 'Energy that travels as electromagnetic waves, capable of moving through a vacuum', 'Energy that travels through a medium only, as a mechanical disturbance', 'A term applicable only to visible light'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why electromagnetic waves do not require a medium to propagate, unlike sound waves?',
          'options': ['Electromagnetic waves are self-sustaining oscillations of electric and magnetic fields, unlike sound waves which require particle vibration', 'Electromagnetic waves are actually mechanical waves', 'Electromagnetic waves always require air specifically', 'There is no fundamental difference between EM and sound waves'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes intensity of an electromagnetic wave in relation to its amplitude?',
          'options': ['Intensity is independent of amplitude', 'Intensity is proportional to the square of the amplitude of the wave', 'Intensity decreases as amplitude increases', 'Intensity is only related to frequency, not amplitude'],
          'correct': 1,
        },
        {
          'question': 'As you move farther from a point source of electromagnetic radiation, the intensity generally?',
          'options': ['Remains constant regardless of distance', 'Increases with distance', 'Decreases with the square of the distance (inverse square law)', 'Increases linearly with distance'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why standing farther from a light source makes it appear dimmer, according to the inverse square law?',
          'options': ['Light loses energy spontaneously with distance', 'The same total power is spread over a larger area as distance increases, reducing intensity per unit area', 'Distance has no effect on perceived brightness', 'Light waves slow down significantly with distance'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the term \'wavefront\' in wave theory?',
          'options': ['The speed of a wave', 'A term unrelated to wave motion', 'A surface connecting points of a wave that are in the same phase', 'A single point on a wave'],
          'correct': 2,
        },
        {
          'question': 'Huygens\' principle states that every point on a wavefront can be regarded as a source of?',
          'options': ['Absorption only', 'Reflection only', 'Sound only', 'New, secondary spherical wavelets'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the relationship between the electric field, magnetic field, and direction of propagation in an electromagnetic wave, according to the right-hand rule?',
          'options': ['Only E and B are perpendicular, with no relation to propagation direction', 'E, B, and the direction of propagation are mutually perpendicular', 'All three are parallel to each other', 'There is no fixed relationship'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why electromagnetic waves are said to be self-propagating?',
          'options': ['They require a constant external energy source at every point', 'A changing electric field induces a changing magnetic field, and vice versa, allowing the wave to sustain itself without an external medium', 'They rely entirely on particle collisions to propagate', 'Self-propagation is a term unrelated to EM waves'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes dispersion of light, as seen when white light passes through a prism?',
          'options': ['A term unrelated to refraction', 'The complete absorption of white light', 'The separation of white light into its constituent colours due to different wavelengths refracting by different amounts', 'A phenomenon where all colours refract identically'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly explains why violet light bends more than red light when passing through a glass prism?',
          'options': ['Red light has a higher refractive index than violet light', 'Violet light has a shorter wavelength and is refracted more strongly (higher refractive index for the medium) than red light', 'Violet light travels faster in glass than red light', 'Wavelength has no effect on the degree of refraction'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes scattering of electromagnetic waves by particles much smaller than the wavelength (Rayleigh scattering)?',
          'options': ['Scattering does not depend on particle size or wavelength', 'Scattering intensity is independent of wavelength', 'Longer wavelengths scatter more than shorter wavelengths', 'Scattering intensity increases strongly for shorter wavelengths compared to longer wavelengths'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the term \'transverse wave\', applicable to electromagnetic waves?',
          'options': ['A wave in which the oscillation is parallel to the direction of wave travel', 'A wave with no oscillation at all', 'A wave that requires a medium', 'A wave in which the oscillation is perpendicular to the direction of wave travel'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes a longitudinal wave, in contrast to electromagnetic (transverse) waves?',
          'options': ['A wave identical in nature to light', 'Oscillation parallel to the direction of wave travel (e.g., sound waves)', 'A wave found only in vacuum', 'Oscillation perpendicular to wave direction'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why X-rays can penetrate soft tissue but are absorbed more by bone, useful in medical imaging?',
          'options': ['Soft tissue absorbs more X-rays than bone', 'Denser materials like bone absorb more X-ray energy than softer tissue, creating contrast in an X-ray image', 'X-rays cannot penetrate any part of the body', 'X-rays are absorbed equally by all body tissues'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why ultraviolet radiation can cause sunburn and skin damage?',
          'options': ['UV radiation cannot be absorbed by skin', 'UV radiation only affects the eyes, not skin', 'UV photons carry enough energy to damage DNA and cellular structures in skin cells upon absorption', 'UV radiation has too little energy to affect biological tissue'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why gamma rays are used cautiously in medical treatments, such as radiotherapy for cancer?',
          'options': ['Gamma rays have no biological effect', 'Gamma rays have very high energy that can damage or kill cells, useful for targeting cancer cells but requiring careful control to limit harm to healthy tissue', 'Gamma rays cannot be focused or directed', 'Gamma rays are the safest form of radiation with no risk'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the difference between ionising and non-ionising electromagnetic radiation?',
          'options': ['There is no meaningful difference between the two', 'Ionising radiation includes only radio waves', 'Ionising radiation carries enough energy to remove electrons from atoms/molecules, while non-ionising radiation does not', 'Non-ionising radiation is always more dangerous'],
          'correct': 2,
        },
        {
          'question': 'Which of these is generally classified as ionising radiation?',
          'options': ['Ultraviolet (higher-energy), X-rays, and gamma rays', 'Infrared', 'Radio waves', 'Visible light'],
          'correct': 0,
        },
        {
          'question': 'Which of these is generally classified as non-ionising radiation?',
          'options': ['High-energy ultraviolet', 'Gamma rays', 'Radio waves, microwaves, infrared, and visible light', 'X-rays'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why radio waves are generally considered safer for everyday human exposure compared to X-rays or gamma rays?',
          'options': ['Radio wave photons carry relatively low energy, insufficient to ionise atoms or significantly damage biological molecules', 'Radio waves carry more energy than gamma rays', 'All electromagnetic radiation is equally hazardous', 'Radio waves cannot be absorbed by the human body'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes why microwave ovens are designed to use radiation in the microwave range to heat food?',
          'options': ['Microwaves are absorbed by water molecules, causing them to vibrate and generate heat through friction', 'Microwaves cook food by ionising its atoms', 'Microwaves have no interaction with water molecules', 'Microwaves are chosen because they pass through food without interacting'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why microwave ovens use metal enclosures with mesh screens on the door?',
          'options': ['The mesh is purely decorative', 'To block visible light only', 'To reflect and contain microwave radiation within the oven, preventing it from escaping, since the mesh holes are smaller than the microwave wavelength', 'Metal has no effect on microwaves'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes the term \'attenuation\' as applied to electromagnetic wave propagation through a medium?',
          'options': ['A term unrelated to wave propagation', 'The strengthening of a wave as it passes through a medium', 'The gradual reduction in intensity/amplitude of a wave as it travels through a medium, due to absorption or scattering', 'The complete reflection of a wave'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly explains why electromagnetic waves of different frequencies interact differently with the same material (e.g., glass is transparent to visible light but opaque to UV)?',
          'options': ['Material properties are unrelated to wave frequency', 'Only visible light can interact with matter', 'The absorption and transmission properties of a material depend on the frequency of the incident radiation relative to the material\'s atomic/molecular structure', 'All frequencies interact identically with a given material'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes the term \'amplitude\' of an electromagnetic wave?',
          'options': ['The speed of the wave', 'The frequency of oscillation', 'The maximum displacement/magnitude of the oscillating electric (or magnetic) field from its equilibrium value', 'The distance between two successive crests'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes \'period\' as applied to an electromagnetic wave?',
          'options': ['The time taken to complete one full oscillation cycle', 'The distance between successive wave crests', 'The maximum field strength', 'The speed of light'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the relationship between period (T) and frequency (f) of a wave?',
          'options': ['T = 1/f', 'T = f', 'T is unrelated to f', 'T = f^2'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why electromagnetic waves carry energy and momentum, evidenced by phenomena like radiation pressure?',
          'options': ['Radiation pressure is a myth with no experimental support', 'Only mechanical waves can exert force', 'Oscillating electric and magnetic fields carry energy, and can exert a small force (radiation pressure) on surfaces they strike', 'EM waves have no physical effect on matter'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the basic principle behind a solar sail, a proposed spacecraft propulsion method using sunlight?',
          'options': ['Solar sails require an atmosphere to function', 'Solar sails work by capturing heat only, with no momentum transfer', 'Sunlight has no momentum and cannot propel anything', 'Photons from sunlight carry momentum, and reflecting them off a large sail can produce a small but continuous thrust'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly explains why an antenna is designed with a length related to the wavelength of the electromagnetic wave it is meant to transmit or receive?',
          'options': ['Efficient transmission/reception occurs when the antenna length is comparable to a fraction (e.g., half or quarter) of the wave\'s wavelength, enabling resonance', 'Antenna length has no relation to wavelength', 'Antennas work efficiently at any arbitrary length', 'Only the antenna\'s colour affects its function'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why different radio stations broadcast at different frequencies?',
          'options': ['Different frequencies are used only for aesthetic reasons', 'All radio stations must use the same frequency', 'To allow multiple stations to transmit simultaneously without interfering with each other, since receivers can be tuned to a specific frequency', 'Frequency has no relation to distinguishing radio broadcasts'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes \'amplitude modulation\' (AM) as a method of encoding information onto a radio wave?',
          'options': ['Varying the frequency of the carrier wave to encode a signal', 'Varying the amplitude of the carrier wave to encode a signal', 'Varying the wavelength only, with no relation to a carrier wave', 'A method unrelated to broadcasting'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes \'frequency modulation\' (FM) as a method of encoding information onto a radio wave?',
          'options': ['A method that does not use a carrier wave', 'Varying the frequency of the carrier wave to encode a signal', 'Varying the amplitude of the carrier wave', 'A method identical to AM'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why FM radio generally provides better sound quality with less static interference compared to AM radio?',
          'options': ['AM signals are always higher quality than FM', 'FM signals are less affected by amplitude-based electrical noise, since the information is carried in frequency variations rather than amplitude', 'FM uses a completely different form of energy than radio waves', 'FM and AM have identical noise susceptibility'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly explains why the ionosphere can reflect certain radio waves, enabling long-distance (over-the-horizon) communication?',
          'options': ['Charged particles in the ionosphere can reflect lower-frequency radio waves back towards Earth, allowing them to travel beyond the horizon', 'The ionosphere absorbs all radio waves completely', 'Only visible light is reflected by the ionosphere', 'The ionosphere has no effect on radio wave propagation'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly explains why higher-frequency signals like those used for satellite communication generally travel in straight lines (line-of-sight) rather than being reflected by the ionosphere?',
          'options': ['Higher frequencies always bend around the Earth naturally', 'Frequency has no bearing on ionospheric interaction', 'Higher-frequency waves tend to pass through the ionosphere rather than being reflected, requiring line-of-sight or satellite relay for long-distance transmission', 'All frequencies are reflected identically by the ionosphere'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why the study of electromagnetic waves is fundamental to understanding both classical optics and modern telecommunications?',
          'options': ['Optics and telecommunications use entirely separate physical principles', 'Electromagnetic waves are unrelated to optics', 'Telecommunications relies solely on sound wave theory', 'Electromagnetic wave theory explains the behaviour of light (optics) and underlies the technology used in radio, television, and wireless communication'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly explains why the frequency of an electromagnetic wave does not change when it passes from one medium into another (unlike its speed and wavelength)?',
          'options': ['Speed remains constant, but wavelength and frequency both change', 'None of these quantities can change when a wave changes medium', 'Frequency always changes when a wave changes medium', 'Frequency is determined by the source of the wave and remains constant as the wave\'s speed and wavelength adjust according to the new medium'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly explains why a rainbow forms when sunlight passes through raindrops?',
          'options': ['Raindrops only reflect a single colour of light', 'Rainbows are unrelated to the behaviour of light', 'Raindrops reflect sunlight without any refraction or dispersion', 'Sunlight is refracted, internally reflected, and dispersed by raindrops, separating it into its constituent colours'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes why thin-film interference, such as seen in soap bubbles or oil slicks, produces colourful patterns?',
          'options': ['Colours in soap bubbles are due to pigment in the soap', 'Constructive and destructive interference of light waves reflecting off the top and bottom surfaces of the thin film vary with wavelength and film thickness, producing different colours', 'Thin-film interference has no relation to wave interference principles', 'Thin films absorb all light except one colour'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly explains why a diffraction grating, with many closely spaced slits, produces sharper and more defined interference patterns than a simple double slit?',
          'options': ['The larger number of closely spaced slits in a diffraction grating causes sharper constructive interference maxima due to the combined effect of many wave sources', 'A diffraction grating has fewer slits than a double slit', 'Diffraction gratings do not rely on wave interference', 'A diffraction grating produces no observable pattern'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why the study of the electromagnetic spectrum has enabled astronomers to learn about distant stars and galaxies beyond what is visible to the naked eye?',
          'options': ['Astronomers rely solely on gravitational data, not electromagnetic radiation', 'Detecting radiation across the full electromagnetic spectrum (radio, infrared, UV, X-ray, gamma) reveals different physical processes and objects not observable in visible light alone', 'Only visible light carries useful astronomical information', 'The electromagnetic spectrum has no relevance to astronomy'],
          'correct': 1,
        },
      ];
    case 'phy102_u3_1': // EM Wave Applications
      return [
        {
          'question': 'Radio waves are primarily used in everyday technology for?',
          'options': ['Killing bacteria', 'Broadcasting and wireless communication', 'Medical imaging', 'Cooking food'],
          'correct': 1,
        },
        {
          'question': 'AM and FM radio broadcasting both use which part of the electromagnetic spectrum?',
          'options': ['Microwaves', 'X-rays', 'Radio waves', 'Gamma rays'],
          'correct': 2,
        },
        {
          'question': 'Television broadcasting historically relied primarily on which part of the electromagnetic spectrum?',
          'options': ['X-rays', 'Gamma rays', 'Radio waves (including VHF/UHF bands)', 'Ultraviolet'],
          'correct': 2,
        },
        {
          'question': 'Mobile phone communication primarily uses which part of the electromagnetic spectrum?',
          'options': ['Visible light only', 'Radio waves/microwaves', 'Gamma rays', 'Infrared only'],
          'correct': 1,
        },
        {
          'question': 'Wi-Fi signals used for wireless internet typically use frequencies in which part of the spectrum?',
          'options': ['Microwave region', 'X-ray region', 'Ultraviolet region', 'Gamma ray region'],
          'correct': 0,
        },
        {
          'question': 'Bluetooth technology, used for short-range wireless communication, operates using?',
          'options': ['Gamma rays', 'Radio waves in the microwave region', 'Visible light', 'Infrared exclusively'],
          'correct': 1,
        },
        {
          'question': 'Radar (radio detection and ranging) uses which type of electromagnetic wave to detect objects and measure their distance/speed?',
          'options': ['Microwaves/radio waves', 'Sound waves only', 'Gamma rays', 'Visible light'],
          'correct': 0,
        },
        {
          'question': 'Radar works by measuring the time delay between transmitting a wave pulse and receiving its?',
          'options': ['Polarisation', 'Absorption', 'Reflection (echo) from an object', 'Refraction'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes how satellite communication typically uses microwaves?',
          'options': ['Microwaves are absorbed completely by the atmosphere', 'Microwaves can pass through the atmosphere with relatively low absorption, making them suitable for satellite-to-ground communication', 'Microwaves cannot penetrate the atmosphere', 'Satellites use only visible light for communication'],
          'correct': 1,
        },
        {
          'question': 'Microwave ovens use electromagnetic radiation primarily to heat food by causing which molecules to vibrate?',
          'options': ['Carbon dioxide molecules', 'Oxygen molecules', 'Nitrogen molecules', 'Water molecules'],
          'correct': 3,
        },
        {
          'question': 'Infrared radiation is commonly used in household remote controls to?',
          'options': ['Kill bacteria', 'Transmit invisible signals that a receiver can detect to control devices', 'Transmit visible signals', 'Cook food'],
          'correct': 1,
        },
        {
          'question': 'Infrared cameras (thermal imaging) are used to detect variations in an object\'s?',
          'options': ['Colour', 'Magnetic field', 'Sound emission', 'Temperature (heat radiation)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why infrared thermal imaging is useful in search and rescue operations at night?',
          'options': ['Infrared cameras only work in daylight', 'Infrared radiation cannot detect body heat', 'Thermal imaging is unrelated to infrared radiation', 'Infrared cameras can detect the heat signatures of living beings even in darkness, since all objects emit some infrared radiation related to their temperature'],
          'correct': 3,
        },
        {
          'question': 'Infrared radiation is also used in short-range wireless data transfer, such as older?',
          'options': ['TV/device remote controls and some older data transfer standards (IrDA)', 'Radar systems', 'X-ray machines', 'Wi-Fi routers'],
          'correct': 0,
        },
        {
          'question': 'Visible light is used in optical fibre communication mainly because it can be transmitted efficiently through fibres using?',
          'options': ['Diffraction only', 'Absorption', 'Refraction only', 'Total internal reflection'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why optical fibres are increasingly preferred over traditional copper cables for data transmission?',
          'options': ['Optical fibres transmit sound instead of light', 'They transmit signals as light pulses with lower loss and higher bandwidth over long distances', 'Optical fibres cannot carry data over long distances', 'Copper cables always have higher bandwidth'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of visible light in barcode scanners?',
          'options': ['Barcode scanners use gamma rays to read codes', 'Barcode scanners use a laser (visible light) that reflects differently off the black and white bars, which a sensor interprets', 'Barcode scanners use only infrared radiation with no visible light', 'Barcode scanners use radio waves exclusively'],
          'correct': 1,
        },
        {
          'question': 'Ultraviolet radiation is used in some settings for its ability to?',
          'options': ['Penetrate deeply into the human body harmlessly', 'Sterilise surfaces and water by killing bacteria and viruses', 'Provide long-range communication', 'Cook food efficiently'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why UV lamps are used for water and surface sterilisation in some water treatment facilities and hospitals?',
          'options': ['UV radiation is only effective against visible dirt, not microorganisms', 'UV radiation can damage the DNA/RNA of bacteria and viruses, preventing them from reproducing and effectively sterilising surfaces or water', 'Sterilisation with UV requires physical contact', 'UV radiation has no effect on microorganisms'],
          'correct': 1,
        },
        {
          'question': 'Ultraviolet radiation is also used to induce fluorescence in certain materials, useful in applications such as?',
          'options': ['Deep tissue medical imaging directly', 'Forensic analysis to detect biological stains or authenticate currency', 'Long-distance radio communication', 'Cooking food'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why sunscreen is designed to absorb or reflect ultraviolet radiation?',
          'options': ['Sunscreen has no relation to UV protection', 'Sunscreen is designed to increase UV absorption by the skin', 'To protect the skin from UV-induced damage such as sunburn and increased skin cancer risk', 'UV radiation poses no risk to skin'],
          'correct': 2,
        },
        {
          'question': 'X-rays are widely used in medicine primarily for?',
          'options': ['Sterilising surgical equipment', 'Imaging bones and dense tissues inside the body', 'Treating viral infections', 'Providing long-range wireless communication'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why X-rays are useful for imaging bones but not as effective for imaging soft tissue detail?',
          'options': ['Soft tissue absorbs X-rays more strongly than bone', 'X-rays cannot interact with bone at all', 'X-rays only interact with soft tissue', 'Bone absorbs X-rays more strongly than soft tissue, creating clear contrast on an X-ray image'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes a CT (computed tomography) scan, an advanced application of X-rays in medicine?',
          'options': ['A method unrelated to X-rays', 'A single flat X-ray image', 'Multiple X-ray images taken from different angles, combined by computer to create detailed cross-sectional/3D images of the body', 'An imaging method that uses only visible light'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why X-rays are also used in airport security scanners?',
          'options': ['X-rays are used only for medical purposes', 'X-rays can penetrate luggage and clothing to reveal the shapes and densities of hidden objects on a screen', 'X-rays cannot penetrate any solid materials', 'Security scanners use only visible light'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why medical staff and patients are given protective shielding (like lead aprons) during X-ray procedures?',
          'options': ['X-rays are a form of ionising radiation that can damage biological tissue with excessive or repeated exposure, so shielding reduces unnecessary exposure', 'Shielding is used only for comfort, not protection', 'X-rays have no harmful effects requiring protection', 'Lead aprons block visible light only'],
          'correct': 0,
        },
        {
          'question': 'Gamma rays are used in medicine primarily for?',
          'options': ['Providing wireless internet access', 'Everyday communication', 'Cooking food efficiently', 'Sterilising food and medical equipment, as well as cancer treatment (radiotherapy) and diagnostic imaging (e.g., PET scans)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains how gamma ray radiotherapy is used to treat cancer?',
          'options': ['Gamma rays have no effect on cancer cells', 'Focused, high-energy gamma radiation is directed at tumours to damage and destroy cancerous cells while attempting to minimise harm to surrounding healthy tissue', 'Radiotherapy relies solely on visible light', 'Gamma rays only affect healthy tissue, not cancer cells'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes gamma ray sterilisation, used for medical equipment and some food products?',
          'options': ['Sterilisation with gamma rays requires the item to be heated', 'High-energy gamma radiation can penetrate packaging and destroy the DNA of bacteria and other microorganisms, sterilising the product without heat', 'Gamma rays cannot kill microorganisms', 'Gamma rays are unsafe for any sterilisation use'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why gamma ray sources must be handled with extreme caution and shielding in industrial and medical settings?',
          'options': ['Gamma rays cannot penetrate any shielding material', 'Gamma rays are highly penetrating, ionising radiation capable of significant biological damage with prolonged or high exposure', 'Gamma rays are completely harmless to living tissue', 'Gamma ray exposure has no cumulative health effects'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a PET (positron emission tomography) scan, a medical imaging technique involving gamma rays?',
          'options': ['A scan unrelated to electromagnetic radiation', 'A scan that uses sound waves exclusively', 'A scan detecting gamma rays produced by a radioactive tracer to visualise metabolic activity within the body', 'A scan using only visible light to observe organ structure'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why microwave communication links are often used for point-to-point data transmission between fixed locations, such as telecom towers?',
          'options': ['Point-to-point links only use visible light', 'Microwaves cannot travel in straight lines', 'Microwaves are unsuitable for any communication use', 'Microwaves can be focused into narrow beams using directional antennas for efficient line-of-sight transmission between fixed points'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes GPS (Global Positioning System) technology in terms of its reliance on electromagnetic waves?',
          'options': ['GPS uses sound waves from satellites', 'GPS satellites transmit radio wave signals that receivers use to calculate precise location based on signal timing', 'GPS does not use electromagnetic waves at all', 'GPS relies entirely on visible light signals'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why GPS satellites transmit precisely timed radio signals to determine a receiver\'s location?',
          'options': ['The receiver calculates its position based on the time delay of signals received from multiple satellites, using the known speed of light', 'Radio signals have no role in GPS technology', 'GPS relies on measuring magnetic field strength', 'GPS uses only a single satellite for positioning'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the application of infrared radiation in fibre optic and short-range wireless data links, such as some older computer peripherals?',
          'options': ['Infrared is only used for heating', 'Infrared data transmission requires physical contact between devices', 'Infrared LEDs and detectors can transmit binary data as pulses of infrared light, useful for line-of-sight, interference-free short-range communication', 'Infrared cannot be used for any form of data transmission'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why night-vision goggles use infrared technology?',
          'options': ['Night vision relies solely on gamma rays', 'They amplify visible light only, ignoring infrared entirely', 'Infrared has no application in low-light imaging', 'They can detect and amplify infrared radiation (including heat signatures) that is invisible to the naked eye, allowing vision in low-light conditions'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of ultraviolet radiation in detecting counterfeit currency?',
          'options': ['UV light causes certain security features (invisible under normal light) printed with special ink to fluoresce, revealing authenticity marks', 'UV radiation destroys currency instantly', 'UV light has no effect on currency', 'Counterfeit detection relies solely on visible light patterns'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why greenhouse glass allows sunlight (including some UV/visible) to enter but traps infrared radiation re-emitted by objects inside, warming the greenhouse?',
          'options': ['Glass is transparent to both incoming sunlight and outgoing infrared radiation equally', 'Glass is relatively transparent to incoming shorter-wavelength sunlight but less transparent to the longer-wavelength infrared re-radiated by warmed objects, trapping heat inside', 'Glass blocks all electromagnetic radiation', 'Greenhouses do not rely on any electromagnetic wave properties'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the basic mechanism behind the atmospheric greenhouse effect, related to infrared radiation?',
          'options': ['The greenhouse effect involves only visible light, not infrared', 'Greenhouse gases in the atmosphere absorb and re-emit infrared radiation from Earth\'s surface, trapping heat and warming the planet', 'Greenhouse gases block all sunlight completely', 'Earth\'s atmosphere has no interaction with infrared radiation'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an example of a common greenhouse gas that absorbs infrared radiation, contributing to the greenhouse effect?',
          'options': ['Carbon dioxide', 'Oxygen', 'Argon', 'Nitrogen'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why remote sensing satellites use multiple bands of the electromagnetic spectrum (visible, infrared, microwave) to study Earth\'s surface and atmosphere?',
          'options': ['Multiple bands provide no additional information over a single band', 'Only visible light provides useful information about Earth', 'Remote sensing relies solely on sound waves', 'Different wavelengths reveal different information, such as vegetation health (infrared), cloud cover (visible), and surface features through clouds (microwave/radar)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes synthetic aperture radar (SAR), a remote sensing application using microwaves?',
          'options': ['A technique unrelated to electromagnetic waves', 'A method that only works during clear daytime conditions', 'A technique using only visible light for imaging', 'A radar imaging technique using microwaves that can produce detailed images of the Earth\'s surface, even through clouds and at night'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why microwaves are particularly useful for satellite-based Earth observation compared to visible light, in terms of weather conditions?',
          'options': ['Visible light penetrates clouds better than microwaves', 'Weather conditions have no effect on either wavelength', 'Microwaves can penetrate clouds and are less affected by weather conditions than visible light, allowing consistent imaging', 'Microwaves cannot penetrate clouds at all'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of gamma rays in industrial settings, such as detecting flaws in metal welds or castings?',
          'options': ['Gamma rays cannot penetrate metal', 'Gamma rays are used only in medicine, not industry', 'Industrial flaw detection relies solely on visible light', 'Gamma ray radiography can penetrate dense materials to reveal internal structural flaws, similar to medical X-ray imaging but for industrial materials'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why smoke detectors sometimes use a small radioactive source emitting alpha or other radiation in conjunction with detecting disruptions, though most modern detectors use optical (light) sensing instead?',
          'options': ['Smoke detectors cannot use any form of electromagnetic radiation', 'Optical detectors work only with gamma rays', 'All smoke detectors work identically using only sound', 'Optical smoke detectors use an infrared or visible light beam and sensor; smoke particles scatter the light, triggering the alarm when detected by the sensor'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the application of visible light lasers in precision cutting and engraving in manufacturing?',
          'options': ['Laser cutting relies on radio waves, not visible light', 'A focused, coherent, high-intensity laser beam can concentrate enough energy to precisely cut, engrave, or weld materials', 'Lasers cannot focus enough energy to cut materials', 'Manufacturing lasers use only infrared, never visible light'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the use of lasers (often visible or near-infrared) in LASIK eye surgery?',
          'options': ['A precisely focused laser beam can reshape the cornea by removing tiny amounts of tissue, correcting vision without traditional surgical cutting tools', 'Lasers cannot interact with biological tissue', 'LASIK uses only X-rays', 'Laser eye surgery has no relation to electromagnetic radiation'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why fibre-optic endoscopes, used in medical diagnostics, rely on visible light and total internal reflection?',
          'options': ['Optical fibres cannot transmit images, only data', 'Endoscopy relies solely on X-ray imaging', 'Endoscopes use light guided through optical fibres via total internal reflection to illuminate and capture images inside the body with minimal invasiveness', 'Endoscopes use gamma rays for imaging'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the application of radio waves in Magnetic Resonance Imaging (MRI), alongside strong magnetic fields?',
          'options': ['MRI relies solely on X-rays', 'MRI does not use any electromagnetic radiation', 'MRI uses radio wave pulses combined with strong magnetic fields to excite hydrogen nuclei in the body, and detects the emitted radio signals to construct detailed images of soft tissue', 'MRI uses gamma rays exclusively'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why MRI is often preferred over X-ray/CT imaging for examining soft tissues such as the brain or muscles?',
          'options': ['MRI and X-ray imaging use identical radiation types', 'MRI uses more harmful radiation than X-rays', 'X-rays provide better soft tissue detail than MRI', 'MRI uses non-ionising radio waves rather than ionising X-rays, and provides better soft-tissue contrast without the radiation risks associated with X-rays'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the use of electromagnetic waves in wireless charging technology for electric toothbrushes and phones?',
          'options': ['Wireless charging uses electromagnetic induction (a near-field application related to changing magnetic fields) to transfer energy without direct electrical contact', 'Wireless charging has no basis in electromagnetic theory', 'Wireless charging relies on gamma radiation', 'Wireless charging requires physical wired connections'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why fibre-optic communication networks form the backbone of modern high-speed internet infrastructure?',
          'options': ['Internet infrastructure does not rely on electromagnetic wave technology', 'Fibre optics transmit data as electrical signals through copper', 'Fibre-optic cables transmit data as pulses of light with very high bandwidth and low signal loss over long distances, compared to traditional copper cabling', 'Fibre optics cannot transmit data over long distances'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the application of terahertz radiation (between microwave and infrared) in emerging security screening technology?',
          'options': ['Terahertz waves can penetrate clothing and some packaging to reveal hidden objects, while being considered less harmful than X-rays due to lower photon energy', 'Terahertz radiation cannot penetrate any materials', 'Terahertz radiation has no practical applications', 'Terahertz waves are identical to X-rays in their biological effects'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why different applications (communication, medical imaging, cooking, sterilisation) use different regions of the electromagnetic spectrum?',
          'options': ['Only visible light has any practical application', 'Each region of the spectrum has distinct properties (energy, penetration ability, interaction with matter) that make it suited to specific practical applications', 'Applications are chosen randomly with no scientific basis', 'All electromagnetic waves behave identically regardless of frequency'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why exposure guidelines and safety standards differ significantly between, for example, radio wave exposure from Wi-Fi routers and X-ray exposure from medical imaging?',
          'options': ['All electromagnetic radiation carries identical risk regardless of frequency', 'Radio waves are more hazardous than X-rays', 'Safety standards are unrelated to radiation frequency or energy', 'Higher-frequency, higher-energy radiation (like X-rays) poses greater potential biological risk (ionisation) than lower-frequency, lower-energy radiation (like radio waves), requiring different safety considerations'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the use of visible light in photography, based on the interaction of light with a photosensitive sensor or film?',
          'options': ['Light entering a camera lens is focused onto a photosensitive sensor or film, which records the intensity and colour of light to form an image', 'Cameras cannot use visible light to form images', 'Photography records sound waves, not light', 'Photography relies entirely on infrared radiation'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why solar panels (photovoltaic cells) can convert sunlight directly into electricity?',
          'options': ['Sunlight has no interaction with semiconductor materials', 'Photons from sunlight strike a semiconductor material, exciting electrons and generating an electric current through the photovoltaic effect', 'Solar panels use radio waves, not visible/infrared light', 'Solar panels work by heating water only'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why solar water heaters use sunlight to directly heat water, distinct from photovoltaic panels?',
          'options': ['Solar water heaters use only microwaves', 'Solar water heaters convert light directly into electricity like photovoltaic cells', 'Solar water heaters have no relation to electromagnetic radiation', 'Solar water heaters absorb electromagnetic radiation (mainly infrared and visible light) and convert it into thermal energy, heating water directly'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the use of electromagnetic waves in television remote controls specifically using infrared LEDs?',
          'options': ['Remote controls require direct wired connections', 'The remote sends a coded sequence of infrared light pulses that a receiver on the television decodes to execute specific commands', 'Infrared cannot be used to encode digital signals', 'Remote controls use gamma rays to communicate with televisions'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why fibre-optic cables are less susceptible to electromagnetic interference compared to traditional copper cables?',
          'options': ['Fibre optics are more susceptible to interference than copper', 'There is no difference in interference susceptibility', 'Copper cables are immune to electromagnetic interference', 'Fibre-optic cables carry signals as light rather than electrical current, so they are not affected by external electric or magnetic fields in the same way copper cables are'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the application of visible/near-infrared light in optical mice used with computers?',
          'options': ['An LED or laser illuminates the surface beneath the mouse, and a sensor detects reflected light patterns to track movement', 'Optical mice rely on radio wave detection', 'Optical mice require physical mechanical rollers only', 'Optical mice use gamma radiation to detect movement'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why X-ray crystallography is used to determine the atomic and molecular structure of crystals, including complex biological molecules like DNA?',
          'options': ['X-rays have wavelengths comparable to the spacing between atoms in a crystal, producing diffraction patterns that reveal structural information', 'X-rays are too large in wavelength to interact with atomic structures', 'X-ray crystallography uses visible light exclusively', 'X-rays cannot interact with crystalline structures'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the use of electromagnetic waves in Wi-Fi routers for home and office wireless networking?',
          'options': ['Wi-Fi requires a direct wired connection between all devices', 'Wi-Fi routers transmit data using sound waves', 'Wi-Fi routers transmit and receive data encoded onto microwave-frequency radio signals between connected devices', 'Wi-Fi relies solely on infrared transmission'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why near-field communication (NFC), used in contactless payment systems, relies on short-range electromagnetic induction?',
          'options': ['NFC uses gamma rays for secure transactions', 'NFC has no basis in electromagnetic wave theory', 'NFC uses short-range radio frequency electromagnetic fields to enable data exchange between devices held very close together, such as a phone and a payment terminal', 'NFC requires devices to be physically connected by wires'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why RFID (Radio Frequency Identification) tags are used for tracking inventory and access control?',
          'options': ['RFID requires physical contact with a scanner', 'RFID tags cannot transmit information wirelessly', 'RFID tags rely on visible light scanning only', 'RFID tags use radio waves to wirelessly transmit identifying information to a reader, without requiring direct contact or line of sight'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why fibre-optic internet connections generally offer higher data transfer speeds than older copper-based DSL connections?',
          'options': ['There is no difference between fibre and copper data capacity', 'Light signals in fibre-optic cables can carry significantly more data with less signal degradation over distance compared to electrical signals in copper wires', 'Fibre-optic cables cannot support high-speed data transfer', 'Copper wires always transmit data faster than fibre optics'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the use of electromagnetic waves (typically infrared or radio) in industrial and home automation motion sensors?',
          'options': ['Motion sensors cannot use electromagnetic radiation', 'Motion sensors rely solely on sound wave detection', 'Motion sensors detect changes in infrared radiation (heat) or reflect radio/microwave signals off moving objects to trigger an alarm or action', 'Motion sensors require physical contact with a moving object'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of electromagnetic waves in Bluetooth-enabled wireless headphones?',
          'options': ['Bluetooth technology relies on gamma radiation', 'Wireless headphones require a direct wired connection to function', 'Wireless headphones transmit audio signals using visible light beams', 'Bluetooth headphones use short-range radio waves to wirelessly receive audio signals from a paired device'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why airport full-body scanners using millimetre-wave (a type of microwave/radio) technology are considered a safer alternative to X-ray backscatter scanners for security screening?',
          'options': ['Millimetre-wave scanners use non-ionising radiation, unlike X-ray scanners which use ionising radiation, reducing potential health risks from repeated exposure', 'Millimetre-wave scanners use higher-energy radiation than X-rays', 'Millimetre-wave technology cannot be used for security screening', 'Both scanner types use identical radiation with identical risk levels'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes why deep space communication with distant spacecraft relies on radio waves rather than visible light?',
          'options': ['Radio waves can be transmitted and received with large antennas over vast distances with manageable signal loss, and are less affected by atmospheric and interstellar interference than visible light', 'Deep space communication does not use electromagnetic waves', 'Radio waves cannot travel through the vacuum of space', 'Visible light travels faster than radio waves over long distances'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why weather satellites use infrared imaging in addition to visible light imaging to monitor cloud systems, especially at night?',
          'options': ['Weather satellites do not use electromagnetic radiation', 'Visible light imaging works equally well day and night', 'Infrared imaging can detect cloud-top temperatures and other thermal patterns even in darkness, when visible light imaging is not possible', 'Infrared imaging only works during the day'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the application of electromagnetic waves in electronic article surveillance (EAS) tags used in retail stores to prevent theft?',
          'options': ['EAS tags require a physical wired connection to store systems', 'EAS tags respond to specific electromagnetic fields generated by detectors at store exits, triggering an alarm if not deactivated at checkout', 'EAS tags use gamma radiation to trigger alarms', 'EAS tags have no basis in electromagnetic principles'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why X-ray telescopes must be placed in space (or high altitude) rather than used at ground level for astronomical observation?',
          'options': ['Ground-based X-ray telescopes work identically to space-based ones', 'X-rays travel faster in space than on Earth', 'X-rays cannot be detected by any telescope', 'Earth\'s atmosphere absorbs most X-rays from space before they reach the ground, so space-based telescopes are needed to detect X-ray emissions from cosmic sources'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why gamma-ray bursts detected by space observatories provide important information about extreme astrophysical events, such as the collapse of massive stars or neutron star mergers?',
          'options': ['Gamma-ray bursts are common, low-energy events with little scientific interest', 'Gamma-ray bursts are extremely energetic electromagnetic emissions that provide insight into some of the most violent and energetic processes in the universe', 'Gamma-ray bursts are unrelated to electromagnetic radiation', 'Gamma rays cannot be detected from astronomical sources'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why radio telescopes are used to study distant galaxies and cosmic phenomena not visible in other parts of the spectrum?',
          'options': ['Radio waves cannot travel through space', 'Radio telescopes can only detect signals from Earth-based sources', 'Radio astronomy has no advantages over visible-light astronomy', 'Radio waves from space can penetrate cosmic dust clouds that block visible light, revealing hidden astronomical structures and phenomena'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the application of electromagnetic waves in laser range finders used in sports, surveying, and military applications?',
          'options': ['Laser range finders cannot measure distance accurately', 'A laser pulse is emitted and the time taken for its reflection to return is used to calculate the precise distance to a target', 'Laser range finders measure distance using sound wave echoes only', 'Range finding relies solely on radio wave triangulation'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why fibre-optic sensors are used in some structural health monitoring systems for bridges and buildings?',
          'options': ['Changes in light transmission properties through embedded optical fibres can indicate structural stress, strain, or temperature changes, allowing continuous monitoring', 'Optical fibres have no sensing applications', 'Structural monitoring relies solely on visible inspection', 'Fibre-optic sensors cannot detect any physical changes'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the use of electromagnetic waves in electronic toll collection (ETC) systems on highways?',
          'options': ['Electronic tolling has no relation to electromagnetic wave technology', 'A radio frequency transponder in a vehicle communicates wirelessly with a roadside reader as the vehicle passes, automatically deducting the toll', 'ETC systems require vehicles to stop and connect a physical cable', 'ETC systems use gamma radiation to detect vehicles'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why ultraviolet (UV) curing is used in some industrial processes, such as curing certain inks, coatings, and adhesives?',
          'options': ['UV curing requires extremely high temperatures unrelated to radiation', 'UV radiation has no effect on chemical bonds', 'UV radiation only affects biological tissue, not industrial materials', 'UV radiation can trigger photochemical reactions that rapidly harden (cure) certain specially formulated materials, offering fast and energy-efficient processing'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of electromagnetic waves in optical coherence tomography (OCT), a medical imaging technique often used in ophthalmology?',
          'options': ['OCT does not use any form of electromagnetic radiation', 'OCT uses low-coherence light (often near-infrared) to capture high-resolution cross-sectional images of tissues such as the retina', 'OCT uses gamma radiation for retinal imaging', 'OCT relies solely on X-ray imaging'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why some greenhouses and horticultural lighting use specific wavelengths of visible light (e.g., red and blue) to promote plant growth?',
          'options': ['All wavelengths of light are equally useful for photosynthesis', 'Light has no role in plant growth', 'Plants cannot use artificial light for photosynthesis', 'Plants absorb specific wavelengths of light most efficiently for photosynthesis, so targeted lighting can optimise growth'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why UV-C radiation (a specific high-energy UV range) is particularly effective for germicidal (disinfection) purposes?',
          'options': ['UV-C has too little energy to affect microorganisms', 'UV-C only affects visible light-sensitive organisms', 'UV-C cannot penetrate air or water at all', 'UV-C radiation is highly effective at damaging the genetic material of bacteria, viruses, and other pathogens, making it useful for disinfection'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the use of electromagnetic waves in cellular network technology (such as 4G/5G) for mobile data and calls?',
          'options': ['Mobile communication does not use electromagnetic waves', 'Cellular networks rely entirely on visible light transmission', 'Cellular networks use radio waves at specific frequency bands to transmit voice and data wirelessly between mobile devices and network towers', 'Cellular networks use only wired connections'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why higher-frequency 5G networks can offer faster data speeds but often require more closely spaced transmission towers compared to lower-frequency networks?',
          'options': ['Higher-frequency radio waves generally carry more data capacity but have shorter range and are more easily blocked by obstacles, requiring denser infrastructure', 'Higher frequency always means longer range with fewer towers needed', 'Frequency has no effect on data speed or range', '5G technology does not use electromagnetic waves'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes an application of electromagnetic waves in electronic keyless entry systems for cars?',
          'options': ['Keyless entry systems use gamma radiation for security', 'Keyless systems do not rely on electromagnetic waves', 'A radio frequency signal from a key fob communicates wirelessly with the car\'s receiver to lock/unlock or start the vehicle', 'Keyless entry requires a physical key to be inserted'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why baby monitors and cordless phones commonly use specific radio frequency bands, sometimes leading to interference between devices operating on similar frequencies?',
          'options': ['Radio frequency devices never interfere with one another', 'Baby monitors and cordless phones use sound waves, not radio waves', 'Devices transmitting on overlapping radio frequency bands can interfere with each other\'s signals, causing static or crossed transmissions', 'These devices do not use electromagnetic waves'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of electromagnetic waves in hyperspectral imaging used in agriculture and environmental monitoring?',
          'options': ['Hyperspectral imaging cannot be used for environmental studies', 'Hyperspectral imaging uses only a single visible wavelength', 'This technology is unrelated to electromagnetic wave properties', 'Hyperspectral imaging captures data across many narrow wavelength bands (including beyond visible light) to reveal detailed information about vegetation health, soil composition, and other characteristics'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the application of infrared spectroscopy in chemical analysis, identifying the composition of unknown substances?',
          'options': ['Infrared spectroscopy can only detect visible light absorption', 'Infrared spectroscopy has no chemical analysis applications', 'Different chemical bonds absorb specific infrared wavelengths, producing a characteristic absorption spectrum that can identify a substance\'s molecular composition', 'Chemical analysis relies solely on gamma ray spectroscopy'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why microwave links are sometimes preferred over fibre-optic cables for temporary or hard-to-reach communication setups, such as remote broadcasting events?',
          'options': ['Microwave links cannot be used for broadcasting purposes', 'Microwave links always require buried cables', 'Microwave links can be quickly deployed without the need to physically lay cables, providing flexible wireless point-to-point communication', 'Fibre optics can be deployed instantly with no infrastructure'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of electromagnetic waves in RFID-based livestock tracking used in agriculture?',
          'options': ['RFID tags implanted or attached to animals allow wireless identification and tracking using radio frequency signals read by nearby scanners', 'Livestock tracking relies solely on visible tags with no electromagnetic component', 'RFID cannot be used for tracking animals', 'This technology requires direct physical contact for every reading'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why some food packaging uses UV-fluorescent inks for authentication and anti-counterfeiting purposes, similar to currency security features?',
          'options': ['Fluorescent inks work only with infrared light', 'UV-reactive inks are invisible under normal light but fluoresce distinctly under UV illumination, allowing verification of authenticity', 'UV inks are visible under all lighting conditions identically', 'UV-fluorescent features have no anti-counterfeiting use'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the general principle connecting most of the technological applications of the electromagnetic spectrum discussed, from radio communication to gamma-ray sterilisation?',
          'options': ['Only one region of the spectrum has any practical use', 'All applications rely on the same underlying wavelength', 'Electromagnetic waves have no practical differences across the spectrum', 'Different frequencies/wavelengths interact differently with matter, and understanding these interactions allows engineers to select the appropriate part of the spectrum for a specific practical application'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why some skin treatments and cosmetic procedures use specific wavelengths of laser light (visible or near-infrared) for hair removal or resurfacing?',
          'options': ['Lasers have no interaction with skin or hair follicles', 'Cosmetic lasers use only gamma radiation', 'Laser treatments rely solely on X-ray radiation', 'Specific wavelengths of light are absorbed by pigments (like melanin) in hair follicles or skin, generating heat that damages the targeted tissue while sparing surrounding areas'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the use of electromagnetic waves in electronic voting or identification systems that use RFID or NFC-enabled ID cards?',
          'options': ['Identification systems require physical insertion into a reader at all times', 'RFID/NFC ID systems have no basis in electromagnetic theory', 'Radio frequency signals allow wireless, contactless reading of identification data stored on a chip embedded in a card', 'These systems use gamma radiation to verify identity'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why deep-space probes like Voyager use large dish antennas to communicate with Earth using radio waves?',
          'options': ['Larger antennas focus radio wave transmission and reception more precisely, improving signal strength over the vast distances involved in deep space communication', 'Dish antennas cannot be used for radio communication', 'Deep-space probes use visible light lasers instead of radio waves', 'Antenna size has no effect on radio wave communication over long distances'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why airport and military applications sometimes use electromagnetic jamming, which deliberately transmits interfering signals on specific frequencies?',
          'options': ['Jamming floods a specific frequency band with noise or competing signals, disrupting the ability of receivers to properly detect the intended signal', 'Jamming works only on visible light communication', 'Jamming has no effect on electromagnetic communication', 'Electromagnetic jamming is a purely theoretical concept with no real application'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why fibre-optic cables used undersea for intercontinental internet connections are considered more secure against certain types of interception compared to wireless (radio) transmission?',
          'options': ['Signals confined within a physical fibre-optic cable are harder to intercept remotely compared to radio waves broadcast openly through the air', 'Fibre-optic cables broadcast their signal in all directions like radio waves', 'Fibre optics cannot be used for long-distance communication', 'Undersea cables provide no security benefit over wireless transmission'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why some agricultural drones use multispectral cameras capturing visible and near-infrared light to assess crop health?',
          'options': ['Only visible light cameras are used in agricultural drones', 'Crop health cannot be assessed using electromagnetic imaging', 'Multispectral imaging has no use in agriculture', 'Healthy vegetation reflects near-infrared light differently than stressed or unhealthy vegetation, so combining visible and infrared data helps assess crop condition remotely'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why some smart home devices use a combination of Wi-Fi (microwave), Bluetooth (radio), and infrared signals depending on the required range and application?',
          'options': ['Different wireless technologies offer trade-offs in range, power consumption, and data rate, so devices choose the type of electromagnetic wave best suited for their specific function', 'Wireless technology choice has no effect on device performance', 'Smart home devices cannot use multiple types of electromagnetic communication', 'All smart home devices must use only one type of electromagnetic wave'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why radio astronomy observatories are often built in remote locations far from cities?',
          'options': ['Location has no effect on radio telescope sensitivity', 'Radio telescopes work better in densely populated areas', 'Remote locations have stronger natural radio wave sources', 'Reducing local radio frequency interference (from human technology) allows more sensitive detection of faint radio signals from distant astronomical sources'],
          'correct': 3,
        },
      ];
    case 'phy102_u3_2': // Motors, Generators and Transformers
      return [
        {
          'question': 'An electric motor converts which form of energy into mechanical energy?',
          'options': ['Thermal energy', 'Nuclear energy', 'Electrical energy', 'Chemical energy'],
          'correct': 2,
        },
        {
          'question': 'An electric generator converts which form of energy into electrical energy?',
          'options': ['Chemical energy directly', 'Mechanical energy', 'Electrical energy', 'Nuclear energy directly'],
          'correct': 1,
        },
        {
          'question': 'The basic operating principle of an electric motor relies on the?',
          'options': ['Resistance heating', 'Capacitive charge storage', 'Force experienced by a current-carrying conductor in a magnetic field', 'Electromagnetic induction of EMF'],
          'correct': 2,
        },
        {
          'question': 'The basic operating principle of an electric generator relies on?',
          'options': ['The force on a current-carrying conductor', 'Electromagnetic induction (a changing magnetic flux inducing an EMF)', 'Resistance heating', 'Capacitive discharge'],
          'correct': 1,
        },
        {
          'question': 'Faraday\'s law of electromagnetic induction states that the induced EMF in a coil is proportional to the?',
          'options': ['Current flowing through the coil initially', 'Resistance of the coil', 'Temperature of the coil', 'Rate of change of magnetic flux through the coil'],
          'correct': 3,
        },
        {
          'question': 'The direction of induced current, as described by Lenz\'s law, always opposes the?',
          'options': ['Direction of the applied voltage always', 'Direction of motion of the observer', 'Change in magnetic flux that produces it', 'Resistance of the circuit'],
          'correct': 2,
        },
        {
          'question': 'In a simple DC motor, the component that reverses the direction of current in the coil every half turn is called the?',
          'options': ['Slip ring', 'Brush only', 'Commutator', 'Armature core'],
          'correct': 2,
        },
        {
          'question': 'In a simple AC generator, the component that maintains continuous electrical contact with the rotating coil without reversing current direction is called the?',
          'options': ['Stator core', 'Commutator', 'Slip rings', 'Brushes only, without rings'],
          'correct': 2,
        },
        {
          'question': 'The stationary part of a motor or generator, often containing magnets or field windings, is called the?',
          'options': ['Stator', 'Commutator', 'Rotor', 'Armature only'],
          'correct': 0,
        },
        {
          'question': 'The rotating part of a motor or generator, typically the coil, is called the?',
          'options': ['Rotor (armature)', 'Stator', 'Brush', 'Commutator only'],
          'correct': 0,
        },
        {
          'question': 'Carbon brushes in a motor or generator serve mainly to?',
          'options': ['Generate the magnetic field', 'Increase resistance intentionally', 'Cool the device', 'Maintain electrical contact between the stationary and rotating parts of the circuit'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes why the coil in a DC motor experiences a continuous torque in one direction, despite the current reversing every half cycle?',
          'options': ['The current never actually reverses in a DC motor', 'Torque direction is unrelated to current direction', 'The commutator reverses the current in the coil at the same time the coil\'s orientation changes, maintaining a consistent torque direction', 'DC motors do not use commutators'],
          'correct': 2,
        },
        {
          'question': 'In an AC generator, the EMF induced in the rotating coil varies?',
          'options': ['Only when the coil stops rotating', 'Linearly with time', 'Remains constant regardless of rotation', 'Sinusoidally with time as the coil rotates in the magnetic field'],
          'correct': 3,
        },
        {
          'question': 'The peak EMF generated by a simple AC generator is given by EMF0 = ?',
          'options': ['NBAomega^2', 'N/(BA omega)', 'NBA omega', 'NBA/omega'],
          'correct': 2,
        },
        {
          'question': 'In the generator EMF formula, \'omega\' represents the?',
          'options': ['Number of turns', 'Angular velocity of rotation', 'Area of the coil', 'Magnetic field strength'],
          'correct': 1,
        },
        {
          'question': 'Increasing the rotational speed of a generator\'s coil will generally?',
          'options': ['Reverse the polarity permanently', 'Decrease the induced EMF', 'Increase the induced EMF (and frequency)', 'Have no effect on the induced EMF'],
          'correct': 2,
        },
        {
          'question': 'Increasing the number of turns in a generator\'s coil will generally?',
          'options': ['Decrease the induced EMF', 'Increase the induced EMF, for a given rate of flux change', 'Eliminate the induced EMF', 'Have no effect'],
          'correct': 1,
        },
        {
          'question': 'A DC generator differs from an AC generator mainly due to the use of a?',
          'options': ['Commutator instead of slip rings, converting the internally generated AC into a pulsating DC output', 'Different type of magnet entirely', 'Slip ring instead of a commutator', 'Larger coil only'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why the output of a simple DC generator (using a split-ring commutator) is described as \'pulsating DC\' rather than perfectly steady DC?',
          'options': ['Pulsating DC is identical to AC in all respects', 'The commutator produces a perfectly constant voltage with no variation', 'DC generators cannot produce any usable output', 'The commutator reverses connections each half cycle, but the resulting voltage still varies in magnitude (though not sign) as the coil rotates'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes how using multiple coils, offset in angle, in a practical DC generator helps smooth the output voltage?',
          'options': ['Multiple coils always produce a purely sinusoidal output', 'It has no effect on output smoothness', 'Additional coils eliminate the need for a commutator', 'Overlapping voltage pulses from multiple coils combine to produce a much steadier, smoother output voltage'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the difference between an AC motor and a DC motor in terms of power supply requirement?',
          'options': ['An AC motor requires direct current, a DC motor requires alternating current', 'Neither motor type is affected by current type', 'Both motor types require identical power supplies', 'An AC motor is designed to run on alternating current, a DC motor is designed to run on direct current'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an induction motor, a common type of AC motor?',
          'options': ['A motor with no rotating parts', 'A motor that requires direct electrical connections to the rotor via brushes', 'A motor in which the rotor current is induced by the changing magnetic field of the stator, without direct electrical connections to the rotor', 'A motor that only works with DC power'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why induction motors are widely used in industrial applications due to their simple and robust design?',
          'options': ['Induction motors cannot produce continuous rotation', 'They require frequent brush replacement and are prone to failure', 'Induction motors require highly complex control systems for basic operation', 'They have no brushes or commutator (in squirrel-cage designs), reducing maintenance needs and increasing reliability'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes \'back EMF\' in the context of a running electric motor?',
          'options': ['An EMF unrelated to motor operation', 'An EMF generated by an external power source only', 'An EMF that only appears when the motor is turned off', 'An EMF induced in the motor\'s coil (due to its own rotation in the magnetic field) that opposes the applied voltage, in accordance with Lenz\'s law'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why a motor draws more current when it first starts (before back EMF builds up) compared to during normal running speed?',
          'options': ['Back EMF has no effect on current draw', 'Starting current is always lower than running current', 'Motors always draw maximum current only after reaching full speed', 'Back EMF opposes the applied voltage and increases as the motor speeds up, reducing the net voltage driving current through the coil\'s resistance, thus reducing current draw once running'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes why a stalled or overloaded motor (unable to rotate) can potentially overheat and be damaged?',
          'options': ['A stalled motor always draws less current than a running motor', 'A stalled motor generates no back EMF, so the current is limited only by coil resistance, which can result in excessive current and heating', 'Back EMF increases when a motor stalls, limiting current safely', 'Stalled motors cannot be damaged by excessive current'],
          'correct': 1,
        },
        {
          'question': 'The efficiency of an electric motor is generally defined as the ratio of?',
          'options': ['Voltage to current', 'Output mechanical power to input electrical power', 'Resistance to reactance', 'Input electrical power to output mechanical power'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a common cause of energy loss (reducing efficiency) in real electric motors and generators?',
          'options': ['Complete absence of any moving parts', 'Perfectly frictionless bearings', 'Resistive (I^2R) losses in windings, friction, and magnetic core losses (hysteresis and eddy currents)', 'Zero resistance windings'],
          'correct': 2,
        },
        {
          'question': 'A transformer is a device used primarily to change the?',
          'options': ['Power delivered, increasing total energy', 'Frequency of an AC supply', 'Type of current from AC to DC directly', 'Voltage (and correspondingly current) level of an AC supply'],
          'correct': 3,
        },
        {
          'question': 'A transformer operates based on the principle of?',
          'options': ['Simple resistance', 'Magnetic force on a moving charge', 'Self-inductance only', 'Mutual inductance (electromagnetic induction between two coils)'],
          'correct': 3,
        },
        {
          'question': 'A step-up transformer has which relationship between the number of turns in its primary and secondary coils?',
          'options': ['More turns in secondary than primary', 'Equal turns in both coils', 'No fixed relationship', 'Fewer turns in secondary than primary'],
          'correct': 0,
        },
        {
          'question': 'A step-down transformer has which relationship between the number of turns in its primary and secondary coils?',
          'options': ['No relationship exists', 'Fewer turns in secondary than primary', 'Equal turns in both coils', 'More turns in secondary than primary'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why power stations typically use step-up transformers before transmitting electricity over long-distance power lines?',
          'options': ['Step-up transformers have no role in power transmission', 'To increase voltage (and reduce current) for transmission, reducing resistive power losses (I^2R) in the transmission lines', 'To reduce voltage and increase current for safer local use', 'To convert AC power to DC for transmission'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why step-down transformers are used near residential and commercial areas before electricity reaches homes and businesses?',
          'options': ['To reduce the high transmission voltage to safer, usable levels for household and business appliances', 'Step-down transformers increase current to dangerous levels intentionally', 'Step-down transformers convert AC to DC', 'To further increase the high transmission voltage for safety'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes an ideal transformer\'s efficiency, assuming no energy losses?',
          'options': ['50 percent', 'Cannot be determined', 'Less than 50 percent always', '100 percent (all input power is transferred to output)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains hysteresis losses in a transformer\'s iron core, arising from repeated magnetisation and demagnetisation with AC current?',
          'options': ['Hysteresis losses increase transformer efficiency', 'Energy is dissipated as heat due to the lag between the applied magnetic field and the core\'s magnetisation during each AC cycle', 'Hysteresis losses only occur in DC circuits', 'Hysteresis losses generate no heat'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains eddy current losses in a transformer core, and why laminated cores help reduce them?',
          'options': ['Eddy currents have no relation to transformer core design', 'Eddy currents are currents induced within the core material itself by the changing magnetic flux; laminating the core into thin, insulated sheets restricts these current loops, reducing energy loss', 'Laminated cores increase eddy current losses', 'Eddy currents only occur in laminated cores, not solid cores'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes copper losses in a transformer, distinct from core (iron) losses?',
          'options': ['Losses caused solely by magnetic hysteresis', 'Losses occurring only in the core material', 'A term unrelated to transformer operation', 'Energy losses due to resistive heating (I^2R) in the primary and secondary windings'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes why transformers can only be used with alternating current, not direct current, for voltage transformation?',
          'options': ['Mutual induction requires a continuously changing magnetic flux, which is produced by AC but not by steady DC', 'Transformer operation is unrelated to changing magnetic flux', 'DC current produces stronger induction effects than AC', 'Transformers work equally well with steady DC current'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the construction feature of using a common iron core in most transformers to link the primary and secondary coils?',
          'options': ['The iron core, due to its high magnetic permeability, concentrates and channels magnetic flux, maximising the coupling (mutual inductance) between the primary and secondary coils', 'The iron core has no effect on transformer performance', 'Iron cores decrease mutual inductance intentionally', 'Iron cores are used purely for structural support with no magnetic function'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the term \'no-load current\' in a transformer, drawn by the primary coil even when the secondary circuit is open (no load connected)?',
          'options': ['A current that only flows in the secondary coil', 'A large current equal to full-load current', 'A small current mainly needed to establish the magnetic flux in the core and supply core losses', 'A current unrelated to transformer operation'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why large power transformers are often filled with oil, in addition to their core and windings?',
          'options': ['Oil is used purely for aesthetic purposes', 'Transformer oil has no functional purpose', 'Transformer oil acts as both an insulator and a coolant, helping dissipate heat generated by resistive and core losses', 'Oil increases resistive losses intentionally'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why generators used in power plants often produce three-phase AC power rather than single-phase power?',
          'options': ['Power plants cannot generate three-phase power', 'Three-phase power offers more efficient and smoother power transmission and is better suited for large industrial loads and motors, compared to single-phase power', 'Single-phase power is always more efficient for large-scale generation', 'Three-phase power is identical to single-phase power in all respects'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes a synchronous generator (alternator), commonly used in large power plants?',
          'options': ['A generator that only produces DC output', 'A generator in which the rotor speed is synchronised with the frequency of the generated AC output (based on the number of poles)', 'A generator whose output frequency is unrelated to its rotational speed', 'A generator with no relationship between speed and frequency'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why hydroelectric, thermal (coal/gas), and nuclear power plants all typically use similar generator designs to produce electricity?',
          'options': ['Only nuclear plants use electromagnetic generators', 'Regardless of the energy source used to spin the turbine, the fundamental principle of electromagnetic induction (a rotating coil/magnet inducing EMF) remains the same across these plant types', 'Generators are unrelated to turbine rotation', 'Each power plant type requires an entirely different type of generator with no shared principles'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the role of a turbine in a power generation system, working together with a generator?',
          'options': ['The turbine converts electrical energy into mechanical energy', 'The turbine has no functional role in power generation', 'The turbine converts the kinetic energy of a moving fluid (steam, water, or wind) into mechanical rotational energy, which drives the generator to produce electricity', 'The turbine directly produces electricity without a generator'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes regenerative braking in electric and hybrid vehicles, an application combining motor and generator principles?',
          'options': ['During braking, the electric motor operates in reverse as a generator, converting the vehicle\'s kinetic energy back into electrical energy stored in the battery', 'Braking energy is always completely lost as heat with no recovery', 'The vehicle\'s motor operates only as a motor, never as a generator', 'Regenerative braking has no relation to electromagnetic principles'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why brushless DC motors are increasingly used in applications like drones and computer cooling fans, compared to traditional brushed DC motors?',
          'options': ['Brushless motors require more maintenance than brushed motors', 'Brushless motors cannot achieve continuous rotation', 'Brushed motors are always more efficient than brushless motors', 'Brushless motors use electronic controllers to switch current direction, eliminating the wear and maintenance issues associated with mechanical brushes and commutators'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes a permanent magnet DC motor, one of the simplest types of electric motor?',
          'options': ['A motor with no magnetic field involved', 'A motor that only functions with AC power', 'A motor using electromagnets exclusively for both stator and rotor', 'A motor using permanent magnets to create the stationary magnetic field, with a current-carrying rotor (armature) that experiences torque'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why the speed of a simple DC motor generally increases with increasing applied voltage (within safe limits)?',
          'options': ['Motor speed is determined solely by the number of turns in the coil', 'Voltage has no effect on motor speed', 'Higher voltage increases the current through the armature (up to the limit set by back EMF and resistance), increasing torque and thus rotational speed until a new equilibrium with back EMF is reached', 'Increasing voltage always stops the motor'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes a stepper motor, used in precision applications like 3D printers and robotics?',
          'options': ['A motor that rotates continuously at a fixed speed with no ability to stop at defined positions', 'A motor that rotates in small, discrete, precisely controlled steps, allowing accurate positioning', 'A motor that cannot be electronically controlled', 'A motor identical in operation to an induction motor'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a linear motor, as opposed to a typical rotary electric motor?',
          'options': ['A motor identical to a rotary motor with no functional difference', 'A motor used only for generating electricity, not motion', 'A motor that cannot use electromagnetic principles', 'A motor that produces motion in a straight line rather than rotational motion, using similar electromagnetic principles'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the working principle of maglev (magnetic levitation) trains, which use linear motors and powerful electromagnets?',
          'options': ['Maglev trains rely solely on gravity for propulsion', 'Maglev trains use wheels and friction for propulsion, with no role for magnetism', 'Maglev trains use magnetic forces to levitate above the track and linear motor principles to propel the train forward, eliminating friction from wheels on rails', 'Magnetic levitation has no practical transportation application'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies the primary factor that determines the frequency of the AC output from a simple generator with a fixed number of poles?',
          'options': ['The resistance of the external circuit', 'The voltage of the power source driving the rotor', 'The type of wire used in the coil', 'The rotational speed of the generator\'s rotor'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why maintaining a constant rotational speed is critical for generators supplying power to a national electrical grid?',
          'options': ['Generators can supply power at any frequency without consequence', 'Rotational speed has no effect on generator output frequency', 'Grid frequency has no importance to connected devices', 'Grid frequency (e.g., 50 or 60 Hz) must be maintained precisely, as many devices and synchronised systems depend on a stable, consistent frequency'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why some countries use a standard AC frequency of 50 Hz, while others (like the United States) use 60 Hz?',
          'options': ['Frequency choice has no historical or regional basis', 'These are historical engineering standards adopted by different regions/countries for their electrical grids, based on early technological and infrastructure decisions', 'All countries are required by international law to use only 50 Hz', '60 Hz systems cannot support any electrical devices'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the concept of a rotating magnetic field, essential to the operation of AC induction motors?',
          'options': ['A magnetic field found only in DC motors', 'A magnetic field produced by multiphase AC currents in stator windings that appears to rotate, inducing current and torque in the rotor', 'A magnetic field unrelated to motor operation', 'A magnetic field that remains completely static regardless of the applied current'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes \'slip\' in the context of an induction motor, referring to the difference between the rotating magnetic field\'s speed and the rotor\'s actual speed?',
          'options': ['Slip refers to mechanical wear on motor brushes only', 'Induction motors do not experience any slip', 'Slip is always zero in induction motors', 'Slip is the small speed difference needed for relative motion between the rotor and rotating magnetic field, which induces the rotor current necessary for torque production'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why large industrial motors often require additional starting circuitry (such as a soft starter) rather than being connected directly to full power?',
          'options': ['The initial starting current (before back EMF develops) can be very high, so starting circuitry helps limit inrush current and reduce mechanical/electrical stress', 'Starting circuitry has no functional benefit', 'Direct starting always provides the smoothest operation', 'Motors experience no current surge at startup'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes an autotransformer\'s key structural difference from a standard two-winding transformer?',
          'options': ['It uses a single winding shared between the primary and secondary circuits, tapped at different points', 'It uses two completely separate windings with no shared connection', 'It has no magnetic core', 'It cannot be used to step up or step down voltage'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why autotransformers are generally more compact and efficient than equivalent two-winding transformers, but offer no electrical isolation?',
          'options': ['There is no difference in efficiency between the two transformer types', 'Autotransformers provide better electrical isolation than standard transformers', 'Autotransformers are always larger than two-winding transformers', 'Autotransformers use less copper and have lower losses due to their shared winding design, but since primary and secondary share a common electrical connection, they do not isolate the circuits'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes an isolation transformer, often used for safety purposes in sensitive electrical equipment?',
          'options': ['A transformer that provides no isolation benefit', 'A transformer with a 1:1 turns ratio designed to electrically isolate a device from the main power supply while maintaining the same voltage, improving safety', 'A transformer that always changes the voltage significantly', 'A transformer that can only be used to step up voltage'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why a doorbell transformer is a common household example of a step-down transformer?',
          'options': ['It steps up the mains voltage to a dangerously high level', 'Doorbell circuits require the full mains voltage without transformation', 'Doorbell transformers do not exist in residential wiring', 'It steps down the mains voltage (e.g., 120V or 230V) to a much lower voltage (e.g., 12-24V) suitable for safely operating a doorbell circuit'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the role of a distribution transformer typically seen mounted on utility poles or in ground-level enclosures in residential neighbourhoods?',
          'options': ['It converts AC power to DC power for homes', 'It generates electricity directly from mechanical energy', 'It steps down the medium-voltage electricity from local distribution lines to the lower voltage used by household appliances', 'It has no functional role in the power distribution system'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes an armature in the context of motors and generators?',
          'options': ['The stationary magnetic field component', 'A term unrelated to motors and generators', 'A type of transformer core', 'The current-carrying winding (typically the rotating part in many designs) in which EMF is induced or torque is produced'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes a series-wound DC motor, in which the field winding is connected in series with the armature?',
          'options': ['Series-wound motors cannot start under load', 'It provides high starting torque, useful in applications like electric trains and starter motors, though speed varies significantly with load', 'Field windings play no role in this motor type', 'It provides constant speed regardless of load, always'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes a shunt-wound DC motor, in which the field winding is connected in parallel with the armature?',
          'options': ['Field and armature windings are electrically identical in this configuration', 'It provides relatively constant speed across varying loads, useful in applications requiring stable speed', 'It cannot maintain consistent speed under any condition', 'Shunt-wound motors have no practical applications'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes a compound-wound DC motor, combining features of series and shunt winding configurations?',
          'options': ['Compound motors cannot be used in any real application', 'It has no practical difference from a series motor', 'It eliminates the need for any field winding', 'It combines characteristics of both series and shunt motors, offering a balance of good starting torque and relatively stable speed regulation'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why universal motors (which can run on both AC and DC) are commonly used in household appliances like vacuum cleaners and power tools?',
          'options': ['These motors have no practical household applications', 'Universal motors are compact, lightweight, and capable of high rotational speeds while operating on either AC or DC supply, making them versatile for portable appliances', 'Universal motors only function with three-phase power', 'Universal motors cannot achieve high rotational speeds'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the difference between synchronous and asynchronous (induction) AC motors in terms of rotor speed relative to the rotating magnetic field?',
          'options': ['A synchronous motor\'s rotor speed matches the rotating magnetic field\'s speed exactly, while an induction motor\'s rotor speed lags slightly behind (slip)', 'Induction motors always rotate faster than the magnetic field', 'Synchronous motors cannot maintain constant speed', 'Both motor types always rotate at identical, fixed speeds'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why synchronous motors are often used in applications requiring very precise and constant speed, such as certain industrial clocks or precision machinery?',
          'options': ['Synchronous motors have highly variable speed depending on load', 'Synchronous motors cannot maintain any fixed relationship to frequency', 'Precision applications never require constant motor speed', 'Synchronous motors maintain a constant speed precisely locked to the supply frequency, regardless of load variations (within limits), providing precise timing'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly identifies why large power transformers often have a distinctive humming sound during operation?',
          'options': ['The humming indicates the transformer is malfunctioning', 'Transformers produce no sound during normal operation', 'Sound has no relation to the transformer\'s magnetic core', 'The hum is caused by magnetostriction (slight changes in the physical dimensions of the core) as the alternating magnetic field cycles, causing vibration at the AC frequency'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why transformer cores are typically made of silicon steel rather than plain iron?',
          'options': ['Adding silicon to iron increases electrical resistivity, reducing eddy current losses, while maintaining good magnetic properties', 'Plain iron always performs better than silicon steel in transformers', 'Silicon steel has no advantages over plain iron for transformer cores', 'Silicon steel is used purely for cost reasons with no technical benefit'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the load on a transformer and how it affects the current drawn by the primary coil?',
          'options': ['Primary current decreases as secondary load increases', 'The primary current is completely independent of the load connected to the secondary coil', 'Transformers cannot supply variable loads', 'As the load on the secondary coil increases (drawing more current), the current drawn by the primary coil also increases to supply the corresponding power'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes why generators in a power plant must be carefully synchronised (matching frequency, voltage, and phase) before being connected to the electrical grid?',
          'options': ['Generators are always automatically synchronised with no need for careful control', 'Connecting an unsynchronised generator to the grid can cause damaging electrical transients, equipment damage, or grid instability', 'Synchronisation has no importance for grid-connected generators', 'Only the voltage needs to match, not frequency or phase'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why a bicycle dynamo (hub generator) can power a bicycle\'s lights while cycling?',
          'options': ['The dynamo converts light energy directly into electrical energy', 'Dynamos have no relation to electromagnetic induction', 'The dynamo converts the mechanical energy of the wheel\'s rotation into electrical energy via electromagnetic induction, powering the lights', 'The dynamo requires an external battery to function'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes a wind turbine\'s basic energy conversion process, from wind to electricity?',
          'options': ['Wind turns the turbine blades (mechanical energy), which drives a generator to convert this mechanical energy into electrical energy via electromagnetic induction', 'Wind directly generates electricity without any mechanical component', 'Wind turbines use only solar panels to generate power', 'Wind energy cannot be converted into electrical energy'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why larger wind turbine blades and higher wind speeds generally result in greater electrical power output, up to the turbine\'s design limits?',
          'options': ['Smaller blades always produce more power than larger blades', 'Greater blade sweep area and higher wind speed increase the kinetic energy captured and converted by the turbine, increasing the mechanical power driving the generator', 'Blade size and wind speed have no effect on power output', 'Wind speed only affects the turbine\'s structural integrity, not its power output'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the function of a rectifier in converting the AC output of a generator into DC, as used in some vehicle charging systems (alternators)?',
          'options': ['A rectifier uses components (typically diodes) to convert alternating current into direct current by allowing current to flow in only one direction', 'A rectifier has no role in AC-to-DC conversion', 'A rectifier increases the AC frequency', 'A rectifier is identical in function to a transformer'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why vehicle alternators (a type of AC generator combined with a rectifier) are used instead of simple DC generators in most modern cars?',
          'options': ['Alternators are generally more efficient, reliable, and capable of charging the battery even at low engine idle speeds compared to older DC generator designs', 'Alternators have no practical advantages over older designs', 'Alternators cannot charge a car battery', 'DC generators are always more efficient than alternators'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why electric motors are used in a wide range of applications, from small household appliances to large industrial machinery and electric vehicles?',
          'options': ['Electric motors offer efficient, controllable conversion of electrical energy into mechanical motion, applicable across a huge range of scales and power requirements', 'Motors are rarely used in industrial machinery', 'Electric motors can only be used for very small-scale applications', 'Electric motors have very limited practical applications'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the role of gearing (mechanical gears) often used in conjunction with electric motors in various applications?',
          'options': ['Gears have no functional purpose alongside motors', 'Gears can adjust the output speed and torque of a motor to match the specific requirements of a given application (e.g., trading speed for increased torque)', 'Gears eliminate the need for any electrical power', 'Gears always reduce a motor\'s efficiency to zero'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly explains why some high-power industrial motors and generators require active cooling systems, such as fans or liquid cooling?',
          'options': ['Cooling systems have no relevance to motor or generator operation', 'These machines produce no heat during operation', 'Heat generation only affects small, low-power motors', 'Resistive losses (I^2R) and other inefficiencies generate heat, which must be managed to prevent overheating and damage to windings and insulation'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the general trend in transformer efficiency for large power transformers used in electrical grids, compared to small transformers such as those in phone chargers?',
          'options': ['Large power transformers are generally designed to be highly efficient (often above 95-99%), given the significant cost implications of losses at large power scales', 'All transformers, regardless of size, have identical efficiency', 'Large power transformers are typically less efficient than small transformers', 'Efficiency is unrelated to transformer size or power scale'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why the National Grid (or similar national electrical networks) uses a combination of many generators, transformers, and transmission lines working together?',
          'options': ['Combining multiple generation sources and using transformers/transmission infrastructure allows for reliable, efficient, and widespread distribution of electrical power across large areas', 'Generators and transformers serve entirely unrelated functions in power systems', 'A single generator alone could reliably power an entire country with no infrastructure needed', 'National grids do not use transformers at all'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why some remote or off-grid locations use small-scale generators combined with local step-up/step-down transformers?',
          'options': ['Small-scale generation cannot use transformer technology', 'Off-grid systems never require transformers', 'Local power systems are unrelated to transformer principles', 'To allow generated power to be efficiently transmitted even short distances, minimising losses, and then transformed to appropriate voltages for local use, similar in principle to large-scale grids'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly explains why permanent magnet synchronous motors are increasingly used in electric vehicles compared to some older induction motor designs?',
          'options': ['Electric vehicles cannot use synchronous motor designs', 'They generally offer higher efficiency and power density due to the strong, consistent magnetic field provided by permanent magnets rather than induced fields', 'Permanent magnet motors are always less efficient than induction motors', 'Permanent magnets provide no advantage in motor design'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why some elevators and cranes use motors with regenerative braking capability, similar to that used in electric vehicles?',
          'options': ['Regenerative capability has no use in elevators or cranes', 'Elevators cannot recover any energy during operation', 'When lowering a load, the motor can act as a generator, converting the load\'s potential/kinetic energy back into electrical energy rather than dissipating it entirely as heat through mechanical braking', 'Only vehicles can use regenerative braking technology'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why a step-up transformer used at a solar or wind farm is needed before feeding generated electricity into the main transmission grid?',
          'options': ['Renewable energy sources cannot be connected to transformers', 'Step-up transformers are not used in renewable energy systems', 'Solar and wind farms generate electricity at the exact transmission voltage already', 'Generated electricity at these farms is typically at a lower voltage suited to the generation equipment, requiring step-up transformation to match the higher transmission grid voltage efficiently'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes a key safety reason why transformers, rather than direct wiring, are used to connect high-voltage transmission lines to lower-voltage distribution networks?',
          'options': ['Direct high-voltage connections to homes pose no safety risk', 'Direct connection without transformation would deliver dangerously high voltages to end users, so transformers safely step down voltage to usable and safer levels', 'Transformers have no role in electrical safety', 'Transformers increase safety risk by increasing voltage for consumers'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly explains why some critical facilities (like hospitals) use backup generators in conjunction with automatic transfer switches?',
          'options': ['Automatic transfer switches are unrelated to generator systems', 'Hospitals never require backup power systems', 'Backup generators provide no benefit during power outages', 'In the event of a main power failure, the transfer switch can automatically connect the facility to a backup generator, ensuring continuous power supply for critical operations'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly explains why the torque produced by a simple DC motor coil is not constant throughout a full rotation, even with a commutator maintaining consistent current direction?',
          'options': ['The commutator eliminates all torque variation completely', 'The torque depends on the angle between the coil\'s plane and the magnetic field, being maximum when the coil is parallel to the field and zero when perpendicular, causing torque to vary cyclically', 'Torque variation only occurs in AC motors, not DC motors', 'Torque is always perfectly constant throughout rotation'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why practical DC motors often use multiple coils (armature windings) arranged at different angles, rather than a single coil?',
          'options': ['Multiple coils have no effect on torque smoothness', 'A single coil always produces the smoothest possible torque', 'Using multiple coils at different angular positions helps ensure that at least one coil is always producing significant torque, resulting in smoother, more consistent overall torque output', 'Multiple coils are used only to reduce manufacturing cost'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why some low-power devices use simple permanent magnet motors, whereas large industrial motors typically use electromagnets for the stator field instead?',
          'options': ['Electromagnets allow for a much stronger and adjustable magnetic field suited to high-power applications, while permanent magnets are often sufficient and cost-effective for smaller, lower-power devices', 'There is no practical difference between permanent magnet and electromagnet-based stators', 'Electromagnets cannot be used in any motor design', 'Permanent magnets are always used in large industrial motors'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the fundamental energy transformation relationship between a motor and a generator, given that both use similar electromagnetic principles?',
          'options': ['A motor and generator perform identical functions with no distinction', 'A motor converts electrical energy to mechanical energy, while a generator performs the reverse conversion, converting mechanical energy to electrical energy; in fact, the same basic device can often function as either depending on how it is driven', 'Only generators rely on electromagnetic induction, motors do not', 'Motors and generators use entirely unrelated physical principles'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why hydroelectric dams are effective sources of large-scale electricity generation using generators?',
          'options': ['The gravitational potential energy of stored water is converted into kinetic energy as it flows through turbines, which then drives generators to produce electricity via electromagnetic induction', 'Hydroelectric dams generate electricity through solar panels installed on the dam structure', 'Falling or flowing water has no usable mechanical energy', 'Water flow cannot be used to generate electricity'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why household electrical appliances are typically rated for a specific voltage (e.g., 120V or 230V) matching the local grid supply, often stepped down via transformers from higher transmission voltages?',
          'options': ['Appliances are designed to operate safely and efficiently only within a specific voltage range, so the electricity distribution system uses transformers to match generation/transmission voltages to appliance requirements', 'Appliance voltage ratings have no relation to the electrical distribution system', 'Transformers are not involved in matching voltage to appliance requirements', 'All appliances can safely operate at any voltage without transformation'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why some countries with 50 Hz grid frequency and others with 60 Hz require different transformer and motor designs when importing electrical equipment?',
          'options': ['All electrical equipment works identically regardless of frequency standard', 'Motors and transformers are often designed and optimised for a specific operating frequency, so equipment designed for one frequency standard may not perform correctly or efficiently on another', 'Frequency has no effect on transformer or motor design or performance', 'Frequency standards are identical worldwide with no variation'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why some large electric motors require a \'star-delta\' starting method to reduce initial current draw during startup?',
          'options': ['Starting the motor in a star configuration initially reduces the voltage (and thus current) applied to each winding, before switching to a delta configuration for normal full-voltage running, reducing inrush current stress', 'Star-delta configurations are unrelated to motor starting behaviour', 'Star-delta starting has no effect on startup current', 'This method is used only to increase starting torque with no effect on current'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly summarises the overall relationship between motors, generators, and transformers as core technologies of the modern electrical power system?',
          'options': ['These three devices are entirely unrelated to one another', 'Transformers generate electricity directly, making generators unnecessary', 'Generators produce electrical energy from mechanical energy, transformers efficiently adjust voltage levels for transmission and distribution, and motors convert electrical energy back into mechanical energy for countless practical applications, together forming the backbone of modern electrical power systems', 'Only motors are used in modern electrical systems, generators and transformers are obsolete'],
          'correct': 2,
        },
      ];
    case 'phy102_u3_3': // Modern Physics Applications
      return [
        {
          'question': 'The photoelectric effect refers to the emission of electrons from a material when it is exposed to?',
          'options': ['Gravitational fields', 'Magnetic fields only', 'Sound waves', 'Light of sufficient frequency'],
          'correct': 3,
        },
        {
          'question': 'The photoelectric effect was successfully explained by Albert Einstein using the concept of?',
          'options': ['Classical electromagnetic theory alone', 'Quantised light energy (photons)', 'Newtonian mechanics only', 'Continuous wave energy'],
          'correct': 1,
        },
        {
          'question': 'According to the photoelectric effect, increasing the intensity of light (at a fixed frequency below threshold) will?',
          'options': ['Have no relevance to electron emission at all', 'Not cause electron emission if the frequency is below the threshold frequency', 'Always increase the kinetic energy of emitted electrons', 'Cause electron emission regardless of frequency'],
          'correct': 1,
        },
        {
          'question': 'The minimum frequency of light required to eject electrons from a given material is called the?',
          'options': ['Resonant frequency', 'Peak frequency', 'Critical frequency (unrelated term)', 'Threshold frequency'],
          'correct': 3,
        },
        {
          'question': 'The work function of a material refers to the?',
          'options': ['Kinetic energy of emitted electrons only', 'Wavelength of emitted electrons', 'Minimum energy needed to remove an electron from the material\'s surface', 'Total energy of incoming photons'],
          'correct': 2,
        },
        {
          'question': 'The Einstein photoelectric equation is given by KEmax = ?',
          'options': ['W - hf', 'hf + W', 'hf - W (photon energy minus work function)', 'hf * W'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why the photoelectric effect could not be fully explained by classical wave theory of light?',
          'options': ['Classical theory fully explained the photoelectric effect with no issues', 'Classical theory had no relevance to any optical phenomena', 'Classical theory could not explain why electron emission depended on frequency (not just intensity) and why emission was instantaneous rather than delayed', 'Classical theory correctly predicted the instantaneous emission of electrons at any frequency'],
          'correct': 2,
        },
        {
          'question': 'Which application relies directly on the photoelectric effect to convert light into an electrical signal?',
          'options': ['Permanent magnets', 'Transformers', 'Simple resistors', 'Solar panels/photovoltaic cells and photodiodes'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes a photomultiplier tube, a device used to detect very low levels of light using the photoelectric effect?',
          'options': ['A device that amplifies a weak initial photoelectron signal through successive electron multiplication stages, enabling detection of extremely faint light signals', 'A device that only works with intense light sources', 'A device unrelated to the photoelectric effect', 'A device that converts light into sound'],
          'correct': 0,
        },
        {
          'question': 'Nuclear fission refers to the process in which?',
          'options': ['A heavy atomic nucleus splits into two or more smaller nuclei, releasing energy', 'An electron is emitted from an atom\'s outer shell', 'Two light nuclei combine to form a heavier nucleus', 'An atom absorbs a photon and becomes excited'],
          'correct': 0,
        },
        {
          'question': 'Nuclear fusion refers to the process in which?',
          'options': ['An atom loses an electron', 'Two light nuclei combine to form a heavier nucleus, releasing energy', 'A heavy nucleus splits apart', 'A photon is absorbed without any nuclear change'],
          'correct': 1,
        },
        {
          'question': 'Which of these is the primary nuclear process powering the sun and most stars?',
          'options': ['Radioactive decay only', 'Nuclear fission', 'Chemical combustion', 'Nuclear fusion (primarily hydrogen fusing into helium)'],
          'correct': 3,
        },
        {
          'question': 'Nuclear power plants generate electricity primarily using which nuclear process?',
          'options': ['Simple chemical reactions', 'Nuclear fission (typically of uranium or plutonium)', 'Radioactive decay only, with no chain reaction', 'Nuclear fusion'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a nuclear chain reaction, essential to nuclear fission power generation?',
          'options': ['A process unrelated to neutron release', 'A self-sustaining sequence of fission reactions, where neutrons released from one fission event trigger further fission events in nearby nuclei', 'A single fission event that produces no further reactions', 'A process that only occurs during nuclear fusion'],
          'correct': 1,
        },
        {
          'question': 'Which of these describes the function of control rods in a nuclear fission reactor?',
          'options': ['To increase the rate of fission uncontrollably', 'To absorb excess neutrons, controlling and regulating the rate of the fission chain reaction', 'To convert nuclear energy directly into light', 'To generate additional fuel for the reactor'],
          'correct': 1,
        },
        {
          'question': 'Which of these describes the function of a moderator (such as water or graphite) in many nuclear fission reactors?',
          'options': ['To absorb all neutrons and stop the reaction', 'To generate radioactive waste intentionally', 'To slow down (moderate) fast neutrons to increase the likelihood of causing further fission in materials like uranium-235', 'To increase neutron speed for more efficient fission'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why nuclear fusion, despite offering potentially cleaner and more abundant energy than fission, has not yet become a widely used commercial power source?',
          'options': ['Fusion is easier to achieve than fission at commercial scale', 'Achieving and sustaining the extremely high temperatures and pressures needed for controlled fusion reactions on Earth remains a significant engineering challenge', 'Fusion technology has already been fully commercialised worldwide', 'Fusion reactions release no usable energy'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes radioactive decay?',
          'options': ['A chemical reaction between different elements', 'The spontaneous transformation of an unstable atomic nucleus, releasing radiation and forming a different (often more stable) nucleus', 'A stable process with no change to the nucleus over time', 'A process that only occurs in fission reactors'],
          'correct': 1,
        },
        {
          'question': 'Which of these is NOT one of the three main types of radioactive decay?',
          'options': ['Alpha decay', 'Beta decay', 'Gamma decay', 'Photoelectric decay'],
          'correct': 3,
        },
        {
          'question': 'Alpha decay involves the emission of a particle consisting of?',
          'options': ['A single electron', 'Two protons and two neutrons (a helium nucleus)', 'A single photon only', 'A neutron alone'],
          'correct': 1,
        },
        {
          'question': 'Beta decay commonly involves the emission of a?',
          'options': ['High-energy electron (or positron) from the nucleus', 'Neutron only', 'Helium nucleus', 'Photon of visible light'],
          'correct': 0,
        },
        {
          'question': 'Gamma decay involves the emission of a?',
          'options': ['Neutron', 'High-energy photon (gamma ray) with no change in atomic or mass number', 'High-energy electron', 'Helium nucleus'],
          'correct': 1,
        },
        {
          'question': 'Which of these types of radioactive emission has the least penetrating power, typically stopped by paper or skin?',
          'options': ['Alpha particles', 'Beta particles', 'All have identical penetrating power', 'Gamma rays'],
          'correct': 0,
        },
        {
          'question': 'Which of these types of radioactive emission has the greatest penetrating power, requiring thick lead or concrete for effective shielding?',
          'options': ['Beta particles', 'Alpha particles', 'All have identical penetrating power', 'Gamma rays'],
          'correct': 3,
        },
        {
          'question': 'The half-life of a radioactive substance is defined as the time required for?',
          'options': ['All of the radioactive nuclei to decay', 'The substance to become completely stable and inert', 'Half of the radioactive nuclei in a sample to decay', 'The substance to double its mass'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why radioactive decay follows an exponential decay pattern over time, rather than a linear decrease?',
          'options': ['Decay occurs at a constant rate regardless of the amount of substance remaining', 'Radioactive decay does not follow any predictable mathematical pattern', 'The decay rate is proportional to the current number of undecayed nuclei present, resulting in a characteristic exponential decrease over time', 'All radioactive nuclei decay simultaneously at a fixed time'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes radiocarbon (carbon-14) dating, an application of radioactive decay in archaeology and geology?',
          'options': ['Measuring the remaining proportion of radioactive carbon-14 in organic material to estimate its age, based on carbon-14\'s known half-life', 'A technique that only works for inorganic materials like rocks', 'A technique unrelated to radioactive decay', 'Measuring the current temperature of an archaeological sample'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why radiocarbon dating is generally limited to dating organic materials up to roughly 50,000 years old?',
          'options': ['Carbon-14 dating can accurately date materials of any age', 'After a sufficient number of half-lives, the remaining amount of carbon-14 becomes too small to measure accurately, limiting the practical dating range', 'Organic materials cannot be dated using any radioactive method', 'Carbon-14 has an infinite half-life'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the medical application of radioactive tracers, used in diagnostic imaging such as PET scans?',
          'options': ['Radioactive tracers are used only to sterilise medical equipment', 'Radioactive tracers are used exclusively in nuclear power plants', 'A small amount of a radioactive substance is introduced into the body, and its emitted radiation is detected to image specific organs, tissues, or metabolic processes', 'Radioactive tracers have no medical application'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the use of radioactive isotopes in cancer radiotherapy?',
          'options': ['Radioactive sources have no role in cancer treatment', 'Radiotherapy relies solely on chemotherapy drugs, not radiation', 'Carefully controlled doses of radiation from radioactive sources or machines are used to target and destroy cancerous cells while attempting to minimise damage to healthy tissue', 'Radioactive isotopes are used only for diagnostic purposes, never treatment'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the use of radioactive tracers in industrial applications, such as detecting leaks in pipelines?',
          'options': ['A small amount of radioactive material added to a fluid can be tracked using radiation detectors to locate leaks, blockages, or flow patterns in pipelines', 'Industrial tracers are always non-radioactive dyes only', 'Radioactive tracers cannot be used for industrial purposes', 'Radioactive tracers have no industrial applications'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why smoke detectors sometimes contain a small amount of a radioactive isotope such as americium-241?',
          'options': ['The radioactive source has no functional role in smoke detection', 'The radioactive material is used only for decoration', 'The radioactive source ionises air within a chamber, creating a small detectable current; smoke particles disrupt this ionisation, triggering the alarm', 'Radioactive smoke detectors are illegal and never used'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes nuclear medicine\'s use of gamma cameras in conjunction with radioactive tracers?',
          'options': ['Gamma cameras can only be used outside medical contexts', 'Gamma cameras detect visible light emitted by tracers', 'Gamma cameras detect gamma radiation emitted by radioactive tracers within the body, creating images that show the distribution and function of organs or tissues', 'Gamma cameras are unrelated to nuclear medicine'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes food irradiation, a modern physics application used to extend shelf life and improve food safety?',
          'options': ['A process identical to microwave cooking', 'Exposing food to ionising radiation (often gamma rays) to kill bacteria, parasites, and pests without significantly heating the food', 'A process that always makes food radioactive and unsafe to eat', 'A process that has no effect on food safety'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why irradiated food does not become radioactive itself, addressing a common public concern?',
          'options': ['Food irradiation involves adding radioactive material directly to food', 'The radiation used (typically gamma rays or electron beams) passes through the food without leaving residual radioactivity, similar to how X-rays do not make a patient radioactive', 'Irradiation always makes food radioactive', 'Irradiated food remains radioactive indefinitely'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a Geiger-Muller counter, commonly used to detect and measure radioactivity?',
          'options': ['A device unrelated to radioactivity detection', 'A device that measures magnetic field strength', 'A device that measures temperature changes only', 'A device that detects ionising radiation by measuring the electrical pulses produced when radiation ionises gas within a tube'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the basic operating principle of a scintillation detector, used to detect radiation in various scientific and medical applications?',
          'options': ['Scintillation detectors work by measuring sound produced by radiation', 'Scintillation detectors cannot detect gamma radiation', 'Certain materials emit flashes of light (scintillate) when struck by ionising radiation, which can be detected and measured, often using a photomultiplier tube', 'These devices have no practical applications'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the working principle of a laser, a key application of modern physics (stimulated emission)?',
          'options': ['A laser produces a coherent, focused beam of light through the process of stimulated emission of photons within a gain medium', 'Lasers produce light through simple incandescent heating', 'Lasers rely on the photoelectric effect exclusively', 'Laser light is always incoherent and unfocused'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why laser light is coherent and monochromatic (single wavelength), unlike ordinary light sources?',
          'options': ['All light sources naturally produce coherent, monochromatic light', 'Coherence and monochromaticity are unrelated to the stimulated emission process', 'Stimulated emission within a laser produces photons that are in phase and of the same wavelength, unlike the random emission in ordinary light sources', 'Laser light has no special properties compared to ordinary light'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes a semiconductor, a material fundamental to modern electronic and photonic devices?',
          'options': ['A material that never conducts electricity under any conditions', 'A material with electrical conductivity between that of a conductor and an insulator, which can be precisely controlled through doping', 'A material identical in properties to a perfect insulator', 'A material that always conducts electricity as well as a metal'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes doping, a process used to modify the electrical properties of semiconductors?',
          'options': ['Removing all impurities from a semiconductor', 'A process that always makes a semiconductor a perfect insulator', 'A process unrelated to semiconductor technology', 'Intentionally adding specific impurity atoms to a semiconductor to increase the number of free charge carriers (electrons or holes), altering its conductivity'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes a p-n junction, the fundamental building block of diodes and transistors?',
          'options': ['A term unrelated to semiconductor devices', 'A junction with no practical electronic application', 'A junction formed between two identical semiconductor regions', 'A junction formed between a p-type (positive charge carrier dominant) and n-type (negative charge carrier dominant) semiconductor region, creating unique electrical properties'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes a light-emitting diode (LED), a common modern application of semiconductor physics?',
          'options': ['A device that absorbs light and converts it into electrical energy', 'A device that only works with alternating current', 'A device unrelated to semiconductor technology', 'A p-n junction diode that emits light when a current passes through it, due to electron-hole recombination releasing energy as photons'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why LEDs are widely considered more energy-efficient than traditional incandescent light bulbs?',
          'options': ['LEDs convert a smaller proportion of electrical energy into unwanted heat and a larger proportion into visible light, compared to the significant heat losses in incandescent bulbs', 'LED efficiency has no relation to electron-hole recombination', 'Incandescent bulbs are always more efficient than LEDs', 'LEDs and incandescent bulbs have identical energy efficiency'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the basic operating principle of a transistor, a fundamental component of modern electronics?',
          'options': ['A transistor is a simple resistor with fixed resistance', 'Transistors function identically to capacitors', 'A transistor can amplify or switch electronic signals, using a small input current/voltage to control a larger output current, based on semiconductor junction properties', 'Transistors have no role in modern electronic devices'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why the invention of the transistor revolutionised electronics compared to earlier vacuum tube technology?',
          'options': ['There is no significant difference between transistors and vacuum tubes', 'Transistors are larger, less efficient, and less reliable than vacuum tubes', 'Vacuum tubes are still universally preferred over transistors today', 'Transistors are much smaller, more energy-efficient, more reliable, and cheaper to mass-produce than vacuum tubes, enabling the miniaturisation of electronic devices'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an integrated circuit (microchip), building on transistor technology?',
          'options': ['A purely mechanical device with no electronic components', 'A single, large vacuum tube', 'A miniaturised electronic circuit containing many interconnected transistors and other components fabricated on a small semiconductor chip', 'A device unrelated to semiconductor technology'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes quantum tunnelling, a modern physics phenomenon with practical applications in devices like tunnel diodes and scanning tunnelling microscopes?',
          'options': ['Quantum tunnelling only applies to macroscopic objects', 'Tunnelling is a purely theoretical concept with no practical application', 'Particles can never cross energy barriers higher than their own energy', 'A quantum mechanical phenomenon where a particle has a probability of passing through an energy barrier that it classically should not be able to surmount'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the working principle of a scanning tunnelling microscope (STM), used to image surfaces at the atomic scale?',
          'options': ['Quantum tunnelling has no application in microscopy', 'The STM measures the quantum tunnelling current between a sharp conducting tip and a surface, which is extremely sensitive to the tip-surface distance, allowing atomic-scale imaging', 'The STM works by physically touching and dragging across the surface only', 'The STM uses visible light reflection to image surfaces'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the basic principle behind MRI (Magnetic Resonance Imaging), which relies on nuclear magnetic resonance, a modern/quantum physics phenomenon?',
          'options': ['MRI has no basis in quantum or nuclear physics', 'MRI relies solely on gamma radiation, similar to a PET scan', 'MRI uses strong magnetic fields and radio waves to align and then detect signals from hydrogen nuclei in the body, producing detailed images of soft tissue without ionising radiation', 'MRI uses X-rays to image the body'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of Einstein\'s theory of special relativity in modern GPS satellite technology?',
          'options': ['GPS satellites operate identically regardless of relativistic effects', 'GPS systems must account for both special and general relativistic time dilation effects between satellites and Earth\'s surface to maintain accurate positioning', 'GPS technology predates and is unrelated to relativity theory', 'Relativity has no relevance to GPS accuracy'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why GPS satellite clocks would drift out of sync with ground-based clocks if relativistic effects were not corrected for?',
          'options': ['Satellite and ground clocks always remain perfectly synchronised naturally', 'Due to their high speed (special relativity) and different gravitational potential (general relativity) compared to Earth\'s surface, satellite clocks experience a measurable time dilation that must be corrected to maintain GPS accuracy', 'Relativistic effects have no measurable impact on clock synchronisation', 'GPS satellites do not use precise timing at all'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the mass-energy equivalence relationship proposed by Einstein, expressed as E = ?',
          'options': ['E = mc', 'E = m + c', 'E = mc^2', 'E = m/c^2'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the significance of E = mc^2 in the context of nuclear fission and fusion energy release?',
          'options': ['Mass and energy are entirely unrelated quantities', 'A small amount of mass lost during nuclear fission or fusion reactions is converted into a very large amount of energy, according to the mass-energy equivalence principle', 'E = mc^2 applies only to chemical reactions, not nuclear reactions', 'Nuclear reactions never involve any change in mass'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a superconductor, a material exhibiting a key modern physics phenomenon?',
          'options': ['A material with unusually high electrical resistance at all temperatures', 'A material that exhibits zero electrical resistance and expels magnetic fields when cooled below a critical temperature', 'A material that only conducts electricity at room temperature', 'A material identical in properties to a standard conductor'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a practical application of superconductors in medical imaging technology?',
          'options': ['Superconducting materials are used only for their optical properties', 'Superconducting magnets are used in MRI machines to generate the very strong, stable magnetic fields required for high-quality imaging', 'MRI machines cannot use superconducting components', 'Superconductors have no application in medical technology'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of superconductors in maglev (magnetic levitation) train technology?',
          'options': ['Superconducting magnets can generate powerful magnetic fields with minimal energy loss, enabling efficient levitation and propulsion of the train', 'Superconductors increase resistance, making levitation less efficient', 'Maglev trains do not use any magnetic technology', 'Superconductors cannot generate magnetic fields'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the application of quantum physics principles in the development of quantum computing?',
          'options': ['Quantum computers operate identically to classical computers with no fundamental difference', 'Qubits behave identically to classical bits at all times', 'Quantum computing has no theoretical basis in physics', 'Quantum computers use quantum bits (qubits), which can exist in superpositions of states, potentially enabling certain calculations to be performed much faster than classical computers for specific problems'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why solar cells (photovoltaic cells) are considered a direct application of quantum/modern physics principles, specifically the photoelectric effect?',
          'options': ['Solar cells cannot generate any usable electrical current', 'Solar cells rely entirely on classical wave theory with no quantum basis', 'Solar cells generate electricity through purely mechanical means', 'Photons from sunlight strike the semiconductor material, exciting electrons across the band gap and generating a flow of current, directly applying quantised photon-electron interactions'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the basic principle of a nuclear reactor\'s use for power generation, in terms of converting nuclear energy into usable electricity?',
          'options': ['Nuclear energy is converted directly into electrical energy with no intermediate steps', 'Heat generated by controlled nuclear fission is used to produce steam, which drives a turbine connected to a generator, converting thermal energy into mechanical and then electrical energy', 'Nuclear reactors generate electricity through direct chemical reactions', 'Nuclear reactors have no connection to turbines or generators'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the ongoing research interest in nuclear fusion reactors (such as tokamak designs) as a potential future energy source?',
          'options': ['There is no potential advantage of fusion over fission for future energy needs', 'Fusion offers the potential for abundant fuel, minimal long-lived radioactive waste, and no risk of runaway chain reactions, compared to fission', 'Fusion produces significantly more long-lived radioactive waste than fission', 'Fusion reactors are already widely used for commercial power generation today'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of particle accelerators, a key tool in modern experimental physics, beyond fundamental research?',
          'options': ['Particle accelerators are used exclusively for weapons development', 'Accelerators cannot be used for any medical purposes', 'In addition to fundamental physics research, particle accelerators are used in medical treatments (like proton therapy for cancer) and in producing medical isotopes', 'Particle accelerators have no practical applications outside pure research'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes proton therapy, a cancer treatment application relying on particle accelerator technology?',
          'options': ['Protons are accelerated and directed at tumours, delivering precise doses of radiation with less damage to surrounding healthy tissue compared to some conventional radiation methods', 'Proton therapy uses no particle acceleration technology', 'Protons cannot be used for medical treatment purposes', 'Proton therapy is identical to standard X-ray radiotherapy with no distinct advantages'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why nuclear waste from fission reactors requires long-term careful storage and management?',
          'options': ['Nuclear waste becomes completely safe within a few hours', 'Nuclear waste has no radioactive properties requiring special handling', 'Some radioactive byproducts of nuclear fission have long half-lives, remaining hazardously radioactive for very long periods, requiring secure long-term storage solutions', 'All nuclear waste can be safely released into the environment immediately'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes the application of quantum physics in the operation of quantum cryptography for secure communication?',
          'options': ['Quantum cryptography can use quantum properties (such as the behaviour of entangled particles or the disturbance caused by measurement) to detect eavesdropping and enable theoretically highly secure communication', 'Quantum cryptography relies on classical encryption methods only', 'Quantum physics has no application in secure communication', 'Quantum cryptography is identical to traditional password-based security'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the photoelectric effect, a key phenomenon that led to the development of quantum theory?',
          'options': ['The emission of electrons from a metal surface when light of sufficient frequency (above a threshold) strikes it', 'Electrons are emitted from a metal regardless of light exposure', 'The photoelectric effect only involves heat, not light', 'Light of any frequency can eject electrons from a metal surface given enough time'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why the photoelectric effect could not be explained by classical wave theory of light, requiring Einstein\'s quantum explanation?',
          'options': ['Classical theory had no predictions about light and metals', 'Classical theory predicted electron emission should depend on light intensity rather than frequency, but experiments showed a frequency threshold, requiring the concept of quantised photons', 'The photoelectric effect has no connection to quantum theory', 'Classical theory correctly predicted all observed features of the effect'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes a photon, the quantum of electromagnetic radiation central to modern physics?',
          'options': ['A discrete packet (quantum) of electromagnetic energy, with energy proportional to frequency (E = hf)', 'A particle of definite mass at rest, unlike light', 'A unit of electric charge', 'A purely classical wave with no particle-like properties'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes Planck\'s constant (h), fundamental to quantum theory?',
          'options': ['A unit of electric charge', 'A constant relating the energy of a photon to its frequency', 'A constant used only in classical mechanics', 'A constant with no physical significance'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the working principle of a laser, an important modern physics application relying on stimulated emission?',
          'options': ['Lasers rely on nuclear fission to produce light', 'Lasers produce random, incoherent light similar to an incandescent bulb', 'Lasers produce coherent, monochromatic light through the process of stimulated emission of radiation from excited atoms', 'Stimulated emission has no role in laser operation'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of lasers in medicine, such as LASIK eye surgery?',
          'options': ['Lasers are used only for cutting metal, not biological tissue', 'LASIK relies on X-rays rather than lasers', 'Lasers cannot be used for any medical procedures', 'Precise, focused laser light is used to reshape corneal tissue with minimal damage to surrounding areas'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of lasers in telecommunications, particularly fibre optic communication?',
          'options': ['Laser communication is slower and less reliable than traditional copper wire', 'Lasers have no application in telecommunications', 'Laser light is used to transmit digital information as pulses through optical fibres over long distances with low signal loss', 'Fibre optic cables rely on radio waves rather than light'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes radioactive dating (e.g., carbon-14 dating), an application of nuclear physics?',
          'options': ['A method that provides no useful information about age', 'A method with no basis in nuclear physics', 'Estimating the age of an object based on the known decay rate (half-life) of a radioactive isotope it contains', 'A method that only works on living organisms, not artifacts'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes half-life, a key concept in radioactive decay applications?',
          'options': ['The total time for a radioactive sample to completely decay', 'A term unrelated to radioactivity', 'The time for a radioactive sample to double in mass', 'The time required for half of a radioactive sample to decay'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of radioactive isotopes in medicine, such as in PET (positron emission tomography) scans?',
          'options': ['PET scans use only visible light, not radioactivity', 'Radioactive tracers are introduced into the body and their emissions detected to produce images revealing metabolic activity, useful in diagnosing conditions like cancer', 'Radioactive tracers are harmful with no diagnostic benefit', 'Radioactive isotopes have no medical application'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the application of nuclear fission in current commercial nuclear power plants?',
          'options': ['Nuclear power plants use fission only for research, not electricity generation', 'Nuclear power plants rely on fusion, not fission', 'Fission reactions release no usable energy', 'Controlled splitting of heavy atomic nuclei (like uranium-235) releases energy used to generate electricity'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of X-rays, a form of high-energy electromagnetic radiation, in medical diagnostics?',
          'options': ['X-rays are used only for treating infections', 'X-rays are absorbed differently by different tissues (e.g., bone vs soft tissue), allowing internal imaging for diagnosis of fractures and other conditions', 'X-rays have no medical application', 'X-rays cannot penetrate any body tissue'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of positron-electron annihilation, relevant to PET imaging technology?',
          'options': ['Annihilation events produce no detectable radiation', 'When a positron meets an electron, they annihilate and produce gamma-ray photons that can be detected to construct an image', 'PET scans do not rely on any particle interactions', 'Positron-electron interactions have no role in imaging'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes semiconductor doping, essential to modern electronic device applications like transistors and diodes?',
          'options': ['A process unrelated to semiconductor electronics', 'Adding controlled impurities to a semiconductor to modify its electrical conductivity properties', 'Doping removes all free charge carriers from a semiconductor', 'Doping always makes a material a perfect insulator'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a p-n junction, the basic building block of diodes and transistors?',
          'options': ['A junction formed between p-type and n-type semiconductor materials, allowing current to flow predominantly in one direction', 'A junction found only in insulators', 'A junction that blocks current flow in both directions equally', 'A junction with no practical application in electronics'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes a light-emitting diode (LED), a modern application of semiconductor physics?',
          'options': ['LEDs rely on nuclear reactions to produce light', 'A diode that emits light when current flows through it in the forward direction, due to electron-hole recombination releasing energy as photons', 'A device that absorbs light rather than emitting it', 'A device unrelated to semiconductor physics'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of nanotechnology, an area often connected to modern/quantum physics principles at small scales?',
          'options': ['Nanotechnology only applies to large-scale structures', 'Nanoscale materials always behave identically to their bulk counterparts', 'Nanotechnology has no connection to physics principles', 'Manipulating matter at the atomic/molecular scale to create materials and devices with novel properties, used in areas like medicine, electronics, and materials science'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the application of Heisenberg\'s uncertainty principle in understanding the limits of measurement in modern physics?',
          'options': ['It states that certain pairs of physical properties (like position and momentum) cannot both be measured with arbitrary precision simultaneously', 'It states that all physical quantities can be measured with perfect precision simultaneously', 'It has no practical implications in modern technology', 'It applies only to macroscopic objects, not particles'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes an application of the Global Positioning System (GPS) that directly depends on precise atomic clock technology, a modern physics application?',
          'options': ['GPS relies on mechanical clocks with no connection to atomic physics', 'Atomic clocks have no role in GPS technology', 'GPS accuracy is unaffected by clock precision', 'GPS satellites use highly accurate atomic clocks, based on stable atomic transition frequencies, to enable precise timing and positioning calculations'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of quantum entanglement, a phenomenon central to developing quantum technologies?',
          'options': ['Entangled particles behave completely independently of one another', 'Entanglement is a purely classical phenomenon', 'Entanglement has no potential technological application', 'Entangled particles show correlated properties regardless of distance, a phenomenon being explored for applications in quantum computing and secure quantum communication'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the application of nuclear magnetic resonance (NMR) spectroscopy in chemistry and medicine, related to the same principle behind MRI?',
          'options': ['NMR relies solely on visible light absorption', 'NMR spectroscopy has no practical scientific application', 'NMR cannot be used to study molecular structure', 'NMR uses magnetic fields and radiofrequency pulses to study the structure of molecules or, in MRI, to produce images of the body'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of the photovoltaic effect beyond solar panels, such as in light sensors and photodiodes?',
          'options': ['The photovoltaic effect only applies to large-scale solar panels', 'Photodiodes cannot detect light', 'The photovoltaic effect enables devices to generate a small electric signal in response to light, useful in sensors and light-detecting applications', 'The photovoltaic effect has no sensor-related applications'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why understanding nuclear binding energy is important for both nuclear power applications and nuclear weapons?',
          'options': ['Nuclear binding energy only applies to chemical reactions', 'Binding energy differences between reactant and product nuclei determine the amount of energy released in fission or fusion reactions', 'Binding energy has no relevance to energy release in nuclear reactions', 'Binding energy determines only the mass of a nucleus, not energy release'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of Compton scattering, a phenomenon supporting the particle nature of light, relevant to certain imaging and detection technologies?',
          'options': ['The scattering of X-ray or gamma-ray photons by electrons, with an associated change in photon wavelength, used in some detection and imaging techniques', 'Compton scattering only applies to visible light', 'Compton scattering has no practical application', 'Photon wavelength never changes during scattering'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes an application of Cherenkov radiation, produced when a charged particle travels faster than light does in a given medium, used in some particle detectors?',
          'options': ['Particles can never travel faster than light in any medium', 'Cherenkov radiation has no use in particle detection', 'Cherenkov radiation is identical to ordinary photon emission from atoms', 'Detecting the characteristic blue glow produced can help identify and study high-energy charged particles in mediums like water-based detectors'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes wave-particle duality, a foundational concept of modern physics with practical implications for technologies like electron microscopes?',
          'options': ['Electron microscopes rely only on classical particle behaviour', 'Light and matter only ever behave as particles', 'Light and matter exhibit both wave-like and particle-like properties depending on the experiment, a principle exploited in electron microscopy using electron wave properties for high-resolution imaging', 'Wave-particle duality has no practical application'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the application of Bose-Einstein condensates, an exotic state of matter studied in modern physics with potential technological uses?',
          'options': ['Bose-Einstein condensates have no relevance to modern physics research', 'A state of matter formed at extremely low temperatures where a large fraction of particles occupy the same quantum state, studied for potential uses in precision measurement and quantum technology', 'This state of matter behaves identically to a normal gas', 'A common state of matter found at room temperature'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of muon detection in modern physics, such as muon tomography used to image large, dense structures like pyramids or volcanoes?',
          'options': ['Muons behave identically to photons in all situations', 'Muon detection has no practical imaging applications', 'Naturally occurring cosmic-ray muons can penetrate large structures, and their absorption patterns can be used to image internal density variations', 'Muons cannot penetrate any solid material'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of quantum dots, nanoscale semiconductor particles with quantised energy levels, in modern display technology?',
          'options': ['Quantum dots have no application in display technology', 'Quantum dots cannot interact with light at all', 'Quantum dots behave identically to bulk semiconductor materials', 'Quantum dots can emit precise colours of light when excited, used to improve colour accuracy and efficiency in some display screens'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the general importance of studying modern physics phenomena (quantum mechanics, relativity, nuclear physics) for technological innovation?',
          'options': ['Modern physics concepts remain purely theoretical with no applications', 'These fields have led to numerous transformative technologies, including electronics, medical imaging, energy generation, and communication systems', 'Modern physics has had no impact on real-world technology', 'Only classical physics has led to practical technological applications'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes an application of positron emission in modern industrial and scientific research, beyond medical PET imaging?',
          'options': ['Positron-based techniques are identical to standard optical microscopy', 'Positrons have no research applications outside medicine', 'Positron annihilation spectroscopy can be used to study material defects at the atomic scale, such as in metals and semiconductors', 'Positrons cannot be detected or studied experimentally'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of the Zeeman effect, the splitting of spectral lines in a magnetic field, in modern astrophysics?',
          'options': ['The Zeeman effect has no astronomical application', 'Spectral lines never split in the presence of a magnetic field', 'The Zeeman effect only applies to radio waves', 'Measuring the splitting of spectral lines allows astronomers to determine the strength of magnetic fields in stars and other astronomical objects'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an application of quantum key distribution (QKD) in modern secure communication systems, based on principles of quantum mechanics?',
          'options': ['QKD cannot detect any interception attempts', 'QKD relies entirely on classical encryption with no quantum basis', 'QKD uses quantum properties of photons to establish encryption keys in a way that reveals any eavesdropping attempt, enhancing communication security', 'Quantum mechanics has no application to communication security'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes an application of radioisotope thermoelectric generators (RTGs), used to power some deep-space spacecraft?',
          'options': ['RTGs convert heat released by the natural radioactive decay of isotopes into electricity, providing long-lasting power in environments where solar power is impractical', 'RTGs generate power through chemical combustion only', 'RTGs have no practical application in space exploration', 'RTGs rely on nuclear fission chain reactions'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes an application of the photoelectric effect in modern digital cameras and image sensors?',
          'options': ['The photoelectric effect has no role in modern imaging technology', 'Incoming photons striking a sensor\'s photosensitive material release electrons, generating an electrical signal that is processed into a digital image', 'Digital cameras rely entirely on chemical film processes with no photoelectric basis', 'Image sensors detect sound waves rather than light'],
          'correct': 1,
        },
      ];
    default:
      return [];
  }
}