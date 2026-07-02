// lib/features/quiz/data/question_banks/phy102_question_bank.dart
//
// Additional PHY102 (Physics II) quiz questions for the Electricity
// units, sourced from two PDFs:
//   - A 175-question Current Electricity bank (35 Q x 5 subtopics)
//   - A 100-question compendium covering Electrostatics + Current
//     Electricity, classified and split by topic below.
//
// These are ADDED ON TOP OF the existing questions in
// phy102_lessons.dart (append, not replace) -- see
// topic_question_source.dart for how the two sources are merged.
//
// phy102_u1_1 and phy102_u1_2 add to the existing Electrostatics
// lessons. phy102_u5_1 through phy102_u5_5 are BRAND NEW lessons
// (Current Electricity subtopics) -- see subjects_data.dart for
// their unit placement.

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

    default:
      return [];
  }
}