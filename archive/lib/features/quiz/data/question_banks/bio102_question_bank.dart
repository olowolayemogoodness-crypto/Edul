// lib/features/quiz/data/question_banks/bio102_question_bank.dart
//
// Additional BIO102 (General Biology II) quiz questions, sourced from
// a PDF question bank. These are ADDED ON TOP OF the original 5
// questions per topic in bio102_lessons.dart (not a replacement) --
// see topic_question_source.dart for how the two sources are merged.
//
// NOTE ON DATA QUALITY: the source PDF's answer key was heavily skewed
// (64% of correct answers were option B). Every question's options have
// been shuffled and the correct index recomputed to remove this bias --
// content/correctness is unaffected, only display order changed.
//
// NOTE ON SCOPE: the source PDF also included 81 diagram-based
// questions (9/topic, e.g. "which letter represents X in the
// diagram"). Those are DELIBERATELY EXCLUDED here -- the extracted
// diagrams weren't realistic/polished enough to ship, so those
// questions would be unanswerable without a real image. Only the 917
// standard (non-diagram) questions are included below. Revisit if/when
// better diagrams are available -- QuizQuestion.imageUrl already
// exists and quiz_question_page.dart already renders it.
//
// NOTE ON MAP-CONTENT MISMATCH: bio102_lessons.dart's content for
// u2_3, u3_1, and u3_2 doesn't fully match their subjects_data.dart
// labels (Molluscs content ended up under u3_1 instead of u2_3).
// This bank is keyed correctly to the LABELS (matching the PDF's own
// topic names), so quiz questions are accurate regardless -- only the
// Learning Map's lesson content is affected, and that's unchanged here.
//
// Keyed by the same lessonId used in subjects_data.dart and
// bio102_lessons.dart (e.g. 'bio102_u1_1').

