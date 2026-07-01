// lib/features/learning/data/lessons/bio102_lessons.dart

Map<String, dynamic> getBIO102LessonData(String lessonId) {
  switch (lessonId) {
    case 'bio102_u1_1':
      return {
        'content': '''# General Survey of the Animal Kingdom

## Defining Animals

Animals are:
✓ Eukaryotic organisms
✓ Multicellular (multiple cells)
✓ Heterotrophic (consume organic matter)
✓ Possess specialized tissues and organs
✓ Most are motile (move) at some life stage
✓ Reproduce sexually (mostly)
✓ No cell walls (unlike plants)

## Key Difference from Other Kingdoms
- **Plants**: Autotrophic, have cell walls, mostly sessile
- **Fungi**: Absorb nutrients, have cell walls
- **Animals**: Ingest food, no cell walls, consume organic matter

## Classification Characteristics

**Body Symmetry**
• Radial: Parts arranged around center (starfish, jellyfish)
• Bilateral: Two mirror-image sides (most animals)
• Asymmetrical: No symmetry pattern (sponges)

**Body Cavity (Coelom)**
• Acoelomate: No body cavity (flatworms)
• Pseudocoelomate: False cavity (roundworms)
• Coelomate: True coelom with lining (most advanced)

**Germ Layers**
• Diploblastic: 2 layers (ectoderm, endoderm) - cnidarians
• Triploblastic: 3 layers (ectoderm, mesoderm, endoderm) - most animals

## Major Animal Phyla Overview

1. **Porifera** - Sponges
2. **Cnidaria** - Jellyfish, Corals, Anemones
3. **Platyhelminthes** - Flatworms
4. **Nematoda** - Roundworms
5. **Annelida** - Segmented Worms
6. **Arthropoda** - Insects, Spiders, Crustaceans
7. **Mollusca** - Snails, Clams, Octopuses
8. **Echinodermata** - Starfish, Sea Urchins
9. **Chordata** - Vertebrates (Fish, Amphibians, Reptiles, Birds, Mammals)''',
        'questions': [
          {
            'question': 'Which characteristic defines all animals?',
            'options': ['Autotrophic', 'Have cell walls', 'Eukaryotic and heterotrophic', 'Sessile (non-motile)'],
            'correct': 2,
          },
          {
            'question': 'Body symmetry types include:',
            'options': ['Only radial and bilateral', 'Radial, bilateral, and asymmetrical', 'Only bilateral', 'Asymmetrical only'],
            'correct': 1,
          },
          {
            'question': 'Animals with true body cavity (coelom) are:',
            'options': ['Acoelomate', 'Pseudocoelomate', 'Coelomate', 'All types equally advanced'],
            'correct': 2,
          },
          {
            'question': 'Most advanced animals are:',
            'options': ['Diploblastic', 'Triploblastic', 'Acoelomate', 'Radially symmetric'],
            'correct': 1,
          },
          {
            'question': 'The most diverse phylum is:',
            'options': ['Mollusca', 'Arthropoda', 'Chordata', 'Annelida'],
            'correct': 1,
          },
        ]
      };

    case 'bio102_u1_2':
      return {
        'content': '''# External Features & Adaptations

## Skeletal Systems

**Exoskeleton** (Outside skeleton)
- Found in: Insects, Crustaceans, Arachnids
- Made of: Chitin (protein-polysaccharide)
- Advantages:
  ✓ Protects internal organs
  ✓ Prevents water loss
  ✓ Attachment for muscles
- Disadvantage: Must molt to grow

**Endoskeleton** (Inside skeleton)
- Found in: Vertebrates, Echinoderms
- Made of: Bone or cartilage
- Advantages:
  ✓ Grows with animal
  ✓ Internal protection
  ✓ Limb flexibility
- Disadvantage: Requires strength to support

## Locomotion Adaptations

• **Cilia**: Hair-like structures (protozoans, some larvae)
• **Flagella**: Whip-like tails (sperm, some protozoans)
• **Muscles**: Work with skeleton for movement
• **Appendages**: Legs, fins, wings adapted to environment

## Feeding Structures

Animals adapted to diet:
- **Herbivores**: Grinding teeth, long digestive tract
- **Carnivores**: Sharp teeth, claws, speed
- **Filter Feeders**: Specialized gills or baleen
- **Parasites**: Hooks, suckers for attachment

## Sensory Organs

• **Eyes**: Simple (light/dark) or complex (detailed vision)
• **Antennae**: Smell, taste, touch
• **Lateral Line**: Water pressure detection (fish)
• **Ears**: Sound detection (vertebrates)

## Protective Features

- Shells: Hard protection (molluscs, crustaceans)
- Spines: Defensive projections (sea urchins)
- Camouflage: Blending with environment
- Warning Coloration: Bright colors signal toxicity
- Armor: Thick skin or scales''',
        'questions': [
          {
            'question': 'Exoskeleton is made of:',
            'options': ['Bone', 'Chitin', 'Cartilage', 'Calcium'],
            'correct': 1,
          },
          {
            'question': 'Endoskeleton advantage is:',
            'options': ['Grows with animal', 'Prevents water loss', 'Lighter than exoskeleton', 'Easier to shed'],
            'correct': 0,
          },
          {
            'question': 'Herbivore teeth are specialized for:',
            'options': ['Tearing', 'Grinding', 'Piercing', 'Sucking'],
            'correct': 1,
          },
          {
            'question': 'Camouflage provides:',
            'options': ['Speed advantage', 'Predator avoidance', 'Hunting concealment', 'Both B and C'],
            'correct': 3,
          },
          {
            'question': 'Warning coloration signals:',
            'options': ['Edibility', 'Toxicity', 'Sexual readiness', 'Age'],
            'correct': 1,
          },
        ]
      };

    case 'bio102_u1_3':
      return {
        'content': '''# Ecological Adaptation & Niche

## Habitat Preferences

**Terrestrial** (Land)
- Challenges: Water loss, gravity, temperature extremes
- Adaptations: Waterproof skin, lungs, strong skeleton

**Aquatic** (Water)
- Freshwater: Low salt concentration
- Marine: High salt (osmoregulation needed)
- Parasitic: Live inside or on hosts

## Feeding Strategies

• **Filter Feeders**: Sponges, bivalves (strain particles)
• **Herbivores**: Eat plants (cows, insects)
• **Carnivores**: Hunt prey (lions, snakes)
• **Omnivores**: Eat plants and animals (bears, humans)
• **Detritivores**: Eat dead matter (earthworms, vultures)

## Reproduction Modes

- **Sexual**: Two parents, genetic variation
- **Asexual**: One parent, identical offspring
- **Parthenogenesis**: Unfertilized eggs produce offspring (some insects)

## Life Cycles

**Simple Metamorphosis**
- No larval stage
- Gradual growth to adult form

**Complex Metamorphosis**
- Complete: Egg → Larva → Pupa → Adult
- Incomplete: Egg → Nymph → Adult (no pupal stage)

Benefits: Larvae and adults occupy different niches, reducing competition

## Camouflage & Defense

**Mimicry**: Resembling toxic/dangerous species
**Armor**: Shells, scales, thick skin
**Toxins**: Chemical defense (poison frogs, snakes)
**Autotomy**: Dropping body parts to escape (lizard tail)

## Niche Specialization

**Niche** = Ecological role + How organism uses environment

Examples:
- Woodpecker: Lives in trees, eats insects in bark
- Sloth: Lives in canopy, eats leaves slowly
- Angler Fish: Lives in deep ocean, uses light to attract prey

No two species occupy exact same niche (Competitive Exclusion Principle)''',
        'questions': [
          {
            'question': 'Terrestrial animals need adaptations for:',
            'options': ['Water conservation', 'Oxygen breathing', 'Temperature regulation', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Complete metamorphosis includes stage:',
            'options': ['Egg, Larva, Adult', 'Egg, Larva, Pupa, Adult', 'Only Egg, Nymph, Adult', 'No distinct stages'],
            'correct': 1,
          },
          {
            'question': 'Mimicry provides advantage by:',
            'options': ['Resembling edible species', 'Resembling toxic species', 'Changing color daily', 'Growing larger'],
            'correct': 1,
          },
          {
            'question': 'Niche refers to:',
            'options': ['Geographic location only', 'Ecological role in environment', 'Mating partner', 'Food type'],
            'correct': 1,
          },
          {
            'question': 'Parthenogenesis produces:',
            'options': ['Genetically different offspring', 'Identical clones', 'Four offspring', 'Spores'],
            'correct': 1,
          },
        ]
      };

    case 'bio102_u2_1':
      return {
        'content': '''# Protozoans & Coelentrates

## Protozoans (Kingdom Protista)

Unicellular eukaryotic organisms with specialized structures:

**Classes:**

**Sarcodina** (Amoeboids)
- Move with pseudopodia ("false feet")
- Feed by engulfing particles
- Example: Amoeba

**Flagellata** (Flagellates)
- Move with flagella (whip-like tails)
- Example: Euglena (can photosynthesize!)

**Ciliata** (Ciliates)
- Move and feed with cilia (hair-like structures)
- Example: Paramecium
- Most complex protozoans

**Sporozoa** (Parasitic)
- No locomotor structures
- Parasitic lifestyle
- Example: Plasmodium (causes malaria)

## Protozoan Structures

- **Cell membrane**: Controls what enters/exits
- **Contractile vacuole**: Removes excess water (osmoregulation)
- **Food vacuole**: Stores ingested food for digestion
- **Nucleus**: Controls cell functions

## Protozoan Reproduction

**Asexual (Cloning)**
- Binary fission: One cell splits into two identical cells
- Fast reproduction
- No genetic variation

**Sexual (Genetic Exchange)**
- Conjugation: Paramecium exchange genetic material
- Increases variation
- Less common than asexual

## Coelentrates (Phylum Cnidaria)

Simple animals with:
- Radial symmetry (circular arrangement)
- Diploblastic (2 germ layers only)
- Tentacles with nematocysts (stinging cells)

**Classes:**

**Hydrozoa** - Hydra
- Small freshwater animals
- Simple, solitary or colonial

**Scyphozoa** - Jellyfish
- Medusa form (umbrella-shaped) dominant
- Planktonic (drift in ocean)

**Anthozoa** - Corals & Sea Anemones
- Polyp form (tube-shaped) dominant
- Sessile (don't move)
- Build coral reefs

## Cnidarian Life Cycle

Alternation between two forms:
- **Polyp**: Tube-shaped, attaches to surface
- **Medusa**: Umbrella-shaped, free-floating

Different classes emphasize different forms

## Cnidarian Nutrition

- Carnivorous (eat animals)
- Use tentacles to capture prey
- Nematocysts paralyze prey
- Gastrovascular cavity for digestion''',
        'questions': [
          {
            'question': 'Protozoans are:',
            'options': ['Multicellular', 'Unicellular eukaryotes', 'Prokaryotic', 'All parasitic'],
            'correct': 1,
          },
          {
            'question': 'Paramecium moves with:',
            'options': ['Pseudopodia', 'Flagella', 'Cilia', 'Muscles'],
            'correct': 2,
          },
          {
            'question': 'Contractile vacuole in protozoans:',
            'options': ['Stores food', 'Removes excess water', 'Aids reproduction', 'Captures prey'],
            'correct': 1,
          },
          {
            'question': 'Cnidarians possess:',
            'options': ['Bilateral symmetry', 'Radial symmetry', 'Asymmetry', 'Three germ layers'],
            'correct': 1,
          },
          {
            'question': 'Nematocysts in cnidarians function to:',
            'options': ['Reproduce', 'Sting and stun prey', 'Produce shell', 'Attach to substrate'],
            'correct': 1,
          },
        ]
      };

    case 'bio102_u2_2':
      return {
        'content': '''# Early Invertebrates & Worm Phyla

## Porifera (Sponges)

Simplest animals:
- Asymmetrical or radial symmetry
- Mostly sessile (non-motile)
- Filter feeders with pores (ostia) and opening (osculum)
- Lack true tissues and organs
- Intracellular digestion (inside cells)

**Reproduction:**
- Asexual: Budding (fragments grow into new sponges)
- Sexual: Sperm and eggs

**Ecological Role:**
- Filter excess food from water
- Food source for other animals
- Can contain symbiotic bacteria

## Platyhelminthes (Flatworms)

Characteristics:
- Bilateral symmetry
- Triploblastic (3 germ layers)
- Acoelomate (no body cavity)
- Flat, leaf or ribbon-shaped

**Classes:**

**Turbellaria** - Free-living Planarians
- Predatory in freshwater
- Can regenerate lost body parts
- Simple brain (ganglia)

**Trematoda** - Parasitic Flukes
- Inhabit vertebrate tissues
- Complex life cycles (require multiple hosts)
- Suckers for attachment

**Cestoda** - Tapeworms
- Parasitic in vertebrate intestines
- Segmented body (proglottids)
- No mouth or digestive system
- Absorb nutrients directly

## Nematoda (Roundworms)

Characteristics:
- Bilateral symmetry
- Triploblastic with pseudocoelom
- Elongated, cylindrical, unsegmented body
- Complete digestive system (mouth → anus)
- Hydrostatic skeleton (body cavity provides pressure/support)

**Free-living:** Soil and water species
**Parasitic Examples:**
- Hookworms: Bloodsuckers, cause anemia
- Pinworms: Infect children
- Filariae: Cause lymphatic filariasis

## Annelida (Segmented Worms)

Characteristics:
- Bilateral symmetry
- Triploblastic with true coelom
- **Segmented body** (key feature!)
- Closed circulatory system (blood in vessels)

**Classes:**

**Polychaeta** - Marine Worms
- Many bristles (chaetae)
- Free-living and motile

**Oligochaeta** - Earthworms
- Few bristles
- Terrestrial and freshwater
- Soil aeration, nutrient cycling

**Hirudinea** - Leeches
- Parasitic or predatory
- Anticoagulant (hirudin) in saliva
- Medical uses (surgical restoration)

## Evolutionary Significance

Annelids are first animals with:
✓ True segmentation
✓ Advanced nervous system (brain + nerve cord)
✓ Closed circulatory system
✓ True coelom (body cavity)''',
        'questions': [
          {
            'question': 'Sponges are characterized by:',
            'options': ['True tissues', 'Filter feeding', 'Motile adults', 'Bilateral symmetry'],
            'correct': 1,
          },
          {
            'question': 'Flatworms lack:',
            'options': ['Symmetry', 'True body cavity', 'Mouth', 'Brain'],
            'correct': 1,
          },
          {
            'question': 'Tapeworms possess:',
            'options': ['Mouth and digestive system', 'Segmented body (proglottids)', 'Free-living lifestyle', 'Simple branched intestine'],
            'correct': 1,
          },
          {
            'question': 'Roundworms have:',
            'options': ['No digestive system', 'Complete digestive tract', 'Pseudocoelom', 'Both B and C'],
            'correct': 3,
          },
          {
            'question': 'Earthworms are important because:',
            'options': ['Aerate soil', 'Decompose organic matter', 'Increase water infiltration', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'bio102_u2_3':
      return {
        'content': '''# Arthropods & Echinoderms Basics

## Arthropoda (The Most Successful Phylum!)

Why are arthropods so successful?

✓ Exoskeleton: Protection + muscle attachment
✓ Segmentation: Specialized segments
✓ Jointed appendages: Diverse uses
✓ Adapt to ANY environment

**Body Structure:**
- Bilateral symmetry
- Triploblastic with coelom
- Exoskeleton of chitin (shed during molt/ecdysis)
- Segmented body with jointed legs

**Major Classes:**

**Arachnida** (8 legs)
- Spiders, Scorpions, Ticks
- No antennae
- Book lungs for breathing
- Venom for prey subdual

**Insecta** (6 legs)
- Most diverse animals on Earth
- Wings (most adults)
- Compound eyes
- Metamorphosis

**Crustacea** (10+ legs)
- Crabs, Lobsters, Shrimp
- Antennae for sensing
- Mostly aquatic
- Hard exoskeleton

**Myriapoda** (Many legs)
- Centipedes: 1 pair per segment
- Millipedes: 2 pairs per segment

## Insect Metamorphosis

**Complete Metamorphosis:**
Egg → Larva (caterpillar) → Pupa (chrysalis) → Adult (butterfly)

Benefits:
- Larvae and adults eat different foods
- Reduces competition
- Larvae focus on growth, adults on reproduction

**Incomplete Metamorphosis:**
Egg → Nymph (looks like tiny adult) → Adult

No distinct pupal stage

## Echinodermata (Sea Stars, Urchins, etc.)

Characteristics:
- Radial symmetry (adults; larvae bilateral!)
- Triploblastic with coelom
- **Water vascular system** (unique!)
- Tube feet for movement and feeding
- Endoskeleton of calcium carbonate plates

**Classes:**

**Asteroidea** - Sea Stars
- 5 arms (usually)
- Predatory on molluscs
- Can regenerate lost arms

**Echinoidea** - Sea Urchins/Sand Dollars
- Globe-shaped
- Spines for protection
- Tube feet for movement

**Holothuroidea** - Sea Cucumbers
- Elongated body
- Detritivorous (eat mud/debris)
- Can eject organs as defense

**Ophiuroidea** - Brittle Stars
- Thin, flexible arms
- Rapid movement
- Autotomy (drop arms to escape)

## Water Vascular System

Unique hydraulic system:
- Tube feet extend/retract with water pressure
- Used for movement, feeding, respiration
- Ampullae (bulbs) control water flow

## Regeneration

Echinoderms can regrow:
- Lost arms
- Damaged organs
- Some can regenerate entire body from arm fragment!''',
        'questions': [
          {
            'question': 'Arthropods are successful because:',
            'options': ['Large size', 'Exoskeleton and adaptability', 'Long lifespan', 'Sexual reproduction'],
            'correct': 1,
          },
          {
            'question': 'Insects possess:',
            'options': ['Eight legs', 'Six legs', 'Ten legs', 'No legs'],
            'correct': 1,
          },
          {
            'question': 'Complete metamorphosis includes:',
            'options': ['Egg, Larva, Pupa, Adult', 'Egg, Nymph, Adult', 'Only egg and adult', 'No distinct stages'],
            'correct': 0,
          },
          {
            'question': 'Water vascular system in echinoderms is used for:',
            'options': ['Excretion', 'Movement and feeding', 'Reproduction', 'Digestion'],
            'correct': 1,
          },
          {
            'question': 'Sea star regeneration ability shows:',
            'options': ['Weakness', 'Evolutionary advantage', 'Loss of body parts', 'Asexual reproduction'],
            'correct': 1,
          },
        ]
      };

    case 'bio102_u3_1':
      return {
        'content': '''# Molluscs & Protochordates

## Mollusca (Soft-Bodied with Shells)

General characteristics:
- Bilateral symmetry
- Triploblastic with coelom
- Soft body (no rigid skeleton)
- Most secrete calcium carbonate shell

**Body Organization:**
- Head: Contains mouth and sensory organs
- Muscular Foot: For movement
- Mantle: Tissue that secretes shell
- Visceral Mass: Contains organs

**Major Classes:**

**Gastropoda** - Snails and Slugs
- Muscular foot for movement
- Radula: Scraping structure for feeding (algae, plants)
- Shell (or lost in slugs)
- Eye stalks on head

**Bivalvia** - Clams, Mussels, Oysters
- Two shells (valves) held together
- Adductor muscles close shells
- Filter feeders (siphons draw water)
- Gills trap plankton

**Cephalopoda** - Octopuses, Squid, Cuttlefish
- Highly developed brain (smartest invertebrates!)
- Multiple arms with suckers
- Jet propulsion locomotion
- Chromatophores for color change
- Excellent problem-solvers and learners

## Mollusc Adaptations

- Open circulatory system (except cephalopods)
- Nervous ganglia (nerve clusters)
- Sexual reproduction (some hermaphroditic)
- Larval stage (trochophore)

## Economic Importance

✓ Food source: Oysters, clams, squid
✓ Pearl production: Irritant coated with nacre
✓ Shell craft and jewelry
✓ Aquaculture industry

## Protochordates

Link between invertebrates and vertebrates!

**Chordata Characteristics** (all chordates possess):
✓ Notochord: Flexible rod supporting body
✓ Dorsal tubular nerve cord
✓ Pharyngeal slits (or clefts)
✓ Post-anal tail
✓ Bilateral symmetry
✓ Triploblastic

## Urochordates (Tunicates)

- Barrel-shaped adults
- Sessile (attached to surface)
- Filter feeders via pharyngeal slits
- Larval form shows chordate features
- Reproduction: Asexual budding and sexual

## Cephalochordates (Lancelets/Amphioxus)

- Small, fish-like organisms (5 cm)
- ALL chordate features visible throughout LIFE
- Notochord runs entire body length
- Segmented muscle blocks (myomeres)
- Filter feeders in sand/mud
- **Living fossils** showing chordate ancestry

## Evolutionary Significance

Protochordates prove:
✓ Vertebrate evolution from simpler forms
✓ Gradual complexity development
✓ Genetic connections between invertebrates and vertebrates''',
        'questions': [
          {
            'question': 'Molluscs possess:',
            'options': ['Rigid skeleton', 'Soft body', 'Jointed legs', 'Exoskeleton'],
            'correct': 1,
          },
          {
            'question': 'Gastropod radula function:',
            'options': ['Locomotion', 'Scraping food', 'Shell formation', 'Reproduction'],
            'correct': 1,
          },
          {
            'question': 'Bivalves obtain nutrition by:',
            'options': ['Predation', 'Filter feeding', 'Absorption', 'Parasitism'],
            'correct': 1,
          },
          {
            'question': 'Cephalopods are intelligent because of:',
            'options': ['Large body size', 'Highly developed brain', 'Number of arms', 'Jet propulsion'],
            'correct': 1,
          },
          {
            'question': 'Protochordates link:',
            'options': ['Fish to amphibians', 'Invertebrates to vertebrates', 'Plants to animals', 'Single cells to multicells'],
            'correct': 1,
          },
        ]
      };

    case 'bio102_u3_2':
      return {
        'content': '''# Vertebrate Classes Overview

## Fish (Agnathans, Chondrichthyes, Osteichthyes)

**Agnathans** (Jawless Fish) - Most Primitive
- Lampreys and Hagfish
- No jaws or paired fins
- Suction mouth with keratinous (horn-like) teeth
- Parasitic feeding
- Notochord persistent (no vertebral column)

**Chondrichthyes** (Cartilaginous Fish)
- Sharks, Rays, Skates
- Skeleton of cartilage (not bone!)
- Jaws and paired fins
- Placoid scales (tooth-like)
- Internal fertilization
- Some ovoviviparous (eggs hatch internally)

**Osteichthyes** (Bony Fish) - Most Successful Vertebrates
- Bone skeleton (not cartilage)
- Operculum: Gill cover
- Swim bladder: For buoyancy control
- External fertilization (mostly)
- Streamlined body for aquatic life
- Freshwater, marine, even extreme habitats

## Amphibia - The Transition

Transitional between aquatic and terrestrial life:
- Moist skin (permeable for gas exchange)
- Tetrapod limbs (4 legs)
- Metamorphosis: Tadpole (aquatic) → Frog (terrestrial)
- Eggs lack shells (require water)
- Return to water for reproduction
- Examples: Frogs, Toads, Salamanders, Caecilians

**Advantages:** Colonize land
**Disadvantages:** Still depend on water

## Reptilia - Fully Terrestrial

Key adaptation: Amniotic egg
- Water-tight shell or membrane
- No free-swimming larval stage
- Internal development
- Can be laid on land

Characteristics:
- Dry, scaly skin (keratinous)
- Ectothermic (cold-blooded) - body temp follows environment
- Internal fertilization
- Examples: Lizards, Snakes, Turtles, Crocodilians
- Dominated Mesozoic era (Age of Dinosaurs)

## Aves (Birds)

Adaptations for flight:
- Feathers: Insulation + aerodynamics
- Hollow bones: Lighter structure
- Air sacs: Efficient respiration
- Keeled sternum: Flight muscle attachment
- High metabolic rate
- Endothermic (warm-blooded)

**Advanced features:**
- Complex brain
- Excellent vision
- Amniotic eggs with hard shell
- Loss of teeth (replaced by beak)
- Evolutionary link to dinosaurs (Archaeopteryx)

## Mammalia - The Winners

Characteristics:
- Hair or fur: Insulation
- Mammary glands: Milk production for young
- Diaphragm: Efficient breathing
- Four-chambered heart
- Endothermic (warm-blooded)
- Specialized teeth (incisors, canines, molars)
- Complex behavior and intelligence

**Subclasses:**

**Monotremes** (egg-laying)
- Platypus, Echidna
- Most primitive mammals

**Marsupials** (pouch-rearing)
- Kangaroo, Koala, Possum
- Short gestation, underdeveloped young

**Placentals** (placental gestation)
- Most mammals (humans, dogs, bats)
- Long gestation, well-developed young
- Placenta provides nutrients

Most successful terrestrial vertebrates!''',
        'questions': [
          {
            'question': 'Swim bladder in fish:',
            'options': ['Stores food', 'Controls buoyancy', 'Breaks down toxins', 'Aids reproduction'],
            'correct': 1,
          },
          {
            'question': 'Amphibians return to water for:',
            'options': ['Feeding', 'Reproduction', 'Breathing', 'Growth'],
            'correct': 1,
          },
          {
            'question': 'Amniotic egg adaptation allows:',
            'options': ['Aquatic development', 'Terrestrial development', 'Larger offspring', 'Faster reproduction'],
            'correct': 1,
          },
          {
            'question': 'Bird feathers provide:',
            'options': ['Insulation only', 'Flight only', 'Insulation and flight', 'Waterproofing only'],
            'correct': 2,
          },
          {
            'question': 'Mammals produce:',
            'options': ['Eggs always', 'Live young always', 'Eggs or live young depending on subclass', 'Spores'],
            'correct': 2,
          },
        ]
      };

    case 'bio102_u3_3':
      return {
        'content': '''# Ecology & Organism-Environment Relationships

## What is Ecology?

Study of:
✓ Organisms and their environment
✓ Population interactions
✓ Energy flow through ecosystems
✓ Nutrient cycling

## Abiotic (Non-Living) Factors

**Temperature**: Affects metabolism, distribution of species
**Light**: Energy source, controls day length (photoperiod)
**Water**: Essential solvent, habitat medium
**Humidity**: Critical for terrestrial organisms
**Soil**: Substrate, nutrient source
**Atmospheric Gases**: O₂, CO₂ availability
**pH and Salinity**: Environmental parameters

## Biotic (Living) Factors

**Producers**: Plants, photosynthetic organisms (make own food)

**Consumers**:
- Primary: Herbivores (eat plants)
- Secondary: Carnivores eating herbivores
- Tertiary: Top predators

**Decomposers**: Bacteria, fungi (break down dead matter)

## Population Interactions

**Competition**: Species compete for same resources
**Predation**: Predator eats prey (benefits predator, harms prey)
**Parasitism**: Parasite benefits, host harmed
**Mutualism**: Both organisms benefit (flower-pollinator)
**Commensalism**: One benefits, other unaffected
**Symbiosis**: Close living arrangement (parasitism, mutualism, commensalism)

## Habitat Types

**Terrestrial Biomes:**
- Forest: High biodiversity, layered structure
- Grassland: Open, low rainfall, grazing animals
- Desert: Extreme temperatures, little water
- Tundra: Frozen ground, low vegetation

**Aquatic Habitats:**
- Freshwater: Ponds, lakes, rivers
  - Littoral (shallow), Limnetic (open water), Profundal (deep)
- Marine: Oceans, saltwater
  - Intertidal, Neritic (shallow), Oceanic (deep)
  - Photic (sunlit), Aphotic (dark)

## Population Dynamics

**Exponential Growth**: Unlimited resources (J-curve)
**Logistic Growth**: Limited by carrying capacity (S-curve)
**Population Density**: Individuals per area

**Limiting Factors:**
- Density-dependent: Disease, predation (increase at high density)
- Density-independent: Weather, disasters (regardless of density)

## Ecological Succession

**Primary Succession**: Colonization of bare rock/new substrate
**Secondary Succession**: Recovery after disturbance (fire, storm)

Steps:
1. Pioneer species (first colonizers)
2. Early colonists modify environment
3. Later species replace earlier ones
4. Climax community (stable end stage)

## Energy Flow

**10% Rule**: Energy decreases 90% with each trophic level
- Producers: 100%
- Primary consumers: ~10%
- Secondary consumers: ~1%
- Tertiary consumers: ~0.1%

Energy lost as heat, waste, and respiration

**Trophic Pyramids**: Show energy, biomass, or number of organisms

## Nutrient Cycling

**Carbon Cycle**: Photosynthesis ← → Respiration, Fossilization
**Nitrogen Cycle**: Fixation → Nitrification → Denitrification
**Phosphorus Cycle**: Weathering → Absorption → Decomposition
**Water Cycle**: Evaporation → Precipitation → Transpiration

## Conservation

**Threats:**
- Habitat loss (primary cause of extinction)
- Climate change
- Pollution
- Overhunting

**Solutions:**
- Protected areas and reserves
- Breeding programs
- Sustainable practices
- International cooperation''',
        'questions': [
          {
            'question': 'Ecology studies:',
            'options': ['Only individual organisms', 'Organisms and environment', 'Only physical factors', 'Only biotic factors'],
            'correct': 1,
          },
          {
            'question': 'Mutualism means:',
            'options': ['One organism benefits', 'Both organisms benefit', 'One is harmed', 'No interaction'],
            'correct': 1,
          },
          {
            'question': '10% Rule means:',
            'options': ['10% energy per level', '90% energy lost per level', 'All levels equal', 'Energy increases upward'],
            'correct': 1,
          },
          {
            'question': 'Carrying capacity is:',
            'options': ['Maximum population size', 'Minimum population', 'Birth rate', 'Death rate'],
            'correct': 0,
          },
          {
            'question': 'Primary succession occurs on:',
            'options': ['Previously inhabited areas', 'Bare rock with no soil', 'After forest fire', 'Disturbed land'],
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