List<Map<String, dynamic>> getBIO102ExtraQuestions(String lessonId) {
  switch (lessonId) {
    case 'bio102_u1_1': // Kingdom Overview
      return [
        {
          'question': 'Who proposed the Five Kingdom classification system?',
          'options': ['Ernst Haeckel', 'R.H. Whittaker', 'Carl Linnaeus', 'Charles Darwin'],
          'correct': 1,
        },
        {
          'question': 'How many kingdoms are recognised in Whittaker\'s classification?',
          'options': ['Four', 'Five', 'Six', 'Three'],
          'correct': 1,
        },
        {
          'question': 'Which kingdom contains only prokaryotic organisms?',
          'options': ['Monera', 'Protista', 'Animalia', 'Fungi'],
          'correct': 0,
        },
        {
          'question': 'Bacteria and blue-green algae belong to which kingdom?',
          'options': ['Plantae', 'Monera', 'Protista', 'Fungi'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a unicellular eukaryote kingdom?',
          'options': ['Animalia', 'Monera', 'Protista', 'Plantae'],
          'correct': 2,
        },
        {
          'question': 'Amoeba and Paramecium belong to which kingdom?',
          'options': ['Fungi', 'Animalia', 'Monera', 'Protista'],
          'correct': 3,
        },
        {
          'question': 'Mushrooms and yeasts belong to which kingdom?',
          'options': ['Protista', 'Monera', 'Fungi', 'Plantae'],
          'correct': 2,
        },
        {
          'question': 'Fungi obtain nutrition mainly by?',
          'options': ['Chemosynthesis only', 'Photosynthesis', 'Ingestion', 'Absorption of organic matter'],
          'correct': 3,
        },
        {
          'question': 'The kingdom Plantae consists of organisms that are mostly?',
          'options': ['Autotrophic', 'Saprophytic', 'Heterotrophic', 'Parasitic only'],
          'correct': 0,
        },
        {
          'question': 'Which kingdom includes multicellular, heterotrophic organisms without cell walls?',
          'options': ['Fungi', 'Monera', 'Animalia', 'Plantae'],
          'correct': 2,
        },
        {
          'question': 'The basic unit of biological classification is the?',
          'options': ['Kingdom', 'Genus', 'Family', 'Species'],
          'correct': 3,
        },
        {
          'question': 'Binomial nomenclature was introduced by?',
          'options': ['Aristotle', 'Darwin', 'Linnaeus', 'Whittaker'],
          'correct': 2,
        },
        {
          'question': 'In binomial nomenclature, the first name represents the?',
          'options': ['Order', 'Family', 'Species', 'Genus'],
          'correct': 3,
        },
        {
          'question': 'The correct hierarchical order from broad to narrow is?',
          'options': ['Kingdom-Phylum-Class-Order-Family-Genus-Species', 'Family-Kingdom-Genus', 'Species-Genus-Family-Order', 'Phylum-Kingdom-Class'],
          'correct': 0,
        },
        {
          'question': 'Which taxonomic rank is between Class and Family?',
          'options': ['Order', 'Kingdom', 'Genus', 'Phylum'],
          'correct': 0,
        },
        {
          'question': 'Viruses are generally considered non-living outside a host because they lack?',
          'options': ['DNA', 'Cell structure and independent metabolism', 'RNA', 'Protein coat'],
          'correct': 1,
        },
        {
          'question': 'Fungal cell walls are mainly composed of?',
          'options': ['Cellulose', 'Lignin', 'Chitin', 'Peptidoglycan'],
          'correct': 2,
        },
        {
          'question': 'Cell walls of plants are mainly made of?',
          'options': ['Keratin', 'Chitin', 'Cellulose', 'Peptidoglycan'],
          'correct': 2,
        },
        {
          'question': 'Which kingdom has cell walls made of peptidoglycan?',
          'options': ['Protista', 'Fungi', 'Plantae', 'Monera (bacteria)'],
          'correct': 3,
        },
        {
          'question': 'Organisms in kingdom Animalia are typically?',
          'options': ['Chemosynthetic', 'Heterotrophic', 'Saprophytic', 'Autotrophic'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is NOT a criterion used in classification?',
          'options': ['Cell structure', 'Body organisation', 'Mode of nutrition', 'Favourite habitat colour'],
          'correct': 3,
        },
        {
          'question': 'Prokaryotic cells differ from eukaryotic cells mainly because they lack a?',
          'options': ['Membrane-bound nucleus', 'Cell membrane', 'Ribosome', 'Cytoplasm'],
          'correct': 0,
        },
        {
          'question': 'Which organism is prokaryotic?',
          'options': ['Paramecium', 'Yeast', 'E. coli bacterium', 'Amoeba'],
          'correct': 2,
        },
        {
          'question': 'Algae such as Chlamydomonas belong to which kingdom?',
          'options': ['Fungi', 'Plantae', 'Monera', 'Protista'],
          'correct': 3,
        },
        {
          'question': 'Slime moulds are classified under kingdom?',
          'options': ['Animalia', 'Fungi', 'Protista', 'Monera'],
          'correct': 2,
        },
        {
          'question': 'The study of classification of living organisms is called?',
          'options': ['Genetics', 'Taxonomy', 'Physiology', 'Ecology'],
          'correct': 1,
        },
        {
          'question': 'A taxon that includes closely related genera is called a?',
          'options': ['Species', 'Family', 'Phylum', 'Kingdom'],
          'correct': 1,
        },
        {
          'question': 'Which level of classification groups together similar families?',
          'options': ['Genus', 'Order', 'Species', 'Class'],
          'correct': 1,
        },
        {
          'question': 'The scientific name of humans, Homo sapiens, shows that sapiens is the?',
          'options': ['Family name', 'Species name', 'Order', 'Genus'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly represents a phylum?',
          'options': ['Mammalia', 'Chordata', 'Homo', 'Primates'],
          'correct': 1,
        },
        {
          'question': 'Organisms that can manufacture their own food are called?',
          'options': ['Decomposers', 'Autotrophs', 'Saprotrophs', 'Heterotrophs'],
          'correct': 1,
        },
        {
          'question': 'Organisms that depend on other organisms for food are called?',
          'options': ['Autotrophs', 'Producers', 'Heterotrophs', 'Photosynthesizers'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes a saprophyte?',
          'options': ['Feeds on sunlight only', 'Feeds on dead and decaying matter', 'Feeds on living hosts', 'Makes its own food'],
          'correct': 1,
        },
        {
          'question': 'Lichens represent a symbiotic association between?',
          'options': ['Fungi and algae', 'Bacteria and protists', 'Algae and bacteria', 'Fungi and bacteria'],
          'correct': 0,
        },
        {
          'question': 'Which kingdom\'s members mostly reproduce by spores?',
          'options': ['Fungi', 'Monera only', 'Animalia', 'Protista only'],
          'correct': 0,
        },
        {
          'question': 'Chlorophyll is mainly found in which kingdom?',
          'options': ['Monera', 'Animalia', 'Fungi', 'Plantae'],
          'correct': 3,
        },
        {
          'question': 'Which of these organisms lacks a well-defined nucleus?',
          'options': ['Amoeba', 'Mushroom', 'Bacterium', 'Earthworm'],
          'correct': 2,
        },
        {
          'question': 'The kingdom Protista includes organisms that are mostly?',
          'options': ['Prokaryotic', 'Unicellular eukaryotes', 'Non-cellular', 'Multicellular only'],
          'correct': 1,
        },
        {
          'question': 'Diatoms belong to which kingdom?',
          'options': ['Monera', 'Protista', 'Fungi', 'Plantae'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is an example of Kingdom Monera?',
          'options': ['Cyanobacteria', 'Amoeba', 'Fern', 'Mushroom'],
          'correct': 0,
        },
        {
          'question': 'Nutrition in Kingdom Fungi is described as?',
          'options': ['Holozoic', 'Photosynthetic', 'Absorptive/saprophytic', 'Chemoautotrophic'],
          'correct': 2,
        },
        {
          'question': 'Which classification level is most specific?',
          'options': ['Class', 'Species', 'Kingdom', 'Order'],
          'correct': 1,
        },
        {
          'question': 'Which classification level is least specific (broadest)?',
          'options': ['Family', 'Kingdom', 'Species', 'Genus'],
          'correct': 1,
        },
        {
          'question': 'An organism\'s genus and species together form its?',
          'options': ['Family name', 'Class name', 'Common name', 'Scientific (binomial) name'],
          'correct': 3,
        },
        {
          'question': 'Which of the following pairs is correctly matched (Kingdom-Example)?',
          'options': ['Monera - Mushroom', 'Protista - Amoeba', 'Animalia - Fern', 'Fungi - Bacteria'],
          'correct': 1,
        },
        {
          'question': 'Which characteristic is used to separate Monera from other kingdoms?',
          'options': ['Multicellularity', 'Presence of chlorophyll', 'Mode of locomotion', 'Absence of membrane-bound organelles'],
          'correct': 3,
        },
        {
          'question': 'The five-kingdom system was proposed mainly based on?',
          'options': ['Colour of organism', 'Cell structure, nutrition, and body organisation', 'Size only', 'Habitat only'],
          'correct': 1,
        },
        {
          'question': 'Which of these is NOT true of Kingdom Animalia?',
          'options': ['Eukaryotic', 'Multicellular', 'Cell walls present', 'Heterotrophic'],
          'correct': 2,
        },
        {
          'question': 'Which term describes organisms living in or on another organism and deriving nourishment from it?',
          'options': ['Saprophyte', 'Parasite', 'Autotroph', 'Decomposer'],
          'correct': 1,
        },
        {
          'question': 'Which kingdom shows the greatest diversity in modes of nutrition (autotrophic, heterotrophic, and mixotrophic)?',
          'options': ['Monera', 'Fungi', 'Protista', 'Animalia'],
          'correct': 2,
        },
        {
          'question': 'A dichotomous key is used mainly to?',
          'options': ['Measure organism size', 'Classify DNA sequences', 'Identify organisms based on characteristics', 'Store specimens'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is considered the smallest unit capable of independent existence in classification?',
          'options': ['Family', 'Species', 'Order', 'Genus'],
          'correct': 1,
        },
        {
          'question': 'Which of these organisms would be classified in Kingdom Protista?',
          'options': ['Mushroom', 'Euglena', 'Moss', 'Housefly'],
          'correct': 1,
        },
        {
          'question': 'The rank directly above Genus in taxonomic hierarchy is?',
          'options': ['Order', 'Class', 'Family', 'Species'],
          'correct': 2,
        },
        {
          'question': 'Which is an example of a chemosynthetic organism?',
          'options': ['Certain sulfur bacteria', 'Mushrooms', 'Amoeba', 'Green plants'],
          'correct': 0,
        },
        {
          'question': 'Which kingdom includes organisms with a mix of plant-like and animal-like features?',
          'options': ['Fungi', 'Animalia', 'Protista', 'Monera'],
          'correct': 2,
        },
        {
          'question': 'Cyanobacteria are also known as?',
          'options': ['Red algae', 'Blue-green algae', 'Brown algae', 'Green algae'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best defines a species?',
          'options': ['Any group of similar-looking organisms', 'A kingdom subdivision only', 'A single organism', 'A group capable of interbreeding to produce fertile offspring'],
          'correct': 3,
        },
        {
          'question': 'The scientific classification system used today is largely based on the work of?',
          'options': ['Darwin only', 'Linnaeus and later Whittaker', 'Pasteur', 'Mendel'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an autotrophic protist?',
          'options': ['Chlamydomonas', 'Paramecium', 'Amoeba', 'Plasmodium'],
          'correct': 0,
        },
        {
          'question': 'Which kingdom\'s cell walls, when present, are made of cellulose?',
          'options': ['Fungi', 'Plantae', 'Monera', 'None of them'],
          'correct': 1,
        },
        {
          'question': 'Nostoc, a filamentous cyanobacterium, belongs to kingdom?',
          'options': ['Fungi', 'Protista', 'Monera', 'Plantae'],
          'correct': 2,
        },
        {
          'question': 'Which of these organisms would NOT have a true nucleus?',
          'options': ['Amoeba', 'Earthworm cell', 'Yeast', 'Bacterium'],
          'correct': 3,
        },
        {
          'question': 'Which is the correct sequence of increasing complexity in classification going upward?',
          'options': ['Family to Species to Genus', 'Species to Kingdom', 'Kingdom to Species', 'Genus to Kingdom to Species'],
          'correct': 1,
        },
        {
          'question': 'Which feature distinguishes Fungi from Plantae?',
          'options': ['Multicellularity', 'Mode of nutrition (absorptive vs photosynthetic)', 'Eukaryotic nature', 'Presence of cell wall'],
          'correct': 1,
        },
        {
          'question': 'The term \'flora\' refers to?',
          'options': ['Microbial life only', 'Animal life of a region', 'Fungal life only', 'Plant life of a region'],
          'correct': 3,
        },
        {
          'question': 'The term \'fauna\' refers to?',
          'options': ['Animal life of a region', 'Plant life of a region', 'Fungal life', 'Bacterial life'],
          'correct': 0,
        },
        {
          'question': 'Which of the following shows correct use of binomial nomenclature?',
          'options': ['Homo Sapiens', 'homo sapiens', 'HOMO SAPIENS', 'Homo sapiens'],
          'correct': 3,
        },
        {
          'question': 'Rules for naming organisms scientifically fall under?',
          'options': ['Physiology', 'Ecology', 'Genetics', 'Nomenclature'],
          'correct': 3,
        },
        {
          'question': 'Which kingdom would a virus most closely be associated with, though not truly classified within any?',
          'options': ['Protista', 'Monera', 'Animalia', 'None (acellular)'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is a decomposer commonly placed in Kingdom Fungi?',
          'options': ['E. coli', 'Spirogyra', 'Rhizopus (bread mould)', 'Amoeba'],
          'correct': 2,
        },
        {
          'question': 'Multicellular organisms with photosynthetic pigments and cellulose cell walls belong to?',
          'options': ['Fungi', 'Monera', 'Animalia', 'Plantae'],
          'correct': 3,
        },
        {
          'question': 'Which classification rank do \'Primates\' and \'Carnivora\' represent?',
          'options': ['Order', 'Class', 'Phylum', 'Family'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of an autotrophic bacterium?',
          'options': ['Housefly', 'Yeast', 'Amoeba', 'Rhizobium (nitrogen-fixing)'],
          'correct': 3,
        },
        {
          'question': 'The presence of a defined nuclear membrane is a feature of?',
          'options': ['Bacteria only', 'Eukaryotes', 'Prokaryotes only', 'Viruses'],
          'correct': 1,
        },
        {
          'question': 'Which kingdom includes both unicellular algae and protozoans?',
          'options': ['Monera', 'Protista', 'Fungi', 'Plantae'],
          'correct': 1,
        },
        {
          'question': 'Which of these best distinguishes Kingdom Animalia from Kingdom Plantae?',
          'options': ['Presence of nucleus', 'Cellular organisation', 'Mode of nutrition and lack of cell wall', 'Ability to reproduce'],
          'correct': 2,
        },
        {
          'question': 'Spirogyra, a green filamentous alga, belongs to kingdom?',
          'options': ['Fungi', 'Protista', 'Animalia', 'Monera'],
          'correct': 1,
        },
        {
          'question': 'Which is the correct order of taxonomic ranks from Kingdom downward?',
          'options': ['Kingdom, Order, Phylum, Class', 'Kingdom, Class, Phylum, Order', 'Kingdom, Family, Phylum, Class', 'Kingdom, Phylum, Class, Order, Family, Genus, Species'],
          'correct': 3,
        },
        {
          'question': 'The scientific name for the domestic cat is Felis catus. \'Felis\' represents the?',
          'options': ['Genus', 'Species', 'Family', 'Order'],
          'correct': 0,
        },
        {
          'question': 'Which of these organisms is placed in Kingdom Monera due to lack of a nuclear membrane?',
          'options': ['Spirogyra', 'Rhizopus', 'Cyanobacteria', 'Paramecium'],
          'correct': 2,
        },
        {
          'question': 'Which mode of nutrition is unique to green plants and some protists among the kingdoms?',
          'options': ['Photosynthetic (autotrophic)', 'Holozoic', 'Parasitic', 'Saprophytic'],
          'correct': 0,
        },
        {
          'question': 'Which taxonomic category is shared by organisms with the most features in common?',
          'options': ['Species', 'Kingdom', 'Phylum', 'Order'],
          'correct': 0,
        },
        {
          'question': 'A key advantage of the five-kingdom system over the two-kingdom system is that it?',
          'options': ['Groups all microbes together', 'Separates prokaryotes and eukaryotes clearly', 'Ignores cell structure', 'Removes need for species names'],
          'correct': 1,
        },
        {
          'question': 'Which of these organisms belongs to Kingdom Fungi due to chitin cell walls and absorptive nutrition?',
          'options': ['Amoeba', 'Chlamydomonas', 'Penicillium', 'E. coli'],
          'correct': 2,
        },
        {
          'question': 'Which statement about viruses is TRUE?',
          'options': ['They belong to Kingdom Monera', 'They have cellular structure', 'They can reproduce only inside a living host cell', 'They photosynthesize'],
          'correct': 2,
        },
        {
          'question': 'Which kingdom would NOT typically show cell walls in its members?',
          'options': ['Animalia', 'Monera', 'Plantae', 'Fungi'],
          'correct': 0,
        },
        {
          'question': 'The kingdom that includes both photosynthetic and non-photosynthetic single-celled eukaryotes is?',
          'options': ['Fungi', 'Protista', 'Plantae', 'Monera'],
          'correct': 1,
        },
        {
          'question': 'Which of the following pairs correctly matches organism with its kingdom?',
          'options': ['Amoeba - Monera', 'Fern - Fungi', 'Bacterium - Protista', 'Mushroom - Fungi'],
          'correct': 3,
        },
        {
          'question': 'Which characteristic is common to all five kingdoms?',
          'options': ['Cellular organisation', 'Multicellularity', 'Cell wall present', 'Photosynthesis'],
          'correct': 0,
        },
        {
          'question': 'Which of these is considered a \'missing link\' organism because it shows features between kingdoms (e.g., Euglena)?',
          'options': ['Euglena (plant and animal-like features)', 'Mushroom', 'Housefly', 'Amoeba'],
          'correct': 0,
        },
        {
          'question': 'The classification rank \'Family\' groups together related?',
          'options': ['Orders', 'Species', 'Kingdoms', 'Genera'],
          'correct': 3,
        },
        {
          'question': 'Which of these is the smallest and most inclusive taxonomic unit respectively?',
          'options': ['Genus (smallest), Family (most inclusive)', 'Order (smallest), Class (most inclusive)', 'Species (smallest), Kingdom (most inclusive)', 'Kingdom (smallest), Species (most inclusive)'],
          'correct': 2,
        },
        {
          'question': 'In taxonomy, organisms sharing a Phylum but different Classes still share which broader rank?',
          'options': ['Genus', 'Species', 'Family', 'Kingdom'],
          'correct': 3,
        },
        {
          'question': 'Which is an example of a heterotrophic protist that causes disease in humans?',
          'options': ['Chlamydomonas', 'Diatom', 'Plasmodium (malaria parasite)', 'Spirogyra'],
          'correct': 2,
        },
        {
          'question': 'Yeasts reproduce mainly by?',
          'options': ['Spore formation only', 'Conjugation only', 'Binary fission', 'Budding'],
          'correct': 3,
        },
        {
          'question': 'The cell wall in Kingdom Monera (bacteria) is mainly made of?',
          'options': ['Cellulose', 'Peptidoglycan', 'Chitin', 'Lignin'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is TRUE about Kingdom Plantae members?',
          'options': ['They are heterotrophic', 'They are unicellular only', 'They possess cellulose cell walls and chlorophyll', 'They lack chlorophyll'],
          'correct': 2,
        },
        {
          'question': 'The organism Rhizopus (bread mould) reproduces mainly through?',
          'options': ['Binary fission', 'Budding only', 'Seeds', 'Spores'],
          'correct': 3,
        },
        {
          'question': 'Which kingdom is characterised by absence of true tissues in most simple members but heterotrophic nutrition by ingestion?',
          'options': ['Animalia', 'Protista', 'Monera', 'Fungi'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best explains why fungi are not classified as plants?',
          'options': ['They are prokaryotic', 'They lack cellulose walls and are heterotrophic (absorptive)', 'They lack cell walls entirely', 'They have chlorophyll'],
          'correct': 1,
        },
        {
          'question': 'The rank \'Class Mammalia\' groups together animals that share which feature?',
          'options': ['Presence of gills', 'Cold-bloodedness', 'Presence of mammary glands and hair', 'Presence of feathers'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly lists examples from Kingdom Protista?',
          'options': ['Mushroom, Yeast, Mould', 'Fern, Moss, Pine', 'Bacteria, Cyanobacteria', 'Amoeba, Paramecium, Euglena'],
          'correct': 3,
        },
        {
          'question': 'A group of interbreeding organisms that produce fertile offspring, and cannot normally breed with other such groups, defines a?',
          'options': ['Family', 'Class', 'Genus', 'Species'],
          'correct': 3,
        },
        {
          'question': 'Which of these terms describes naming organisms using two Latin words?',
          'options': ['Trinomial nomenclature', 'Binomial nomenclature', 'Common naming', 'Monomial nomenclature'],
          'correct': 1,
        },
      ];
    case 'bio102_u1_2': // Animal Features
      return [
        {
          'question': 'Animals that can be divided into two equal halves by only one plane show which symmetry?',
          'options': ['Asymmetry', 'Bilateral symmetry', 'Spherical symmetry', 'Radial symmetry'],
          'correct': 1,
        },
        {
          'question': 'Animals like starfish and sea anemones typically show which type of symmetry?',
          'options': ['Asymmetry', 'Bilateral', 'Biradial', 'Radial'],
          'correct': 3,
        },
        {
          'question': 'An organism with no definite symmetry, such as most sponges, is said to be?',
          'options': ['Bilaterally symmetrical', 'Asymmetrical', 'Radially symmetrical', 'Biradial'],
          'correct': 1,
        },
        {
          'question': 'The body cavity that is completely lined by mesoderm is called?',
          'options': ['Blastocoel', 'Pseudocoelom', 'Coelom (true coelom)', 'Acoelomate'],
          'correct': 2,
        },
        {
          'question': 'Animals with a body cavity partially lined by mesoderm are called?',
          'options': ['Pseudocoelomate', 'Diploblastic', 'Coelomate', 'Acoelomate'],
          'correct': 0,
        },
        {
          'question': 'Flatworms (Platyhelminthes) are examples of which body cavity condition?',
          'options': ['Coelomate', 'Pseudocoelomate', 'Acoelomate', 'Triploblastic coelomate'],
          'correct': 2,
        },
        {
          'question': 'Roundworms (Nematodes) show which body cavity type?',
          'options': ['Acoelomate', 'Pseudocoelomate', 'None', 'Coelomate'],
          'correct': 1,
        },
        {
          'question': 'Earthworms and vertebrates possess which type of body cavity?',
          'options': ['Blastocoel only', 'True coelom', 'No cavity', 'Pseudocoelom'],
          'correct': 1,
        },
        {
          'question': 'Animals developing from two germ layers are called?',
          'options': ['Tetrablastic', 'Monoblastic', 'Diploblastic', 'Triploblastic'],
          'correct': 2,
        },
        {
          'question': 'Animals developing from three germ layers are called?',
          'options': ['Triploblastic', 'Diploblastic', 'Biploblastic', 'Acellular'],
          'correct': 0,
        },
        {
          'question': 'Which of these is a diploblastic animal?',
          'options': ['Earthworm', 'Housefly', 'Hydra', 'Frog'],
          'correct': 2,
        },
        {
          'question': 'Which of these is a triploblastic animal?',
          'options': ['Jellyfish', 'Roundworm', 'Coral', 'Sponge'],
          'correct': 1,
        },
        {
          'question': 'The middle germ layer that gives rise to muscles and the skeletal system is the?',
          'options': ['Endoderm', 'Mesoderm', 'Blastoderm', 'Ectoderm'],
          'correct': 1,
        },
        {
          'question': 'The germ layer that gives rise to the skin and nervous system is the?',
          'options': ['Mesoderm', 'Notoderm', 'Endoderm', 'Ectoderm'],
          'correct': 3,
        },
        {
          'question': 'The germ layer that lines the gut and gives rise to digestive organs is the?',
          'options': ['None of these', 'Mesoderm', 'Ectoderm', 'Endoderm'],
          'correct': 3,
        },
        {
          'question': 'Segmentation of the body into repeated units is called?',
          'options': ['Torsion', 'Symmetry', 'Metamerism', 'Coelom formation'],
          'correct': 2,
        },
        {
          'question': 'Which of these animals shows true metameric segmentation?',
          'options': ['Jellyfish', 'Earthworm', 'Amoeba', 'Sponge'],
          'correct': 1,
        },
        {
          'question': 'Animals lacking any form of tissue organisation (cells work independently) belong to which grade?',
          'options': ['Organ grade', 'Organ-system grade', 'Cellular grade of organisation', 'Tissue grade'],
          'correct': 2,
        },
        {
          'question': 'Sponges show which grade of body organisation?',
          'options': ['Tissue grade', 'Organ-system grade', 'Organ grade', 'Cellular grade'],
          'correct': 3,
        },
        {
          'question': 'Hydra and jellyfish show which grade of organisation?',
          'options': ['Tissue grade', 'Organ-system grade', 'Cellular grade', 'Organ grade'],
          'correct': 0,
        },
        {
          'question': 'Higher animals like vertebrates show which grade of body organisation?',
          'options': ['Tissue grade', 'Organ-system grade', 'Cellular grade', 'Organ grade'],
          'correct': 1,
        },
        {
          'question': 'Which feature is used to distinguish vertebrates from invertebrates?',
          'options': ['Ability to fly', 'Body colour', 'Presence of legs', 'Presence of a notochord/vertebral column'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an invertebrate?',
          'options': ['Grasshopper', 'Snake', 'Frog', 'Lizard'],
          'correct': 0,
        },
        {
          'question': 'Cold-blooded animals are also referred to as?',
          'options': ['Endothermic', 'Homeothermic', 'Poikilothermic', 'Warm-blooded'],
          'correct': 2,
        },
        {
          'question': 'Warm-blooded animals that maintain constant body temperature are called?',
          'options': ['Ectothermic', 'Cold-blooded', 'Homeothermic', 'Poikilothermic'],
          'correct': 2,
        },
        {
          'question': 'Which of these animals is poikilothermic (cold-blooded)?',
          'options': ['Fish', 'Mammal', 'Human', 'Bird'],
          'correct': 0,
        },
        {
          'question': 'Which of these animals is homeothermic (warm-blooded)?',
          'options': ['Snake', 'Bird', 'Fish', 'Frog'],
          'correct': 1,
        },
        {
          'question': 'The process by which an organism maintains a stable internal environment is called?',
          'options': ['Metabolism', 'Homeostasis', 'Excretion', 'Respiration'],
          'correct': 1,
        },
        {
          'question': 'Animals that respire using gills are typically found in which habitat?',
          'options': ['Terrestrial', 'Aerial', 'Underground only', 'Aquatic'],
          'correct': 3,
        },
        {
          'question': 'Which respiratory structure is characteristic of insects?',
          'options': ['Gills', 'Tracheae', 'Skin only', 'Lungs'],
          'correct': 1,
        },
        {
          'question': 'Which of these is the main excretory organ in earthworms?',
          'options': ['Kidneys', 'Flame cells', 'Nephridia', 'Malpighian tubules'],
          'correct': 2,
        },
        {
          'question': 'Which excretory structures are found in flatworms?',
          'options': ['Malpighian tubules', 'Flame cells (protonephridia)', 'Kidneys', 'Nephridia'],
          'correct': 1,
        },
        {
          'question': 'Which excretory organs are characteristic of insects?',
          'options': ['Malpighian tubules', 'Flame cells', 'Nephridia', 'Kidneys'],
          'correct': 0,
        },
        {
          'question': 'The presence of jointed appendages is a key feature of which animal group?',
          'options': ['Cnidarians', 'Arthropods', 'Annelids', 'Molluscs'],
          'correct': 1,
        },
        {
          'question': 'An exoskeleton made of chitin is characteristic of?',
          'options': ['Vertebrates', 'Arthropods', 'Molluscs', 'Annelids'],
          'correct': 1,
        },
        {
          'question': 'An endoskeleton made of bone or cartilage is found in?',
          'options': ['Vertebrates', 'Arthropods', 'Cnidarians', 'Molluscs'],
          'correct': 0,
        },
        {
          'question': 'Which type of skeleton is found in most molluscs (like snails)?',
          'options': ['No skeleton at all', 'Endoskeleton', 'Chitinous exoskeleton like insects', 'Hydrostatic and/or shell exoskeleton'],
          'correct': 3,
        },
        {
          'question': 'Open circulatory system, where blood is not always confined to vessels, is typical of?',
          'options': ['Vertebrates', 'Annelids only', 'Cnidarians only', 'Arthropods and most molluscs'],
          'correct': 3,
        },
        {
          'question': 'Closed circulatory system, where blood flows entirely within vessels, is typical of?',
          'options': ['Annelids and vertebrates', 'Molluscs only', 'Cnidarians', 'Arthropods'],
          'correct': 0,
        },
        {
          'question': 'Which of these animal groups reproduces mainly by budding as well as sexual means?',
          'options': ['Mammals', 'Hydra (Cnidaria)', 'Insects', 'Vertebrates'],
          'correct': 1,
        },
        {
          'question': 'Hermaphroditic animals possess?',
          'options': ['Only female organs', 'Both male and female reproductive organs', 'Only male organs', 'No reproductive organs'],
          'correct': 1,
        },
        {
          'question': 'Which of these is typically hermaphroditic?',
          'options': ['Dog', 'Housefly', 'Frog', 'Earthworm'],
          'correct': 3,
        },
        {
          'question': 'Animals in which sexes are separate (male and female individuals) are termed?',
          'options': ['Dioecious', 'Hermaphrodite', 'Asexual', 'Monoecious'],
          'correct': 0,
        },
        {
          'question': 'The presence of a notochord at some stage of life is a defining feature of which phylum?',
          'options': ['Annelida', 'Chordata', 'Arthropoda', 'Mollusca'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a characteristic feature distinguishing vertebrates from invertebrates at the developmental level?',
          'options': ['Bilateral symmetry', 'Segmentation', 'Presence of vertebral column replacing notochord', 'Presence of legs'],
          'correct': 2,
        },
        {
          'question': 'Locomotion by means of a muscular foot is characteristic of which animal group?',
          'options': ['Cnidarians', 'Molluscs (e.g., snails)', 'Arthropods', 'Sponges'],
          'correct': 1,
        },
        {
          'question': 'Locomotion using parapodia (paired appendages) is seen in?',
          'options': ['Earthworms', 'Molluscs', 'Polychaete annelids', 'Insects'],
          'correct': 2,
        },
        {
          'question': 'Cilia-based locomotion is common in which group of organisms?',
          'options': ['Vertebrates', 'Molluscs', 'Insects', 'Protozoans like Paramecium'],
          'correct': 3,
        },
        {
          'question': 'Amoeboid movement, using pseudopodia, is characteristic of?',
          'options': ['Euglena', 'Paramecium', 'Hydra', 'Amoeba'],
          'correct': 3,
        },
        {
          'question': 'Flagellar movement for locomotion is seen in organisms such as?',
          'options': ['Earthworm', 'Starfish', 'Euglena', 'Amoeba'],
          'correct': 2,
        },
        {
          'question': 'Which body plan feature helps in efficient one-way digestion (mouth and anus separate)?',
          'options': ['Gastrovascular cavity only', 'No digestive system', 'Complete (tube-within-a-tube) digestive system', 'Incomplete digestive system'],
          'correct': 2,
        },
        {
          'question': 'Animals with a gastrovascular cavity (single opening for mouth and anus) include?',
          'options': ['Vertebrates', 'Insects', 'Earthworms', 'Cnidarians like Hydra'],
          'correct': 3,
        },
        {
          'question': 'Cephalisation refers to the concentration of sensory organs and nerve tissue at the?',
          'options': ['Middle of the body', 'Ventral side only', 'Anterior (head) end', 'Tail end'],
          'correct': 2,
        },
        {
          'question': 'Which animals show clear cephalisation due to bilateral symmetry?',
          'options': ['Insects and vertebrates', 'Sponges', 'Corals', 'Jellyfish'],
          'correct': 0,
        },
        {
          'question': 'A hydrostatic skeleton, using fluid pressure for movement and shape, is found in?',
          'options': ['Vertebrates', 'Earthworms', 'Insects', 'Molluscs with shells'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is a soft-bodied animal typically protected by a calcareous shell?',
          'options': ['Snail (mollusc)', 'Insect', 'Frog', 'Earthworm'],
          'correct': 0,
        },
        {
          'question': 'Torsion, a twisting of the body during development, is a characteristic feature of which group?',
          'options': ['Gastropod molluscs (snails)', 'Annelids', 'Cephalopod molluscs', 'Bivalve molluscs'],
          'correct': 0,
        },
        {
          'question': 'Which class of molluscs lacks a shell and includes octopuses and squids?',
          'options': ['Gastropoda', 'Cephalopoda', 'Bivalvia', 'Polyplacophora'],
          'correct': 1,
        },
        {
          'question': 'Which of these animal features is an adaptation for flight?',
          'options': ['Thick fur', 'Heavy solid bones', 'Gills', 'Hollow, lightweight bones (as in birds)'],
          'correct': 3,
        },
        {
          'question': 'Streamlined body shape in fish is an adaptation mainly for?',
          'options': ['Reproduction', 'Reducing water resistance during swimming', 'Digestion', 'Camouflage'],
          'correct': 1,
        },
        {
          'question': 'Which body covering helps terrestrial vertebrates like reptiles prevent water loss?',
          'options': ['Gills', 'Moist skin', 'Feathers only', 'Scales (dry, keratinised)'],
          'correct': 3,
        },
        {
          'question': 'Feathers, found only in birds, primarily function in?',
          'options': ['Respiration only', 'Excretion', 'Digestion', 'Insulation and flight'],
          'correct': 3,
        },
        {
          'question': 'Mammary glands, used for producing milk to feed young, are a defining feature of?',
          'options': ['Mammals', 'Reptiles', 'Amphibians', 'Birds'],
          'correct': 0,
        },
        {
          'question': 'Which class of vertebrates typically has a moist, permeable skin and undergoes metamorphosis?',
          'options': ['Fish', 'Birds', 'Amphibians', 'Reptiles'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best distinguishes reptiles from amphibians?',
          'options': ['Reptiles live only in water', 'Reptiles have gills as adults', 'Amphibians have scales', 'Reptiles lay eggs on land with a protective shell, amphibians usually don\'t'],
          'correct': 3,
        },
        {
          'question': 'Which vertebrate class is characterised by a four-chambered heart and constant body temperature, and lacks feathers or fur typically covering scales instead?',
          'options': ['Amphibians', 'Mammals', 'Fish (bony)', 'Reptiles'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly matches an animal group with its typical respiratory organ?',
          'options': ['Fish - Gills', 'Mammals - Skin only', 'Insects - Gills', 'Fish - Lungs'],
          'correct': 0,
        },
        {
          'question': 'Which feature allows some animals like frogs to respire through their skin as well as lungs?',
          'options': ['Moist, vascularised skin', 'Presence of feathers', 'Presence of scales', 'Thick dry skin'],
          'correct': 0,
        },
        {
          'question': 'Which of these terms describes an animal\'s ability to regenerate lost body parts, seen strongly in organisms like starfish and Hydra?',
          'options': ['Metamerism', 'Metamorphosis', 'Regeneration', 'Torsion'],
          'correct': 2,
        },
        {
          'question': 'A larval stage that differs greatly from the adult form, followed by a dramatic change, is called?',
          'options': ['Metamorphosis', 'Cephalisation', 'Regeneration', 'Torsion'],
          'correct': 0,
        },
        {
          'question': 'Which of these animals undergoes complete metamorphosis (egg-larva-pupa-adult)?',
          'options': ['Grasshopper', 'Cockroach', 'Frog', 'Housefly'],
          'correct': 3,
        },
        {
          'question': 'Which of these animals undergoes incomplete metamorphosis (egg-nymph-adult)?',
          'options': ['Grasshopper', 'Butterfly', 'Housefly', 'Beetle'],
          'correct': 0,
        },
        {
          'question': 'Frogs undergo metamorphosis from which larval stage to the adult form?',
          'options': ['Caterpillar to butterfly', 'Tadpole to frog', 'Nymph to adult', 'Pupa to adult'],
          'correct': 1,
        },
        {
          'question': 'Which animal group is characterised by having a mantle that secretes a shell?',
          'options': ['Molluscs', 'Cnidarians', 'Annelids', 'Arthropods'],
          'correct': 0,
        },
        {
          'question': 'Which of the following animal features primarily functions in defence, such as spines or a hard exoskeleton?',
          'options': ['Exoskeleton/spines', 'Mantle only', 'Flagella', 'Cilia'],
          'correct': 0,
        },
        {
          'question': 'Bioluminescence, the ability to produce light, is seen in certain?',
          'options': ['Mammals only', 'Birds only', 'Deep-sea fish and some insects like fireflies', 'Reptiles only'],
          'correct': 2,
        },
        {
          'question': 'Camouflage, blending with the environment, is an adaptation mainly for?',
          'options': ['Digestion', 'Respiration', 'Reproduction', 'Protection from predators'],
          'correct': 3,
        },
        {
          'question': 'Mimicry, where a harmless species resembles a harmful one, is an adaptation for?',
          'options': ['Excretion', 'Locomotion', 'Protection from predators', 'Feeding'],
          'correct': 2,
        },
        {
          'question': 'Countershading, where an animal is darker on top and lighter underneath, helps mainly with?',
          'options': ['Camouflage', 'Excretion', 'Respiration', 'Digestion'],
          'correct': 0,
        },
        {
          'question': 'The dorsal, hollow nerve cord is a distinguishing feature of which major animal group?',
          'options': ['Molluscs', 'Arthropods', 'Chordates', 'Cnidarians'],
          'correct': 2,
        },
        {
          'question': 'Pharyngeal gill slits at some stage of development are characteristic of?',
          'options': ['Arthropods', 'Molluscs', 'Chordates', 'Annelids'],
          'correct': 2,
        },
        {
          'question': 'A post-anal tail at some developmental stage is a defining chordate feature that distinguishes them from?',
          'options': ['Non-chordate invertebrates', 'Only fish', 'Only mammals', 'Other chordates'],
          'correct': 0,
        },
        {
          'question': 'Which of these is NOT one of the four basic chordate characteristics?',
          'options': ['Post-anal tail', 'Dorsal hollow nerve cord', 'Notochord', 'Open circulatory system'],
          'correct': 3,
        },
        {
          'question': 'Which animal group typically has a closed circulatory system, segmented body, and nephridia for excretion?',
          'options': ['Cnidaria', 'Mollusca', 'Annelida', 'Arthropoda'],
          'correct': 2,
        },
        {
          'question': 'Bilateral symmetry is advantageous mainly because it allows for?',
          'options': ['Random movement', 'Directional (forward) movement and cephalisation', 'Sessile lifestyle', 'Radial feeding only'],
          'correct': 1,
        },
        {
          'question': 'Which of these organisms is sessile (fixed in one place) as an adult?',
          'options': ['Earthworm', 'Housefly', 'Sponge', 'Frog'],
          'correct': 2,
        },
        {
          'question': 'Free-living organisms, as opposed to sessile ones, are able to?',
          'options': ['Absorb nutrients only', 'Photosynthesize', 'Stay fixed in place', 'Move about actively'],
          'correct': 3,
        },
        {
          'question': 'The exoskeleton of arthropods must be periodically shed for growth in a process called?',
          'options': ['Metamorphosis', 'Torsion', 'Regeneration', 'Moulting (ecdysis)'],
          'correct': 3,
        },
        {
          'question': 'Which class of arthropods is characterised by three pairs of jointed legs and often wings?',
          'options': ['Myriapoda', 'Insecta', 'Arachnida', 'Crustacea'],
          'correct': 1,
        },
        {
          'question': 'Which class of arthropods typically has four pairs of legs and no antennae (e.g., spiders)?',
          'options': ['Chilopoda', 'Crustacea', 'Arachnida', 'Insecta'],
          'correct': 2,
        },
        {
          'question': 'Which class of arthropods, including crabs and shrimp, is mostly aquatic and has two pairs of antennae?',
          'options': ['Insecta', 'Crustacea', 'Diplopoda', 'Arachnida'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a defining feature of the class Insecta?',
          'options': ['Three body regions (head, thorax, abdomen) and three pairs of legs', 'Two body regions only', 'Four pairs of legs', 'Absence of exoskeleton'],
          'correct': 0,
        },
        {
          'question': 'The body of an insect is typically divided into which three regions?',
          'options': ['Cephalothorax, abdomen, tail', 'Anterior, posterior, middle', 'Head, tail, body', 'Head, thorax, abdomen'],
          'correct': 3,
        },
        {
          'question': 'The body of a spider (Arachnida) is typically divided into which two regions?',
          'options': ['Head and abdomen', 'Head and thorax', 'Cephalothorax and abdomen', 'Thorax and abdomen'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes \'bilateral symmetry with cephalisation\' as an evolutionary advantage?',
          'options': ['It allows radial feeding from all directions', 'It prevents movement', 'It supports directional movement with sensory organs concentrated at the front', 'It only benefits sessile organisms'],
          'correct': 2,
        },
        {
          'question': 'A key adaptive feature of desert-dwelling animals for water conservation is?',
          'options': ['Constant sweating', 'Thick, dry, keratinised skin or exoskeleton', 'Thin, moist skin', 'Large exposed gills'],
          'correct': 1,
        },
        {
          'question': 'Nocturnal animals are those that are mainly active during the?',
          'options': ['Never active', 'Dawn only', 'Night', 'Day'],
          'correct': 2,
        },
        {
          'question': 'Diurnal animals are those that are mainly active during the?',
          'options': ['Day', 'Dusk only', 'Night', 'Underground only'],
          'correct': 0,
        },
        {
          'question': 'Animals that are active mainly at dawn and dusk are called?',
          'options': ['Aestivating', 'Diurnal', 'Crepuscular', 'Nocturnal'],
          'correct': 2,
        },
        {
          'question': 'Hibernation is an adaptation that helps animals survive?',
          'options': ['Floods only', 'Hot summers', 'Cold winters with dormancy', 'Predators only'],
          'correct': 2,
        },
        {
          'question': 'Aestivation is a period of dormancy that helps animals survive?',
          'options': ['Rainy seasons only', 'Cold winters', 'Hot, dry conditions', 'Migration'],
          'correct': 2,
        },
        {
          'question': 'Which term describes the seasonal movement of animals from one region to another, often for breeding or food?',
          'options': ['Hibernation', 'Metamorphosis', 'Aestivation', 'Migration'],
          'correct': 3,
        },
        {
          'question': 'Which of the following animal groups is best known for long-distance migration, such as some birds and whales?',
          'options': ['Corals', 'Snails', 'Birds', 'Sponges'],
          'correct': 2,
        },
      ];
    case 'bio102_u1_3': // Ecological Adaptation
      return [
        {
          'question': 'An adaptation is best defined as a trait that?',
          'options': ['Only affects colour', 'Is always learned behaviour', 'Harms an organism\'s survival', 'Helps an organism survive and reproduce in its environment'],
          'correct': 3,
        },
        {
          'question': 'Structural adaptations refer to changes in an organism\'s?',
          'options': ['Behaviour', 'Diet only', 'Physical body features', 'Habitat location only'],
          'correct': 2,
        },
        {
          'question': 'Behavioural adaptations refer to changes in an organism\'s?',
          'options': ['Body structure', 'Colour only', 'Actions or behaviour patterns', 'Internal chemistry only'],
          'correct': 2,
        },
        {
          'question': 'Physiological adaptations refer to changes in an organism\'s?',
          'options': ['Internal body functions/processes', 'Actions', 'External shape only', 'Habitat only'],
          'correct': 0,
        },
        {
          'question': 'The thick blubber layer in whales and seals is an adaptation for?',
          'options': ['Camouflage', 'Digestion', 'Insulation against cold', 'Locomotion'],
          'correct': 2,
        },
        {
          'question': 'The long neck of a giraffe is a structural adaptation for?',
          'options': ['Reaching high tree leaves for food', 'Swimming', 'Camouflage', 'Defence'],
          'correct': 0,
        },
        {
          'question': 'Webbed feet in ducks are an adaptation for?',
          'options': ['Climbing trees', 'Swimming efficiently', 'Digging burrows', 'Walking on land only'],
          'correct': 1,
        },
        {
          'question': 'Camels storing fat in their humps is an adaptation for?',
          'options': ['Attracting mates', 'Regulating body temperature only', 'Camouflage', 'Surviving long periods without food'],
          'correct': 3,
        },
        {
          'question': 'The ability of some desert animals to produce very concentrated urine is an adaptation to?',
          'options': ['Aid digestion', 'Increase water loss', 'Conserve water', 'Aid respiration'],
          'correct': 2,
        },
        {
          'question': 'Fish adapted to deep-sea environments often have which feature?',
          'options': ['Large wings', 'Thick fur', 'Bright colours', 'Bioluminescent organs to attract prey/mates in darkness'],
          'correct': 3,
        },
        {
          'question': 'Polar bear fur being white is mainly an adaptation for?',
          'options': ['Repelling water only', 'Attracting mates', 'Increasing speed', 'Camouflage in snowy environments'],
          'correct': 3,
        },
        {
          'question': 'Cacti have spines instead of leaves mainly as an adaptation to?',
          'options': ['Aid reproduction', 'Reduce water loss and deter herbivores', 'Attract pollinators', 'Increase photosynthesis'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a behavioural adaptation?',
          'options': ['Migration to warmer areas in winter', 'Thick fur', 'Sharp teeth', 'Long claws'],
          'correct': 0,
        },
        {
          'question': 'Hibernation in animals like bears is an example of a?',
          'options': ['Reproductive adaptation only', 'Behavioural adaptation', 'Chemical adaptation', 'Structural adaptation'],
          'correct': 1,
        },
        {
          'question': 'Which of these represents a physiological adaptation in animals living at high altitudes?',
          'options': ['Brighter colours', 'Increased red blood cell production for more oxygen uptake', 'Longer legs', 'Bigger eyes only'],
          'correct': 1,
        },
        {
          'question': 'Nocturnal behaviour in desert animals mainly helps them avoid?',
          'options': ['Predators only', 'Rainfall', 'Extreme daytime heat', 'Migration'],
          'correct': 2,
        },
        {
          'question': 'Countershading in fish (dark top, light belly) is an adaptation mainly for?',
          'options': ['Reproduction', 'Respiration', 'Camouflage from predators above and below', 'Digestion'],
          'correct': 2,
        },
        {
          'question': 'Mimicry, where a species resembles another to avoid predation, is an example of?',
          'options': ['Physiological adaptation', 'Hibernation', 'Structural adaptation used for defence', 'Migration'],
          'correct': 2,
        },
        {
          'question': 'The sharp claws and strong beak of a bird of prey are adaptations for?',
          'options': ['Filtering water', 'Digging burrows', 'Catching and tearing prey', 'Swimming'],
          'correct': 2,
        },
        {
          'question': 'Adaptations that help organisms obtain food are often related to their?',
          'options': ['Colour only', 'Reproductive cycle only', 'Mouth/beak structure and feeding behaviour', 'Sleep pattern only'],
          'correct': 2,
        },
        {
          'question': 'The flat, broad teeth of herbivores are adapted for?',
          'options': ['Filtering water', 'Tearing meat', 'Grinding plant material', 'Sucking blood'],
          'correct': 2,
        },
        {
          'question': 'The sharp, pointed teeth of carnivores are adapted for?',
          'options': ['Filtering food', 'Chewing bark', 'Grinding plants', 'Tearing and cutting meat'],
          'correct': 3,
        },
        {
          'question': 'Which adaptation helps aquatic mammals like dolphins swim efficiently?',
          'options': ['Fur coat', 'Streamlined body shape', 'Long legs', 'Feathers'],
          'correct': 1,
        },
        {
          'question': 'The large ears of desert animals like the fennec fox mainly help with?',
          'options': ['Camouflage', 'Dissipating excess body heat', 'Digging', 'Hearing only'],
          'correct': 1,
        },
        {
          'question': 'Which adaptation allows some fish to survive in low-oxygen water?',
          'options': ['Thick scales', 'Gills only', 'Ability to gulp air at the surface (accessory air-breathing organs)', 'Bright colouration'],
          'correct': 2,
        },
        {
          'question': 'Migratory birds fly to warmer regions mainly to?',
          'options': ['Find better food supply and breeding conditions', 'Change colour', 'Reproduce asexually', 'Escape predators only'],
          'correct': 0,
        },
        {
          'question': 'Which is an example of adaptation for defence against predators?',
          'options': ['Fins of a fish', 'Sharp spines on a hedgehog', 'Wide mouth of a frog', 'Long neck of a giraffe'],
          'correct': 1,
        },
        {
          'question': 'An organism\'s tolerance range refers to?',
          'options': ['Only its diet', 'Only its colour', 'The range of conditions it can survive in', 'Only its size'],
          'correct': 2,
        },
        {
          'question': 'Organisms with a wide tolerance range for environmental factors are called?',
          'options': ['Eurytopic', 'Homeothermic', 'Poikilothermic', 'Stenotopic'],
          'correct': 0,
        },
        {
          'question': 'Organisms with a narrow tolerance range for environmental factors are called?',
          'options': ['Ectothermic', 'Stenotopic', 'Endothermic', 'Eurytopic'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an adaptation of plants (not animals) for surviving arid environments?',
          'options': ['Deep or widespread root systems', 'Gills', 'Webbed feet', 'Thick fur'],
          'correct': 0,
        },
        {
          'question': 'Succulent plants like cacti store water mainly in their?',
          'options': ['Stems', 'Leaves only', 'Roots only', 'Flowers only'],
          'correct': 0,
        },
        {
          'question': 'Which adaptation helps polar animals like penguins conserve heat?',
          'options': ['Large ears', 'Layers of fat (blubber) and dense feathers', 'Long legs', 'Thin layer of feathers only'],
          'correct': 1,
        },
        {
          'question': 'Aquatic adaptation seen in fish that helps them maintain buoyancy is the?',
          'options': ['Gills', 'Fins only', 'Scales only', 'Swim bladder'],
          'correct': 3,
        },
        {
          'question': 'Which adaptation in birds helps reduce weight for flight?',
          'options': ['Large teeth', 'Solid heavy bones', 'Thick fur', 'Hollow, air-filled bones'],
          'correct': 3,
        },
        {
          'question': 'Adaptive radiation refers to?',
          'options': ['Hibernation of a species', 'Extinction of a species', 'Migration of a species', 'A single species evolving into many species to fill different niches'],
          'correct': 3,
        },
        {
          'question': 'An ecological niche refers to?',
          'options': ['An organism\'s physical location only', 'Only its food source', 'The role and position of an organism in its environment, including its interactions', 'Only its predators'],
          'correct': 2,
        },
        {
          'question': 'Two species cannot occupy the exact same ecological niche in the same habitat for long due to?',
          'options': ['Symbiosis', 'Mutualism', 'Commensalism', 'Competitive exclusion'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes convergent evolution in relation to adaptation?',
          'options': ['Extinction of similar species', 'Random genetic drift only', 'Unrelated species evolving similar traits due to similar environments', 'Related species evolving different traits'],
          'correct': 2,
        },
        {
          'question': 'Sharks and dolphins having similar streamlined body shapes despite being unrelated is an example of?',
          'options': ['Convergent evolution', 'Genetic drift', 'Divergent evolution', 'Coevolution'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is an adaptation for camouflage in animals?',
          'options': ['Bright warning colouration', 'Loud sounds', 'Strong odour', 'Colour and pattern matching the surroundings'],
          'correct': 3,
        },
        {
          'question': 'Warning colouration (aposematism), such as bright colours in poisonous frogs, serves mainly to?',
          'options': ['Camouflage', 'Aid digestion', 'Warn predators of toxicity or danger', 'Attract prey'],
          'correct': 2,
        },
        {
          'question': 'Which adaptation helps some insects avoid predators by looking like twigs or leaves?',
          'options': ['Mimicry of predators', 'Aposematism', 'Camouflage (cryptic colouration)', 'Migration'],
          'correct': 2,
        },
        {
          'question': 'Batesian mimicry occurs when a harmless species resembles a?',
          'options': ['Predator directly', 'Harmful or unpalatable species', 'Another harmless species', 'Plant'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a physiological adaptation that helps animals survive extreme cold, such as antifreeze proteins in some fish?',
          'options': ['Structural bone changes', 'Migration behaviour', 'Blood chemicals that prevent freezing', 'Camouflage colouration'],
          'correct': 2,
        },
        {
          'question': 'Adaptations for burrowing animals, like moles, typically include?',
          'options': ['Wings', 'Long necks', 'Large eyes', 'Strong forelimbs and reduced eyesight'],
          'correct': 3,
        },
        {
          'question': 'Which adaptation helps arboreal (tree-dwelling) animals like monkeys move efficiently?',
          'options': ['Gills', 'Prehensile tails and grasping hands/feet', 'Hooves', 'Flippers'],
          'correct': 1,
        },
        {
          'question': 'Which of these adaptations helps grassland animals like antelope escape predators?',
          'options': ['Burrowing ability only', 'Thick fur', 'Camouflage in snow', 'Speed and long legs for running'],
          'correct': 3,
        },
        {
          'question': 'Adaptations of aquatic plants to living submerged in water often include?',
          'options': ['Deep taproots', 'Thick waxy cuticle', 'Spines', 'Thin flexible leaves and reduced root systems'],
          'correct': 3,
        },
        {
          'question': 'Which of the following helps marine animals like fish osmoregulate (balance salt/water) in saltwater?',
          'options': ['Growing fur', 'Producing dilute urine only', 'Specialised gills/kidneys to excrete excess salts', 'Increasing water intake only'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is an adaptation that helps freshwater fish avoid excess water uptake?',
          'options': ['Drinking large amounts of water', 'Excreting large amounts of dilute urine', 'Producing very concentrated urine only', 'Having no kidneys'],
          'correct': 1,
        },
        {
          'question': 'Which adaptation allows amphibians to live both in water and on land?',
          'options': ['Thick dry scales', 'Feathers', 'Fur', 'Moist, permeable skin for gas exchange plus lungs'],
          'correct': 3,
        },
        {
          'question': 'Which of these describes an adaptation for pollination in flowering plants, indirectly aiding animal survival too (mutualism)?',
          'options': ['Thick bark', 'Thorns', 'Deep roots', 'Bright colours and nectar to attract pollinators'],
          'correct': 3,
        },
        {
          'question': 'Coevolution refers to?',
          'options': ['Two or more species evolving together, each influencing the other\'s adaptations', 'Only extinction events', 'One species evolving in isolation', 'Random mutation with no interaction'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is a key adaptation of predators for hunting?',
          'options': ['Sharp claws, keen eyesight, and speed', 'Bright warning colours', 'Thick shells', 'Flat grinding teeth'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is a key adaptation of prey species for avoiding predation?',
          'options': ['Alertness, speed, camouflage, or defensive structures', 'Bright colouration always', 'Slow movement', 'Weak senses'],
          'correct': 0,
        },
        {
          'question': 'An organism\'s ability to change colour to match its surroundings, like a chameleon, is called?',
          'options': ['Mimicry', 'Aposematism', 'Countershading', 'Cryptic colouration/camouflage'],
          'correct': 3,
        },
        {
          'question': 'The long proboscis of a butterfly is an adaptation for?',
          'options': ['Feeding on nectar deep within flowers', 'Defence', 'Camouflage', 'Flight only'],
          'correct': 0,
        },
        {
          'question': 'Which adaptation helps woodpeckers feed on insects inside tree bark?',
          'options': ['Long neck', 'Strong, chisel-like beak and shock-absorbing skull', 'Flat teeth', 'Webbed feet'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an adaptation seen in high-altitude plants to survive cold and strong winds?',
          'options': ['Large broad leaves', 'Thin bark', 'Tall thin stems', 'Low-growing, cushion-like or mat-forming growth'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why polar bears have small ears compared to desert foxes?',
          'options': ['Random variation with no function', 'To improve hearing only', 'To increase heat loss', 'To reduce heat loss in cold climates'],
          'correct': 3,
        },
        {
          'question': 'An adaptation that increases an organism\'s chances of survival and reproduction is said to increase its?',
          'options': ['Mutation rate', 'Habitat range only', 'Fitness', 'Population size only'],
          'correct': 2,
        },
        {
          'question': 'Natural selection acts on adaptations by favouring individuals that are?',
          'options': ['Fastest only', 'Most colourful only', 'Best suited to their environment, allowing them to survive and reproduce more', 'Largest in size only'],
          'correct': 2,
        },
        {
          'question': 'Vestigial structures, like the human appendix, are considered evidence of?',
          'options': ['Future adaptations', 'Random mutation with immediate benefit', 'Past adaptations that are no longer functional', 'Current adaptive advantage'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes an exaptation, related to adaptation?',
          'options': ['A behavioural trait only', 'A trait that evolved for one function but is co-opted for another', 'A trait with no function at all', 'A trait that always harms the organism'],
          'correct': 1,
        },
        {
          'question': 'Desert plants having a reduced number of stomata mainly helps to?',
          'options': ['Increase photosynthesis', 'Increase water uptake', 'Aid pollination', 'Reduce water loss through transpiration'],
          'correct': 3,
        },
        {
          'question': 'Which adaptation helps some rainforest animals, like tree frogs, move between tall trees?',
          'options': ['Hooves', 'Webbed feet for gliding', 'Thick fur', 'Burrowing claws'],
          'correct': 1,
        },
        {
          'question': 'The countercurrent heat exchange system found in the legs of some Arctic animals (like penguins) helps to?',
          'options': ['Aid digestion', 'Minimise heat loss from extremities', 'Increase blood flow only', 'Increase heat loss'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an adaptation for filter feeding, as seen in baleen whales?',
          'options': ['Sharp teeth', 'Long claws', 'Beak', 'Baleen plates to strain small organisms from water'],
          'correct': 3,
        },
        {
          'question': 'Torpor, a short-term state of reduced metabolic activity, helps animals conserve?',
          'options': ['Water only', 'Colour', 'Reproductive ability', 'Energy during unfavourable conditions'],
          'correct': 3,
        },
        {
          'question': 'Which adaptation helps cacti reduce water loss compared to plants with broad leaves?',
          'options': ['Large leaf surface area', 'Thin leaves', 'Thick waxy cuticle and reduced leaf surface area (spines)', 'No cuticle at all'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the adaptive significance of schooling behaviour in fish?',
          'options': ['Reduces individual risk of predation through group vigilance and confusion effect', 'Only helps with reproduction', 'Has no survival benefit', 'Increases predation risk'],
          'correct': 0,
        },
        {
          'question': 'Adaptations that allow organisms to survive in extreme environments, such as hot springs, are found in organisms called?',
          'options': ['Halophobes', 'Photophobes', 'Extremophiles', 'Mesophiles'],
          'correct': 2,
        },
        {
          'question': 'Which adaptation is commonly seen in animals living in low-light cave environments?',
          'options': ['Reduced or absent eyes and enhanced other senses (touch, smell)', 'Thick fur only', 'Bright colouration and large eyes', 'Wings only'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an adaptation for gas exchange in plants living in waterlogged soils, such as mangroves?',
          'options': ['Aerial roots (pneumatophores) for oxygen uptake', 'Large flowers', 'Deep taproots only', 'Thick bark only'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an adaptation for wind pollination in plants (e.g., grasses)?',
          'options': ['Bright petals and strong scent', 'Large colourful flowers', 'Small, light pollen and feathery stigmas', 'Thick nectar production'],
          'correct': 2,
        },
        {
          'question': 'Xerophytes are plants adapted to survive in?',
          'options': ['Dry, arid habitats', 'Very wet habitats', 'Deep ocean only', 'Saltwater habitats only'],
          'correct': 0,
        },
        {
          'question': 'Hydrophytes are plants adapted to survive in?',
          'options': ['Dry habitats', 'Aquatic (water) habitats', 'Desert habitats', 'Cold mountain habitats only'],
          'correct': 1,
        },
        {
          'question': 'Halophytes are plants adapted to survive in?',
          'options': ['Cave habitats', 'Freshwater habitats', 'Saline (salty) habitats', 'Dry mountain habitats'],
          'correct': 2,
        },
        {
          'question': 'Which adaptation helps hydrophytes like water lilies float on water?',
          'options': ['Air spaces (aerenchyma) in stems and leaves', 'Deep roots', 'Thick bark', 'Heavy waxy leaves'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an adaptation of xerophytes to reduce water loss?',
          'options': ['Shallow roots only', 'Broad thin leaves', 'Sunken stomata and thick cuticle', 'Thin cuticle'],
          'correct': 2,
        },
        {
          'question': 'Migratory locusts changing behaviour and forming swarms is an example of which type of adaptation?',
          'options': ['Structural', 'Chemical only', 'Behavioural', 'None, it is random'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an adaptation seen in animals for thermoregulation through behaviour, such as basking in the sun?',
          'options': ['Structural adaptation only', 'Behavioural adaptation', 'Physiological only', 'Reproductive adaptation'],
          'correct': 1,
        },
        {
          'question': 'Chemical defence, such as producing toxins, is an example of which type of adaptation?',
          'options': ['Behavioural only', 'Reproductive only', 'Structural', 'Physiological/chemical'],
          'correct': 3,
        },
        {
          'question': 'Skunks releasing a foul-smelling spray when threatened is an example of?',
          'options': ['Hibernation', 'Structural adaptation', 'Migration', 'Physiological/chemical defence adaptation'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best explains why deep-sea organisms often lack pigmentation and eyes?',
          'options': ['Absence of light makes colour and sight less necessary for survival', 'Random mutation with no relation to environment', 'They evolved for camouflage in bright light', 'They need bright colours to attract mates'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an adaptation of seeds for dispersal by wind, aiding survival and colonisation?',
          'options': ['Light seeds with wing-like or fluffy structures', 'Heavy, wingless seeds', 'Large fleshy fruits only', 'Sticky seeds only'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an adaptation of seeds for dispersal by animals?',
          'options': ['Buoyant seed coats only', 'Fluffy, wind-borne structures', 'Explosive pods only', 'Fleshy, edible fruit or hooks that stick to fur'],
          'correct': 3,
        },
        {
          'question': 'Coconut seeds are adapted for dispersal by?',
          'options': ['Water (buoyant fibrous husk)', 'Wind', 'Explosive mechanism', 'Animals'],
          'correct': 0,
        },
        {
          'question': 'Which of the following describes an adaptation for surviving fire-prone environments, seen in some plants?',
          'options': ['Deep water storage only', 'No adaptation possible', 'Thick, fire-resistant bark or fire-triggered seed release', 'Thin bark that burns easily'],
          'correct': 2,
        },
        {
          'question': 'Which adaptation helps some animals like the arctic fox change coat colour with the seasons?',
          'options': ['Constant brown fur year-round', 'Constant white fur year-round', 'No colour change at all', 'Seasonal camouflage, white in winter and brown in summer'],
          'correct': 3,
        },
        {
          'question': 'Which of these describes symbiotic adaptation between clownfish and sea anemones?',
          'options': ['Anemones eat the clownfish', 'No interaction occurs', 'Clownfish harm the anemone with no benefit', 'Clownfish are immune to anemone stings and gain protection, while anemones may gain food scraps'],
          'correct': 3,
        },
        {
          'question': 'Which of these best defines commensalism as an ecological adaptation/relationship?',
          'options': ['One species benefits, the other is harmed', 'Both species are harmed', 'Both species benefit', 'One species benefits, the other is unaffected'],
          'correct': 3,
        },
        {
          'question': 'Which of these best defines mutualism as an ecological relationship?',
          'options': ['Both species benefit from the interaction', 'Only one species benefits', 'One species is harmed', 'Neither species benefits'],
          'correct': 0,
        },
        {
          'question': 'Which of these best defines parasitism as an ecological relationship?',
          'options': ['Both species are harmed equally', 'Neither species is affected', 'Both species benefit', 'One species benefits at the expense of the other'],
          'correct': 3,
        },
        {
          'question': 'Adaptations of parasites, such as hooks or suckers for attachment to a host, mainly aid in?',
          'options': ['Camouflage', 'Photosynthesis', 'Attachment and nutrient absorption from the host', 'Flight'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an adaptation for surviving in low-oxygen high-altitude environments, seen in llamas and humans native to mountains?',
          'options': ['No adaptation exists', 'Larger lungs only, no blood changes', 'More red blood cells and haemoglobin with higher oxygen affinity', 'Fewer red blood cells'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains bioluminescence as an adaptation in deep-sea anglerfish?',
          'options': ['It attracts prey and/or mates in the dark ocean depths', 'It helps in photosynthesis', 'It aids digestion only', 'It cools the body'],
          'correct': 0,
        },
        {
          'question': 'Which structural adaptation helps chameleons catch insects from a distance?',
          'options': ['Short, thick tongue', 'Webbed feet', 'Long, sticky, rapidly extendable tongue', 'Sharp teeth only'],
          'correct': 2,
        },
        {
          'question': 'Which adaptation helps kangaroo rats survive in deserts with little water, relying mainly on metabolic water from food?',
          'options': ['Thin fur', 'Frequent drinking behaviour', 'Large ears only', 'Highly efficient kidneys that produce very concentrated urine'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an adaptation for gliding, seen in flying squirrels?',
          'options': ['Feathers', 'Hollow bones only', 'Wings like birds', 'A patagium (skin membrane) between limbs'],
          'correct': 3,
        },
        {
          'question': 'Which term describes the gradual adjustment of an organism to a new environment over its lifetime (not genetic)?',
          'options': ['Speciation', 'Evolution', 'Natural selection', 'Acclimatisation'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is an adaptation of plants to survive grazing by herbivores?',
          'options': ['Shallow roots', 'Thorns, spines, or bitter/toxic chemicals', 'Soft, sweet leaves', 'Bright colourful flowers only'],
          'correct': 1,
        },
        {
          'question': 'Which adaptation allows some insects, like the stick insect, to avoid predators through body shape resembling twigs?',
          'options': ['Cryptic mimicry (camouflage)', 'Migration', 'Aposematism', 'Batesian mimicry'],
          'correct': 0,
        },
      ];
    case 'bio102_u2_1': // Protozoans & Coelenterates
      return [
        {
          'question': 'Protozoans are classified under which kingdom?',
          'options': ['Fungi', 'Animalia', 'Monera', 'Protista'],
          'correct': 3,
        },
        {
          'question': 'Protozoans are generally described as?',
          'options': ['Unicellular eukaryotic heterotrophs', 'Prokaryotic autotrophs', 'Multicellular autotrophs', 'Multicellular heterotrophs'],
          'correct': 0,
        },
        {
          'question': 'Amoeba moves using?',
          'options': ['Pseudopodia', 'Cilia', 'Muscular foot', 'Flagella'],
          'correct': 0,
        },
        {
          'question': 'Paramecium moves using?',
          'options': ['Flagella', 'Wings', 'Pseudopodia', 'Cilia'],
          'correct': 3,
        },
        {
          'question': 'Euglena moves using?',
          'options': ['Cilia', 'Pseudopodia', 'Flagella', 'Legs'],
          'correct': 2,
        },
        {
          'question': 'The process by which Amoeba engulfs food particles is called?',
          'options': ['Osmosis', 'Exocytosis only', 'Diffusion', 'Phagocytosis'],
          'correct': 3,
        },
        {
          'question': 'The contractile vacuole in Amoeba mainly functions in?',
          'options': ['Osmoregulation (removal of excess water)', 'Reproduction', 'Respiration', 'Digestion'],
          'correct': 0,
        },
        {
          'question': 'Paramecium belongs to which protozoan group based on locomotion?',
          'options': ['Sarcodina (Rhizopoda)', 'Ciliophora', 'Mastigophora', 'Sporozoa'],
          'correct': 1,
        },
        {
          'question': 'Amoeba belongs to which protozoan group based on locomotion?',
          'options': ['Mastigophora', 'Sporozoa', 'Sarcodina (Rhizopoda)', 'Ciliophora'],
          'correct': 2,
        },
        {
          'question': 'Euglena belongs to which protozoan group based on locomotion?',
          'options': ['Ciliophora', 'Sarcodina', 'Mastigophora (Flagellata)', 'Sporozoa'],
          'correct': 2,
        },
        {
          'question': 'Plasmodium, the malaria-causing protozoan, belongs to which group?',
          'options': ['Ciliophora', 'Sporozoa', 'Mastigophora', 'Sarcodina'],
          'correct': 1,
        },
        {
          'question': 'Plasmodium is transmitted to humans through the bite of?',
          'options': ['Housefly', 'Female Anopheles mosquito', 'Tsetse fly', 'Tick'],
          'correct': 1,
        },
        {
          'question': 'Entamoeba histolytica causes which human disease?',
          'options': ['Malaria', 'Sleeping sickness', 'Amoebic dysentery', 'Typhoid'],
          'correct': 2,
        },
        {
          'question': 'Trypanosoma, transmitted by the tsetse fly, causes which disease?',
          'options': ['African sleeping sickness', 'Amoebic dysentery', 'Malaria', 'Cholera'],
          'correct': 0,
        },
        {
          'question': 'Euglena is considered unique because it shows characteristics of both?',
          'options': ['Fungi and bacteria', 'Only plants', 'Plants (chlorophyll) and animals (motility)', 'Only animals'],
          'correct': 2,
        },
        {
          'question': 'The reddish eyespot in Euglena is called the?',
          'options': ['Pellicle', 'Flagellum', 'Stigma', 'Nucleus'],
          'correct': 2,
        },
        {
          'question': 'Reproduction in Amoeba typically occurs by?',
          'options': ['Sexual reproduction only', 'Binary fission', 'Budding', 'Spore formation only'],
          'correct': 1,
        },
        {
          'question': 'The life cycle of Plasmodium involves two hosts: humans and?',
          'options': ['Tsetse fly', 'Snail', 'Housefly', 'Female Anopheles mosquito'],
          'correct': 3,
        },
        {
          'question': 'Coelenterates (Cnidarians) are characterised by having how many germ layers?',
          'options': ['Three (triploblastic)', 'One', 'Four', 'Two (diploblastic)'],
          'correct': 3,
        },
        {
          'question': 'The body cavity of coelenterates that also functions in digestion is called the?',
          'options': ['Haemocoel', 'Pseudocoel', 'Gastrovascular cavity', 'Coelom'],
          'correct': 2,
        },
        {
          'question': 'Stinging cells used by coelenterates for defence and capturing prey are called?',
          'options': ['Cnidocytes (nematocysts)', 'Flame cells', 'Nephridia', 'Choanocytes'],
          'correct': 0,
        },
        {
          'question': 'Hydra reproduces asexually mainly by?',
          'options': ['Budding', 'Spore formation', 'Fragmentation only', 'Binary fission'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a coelenterate (Cnidarian)?',
          'options': ['Amoeba', 'Earthworm', 'Hydra', 'Housefly'],
          'correct': 2,
        },
        {
          'question': 'Jellyfish belong to which phylum?',
          'options': ['Platyhelminthes', 'Mollusca', 'Porifera', 'Cnidaria (Coelenterata)'],
          'correct': 3,
        },
        {
          'question': 'Coral polyps secrete a hard structure mainly made of?',
          'options': ['Calcium carbonate', 'Keratin', 'Chitin', 'Silica'],
          'correct': 0,
        },
        {
          'question': 'The two basic body forms seen in Cnidarians are the polyp and the?',
          'options': ['Pupa', 'Medusa', 'Cyst', 'Larva'],
          'correct': 1,
        },
        {
          'question': 'Which body form of Cnidarians is typically sessile (fixed)?',
          'options': ['Both are motile', 'Polyp', 'Medusa', 'Neither'],
          'correct': 1,
        },
        {
          'question': 'Which body form of Cnidarians is typically free-swimming?',
          'options': ['Both are sessile', 'Neither', 'Polyp', 'Medusa'],
          'correct': 3,
        },
        {
          'question': 'Sea anemones exist mainly in which body form?',
          'options': ['Egg only', 'Medusa', 'Polyp', 'Larva only'],
          'correct': 2,
        },
        {
          'question': 'Jellyfish exist mainly in which body form?',
          'options': ['Medusa', 'Larva only', 'Egg only', 'Polyp'],
          'correct': 0,
        },
        {
          'question': 'Coelenterates digest food using which type of digestion?',
          'options': ['Only intracellular', 'No digestion, absorption only', 'Only extracellular', 'Both extracellular and intracellular digestion within the gastrovascular cavity'],
          'correct': 3,
        },
        {
          'question': 'Coelenterates lack which of the following organ systems entirely?',
          'options': ['Tentacles', 'Nervous system (nerve net present, but no organs)', 'Cnidocytes', 'Nerve net'],
          'correct': 1,
        },
        {
          'question': 'The nerve net in coelenterates allows for?',
          'options': ['No response at all', 'Only chemical signalling', 'Complex brain function', 'Simple, diffuse coordination of responses'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is a characteristic feature of Cnidarians?',
          'options': ['Radial symmetry', 'Asymmetry', 'Segmented body', 'Bilateral symmetry'],
          'correct': 0,
        },
        {
          'question': 'Corals are important because they form?',
          'options': ['Coral reefs, which support marine biodiversity', 'Forests', 'Grasslands', 'Deserts'],
          'correct': 0,
        },
        {
          'question': 'Which protozoan is responsible for causing malaria in humans?',
          'options': ['Giardia', 'Plasmodium', 'Entamoeba', 'Trypanosoma'],
          'correct': 1,
        },
        {
          'question': 'Giardia, a flagellated protozoan, causes which condition in humans?',
          'options': ['Amoebic dysentery', 'Giardiasis (intestinal infection)', 'Malaria', 'Sleeping sickness'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes free-living protozoans as opposed to parasitic ones?',
          'options': ['They live inside a host and cause disease', 'They live independently in water or soil without harming a host', 'They cannot reproduce', 'They lack a nucleus'],
          'correct': 1,
        },
        {
          'question': 'The pellicle, a flexible outer covering, is found in which protozoan?',
          'options': ['Plasmodium', 'Amoeba', 'Euglena', 'Paramecium'],
          'correct': 2,
        },
        {
          'question': 'Which of the following protozoan groups is entirely parasitic and lacks locomotory structures in the adult stage?',
          'options': ['Sarcodina', 'Mastigophora', 'Ciliophora', 'Sporozoa'],
          'correct': 3,
        },
        {
          'question': 'Coelenterates obtain food primarily by using their?',
          'options': ['Roots', 'Tentacles armed with cnidocytes', 'Legs', 'Gills'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a freshwater coelenterate commonly studied in biology?',
          'options': ['Sea anemone', 'Coral', 'Jellyfish', 'Hydra'],
          'correct': 3,
        },
        {
          'question': 'The medusa stage of coelenterates is adapted for?',
          'options': ['Photosynthesis', 'Attachment to substrate', 'Swimming freely in water', 'Burrowing'],
          'correct': 2,
        },
        {
          'question': 'Alternation of generations between polyp and medusa forms is seen in the life cycle of many?',
          'options': ['Sponges', 'Cnidarians', 'Protozoans', 'Flatworms'],
          'correct': 1,
        },
        {
          'question': 'Which structure in Paramecium helps expel excess water, similar to Amoeba\'s contractile vacuole?',
          'options': ['Nucleus', 'Cilia', 'Pellicle', 'Contractile vacuole'],
          'correct': 3,
        },
        {
          'question': 'Paramecium has two types of nuclei: a macronucleus and a?',
          'options': ['Micronucleus', 'Perinucleus', 'Mesonucleus', 'Endonucleus'],
          'correct': 0,
        },
        {
          'question': 'Conjugation, a form of sexual reproduction involving exchange of genetic material, is seen in?',
          'options': ['Amoeba', 'Coral', 'Paramecium', 'Hydra'],
          'correct': 2,
        },
        {
          'question': 'Which protozoan disease is spread through contaminated food or water rather than an insect vector?',
          'options': ['Amoebic dysentery', 'Both malaria and sleeping sickness', 'African sleeping sickness', 'Malaria'],
          'correct': 0,
        },
        {
          'question': 'Which of the following coelenterates is colonial, forming large branching structures?',
          'options': ['Coral', 'Sea anemone', 'Jellyfish (solitary forms)', 'Hydra'],
          'correct': 0,
        },
        {
          'question': 'The outer body layer of a coelenterate is called the?',
          'options': ['Mesoderm', 'Ectoderm/epidermis', 'Mesoglea', 'Endoderm/gastrodermis'],
          'correct': 1,
        },
        {
          'question': 'The inner body layer of a coelenterate, lining the gastrovascular cavity, is called the?',
          'options': ['Mesoglea', 'Endoderm (gastrodermis)', 'Mesoderm', 'Ectoderm'],
          'correct': 1,
        },
        {
          'question': 'The jelly-like layer between the two body layers of a coelenterate is called the?',
          'options': ['Coelom', 'Mesoglea', 'Ectoderm', 'Endoderm'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best explains why coelenterates are described as diploblastic?',
          'options': ['They have three true germ layers', 'They have only one cell layer', 'They lack any distinct layers', 'They have two body layers (ectoderm and endoderm) with mesoglea between'],
          'correct': 3,
        },
        {
          'question': 'Sea anemones capture prey mainly using their?',
          'options': ['Gills', 'Roots', 'Tentacles with nematocysts', 'Fins'],
          'correct': 2,
        },
        {
          'question': 'Which of these protozoan groups includes species with both free-living and parasitic members, such as Entamoeba?',
          'options': ['Mastigophora only', 'Sporozoa only', 'Ciliophora only', 'Sarcodina'],
          'correct': 3,
        },
        {
          'question': 'The process of asexual reproduction in Hydra where a small outgrowth develops into a new individual is called?',
          'options': ['Spore formation', 'Budding', 'Fission', 'Regeneration only'],
          'correct': 1,
        },
        {
          'question': 'Regeneration, the ability to regrow lost body parts, is highly developed in which coelenterate?',
          'options': ['Sea anemone only', 'Jellyfish', 'Hydra', 'Coral only'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is a function of cnidocytes (nematocysts) in Cnidarians?',
          'options': ['Digestion', 'Capturing prey and defence by injecting toxins', 'Respiration', 'Excretion'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the symmetry seen in most coelenterates?',
          'options': ['Bilateral symmetry', 'Biradial only', 'Asymmetry', 'Radial symmetry'],
          'correct': 3,
        },
        {
          'question': 'Amoeba reproduces asexually through a process where the parent cell divides into two, called?',
          'options': ['Budding', 'Multiple fission', 'Conjugation', 'Binary fission'],
          'correct': 3,
        },
        {
          'question': 'Which of the following diseases is transmitted by the tsetse fly and caused by a flagellated protozoan?',
          'options': ['Sleeping sickness (Trypanosomiasis)', 'Amoebic dysentery', 'Giardiasis', 'Malaria'],
          'correct': 0,
        },
        {
          'question': 'Which structure allows Euglena to detect light for phototaxis (movement towards light)?',
          'options': ['Pellicle', 'Eyespot (stigma)', 'Nucleus', 'Contractile vacuole'],
          'correct': 1,
        },
        {
          'question': 'Coral bleaching occurs mainly due to the loss of which organism living symbiotically within coral tissue?',
          'options': ['Protozoa', 'Bacteria', 'Zooxanthellae (symbiotic algae)', 'Fungi'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the mutualistic relationship between corals and zooxanthellae?',
          'options': ['Corals eat the zooxanthellae directly with no benefit exchanged', 'There is no relationship between them', 'Zooxanthellae provide corals with food via photosynthesis, and corals provide shelter and nutrients', 'Zooxanthellae harm the coral'],
          'correct': 2,
        },
        {
          'question': 'Which term is used for organisms, like some protozoans, that can survive unfavourable conditions by forming a protective resting stage?',
          'options': ['Spore capsule only', 'Larva', 'Cyst', 'Pupa'],
          'correct': 2,
        },
        {
          'question': 'Which protozoan group reproduces sexually through a spore-forming process, as seen in Plasmodium\'s life cycle?',
          'options': ['Sarcodina', 'Ciliophora', 'Sporozoa', 'Mastigophora'],
          'correct': 2,
        },
        {
          'question': 'Which of these is a key economic/ecological importance of coral reefs?',
          'options': ['They provide habitat for a large diversity of marine organisms', 'They only exist in freshwater', 'They destroy marine biodiversity', 'They have no ecological role'],
          'correct': 0,
        },
        {
          'question': 'The process by which Amoeba digests food after engulfing it in a food vacuole is aided by?',
          'options': ['Digestive enzymes released into the food vacuole', 'Chlorophyll', 'Cnidocytes', 'Photosynthesis'],
          'correct': 0,
        },
        {
          'question': 'Which of these organisms is both photosynthetic and capable of heterotrophic feeding under certain conditions?',
          'options': ['Paramecium', 'Amoeba', 'Euglena', 'Plasmodium'],
          'correct': 2,
        },
        {
          'question': 'Which coelenterate class includes jellyfish, characterised by a dominant medusa stage?',
          'options': ['Scyphozoa', 'Hydrozoa', 'Anthozoa', 'Cubozoa is not a class'],
          'correct': 0,
        },
        {
          'question': 'Which coelenterate class includes sea anemones and corals, lacking a medusa stage entirely?',
          'options': ['Cubozoa', 'Anthozoa', 'Scyphozoa', 'Hydrozoa'],
          'correct': 1,
        },
        {
          'question': 'Which coelenterate class includes Hydra and shows both polyp and medusa stages in some species?',
          'options': ['Anthozoa', 'Scyphozoa', 'None', 'Hydrozoa'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the general habitat of coelenterates?',
          'options': ['Almost entirely terrestrial', 'Entirely underground', 'Entirely parasitic in humans', 'Almost entirely aquatic, mostly marine'],
          'correct': 3,
        },
        {
          'question': 'Which of these protozoan structures is responsible for capturing and ingesting food in Paramecium?',
          'options': ['Nucleus', 'Pellicle', 'Contractile vacuole', 'Oral groove/cytostome (cell mouth)'],
          'correct': 3,
        },
        {
          'question': 'The anal pore (cytopyge) in Paramecium is used for?',
          'options': ['Feeding', 'Respiration', 'Expelling undigested waste', 'Reproduction'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is a characteristic shared by both Amoeba and Paramecium?',
          'options': ['Both have shells', 'Both are unicellular protozoans', 'Both are photosynthetic', 'Both are multicellular'],
          'correct': 1,
        },
        {
          'question': 'Trichocysts, defensive structures found in Paramecium, function mainly to?',
          'options': ['Aid respiration', 'Aid digestion', 'Aid reproduction', 'Deter predators'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes osmoregulation in freshwater protozoans like Amoeba?',
          'options': ['They lose water constantly with no mechanism to regain it', 'They neither gain nor lose water', 'They live only in salty water', 'They gain water constantly and must expel it via contractile vacuole'],
          'correct': 3,
        },
        {
          'question': 'Sporozoans, such as Plasmodium, are characterised by the absence of which locomotory structure in adults?',
          'options': ['Only pseudopodia', 'Cilia only', 'Flagella only', 'Both cilia and flagella (and pseudopodia)'],
          'correct': 3,
        },
        {
          'question': 'Which of these is a vector-borne protozoan disease of major public health concern in tropical regions?',
          'options': ['Common cold', 'Malaria', 'Tetanus', 'Measles'],
          'correct': 1,
        },
        {
          'question': 'Which stage of the Plasmodium life cycle occurs within the human liver and red blood cells?',
          'options': ['Sporozoite stage entering host, then schizogony in liver and blood cells', 'Gametocyte stage only', 'Zygote stage only', 'Oocyst stage only'],
          'correct': 0,
        },
        {
          'question': 'Coelenterates lack a true excretory system; waste is removed mainly by?',
          'options': ['Malpighian tubules', 'Nephridia', 'Kidneys', 'Diffusion across the body surface'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the digestive process within the gastrovascular cavity of a Hydra?',
          'options': ['Both extracellular digestion in the cavity and intracellular digestion within cells', 'Only intracellular digestion occurs', 'Only extracellular digestion occurs', 'No digestion occurs, only absorption'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is true regarding respiration in coelenterates?',
          'options': ['They have lungs', 'They respire by simple diffusion across the body surface', 'They use tracheae', 'They have specialised gills'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes how Hydra captures its prey, such as small aquatic organisms?',
          'options': ['Using tentacles armed with stinging cnidocytes to paralyse and draw in prey', 'By chasing prey using fins', 'By filtering water through gills', 'By absorbing prey through the skin'],
          'correct': 0,
        },
        {
          'question': 'Which of these coelenterate features is an adaptation for a sessile (fixed) lifestyle?',
          'options': ['Streamlined body for swimming', 'Strong jointed legs', 'Wings', 'Attachment disc/basal disc for anchoring to a substrate'],
          'correct': 3,
        },
        {
          'question': 'The \'Portuguese man o\' war\' is an example of a colonial?',
          'options': ['Mollusc', 'Sponge', 'Cnidarian (siphonophore)', 'Flatworm'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the significance of protozoans in freshwater and marine food webs?',
          'options': ['They only live in soil', 'They serve as important primary consumers/decomposers and food for larger organisms', 'They only cause disease', 'They have no ecological role'],
          'correct': 1,
        },
        {
          'question': 'Which of these protozoans is commonly used as a model organism in biology classrooms to study cell structure and movement?',
          'options': ['Plasmodium', 'Amoeba', 'Trypanosoma', 'Giardia'],
          'correct': 1,
        },
        {
          'question': 'Which of these is a symptom commonly associated with malaria caused by Plasmodium infection?',
          'options': ['Joint pain only', 'Skin rash only', 'Recurring fever and chills', 'Persistent cough'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes how amoebic dysentery caused by Entamoeba histolytica is typically transmitted?',
          'options': ['Contaminated food or water containing cysts', 'Airborne droplets', 'Direct skin contact', 'Mosquito bite'],
          'correct': 0,
        },
        {
          'question': 'Which of these is a preventive measure against malaria transmission?',
          'options': ['Use of insecticide-treated mosquito nets', 'Hand washing only', 'Drinking boiled water', 'Vaccination against Entamoeba'],
          'correct': 0,
        },
        {
          'question': 'Which of these is a preventive measure against amoebic dysentery?',
          'options': ['Wearing protective clothing against ticks', 'Avoiding tsetse fly bites', 'Mosquito nets', 'Proper sanitation and safe drinking water'],
          'correct': 3,
        },
        {
          'question': 'Which of the following coelenterates can cause painful stings to humans due to their nematocysts?',
          'options': ['Jellyfish', 'Flatworms', 'Amoeba', 'Sponges'],
          'correct': 0,
        },
        {
          'question': 'Box jellyfish are notable among Cnidarians for having?',
          'options': ['Only a polyp stage', 'No stinging cells', 'A shell for protection', 'Highly potent venom in their nematocysts'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why coral reefs are sensitive to rising ocean temperatures?',
          'options': ['Corals grow faster in warm water with no ill effects', 'Corals expel their symbiotic algae (zooxanthellae) under stress, leading to bleaching', 'Coral reefs are unaffected by temperature', 'Corals are plants, not animals'],
          'correct': 1,
        },
        {
          'question': 'Which of the following statements about protozoans is TRUE?',
          'options': ['Protozoans lack a nucleus', 'Protozoans include both free-living and parasitic forms', 'All protozoans are parasitic and harmful', 'Protozoans are always photosynthetic'],
          'correct': 1,
        },
        {
          'question': 'The cyst stage in protozoans like Entamoeba serves mainly to?',
          'options': ['Aid in locomotion', 'Allow survival and transmission under unfavourable conditions', 'Aid in respiration only', 'Aid in digestion'],
          'correct': 1,
        },
        {
          'question': 'Which coelenterate structure connects the polyp to the substrate it is attached to?',
          'options': ['Mesoglea', 'Mouth', 'Basal (pedal) disc', 'Tentacle'],
          'correct': 2,
        },
        {
          'question': 'Which of these is NOT a typical feature of Phylum Cnidaria?',
          'options': ['Diploblastic body organisation', 'Presence of cnidocytes', 'Radial symmetry', 'Presence of a true coelom'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the general body shape of a typical coelenterate polyp?',
          'options': ['Segmented like an earthworm', 'Flat and leaf-shaped', 'Tube-shaped with a mouth surrounded by tentacles at one end', 'Spherical with no mouth'],
          'correct': 2,
        },
      ];
    case 'bio102_u2_2': // Worms & Nematodes
      return [
        {
          'question': 'Flatworms belong to which phylum?',
          'options': ['Platyhelminthes', 'Nematoda', 'Annelida', 'Mollusca'],
          'correct': 0,
        },
        {
          'question': 'Roundworms belong to which phylum?',
          'options': ['Annelida', 'Cnidaria', 'Nematoda', 'Platyhelminthes'],
          'correct': 2,
        },
        {
          'question': 'Segmented worms, like earthworms, belong to which phylum?',
          'options': ['Mollusca', 'Platyhelminthes', 'Nematoda', 'Annelida'],
          'correct': 3,
        },
        {
          'question': 'Flatworms are characterised by which body cavity condition?',
          'options': ['Acoelomate', 'None have a defined body', 'Pseudocoelomate', 'Coelomate'],
          'correct': 0,
        },
        {
          'question': 'Roundworms (Nematodes) are characterised by which body cavity condition?',
          'options': ['No body cavity at all', 'Coelomate', 'Acoelomate', 'Pseudocoelomate'],
          'correct': 3,
        },
        {
          'question': 'Earthworms are characterised by which body cavity condition?',
          'options': ['Pseudocoelomate', 'Coelomate (true coelom)', 'None', 'Acoelomate'],
          'correct': 1,
        },
        {
          'question': 'Tapeworms belong to which class of flatworms?',
          'options': ['Trematoda', 'Monogenea', 'Turbellaria', 'Cestoda'],
          'correct': 3,
        },
        {
          'question': 'Free-living flatworms like Planaria belong to which class?',
          'options': ['Trematoda', 'Cestoda', 'None', 'Turbellaria'],
          'correct': 3,
        },
        {
          'question': 'Liver flukes belong to which class of flatworms?',
          'options': ['Trematoda', 'Nematoda', 'Cestoda', 'Turbellaria'],
          'correct': 0,
        },
        {
          'question': 'Tapeworms lack a digestive system and absorb nutrients directly through their?',
          'options': ['Gills', 'Body surface (tegument)', 'Roots', 'Mouth'],
          'correct': 1,
        },
        {
          'question': 'The scolex of a tapeworm is used mainly for?',
          'options': ['Respiration', 'Digestion', 'Reproduction only', 'Attachment to the host\'s intestine using hooks/suckers'],
          'correct': 3,
        },
        {
          'question': 'Segments of a tapeworm\'s body, each containing reproductive organs, are called?',
          'options': ['Proglottids', 'Setae', 'Cilia', 'Parapodia'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes flatworms\' excretory structures?',
          'options': ['Kidneys', 'Flame cells (protonephridia)', 'Nephridia', 'Malpighian tubules'],
          'correct': 1,
        },
        {
          'question': 'Planaria reproduces asexually mainly through?',
          'options': ['Fragmentation and regeneration', 'Spore formation', 'Conjugation', 'Budding'],
          'correct': 0,
        },
        {
          'question': 'Which of these is a common human parasite from Phylum Nematoda?',
          'options': ['Planaria', 'Tapeworm', 'Ascaris (roundworm)', 'Liver fluke'],
          'correct': 2,
        },
        {
          'question': 'Ascaris lumbricoides mainly infects which human organ?',
          'options': ['Brain', 'Liver', 'Lungs', 'Small intestine'],
          'correct': 3,
        },
        {
          'question': 'Which of these is a soil-transmitted nematode infection common in areas with poor sanitation?',
          'options': ['Malaria', 'Schistosomiasis', 'Ascariasis', 'Amoebic dysentery'],
          'correct': 2,
        },
        {
          'question': 'Elephantiasis in humans is caused by infection with which type of worm?',
          'options': ['Liver fluke', 'Tapeworm', 'Filarial nematodes (e.g., Wuchereria bancrofti)', 'Planaria'],
          'correct': 2,
        },
        {
          'question': 'Elephantiasis is transmitted to humans through the bite of?',
          'options': ['Housefly', 'Tick', 'Mosquito', 'Tsetse fly'],
          'correct': 2,
        },
        {
          'question': 'Hookworms typically enter the human body through the?',
          'options': ['Ears', 'Skin (often bare feet)', 'Eyes', 'Mouth only'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the body shape of nematodes (roundworms)?',
          'options': ['Flat and leaf-shaped', 'Cylindrical and tapering at both ends', 'Star-shaped', 'Segmented like a chain'],
          'correct': 1,
        },
        {
          'question': 'Nematodes possess a complete digestive system with a mouth and?',
          'options': ['An anus', 'No other opening', 'Two mouths', 'A gastrovascular cavity only'],
          'correct': 0,
        },
        {
          'question': 'Which of these is a key difference between flatworms and roundworms regarding the digestive system?',
          'options': ['Neither has a digestive system', 'Both have identical digestive systems', 'Flatworms have an incomplete digestive system with one opening, roundworms have a complete tube-within-a-tube system', 'Roundworms lack any digestive system'],
          'correct': 2,
        },
        {
          'question': 'Which of these worms is hermaphroditic, possessing both male and female reproductive organs?',
          'options': ['Only Ascaris', 'Only earthworms', 'Most nematodes', 'Most tapeworms and flukes'],
          'correct': 3,
        },
        {
          'question': 'Which of these worms typically has separate sexes (male and female individuals)?',
          'options': ['Most Nematodes (roundworms) like Ascaris', 'Liver flukes', 'Planaria', 'Tapeworms'],
          'correct': 0,
        },
        {
          'question': 'Earthworms belong to which class within Phylum Annelida?',
          'options': ['Turbellaria', 'Oligochaeta', 'Hirudinea', 'Polychaeta'],
          'correct': 1,
        },
        {
          'question': 'Leeches belong to which class within Phylum Annelida?',
          'options': ['Hirudinea', 'Polychaeta', 'Trematoda', 'Oligochaeta'],
          'correct': 0,
        },
        {
          'question': 'Marine bristle worms with parapodia belong to which class of Annelida?',
          'options': ['Polychaeta', 'Oligochaeta', 'Cestoda', 'Hirudinea'],
          'correct': 0,
        },
        {
          'question': 'Segmentation of the earthworm\'s body is externally visible as?',
          'options': ['Plates', 'Scales', 'Rings called annuli/segments', 'Setae only'],
          'correct': 2,
        },
        {
          'question': 'Earthworms move using contraction of muscles along with tiny bristle-like structures called?',
          'options': ['Cilia', 'Flagella', 'Setae (chaetae)', 'Parapodia'],
          'correct': 2,
        },
        {
          'question': 'The clitellum, a swollen band on the earthworm\'s body, functions mainly in?',
          'options': ['Respiration', 'Reproduction (cocoon formation)', 'Excretion', 'Digestion'],
          'correct': 1,
        },
        {
          'question': 'Earthworms are important in agriculture mainly because they?',
          'options': ['Aerate and enrich the soil through burrowing and casting', 'Destroy soil structure', 'Spread disease', 'Eat crop roots'],
          'correct': 0,
        },
        {
          'question': 'Earthworms respire through their?',
          'options': ['Gills', 'Tracheae', 'Lungs', 'Moist skin'],
          'correct': 3,
        },
        {
          'question': 'Leeches are mostly known for being?',
          'options': ['Ectoparasites that feed on blood', 'Herbivorous only', 'Free-living predators only', 'Photosynthetic'],
          'correct': 0,
        },
        {
          'question': 'Leeches secrete an anticoagulant called hirudin, which mainly functions to?',
          'options': ['Digest food', 'Aid respiration', 'Prevent blood from clotting during feeding', 'Clot blood quickly'],
          'correct': 2,
        },
        {
          'question': 'Which of the following worms is used medicinally to reduce blood clotting in certain treatments?',
          'options': ['Planaria', 'Tapeworm', 'Leech', 'Ascaris'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the nervous system in Planaria compared to Cnidarians?',
          'options': ['Planaria has no nervous system', 'Planaria has only a diffuse nerve net like Cnidarians', 'Planaria shows cephalisation with a simple brain and paired nerve cords', 'Planaria has a complex brain like vertebrates'],
          'correct': 2,
        },
        {
          'question': 'Eye spots in Planaria mainly function to detect?',
          'options': ['Light', 'Sound', 'Chemicals only', 'Touch only'],
          'correct': 0,
        },
        {
          'question': 'Which of these worm groups has NO circulatory system, relying instead on diffusion?',
          'options': ['Only roundworms', 'Flatworms', 'Annelids', 'Both flatworms and roundworms'],
          'correct': 3,
        },
        {
          'question': 'Which of these worm groups has a closed circulatory system?',
          'options': ['None of the worm phyla', 'Flatworms', 'Nematodes', 'Annelids (e.g., earthworms)'],
          'correct': 3,
        },
        {
          'question': 'Schistosomiasis (bilharzia) in humans is caused by which type of parasitic worm?',
          'options': ['Blood fluke (Schistosoma, a trematode)', 'Tapeworm', 'Roundworm', 'Leech'],
          'correct': 0,
        },
        {
          'question': 'Schistosomiasis is transmitted to humans through contact with water containing infected?',
          'options': ['Snails (intermediate host releasing larvae)', 'Houseflies', 'Mosquitoes', 'Ticks'],
          'correct': 0,
        },
        {
          'question': 'Which of these describes the life cycle feature common to many parasitic flatworms, involving more than one host?',
          'options': ['Direct life cycle with a single host', 'Indirect life cycle involving intermediate host(s)', 'Only free-living stages', 'No host required'],
          'correct': 1,
        },
        {
          'question': 'The pork tapeworm, Taenia solium, uses which animal as an intermediate host?',
          'options': ['Cow', 'Sheep', 'Dog', 'Pig'],
          'correct': 3,
        },
        {
          'question': 'The beef tapeworm, Taenia saginata, uses which animal as an intermediate host?',
          'options': ['Pig', 'Sheep', 'Cat', 'Cow'],
          'correct': 3,
        },
        {
          'question': 'Which of these is a key adaptation of parasitic worms for survival inside a host?',
          'options': ['Reduced digestive/sensory systems but well-developed reproductive systems', 'Complex sense organs', 'Photosynthetic ability', 'Strong locomotion'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the cuticle covering nematodes?',
          'options': ['A thin, permeable membrane', 'Absent entirely', 'Made of chitin plates', 'A tough, flexible, protective outer covering'],
          'correct': 3,
        },
        {
          'question': 'Trichinella, a nematode causing trichinosis, is typically transmitted through consumption of?',
          'options': ['Airborne spores', 'Contaminated water', 'Mosquito bites', 'Undercooked infected meat (e.g., pork)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes pseudocoelom, as found in nematodes?',
          'options': ['A cavity lined only by ectoderm', 'A body cavity completely lined by mesoderm', 'A body cavity not completely lined by mesoderm, located between mesoderm and endoderm', 'Absence of any body cavity'],
          'correct': 2,
        },
        {
          'question': 'Which of these functions does the pseudocoelom serve in nematodes?',
          'options': ['Only aids reproduction', 'Only aids excretion', 'Acts as a hydrostatic skeleton and aids in nutrient transport', 'Has no function'],
          'correct': 2,
        },
        {
          'question': 'Which of these is a distinguishing feature of earthworms compared to nematodes?',
          'options': ['Presence of a pseudocoelom', 'Absence of a nervous system', 'Presence of true segmentation (metamerism) and a coelom', 'Absence of a digestive tract'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes hermaphroditism as seen in earthworms during reproduction?',
          'options': ['Earthworms cannot reproduce', 'Each earthworm has both male and female reproductive organs and typically cross-fertilises with another earthworm', 'Each earthworm produces only sperm', 'Earthworms reproduce asexually only'],
          'correct': 1,
        },
        {
          'question': 'The cocoon secreted by the clitellum of an earthworm serves mainly to?',
          'options': ['Aid digestion', 'Aid respiration', 'Aid locomotion', 'Protect fertilised eggs during development'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is a free-living (non-parasitic) member of Phylum Nematoda commonly used in genetic research?',
          'options': ['Taenia', 'Ascaris', 'Fasciola', 'Caenorhabditis elegans'],
          'correct': 3,
        },
        {
          'question': 'Which of the following diseases in plants can be caused by parasitic nematodes affecting roots?',
          'options': ['Root-knot disease', 'Rust disease', 'Powdery mildew', 'Malaria in plants'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the excretory system of nematodes?',
          'options': ['Nephridia', 'Flame cells', 'Simple excretory canals/glands, lacking flame cells', 'Malpighian tubules'],
          'correct': 2,
        },
        {
          'question': 'Which of the following worm phyla lacks any circulatory system and relies entirely on diffusion for gas and nutrient exchange?',
          'options': ['Platyhelminthes', 'Mollusca', 'Both Annelida and Nematoda', 'Annelida'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes why flatworms have a flattened body shape?',
          'options': ['To aid flight', 'To maximise surface area for diffusion of gases and nutrients in the absence of a circulatory system', 'To increase speed', 'To aid burrowing only'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is an intermediate host commonly involved in the life cycle of the liver fluke (Fasciola hepatica)?',
          'options': ['Freshwater snail', 'Housefly', 'Mosquito', 'Tick'],
          'correct': 0,
        },
        {
          'question': 'Which of these worm-related human diseases is prevented mainly through proper sanitation and hygiene rather than vector control?',
          'options': ['Elephantiasis', 'Malaria', 'Ascariasis (roundworm infection)', 'Schistosomiasis'],
          'correct': 2,
        },
        {
          'question': 'The typical symptoms of intestinal worm infections (such as Ascariasis) in humans include?',
          'options': ['Hair loss only', 'Abdominal pain, malnutrition, and intestinal blockage', 'Only skin rash', 'Only fever with no digestive symptoms'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is TRUE regarding the reproductive capacity of parasitic worms like Ascaris?',
          'options': ['They produce very few eggs', 'They cannot reproduce inside a host', 'They reproduce only asexually', 'They typically produce a very large number of eggs to increase chances of transmission'],
          'correct': 3,
        },
        {
          'question': 'Which of these is a key method for controlling nematode and flatworm infections in humans?',
          'options': ['Vaccination only', 'Insecticide-treated bed nets only', 'Antibiotics only', 'Deworming medication and improved sanitation'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the term \'definitive host\' in a parasite\'s life cycle?',
          'options': ['The host in which the parasite reaches sexual maturity and reproduces', 'An intermediate host only', 'A host with no role in the life cycle', 'A host that is always a vector'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the term \'intermediate host\' in a parasite\'s life cycle?',
          'options': ['A host not involved at all', 'The host in which the parasite reaches sexual maturity', 'The main reproducing host', 'A host in which the parasite undergoes larval development before reaching the definitive host'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the body wall musculature of nematodes?',
          'options': ['Only circular muscles', 'Circular and longitudinal muscles like annelids', 'No muscles at all', 'Only longitudinal muscles, giving a characteristic whip-like movement'],
          'correct': 3,
        },
        {
          'question': 'The whip-like thrashing movement of nematodes is due to?',
          'options': ['Cilia', 'Setae', 'Longitudinal muscles acting against the pseudocoelom\'s hydrostatic pressure', 'Parapodia'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes reproduction in tapeworms across their many proglottids?',
          'options': ['Each mature proglottid can produce thousands of fertilised eggs', 'Each proglottid is asexual only', 'Only the scolex reproduces', 'Proglottids cannot reproduce'],
          'correct': 0,
        },
        {
          'question': 'Gravid (mature, egg-filled) proglottids of a tapeworm are eventually?',
          'options': ['Digested internally', 'Shed from the worm\'s body and passed out in host faeces', 'Reabsorbed by the host', 'Converted into new worms directly'],
          'correct': 1,
        },
        {
          'question': 'Which of these describes the main danger of untreated elephantiasis (filariasis) in humans?',
          'options': ['Mild skin rash only', 'Loss of hearing', 'Loss of vision only', 'Severe swelling of limbs due to blocked lymphatic vessels'],
          'correct': 3,
        },
        {
          'question': 'Which of these worm phyla members are commonly called \'flukes\' when parasitic and flat/leaf-shaped?',
          'options': ['Annelida', 'Nematoda', 'Trematoda (class within Platyhelminthes)', 'Cestoda'],
          'correct': 2,
        },
        {
          'question': 'Which of these best distinguishes Cestoda (tapeworms) from Trematoda (flukes) structurally?',
          'options': ['Both have identical body shapes', 'Tapeworms have a segmented, ribbon-like body of proglottids; flukes have an unsegmented leaf-like body', 'Flukes are segmented, tapeworms are not', 'Neither has any distinct shape'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why tapeworms have no digestive system?',
          'options': ['They digest food externally before absorption', 'They photosynthesize', 'They absorb pre-digested nutrients directly through their body surface from the host\'s gut', 'They do not need nutrients'],
          'correct': 2,
        },
        {
          'question': 'Which of these is a hazard associated with eating undercooked pork infected with tapeworm larvae (cysticerci)?',
          'options': ['Risk of developing an adult tapeworm infection (taeniasis) in the intestine', 'Risk of malaria', 'No risk at all', 'Risk of elephantiasis'],
          'correct': 0,
        },
        {
          'question': 'Which of the following worm phyla is characterised by having a true coelom that develops from mesoderm and functions as a hydrostatic skeleton?',
          'options': ['Nematoda', 'Platyhelminthes', 'None of the worm phyla', 'Annelida'],
          'correct': 3,
        },
        {
          'question': 'Setae in earthworms primarily assist with?',
          'options': ['Vision', 'Digestion', 'Reproduction', 'Anchoring the body segments during locomotion (burrowing)'],
          'correct': 3,
        },
        {
          'question': 'Which of the following organs in the earthworm functions similarly to a heart, helping pump blood?',
          'options': ['Crop', 'Aortic arches (pseudohearts)', 'Nephridia', 'Gizzard'],
          'correct': 1,
        },
        {
          'question': 'The gizzard in an earthworm\'s digestive system functions mainly to?',
          'options': ['Store food temporarily', 'Excrete waste', 'Absorb nutrients', 'Grind ingested soil and food particles'],
          'correct': 3,
        },
        {
          'question': 'The crop in an earthworm\'s digestive system functions mainly to?',
          'options': ['Produce cocoons', 'Temporarily store food before it moves to the gizzard', 'Absorb nutrients directly', 'Grind food'],
          'correct': 1,
        },
        {
          'question': 'Earthworms are hermaphroditic but typically avoid self-fertilisation by?',
          'options': ['Having only male organs active at a time', 'Not reproducing at all', 'Mutual cross-fertilisation between two individuals during mating', 'Reproducing asexually only'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the ecological importance of earthworms as \'ecosystem engineers\'?',
          'options': ['They only live in water', 'They destroy soil fertility', 'They have no impact on soil', 'They improve soil aeration, drainage, and nutrient cycling through burrowing and casting'],
          'correct': 3,
        },
        {
          'question': 'Vermicomposting, a method of producing compost, relies mainly on the activity of?',
          'options': ['Earthworms', 'Tapeworms', 'Roundworms', 'Leeches'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the excretory structures called nephridia found in each segment of an earthworm?',
          'options': ['They produce eggs', 'They filter coelomic fluid and expel waste through nephridiopores', 'They are used for feeding', 'They aid in respiration only'],
          'correct': 1,
        },
        {
          'question': 'Which of the following worm phyla members typically show the most complex organ-system level body organisation?',
          'options': ['Platyhelminthes', 'None show organ-system organisation', 'Nematoda', 'Annelida'],
          'correct': 3,
        },
        {
          'question': 'Which of the following statements about Planaria\'s regenerative ability is TRUE?',
          'options': ['It can regenerate a whole new organism from small body fragments', 'It can only regenerate its head', 'It cannot regenerate any lost parts', 'It dies if cut into pieces'],
          'correct': 0,
        },
        {
          'question': 'Which of these worm-related infections is most directly linked to inadequate footwear and contact with contaminated soil?',
          'options': ['Schistosomiasis', 'Elephantiasis', 'Hookworm infection', 'Ascariasis'],
          'correct': 2,
        },
        {
          'question': 'The larval form of many trematodes (flukes) that develops and multiplies within a snail host is called a?',
          'options': ['Proglottid', 'Cercaria/sporocyst stage', 'Cocoon', 'Scolex'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes why nematode infections are often described as \'soil-transmitted helminths\'?',
          'options': ['They are transmitted only through mosquito bites', 'They live only in water', 'They cannot survive outside a host at all', 'Their eggs or larvae develop in soil before infecting a human host'],
          'correct': 3,
        },
        {
          'question': 'Which of these worm phyla members generally lack any specialised respiratory organs, relying on diffusion?',
          'options': ['Platyhelminthes and Nematoda', 'Annelida only', 'Only Nematoda', 'None, all have gills'],
          'correct': 0,
        },
        {
          'question': 'Which of these describes a key difference between free-living flatworms (like Planaria) and parasitic flatworms (like tapeworms)?',
          'options': ['Parasitic forms have better eyesight', 'Free-living forms have well-developed sensory organs; parasitic forms have reduced sensory organs but enhanced reproductive structures', 'Both are identical in structure', 'Free-living forms lack a nervous system'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies the phylum of the guinea worm (Dracunculus medinensis), a parasite transmitted through contaminated drinking water?',
          'options': ['Mollusca', 'Annelida', 'Platyhelminthes', 'Nematoda'],
          'correct': 3,
        },
        {
          'question': 'Which of these is a common method of preventing guinea worm disease?',
          'options': ['Vaccination', 'Filtering drinking water to remove infected water fleas', 'Deworming tablets only', 'Mosquito nets'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best explains why roundworm (Ascaris) eggs are highly resistant and can survive in soil for long periods?',
          'options': ['They have a thick, protective outer shell', 'They are kept warm by the host', 'They cannot survive outside a host', 'They have no shell at all'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is a correct pairing of parasite and the human organ it primarily affects?',
          'options': ['Schistosoma - eyes', 'Ascaris - small intestine', 'Wuchereria - stomach', 'Taenia - lungs'],
          'correct': 1,
        },
        {
          'question': 'Which of these worm phyla shows the greatest range of habitats, from free-living aquatic/terrestrial forms to internal parasites?',
          'options': ['Both Nematoda and Platyhelminthes', 'Nematoda', 'Platyhelminthes', 'Only Annelida'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the structure called \'suckers\' found in tapeworms and some flukes?',
          'options': ['Used for digestion', 'Used for attachment to host tissue', 'Used for excretion', 'Used for reproduction'],
          'correct': 1,
        },
        {
          'question': 'Which of the following worm groups is entirely free-living with no parasitic members at all?',
          'options': ['Trematoda', 'Nematoda', 'Platyhelminthes', 'Oligochaeta (earthworms) within Annelida'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes bilateral symmetry as seen in all three worm phyla (flatworms, roundworms, segmented worms)?',
          'options': ['The body shows radial symmetry instead', 'The body has no plane of symmetry', 'The body can be divided into two similar halves only through one plane, aiding directional movement', 'Symmetry is absent in worms'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the term \'vector\' in the context of parasitic worm transmission, such as mosquitoes transmitting filarial worms?',
          'options': ['A type of muscle tissue', 'The final host where reproduction occurs', 'An organism that carries and transmits a parasite from one host to another', 'A worm\'s egg stage'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is TRUE about the size range of parasitic worms affecting humans?',
          'options': ['They are always microscopic and invisible without a microscope', 'They are always smaller than one millimetre', 'They range from microscopic larvae to tapeworms several metres long', 'They are always larger than one metre'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why good personal hygiene, such as handwashing, helps prevent many worm infections?',
          'options': ['It reduces ingestion of worm eggs or larvae from contaminated hands, food, or surfaces', 'It has no effect on worm transmission', 'It only prevents viral infections', 'It kills mosquitoes'],
          'correct': 0,
        },
      ];
    case 'bio102_u2_3': // Arthropods & Molluscs
      return [
        {
          'question': 'Arthropods are the most diverse animal phylum, characterised mainly by?',
          'options': ['Absence of segmentation', 'Jointed appendages and a chitinous exoskeleton', 'Radial symmetry', 'Soft bodies and no legs'],
          'correct': 1,
        },
        {
          'question': 'The exoskeleton of arthropods is primarily made of?',
          'options': ['Calcium carbonate only', 'Cellulose', 'Keratin', 'Chitin'],
          'correct': 3,
        },
        {
          'question': 'Which class of Arthropoda includes insects?',
          'options': ['Chilopoda', 'Insecta', 'Crustacea', 'Arachnida'],
          'correct': 1,
        },
        {
          'question': 'Which class of Arthropoda includes spiders and scorpions?',
          'options': ['Arachnida', 'Diplopoda', 'Crustacea', 'Insecta'],
          'correct': 0,
        },
        {
          'question': 'Which class of Arthropoda includes crabs, shrimp, and lobsters?',
          'options': ['Chilopoda', 'Insecta', 'Arachnida', 'Crustacea'],
          'correct': 3,
        },
        {
          'question': 'Which class of Arthropoda includes centipedes?',
          'options': ['Chilopoda', 'Insecta', 'Arachnida', 'Diplopoda'],
          'correct': 0,
        },
        {
          'question': 'Which class of Arthropoda includes millipedes?',
          'options': ['Insecta', 'Crustacea', 'Diplopoda', 'Chilopoda'],
          'correct': 2,
        },
        {
          'question': 'Insects typically have how many pairs of legs?',
          'options': ['Two', 'Five', 'Four', 'Three'],
          'correct': 3,
        },
        {
          'question': 'Spiders typically have how many pairs of legs?',
          'options': ['Four', 'Two', 'Five', 'Three'],
          'correct': 0,
        },
        {
          'question': 'Centipedes have how many legs per body segment?',
          'options': ['Three pairs', 'Two pairs', 'No legs', 'One pair'],
          'correct': 3,
        },
        {
          'question': 'Millipedes have how many legs per body segment?',
          'options': ['One pair', 'Two pairs', 'Three pairs', 'No legs'],
          'correct': 1,
        },
        {
          'question': 'The body of an insect is divided into which regions?',
          'options': ['Head and abdomen only', 'Head, tail, and body', 'Head, thorax, and abdomen', 'Cephalothorax and abdomen'],
          'correct': 2,
        },
        {
          'question': 'The body of a spider (Arachnida) is divided into which regions?',
          'options': ['Head and abdomen only', 'Head, thorax, abdomen', 'Cephalothorax and abdomen', 'No distinct regions'],
          'correct': 2,
        },
        {
          'question': 'Insects typically breathe using?',
          'options': ['Gills', 'Skin only', 'Tracheae (a system of tubes)', 'Lungs'],
          'correct': 2,
        },
        {
          'question': 'Crustaceans typically breathe using?',
          'options': ['Gills', 'Lungs', 'Skin only', 'Tracheae'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is the correct term for the process of shedding the exoskeleton for growth in arthropods?',
          'options': ['Torsion', 'Ecdysis (moulting)', 'Metamorphosis', 'Regeneration'],
          'correct': 1,
        },
        {
          'question': 'Which class of arthropods has antennae in two pairs?',
          'options': ['Arachnida', 'Crustacea', 'Insecta', 'Chilopoda'],
          'correct': 1,
        },
        {
          'question': 'Which class of arthropods completely lacks antennae?',
          'options': ['Insecta', 'Diplopoda', 'Arachnida', 'Crustacea'],
          'correct': 2,
        },
        {
          'question': 'The compound eye, made up of many individual units called ommatidia, is characteristic of many?',
          'options': ['Molluscs', 'Arachnids', 'Annelids', 'Insects and crustaceans'],
          'correct': 3,
        },
        {
          'question': 'Which of the following insects undergoes complete metamorphosis (egg-larva-pupa-adult)?',
          'options': ['Grasshopper', 'Dragonfly', 'Cockroach', 'Butterfly'],
          'correct': 3,
        },
        {
          'question': 'Which of the following insects undergoes incomplete metamorphosis (egg-nymph-adult)?',
          'options': ['Butterfly', 'Grasshopper', 'Housefly', 'Beetle'],
          'correct': 1,
        },
        {
          'question': 'The pupal stage in complete metamorphosis is a period mainly of?',
          'options': ['Active feeding', 'Migration', 'Transformation/reorganisation of body structures', 'Reproduction'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an example of a beneficial insect due to its role in pollination?',
          'options': ['Cockroach', 'Mosquito', 'Honeybee', 'Housefly'],
          'correct': 2,
        },
        {
          'question': 'Which of these insects is a major agricultural pest that damages crops?',
          'options': ['Honeybee', 'Dragonfly', 'Locust', 'Ladybird beetle'],
          'correct': 2,
        },
        {
          'question': 'Malaria and dengue are transmitted to humans by which arthropod vector?',
          'options': ['Housefly', 'Mosquito', 'Ant', 'Honeybee'],
          'correct': 1,
        },
        {
          'question': 'Molluscs are generally characterised by having a soft body often protected by a?',
          'options': ['Feathers', 'Calcareous shell', 'Exoskeleton of chitin', 'Bony skeleton'],
          'correct': 1,
        },
        {
          'question': 'The muscular structure used by molluscs for movement is called the?',
          'options': ['Radula', 'Siphon', 'Mantle', 'Foot'],
          'correct': 3,
        },
        {
          'question': 'The layer of tissue in molluscs that secretes the shell is called the?',
          'options': ['Foot', 'Mantle', 'Visceral mass', 'Radula'],
          'correct': 1,
        },
        {
          'question': 'The rasping, tongue-like structure used by many molluscs for feeding is called the?',
          'options': ['Siphon', 'Mantle', 'Radula', 'Foot'],
          'correct': 2,
        },
        {
          'question': 'Which class of Mollusca includes snails and slugs?',
          'options': ['Polyplacophora', 'Cephalopoda', 'Gastropoda', 'Bivalvia'],
          'correct': 2,
        },
        {
          'question': 'Which class of Mollusca includes clams, oysters, and mussels, typically with two shells?',
          'options': ['Scaphopoda', 'Cephalopoda', 'Bivalvia', 'Gastropoda'],
          'correct': 2,
        },
        {
          'question': 'Which class of Mollusca includes octopuses, squids, and cuttlefish?',
          'options': ['Bivalvia', 'Cephalopoda', 'Polyplacophora', 'Gastropoda'],
          'correct': 1,
        },
        {
          'question': 'Which class of Mollusca includes chitons, characterised by a shell made of eight plates?',
          'options': ['Cephalopoda', 'Gastropoda', 'Polyplacophora', 'Bivalvia'],
          'correct': 2,
        },
        {
          'question': 'Cephalopods are noted among molluscs for having a highly developed?',
          'options': ['Nervous system and complex behaviour', 'Shell only', 'Exoskeleton like insects', 'Absence of a foot'],
          'correct': 0,
        },
        {
          'question': 'Octopuses lack an external shell but may retain a reduced internal structure; this is an adaptation mainly for?',
          'options': ['Greater flexibility and speed in movement', 'Photosynthesis', 'Camouflage only', 'Increased buoyancy only'],
          'correct': 0,
        },
        {
          'question': 'Bivalves typically feed by a method known as?',
          'options': ['Filter feeding', 'Predation', 'Parasitism', 'Photosynthesis'],
          'correct': 0,
        },
        {
          'question': 'The siphon in bivalve molluscs like clams functions mainly to?',
          'options': ['Draw water in and out for feeding and respiration', 'Aid in excretion of solid waste only', 'Aid in digestion of solid food', 'Aid in reproduction'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes torsion, a developmental process occurring in gastropods?',
          'options': ['Loss of the shell', 'Development of jointed legs', 'A straightening of the body', 'A 180-degree twisting of the visceral mass during development'],
          'correct': 3,
        },
        {
          'question': 'Pearls are formed within which class of molluscs, typically oysters?',
          'options': ['Cephalopoda', 'Polyplacophora', 'Bivalvia', 'Gastropoda'],
          'correct': 2,
        },
        {
          'question': 'Pearls form when a bivalve mollusc deposits layers of a substance called ___ around an irritant.',
          'options': ['Chitin', 'Nacre (mother-of-pearl)', 'Cellulose', 'Keratin'],
          'correct': 1,
        },
        {
          'question': 'Which of the following molluscs is entirely land-dwelling (terrestrial)?',
          'options': ['Squid', 'Garden snail', 'Octopus', 'Clam'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes an open circulatory system, found in most molluscs and arthropods?',
          'options': ['There is no circulatory system', 'Blood flows only through gills', 'Blood is pumped into open spaces called sinuses/haemocoel that bathe the tissues directly', 'Blood flows entirely within closed vessels'],
          'correct': 2,
        },
        {
          'question': 'Which molluscan class shows the most advanced (closed) circulatory system, an exception among molluscs?',
          'options': ['Bivalvia', 'Gastropoda', 'Cephalopoda', 'Polyplacophora'],
          'correct': 2,
        },
        {
          'question': 'Which of the following is a key economic importance of molluscs to humans?',
          'options': ['No economic importance', 'Source of food (e.g., oysters, squid) and pearls', 'Only as pests', 'Only as disease vectors'],
          'correct': 1,
        },
        {
          'question': 'Which of these arthropods is an important decomposer, helping break down organic matter?',
          'options': ['Only honeybees', 'Only butterflies', 'Only mosquitoes', 'Housefly maggots and some beetles'],
          'correct': 3,
        },
        {
          'question': 'Which class of arthropods includes horseshoe crabs, which are actually more closely related to arachnids?',
          'options': ['Merostomata (related to Arachnida)', 'Crustacea', 'Insecta', 'Diplopoda'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the jointed appendages found throughout the arthropod body?',
          'options': ['They include legs, antennae, and mouthparts, adapted for various functions', 'They are limited to legs only', 'They serve no functional purpose', 'They are found only in insects'],
          'correct': 0,
        },
        {
          'question': 'Which of the following statements about arthropod exoskeletons is TRUE?',
          'options': ['They dissolve and reform daily', 'They grow continuously with the animal', 'They must be periodically shed (moulted) to allow growth', 'They are made of bone'],
          'correct': 2,
        },
        {
          'question': 'Which of these is a disadvantage of having a rigid exoskeleton in arthropods?',
          'options': ['Prevents movement entirely', 'Limits continuous growth, requiring periodic moulting', 'Provides no support', 'Excellent protection'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies the main respiratory organ used by spiders?',
          'options': ['Skin only', 'Gills', 'Tracheae only', 'Book lungs (and sometimes tracheae)'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly identifies the venom-delivering structures in spiders?',
          'options': ['Chelicerae (fangs)', 'Mandibles', 'Stinger', 'Antennae'],
          'correct': 0,
        },
        {
          'question': 'Scorpions use which structure to deliver venom to prey or for defence?',
          'options': ['A stinger at the tip of the tail (telson)', 'Mandibles', 'Antennae', 'Chelicerae'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is an adaptation of crustaceans like crabs for life in marine/aquatic environments?',
          'options': ['Lungs', 'Gills for extracting oxygen from water', 'Skin breathing only', 'Tracheae for breathing air'],
          'correct': 1,
        },
        {
          'question': 'The exoskeleton of crustaceans, unlike insects, is often reinforced with?',
          'options': ['Keratin', 'Silica', 'Calcium carbonate', 'Cellulose'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the compound eyes found in many insects and crustaceans?',
          'options': ['Many individual visual units (ommatidia) providing a wide field of view', 'A single lens providing sharp images', 'No light-sensing ability', 'Only useful in darkness'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an adaptation of many insects for flight?',
          'options': ['Absence of legs', 'Gills for respiration', 'Lightweight exoskeleton and wings powered by flight muscles', 'Heavy, solid exoskeleton'],
          'correct': 2,
        },
        {
          'question': 'Which of the following correctly describes the life cycle stage called a \'nymph\', seen in insects with incomplete metamorphosis?',
          'options': ['The final adult stage', 'A stage found only in complete metamorphosis', 'A young form resembling a small adult, lacking fully developed wings/reproductive organs', 'A non-feeding resting stage'],
          'correct': 2,
        },
        {
          'question': 'Which of these is a key difference between a caterpillar (larva) and an adult butterfly (imago)?',
          'options': ['They look and feed identically', 'The caterpillar is a feeding larval stage while the adult is reproductive and often feeds differently', 'The caterpillar is the reproductive stage', 'There is no difference'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the ecological importance of bees as pollinators?',
          'options': ['They transfer pollen between flowers, aiding fertilisation and fruit/seed production', 'They destroy flowers', 'They only eat plants, harming them', 'They have no impact on plant reproduction'],
          'correct': 0,
        },
        {
          'question': 'Which of the following arthropods is known for building complex social colonies with a queen, workers, and sometimes soldiers?',
          'options': ['Ants, bees, and termites', 'Spiders', 'Beetles', 'Butterflies'],
          'correct': 0,
        },
        {
          'question': 'Which of the following molluscs uses jet propulsion (expelling water forcefully) as a means of rapid movement?',
          'options': ['Chiton', 'Squid', 'Clam', 'Snail'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the radula\'s function in a predatory gastropod, like a whelk?',
          'options': ['Rasping/drilling through prey shells or tissue to feed', 'Filtering plankton from water', 'Producing venom', 'Producing a shell'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why cephalopods like octopuses are considered highly intelligent invertebrates?',
          'options': ['They possess a large, complex brain and demonstrate problem-solving behaviour', 'They have simple nerve nets only', 'They lack a nervous system', 'They are plants'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies chromatophores, structures found in cephalopod skin?',
          'options': ['Structures for digestion', 'Structures for hearing', 'Pigment-containing cells that allow rapid colour change for camouflage/communication', 'Structures for excretion'],
          'correct': 2,
        },
        {
          'question': 'Which of these describes the general habitat range of Phylum Mollusca?',
          'options': ['Only freshwater', 'Only marine', 'Marine, freshwater, and terrestrial habitats', 'Only terrestrial'],
          'correct': 2,
        },
        {
          'question': 'Which of these describes the general habitat range of Phylum Arthropoda?',
          'options': ['Nearly every habitat on Earth, aquatic and terrestrial', 'Only underground', 'Only aquatic', 'Only terrestrial'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best explains why arthropods are considered the most successful animal phylum by number of species?',
          'options': ['Limited habitat range', 'Absence of segmentation', 'Lack of an exoskeleton', 'Jointed appendages, adaptable exoskeleton, and diverse feeding/reproductive strategies'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly matches a mollusc class with an example?',
          'options': ['Gastropoda - Octopus', 'Cephalopoda - Snail', 'Bivalvia - Oyster', 'Polyplacophora - Clam'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly matches an arthropod class with an example?',
          'options': ['Arachnida - Housefly', 'Insecta - Honeybee', 'Chilopoda - Crab', 'Crustacea - Spider'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the function of the mantle cavity in molluscs?',
          'options': ['Is used for locomotion only', 'Houses gills and is involved in respiration and often excretion/reproduction', 'Houses only the brain', 'Serves no function'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best explains why locusts swarming can be economically devastating?',
          'options': ['Large swarms consume enormous quantities of crops, causing famine and economic loss', 'They pollinate crops', 'They are harmless to plants', 'They only eat other insects'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of biological pest control involving arthropods?',
          'options': ['Using ladybird beetles to control aphid populations', 'Using locusts to fertilise soil', 'Using houseflies to pollinate crops', 'Using mosquitoes to control malaria'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the term \'exuvia\', related to arthropod moulting?',
          'options': ['The digestive organ', 'The shed/cast-off old exoskeleton', 'The new exoskeleton', 'The reproductive organ'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why many arthropods, such as beetles, have hardened forewings called elytra?',
          'options': ['To aid in swimming only', 'To protect the delicate hindwings and body when not flying', 'To aid digestion', 'To produce sound only'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes stridulation, a behaviour seen in some insects like crickets?',
          'options': ['Producing sound by rubbing body parts together, often for mating calls', 'A method of respiration', 'A type of moulting', 'A method of feeding'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the function of Malpighian tubules in insects?',
          'options': ['Reproduction', 'Digestion of food', 'Excretion of nitrogenous waste', 'Respiration'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the process by which insects excrete nitrogenous waste as a solid (uric acid) to conserve water?',
          'options': ['Only seen in aquatic insects', 'An adaptation for aquatic life', 'An adaptation for terrestrial life, reducing water loss', 'An adaptation with no ecological benefit'],
          'correct': 2,
        },
        {
          'question': 'Which of the following arthropod groups is almost entirely aquatic and breathes via gills, in contrast to insects?',
          'options': ['Arachnida', 'Chilopoda', 'Crustacea', 'Insecta'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies book lungs as a respiratory adaptation?',
          'options': ['Found in insects only', 'Found in crustaceans only', 'Found in molluscs only', 'Found in many arachnids, consisting of stacked, leaf-like plates for gas exchange'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the advantage of a hard exoskeleton for terrestrial arthropods, such as insects?',
          'options': ['Increases water loss', 'Prevents water loss and provides structural support and protection', 'Has no protective function', 'Prevents movement'],
          'correct': 1,
        },
        {
          'question': 'Which of the following correctly describes the difference between chelicerae and mandibles as mouthpart types?',
          'options': ['Chelicerae are found only in insects', 'Chelicerae are pincer/fang-like mouthparts of arachnids; mandibles are jaw-like mouthparts of insects and crustaceans', 'Both terms refer to the same structure', 'Mandibles are found only in molluscs'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the reproductive strategy of many marine molluscs and crustaceans, releasing vast numbers of eggs into open water?',
          'options': ['Live birth only', 'Direct development with parental care always', 'No reproduction in water', 'Broadcast spawning with external fertilisation'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the veliger, a larval stage found in many molluscs?',
          'options': ['A resting cyst stage', 'An adult stage', 'A free-swimming larval stage that eventually settles and metamorphoses into the adult form', 'A form found only in cephalopods'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why cephalopods, unlike other molluscs, mostly lack an external shell?',
          'options': ['They never had a shell in their evolutionary history', 'It evolved into an adaptation for greater speed and manoeuvrability in predation/escape', 'Their shells dissolved due to ocean acidity only', 'They are not true molluscs'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is a correct example of a terrestrial arthropod adaptation for water conservation?',
          'options': ['Constant sweating', 'Thin permeable cuticle', 'Waxy, waterproof outer cuticle layer', 'Gills for breathing air'],
          'correct': 2,
        },
        {
          'question': 'Which of these describes the primary role of antennae in insects and crustaceans?',
          'options': ['Sensory reception, including touch, smell, and sometimes taste', 'Reproduction only', 'Vision only', 'Locomotion only'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the term \'exoskeleton moulting cycle\' and its relation to growth stages called instars in insects?',
          'options': ['Each stage between moults is called an instar, allowing stepwise growth', 'Insects grow continuously without moulting', 'Instars refer only to adult insects', 'Moulting occurs only once in an insect\'s life'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains the ecological role of crustaceans like krill in marine food webs?',
          'options': ['They are decomposers only', 'They have no ecological role', 'They serve as a critical food source for many larger marine animals, including whales', 'They are apex predators only'],
          'correct': 2,
        },
        {
          'question': 'Which of the following correctly identifies barnacles as belonging to which arthropod class, despite their shell-like appearance resembling molluscs?',
          'options': ['Mollusca (they are actually molluscs)', 'Arachnida', 'Insecta', 'Crustacea'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the sessile (attached) adult lifestyle of barnacles?',
          'options': ['They burrow underground', 'They attach permanently to a substrate and filter-feed using modified legs (cirri)', 'They live as internal parasites', 'They swim freely as adults'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best explains why insects are considered ecologically and economically significant to humans?',
          'options': ['They have no significant role', 'They serve roles in pollination, decomposition, pest control, and as agricultural pests/disease vectors', 'Only as food sources', 'Only as pests'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies the term \'apiculture\'?',
          'options': ['The keeping of honeybees for honey and pollination', 'The study/farming of spiders', 'The study of molluscs', 'The farming of crustaceans'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies \'sericulture\' as an economically important insect-related activity?',
          'options': ['Fishing for crustaceans', 'Snail farming', 'Beekeeping', 'Silk production using silkworms'],
          'correct': 3,
        },
        {
          'question': 'Which of the following molluscs is a significant agricultural pest, feeding on crops and garden plants?',
          'options': ['Chiton', 'Slugs and snails', 'Octopus', 'Squid'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly explains why molluscs like oysters are considered good bioindicators of water quality?',
          'options': ['As filter feeders, they accumulate pollutants from water, reflecting environmental contamination levels', 'They live only in clean water and cannot survive otherwise', 'They have no sensitivity to pollutants', 'They are unaffected by pollution'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best explains the function of statocysts, sensory structures found in some molluscs and crustaceans?',
          'options': ['Balance and orientation (equivalent to a simple inner ear)', 'Vision', 'Taste', 'Smell'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes \'ballooning\', a dispersal behaviour seen in some spiders?',
          'options': ['Burrowing underground for dispersal', 'Using silk threads to be carried by wind currents over long distances', 'Swimming across oceans', 'Flying using wings'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes web-spinning behaviour in spiders as an adaptation?',
          'options': ['Used mainly for capturing prey and sometimes for reproduction/dispersal', 'Used for photosynthesis', 'Used for excretion', 'Used only for decoration'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies the difference in growth pattern between arthropods (moulting) and molluscs (shell growth)?',
          'options': ['Arthropods must periodically shed their exoskeleton to grow, while many molluscs continuously add new shell material without moulting', 'Arthropods add new shell layers continuously; molluscs must moult', 'Both grow identically', 'Neither grows after hatching'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes why chitons (Polyplacophora) are well adapted to rocky intertidal shores?',
          'options': ['Their segmented shell plates and strong foot allow them to cling tightly and flex over uneven rock surfaces', 'They float freely in open water', 'They swim rapidly to escape waves', 'They burrow deep in sand'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes a key difference between insects and crustaceans regarding antennae number?',
          'options': ['Both have no antennae', 'Both have three pairs', 'Insects have two pairs, crustaceans have one pair', 'Insects have one pair, crustaceans typically have two pairs'],
          'correct': 3,
        },
      ];
    case 'bio102_u3_1': // Vertebrate Evolution
      return [
        {
          'question': 'Vertebrates are distinguished from invertebrates mainly by the presence of a?',
          'options': ['Vertebral column (backbone)', 'Radula', 'Exoskeleton', 'Open circulatory system'],
          'correct': 0,
        },
        {
          'question': 'The earliest vertebrates are believed to have evolved from ancestors resembling?',
          'options': ['Insects', 'Reptiles', 'Modern mammals', 'Jawless, fish-like chordates'],
          'correct': 3,
        },
        {
          'question': 'Which of these is considered the most primitive class of living vertebrates, lacking jaws?',
          'options': ['Osteichthyes', 'Amphibia', 'Chondrichthyes', 'Agnatha (jawless fish, e.g., lampreys)'],
          'correct': 3,
        },
        {
          'question': 'Jawed vertebrates are believed to have evolved from jawless ancestors through modification of which structure?',
          'options': ['Vertebrae', 'Scales', 'Gill arches (branchial arches)', 'Fins'],
          'correct': 2,
        },
        {
          'question': 'Which class of fish has a skeleton made mainly of cartilage rather than bone?',
          'options': ['Chondrichthyes (cartilaginous fish, e.g., sharks)', 'Agnatha', 'Amphibia', 'Osteichthyes (bony fish)'],
          'correct': 0,
        },
        {
          'question': 'Which class of fish has a skeleton made mainly of bone?',
          'options': ['Osteichthyes (bony fish)', 'Amphibia', 'Chondrichthyes', 'Agnatha'],
          'correct': 0,
        },
        {
          'question': 'Amphibians are believed to have evolved from which ancestral group?',
          'options': ['Reptiles', 'Lobe-finned fish (Sarcopterygii)', 'Mammals', 'Birds'],
          'correct': 1,
        },
        {
          'question': 'The evolutionary transition from water to land was significantly aided in early tetrapods by the development of?',
          'options': ['Feathers', 'Scales', 'Limbs capable of supporting weight on land', 'Gills'],
          'correct': 2,
        },
        {
          'question': 'Which of these vertebrate classes represents an evolutionary link between fully aquatic fish and fully terrestrial reptiles?',
          'options': ['Mammalia', 'Chondrichthyes', 'Amphibia', 'Aves'],
          'correct': 2,
        },
        {
          'question': 'Reptiles are believed to have evolved from early amphibian ancestors mainly due to the evolutionary innovation of?',
          'options': ['Mammary glands', 'Feathers', 'The amniotic egg, allowing reproduction away from water', 'Gills'],
          'correct': 2,
        },
        {
          'question': 'The amniotic egg, a key evolutionary adaptation in reptiles, allowed vertebrates to?',
          'options': ['Lose the ability to lay eggs', 'Reproduce successfully on land without returning to water', 'Remain dependent on water for reproduction', 'Develop gills permanently'],
          'correct': 1,
        },
        {
          'question': 'Birds are believed to have evolved from which ancestral group?',
          'options': ['Fish', 'Amphibians', 'Mammals', 'Theropod dinosaurs (reptilian ancestors)'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is considered strong fossil evidence linking birds to reptilian (dinosaur) ancestors?',
          'options': ['Tyrannosaurus rex fossils only', 'Archaeopteryx, showing both reptilian and avian features', 'Modern penguin fossils', 'Whale fossils'],
          'correct': 1,
        },
        {
          'question': 'Which feature of Archaeopteryx suggests a reptilian ancestry despite having feathers?',
          'options': ['Presence of wings only', 'Presence of a beak with no teeth', 'Warm-bloodedness only', 'Presence of teeth and a bony tail'],
          'correct': 3,
        },
        {
          'question': 'Mammals are believed to have evolved from which ancestral group?',
          'options': ['Fish directly', 'Synapsid reptiles (mammal-like reptiles)', 'Birds', 'Amphibians directly'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is a key mammalian evolutionary innovation not present in reptiles?',
          'options': ['Amniotic eggs', 'Scales', 'Cold-bloodedness', 'Mammary glands for producing milk'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes convergent evolution, as seen when unrelated species (like sharks and dolphins) develop similar streamlined body shapes?',
          'options': ['Unrelated species independently evolving similar traits due to similar environmental pressures', 'Random mutation with no adaptive value', 'Species with a common ancestor developing similar traits', 'Extinction of similar species'],
          'correct': 0,
        },
        {
          'question': 'Homologous structures, such as the forelimbs of humans, whales, and bats, provide evidence for?',
          'options': ['Convergent evolution', 'No evolutionary relationship', 'Common ancestry (divergent evolution from a shared ancestor)', 'Coincidence only'],
          'correct': 2,
        },
        {
          'question': 'Analogous structures, such as the wings of insects and birds, are examples of?',
          'options': ['Common ancestry', 'Homology', 'Vestigial structures', 'Convergent evolution (similar function, different origin)'],
          'correct': 3,
        },
        {
          'question': 'Vestigial structures, like the human tailbone (coccyx), are considered evidence of?',
          'options': ['Recent mutation', 'Evolutionary history, remnants of structures functional in ancestors', 'Future adaptation', 'Design flaws with no evolutionary significance'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the evolutionary significance of the swim bladder in bony fish, thought to be related to lungs in early tetrapods?',
          'options': ['Neither structure has any evolutionary link', 'They are entirely unrelated structures', 'Swim bladders evolved after lungs in all vertebrates', 'Both may share an evolutionary origin from a similar ancestral structure used for buoyancy/gas exchange'],
          'correct': 3,
        },
        {
          'question': 'Which of the following vertebrate groups was the first to fully adapt to life independent of water for reproduction?',
          'options': ['Amphibians', 'None, all remain water-dependent', 'Fish', 'Reptiles'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why amphibians are still considered only partially adapted to terrestrial life?',
          'options': ['They never enter water', 'They have fully waterproof skin and shelled eggs', 'They lack lungs entirely', 'They generally require water or moist environments for reproduction and often have permeable skin'],
          'correct': 3,
        },
        {
          'question': 'Which of these is a key adaptation of reptiles that reduced their dependency on water compared to amphibians?',
          'options': ['Moist permeable skin', 'Absence of lungs', 'Dry, scaly, keratinised skin reducing water loss', 'Gills throughout life'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the evolutionary advantage of endothermy (warm-bloodedness) seen in birds and mammals?',
          'options': ['Is only useful in warm climates', 'Has no adaptive advantage', 'Allows for a constant internal temperature, supporting sustained high activity levels regardless of external temperature', 'Requires less energy than ectothermy'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the trade-off of endothermy compared to ectothermy?',
          'options': ['Endotherms require more food/energy to maintain constant body temperature', 'Endotherms require no food at all', 'There is no trade-off', 'Ectotherms require more food than endotherms'],
          'correct': 0,
        },
        {
          'question': 'The fossil record shows a gradual transition of limb-like fins to legs in which transitional organism, an important link between fish and tetrapods?',
          'options': ['Trilobite', 'Archaeopteryx', 'Tiktaalik', 'Australopithecus'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the term \'tetrapod\' in vertebrate evolution?',
          'options': ['Only fish', 'A four-limbed vertebrate, including amphibians, reptiles, birds, and mammals', 'Any vertebrate with a backbone', 'Only invertebrates'],
          'correct': 1,
        },
        {
          'question': 'Which of the following vertebrate classes shows the greatest diversity in modern habitats, from deep ocean to high mountains, due to key adaptations like endothermy and efficient respiration?',
          'options': ['Aves and Mammalia', 'Amphibia', 'Reptilia', 'Agnatha'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains the evolutionary loss of limbs in snakes, despite being reptiles descended from limbed ancestors?',
          'options': ['Loss of limbs occurred in all reptiles', 'An adaptation for burrowing/limbless locomotion, retained through natural selection', 'Snakes never had limbed ancestors', 'Random mutation with no adaptive benefit'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies whales and dolphins as mammals that re-adapted to a fully aquatic lifestyle, evolved from land-dwelling ancestors?',
          'options': ['Evidence includes vestigial pelvic bones and the presence of mammary glands and lungs', 'They lack lungs, using gills instead', 'They never had land ancestors', 'They are actually fish, not mammals'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why the evolution of the amniotic egg is considered a major milestone in vertebrate evolution?',
          'options': ['It eliminated the need for fertilisation', 'It had no significant evolutionary impact', 'It allowed reptiles, birds, and mammals to reproduce independently of standing water', 'It only benefited amphibians'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes the evolutionary relationship between birds and reptiles based on modern classification?',
          'options': ['Birds are entirely unrelated to reptiles', 'Birds evolved from mammals', 'Birds evolved independently with no reptilian ancestry', 'Birds are now classified as a specialised group within the reptile lineage (having evolved from theropod dinosaurs)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the evolutionary significance of feathers, believed to have originally evolved for insulation before being adapted for flight?',
          'options': ['Feathers likely first served in thermoregulation/display before enabling powered flight', 'Feathers appeared only in modern birds', 'Feathers evolved solely for flight with no other function', 'Feathers have no evolutionary history'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the pattern of adaptive radiation seen after mass extinction events, such as the extinction of dinosaurs?',
          'options': ['Only plants are affected', 'No change occurs in surviving species', 'Surviving lineages, like early mammals, diversified rapidly to fill newly available ecological niches', 'Surviving species decline further'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best explains why cartilaginous fish (like sharks) are considered to have changed relatively little over millions of years?',
          'options': ['They are actually very recently evolved', 'They lack any fossil record', 'Their well-adapted body plan and successful predatory adaptations faced little selective pressure to change dramatically', 'They evolved after bony fish'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies lungfish and coelacanths as significant in vertebrate evolutionary studies?',
          'options': ['They are lobe-finned fish considered close relatives of the ancestors of tetrapods', 'They are ancient reptiles', 'They are entirely unrelated to tetrapod evolution', 'They are modern amphibians'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why the evolution of a four-chambered heart in birds and mammals is considered advantageous?',
          'options': ['It fully separates oxygenated and deoxygenated blood, allowing more efficient oxygen delivery to support high metabolic rates', 'It mixes oxygenated and deoxygenated blood for efficiency', 'It has no functional advantage over a two-chambered heart', 'It is only found in fish'],
          'correct': 0,
        },
        {
          'question': 'Which of the following vertebrate classes typically has a three-chambered heart, with some mixing of oxygenated and deoxygenated blood?',
          'options': ['Reptilia and Amphibia (mostly)', 'Mammalia', 'Chondrichthyes', 'Aves'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why mammals are believed to have remained small and nocturnal for much of the age of dinosaurs?',
          'options': ['Dinosaurs did not yet exist', 'They were the dominant group at the time', 'To avoid competition and predation from larger dominant reptilian species', 'They had no ecological competitors'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the significance of the fossil transition from reptile-like jaw bones to mammalian middle ear bones?',
          'options': ['It shows reptiles evolved from mammals', 'It provides strong evidence of gradual evolutionary change, as reptilian jaw bones were repurposed into mammalian ear ossicles', 'It shows no evolutionary relationship between reptiles and mammals', 'It is unrelated to hearing'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why marsupials (like kangaroos) and placental mammals are considered to have diverged early in mammalian evolution?',
          'options': ['Marsupials lay eggs', 'They show different reproductive strategies, with marsupials giving birth to underdeveloped young that continue developing in a pouch', 'Placental mammals lay eggs', 'Both give birth in identical ways'],
          'correct': 1,
        },
        {
          'question': 'Which group of mammals, including the platypus, is unique for laying eggs rather than giving live birth, representing an early branch in mammalian evolution?',
          'options': ['Primates', 'Monotremes', 'Marsupials', 'Placental mammals'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes convergent evolution between the flippers of dolphins (mammals) and the fins of fish?',
          'options': ['Neither shows any adaptation for swimming', 'Dolphins evolved directly from fish', 'Both evolved from a shared fish ancestor with no modification', 'Both independently evolved similar streamlined shapes for efficient swimming, despite different ancestries'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the evolutionary trend of increasing brain size and complexity seen in the primate lineage leading to humans?',
          'options': ['Only seen in modern humans, with no earlier evidence', 'Associated with increased cognitive abilities, tool use, and social behaviour, providing survival advantages', 'A trend unrelated to survival', 'A trend with no adaptive advantage'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes bipedalism (walking on two legs) as a key evolutionary adaptation in human ancestors?',
          'options': ['It had no adaptive advantage', 'It prevented tool use', 'It freed the hands for tool use and carrying, while enabling energy-efficient long-distance walking', 'It reduced brain size'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why fossils are considered crucial evidence for vertebrate evolution?',
          'options': ['They only show modern species', 'They provide no useful information', 'They are always complete and perfectly preserved', 'They preserve physical evidence of extinct organisms, showing gradual changes in structure over geological time'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the concept of a \'living fossil\', such as the coelacanth, in the context of vertebrate evolution?',
          'options': ['A species that has changed relatively little over a very long evolutionary time period, resembling ancient relatives', 'A newly evolved species', 'A species that has changed dramatically in a short time', 'A species that is now completely extinct'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why molecular evidence (DNA comparison) supports and complements fossil evidence in studies of vertebrate evolution?',
          'options': ['Only fossils provide evolutionary evidence', 'DNA evidence always contradicts fossil evidence', 'DNA cannot be used to study evolution', 'DNA similarities between species can indicate evolutionary relationships and estimated divergence times, matching fossil-based conclusions'],
          'correct': 3,
        },
        {
          'question': 'Which of these vertebrate groups is generally considered to have appeared earliest in the fossil record?',
          'options': ['Reptiles', 'Birds', 'Fish (jawless, then jawed)', 'Mammals'],
          'correct': 2,
        },
        {
          'question': 'Which of these vertebrate groups is generally considered to have appeared most recently in the fossil record, among major classes?',
          'options': ['Fish', 'Reptiles', 'Amphibians', 'Mammals and birds'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best summarises the general evolutionary sequence of major vertebrate classes over geological time?',
          'options': ['Birds, then fish, then reptiles', 'Fish, then amphibians, then reptiles, then birds and mammals', 'Reptiles, then fish, then mammals', 'Mammals, then fish, then amphibians'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why lampreys and hagfish, both jawless fish, are considered evolutionarily significant?',
          'options': ['They have the most complex vertebrate anatomy', 'They are the most recently evolved vertebrates', 'They represent living examples of one of the earliest vertebrate lineages, lacking jaws and paired fins', 'They are closely related to mammals'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the evolutionary origin of vertebrate jaws from earlier gill-supporting structures?',
          'options': ['Jaws evolved from limbs', 'Jaws evolved independently in every vertebrate class', 'Jaws are believed to have evolved from modified anterior gill arches in early jawless fish', 'Jaws appeared suddenly with no precursor structure'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the evolutionary advantage jaws provided to early vertebrates?',
          'options': ['Jaws reduced feeding efficiency', 'Jaws had no functional advantage', 'Jaws prevented respiration', 'Jaws allowed more efficient and varied feeding, including active predation, over simple filter feeding'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes paired fins in fish as evolutionary precursors to tetrapod limbs?',
          'options': ['Limbs evolved before fins', 'Only unpaired fins relate to limb evolution', 'Fins and limbs are entirely unrelated structures', 'Paired pectoral and pelvic fins are thought to be homologous to forelimbs and hindlimbs in tetrapods'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why the swim bladder and lungs are considered homologous structures in fish and tetrapods?',
          'options': ['Lungs evolved from bone', 'Both may have evolved from a common ancestral outpocketing of the gut used for gas exchange or buoyancy', 'Swim bladders evolved from skin', 'They developed independently with no shared origin'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the term \'stem tetrapod\' used to describe transitional fossils like Tiktaalik?',
          'options': ['An organism showing a mix of fish-like and tetrapod-like features, representing a transitional evolutionary stage', 'A modern reptile', 'An organism unrelated to tetrapod evolution', 'A fully modern amphibian'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why early tetrapods retained gills as juveniles despite having developed limbs, similar to modern amphibians?',
          'options': ['Gills serve no respiratory function', 'Limbs appeared only after gills were lost completely', 'All early tetrapods lacked gills entirely', 'The transition from water to land was gradual, with some aquatic larval stages retained'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the evolutionary pressure that may have favoured the development of stronger limbs in early tetrapods living in shallow water/swampy habitats?',
          'options': ['Limbs evolved only for swimming faster', 'Limbs helped them navigate through vegetation and shallow water, and eventually move onto land', 'Limbs had no survival advantage', 'Limbs reduced mobility'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why reptiles were able to diversify into a wide range of terrestrial habitats compared to amphibians?',
          'options': ['Reptiles could only live in swamps', 'Reptiles lacked lungs', 'Their dry, scaly skin and amniotic eggs freed them from dependence on moist environments for reproduction', 'Reptiles remained fully aquatic'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the evolutionary significance of the therapsids (mammal-like reptiles) in the transition to true mammals?',
          'options': ['They are unrelated to mammalian evolution', 'They evolved after true mammals appeared', 'They lacked any mammalian traits', 'They show a gradual accumulation of mammalian traits, such as differentiated teeth and possibly fur, within a reptilian lineage'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why differentiated teeth (incisors, canines, molars), seen in mammals, are considered an evolutionary advancement over the uniform teeth of most reptiles?',
          'options': ['They are found in all vertebrate classes equally', 'They reduce feeding efficiency', 'They allow more efficient processing of varied diets, supporting higher metabolic demands', 'They serve no functional advantage'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why the evolution of a secondary palate in mammals (and some reptiles like crocodilians) was advantageous?',
          'options': ['It has no functional benefit', 'It separates the nasal and oral cavities, allowing breathing while chewing or suckling', 'It only aids in vision', 'It prevents breathing entirely'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why birds are thought to have evolved flight from small, feathered theropod dinosaurs, based on fossil evidence?',
          'options': ['No transitional fossils exist for bird evolution', 'Birds evolved directly from fish', 'Flight appeared suddenly with no precursor adaptations', 'Fossils show a gradual accumulation of flight-related features, such as feathers, hollow bones, and wishbones, in non-flying dinosaur ancestors'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the \'trees-down\' versus \'ground-up\' hypotheses for the origin of bird flight?',
          'options': ['These hypotheses relate only to insect flight', 'There is only one accepted hypothesis with no debate', 'Both are competing hypotheses about whether flight evolved from gliding out of trees or running/jumping from the ground', 'Flight is not believed to have evolved gradually'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why keeled sternums (breastbones) are found in most flying birds?',
          'options': ['They provide an anchor point for large flight muscles, supporting powered flight', 'They reduce muscle attachment area', 'They are found in all reptiles', 'They have no relation to flight'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the evolutionary loss of teeth in modern birds, replaced by a lightweight beak?',
          'options': ['Teeth loss has no relation to flight efficiency', 'All birds retain teeth today', 'Birds never had toothed ancestors', 'An adaptation likely related to reducing body weight for more efficient flight'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why whales, despite being fully aquatic mammals, still possess vestigial pelvic and leg bones?',
          'options': ['The bones have a current swimming function identical to legs', 'They are entirely new structures unrelated to limbs', 'These structures are remnants inherited from their land-dwelling four-limbed ancestors', 'Whales never had land ancestors'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the fossil sequence (e.g., Pakicetus, Ambulocetus, Basilosaurus) used to trace whale evolution from land mammals to fully aquatic forms?',
          'options': ['It shows a single sudden transformation', 'It shows whales evolving from fish', 'It shows no evolutionary pattern', 'It shows a gradual series of anatomical changes, including limb reduction and streamlining, over millions of years'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why bats and birds, both capable of powered flight, are not closely related despite similar wing function?',
          'options': ['They share a direct common flying ancestor', 'Wings are homologous in both groups', 'Their wings are analogous structures, having evolved independently (convergent evolution) from different ancestral limbs', 'Bats evolved from birds'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the structural difference between bat wings (modified digits with skin) and bird wings (feathers on a modified forelimb)?',
          'options': ['Bats have feathers', 'Birds have skin membranes instead of feathers', 'Both have identical bone structure', 'They demonstrate that similar function (flight) can evolve through different underlying anatomical modifications'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why humans are classified within the order Primates, along with monkeys and apes?',
          'options': ['Classification is based on habitat alone', 'Primates share no anatomical similarities', 'Shared anatomical features such as grasping hands, forward-facing eyes, and large brains relative to body size, reflecting common ancestry', 'Humans are unrelated to other primates'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the general fossil evidence trend for hominin evolution leading to modern humans?',
          'options': ['A gradual increase in brain size and bipedal adaptations over several million years, with multiple now-extinct hominin species', 'A sudden appearance of modern humans with no fossil ancestors', 'A decrease in brain size over time', 'No fossil evidence exists for human evolution'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why Australopithecus is considered an important early hominin genus in human evolutionary studies?',
          'options': ['It shows no bipedal adaptations', 'It is unrelated to the human lineage', 'Fossils show clear evidence of bipedal walking combined with a relatively small, ape-like brain', 'It shows a fully modern human brain'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the general concept of a \'missing link\' in evolutionary biology, often used informally in discussions of vertebrate evolution?',
          'options': ['An organism that disproves evolution', 'A transitional fossil showing characteristics intermediate between an ancestral and descendant group', 'A living species with no fossil record', 'A term with no scientific basis at all'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why comparative embryology (similar early developmental stages across vertebrate classes) is used as evidence for shared ancestry?',
          'options': ['Comparative embryology has no relevance to evolution', 'Embryos of different vertebrate classes show no similarities', 'Related species often show similar early embryonic structures (like pharyngeal pouches) even if adult forms differ greatly', 'Only adult anatomy provides evolutionary evidence'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains the evolutionary loss of hindlimbs in whales and some other fully aquatic vertebrates over time?',
          'options': ['Loss occurred randomly with no environmental pressure involved', 'Reduced functional need for hindlimbs in an aquatic environment led to their gradual reduction through natural selection', 'Hindlimbs became larger over time', 'Hindlimbs were never present in ancestors'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why island populations of vertebrates, such as Darwin\'s finches, are often used as examples of rapid evolutionary adaptation?',
          'options': ['Isolated populations facing unique environmental pressures can show relatively rapid diversification in traits like beak shape', 'Islands prevent any evolutionary change', 'Finches show no variation between islands', 'Isolated populations cannot adapt'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the significance of Charles Darwin\'s observations of finches in the Galápagos Islands for evolutionary theory?',
          'options': ['They had no influence on evolutionary theory', 'They provided key evidence supporting natural selection and adaptive radiation from a common ancestor', 'They disproved evolutionary theory', 'They showed finches were unrelated to each other'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why natural selection is considered the primary mechanism driving vertebrate evolutionary adaptations over time?',
          'options': ['Natural selection has no effect on trait frequency', 'Individuals with traits better suited to their environment tend to survive and reproduce more, passing those traits to offspring', 'Natural selection only applies to plants', 'All individuals reproduce equally regardless of traits'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains genetic drift as a mechanism of evolutionary change, distinct from natural selection?',
          'options': ['A synonym for natural selection', 'A form of selection based on traits', 'Random changes in allele frequency, especially significant in small populations, not necessarily linked to survival advantage', 'A process that only increases fitness'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the term \'speciation\' in the context of vertebrate evolutionary history?',
          'options': ['The merging of two species into one', 'A process that only occurs in plants', 'The extinction of a species', 'The process by which new, distinct species arise from an ancestral population, often through geographic isolation'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains allopatric speciation, a common mode of speciation in vertebrates?',
          'options': ['Speciation caused only by hybridisation', 'A process unrelated to geography', 'Geographic separation of populations leads to independent evolution and eventual reproductive isolation', 'Speciation occurring without any separation'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why the fossil record is considered incomplete, despite providing strong evolutionary evidence?',
          'options': ['All organisms fossilise perfectly', 'The fossil record contradicts evolutionary theory', 'Fossilisation is a rare process, and many organisms/soft tissues do not preserve well over geological time', 'Fossils provide no evolutionary evidence at all'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes radiometric dating and its use in studying vertebrate evolution?',
          'options': ['A method that only works on living organisms', 'A method unrelated to determining fossil ages', 'A method using the decay rates of radioactive isotopes to estimate the age of fossils and rock layers', 'A method with no scientific basis'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why the evolution of efficient lungs was crucial for vertebrates transitioning to a fully terrestrial existence?',
          'options': ['Gills work equally well on land', 'Efficient lungs allow sufficient oxygen uptake from air, supporting higher metabolic activity away from water', 'Lungs are unnecessary for terrestrial life', 'Lungs evolved after full terrestrial adaptation was complete'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the adaptive significance of internal fertilisation, which evolved in reptiles, birds, and mammals compared to many fish and amphibians?',
          'options': ['It is only found in aquatic vertebrates', 'It has no adaptive advantage', 'It prevents successful reproduction', 'It allows reproduction without dependence on external water, supporting full terrestrial life cycles'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes why the study of vertebrate evolution relies on multiple lines of evidence (fossils, comparative anatomy, embryology, and molecular biology)?',
          'options': ['A single line of evidence is always sufficient and conclusive', 'Combining multiple evidence types strengthens and cross-validates conclusions about evolutionary relationships', 'Only fossils are considered valid evidence', 'These evidence types always contradict each other'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the class Osteichthyes, which represents the majority of living fish species today?',
          'options': ['Jawless fish only', 'Amphibians', 'Cartilaginous fish only', 'Bony fish with an ossified internal skeleton and typically a swim bladder'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why the discovery of feathered dinosaur fossils in China strengthened the dinosaur-bird evolutionary link?',
          'options': ['They disproved the existence of feathered dinosaurs', 'They showed birds evolved before dinosaurs', 'They showed dinosaurs and birds are unrelated', 'They showed many non-avian dinosaurs already possessed feathers before the evolution of flight'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the term \'exaptation\' as applied to the evolution of feathers, which may have first served insulation before flight?',
          'options': ['A trait that only ever serves one function', 'A term unrelated to evolutionary biology', 'A trait with no original function', 'A trait that originally evolved for one function being later co-opted for a different function'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the significance of Ichthyostega and Acanthostega as early tetrapod fossils?',
          'options': ['They are dinosaur fossils', 'They show early limbed vertebrates that retained many fish-like features, illustrating the water-to-land transition', 'They are fully modern amphibians', 'They show no connection to fish ancestors'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why many marine reptiles, like ichthyosaurs (now extinct), evolved streamlined bodies similar to fish and dolphins?',
          'options': ['They evolved identical internal anatomy to fish', 'They are directly related to fish', 'Streamlining offered no advantage in water', 'Convergent evolution due to similar aquatic environmental pressures despite different ancestries'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the term \'punctuated equilibrium\' as a proposed pattern of evolutionary change, relevant to vertebrate fossil records?',
          'options': ['Evolution never shows periods of stability', 'A pattern seen only in plants', 'Evolution always proceeds at a constant, slow rate', 'Long periods of little change punctuated by relatively rapid bursts of evolutionary change'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why deep homology (shared developmental genes like Hox genes) across very different vertebrate body plans supports common ancestry?',
          'options': ['Shared genes always mean identical adult body plans', 'Hox genes are unique to each vertebrate species with no similarity', 'Despite very different adult forms, shared underlying genetic control of development points to descent from a common ancestor', 'Genetic evidence contradicts fossil evidence in all cases'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why comparing the number of chromosomes alone is not a reliable way to determine evolutionary relatedness between vertebrate species?',
          'options': ['Chromosome number can vary widely even among closely related species due to fusion/fission events, without indicating major evolutionary distance', 'Species with different chromosome numbers can never be related', 'Chromosome number is always identical between related species', 'Chromosome number is the only evidence needed for classification'],
          'correct': 0,
        },
        {
          'question': 'Which of these best summarises the overall pattern described by the theory of vertebrate evolution?',
          'options': ['A single linear ladder from simple to complex with no branching', 'A process completed entirely within human history', 'A branching tree of descent with modification from common ancestors, shaped by natural selection and other mechanisms over vast timescales', 'A pattern with no connection between different vertebrate classes'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why Darwin\'s finches are a classic example used to teach vertebrate adaptive evolution in biology?',
          'options': ['They disprove natural selection', 'Their beak shapes diversified to exploit different food sources on different islands, illustrating natural selection in action', 'They show no variation in beak shape', 'They are invertebrates, not vertebrates'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why the transition of the reptilian jaw joint bones into mammalian middle ear ossicles (malleus and incus) is considered strong evolutionary evidence?',
          'options': ['It shows mammals evolved after birds', 'It has no fossil support at all', 'It is documented by a well-supported sequence of transitional fossils showing gradual repurposing of these bones', 'It shows no relationship between reptiles and mammals'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why vertebrate evolution is studied as part of the broader field of phylogenetics?',
          'options': ['Phylogenetics uses evidence to reconstruct evolutionary relationships and branching patterns among species, including vertebrates', 'Phylogenetics only studies living species with no historical component', 'Phylogenetics is unrelated to evolutionary biology', 'Phylogenetics only applies to bacteria'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why the evolutionary success of mammals expanded greatly after the extinction of non-avian dinosaurs about 66 million years ago?',
          'options': ['Reduced competition and newly available ecological niches allowed rapid mammalian adaptive radiation', 'Dinosaurs and mammals never coexisted', 'Mammals appeared for the first time after this extinction', 'Mammalian diversity decreased after this event'],
          'correct': 0,
        },
      ];
    case 'bio102_u3_2': // Chordates
      return [
        {
          'question': 'Which of these is NOT one of the four defining characteristics of Phylum Chordata?',
          'options': ['Notochord', 'Pharyngeal gill slits', 'Dorsal hollow nerve cord', 'Jointed exoskeleton'],
          'correct': 3,
        },
        {
          'question': 'The notochord is a flexible rod that provides support and is found at some stage in which animal phylum?',
          'options': ['Chordata', 'Annelida', 'Mollusca', 'Arthropoda'],
          'correct': 0,
        },
        {
          'question': 'In most adult vertebrates, the notochord is replaced by the?',
          'options': ['Exoskeleton', 'Shell', 'Mantle', 'Vertebral column (backbone)'],
          'correct': 3,
        },
        {
          'question': 'The nerve cord in chordates is located on which side of the body, distinguishing them from most invertebrates?',
          'options': ['Dorsal (back) side', 'No fixed position', 'Ventral (belly) side', 'Lateral side only'],
          'correct': 0,
        },
        {
          'question': 'Pharyngeal gill slits in chordate embryos develop into gills in fish or into which structures in terrestrial vertebrates?',
          'options': ['Parts of the ear and other head/neck structures', 'Lungs entirely', 'The notochord', 'The tail'],
          'correct': 0,
        },
        {
          'question': 'The post-anal tail, a chordate feature, extends beyond the?',
          'options': ['Head', 'Mouth', 'Anus', 'Notochord only'],
          'correct': 2,
        },
        {
          'question': 'Phylum Chordata is divided into three main subphyla: Urochordata, Cephalochordata, and?',
          'options': ['Vertebrata', 'Mollusca', 'Arthropoda', 'Annelida'],
          'correct': 0,
        },
        {
          'question': 'Which chordate subphylum includes tunicates (sea squirts), which have a notochord only in the larval stage?',
          'options': ['Vertebrata', 'Cephalochordata', 'Urochordata', 'Echinodermata'],
          'correct': 2,
        },
        {
          'question': 'Which chordate subphylum includes lancelets (Amphioxus), retaining a notochord throughout life?',
          'options': ['Vertebrata', 'Urochordata', 'Cephalochordata', 'None'],
          'correct': 2,
        },
        {
          'question': 'Which chordate subphylum includes all animals with a vertebral column (backbone)?',
          'options': ['Vertebrata', 'Urochordata', 'Cephalochordata', 'None of these'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of Urochordata?',
          'options': ['Amphioxus', 'Fish', 'Sea squirt (Tunicate)', 'Frog'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an example of Cephalochordata?',
          'options': ['Sea squirt', 'Amphioxus (lancelet)', 'Snake', 'Shark'],
          'correct': 1,
        },
        {
          'question': 'Which of the following is TRUE regarding tunicates (Urochordata) as adults?',
          'options': ['They retain a notochord and swim actively', 'They have jointed legs', 'Most become sessile filter feeders, losing the notochord after the larval stage', 'They develop a vertebral column'],
          'correct': 2,
        },
        {
          'question': 'Vertebrata is characterised, in addition to the basic chordate features, by the presence of a?',
          'options': ['Radula', 'Vertebral column enclosing the spinal cord', 'Exoskeleton', 'Mantle'],
          'correct': 1,
        },
        {
          'question': 'Which of these vertebrate classes is entirely aquatic and breathes primarily using gills throughout life?',
          'options': ['Reptilia', 'Aves', 'Chondrichthyes and most Osteichthyes', 'Mammalia'],
          'correct': 2,
        },
        {
          'question': 'Which vertebrate class includes cartilaginous fish such as sharks and rays?',
          'options': ['Osteichthyes', 'Agnatha', 'Chondrichthyes', 'Amphibia'],
          'correct': 2,
        },
        {
          'question': 'Which vertebrate class includes bony fish, the most numerous and diverse fish group?',
          'options': ['Chondrichthyes', 'Reptilia', 'Agnatha', 'Osteichthyes'],
          'correct': 3,
        },
        {
          'question': 'Which vertebrate class typically undergoes metamorphosis from an aquatic larval stage (e.g., tadpole) to a semi-terrestrial adult?',
          'options': ['Reptilia', 'Aves', 'Mammalia', 'Amphibia'],
          'correct': 3,
        },
        {
          'question': 'Which vertebrate class is characterised by dry, scaly skin and amniotic eggs, adapted for terrestrial reproduction?',
          'options': ['Chondrichthyes', 'Agnatha', 'Amphibia', 'Reptilia'],
          'correct': 3,
        },
        {
          'question': 'Which vertebrate class is characterised by feathers, beaks, and adaptations for flight in most members?',
          'options': ['Reptilia', 'Mammalia', 'Amphibia', 'Aves (birds)'],
          'correct': 3,
        },
        {
          'question': 'Which vertebrate class is characterised by hair/fur, mammary glands, and typically live birth (with exceptions)?',
          'options': ['Amphibia', 'Reptilia', 'Aves', 'Mammalia'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is a key feature distinguishing Aves (birds) from other reptile-related vertebrates?',
          'options': ['Presence of feathers and adaptations for flight', 'Absence of a skeleton', 'Cold-bloodedness', 'Presence of scales only'],
          'correct': 0,
        },
        {
          'question': 'Which of the following vertebrate classes is generally ectothermic (cold-blooded)?',
          'options': ['Aves', 'Mammalia', 'Both Aves and Mammalia', 'Reptilia'],
          'correct': 3,
        },
        {
          'question': 'Which of the following vertebrate classes is generally endothermic (warm-blooded)?',
          'options': ['Chondrichthyes', 'Amphibia', 'Aves and Mammalia', 'Reptilia'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies the lateral line system, a sensory structure found in fish?',
          'options': ['Detects light', 'Detects water movement/vibrations, aiding in sensing predators, prey, and obstacles', 'Detects smell only', 'Detects taste only'],
          'correct': 1,
        },
        {
          'question': 'Fish typically maintain buoyancy in water using a specialised organ called the?',
          'options': ['Lung', 'Gill', 'Swim bladder', 'Liver only'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes operculum, a structure found in bony fish?',
          'options': ['A sensory organ for smell', 'A type of fin', 'A type of scale', 'A bony flap covering and protecting the gills'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes cartilaginous fish (sharks) lacking a swim bladder, relying instead on which adaptation for buoyancy?',
          'options': ['Lungs', 'Feathers', 'A large oil-filled liver and continuous swimming', 'Gas-filled bones'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why amphibians typically lay eggs in water or moist environments?',
          'options': ['They cannot reproduce without extreme cold', 'Amphibian eggs require sunlight only', 'Their eggs lack a protective shell and would dry out on land', 'Their eggs are fully waterproof'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the three main living orders of amphibians?',
          'options': ['Anura (frogs/toads), Urodela (salamanders), Apoda (caecilians)', 'Only frogs and toads', 'Only snakes and lizards', 'Only salamanders'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of Urodela (tailed amphibians)?',
          'options': ['Salamander', 'Caecilian', 'Frog', 'Toad'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of Apoda, legless burrowing amphibians?',
          'options': ['Frog', 'Caecilian', 'Salamander', 'Newt'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the skin of amphibians, important for cutaneous (skin) respiration?',
          'options': ['Thin, moist, and highly permeable', 'Thick, dry, and scaly', 'Covered in fur', 'Covered in feathers'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a reptile order that includes snakes and lizards?',
          'options': ['Testudines', 'Crocodilia', 'Rhynchocephalia', 'Squamata'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an example of a reptile order that includes turtles and tortoises?',
          'options': ['None', 'Testudines', 'Squamata', 'Crocodilia'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an example of a reptile order that includes crocodiles and alligators?',
          'options': ['Crocodilia', 'Rhynchocephalia', 'Squamata', 'Testudines'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the amniotic egg\'s key protective structures, such as the amnion and shell?',
          'options': ['They provide no protection', 'They provide a protective, often waterproof environment allowing development away from water', 'They prevent gas exchange entirely', 'They only function in aquatic animals'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes ectothermy (cold-bloodedness), typical of reptiles and amphibians?',
          'options': ['Body temperature is regulated internally at a constant level', 'Requires constant high food intake', 'Applies only to birds', 'Body temperature varies with the external environment'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes endothermy (warm-bloodedness), typical of birds and mammals?',
          'options': ['Requires no food intake', 'Body temperature varies with surroundings', 'Applies only to fish', 'Body temperature is maintained at a relatively constant internal level through metabolic heat production'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the four-chambered heart found in birds and mammals?',
          'options': ['It mixes all blood together', 'It has only one chamber', 'It fully separates oxygenated and deoxygenated blood for efficient circulation', 'It is found only in fish'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes hollow, air-filled bones (pneumatic bones), an adaptation seen in most birds?',
          'options': ['They are solid and heavy', 'They are unrelated to flight', 'They reduce body weight, aiding flight, while often retaining structural strength', 'They increase body weight'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the beak (bill) of birds, replacing teeth found in most other vertebrates?',
          'options': ['A lightweight, keratinised structure adapted to different diets', 'A structure used only for defence', 'A heavy, tooth-filled structure', 'A structure unrelated to feeding'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes down feathers versus contour feathers in birds?',
          'options': ['Both serve identical functions', 'Down feathers provide insulation; contour feathers give body shape and aid flight', 'Contour feathers provide insulation only', 'Down feathers are used for flight only'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes why most mammals give birth to live young (viviparity), except monotremes?',
          'options': ['It has no protective advantage', 'It allows for greater protection and development of the embryo within the mother\'s body', 'It always requires external water', 'It is identical to egg-laying'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies hair/fur as a key mammalian feature, primarily functioning in?',
          'options': ['Insulation, and sometimes camouflage/sensory functions', 'Only for gas exchange', 'Only for reproduction', 'Only camouflage'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the diaphragm, a muscular structure found in mammals, aiding respiration?',
          'options': ['It is found only in reptiles', 'It replaces the lungs', 'It has no respiratory role', 'It separates the thoracic and abdominal cavities and assists in breathing by changing chest cavity volume'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly categorises whales, bats, and humans as belonging to the same class due to shared features like hair and mammary glands?',
          'options': ['Reptilia', 'Aves', 'Amphibia', 'Mammalia'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why bats, despite flying like birds, are classified as mammals and not birds?',
          'options': ['They have feathers', 'They possess mammalian features such as fur, mammary glands, and live birth, despite convergent flight adaptation', 'They are cold-blooded like reptiles', 'They lay eggs like birds'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies the three main groups (infraclasses) of mammals based on reproductive strategy?',
          'options': ['Reptiles, Birds, Mammals', 'Only Marsupials and Monotremes', 'Monotremes, Marsupials, Placental mammals', 'Only Placental mammals'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an example of a monotreme, an egg-laying mammal?',
          'options': ['Platypus', 'Human', 'Dog', 'Kangaroo'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a marsupial, giving birth to underdeveloped young that complete development in a pouch?',
          'options': ['Platypus', 'Whale', 'Human', 'Kangaroo'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an example of a placental mammal, where the young develop fully inside the uterus nourished by a placenta?',
          'options': ['Platypus', 'Echidna', 'Human', 'Kangaroo'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes why fish are considered the most numerous and diverse group of vertebrates?',
          'options': ['They occupy only freshwater habitats', 'They are limited to a single habitat type', 'They are the least diverse vertebrate group', 'They occupy a vast range of aquatic habitats and show great diversity in size, shape, and behaviour'],
          'correct': 3,
        },
        {
          'question': 'Which of the following correctly identifies gills as the primary respiratory organs in most fish, extracting oxygen from?',
          'options': ['Water', 'Blood directly', 'Air', 'Soil'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes countercurrent gas exchange in fish gills, increasing respiratory efficiency?',
          'options': ['No blood flow is involved', 'Water and blood flow in the same direction', 'Water and blood flow in opposite directions, maximising oxygen diffusion', 'Only air is used for exchange'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies the general body covering of most bony fish?',
          'options': ['Fur', 'Bare, moist skin only', 'Overlapping scales, often covered in mucus', 'Feathers'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why amphibians are considered indicator species, reflecting environmental health?',
          'options': ['They live only in extremely polluted areas', 'They have no ecological sensitivity', 'They are unaffected by environmental changes', 'Their permeable skin makes them highly sensitive to pollutants and environmental changes'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly identifies the key chordate feature that persists into adulthood in fish, as the primary axial support structure alongside or before full vertebral development?',
          'options': ['Exoskeleton', 'Notochord (later largely replaced by vertebrae)', 'Radula', 'Mantle'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes the general trend seen across chordate evolution regarding the notochord?',
          'options': ['It is generally reduced or replaced by the vertebral column in adult vertebrates, though present in early development', 'It disappears entirely with no replacement', 'It is absent even at the embryonic stage in vertebrates', 'It becomes more prominent in adult vertebrates'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why Amphioxus (lancelet) is often studied as a model for understanding basic chordate body plan and early vertebrate evolution?',
          'options': ['It is a complex vertebrate with limbs', 'It shows the four basic chordate features clearly and retains a notochord throughout life, unlike more derived vertebrates', 'It lacks all chordate features', 'It is unrelated to chordate evolution'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies the general characteristic of pharyngeal slits in adult terrestrial vertebrates, such as reptiles and mammals?',
          'options': ['They are present only during embryonic development and are absent or modified in adults', 'They are absent throughout life, even in embryos', 'They remain as functional gills', 'They function as an exoskeleton'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the key evolutionary trend from fish to tetrapods regarding paired fins?',
          'options': ['Fins and limbs share no evolutionary connection', 'Paired fins evolved after limbs appeared', 'Paired fins gradually became reduced and non-functional', 'Paired fins are thought to have evolved into limbs, enabling support on land'],
          'correct': 3,
        },
        {
          'question': 'Which of these best summarises why Phylum Chordata, despite its relatively small number of species compared to Arthropoda, includes some of the most complex and largest animals on Earth?',
          'options': ['Chordates lack any distinguishing advantageous features', 'Complexity and size are unrelated to the presence of an internal skeleton and advanced nervous system', 'Arthropods are more complex than chordates', 'The chordate body plan, including an internal skeleton in vertebrates, supports large body size and complex nervous system development'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the term \'ectotherm\' as applied to fish, amphibians, and reptiles?',
          'options': ['Requires constant metabolic heat production', 'Body temperature depends largely on the external environment', 'Body temperature is regulated internally regardless of environment', 'Only applies to birds'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies scales as a body covering, and the class most associated with dry, keratinised scales for water conservation?',
          'options': ['Amphibia', 'Mammalia', 'Reptilia', 'Aves'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes the fins of fish and their general functions?',
          'options': ['For steering, balance, and propulsion during swimming', 'Only for respiration', 'Only for feeding', 'Only for reproduction'],
          'correct': 0,
        },
        {
          'question': 'The dorsal fin in fish primarily helps with?',
          'options': ['Stability and preventing rolling while swimming', 'Feeding', 'Excretion', 'Vision'],
          'correct': 0,
        },
        {
          'question': 'The caudal (tail) fin in fish primarily provides?',
          'options': ['Balance only', 'Vision', 'Propulsion for forward movement', 'Digestion'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes pectoral and pelvic fins in fish, considered homologous to tetrapod limbs?',
          'options': ['Paired fins located on the sides of the body, used for steering and balance', 'They are used only for respiration', 'They are located on the dorsal side only', 'They are absent in all fish'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes why cartilage, rather than bone, forms the skeleton in sharks and rays?',
          'options': ['Cartilage is lighter and more flexible than bone, aiding buoyancy and movement', 'Cartilage cannot support any weight', 'Bone is absent from all vertebrates', 'Cartilage is heavier than bone'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies placoid scales, unique to cartilaginous fish like sharks?',
          'options': ['Absent scales entirely', 'Smooth, overlapping scales like most bony fish', 'Small, tooth-like structures giving a rough texture to the skin', 'Feather-like structures'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes viviparity as a reproductive strategy?',
          'options': ['Reproduction without fertilisation', 'Asexual reproduction only', 'Giving birth to live young that developed inside the parent\'s body', 'Laying eggs that hatch outside the body'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes oviparity as a reproductive strategy, typical of most birds, reptiles, and some fish/amphibians?',
          'options': ['A strategy unique to mammals', 'Laying eggs that develop and hatch outside the mother\'s body', 'Giving birth to fully developed live young', 'A form of asexual reproduction'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes ovoviviparity, seen in some sharks and reptiles, as an intermediate reproductive strategy?',
          'options': ['Eggs develop and hatch inside the mother\'s body without a placental connection, and young are born live', 'Young are cloned', 'Eggs are laid externally', 'No eggs are involved at all'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why most amphibians must return to water to breed, even as semi-terrestrial adults?',
          'options': ['Amphibians cannot produce eggs', 'Amphibian eggs are fully waterproof', 'Breeding occurs entirely on dry land', 'Their eggs lack a shell and require a moist environment to prevent desiccation, and larvae are typically aquatic'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes gill slits (branchial slits) as seen in fish and shark embryos, and cartilaginous fish adults?',
          'options': ['Structures used for reproduction', 'Openings allowing water to pass over the gills for gas exchange', 'Structures found only in birds', 'Structures used for excretion'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies the lung structure found in birds, considered highly efficient compared to mammalian lungs?',
          'options': ['No lungs at all, relying on skin only', 'Lungs connected to air sacs, allowing continuous one-way airflow for efficient gas exchange', 'Simple sac-like lungs with no additional structures', 'Lungs identical in structure to fish gills'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes why bird lungs, with their air sac system, are particularly advantageous during high-altitude flight?',
          'options': ['They have no relation to flight altitude', 'They allow highly efficient oxygen extraction even in low-oxygen conditions at altitude', 'They reduce oxygen uptake at altitude', 'They function only at sea level'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why reptiles, unlike amphibians, generally have well-developed lungs as their primary respiratory organ throughout life?',
          'options': ['Reptiles do not respire at all', 'Reptiles use gills throughout life', 'Reptiles rely less on cutaneous (skin) respiration due to their dry, less permeable skin', 'Reptile skin is highly permeable like amphibians'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly identifies claws, nails, or hooves as keratinised structures found in many terrestrial vertebrates, including reptiles, birds, and mammals?',
          'options': ['Used only for respiration', 'Found only in fish', 'Used for defence, digging, climbing, or locomotion depending on the species', 'Used only for swimming'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes the general skeletal difference between cartilaginous fish and bony fish?',
          'options': ['Both groups have identical skeletons', 'Cartilaginous fish have an ossified (bony) internal skeleton, while bony fish have a cartilaginous one', 'Neither group has an internal skeleton', 'Cartilaginous fish have a skeleton mainly of cartilage, while bony fish have an ossified (bony) skeleton'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly identifies the general term for the process of hatching from an egg, as seen in many oviparous vertebrates?',
          'options': ['Moulting', 'Hatching', 'Budding', 'Metamorphosis'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes the significance of the placenta in placental mammals?',
          'options': ['It has no function', 'It is found in all vertebrate classes', 'It functions only after birth', 'It allows nutrient and gas exchange between mother and developing embryo/fetus during pregnancy'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly identifies the general dental pattern (heterodont dentition) found in most mammals, unlike most reptiles?',
          'options': ['Differentiated teeth (incisors, canines, premolars, molars) adapted for different feeding functions', 'Complete absence of teeth', 'Uniform teeth throughout the jaw', 'Teeth found only in the upper jaw'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes homodont dentition, typical of most reptiles and fish, as opposed to mammals?',
          'options': ['Teeth found only in birds', 'Teeth of similar shape and size throughout the jaw, generally for gripping rather than specialised processing', 'Highly differentiated teeth like mammals', 'Complete absence of any teeth'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies why most birds lack teeth, relying instead on a gizzard for mechanical digestion?',
          'options': ['Teeth are heavier than a gizzard, providing no advantage', 'An adaptation reducing body weight, aiding flight, since the gizzard (with swallowed grit) grinds food instead', 'Birds never evolved any digestive adaptation', 'All birds retain teeth like reptiles'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes external fertilisation, common in most fish and amphibians, compared to internal fertilisation in reptiles, birds, and mammals?',
          'options': ['External fertilisation is unique to mammals', 'Fertilisation occurs outside the body, typically in water', 'Fertilisation always occurs inside the female\'s body', 'Fertilisation does not occur in these groups'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains why external fertilisation is generally associated with the production of large numbers of eggs/gametes?',
          'options': ['External fertilisation guarantees higher survival than internal fertilisation', 'To compensate for lower fertilisation and survival rates outside a protected internal environment', 'Egg number is unrelated to fertilisation type', 'Fewer eggs are always needed with external fertilisation'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly identifies parental care as more commonly extensive in birds and mammals compared to most fish and amphibians?',
          'options': ['Birds and mammals typically invest more time and energy in caring for fewer offspring, increasing individual survival chances', 'Birds and mammals never provide parental care', 'Parental care has no effect on offspring survival', 'Fish and amphibians always provide extensive parental care'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies the general term for animals, like most fish and invertebrates, that produce very large numbers of offspring with little to no parental care (r-selected strategy)?',
          'options': ['r-selected strategy', 'K-selected strategy', 'No such strategy exists', 'Direct development strategy'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies the general term for organisms, like most mammals and birds, that produce fewer offspring but invest heavily in their care and survival (K-selected strategy)?',
          'options': ['K-selected strategy', 'r-selected strategy', 'External fertilisation strategy', 'Oviparous strategy only'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes echolocation, a sensory adaptation used by some mammals like bats and dolphins?',
          'options': ['A method exclusive to birds', 'Using smell only to navigate', 'Using sound waves and their echoes to navigate and locate prey/objects, especially useful in darkness or murky water', 'Using light to detect objects'],
          'correct': 2,
        },
        {
          'question': 'Which of these correctly describes why marine mammals like seals and whales have thick layers of blubber?',
          'options': ['For insulation against cold water temperatures and energy storage', 'For camouflage only', 'Blubber has no functional role', 'For increasing buoyancy only, with no thermal role'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly identifies gill rakers in fish, aiding certain species in filter feeding?',
          'options': ['Structures used for vision', 'Structures used only in reproduction', 'Structures used for excretion only', 'Structures that trap food particles as water passes over the gills'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why many bony fish possess a lateral line system in addition to eyes and ears?',
          'options': ['To function only in air-breathing fish', 'To replace the need for eyes entirely', 'To detect changes in water pressure and movement, complementing other senses for navigation and predator/prey detection', 'To aid only in digestion'],
          'correct': 2,
        },
        {
          'question': 'Which of these best summarises the overall evolutionary trend across chordate classes regarding adaptation to terrestrial life?',
          'options': ['A trend from terrestrial to aquatic life only', 'All chordates remain fully aquatic', 'No trend exists across chordate classes', 'A trend from fully aquatic ancestors (fish) towards increasingly independent terrestrial adaptations seen in amphibians, reptiles, birds, and mammals'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly describes the term \'poikilothermic\', synonymous with ectothermic, applied to fish, amphibians, and reptiles?',
          'options': ['Applies only to warm-blooded animals', 'Body temperature actively regulated internally', 'A term unrelated to temperature regulation', 'Body temperature fluctuates with the surrounding environment'],
          'correct': 3,
        },
        {
          'question': 'Which of these correctly identifies why reptiles are often found basking in the sun?',
          'options': ['To attract prey only', 'To absorb external heat and raise their body temperature, since they cannot generate it internally', 'To aid digestion exclusively, with no thermal benefit', 'To photosynthesize'],
          'correct': 1,
        },
        {
          'question': 'Which of these correctly describes brumation, a state similar to hibernation seen in some reptiles during cold periods?',
          'options': ['A dormant state with reduced metabolic activity to survive cold conditions', 'A term unrelated to reptile biology', 'A period of increased activity in cold weather', 'A reproductive stage only'],
          'correct': 0,
        },
        {
          'question': 'Which of these correctly describes the swim bladder\'s secondary role in some fish, in addition to buoyancy control?',
          'options': ['Vision enhancement', 'Production of digestive enzymes', 'Sound production/reception in some species', 'Excretion of nitrogenous waste'],
          'correct': 2,
        },
      ];
    case 'bio102_u3_3': // Ecology Basics
      return [
        {
          'question': 'Ecology is best defined as the study of?',
          'options': ['Only animal behaviour', 'Only human health', 'Interactions between organisms and their environment', 'Only plants'],
          'correct': 2,
        },
        {
          'question': 'The living components of an ecosystem are collectively called the?',
          'options': ['Habitat only', 'Abiotic factors', 'Niche only', 'Biotic factors'],
          'correct': 3,
        },
        {
          'question': 'The non-living components of an ecosystem, such as temperature and water, are called?',
          'options': ['Consumers', 'Abiotic factors', 'Biotic factors', 'Producers'],
          'correct': 1,
        },
        {
          'question': 'An ecosystem consists of?',
          'options': ['Only decomposers', 'Living organisms interacting with each other and their physical environment', 'Only physical/chemical factors', 'Only living organisms'],
          'correct': 1,
        },
        {
          'question': 'Organisms that make their own food through photosynthesis are called?',
          'options': ['Scavengers', 'Consumers', 'Decomposers', 'Producers'],
          'correct': 3,
        },
        {
          'question': 'Organisms that obtain energy by eating other organisms are called?',
          'options': ['Producers', 'Consumers', 'Autotrophs', 'Photosynthesizers'],
          'correct': 1,
        },
        {
          'question': 'Organisms that break down dead organic matter and recycle nutrients are called?',
          'options': ['Producers', 'Primary consumers', 'Decomposers', 'Herbivores'],
          'correct': 2,
        },
        {
          'question': 'Animals that eat only plants are called?',
          'options': ['Omnivores', 'Herbivores', 'Decomposers', 'Carnivores'],
          'correct': 1,
        },
        {
          'question': 'Animals that eat only other animals are called?',
          'options': ['Carnivores', 'Producers', 'Omnivores', 'Herbivores'],
          'correct': 0,
        },
        {
          'question': 'Animals that eat both plants and animals are called?',
          'options': ['Decomposers', 'Herbivores', 'Omnivores', 'Carnivores'],
          'correct': 2,
        },
        {
          'question': 'A sequence showing the flow of energy from producer to various consumers is called a?',
          'options': ['Ecological pyramid', 'Trophic level', 'Food chain', 'Food web'],
          'correct': 2,
        },
        {
          'question': 'An interconnected network of multiple food chains in an ecosystem is called a?',
          'options': ['Food web', 'Food chain', 'Biome', 'Habitat'],
          'correct': 0,
        },
        {
          'question': 'The position an organism occupies in a food chain is called its?',
          'options': ['Habitat', 'Trophic level', 'Niche only', 'Population'],
          'correct': 1,
        },
        {
          'question': 'Producers occupy which trophic level in a food chain?',
          'options': ['Third', 'First', 'Fourth', 'Second'],
          'correct': 1,
        },
        {
          'question': 'Primary consumers (herbivores) occupy which trophic level?',
          'options': ['First', 'Fourth', 'Second', 'Third'],
          'correct': 2,
        },
        {
          'question': 'Secondary consumers (carnivores that eat herbivores) occupy which trophic level?',
          'options': ['First', 'Second', 'Fourth', 'Third'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes an ecological pyramid of numbers?',
          'options': ['Shows the number of individual organisms at each trophic level', 'Shows only producer numbers', 'Shows only energy flow', 'Shows biomass at each trophic level'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes an ecological pyramid of energy?',
          'options': ['Shows only the number of organisms', 'Shows the amount of energy available at each trophic level, always decreasing upward', 'Shows only biomass', 'Remains constant at every level'],
          'correct': 1,
        },
        {
          'question': 'According to the 10% rule (law of energy transfer), roughly what percentage of energy is transferred from one trophic level to the next?',
          'options': ['50%', '10%', '100%', '1%'],
          'correct': 1,
        },
        {
          'question': 'Most of the energy lost between trophic levels is lost mainly as?',
          'options': ['Heat (through metabolic processes/respiration)', 'Water', 'Light', 'Sound'],
          'correct': 0,
        },
        {
          'question': 'A group of organisms of the same species living in the same area at the same time is called a?',
          'options': ['Community', 'Biome', 'Ecosystem', 'Population'],
          'correct': 3,
        },
        {
          'question': 'All the different populations of various species living and interacting in a given area form a?',
          'options': ['Niche', 'Habitat', 'Population', 'Community'],
          'correct': 3,
        },
        {
          'question': 'The place where an organism normally lives is called its?',
          'options': ['Niche', 'Biome', 'Habitat', 'Population'],
          'correct': 2,
        },
        {
          'question': 'The role and functional position of an organism within its ecosystem, including its interactions, is called its?',
          'options': ['Community', 'Niche', 'Biome', 'Habitat'],
          'correct': 1,
        },
        {
          'question': 'A large geographic area characterised by specific climate and dominant vegetation/animal life is called a?',
          'options': ['Biome', 'Population', 'Habitat', 'Niche'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a biome characterised by low rainfall and sparse vegetation?',
          'options': ['Desert', 'Wetland', 'Rainforest', 'Coral reef'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a biome characterised by dense tree cover and high rainfall/biodiversity?',
          'options': ['Grassland', 'Tundra', 'Tropical rainforest', 'Desert'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an example of a biome characterised by extremely cold temperatures and permanently frozen subsoil?',
          'options': ['Tundra', 'Wetland', 'Savanna', 'Rainforest'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a biome dominated by grasses with scattered trees, common in Africa?',
          'options': ['Savanna (grassland)', 'Desert', 'Tundra', 'Rainforest'],
          'correct': 0,
        },
        {
          'question': 'The largest ecological unit, encompassing all ecosystems on Earth, is called the?',
          'options': ['Habitat', 'Biome', 'Population', 'Biosphere'],
          'correct': 3,
        },
        {
          'question': 'The continuous movement of water between the atmosphere, land, and oceans is called the?',
          'options': ['Nitrogen cycle', 'Water (hydrologic) cycle', 'Carbon cycle', 'Oxygen cycle'],
          'correct': 1,
        },
        {
          'question': 'The process by which carbon moves between the atmosphere, living organisms, and the earth is called the?',
          'options': ['Nitrogen cycle', 'Water cycle', 'Carbon cycle', 'Phosphorus cycle'],
          'correct': 2,
        },
        {
          'question': 'Photosynthesis removes which gas from the atmosphere, playing a key role in the carbon cycle?',
          'options': ['Methane', 'Carbon dioxide', 'Nitrogen', 'Oxygen'],
          'correct': 1,
        },
        {
          'question': 'Respiration and decomposition release which gas into the atmosphere as part of the carbon cycle?',
          'options': ['Hydrogen', 'Nitrogen', 'Carbon dioxide', 'Oxygen'],
          'correct': 2,
        },
        {
          'question': 'The process by which atmospheric nitrogen is converted into a usable form by certain bacteria is called?',
          'options': ['Ammonification', 'Nitrification', 'Denitrification', 'Nitrogen fixation'],
          'correct': 3,
        },
        {
          'question': 'Which organisms are primarily responsible for nitrogen fixation in the soil?',
          'options': ['Viruses', 'Fungi', 'Certain bacteria (e.g., Rhizobium)', 'Protozoans'],
          'correct': 2,
        },
        {
          'question': 'Denitrification is the process by which nitrogen compounds are converted back into?',
          'options': ['Nitrites only', 'Atmospheric nitrogen gas', 'Nitrates', 'Ammonia'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes a symbiotic relationship in ecology?',
          'options': ['A close, long-term interaction between two different species', 'A relationship only between predators and prey', 'A relationship where organisms have no interaction', 'A relationship found only in plants'],
          'correct': 0,
        },
        {
          'question': 'Mutualism is a symbiotic relationship where?',
          'options': ['Both species benefit', 'Both species are harmed', 'One species benefits and the other is harmed', 'One species benefits and the other is unaffected'],
          'correct': 0,
        },
        {
          'question': 'Commensalism is a symbiotic relationship where?',
          'options': ['One species is always harmed', 'Both species benefit', 'One species benefits while the other is neither helped nor harmed', 'Both species are harmed'],
          'correct': 2,
        },
        {
          'question': 'Parasitism is a symbiotic relationship where?',
          'options': ['One species benefits at the expense (harm) of the other', 'Neither species is affected', 'Both species benefit equally', 'Both species benefit'],
          'correct': 0,
        },
        {
          'question': 'Competition in ecology occurs when organisms?',
          'options': ['Never interact', 'Cooperate for mutual benefit', 'Compete for the same limited resources', 'Always benefit each other'],
          'correct': 2,
        },
        {
          'question': 'Predation is an interaction where?',
          'options': ['One organism (predator) kills and eats another (prey)', 'Both organisms benefit', 'Organisms cooperate for food', 'Neither organism is affected'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes intraspecific competition?',
          'options': ['No competition at all', 'Competition between different species', 'Cooperation between species', 'Competition between members of the same species'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes interspecific competition?',
          'options': ['Cooperation within a species', 'Competition between members of the same species', 'Competition between members of different species', 'Predation only'],
          'correct': 2,
        },
        {
          'question': 'The maximum population size that an environment can sustainably support is called the?',
          'options': ['Ecological niche', 'Carrying capacity', 'Population density', 'Birth rate'],
          'correct': 1,
        },
        {
          'question': 'An increase in a population over time due to more births than deaths (plus immigration) reflects?',
          'options': ['Extinction', 'Population growth', 'Population stability only', 'Population decline'],
          'correct': 1,
        },
        {
          'question': 'Which of these factors can limit population growth in an ecosystem?',
          'options': ['Limited resources, disease, predation, and competition', 'Unlimited food and space', 'Constant immigration only', 'Absence of predators only'],
          'correct': 0,
        },
        {
          'question': 'A sudden, significant decline in a population, potentially leading to extinction, can be caused by?',
          'options': ['Habitat destruction, disease, or overhunting', 'Increased biodiversity', 'Improved climate conditions only', 'Abundant resources'],
          'correct': 0,
        },
        {
          'question': 'Biodiversity refers to?',
          'options': ['Only plant diversity', 'Only animal population size', 'The variety of life forms (species, genetic, and ecosystem diversity) within a given area', 'The number of ecosystems only'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why biodiversity is important for ecosystem stability?',
          'options': ['Biodiversity only affects human aesthetics', 'Greater biodiversity generally increases ecosystem resilience and resource availability', 'Biodiversity has no effect on ecosystems', 'Lower biodiversity always improves stability'],
          'correct': 1,
        },
        {
          'question': 'A species whose presence or health reflects the overall condition of an ecosystem is called a/an?',
          'options': ['Invasive species', 'Endangered species', 'Keystone species', 'Indicator species'],
          'correct': 3,
        },
        {
          'question': 'A species that has a disproportionately large effect on its ecosystem relative to its abundance is called a?',
          'options': ['Endemic species', 'Indicator species', 'Keystone species', 'Invasive species'],
          'correct': 2,
        },
        {
          'question': 'A species introduced (often by humans) to a new environment where it causes ecological harm is called an?',
          'options': ['Indicator species', 'Endemic species', 'Endangered species', 'Invasive species'],
          'correct': 3,
        },
        {
          'question': 'A species found naturally only in a specific geographic area and nowhere else is called an?',
          'options': ['Keystone species', 'Endemic species', 'Invasive species', 'Indicator species'],
          'correct': 1,
        },
        {
          'question': 'A species at risk of extinction in the near future is classified as an?',
          'options': ['Endemic species', 'Keystone species', 'Invasive species', 'Endangered species'],
          'correct': 3,
        },
        {
          'question': 'Which of these human activities is a major cause of habitat destruction and biodiversity loss?',
          'options': ['Wildlife conservation', 'Deforestation and urbanisation', 'Sustainable farming', 'Reforestation'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes pollution as a threat to ecosystems?',
          'options': ['A process that always improves biodiversity', 'A natural, harmless process', 'Only relevant to human health, not ecosystems', 'The introduction of harmful substances into the environment, degrading air, water, or soil quality'],
          'correct': 3,
        },
        {
          'question': 'Global warming, largely driven by increased greenhouse gases, primarily affects ecosystems by?',
          'options': ['Having no measurable ecological effect', 'Decreasing average temperatures', 'Increasing average global temperatures and altering climate patterns', 'Only affecting polar regions'],
          'correct': 2,
        },
        {
          'question': 'Which of these gases is a major greenhouse gas contributing to global warming?',
          'options': ['Carbon dioxide', 'Oxygen', 'Helium', 'Nitrogen gas'],
          'correct': 0,
        },
        {
          'question': 'The greenhouse effect refers to?',
          'options': ['Only occurring in greenhouses', 'The cooling of Earth\'s atmosphere', 'A process unrelated to climate', 'The trapping of heat in Earth\'s atmosphere by certain gases, warming the planet'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes ecological succession?',
          'options': ['A process that never occurs in nature', 'A term unrelated to ecosystems', 'A sudden change with no pattern', 'The gradual, predictable change in species composition of a community over time'],
          'correct': 3,
        },
        {
          'question': 'Primary succession occurs in an area that?',
          'options': ['Has never previously supported life (e.g., bare rock)', 'Was recently disturbed but retains soil', 'Previously had a well-established ecosystem', 'Is fully mature already'],
          'correct': 0,
        },
        {
          'question': 'Secondary succession occurs in an area that?',
          'options': ['Is a completely new landform', 'Has never supported life before', 'Previously had an ecosystem that was disturbed or destroyed, but soil remains', 'Cannot support any life'],
          'correct': 2,
        },
        {
          'question': 'Which of these is typically among the first organisms to colonise bare rock during primary succession?',
          'options': ['Large trees', 'Fish', 'Mammals', 'Lichens and mosses (pioneer species)'],
          'correct': 3,
        },
        {
          'question': 'The final, relatively stable community that results from ecological succession is called the?',
          'options': ['Primary community', 'Climax community', 'Extinct community', 'Pioneer community'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes conservation in an ecological context?',
          'options': ['A process unrelated to ecosystems', 'The deliberate destruction of natural resources', 'Only applicable to endangered species', 'The protection and sustainable management of natural resources and biodiversity'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an example of an in-situ conservation method, protecting species within their natural habitat?',
          'options': ['Botanical gardens', 'National parks and wildlife reserves', 'Seed banks', 'Zoos'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an example of an ex-situ conservation method, protecting species outside their natural habitat?',
          'options': ['Protected forests', 'Wildlife reserves', 'National parks', 'Zoos and seed banks'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why the loss of a keystone species can drastically alter an ecosystem?',
          'options': ['Their removal can cause significant cascading effects on other species and ecosystem structure', 'All species have equal ecological impact', 'Ecosystems are unaffected by species loss', 'Keystone species have minimal ecological influence'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes a food chain\'s typical energy source at the base (producer level)?',
          'options': ['Chemical energy from decomposers', 'Energy from consumers', 'No energy source is required', 'Solar (sunlight) energy captured through photosynthesis'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why food chains rarely have more than four or five trophic levels?',
          'options': ['Trophic levels are unrelated to energy availability', 'Energy increases at each level', 'Significant energy loss occurs at each transfer, limiting the energy available to support higher levels', 'Unlimited energy is available at each level'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes bioaccumulation, a phenomenon relevant to ecological pyramids of toxins like pesticides?',
          'options': ['Toxins have no effect on food chains', 'Toxins decrease in concentration up the food chain', 'Toxins only affect producers', 'Toxins can become more concentrated in organisms at higher trophic levels as they accumulate over time'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why apex predators often show higher concentrations of certain pollutants (biomagnification)?',
          'options': ['They consume large amounts of contaminated prey, accumulating toxins passed up through trophic levels', 'They produce toxins themselves', 'Apex predators never accumulate toxins', 'They are unaffected by pollutants entirely'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the term \'limiting factor\' in ecology?',
          'options': ['An environmental factor that restricts the growth, abundance, or distribution of a population', 'A factor with no effect on population growth', 'A factor that only benefits populations', 'A term unrelated to ecosystems'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a density-dependent limiting factor?',
          'options': ['Disease spread, which increases with higher population density', 'Sudden temperature drop affecting all individuals equally', 'A volcanic eruption', 'A random natural disaster'],
          'correct': 0,
        },
        {
          'question': 'Which of these is an example of a density-independent limiting factor?',
          'options': ['Predation rates that increase with prey density', 'Natural disasters like floods or fires, affecting populations regardless of density', 'Disease spread', 'Competition for food'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes mutualism using the example of bees and flowering plants?',
          'options': ['Bees harm plants with no benefit exchanged', 'Bees obtain nectar/pollen for food while pollinating the plants, benefiting both', 'Neither organism benefits', 'Only the plant benefits'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes commensalism using the example of birds nesting in trees?',
          'options': ['Neither organism is affected', 'The tree is harmed while the bird benefits', 'The bird benefits from shelter while the tree is largely unaffected', 'Both organisms are harmed'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes parasitism using the example of a tapeworm in a human intestine?',
          'options': ['Neither organism is affected', 'Both organisms benefit', 'The tapeworm benefits by obtaining nutrients while harming the host', 'The host benefits from the tapeworm'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why decomposers are considered essential to nutrient cycling in ecosystems?',
          'options': ['They only consume living organisms', 'They prevent nutrient cycling', 'They have no ecological role', 'They break down dead organic matter, releasing nutrients back into the soil/environment for reuse by producers'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an example of a decomposer commonly found in ecosystems?',
          'options': ['Eagle', 'Bacteria and fungi', 'Grass', 'Lion'],
          'correct': 1,
        },
        {
          'question': 'Which of these best explains the concept of \'sustainability\' in the context of natural resource use?',
          'options': ['Ignoring environmental impact entirely', 'Using resources faster than they can be replenished', 'Using resources at a rate that allows them to be replenished naturally, ensuring long-term availability', 'A term unrelated to ecosystems'],
          'correct': 2,
        },
        {
          'question': 'Which of these human activities directly contributes to ozone layer depletion, an ecological concern distinct from global warming?',
          'options': ['Deforestation only', 'Overfishing', 'Release of certain chemicals like chlorofluorocarbons (CFCs)', 'Soil erosion'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes eutrophication, a process affecting aquatic ecosystems?',
          'options': ['Excessive nutrient enrichment (often from fertilisers) causing algal blooms and oxygen depletion in water bodies', 'A process that improves water quality', 'A term unrelated to aquatic ecosystems', 'A decrease in nutrients leading to lower productivity'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains why algal blooms resulting from eutrophication can be harmful to aquatic life?',
          'options': ['Algal blooms always benefit aquatic ecosystems', 'They increase oxygen levels excessively', 'They have no impact on oxygen levels', 'Decomposition of dead algae depletes dissolved oxygen, potentially causing die-offs of fish and other aquatic organisms'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes deforestation\'s impact on the carbon cycle?',
          'options': ['Has no effect on atmospheric carbon dioxide', 'Reduces atmospheric carbon dioxide', 'Only affects the nitrogen cycle', 'Reduces carbon dioxide absorption by trees, contributing to higher atmospheric carbon dioxide levels'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the term \'renewable resource\'?',
          'options': ['A resource that cannot be replenished once used', 'A term unrelated to ecology', 'A resource found only underground', 'A resource that can be naturally replenished over a relatively short time (e.g., solar energy, timber with proper management)'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes the term \'non-renewable resource\'?',
          'options': ['A resource that never depletes', 'A resource that exists in finite supply and is not replenished on a human timescale (e.g., fossil fuels)', 'A resource that regenerates quickly', 'A term unrelated to natural resources'],
          'correct': 1,
        },
        {
          'question': 'Which of these is an example of a renewable energy source?',
          'options': ['Petroleum', 'Coal', 'Natural gas', 'Solar energy'],
          'correct': 3,
        },
        {
          'question': 'Which of these is an example of a non-renewable energy source?',
          'options': ['Coal', 'Hydropower', 'Solar energy', 'Wind energy'],
          'correct': 0,
        },
        {
          'question': 'Which of these best explains the importance of wetlands as ecosystems?',
          'options': ['They filter pollutants, provide habitat for diverse species, and help control flooding', 'They only harm surrounding ecosystems', 'They have no ecological value', 'They contribute to desertification'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes the term \'ecological footprint\'?',
          'options': ['A measure of biodiversity alone', 'A term describing animal tracks only', 'A measure unrelated to resource use', 'A measure of an individual\'s or population\'s demand on natural resources relative to Earth\'s capacity to regenerate them'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains why coral reefs are considered highly biodiverse but also highly vulnerable ecosystems?',
          'options': ['They are unaffected by environmental changes', 'They exist only in freshwater', 'They support a huge variety of marine life but are sensitive to changes in temperature, pollution, and ocean acidity', 'They have low biodiversity and are highly resistant to change'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes the overall goal of ecological conservation efforts?',
          'options': ['To maximise short-term resource extraction', 'To maintain biodiversity and ecosystem health for current and future generations through sustainable practices', 'To ignore the effects of human activity on nature', 'To eliminate all human interaction with nature'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes overfishing as an ecological concern?',
          'options': ['A practice with no ecological impact', 'A practice that only benefits marine biodiversity', 'Harvesting fish faster than populations can naturally replenish, threatening marine ecosystems', 'Harvesting fish at a sustainable rate'],
          'correct': 2,
        },
        {
          'question': 'Which of these best explains why invasive species can outcompete native species in a new ecosystem?',
          'options': ['They cannot survive outside their native range', 'They have no impact on native species', 'They are always weaker than native species', 'They often lack natural predators/competitors in the new environment, allowing rapid population growth'],
          'correct': 3,
        },
        {
          'question': 'Which of these best describes bioremediation as an ecological technique?',
          'options': ['A method of increasing pollution', 'Only applicable to air pollution', 'A term unrelated to environmental cleanup', 'The use of organisms (like bacteria) to help remove or neutralise pollutants from an environment'],
          'correct': 3,
        },
        {
          'question': 'Which of these best explains the term \'carbon footprint\'?',
          'options': ['A term unrelated to climate change', 'The total amount of greenhouse gases, expressed as carbon dioxide equivalent, generated by an individual or activity', 'A measure of soil carbon content only', 'The physical footprint left by carbon-based life forms'],
          'correct': 1,
        },
        {
          'question': 'Which of these best describes why protecting keystone species is often a conservation priority?',
          'options': ['They are the least biodiverse species', 'They have minimal ecological importance', 'Their protection has no broader ecosystem benefit', 'Their loss can trigger significant, cascading negative effects throughout the ecosystem'],
          'correct': 3,
        },
      ];
    default:
      return [];
  }
}