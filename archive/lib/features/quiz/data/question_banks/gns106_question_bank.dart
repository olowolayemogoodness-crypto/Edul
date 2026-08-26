// lib/features/quiz/data/question_banks/gns106_question_bank.dart
//
// Additional GNS106 (Philosophy, Logic and Issues in Science and
// Technology) quiz questions, sourced from the 600-question PDF quiz
// bank (40 questions per fine-grained topic, 15 topics). These are
// ADDED ON TOP OF the original 5 questions per topic in
// gns106_lessons.dart for the 9 topics that have base lesson content
// (not a replacement) -- see topic_question_source.dart for how the
// two sources are merged.
//
// NOTE: gns106_u4_1 through gns106_u5_3 (Philosophy of Science through
// Tech Ethics) have NO base lesson content in gns106_lessons.dart yet
// (learning map shows a placeholder for these) -- this bank is the
// ONLY question source for those 6 topics. See topic_question_source.dart
// for how empty base lookups are handled gracefully.
//
// PASSAGE QUESTIONS: within each topic, questions 1-20 are reading-
// passage questions (5 passages x 4 questions) and carry a 'passage'
// key with the source text the question refers to. Questions 21-40
// are standalone conceptual questions with no 'passage' key. The quiz
// UI must render the passage above the question stem when present --
// see QuizQuestion.passage and _QuestionCard in quiz_question_page.dart.
//
// Keyed by the same lessonId used in subjects_data.dart and
// gns106_lessons.dart (e.g. 'gns106_u1_1').

List<Map<String, dynamic>> getGNS106ExtraQuestions(String lessonId) {
  switch (lessonId) {
    case 'gns106_u1_1': // Intro to Philosophy
      return [
        {
          'passage': 'Philosophy comes from the Greek words philos (love) and sophia (wisdom), so it literally means \'love of wisdom.\' Unlike many other disciplines, philosophy does not simply hand down a fixed body of facts to be memorized. Instead, it is best understood as an activity: the disciplined practice of questioning assumptions, clarifying concepts, and constructing or evaluating arguments about fundamental matters such as existence, knowledge, value, and reason. A philosopher may study the same topic as a scientist or a theologian, but characteristically asks a different kind of question — not \'what happened?\' but \'what does it mean, and how do we know?\' Because philosophy probes the assumptions that other fields often take for granted, it is sometimes called the \'discipline of disciplines.\'',
          'question': 'According to the passage, the word \'philosophy\' literally means:',
          'options': ['search for truth', 'study of being', 'knowledge of nature', 'love of wisdom'],
          'correct': 3,
        },
        {
          'passage': 'Philosophy comes from the Greek words philos (love) and sophia (wisdom), so it literally means \'love of wisdom.\' Unlike many other disciplines, philosophy does not simply hand down a fixed body of facts to be memorized. Instead, it is best understood as an activity: the disciplined practice of questioning assumptions, clarifying concepts, and constructing or evaluating arguments about fundamental matters such as existence, knowledge, value, and reason. A philosopher may study the same topic as a scientist or a theologian, but characteristically asks a different kind of question — not \'what happened?\' but \'what does it mean, and how do we know?\' Because philosophy probes the assumptions that other fields often take for granted, it is sometimes called the \'discipline of disciplines.\'',
          'question': 'The passage suggests philosophy is best understood as:',
          'options': ['an activity of questioning and evaluating arguments', 'a branch of natural science', 'a religious practice', 'a fixed body of facts to memorize'],
          'correct': 0,
        },
        {
          'passage': 'Philosophy comes from the Greek words philos (love) and sophia (wisdom), so it literally means \'love of wisdom.\' Unlike many other disciplines, philosophy does not simply hand down a fixed body of facts to be memorized. Instead, it is best understood as an activity: the disciplined practice of questioning assumptions, clarifying concepts, and constructing or evaluating arguments about fundamental matters such as existence, knowledge, value, and reason. A philosopher may study the same topic as a scientist or a theologian, but characteristically asks a different kind of question — not \'what happened?\' but \'what does it mean, and how do we know?\' Because philosophy probes the assumptions that other fields often take for granted, it is sometimes called the \'discipline of disciplines.\'',
          'question': 'According to the passage, what distinguishes a philosopher\'s question from a scientist\'s about the same topic?',
          'options': ['the philosopher relies purely on experiments', 'the philosopher never asks questions', 'the philosopher asks about meaning and how we know, not just what happened', 'the philosopher only studies history'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy comes from the Greek words philos (love) and sophia (wisdom), so it literally means \'love of wisdom.\' Unlike many other disciplines, philosophy does not simply hand down a fixed body of facts to be memorized. Instead, it is best understood as an activity: the disciplined practice of questioning assumptions, clarifying concepts, and constructing or evaluating arguments about fundamental matters such as existence, knowledge, value, and reason. A philosopher may study the same topic as a scientist or a theologian, but characteristically asks a different kind of question — not \'what happened?\' but \'what does it mean, and how do we know?\' Because philosophy probes the assumptions that other fields often take for granted, it is sometimes called the \'discipline of disciplines.\'',
          'question': 'Why does the passage call philosophy the \'discipline of disciplines\'?',
          'options': ['because it probes the assumptions other fields take for granted', 'because it has the most students', 'because it was the first subject ever taught', 'because it replaced all other disciplines Passage 2 One common misconception is that philosophy is purely a matter of opinion, so that \'anything goes\' as long as someone believes it. Professional philosophers reject this view. While philosophical questions often lack a single settled answer in the way that \'2+2=4\' does, philosophical claims are still expected to be supported by reasons, and those reasons can be evaluated as strong or weak, consistent or self-contradictory. A philosophical position that ignores counter-evidence or relies on a fallacy is considered a worse position than one that engages honestly with objections, even though neither may be provable with mathematical certainty. In this sense, philosophy occupies a middle ground: more rigorous than mere personal preference, but more open-ended than settled empirical fact.'],
          'correct': 0,
        },
        {
          'passage': 'One common misconception is that philosophy is purely a matter of opinion, so that \'anything goes\' as long as someone believes it. Professional philosophers reject this view. While philosophical questions often lack a single settled answer in the way that \'2+2=4\' does, philosophical claims are still expected to be supported by reasons, and those reasons can be evaluated as strong or weak, consistent or self-contradictory. A philosophical position that ignores counter-evidence or relies on a fallacy is considered a worse position than one that engages honestly with objections, even though neither may be provable with mathematical certainty. In this sense, philosophy occupies a middle ground: more rigorous than mere personal preference, but more open-ended than settled empirical fact.',
          'question': 'The passage argues that philosophy is NOT simply a matter of:',
          'options': ['opinion where anything goes', 'careful definition', 'logical consistency', 'reasoned argument'],
          'correct': 0,
        },
        {
          'passage': 'One common misconception is that philosophy is purely a matter of opinion, so that \'anything goes\' as long as someone believes it. Professional philosophers reject this view. While philosophical questions often lack a single settled answer in the way that \'2+2=4\' does, philosophical claims are still expected to be supported by reasons, and those reasons can be evaluated as strong or weak, consistent or self-contradictory. A philosophical position that ignores counter-evidence or relies on a fallacy is considered a worse position than one that engages honestly with objections, even though neither may be provable with mathematical certainty. In this sense, philosophy occupies a middle ground: more rigorous than mere personal preference, but more open-ended than settled empirical fact.',
          'question': 'According to the passage, what happens to a philosophical position that relies on a fallacy?',
          'options': ['it becomes mathematically certain', 'it is automatically the correct one', 'it stops being philosophy', 'it is considered a worse position'],
          'correct': 3,
        },
        {
          'passage': 'One common misconception is that philosophy is purely a matter of opinion, so that \'anything goes\' as long as someone believes it. Professional philosophers reject this view. While philosophical questions often lack a single settled answer in the way that \'2+2=4\' does, philosophical claims are still expected to be supported by reasons, and those reasons can be evaluated as strong or weak, consistent or self-contradictory. A philosophical position that ignores counter-evidence or relies on a fallacy is considered a worse position than one that engages honestly with objections, even though neither may be provable with mathematical certainty. In this sense, philosophy occupies a middle ground: more rigorous than mere personal preference, but more open-ended than settled empirical fact.',
          'question': 'The passage describes philosophy as occupying:',
          'options': ['the same certainty as mathematics', 'pure guesswork with no standards', 'a middle ground between personal preference and settled empirical fact', 'a subset of religious doctrine'],
          'correct': 2,
        },
        {
          'passage': 'One common misconception is that philosophy is purely a matter of opinion, so that \'anything goes\' as long as someone believes it. Professional philosophers reject this view. While philosophical questions often lack a single settled answer in the way that \'2+2=4\' does, philosophical claims are still expected to be supported by reasons, and those reasons can be evaluated as strong or weak, consistent or self-contradictory. A philosophical position that ignores counter-evidence or relies on a fallacy is considered a worse position than one that engages honestly with objections, even though neither may be provable with mathematical certainty. In this sense, philosophy occupies a middle ground: more rigorous than mere personal preference, but more open-ended than settled empirical fact.',
          'question': 'Which of the following best reflects the passage\'s view of philosophical claims?',
          'options': ['they are always provable like equations', 'they require no justification at all', 'they are true simply because someone holds them', 'they must be supported by reasons that can be evaluated Passage 3 Philosophy is often traced to a shift, beginning in ancient Greece around the 6th century BCE, from mythological explanations of the world to explanations grounded in reason and observation. Early thinkers such as Thales asked what the fundamental substance of the universe was, and instead of appealing to the will of the gods, proposed natural explanations — Thales famously suggested it was water. This shift did not mean religion disappeared, but it introduced a new expectation: that claims about the world should be defended with arguments others could examine and challenge, rather than accepted purely on authority or tradition. This expectation of open, examinable reasoning remains a defining feature of philosophical practice today.'],
          'correct': 3,
        },
        {
          'passage': 'Philosophy is often traced to a shift, beginning in ancient Greece around the 6th century BCE, from mythological explanations of the world to explanations grounded in reason and observation. Early thinkers such as Thales asked what the fundamental substance of the universe was, and instead of appealing to the will of the gods, proposed natural explanations — Thales famously suggested it was water. This shift did not mean religion disappeared, but it introduced a new expectation: that claims about the world should be defended with arguments others could examine and challenge, rather than accepted purely on authority or tradition. This expectation of open, examinable reasoning remains a defining feature of philosophical practice today.',
          'question': 'According to the passage, what shift is philosophy often traced to?',
          'options': ['a shift from writing to oral tradition', 'a shift from Greek to Latin language', 'a shift from mythological explanation to explanation grounded in reason and observation', 'a shift from science to religion'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy is often traced to a shift, beginning in ancient Greece around the 6th century BCE, from mythological explanations of the world to explanations grounded in reason and observation. Early thinkers such as Thales asked what the fundamental substance of the universe was, and instead of appealing to the will of the gods, proposed natural explanations — Thales famously suggested it was water. This shift did not mean religion disappeared, but it introduced a new expectation: that claims about the world should be defended with arguments others could examine and challenge, rather than accepted purely on authority or tradition. This expectation of open, examinable reasoning remains a defining feature of philosophical practice today.',
          'question': 'What did Thales propose as the fundamental substance of the universe, according to the passage?',
          'options': ['air', 'atoms', 'water', 'fire'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy is often traced to a shift, beginning in ancient Greece around the 6th century BCE, from mythological explanations of the world to explanations grounded in reason and observation. Early thinkers such as Thales asked what the fundamental substance of the universe was, and instead of appealing to the will of the gods, proposed natural explanations — Thales famously suggested it was water. This shift did not mean religion disappeared, but it introduced a new expectation: that claims about the world should be defended with arguments others could examine and challenge, rather than accepted purely on authority or tradition. This expectation of open, examinable reasoning remains a defining feature of philosophical practice today.',
          'question': 'According to the passage, the new expectation introduced by this shift was that claims should be:',
          'options': ['kept secret from the public', 'accepted purely on authority or tradition', 'defended with arguments others could examine and challenge', 'proven only through religious ritual'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy is often traced to a shift, beginning in ancient Greece around the 6th century BCE, from mythological explanations of the world to explanations grounded in reason and observation. Early thinkers such as Thales asked what the fundamental substance of the universe was, and instead of appealing to the will of the gods, proposed natural explanations — Thales famously suggested it was water. This shift did not mean religion disappeared, but it introduced a new expectation: that claims about the world should be defended with arguments others could examine and challenge, rather than accepted purely on authority or tradition. This expectation of open, examinable reasoning remains a defining feature of philosophical practice today.',
          'question': 'Did this shift, according to the passage, mean religion disappeared?',
          'options': ['The passage does not mention religion', 'Yes, but only in Greece', 'Yes, religion disappeared entirely', 'No, the passage says it did not mean religion disappeared Passage 4 A useful way to see what philosophy does is to notice how it treats a term everyone uses but few stop to define, such as \'justice\' or \'knowledge.\' In ordinary conversation, we assume we already understand such words. A philosopher, by contrast, treats the ordinary use of a term as a starting point for inquiry rather than an endpoint: what exactly must be true for a belief to count as \'knowledge\' rather than a lucky guess? What separates a \'just\' distribution of resources from an unjust one? This process of pressing on familiar concepts until their hidden assumptions and ambiguities become visible is sometimes called conceptual analysis, and it is one of philosophy\'s most characteristic tools.'],
          'correct': 3,
        },
        {
          'passage': 'A useful way to see what philosophy does is to notice how it treats a term everyone uses but few stop to define, such as \'justice\' or \'knowledge.\' In ordinary conversation, we assume we already understand such words. A philosopher, by contrast, treats the ordinary use of a term as a starting point for inquiry rather than an endpoint: what exactly must be true for a belief to count as \'knowledge\' rather than a lucky guess? What separates a \'just\' distribution of resources from an unjust one? This process of pressing on familiar concepts until their hidden assumptions and ambiguities become visible is sometimes called conceptual analysis, and it is one of philosophy\'s most characteristic tools.',
          'question': 'According to the passage, how does a philosopher treat the ordinary use of a term like \'justice\'?',
          'options': ['as a word with no real meaning', 'as something that needs no further examination', 'as a topic only scientists can study', 'as a starting point for inquiry rather than an endpoint'],
          'correct': 3,
        },
        {
          'passage': 'A useful way to see what philosophy does is to notice how it treats a term everyone uses but few stop to define, such as \'justice\' or \'knowledge.\' In ordinary conversation, we assume we already understand such words. A philosopher, by contrast, treats the ordinary use of a term as a starting point for inquiry rather than an endpoint: what exactly must be true for a belief to count as \'knowledge\' rather than a lucky guess? What separates a \'just\' distribution of resources from an unjust one? This process of pressing on familiar concepts until their hidden assumptions and ambiguities become visible is sometimes called conceptual analysis, and it is one of philosophy\'s most characteristic tools.',
          'question': 'The passage\'s example question about knowledge asks:',
          'options': ['how fast can someone learn a fact', 'how many types of knowledge exist', 'who invented the concept of knowledge', 'what must be true for a belief to count as knowledge rather than a lucky guess'],
          'correct': 3,
        },
        {
          'passage': 'A useful way to see what philosophy does is to notice how it treats a term everyone uses but few stop to define, such as \'justice\' or \'knowledge.\' In ordinary conversation, we assume we already understand such words. A philosopher, by contrast, treats the ordinary use of a term as a starting point for inquiry rather than an endpoint: what exactly must be true for a belief to count as \'knowledge\' rather than a lucky guess? What separates a \'just\' distribution of resources from an unjust one? This process of pressing on familiar concepts until their hidden assumptions and ambiguities become visible is sometimes called conceptual analysis, and it is one of philosophy\'s most characteristic tools.',
          'question': 'What is the name given in the passage to the process of pressing on familiar concepts to reveal hidden assumptions?',
          'options': ['historical narrative', 'empirical observation', 'conceptual analysis', 'logical deduction'],
          'correct': 2,
        },
        {
          'passage': 'A useful way to see what philosophy does is to notice how it treats a term everyone uses but few stop to define, such as \'justice\' or \'knowledge.\' In ordinary conversation, we assume we already understand such words. A philosopher, by contrast, treats the ordinary use of a term as a starting point for inquiry rather than an endpoint: what exactly must be true for a belief to count as \'knowledge\' rather than a lucky guess? What separates a \'just\' distribution of resources from an unjust one? This process of pressing on familiar concepts until their hidden assumptions and ambiguities become visible is sometimes called conceptual analysis, and it is one of philosophy\'s most characteristic tools.',
          'question': 'According to the passage, conceptual analysis is described as:',
          'options': ['one of philosophy\'s most characteristic tools', 'a rare and rarely used method', 'a technique invented by scientists', 'identical to mathematical proof Passage 5 Some people ask why philosophy matters if it rarely produces a final, agreed-upon answer. One reply is that philosophical inquiry is valuable partly because of the skills it builds along the way: the ability to state a position clearly, to anticipate objections, to distinguish a good argument from a merely persuasive one, and to revise a view in light of new reasons rather than defend it out of stubbornness. These skills transfer well beyond formal philosophy classes — into law, science, public debate, and everyday decision-making. A second reply is that many disciplines we take for granted today, including physics and psychology, began as branches of philosophy before developing their own specialized methods and separating into independent fields.'],
          'correct': 0,
        },
        {
          'passage': 'Some people ask why philosophy matters if it rarely produces a final, agreed-upon answer. One reply is that philosophical inquiry is valuable partly because of the skills it builds along the way: the ability to state a position clearly, to anticipate objections, to distinguish a good argument from a merely persuasive one, and to revise a view in light of new reasons rather than defend it out of stubbornness. These skills transfer well beyond formal philosophy classes — into law, science, public debate, and everyday decision-making. A second reply is that many disciplines we take for granted today, including physics and psychology, began as branches of philosophy before developing their own specialized methods and separating into independent fields.',
          'question': 'According to the passage, one reason philosophy matters is:',
          'options': ['the skills it builds, such as stating positions clearly and evaluating arguments', 'it guarantees financial success', 'it always produces a final, agreed-upon answer', 'it eliminates the need for other subjects'],
          'correct': 0,
        },
        {
          'passage': 'Some people ask why philosophy matters if it rarely produces a final, agreed-upon answer. One reply is that philosophical inquiry is valuable partly because of the skills it builds along the way: the ability to state a position clearly, to anticipate objections, to distinguish a good argument from a merely persuasive one, and to revise a view in light of new reasons rather than defend it out of stubbornness. These skills transfer well beyond formal philosophy classes — into law, science, public debate, and everyday decision-making. A second reply is that many disciplines we take for granted today, including physics and psychology, began as branches of philosophy before developing their own specialized methods and separating into independent fields.',
          'question': 'The passage lists physics and psychology as examples of fields that:',
          'options': ['were never related to philosophy', 'replaced philosophy entirely', 'are identical to philosophy today', 'began as branches of philosophy before becoming independent'],
          'correct': 3,
        },
        {
          'passage': 'Some people ask why philosophy matters if it rarely produces a final, agreed-upon answer. One reply is that philosophical inquiry is valuable partly because of the skills it builds along the way: the ability to state a position clearly, to anticipate objections, to distinguish a good argument from a merely persuasive one, and to revise a view in light of new reasons rather than defend it out of stubbornness. These skills transfer well beyond formal philosophy classes — into law, science, public debate, and everyday decision-making. A second reply is that many disciplines we take for granted today, including physics and psychology, began as branches of philosophy before developing their own specialized methods and separating into independent fields.',
          'question': 'According to the passage, a valuable philosophical skill is the ability to revise a view based on:',
          'options': ['new reasons, rather than defending it out of stubbornness', 'popular opinion alone', 'whichever view is easiest to defend', 'the loudest argument in a room'],
          'correct': 0,
        },
        {
          'passage': 'Some people ask why philosophy matters if it rarely produces a final, agreed-upon answer. One reply is that philosophical inquiry is valuable partly because of the skills it builds along the way: the ability to state a position clearly, to anticipate objections, to distinguish a good argument from a merely persuasive one, and to revise a view in light of new reasons rather than defend it out of stubbornness. These skills transfer well beyond formal philosophy classes — into law, science, public debate, and everyday decision-making. A second reply is that many disciplines we take for granted today, including physics and psychology, began as branches of philosophy before developing their own specialized methods and separating into independent fields.',
          'question': 'Where does the passage say these philosophical skills transfer to?',
          'options': ['only ancient Greek city-states', 'only university philosophy departments', 'law, science, public debate, and everyday decision-making', 'nowhere outside of philosophy'],
          'correct': 2,
        },
        {
          'question': 'Philosophy is generally divided into major branches; which of the following is typically NOT considered one of them?',
          'options': ['epistemology', 'cartography', 'metaphysics', 'ethics'],
          'correct': 1,
        },
        {
          'question': 'The term \'philosopher\' was reportedly first used, in a modest sense, by which ancient Greek thinker?',
          'options': ['Socrates', 'Plato', 'Pythagoras', 'Aristotle'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the relationship between philosophy and critical thinking?',
          'options': ['critical thinking replaced philosophy in modern times', 'philosophy discourages critical thinking', 'critical thinking is a core skill philosophy trains and depends on', 'they are entirely unrelated fields'],
          'correct': 2,
        },
        {
          'question': 'A key feature distinguishing philosophical questions from many everyday questions is that they are often:',
          'options': ['trivial and easily answered', 'fundamental and not resolvable by simple observation alone', 'irrelevant to daily life', 'answerable only by children'],
          'correct': 1,
        },
        {
          'question': 'Socrates is best known for a method of inquiry involving:',
          'options': ['conducting laboratory experiments', 'writing extensive systematic treatises', 'asking a series of probing questions to expose contradictions in a person\'s beliefs', 'translating religious texts'],
          'correct': 2,
        },
        {
          'question': 'The famous phrase \'the unexamined life is not worth living\' is attributed to:',
          'options': ['Socrates', 'Aristotle', 'Descartes', 'Plato'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes \'metaphysics\' as a branch of philosophy?',
          'options': ['the study of valid reasoning', 'the study of beauty and art', 'the study of the fundamental nature of reality and existence', 'the study of right and wrong conduct'],
          'correct': 2,
        },
        {
          'question': 'Which of these best describes \'epistemology\' as a branch of philosophy?',
          'options': ['the study of knowledge, belief, and justification', 'the study of language origins', 'the study of the physical universe', 'the study of political systems'],
          'correct': 0,
        },
        {
          'question': 'Which of these best describes \'ethics\' as a branch of philosophy?',
          'options': ['the study of formal logical systems', 'the study of scientific method', 'the study of historical events', 'the study of morality, right conduct, and value'],
          'correct': 3,
        },
        {
          'question': 'Philosophy is often distinguished from religion mainly by its emphasis on:',
          'options': ['reasoned argument open to challenge, rather than appeal to revealed authority alone', 'total agreement among all philosophers', 'complete rejection of all belief in the divine', 'refusal to discuss moral questions'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is a hallmark of doing philosophy well?',
          'options': ['avoiding all counterarguments', 'assuming one\'s own view is obviously correct', 'using as many technical words as possible', 'clearly defining key terms before arguing about them'],
          'correct': 3,
        },
        {
          'question': 'A \'thought experiment\' in philosophy is best described as:',
          'options': ['a historical event used as evidence', 'a physical laboratory procedure', 'an imagined scenario used to test intuitions about a concept or principle', 'a survey of public opinion'],
          'correct': 2,
        },
        {
          'question': 'Which of these is an example of a classic philosophical thought experiment?',
          'options': ['the Michelson-Morley experiment', 'the Milgram experiment', 'the double-slit experiment', 'the trolley problem'],
          'correct': 3,
        },
        {
          'question': 'Compared to science, philosophy typically relies less on:',
          'options': ['conceptual clarity', 'logical argumentation', 'controlled empirical experimentation', 'careful reasoning'],
          'correct': 2,
        },
        {
          'question': 'The \'Pre-Socratic\' philosophers are so named because they:',
          'options': ['were all students of Socrates', 'lived after Socrates but disagreed with him', 'philosophized before or around the same time as Socrates, focused mainly on nature', 'rejected the existence of Socrates'],
          'correct': 2,
        },
        {
          'question': 'A philosophical \'argument,\' in the technical sense, refers to:',
          'options': ['a heated disagreement between two people', 'a set of premises offered in support of a conclusion', 'any statement made with confidence', 'a purely emotional appeal'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best distinguishes a valid argument from a sound one?',
          'options': ['a sound argument does not need to be valid', 'a valid argument always has true premises', 'a sound argument must be valid AND have true premises, while a valid argument just has a conclusion that follows from its premises', 'they are exactly the same thing'],
          'correct': 2,
        },
        {
          'question': 'Philosophy\'s traditional aim of pursuing \'wisdom\' is generally understood to involve:',
          'options': ['winning arguments regardless of truth', 'memorizing as many facts as possible', 'avoiding all difficult questions', 'understanding how to live well and reason clearly, not merely accumulating facts'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is NOT a typical goal of introductory philosophical study?',
          'options': ['learning to identify hidden assumptions', 'developing clearer reasoning skills', 'achieving unanimous agreement on every question studied', 'understanding competing perspectives on fundamental questions'],
          'correct': 2,
        },
        {
          'question': 'The claim that philosophy \'begins in wonder\' is most associated with:',
          'options': ['Confucius', 'Karl Marx', 'René Descartes', 'Aristotle'],
          'correct': 3,
        },
      ];
    case 'gns106_u1_2': // Rational Inquiry
      return [
        {
          'passage': 'Rational inquiry is the practice of forming and revising beliefs on the basis of reasons and evidence rather than habit, wishful thinking, or social pressure. It does not require that a person feel certain; in fact, a hallmark of rational inquiry is a willingness to hold beliefs with a degree of confidence proportional to the strength of the evidence available, and to change one\'s mind when better evidence or arguments appear. This contrasts with dogmatism, in which a belief is held regardless of what counter-evidence emerges. Rational inquiry is not limited to formal academic settings; it can guide everyday decisions, such as evaluating whether a news claim is credible before sharing it.',
          'question': 'According to the passage, rational inquiry forms beliefs on the basis of:',
          'options': ['reasons and evidence', 'habit and wishful thinking', 'social pressure alone', 'random chance'],
          'correct': 0,
        },
        {
          'passage': 'Rational inquiry is the practice of forming and revising beliefs on the basis of reasons and evidence rather than habit, wishful thinking, or social pressure. It does not require that a person feel certain; in fact, a hallmark of rational inquiry is a willingness to hold beliefs with a degree of confidence proportional to the strength of the evidence available, and to change one\'s mind when better evidence or arguments appear. This contrasts with dogmatism, in which a belief is held regardless of what counter-evidence emerges. Rational inquiry is not limited to formal academic settings; it can guide everyday decisions, such as evaluating whether a news claim is credible before sharing it.',
          'question': 'According to the passage, a hallmark of rational inquiry is holding beliefs:',
          'options': ['based only on how popular they are', 'with confidence proportional to the strength of available evidence', 'without ever changing one\'s mind', 'with absolute certainty at all times'],
          'correct': 1,
        },
        {
          'passage': 'Rational inquiry is the practice of forming and revising beliefs on the basis of reasons and evidence rather than habit, wishful thinking, or social pressure. It does not require that a person feel certain; in fact, a hallmark of rational inquiry is a willingness to hold beliefs with a degree of confidence proportional to the strength of the evidence available, and to change one\'s mind when better evidence or arguments appear. This contrasts with dogmatism, in which a belief is held regardless of what counter-evidence emerges. Rational inquiry is not limited to formal academic settings; it can guide everyday decisions, such as evaluating whether a news claim is credible before sharing it.',
          'question': 'The passage contrasts rational inquiry with:',
          'options': ['empiricism', 'logic', 'skepticism', 'dogmatism'],
          'correct': 3,
        },
        {
          'passage': 'Rational inquiry is the practice of forming and revising beliefs on the basis of reasons and evidence rather than habit, wishful thinking, or social pressure. It does not require that a person feel certain; in fact, a hallmark of rational inquiry is a willingness to hold beliefs with a degree of confidence proportional to the strength of the evidence available, and to change one\'s mind when better evidence or arguments appear. This contrasts with dogmatism, in which a belief is held regardless of what counter-evidence emerges. Rational inquiry is not limited to formal academic settings; it can guide everyday decisions, such as evaluating whether a news claim is credible before sharing it.',
          'question': 'According to the passage, where can rational inquiry be applied?',
          'options': ['only in scientific laboratories', 'only in academic philosophy departments', 'only in legal courtrooms', 'everyday decisions, such as evaluating whether a news claim is credible Passage 2 A central tool of rational inquiry is the distinction between a claim\'s truth and the strength of the argument offered for it. It is possible to offer a weak argument for a true conclusion, just as it is possible to offer a persuasive-sounding but flawed argument for a false conclusion. Rational inquiry asks us to evaluate arguments on their own terms — checking whether the premises are plausible and whether the conclusion actually follows from them — rather than simply accepting a conclusion because we already agree with it, or rejecting it because we dislike it. This discipline of separating what we want to be true from what the evidence supports is often the hardest part of rational inquiry to practice consistently.'],
          'correct': 3,
        },
        {
          'passage': 'A central tool of rational inquiry is the distinction between a claim\'s truth and the strength of the argument offered for it. It is possible to offer a weak argument for a true conclusion, just as it is possible to offer a persuasive-sounding but flawed argument for a false conclusion. Rational inquiry asks us to evaluate arguments on their own terms — checking whether the premises are plausible and whether the conclusion actually follows from them — rather than simply accepting a conclusion because we already agree with it, or rejecting it because we dislike it. This discipline of separating what we want to be true from what the evidence supports is often the hardest part of rational inquiry to practice consistently.',
          'question': 'According to the passage, what is possible even for a true conclusion?',
          'options': ['it can be supported by a weak argument', 'it cannot be stated clearly', 'it can never be doubted', 'it always has flawless supporting arguments'],
          'correct': 0,
        },
        {
          'passage': 'A central tool of rational inquiry is the distinction between a claim\'s truth and the strength of the argument offered for it. It is possible to offer a weak argument for a true conclusion, just as it is possible to offer a persuasive-sounding but flawed argument for a false conclusion. Rational inquiry asks us to evaluate arguments on their own terms — checking whether the premises are plausible and whether the conclusion actually follows from them — rather than simply accepting a conclusion because we already agree with it, or rejecting it because we dislike it. This discipline of separating what we want to be true from what the evidence supports is often the hardest part of rational inquiry to practice consistently.',
          'question': 'Rational inquiry asks us to evaluate arguments by checking:',
          'options': ['whether the argument sounds persuasive', 'whether the speaker is likeable', 'whether the premises are plausible and the conclusion follows from them', 'whether we already agree with the conclusion'],
          'correct': 2,
        },
        {
          'passage': 'A central tool of rational inquiry is the distinction between a claim\'s truth and the strength of the argument offered for it. It is possible to offer a weak argument for a true conclusion, just as it is possible to offer a persuasive-sounding but flawed argument for a false conclusion. Rational inquiry asks us to evaluate arguments on their own terms — checking whether the premises are plausible and whether the conclusion actually follows from them — rather than simply accepting a conclusion because we already agree with it, or rejecting it because we dislike it. This discipline of separating what we want to be true from what the evidence supports is often the hardest part of rational inquiry to practice consistently.',
          'question': 'According to the passage, what is often the hardest part of rational inquiry to practice consistently?',
          'options': ['reading quickly', 'memorizing definitions', 'separating what we want to be true from what the evidence supports', 'avoiding all disagreement'],
          'correct': 2,
        },
        {
          'passage': 'A central tool of rational inquiry is the distinction between a claim\'s truth and the strength of the argument offered for it. It is possible to offer a weak argument for a true conclusion, just as it is possible to offer a persuasive-sounding but flawed argument for a false conclusion. Rational inquiry asks us to evaluate arguments on their own terms — checking whether the premises are plausible and whether the conclusion actually follows from them — rather than simply accepting a conclusion because we already agree with it, or rejecting it because we dislike it. This discipline of separating what we want to be true from what the evidence supports is often the hardest part of rational inquiry to practice consistently.',
          'question': 'The passage warns against accepting a conclusion merely because:',
          'options': ['the premises are plausible', 'we already agree with it', 'it has been carefully argued for', 'it follows logically from true premises Passage 3 Two broad methods are often associated with rational inquiry: deduction and induction. Deductive reasoning moves from general premises to a specific conclusion that is guaranteed to be true if the premises are true — for example, \'All mammals are warm-blooded; a whale is a mammal; therefore a whale is warm-blooded.\' Inductive reasoning, by contrast, moves from specific observations to a general conclusion that is probable but not guaranteed — for example, observing many swans that are white and concluding that swans are probably white. Rational inquiry uses both methods, but a careful thinker distinguishes between them, since treating an inductive conclusion as though it had deductive certainty is a common source of overconfident belief.'],
          'correct': 1,
        },
        {
          'passage': 'Two broad methods are often associated with rational inquiry: deduction and induction. Deductive reasoning moves from general premises to a specific conclusion that is guaranteed to be true if the premises are true — for example, \'All mammals are warm-blooded; a whale is a mammal; therefore a whale is warm-blooded.\' Inductive reasoning, by contrast, moves from specific observations to a general conclusion that is probable but not guaranteed — for example, observing many swans that are white and concluding that swans are probably white. Rational inquiry uses both methods, but a careful thinker distinguishes between them, since treating an inductive conclusion as though it had deductive certainty is a common source of overconfident belief.',
          'question': 'According to the passage, deductive reasoning moves from:',
          'options': ['general premises to a specific conclusion guaranteed true if premises are true', 'emotion to belief', 'one opinion to another opinion', 'specific observations to a probable general conclusion'],
          'correct': 0,
        },
        {
          'passage': 'Two broad methods are often associated with rational inquiry: deduction and induction. Deductive reasoning moves from general premises to a specific conclusion that is guaranteed to be true if the premises are true — for example, \'All mammals are warm-blooded; a whale is a mammal; therefore a whale is warm-blooded.\' Inductive reasoning, by contrast, moves from specific observations to a general conclusion that is probable but not guaranteed — for example, observing many swans that are white and concluding that swans are probably white. Rational inquiry uses both methods, but a careful thinker distinguishes between them, since treating an inductive conclusion as though it had deductive certainty is a common source of overconfident belief.',
          'question': 'According to the passage, inductive reasoning produces a conclusion that is:',
          'options': ['always guaranteed true', 'probable but not guaranteed', 'always false', 'irrelevant to evidence'],
          'correct': 1,
        },
        {
          'passage': 'Two broad methods are often associated with rational inquiry: deduction and induction. Deductive reasoning moves from general premises to a specific conclusion that is guaranteed to be true if the premises are true — for example, \'All mammals are warm-blooded; a whale is a mammal; therefore a whale is warm-blooded.\' Inductive reasoning, by contrast, moves from specific observations to a general conclusion that is probable but not guaranteed — for example, observing many swans that are white and concluding that swans are probably white. Rational inquiry uses both methods, but a careful thinker distinguishes between them, since treating an inductive conclusion as though it had deductive certainty is a common source of overconfident belief.',
          'question': 'The passage\'s example of inductive reasoning involves:',
          'options': ['a definition of a word', 'observing many white swans and concluding swans are probably white', 'a syllogism about mammals', 'a mathematical proof'],
          'correct': 1,
        },
        {
          'passage': 'Two broad methods are often associated with rational inquiry: deduction and induction. Deductive reasoning moves from general premises to a specific conclusion that is guaranteed to be true if the premises are true — for example, \'All mammals are warm-blooded; a whale is a mammal; therefore a whale is warm-blooded.\' Inductive reasoning, by contrast, moves from specific observations to a general conclusion that is probable but not guaranteed — for example, observing many swans that are white and concluding that swans are probably white. Rational inquiry uses both methods, but a careful thinker distinguishes between them, since treating an inductive conclusion as though it had deductive certainty is a common source of overconfident belief.',
          'question': 'According to the passage, a common source of overconfident belief is:',
          'options': ['treating an inductive conclusion as though it had deductive certainty', 'ignoring all evidence', 'using deduction at all', 'observing too many examples Passage 4 Rational inquiry also depends on intellectual virtues — habits of mind that make good reasoning more likely. These include intellectual humility (recognizing the limits of one\'s own knowledge), open-mindedness (genuinely considering opposing views rather than dismissing them outright), and intellectual courage (being willing to hold or state an unpopular but well-supported position). None of these virtues requires abandoning one\'s standards of evidence; open-mindedness, for instance, does not mean treating every claim as equally credible. Rather, these virtues describe the disposition needed to apply standards of evidence fairly, including to one\'s own cherished beliefs, which are often the hardest to scrutinize objectively.'],
          'correct': 0,
        },
        {
          'passage': 'Rational inquiry also depends on intellectual virtues — habits of mind that make good reasoning more likely. These include intellectual humility (recognizing the limits of one\'s own knowledge), open-mindedness (genuinely considering opposing views rather than dismissing them outright), and intellectual courage (being willing to hold or state an unpopular but well-supported position). None of these virtues requires abandoning one\'s standards of evidence; open-mindedness, for instance, does not mean treating every claim as equally credible. Rather, these virtues describe the disposition needed to apply standards of evidence fairly, including to one\'s own cherished beliefs, which are often the hardest to scrutinize objectively.',
          'question': 'According to the passage, intellectual humility means:',
          'options': ['recognizing the limits of one\'s own knowledge', 'refusing to state any position', 'avoiding disagreement at all costs', 'believing all opinions are equally valid'],
          'correct': 0,
        },
        {
          'passage': 'Rational inquiry also depends on intellectual virtues — habits of mind that make good reasoning more likely. These include intellectual humility (recognizing the limits of one\'s own knowledge), open-mindedness (genuinely considering opposing views rather than dismissing them outright), and intellectual courage (being willing to hold or state an unpopular but well-supported position). None of these virtues requires abandoning one\'s standards of evidence; open-mindedness, for instance, does not mean treating every claim as equally credible. Rather, these virtues describe the disposition needed to apply standards of evidence fairly, including to one\'s own cherished beliefs, which are often the hardest to scrutinize objectively.',
          'question': 'According to the passage, open-mindedness does NOT mean:',
          'options': ['being willing to change one\'s mind', 'applying standards of evidence fairly', 'treating every claim as equally credible', 'genuinely considering opposing views'],
          'correct': 2,
        },
        {
          'passage': 'Rational inquiry also depends on intellectual virtues — habits of mind that make good reasoning more likely. These include intellectual humility (recognizing the limits of one\'s own knowledge), open-mindedness (genuinely considering opposing views rather than dismissing them outright), and intellectual courage (being willing to hold or state an unpopular but well-supported position). None of these virtues requires abandoning one\'s standards of evidence; open-mindedness, for instance, does not mean treating every claim as equally credible. Rather, these virtues describe the disposition needed to apply standards of evidence fairly, including to one\'s own cherished beliefs, which are often the hardest to scrutinize objectively.',
          'question': 'According to the passage, intellectual courage involves:',
          'options': ['always agreeing with the majority', 'being willing to hold or state an unpopular but well-supported position', 'avoiding controversial topics entirely', 'abandoning evidence in favor of popularity'],
          'correct': 1,
        },
        {
          'passage': 'Rational inquiry also depends on intellectual virtues — habits of mind that make good reasoning more likely. These include intellectual humility (recognizing the limits of one\'s own knowledge), open-mindedness (genuinely considering opposing views rather than dismissing them outright), and intellectual courage (being willing to hold or state an unpopular but well-supported position). None of these virtues requires abandoning one\'s standards of evidence; open-mindedness, for instance, does not mean treating every claim as equally credible. Rather, these virtues describe the disposition needed to apply standards of evidence fairly, including to one\'s own cherished beliefs, which are often the hardest to scrutinize objectively.',
          'question': 'According to the passage, which beliefs are often hardest to scrutinize objectively?',
          'options': ['beliefs about historical events', 'beliefs found in textbooks', 'beliefs held by strangers', 'one\'s own cherished beliefs Passage 5 A frequent obstacle to rational inquiry is confirmation bias: the tendency to notice, seek out, and remember information that supports what we already believe, while overlooking or discounting evidence that challenges it. Confirmation bias operates largely below conscious awareness, which is part of why it is so persistent — a person affected by it typically feels that they are simply \'following the evidence,\' even while unconsciously filtering that evidence. Strategies for counteracting confirmation bias include deliberately seeking out the strongest versions of opposing arguments, asking what evidence would change one\'s mind before looking for it, and inviting critique from people who are likely to disagree.'],
          'correct': 3,
        },
        {
          'passage': 'A frequent obstacle to rational inquiry is confirmation bias: the tendency to notice, seek out, and remember information that supports what we already believe, while overlooking or discounting evidence that challenges it. Confirmation bias operates largely below conscious awareness, which is part of why it is so persistent — a person affected by it typically feels that they are simply \'following the evidence,\' even while unconsciously filtering that evidence. Strategies for counteracting confirmation bias include deliberately seeking out the strongest versions of opposing arguments, asking what evidence would change one\'s mind before looking for it, and inviting critique from people who are likely to disagree.',
          'question': 'According to the passage, confirmation bias is the tendency to:',
          'options': ['forget everything we have read', 'agree with the last person we spoke to', 'always seek out opposing viewpoints', 'notice and remember information that supports what we already believe'],
          'correct': 3,
        },
        {
          'passage': 'A frequent obstacle to rational inquiry is confirmation bias: the tendency to notice, seek out, and remember information that supports what we already believe, while overlooking or discounting evidence that challenges it. Confirmation bias operates largely below conscious awareness, which is part of why it is so persistent — a person affected by it typically feels that they are simply \'following the evidence,\' even while unconsciously filtering that evidence. Strategies for counteracting confirmation bias include deliberately seeking out the strongest versions of opposing arguments, asking what evidence would change one\'s mind before looking for it, and inviting critique from people who are likely to disagree.',
          'question': 'According to the passage, why is confirmation bias so persistent?',
          'options': ['it is taught in schools', 'it operates largely below conscious awareness', 'it is a deliberate, conscious choice', 'it only affects unintelligent people'],
          'correct': 1,
        },
        {
          'passage': 'A frequent obstacle to rational inquiry is confirmation bias: the tendency to notice, seek out, and remember information that supports what we already believe, while overlooking or discounting evidence that challenges it. Confirmation bias operates largely below conscious awareness, which is part of why it is so persistent — a person affected by it typically feels that they are simply \'following the evidence,\' even while unconsciously filtering that evidence. Strategies for counteracting confirmation bias include deliberately seeking out the strongest versions of opposing arguments, asking what evidence would change one\'s mind before looking for it, and inviting critique from people who are likely to disagree.',
          'question': 'According to the passage, a person affected by confirmation bias typically feels that they are:',
          'options': ['simply \'following the evidence\'', 'acting against their own beliefs', 'deliberately ignoring evidence', 'completely irrational'],
          'correct': 0,
        },
        {
          'passage': 'A frequent obstacle to rational inquiry is confirmation bias: the tendency to notice, seek out, and remember information that supports what we already believe, while overlooking or discounting evidence that challenges it. Confirmation bias operates largely below conscious awareness, which is part of why it is so persistent — a person affected by it typically feels that they are simply \'following the evidence,\' even while unconsciously filtering that evidence. Strategies for counteracting confirmation bias include deliberately seeking out the strongest versions of opposing arguments, asking what evidence would change one\'s mind before looking for it, and inviting critique from people who are likely to disagree.',
          'question': 'Which of the following strategies does the passage suggest for counteracting confirmation bias?',
          'options': ['refusing to state a position', 'only reading sources that agree with you', 'asking what evidence would change one\'s mind before looking for it', 'avoiding all forms of evidence'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best defines \'rational inquiry\'?',
          'options': ['a systematic process of forming beliefs based on reasons and evidence', 'following the majority opinion automatically', 'believing whatever feels emotionally satisfying', 'accepting whatever a trusted authority says without question'],
          'correct': 0,
        },
        {
          'question': 'A \'premise\' in an argument is:',
          'options': ['a question posed rather than answered', 'the final claim being argued for', 'an irrelevant side comment', 'a statement offered as support for the conclusion'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is an example of an a priori claim?',
          'options': ['\'My friend prefers tea to coffee.\'', '\'All bachelors are unmarried.\'', '\'The stock market rose yesterday.\'', '\'It is raining outside right now.\''],
          'correct': 1,
        },
        {
          'question': 'Which of the following is an example of an a posteriori (empirical) claim?',
          'options': ['\'Water boils at 100°C at sea level.\'', '\'2 + 2 = 4.\'', '\'A triangle has three sides.\'', '\'All squares have four equal sides.\''],
          'correct': 0,
        },
        {
          'question': 'The \'burden of proof\' in rational inquiry generally falls on:',
          'options': ['no one; proof is never required', 'the person who remains silent', 'whoever is listening to the argument', 'the person making a positive claim'],
          'correct': 3,
        },
        {
          'question': 'Occam\'s Razor is a principle suggesting that, all else equal, we should prefer:',
          'options': ['the explanation that requires the most assumptions', 'the most complex explanation available', 'the simplest explanation that accounts for the evidence', 'whichever explanation was proposed first'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'skepticism\' in the philosophical sense?',
          'options': ['refusal to ever accept any claim', 'the practice of questioning and doubting claims until sufficiently justified', 'a firm belief that nothing can ever be known', 'cynicism about other people\'s motives'],
          'correct': 1,
        },
        {
          'question': 'A \'necessary condition\' for X is one that:',
          'options': ['must be true for X to occur, though it may not be enough on its own', 'is the same as a sufficient condition', 'guarantees X will occur on its own', 'is irrelevant to whether X occurs'],
          'correct': 0,
        },
        {
          'question': 'A \'sufficient condition\' for X is one that:',
          'options': ['is required for X but does not guarantee it', 'guarantees X will occur if it is present', 'has no relationship to X', 'must always also be necessary'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best distinguishes rationalism from empiricism as approaches to knowledge?',
          'options': ['rationalism emphasizes reason as a primary source of knowledge, while empiricism emphasizes sensory experience', 'empiricism denies the existence of the external world', 'they are two names for the same view', 'rationalism rejects all use of logic'],
          'correct': 0,
        },
        {
          'question': 'Descartes\' famous method of \'systematic doubt\' aimed to:',
          'options': ['strip away all beliefs that could possibly be doubted, to find a certain foundation for knowledge', 'reject the usefulness of reason', 'replace philosophy with theology', 'prove that nothing can ever be known'],
          'correct': 0,
        },
        {
          'question': 'The Latin phrase \'cogito ergo sum,\' associated with Descartes, translates to:',
          'options': ['\'I see, therefore I believe.\'', '\'I think, therefore I am.\'', '\'I am, therefore I think.\'', '\'I doubt, therefore I know.\''],
          'correct': 1,
        },
        {
          'question': 'Which of the following is a hallmark of a well-conducted rational inquiry into a controversial claim?',
          'options': ['considering the strongest available objections before reaching a conclusion', 'ignoring objections that are inconvenient', 'relying solely on personal intuition', 'reaching a conclusion before examining any evidence'],
          'correct': 0,
        },
        {
          'question': 'The practice of representing an opposing argument in its weakest, most easily refuted form is called:',
          'options': ['a slippery slope', 'a straw man', 'a red herring', 'a steel man'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'coherentism\' as a theory of knowledge justification?',
          'options': ['a belief is justified if it fits consistently within a broader web of one\'s other beliefs', 'a belief is justified only if it can be traced back to a single foundational certainty', 'no belief can ever be justified', 'a belief is justified by popularity alone'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'foundationalism\' as a theory of knowledge justification?',
          'options': ['a belief is justified if it rests on basic beliefs that do not themselves require further justification', 'a belief is justified by tradition alone', 'no distinction exists between basic and derived beliefs', 'a belief is justified only by its consistency with other beliefs'],
          'correct': 0,
        },
        {
          'question': 'Rational inquiry treats a claim\'s \'plausibility\' as depending mainly on:',
          'options': ['how confidently it is stated', 'how many people repeat it', 'how well it is supported by available reasons and evidence', 'how emotionally appealing it is'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best illustrates the difference between correlation and causation, a key concern in rational inquiry?',
          'options': ['gravity causes objects to fall', 'heating water causes it to boil', 'ice cream sales and drowning rates both rise in summer, but ice cream does not cause drowning', 'smoking causes an increase in lung cancer rates'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes an \'ad hoc\' modification to a theory in the context of rational inquiry?',
          'options': ['a change made solely to protect the theory from a specific piece of contrary evidence, without independent justification', 'a change that simplifies the theory overall', 'a minor clarification of terminology', 'a change supported by new, independently verified evidence'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the \'principle of charity\' in evaluating another person\'s argument?',
          'options': ['interpreting an argument in its strongest, most reasonable form before criticizing it', 'refusing to criticize any argument', 'interpreting an argument in its weakest possible form', 'assuming the arguer is always correct'],
          'correct': 0,
        },
      ];
    case 'gns106_u1_3': // Branches of Philosophy
      return [
        {
          'passage': 'Philosophy is traditionally divided into several major branches, each concerned with a different kind of fundamental question. Metaphysics asks about the nature of reality: what exists, and what is the nature of things like time, causation, and identity? Epistemology asks about knowledge: what can we know, and how is a belief justified? Ethics (or moral philosophy) asks about value and conduct: what makes an action right or wrong, and what makes a life good? Logic studies the structure of valid reasoning itself, independent of any particular subject matter. Aesthetics examines beauty, art, and taste. While these branches are often taught separately, real philosophical problems frequently cut across more than one — a question about whether moral facts are \'real\' in the same way physical facts are, for instance, sits at the intersection of ethics and metaphysics.',
          'question': 'According to the passage, metaphysics asks about:',
          'options': ['the nature of reality, including time, causation, and identity', 'the structure of valid reasoning', 'what makes an action right or wrong', 'the nature of beauty and art'],
          'correct': 0,
        },
        {
          'passage': 'Philosophy is traditionally divided into several major branches, each concerned with a different kind of fundamental question. Metaphysics asks about the nature of reality: what exists, and what is the nature of things like time, causation, and identity? Epistemology asks about knowledge: what can we know, and how is a belief justified? Ethics (or moral philosophy) asks about value and conduct: what makes an action right or wrong, and what makes a life good? Logic studies the structure of valid reasoning itself, independent of any particular subject matter. Aesthetics examines beauty, art, and taste. While these branches are often taught separately, real philosophical problems frequently cut across more than one — a question about whether moral facts are \'real\' in the same way physical facts are, for instance, sits at the intersection of ethics and metaphysics.',
          'question': 'According to the passage, epistemology is concerned with:',
          'options': ['what exists in the universe', 'what can we know, and how is a belief justified', 'what makes an action right or wrong', 'how to create beautiful art'],
          'correct': 1,
        },
        {
          'passage': 'Philosophy is traditionally divided into several major branches, each concerned with a different kind of fundamental question. Metaphysics asks about the nature of reality: what exists, and what is the nature of things like time, causation, and identity? Epistemology asks about knowledge: what can we know, and how is a belief justified? Ethics (or moral philosophy) asks about value and conduct: what makes an action right or wrong, and what makes a life good? Logic studies the structure of valid reasoning itself, independent of any particular subject matter. Aesthetics examines beauty, art, and taste. While these branches are often taught separately, real philosophical problems frequently cut across more than one — a question about whether moral facts are \'real\' in the same way physical facts are, for instance, sits at the intersection of ethics and metaphysics.',
          'question': 'According to the passage, which branch studies the structure of valid reasoning independent of subject matter?',
          'options': ['aesthetics', 'ethics', 'logic', 'metaphysics'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy is traditionally divided into several major branches, each concerned with a different kind of fundamental question. Metaphysics asks about the nature of reality: what exists, and what is the nature of things like time, causation, and identity? Epistemology asks about knowledge: what can we know, and how is a belief justified? Ethics (or moral philosophy) asks about value and conduct: what makes an action right or wrong, and what makes a life good? Logic studies the structure of valid reasoning itself, independent of any particular subject matter. Aesthetics examines beauty, art, and taste. While these branches are often taught separately, real philosophical problems frequently cut across more than one — a question about whether moral facts are \'real\' in the same way physical facts are, for instance, sits at the intersection of ethics and metaphysics.',
          'question': 'The passage\'s example of a question that sits at the intersection of two branches concerns:',
          'options': ['whether time exists', 'whether logic requires language', 'whether moral facts are \'real\' in the way physical facts are', 'whether art can be beautiful Passage 2 Within ethics, philosophers often distinguish three sub-areas. Normative ethics asks which general moral principles or theories should guide action — for example, should we always aim to maximize overall well-being (as consequentialism suggests), or should we follow certain duties regardless of outcome (as deontology suggests)? Applied ethics takes those general theories and applies them to specific, often controversial, practical issues, such as questions in medical ethics or environmental policy. Metaethics, by contrast, steps back from any particular moral question and asks what moral claims even mean and whether they can be objectively true — for instance, whether \'stealing is wrong\' expresses a fact about the world or merely an attitude of disapproval.'],
          'correct': 2,
        },
        {
          'passage': 'Within ethics, philosophers often distinguish three sub-areas. Normative ethics asks which general moral principles or theories should guide action — for example, should we always aim to maximize overall well-being (as consequentialism suggests), or should we follow certain duties regardless of outcome (as deontology suggests)? Applied ethics takes those general theories and applies them to specific, often controversial, practical issues, such as questions in medical ethics or environmental policy. Metaethics, by contrast, steps back from any particular moral question and asks what moral claims even mean and whether they can be objectively true — for instance, whether \'stealing is wrong\' expresses a fact about the world or merely an attitude of disapproval.',
          'question': 'According to the passage, normative ethics asks:',
          'options': ['which general moral principles or theories should guide action', 'whether moral claims can be objectively true', 'what art is', 'how to apply theories to specific practical cases'],
          'correct': 0,
        },
        {
          'passage': 'Within ethics, philosophers often distinguish three sub-areas. Normative ethics asks which general moral principles or theories should guide action — for example, should we always aim to maximize overall well-being (as consequentialism suggests), or should we follow certain duties regardless of outcome (as deontology suggests)? Applied ethics takes those general theories and applies them to specific, often controversial, practical issues, such as questions in medical ethics or environmental policy. Metaethics, by contrast, steps back from any particular moral question and asks what moral claims even mean and whether they can be objectively true — for instance, whether \'stealing is wrong\' expresses a fact about the world or merely an attitude of disapproval.',
          'question': 'According to the passage, applied ethics involves:',
          'options': ['questioning whether reality exists', 'asking what moral claims mean', 'applying general theories to specific, controversial practical issues', 'studying the structure of valid arguments'],
          'correct': 2,
        },
        {
          'passage': 'Within ethics, philosophers often distinguish three sub-areas. Normative ethics asks which general moral principles or theories should guide action — for example, should we always aim to maximize overall well-being (as consequentialism suggests), or should we follow certain duties regardless of outcome (as deontology suggests)? Applied ethics takes those general theories and applies them to specific, often controversial, practical issues, such as questions in medical ethics or environmental policy. Metaethics, by contrast, steps back from any particular moral question and asks what moral claims even mean and whether they can be objectively true — for instance, whether \'stealing is wrong\' expresses a fact about the world or merely an attitude of disapproval.',
          'question': 'According to the passage, metaethics asks:',
          'options': ['which specific action is right in a given case', 'how art should be judged', 'what moral claims mean and whether they can be objectively true', 'what the correct medical treatment is'],
          'correct': 2,
        },
        {
          'passage': 'Within ethics, philosophers often distinguish three sub-areas. Normative ethics asks which general moral principles or theories should guide action — for example, should we always aim to maximize overall well-being (as consequentialism suggests), or should we follow certain duties regardless of outcome (as deontology suggests)? Applied ethics takes those general theories and applies them to specific, often controversial, practical issues, such as questions in medical ethics or environmental policy. Metaethics, by contrast, steps back from any particular moral question and asks what moral claims even mean and whether they can be objectively true — for instance, whether \'stealing is wrong\' expresses a fact about the world or merely an attitude of disapproval.',
          'question': 'The passage\'s example metaethical question concerns:',
          'options': ['whether art can be immoral', 'whether stealing is ever legal', 'whether \'stealing is wrong\' expresses a fact or merely an attitude', 'whether consequentialism is popular Passage 3 Political philosophy, sometimes treated as a branch of ethics and sometimes as its own field, asks questions about the legitimate use of power, the proper role of the state, and the basis of rights and justice. Classic questions include: what, if anything, justifies one person or group having authority over others? What do citizens owe their government, and what does government owe its citizens in return? Philosophers such as Thomas Hobbes, John Locke, and Jean-Jacques Rousseau developed influential \'social contract\' theories, arguing that legitimate political authority arises from an agreement, whether explicit or implicit, among the governed. Their differing views on human nature led them to strikingly different conclusions about how much power a state should hold.'],
          'correct': 2,
        },
        {
          'passage': 'Political philosophy, sometimes treated as a branch of ethics and sometimes as its own field, asks questions about the legitimate use of power, the proper role of the state, and the basis of rights and justice. Classic questions include: what, if anything, justifies one person or group having authority over others? What do citizens owe their government, and what does government owe its citizens in return? Philosophers such as Thomas Hobbes, John Locke, and Jean-Jacques Rousseau developed influential \'social contract\' theories, arguing that legitimate political authority arises from an agreement, whether explicit or implicit, among the governed. Their differing views on human nature led them to strikingly different conclusions about how much power a state should hold.',
          'question': 'According to the passage, political philosophy asks questions about:',
          'options': ['the legitimate use of power and the basis of rights and justice', 'the nature of beauty in art', 'the origin of the physical universe', 'the structure of valid logical arguments'],
          'correct': 0,
        },
        {
          'passage': 'Political philosophy, sometimes treated as a branch of ethics and sometimes as its own field, asks questions about the legitimate use of power, the proper role of the state, and the basis of rights and justice. Classic questions include: what, if anything, justifies one person or group having authority over others? What do citizens owe their government, and what does government owe its citizens in return? Philosophers such as Thomas Hobbes, John Locke, and Jean-Jacques Rousseau developed influential \'social contract\' theories, arguing that legitimate political authority arises from an agreement, whether explicit or implicit, among the governed. Their differing views on human nature led them to strikingly different conclusions about how much power a state should hold.',
          'question': 'According to the passage, social contract theorists argue that legitimate political authority arises from:',
          'options': ['inherited bloodlines', 'military conquest alone', 'divine appointment of rulers', 'an agreement, explicit or implicit, among the governed'],
          'correct': 3,
        },
        {
          'passage': 'Political philosophy, sometimes treated as a branch of ethics and sometimes as its own field, asks questions about the legitimate use of power, the proper role of the state, and the basis of rights and justice. Classic questions include: what, if anything, justifies one person or group having authority over others? What do citizens owe their government, and what does government owe its citizens in return? Philosophers such as Thomas Hobbes, John Locke, and Jean-Jacques Rousseau developed influential \'social contract\' theories, arguing that legitimate political authority arises from an agreement, whether explicit or implicit, among the governed. Their differing views on human nature led them to strikingly different conclusions about how much power a state should hold.',
          'question': 'According to the passage, which three philosophers are named as developing social contract theories?',
          'options': ['Descartes, Spinoza, and Leibniz', 'Thomas Hobbes, John Locke, and Jean-Jacques Rousseau', 'Kant, Hume, and Mill', 'Plato, Aristotle, and Socrates'],
          'correct': 1,
        },
        {
          'passage': 'Political philosophy, sometimes treated as a branch of ethics and sometimes as its own field, asks questions about the legitimate use of power, the proper role of the state, and the basis of rights and justice. Classic questions include: what, if anything, justifies one person or group having authority over others? What do citizens owe their government, and what does government owe its citizens in return? Philosophers such as Thomas Hobbes, John Locke, and Jean-Jacques Rousseau developed influential \'social contract\' theories, arguing that legitimate political authority arises from an agreement, whether explicit or implicit, among the governed. Their differing views on human nature led them to strikingly different conclusions about how much power a state should hold.',
          'question': 'According to the passage, why did these three philosophers reach different conclusions about state power?',
          'options': ['they used different logical systems', 'they disagreed about the existence of God', 'they lived in different centuries only', 'their differing views on human nature Passage 4 Philosophy of mind investigates the nature of mental states — such as beliefs, desires, and consciousness — and their relationship to the physical body, especially the brain. A central puzzle, often called the \'mind-body problem,\' asks how subjective, felt experience (like the redness of red, or the pain of a headache) can arise from, or relate to, physical processes in a material brain. Dualist views hold that the mind is, in some sense, distinct from the physical body; physicalist views hold that mental states simply are, or are entirely dependent upon, physical brain states. This debate has become increasingly important as neuroscience and artificial intelligence raise new versions of old questions, such as whether a sufficiently advanced machine could ever be conscious.'],
          'correct': 3,
        },
        {
          'passage': 'Philosophy of mind investigates the nature of mental states — such as beliefs, desires, and consciousness — and their relationship to the physical body, especially the brain. A central puzzle, often called the \'mind-body problem,\' asks how subjective, felt experience (like the redness of red, or the pain of a headache) can arise from, or relate to, physical processes in a material brain. Dualist views hold that the mind is, in some sense, distinct from the physical body; physicalist views hold that mental states simply are, or are entirely dependent upon, physical brain states. This debate has become increasingly important as neuroscience and artificial intelligence raise new versions of old questions, such as whether a sufficiently advanced machine could ever be conscious.',
          'question': 'According to the passage, philosophy of mind investigates the relationship between mental states and:',
          'options': ['the legal system', 'the physical body, especially the brain', 'the natural environment', 'artistic traditions'],
          'correct': 1,
        },
        {
          'passage': 'Philosophy of mind investigates the nature of mental states — such as beliefs, desires, and consciousness — and their relationship to the physical body, especially the brain. A central puzzle, often called the \'mind-body problem,\' asks how subjective, felt experience (like the redness of red, or the pain of a headache) can arise from, or relate to, physical processes in a material brain. Dualist views hold that the mind is, in some sense, distinct from the physical body; physicalist views hold that mental states simply are, or are entirely dependent upon, physical brain states. This debate has become increasingly important as neuroscience and artificial intelligence raise new versions of old questions, such as whether a sufficiently advanced machine could ever be conscious.',
          'question': 'According to the passage, the \'mind-body problem\' asks how:',
          'options': ['subjective, felt experience can arise from physical processes in the brain', 'logical arguments are structured', 'art is judged as beautiful or ugly', 'laws are made in a democracy'],
          'correct': 0,
        },
        {
          'passage': 'Philosophy of mind investigates the nature of mental states — such as beliefs, desires, and consciousness — and their relationship to the physical body, especially the brain. A central puzzle, often called the \'mind-body problem,\' asks how subjective, felt experience (like the redness of red, or the pain of a headache) can arise from, or relate to, physical processes in a material brain. Dualist views hold that the mind is, in some sense, distinct from the physical body; physicalist views hold that mental states simply are, or are entirely dependent upon, physical brain states. This debate has become increasingly important as neuroscience and artificial intelligence raise new versions of old questions, such as whether a sufficiently advanced machine could ever be conscious.',
          'question': 'According to the passage, dualist views hold that:',
          'options': ['mental states simply are physical brain states', 'consciousness does not exist', 'only the brain is real', 'the mind is, in some sense, distinct from the physical body'],
          'correct': 3,
        },
        {
          'passage': 'Philosophy of mind investigates the nature of mental states — such as beliefs, desires, and consciousness — and their relationship to the physical body, especially the brain. A central puzzle, often called the \'mind-body problem,\' asks how subjective, felt experience (like the redness of red, or the pain of a headache) can arise from, or relate to, physical processes in a material brain. Dualist views hold that the mind is, in some sense, distinct from the physical body; physicalist views hold that mental states simply are, or are entirely dependent upon, physical brain states. This debate has become increasingly important as neuroscience and artificial intelligence raise new versions of old questions, such as whether a sufficiently advanced machine could ever be conscious.',
          'question': 'According to the passage, physicalist views hold that mental states:',
          'options': ['exist independently of any body', 'cannot be studied by science', 'simply are, or are entirely dependent upon, physical brain states', 'are identical to social conventions Passage 5 Philosophy of language examines how words and sentences come to have meaning, how reference works (how a name like \'Paris\' picks out a particular city), and how context shapes what a sentence communicates. One classic puzzle concerns how two expressions can refer to the same object while having different meanings — for example, \'the morning star\' and \'the evening star\' both refer to the planet Venus, yet a person could believe one but not the other without any contradiction, suggesting that meaning involves more than just what a term refers to. Philosophy of language overlaps closely with logic and with linguistics, but it is distinguished by its focus on deeper conceptual questions about meaning itself, rather than on describing how a particular language happens to be used.'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy of language examines how words and sentences come to have meaning, how reference works (how a name like \'Paris\' picks out a particular city), and how context shapes what a sentence communicates. One classic puzzle concerns how two expressions can refer to the same object while having different meanings — for example, \'the morning star\' and \'the evening star\' both refer to the planet Venus, yet a person could believe one but not the other without any contradiction, suggesting that meaning involves more than just what a term refers to. Philosophy of language overlaps closely with logic and with linguistics, but it is distinguished by its focus on deeper conceptual questions about meaning itself, rather than on describing how a particular language happens to be used.',
          'question': 'According to the passage, philosophy of language examines how:',
          'options': ['laws are enforced in society', 'art is created and appreciated', 'words and sentences come to have meaning and how reference works', 'the brain processes visual information'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy of language examines how words and sentences come to have meaning, how reference works (how a name like \'Paris\' picks out a particular city), and how context shapes what a sentence communicates. One classic puzzle concerns how two expressions can refer to the same object while having different meanings — for example, \'the morning star\' and \'the evening star\' both refer to the planet Venus, yet a person could believe one but not the other without any contradiction, suggesting that meaning involves more than just what a term refers to. Philosophy of language overlaps closely with logic and with linguistics, but it is distinguished by its focus on deeper conceptual questions about meaning itself, rather than on describing how a particular language happens to be used.',
          'question': 'According to the passage, the \'morning star\' and \'evening star\' example illustrates:',
          'options': ['that logic cannot handle astronomy', 'that all language is meaningless', 'that two expressions can refer to the same object while having different meanings', 'that Venus does not really exist'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy of language examines how words and sentences come to have meaning, how reference works (how a name like \'Paris\' picks out a particular city), and how context shapes what a sentence communicates. One classic puzzle concerns how two expressions can refer to the same object while having different meanings — for example, \'the morning star\' and \'the evening star\' both refer to the planet Venus, yet a person could believe one but not the other without any contradiction, suggesting that meaning involves more than just what a term refers to. Philosophy of language overlaps closely with logic and with linguistics, but it is distinguished by its focus on deeper conceptual questions about meaning itself, rather than on describing how a particular language happens to be used.',
          'question': 'According to the passage, what do \'the morning star\' and \'the evening star\' both refer to?',
          'options': ['the planet Mars', 'the Sun', 'the planet Venus', 'the Moon'],
          'correct': 2,
        },
        {
          'passage': 'Philosophy of language examines how words and sentences come to have meaning, how reference works (how a name like \'Paris\' picks out a particular city), and how context shapes what a sentence communicates. One classic puzzle concerns how two expressions can refer to the same object while having different meanings — for example, \'the morning star\' and \'the evening star\' both refer to the planet Venus, yet a person could believe one but not the other without any contradiction, suggesting that meaning involves more than just what a term refers to. Philosophy of language overlaps closely with logic and with linguistics, but it is distinguished by its focus on deeper conceptual questions about meaning itself, rather than on describing how a particular language happens to be used.',
          'question': 'According to the passage, how is philosophy of language distinguished from linguistics?',
          'options': ['by its focus on deeper conceptual questions about meaning itself', 'by rejecting the use of logic', 'by ignoring the concept of reference', 'by studying only ancient languages'],
          'correct': 0,
        },
        {
          'question': 'Which branch of philosophy is primarily concerned with questions about beauty, art, and taste?',
          'options': ['epistemology', 'metaphysics', 'aesthetics', 'logic'],
          'correct': 2,
        },
        {
          'question': 'Which branch of philosophy would most directly address the question \'Does free will exist?\'',
          'options': ['aesthetics', 'metaphysics', 'logic', 'philosophy of language'],
          'correct': 1,
        },
        {
          'question': 'Which branch of philosophy would most directly address the question \'What makes a belief justified?\'',
          'options': ['philosophy of mind', 'aesthetics', 'epistemology', 'ethics'],
          'correct': 2,
        },
        {
          'question': 'Philosophy of science, as a branch, is primarily concerned with:',
          'options': ['the biography of individual scientists', 'the aesthetic value of scientific diagrams', 'the political funding of universities', 'the methods, assumptions, and implications of scientific inquiry'],
          'correct': 3,
        },
        {
          'question': 'Which of the following questions belongs most clearly to philosophy of religion?',
          'options': ['what caused a specific historical war?', 'how are chemical bonds formed?', 'does the existence of evil provide evidence against an all-good, all-powerful God?', 'what is the boiling point of water?'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'philosophy of law\' (jurisprudence)?',
          'options': ['the practice of representing clients in court', 'the memorization of specific legal statutes', 'the study of the nature of law, legal validity, and the relationship between law and morality', 'the study of criminal psychology'],
          'correct': 2,
        },
        {
          'question': 'Which branch of philosophy deals most directly with the study of formal systems of valid inference?',
          'options': ['logic', 'aesthetics', 'political philosophy', 'philosophy of religion'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is a central question in the philosophy of mind?',
          'options': ['what is the best economic system?', 'what is the nature of beauty?', 'how should punishment be justified?', 'how does subjective experience relate to physical brain processes?'],
          'correct': 3,
        },
        {
          'question': 'Consequentialism is a normative ethical theory holding that the rightness of an action depends primarily on:',
          'options': ['its outcomes or consequences', 'the character traits it expresses', 'fixed duties that must never be broken', 'the intentions behind it, regardless of outcome'],
          'correct': 0,
        },
        {
          'question': 'Deontology is a normative ethical theory holding that the rightness of an action depends primarily on:',
          'options': ['its overall consequences for well-being', 'majority public opinion at the time', 'the artistic merit of the act', 'whether it conforms to a moral duty or rule, regardless of consequences'],
          'correct': 3,
        },
        {
          'question': 'Virtue ethics is a normative ethical theory that focuses primarily on:',
          'options': ['legal compliance', 'maximizing pleasure only', 'the character and virtues of the moral agent, rather than isolated acts or their consequences', 'strict rule-following above all else'],
          'correct': 2,
        },
        {
          'question': 'Which branch of philosophy would most directly examine the statement \'Torturing an innocent person for fun is wrong\'?',
          'options': ['aesthetics', 'logic', 'philosophy of language (exclusively)', 'ethics'],
          'correct': 3,
        },
        {
          'question': 'Philosophy of history examines questions such as:',
          'options': ['the exact dates of specific battles', 'whether historical events unfold according to discernible patterns or laws', 'the best method for archiving documents', 'the chemical composition of ancient artifacts'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best captures the difference between ethics and aesthetics?',
          'options': ['ethics concerns beauty, while aesthetics concerns conduct', 'ethics concerns right and wrong conduct, while aesthetics concerns beauty and artistic value', 'there is no meaningful difference in modern philosophy', 'they are simply two names for the same branch'],
          'correct': 1,
        },
        {
          'question': 'The philosophy of education asks questions such as:',
          'options': ['what are the proper aims and methods of teaching and learning?', 'what is the boiling point of a chemical compound?', 'what is the origin of the universe?', 'how should a legal contract be drafted?'],
          'correct': 0,
        },
        {
          'question': 'Environmental philosophy is most centrally concerned with questions about:',
          'options': ['the stock prices of energy companies', 'humanity\'s moral relationship to the natural world and nonhuman life', 'the architectural design of buildings', 'the chemical formulas of pollutants'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best distinguishes philosophy of mind from psychology?',
          'options': ['philosophy of mind rejects the existence of the mind', 'they are identical fields with different names', 'psychology never studies consciousness', 'philosophy of mind asks conceptual and foundational questions about the nature of mental states, while psychology studies them empirically'],
          'correct': 3,
        },
        {
          'question': 'Which of these questions falls under \'philosophy of art\' specifically (a subfield of aesthetics)?',
          'options': ['how much does a painting sell for at auction?', 'what is the boiling point of paint?', 'what year was a particular sculpture completed?', 'what makes something count as a work of art in the first place?'],
          'correct': 3,
        },
        {
          'question': 'Which branch of philosophy studies the nature and scope of personal identity over time?',
          'options': ['logic', 'aesthetics', 'philosophy of language (exclusively)', 'metaphysics'],
          'correct': 3,
        },
        {
          'question': 'Feminist philosophy, as a field, primarily examines:',
          'options': ['the biology of reproduction exclusively', 'the history of fashion', 'only questions about voting rights', 'how gender shapes, and is shaped by, philosophical concepts, social structures, and knowledge itself'],
          'correct': 3,
        },
      ];
    case 'gns106_u2_1': // Philosophical Methods
      return [
        {
          'passage': 'The Socratic method, named for Socrates as depicted in Plato\'s dialogues, proceeds through a series of questions and answers rather than through lectures or one-sided argument. Socrates would typically ask an interlocutor to define a concept — such as \'justice\' or \'courage\' — and then, through further questioning, expose cases where the interlocutor\'s own beliefs led to contradiction. The aim was not primarily to humiliate the other person, but to demonstrate that unexamined confidence in one\'s own understanding is often unjustified, and that genuine progress requires acknowledging what one does not know. This process is sometimes called \'elenchus,\' from the Greek word for cross-examination or refutation.',
          'question': 'According to the passage, the Socratic method proceeds through:',
          'options': ['written essays only', 'one-sided lectures', 'a series of questions and answers', 'silent meditation'],
          'correct': 2,
        },
        {
          'passage': 'The Socratic method, named for Socrates as depicted in Plato\'s dialogues, proceeds through a series of questions and answers rather than through lectures or one-sided argument. Socrates would typically ask an interlocutor to define a concept — such as \'justice\' or \'courage\' — and then, through further questioning, expose cases where the interlocutor\'s own beliefs led to contradiction. The aim was not primarily to humiliate the other person, but to demonstrate that unexamined confidence in one\'s own understanding is often unjustified, and that genuine progress requires acknowledging what one does not know. This process is sometimes called \'elenchus,\' from the Greek word for cross-examination or refutation.',
          'question': 'According to the passage, what did Socrates typically ask an interlocutor to do first?',
          'options': ['define a concept, such as \'justice\' or \'courage\'', 'describe a historical event', 'solve a mathematical equation', 'recite a poem'],
          'correct': 0,
        },
        {
          'passage': 'The Socratic method, named for Socrates as depicted in Plato\'s dialogues, proceeds through a series of questions and answers rather than through lectures or one-sided argument. Socrates would typically ask an interlocutor to define a concept — such as \'justice\' or \'courage\' — and then, through further questioning, expose cases where the interlocutor\'s own beliefs led to contradiction. The aim was not primarily to humiliate the other person, but to demonstrate that unexamined confidence in one\'s own understanding is often unjustified, and that genuine progress requires acknowledging what one does not know. This process is sometimes called \'elenchus,\' from the Greek word for cross-examination or refutation.',
          'question': 'According to the passage, what was the primary aim of the Socratic method?',
          'options': ['to win a public debate for entertainment', 'to humiliate the other person', 'to prove Socrates was always correct', 'to show that unexamined confidence in one\'s understanding is often unjustified'],
          'correct': 3,
        },
        {
          'passage': 'The Socratic method, named for Socrates as depicted in Plato\'s dialogues, proceeds through a series of questions and answers rather than through lectures or one-sided argument. Socrates would typically ask an interlocutor to define a concept — such as \'justice\' or \'courage\' — and then, through further questioning, expose cases where the interlocutor\'s own beliefs led to contradiction. The aim was not primarily to humiliate the other person, but to demonstrate that unexamined confidence in one\'s own understanding is often unjustified, and that genuine progress requires acknowledging what one does not know. This process is sometimes called \'elenchus,\' from the Greek word for cross-examination or refutation.',
          'question': 'According to the passage, what is the Greek term for this process of cross-examination?',
          'options': ['sophia', 'logos', 'elenchus', 'dialectic (used generically) Passage 2 Thought experiments are a distinctive method in philosophy, used to test the implications of a concept or principle by imagining a scenario, often one that could never actually occur. Because a thought experiment is imaginary, it can isolate a single variable in a way real-world cases rarely allow — for instance, a thought experiment about personal identity might imagine a person\'s brain being gradually replaced, piece by piece, with artificial parts, in order to ask at what point, if any, the person would cease to exist. Critics of this method argue that our intuitive reactions to far-fetched scenarios may not reliably track deep truths, since intuitions evolved to handle ordinary, realistic situations, not exotic hypotheticals.'],
          'correct': 2,
        },
        {
          'passage': 'Thought experiments are a distinctive method in philosophy, used to test the implications of a concept or principle by imagining a scenario, often one that could never actually occur. Because a thought experiment is imaginary, it can isolate a single variable in a way real-world cases rarely allow — for instance, a thought experiment about personal identity might imagine a person\'s brain being gradually replaced, piece by piece, with artificial parts, in order to ask at what point, if any, the person would cease to exist. Critics of this method argue that our intuitive reactions to far-fetched scenarios may not reliably track deep truths, since intuitions evolved to handle ordinary, realistic situations, not exotic hypotheticals.',
          'question': 'According to the passage, thought experiments are used to:',
          'options': ['survey public opinion on ethics', 'replace the need for any argument', 'test the implications of a concept or principle by imagining a scenario', 'measure physical quantities precisely'],
          'correct': 2,
        },
        {
          'passage': 'Thought experiments are a distinctive method in philosophy, used to test the implications of a concept or principle by imagining a scenario, often one that could never actually occur. Because a thought experiment is imaginary, it can isolate a single variable in a way real-world cases rarely allow — for instance, a thought experiment about personal identity might imagine a person\'s brain being gradually replaced, piece by piece, with artificial parts, in order to ask at what point, if any, the person would cease to exist. Critics of this method argue that our intuitive reactions to far-fetched scenarios may not reliably track deep truths, since intuitions evolved to handle ordinary, realistic situations, not exotic hypotheticals.',
          'question': 'According to the passage, why can a thought experiment isolate a single variable?',
          'options': ['because it requires a laboratory', 'because it always involves real people', 'because it must be published in a journal', 'because it is imaginary and not constrained by real-world messiness'],
          'correct': 3,
        },
        {
          'passage': 'Thought experiments are a distinctive method in philosophy, used to test the implications of a concept or principle by imagining a scenario, often one that could never actually occur. Because a thought experiment is imaginary, it can isolate a single variable in a way real-world cases rarely allow — for instance, a thought experiment about personal identity might imagine a person\'s brain being gradually replaced, piece by piece, with artificial parts, in order to ask at what point, if any, the person would cease to exist. Critics of this method argue that our intuitive reactions to far-fetched scenarios may not reliably track deep truths, since intuitions evolved to handle ordinary, realistic situations, not exotic hypotheticals.',
          'question': 'According to the passage, the personal-identity thought experiment involves imagining:',
          'options': ['two people switching bodies permanently', 'a person losing all their memories at once', 'a person\'s brain being gradually replaced, piece by piece, with artificial parts', 'a person traveling faster than light'],
          'correct': 2,
        },
        {
          'passage': 'Thought experiments are a distinctive method in philosophy, used to test the implications of a concept or principle by imagining a scenario, often one that could never actually occur. Because a thought experiment is imaginary, it can isolate a single variable in a way real-world cases rarely allow — for instance, a thought experiment about personal identity might imagine a person\'s brain being gradually replaced, piece by piece, with artificial parts, in order to ask at what point, if any, the person would cease to exist. Critics of this method argue that our intuitive reactions to far-fetched scenarios may not reliably track deep truths, since intuitions evolved to handle ordinary, realistic situations, not exotic hypotheticals.',
          'question': 'According to the passage, what do critics argue about our intuitive reactions to far-fetched scenarios?',
          'options': ['they are irrelevant to philosophy entirely', 'they are always completely reliable', 'they may not reliably track deep truths, since intuitions evolved for ordinary situations', 'they only apply to scientific questions Passage 3 Conceptual analysis attempts to clarify a concept by identifying necessary and sufficient conditions for its correct application — that is, by specifying exactly what must be true for something to count as an instance of that concept. A classic target has been the concept of \'knowledge,\' traditionally analyzed as \'justified true belief\': a person knows a claim if they believe it, the claim is true, and their belief is adequately justified. In 1963, however, Edmund Gettier published cases in which a person appears to have a justified true belief that most people would not call knowledge, due to an element of luck. These \'Gettier cases\' triggered decades of further conceptual analysis attempting to repair or replace the traditional definition.'],
          'correct': 2,
        },
        {
          'passage': 'Conceptual analysis attempts to clarify a concept by identifying necessary and sufficient conditions for its correct application — that is, by specifying exactly what must be true for something to count as an instance of that concept. A classic target has been the concept of \'knowledge,\' traditionally analyzed as \'justified true belief\': a person knows a claim if they believe it, the claim is true, and their belief is adequately justified. In 1963, however, Edmund Gettier published cases in which a person appears to have a justified true belief that most people would not call knowledge, due to an element of luck. These \'Gettier cases\' triggered decades of further conceptual analysis attempting to repair or replace the traditional definition.',
          'question': 'According to the passage, conceptual analysis attempts to clarify a concept by identifying:',
          'options': ['its popularity in everyday speech', 'necessary and sufficient conditions for its correct application', 'its emotional connotations only', 'its historical origin'],
          'correct': 1,
        },
        {
          'passage': 'Conceptual analysis attempts to clarify a concept by identifying necessary and sufficient conditions for its correct application — that is, by specifying exactly what must be true for something to count as an instance of that concept. A classic target has been the concept of \'knowledge,\' traditionally analyzed as \'justified true belief\': a person knows a claim if they believe it, the claim is true, and their belief is adequately justified. In 1963, however, Edmund Gettier published cases in which a person appears to have a justified true belief that most people would not call knowledge, due to an element of luck. These \'Gettier cases\' triggered decades of further conceptual analysis attempting to repair or replace the traditional definition.',
          'question': 'According to the passage, the traditional analysis of \'knowledge\' is:',
          'options': ['confident guess', 'strong intuition', 'justified true belief', 'true opinion'],
          'correct': 2,
        },
        {
          'passage': 'Conceptual analysis attempts to clarify a concept by identifying necessary and sufficient conditions for its correct application — that is, by specifying exactly what must be true for something to count as an instance of that concept. A classic target has been the concept of \'knowledge,\' traditionally analyzed as \'justified true belief\': a person knows a claim if they believe it, the claim is true, and their belief is adequately justified. In 1963, however, Edmund Gettier published cases in which a person appears to have a justified true belief that most people would not call knowledge, due to an element of luck. These \'Gettier cases\' triggered decades of further conceptual analysis attempting to repair or replace the traditional definition.',
          'question': 'According to the passage, who published cases challenging this traditional analysis in 1963?',
          'options': ['René Descartes', 'Bertrand Russell', 'Socrates', 'Edmund Gettier'],
          'correct': 3,
        },
        {
          'passage': 'Conceptual analysis attempts to clarify a concept by identifying necessary and sufficient conditions for its correct application — that is, by specifying exactly what must be true for something to count as an instance of that concept. A classic target has been the concept of \'knowledge,\' traditionally analyzed as \'justified true belief\': a person knows a claim if they believe it, the claim is true, and their belief is adequately justified. In 1963, however, Edmund Gettier published cases in which a person appears to have a justified true belief that most people would not call knowledge, due to an element of luck. These \'Gettier cases\' triggered decades of further conceptual analysis attempting to repair or replace the traditional definition.',
          'question': 'According to the passage, what element do Gettier cases involve that undermines the traditional definition?',
          'options': ['an element of luck', 'a false belief', 'the complete absence of justification', 'a lack of any belief at all Passage 4 The dialectical method, closely associated with Hegel though it has roots in ancient philosophy, describes philosophical progress as unfolding through a pattern of thesis, antithesis, and synthesis. A thesis is an initial position; the antithesis is a contrasting or opposing position that reveals tensions or limitations in the thesis; and the synthesis is a new position that resolves the conflict by incorporating insights from both, often at a more sophisticated level of understanding. Rather than viewing disagreement as simply a problem to be eliminated, the dialectical method treats productive disagreement as a driving force of intellectual progress, since the tension between opposing views can reveal blind spots that neither view alone would have exposed.'],
          'correct': 0,
        },
        {
          'passage': 'The dialectical method, closely associated with Hegel though it has roots in ancient philosophy, describes philosophical progress as unfolding through a pattern of thesis, antithesis, and synthesis. A thesis is an initial position; the antithesis is a contrasting or opposing position that reveals tensions or limitations in the thesis; and the synthesis is a new position that resolves the conflict by incorporating insights from both, often at a more sophisticated level of understanding. Rather than viewing disagreement as simply a problem to be eliminated, the dialectical method treats productive disagreement as a driving force of intellectual progress, since the tension between opposing views can reveal blind spots that neither view alone would have exposed.',
          'question': 'According to the passage, the dialectical method describes progress unfolding through:',
          'options': ['question, answer, and refutation', 'observation, hypothesis, and test', 'premise, conclusion, and objection', 'thesis, antithesis, and synthesis'],
          'correct': 3,
        },
        {
          'passage': 'The dialectical method, closely associated with Hegel though it has roots in ancient philosophy, describes philosophical progress as unfolding through a pattern of thesis, antithesis, and synthesis. A thesis is an initial position; the antithesis is a contrasting or opposing position that reveals tensions or limitations in the thesis; and the synthesis is a new position that resolves the conflict by incorporating insights from both, often at a more sophisticated level of understanding. Rather than viewing disagreement as simply a problem to be eliminated, the dialectical method treats productive disagreement as a driving force of intellectual progress, since the tension between opposing views can reveal blind spots that neither view alone would have exposed.',
          'question': 'According to the passage, the \'antithesis\' is:',
          'options': ['a final, unchallengeable conclusion', 'the very first position proposed', 'a contrasting or opposing position that reveals tensions in the thesis', 'an irrelevant side issue'],
          'correct': 2,
        },
        {
          'passage': 'The dialectical method, closely associated with Hegel though it has roots in ancient philosophy, describes philosophical progress as unfolding through a pattern of thesis, antithesis, and synthesis. A thesis is an initial position; the antithesis is a contrasting or opposing position that reveals tensions or limitations in the thesis; and the synthesis is a new position that resolves the conflict by incorporating insights from both, often at a more sophisticated level of understanding. Rather than viewing disagreement as simply a problem to be eliminated, the dialectical method treats productive disagreement as a driving force of intellectual progress, since the tension between opposing views can reveal blind spots that neither view alone would have exposed.',
          'question': 'According to the passage, the \'synthesis\' resolves conflict by:',
          'options': ['ending the discussion without resolution', 'rejecting both the thesis and antithesis entirely', 'simply restating the original thesis', 'incorporating insights from both the thesis and antithesis'],
          'correct': 3,
        },
        {
          'passage': 'The dialectical method, closely associated with Hegel though it has roots in ancient philosophy, describes philosophical progress as unfolding through a pattern of thesis, antithesis, and synthesis. A thesis is an initial position; the antithesis is a contrasting or opposing position that reveals tensions or limitations in the thesis; and the synthesis is a new position that resolves the conflict by incorporating insights from both, often at a more sophisticated level of understanding. Rather than viewing disagreement as simply a problem to be eliminated, the dialectical method treats productive disagreement as a driving force of intellectual progress, since the tension between opposing views can reveal blind spots that neither view alone would have exposed.',
          'question': 'According to the passage, how does the dialectical method view disagreement?',
          'options': ['as a driving force of intellectual progress, not merely a problem to eliminate', 'as evidence that philosophy has failed', 'as something to avoid at all costs', 'as irrelevant to reaching truth Passage 5 Reflective equilibrium, a method most associated with the philosopher John Rawls, describes an ongoing process of adjusting general moral principles and specific moral judgments until they fit together consistently. If a general principle implies a specific judgment that strikes us as clearly wrong — for example, a principle that seems to permit an obviously unjust practice — this may be reason to revise the principle rather than accept the troubling judgment. Conversely, a widely shared specific judgment might need to be revised if it cannot be reconciled with principles we have strong independent reason to accept. Neither principles nor specific judgments are treated as automatically more authoritative; instead, both are adjusted together until a stable, coherent equilibrium is reached.'],
          'correct': 0,
        },
        {
          'passage': 'Reflective equilibrium, a method most associated with the philosopher John Rawls, describes an ongoing process of adjusting general moral principles and specific moral judgments until they fit together consistently. If a general principle implies a specific judgment that strikes us as clearly wrong — for example, a principle that seems to permit an obviously unjust practice — this may be reason to revise the principle rather than accept the troubling judgment. Conversely, a widely shared specific judgment might need to be revised if it cannot be reconciled with principles we have strong independent reason to accept. Neither principles nor specific judgments are treated as automatically more authoritative; instead, both are adjusted together until a stable, coherent equilibrium is reached.',
          'question': 'According to the passage, reflective equilibrium is most associated with which philosopher?',
          'options': ['John Rawls', 'Aristotle', 'Socrates', 'Immanuel Kant'],
          'correct': 0,
        },
        {
          'passage': 'Reflective equilibrium, a method most associated with the philosopher John Rawls, describes an ongoing process of adjusting general moral principles and specific moral judgments until they fit together consistently. If a general principle implies a specific judgment that strikes us as clearly wrong — for example, a principle that seems to permit an obviously unjust practice — this may be reason to revise the principle rather than accept the troubling judgment. Conversely, a widely shared specific judgment might need to be revised if it cannot be reconciled with principles we have strong independent reason to accept. Neither principles nor specific judgments are treated as automatically more authoritative; instead, both are adjusted together until a stable, coherent equilibrium is reached.',
          'question': 'According to the passage, reflective equilibrium involves adjusting:',
          'options': ['only specific judgments, never general principles', 'legal statutes and court rulings', 'only general principles, never specific judgments', 'general moral principles and specific moral judgments until they fit together consistently'],
          'correct': 3,
        },
        {
          'passage': 'Reflective equilibrium, a method most associated with the philosopher John Rawls, describes an ongoing process of adjusting general moral principles and specific moral judgments until they fit together consistently. If a general principle implies a specific judgment that strikes us as clearly wrong — for example, a principle that seems to permit an obviously unjust practice — this may be reason to revise the principle rather than accept the troubling judgment. Conversely, a widely shared specific judgment might need to be revised if it cannot be reconciled with principles we have strong independent reason to accept. Neither principles nor specific judgments are treated as automatically more authoritative; instead, both are adjusted together until a stable, coherent equilibrium is reached.',
          'question': 'According to the passage, what might happen if a general principle implies a judgment that seems clearly wrong?',
          'options': ['the judgment must always be accepted regardless', 'the principle is automatically proven true', 'nothing changes; both are kept as is', 'this may be reason to revise the principle rather than accept the judgment'],
          'correct': 3,
        },
        {
          'passage': 'Reflective equilibrium, a method most associated with the philosopher John Rawls, describes an ongoing process of adjusting general moral principles and specific moral judgments until they fit together consistently. If a general principle implies a specific judgment that strikes us as clearly wrong — for example, a principle that seems to permit an obviously unjust practice — this may be reason to revise the principle rather than accept the troubling judgment. Conversely, a widely shared specific judgment might need to be revised if it cannot be reconciled with principles we have strong independent reason to accept. Neither principles nor specific judgments are treated as automatically more authoritative; instead, both are adjusted together until a stable, coherent equilibrium is reached.',
          'question': 'According to the passage, in reflective equilibrium, are principles automatically treated as more authoritative than specific judgments?',
          'options': ['The passage does not address this question', 'No, neither is automatically treated as more authoritative', 'Yes, principles always outrank judgments', 'Yes, judgments always outrank principles'],
          'correct': 1,
        },
        {
          'question': 'The term \'dialectic\' broadly refers to:',
          'options': ['a legal contract between two parties', 'a purely emotional form of persuasion', 'a method of reasoning through structured dialogue or contrasting arguments', 'a type of mathematical proof'],
          'correct': 2,
        },
        {
          'question': 'A \'reductio ad absurdum\' argument works by:',
          'options': ['citing statistical evidence', 'assuming a claim is true and showing it leads to an absurd or contradictory conclusion', 'appealing to the authority of an expert', 'offering a personal anecdote'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes a \'counterexample\' in philosophical method?',
          'options': ['an irrelevant historical fact', 'a specific case that shows a general claim or definition is false', 'an example that supports the claim', 'a restatement of the original claim'],
          'correct': 1,
        },
        {
          'question': 'The method of \'analytic philosophy,\' broadly practiced since the early 20th century, emphasizes:',
          'options': ['relying primarily on mystical insight', 'clarity, precision, and logical analysis of language and arguments', 'poetic and literary style over precision', 'rejecting the use of logic entirely'],
          'correct': 1,
        },
        {
          'question': '\'Continental philosophy\' is often contrasted with analytic philosophy and is associated with a greater emphasis on:',
          'options': ['strict formal logic above all else', 'historical, existential, and interpretive approaches to broader human experience', 'laboratory experimentation', 'purely mathematical proofs'],
          'correct': 1,
        },
        {
          'question': 'Phenomenology, a method associated with Edmund Husserl, focuses on:',
          'options': ['measuring brain activity with instruments', 'describing structures of conscious experience as they are directly lived', 'legal interpretation of written law', 'statistical analysis of survey data'],
          'correct': 1,
        },
        {
          'question': 'A \'syllogism\' is a specific form of argument consisting of:',
          'options': ['two premises and a conclusion', 'an infinite chain of premises', 'a question followed by silence', 'a single unsupported assertion'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the use of \'intuition pumps\' in philosophical method (a term coined by Daniel Dennett)?',
          'options': ['peer-reviewed empirical studies', 'thought experiments designed to elicit or shape a particular intuitive response', 'statistical surveys of public opinion', 'controlled laboratory experiments'],
          'correct': 1,
        },
        {
          'question': 'The method of \'genealogy,\' associated with Friedrich Nietzsche and later Michel Foucault, examines concepts by:',
          'options': ['proving them through formal logical deduction', 'tracing their historical origins and the power relations that shaped them', 'testing them in a controlled laboratory', 'measuring them with mathematical precision'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'formal logic\' as a philosophical method?',
          'options': ['a purely historical survey of ancient texts', 'an artistic method of writing essays', 'the use of symbolic systems to represent and evaluate the validity of arguments', 'informal conversation about any topic'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes an \'intuition\' in philosophical methodology?',
          'options': ['a statement that has been formally proven', 'a random guess with no cognitive basis', 'an immediate, pre-theoretical judgment about a case or principle', 'a conclusion reached only after lengthy calculation'],
          'correct': 2,
        },
        {
          'question': 'The \'method of doubt\' is most closely associated with which philosopher?',
          'options': ['Karl Marx', 'René Descartes', 'John Stuart Mill', 'Confucius'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'dialogue\' as used in Plato\'s philosophical writings?',
          'options': ['a scientific laboratory report', 'a formal legal deposition', 'a written conversation between characters used to explore philosophical ideas', 'a private diary never meant to be read'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the philosophical use of \'possible worlds\' as a method?',
          'options': ['a religious doctrine about the afterlife', 'a way of analyzing claims about necessity and possibility by imagining alternative ways things could have been', 'a scientific theory about parallel physical universes', 'a literary genre of science fiction'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'first-order logic\' as a tool in philosophical method?',
          'options': ['a formal system that uses quantifiers, predicates, and variables to represent statements precisely', 'a branch of aesthetics concerned with beauty', 'a historical school of ancient ethics', 'an informal rule of everyday conversation'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'case-based reasoning\' in applied ethics?',
          'options': ['rejecting the use of any general principles', 'reasoning from specific, well-understood cases to general principles, or applying principles to new specific cases by analogy', 'ignoring specific cases in favor of pure abstraction', 'relying exclusively on legal precedent'],
          'correct': 1,
        },
        {
          'question': 'The \'veil of ignorance,\' a thought experiment devised by John Rawls, asks us to imagine designing principles of justice:',
          'options': ['with complete knowledge of every citizen\'s identity', 'based purely on majority vote', 'only after consulting religious authorities', 'without knowing our own place in society, such as our wealth, talents, or social class'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'philosophical argument mapping\'?',
          'options': ['a statistical technique for surveys', 'a purely artistic exercise with no logical content', 'a method for drawing geographic maps of ancient philosophy schools', 'a visual technique for laying out the logical structure of premises and conclusions in an argument'],
          'correct': 3,
        },
        {
          'question': 'A key methodological difference between philosophy and empirical science is that philosophy typically relies more heavily on:',
          'options': ['laboratory measurement of physical quantities', 'peer-reviewed experimental replication as its primary tool', 'conceptual argument and logical analysis rather than controlled experimentation', 'statistical sampling of large populations'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the philosophical method of \'analogy\'?',
          'options': ['a method used only in mathematics, never in ethics', 'reasoning based purely on statistical probability', 'reasoning that a conclusion likely holds in one case because of relevant similarities to another case where it is known to hold', 'reasoning that ignores all similarities between cases'],
          'correct': 2,
        },
      ];
    case 'gns106_u2_2': // Schools of Thought
      return [
        {
          'passage': 'Rationalism and empiricism represent two competing schools of thought about the primary source of human knowledge. Rationalists, such as René Descartes, Baruch Spinoza, and Gottfried Leibniz, held that reason alone, independent of sensory experience, can establish certain foundational truths — for instance, mathematical and logical truths seem knowable through pure thought. Empiricists, such as John Locke, George Berkeley, and David Hume, argued instead that all substantive knowledge of the world ultimately derives from sensory experience, and that the mind begins as a \'blank slate\' (tabula rasa) with no innate ideas. The debate is not simply about whether reason or experience matters at all — both schools use reasoning and both acknowledge some role for experience — but about which one provides the ultimate foundation for genuine knowledge.',
          'question': 'According to the passage, rationalists held that certain foundational truths can be established by:',
          'options': ['religious revelation only', 'reason alone, independent of sensory experience', 'sensory experience alone', 'majority consensus'],
          'correct': 1,
        },
        {
          'passage': 'Rationalism and empiricism represent two competing schools of thought about the primary source of human knowledge. Rationalists, such as René Descartes, Baruch Spinoza, and Gottfried Leibniz, held that reason alone, independent of sensory experience, can establish certain foundational truths — for instance, mathematical and logical truths seem knowable through pure thought. Empiricists, such as John Locke, George Berkeley, and David Hume, argued instead that all substantive knowledge of the world ultimately derives from sensory experience, and that the mind begins as a \'blank slate\' (tabula rasa) with no innate ideas. The debate is not simply about whether reason or experience matters at all — both schools use reasoning and both acknowledge some role for experience — but about which one provides the ultimate foundation for genuine knowledge.',
          'question': 'According to the passage, which three philosophers are named as rationalists?',
          'options': ['Kant, Hegel, and Marx', 'Plato, Aristotle, and Socrates', 'Locke, Berkeley, and Hume', 'Descartes, Spinoza, and Leibniz'],
          'correct': 3,
        },
        {
          'passage': 'Rationalism and empiricism represent two competing schools of thought about the primary source of human knowledge. Rationalists, such as René Descartes, Baruch Spinoza, and Gottfried Leibniz, held that reason alone, independent of sensory experience, can establish certain foundational truths — for instance, mathematical and logical truths seem knowable through pure thought. Empiricists, such as John Locke, George Berkeley, and David Hume, argued instead that all substantive knowledge of the world ultimately derives from sensory experience, and that the mind begins as a \'blank slate\' (tabula rasa) with no innate ideas. The debate is not simply about whether reason or experience matters at all — both schools use reasoning and both acknowledge some role for experience — but about which one provides the ultimate foundation for genuine knowledge.',
          'question': 'According to the passage, empiricists argued that the mind begins as a:',
          'options': ['fully formed set of complete knowledge', '\'blank slate\' (tabula rasa) with no innate ideas', 'perfect mirror of mathematical forms', 'divine spark containing all truths'],
          'correct': 1,
        },
        {
          'passage': 'Rationalism and empiricism represent two competing schools of thought about the primary source of human knowledge. Rationalists, such as René Descartes, Baruch Spinoza, and Gottfried Leibniz, held that reason alone, independent of sensory experience, can establish certain foundational truths — for instance, mathematical and logical truths seem knowable through pure thought. Empiricists, such as John Locke, George Berkeley, and David Hume, argued instead that all substantive knowledge of the world ultimately derives from sensory experience, and that the mind begins as a \'blank slate\' (tabula rasa) with no innate ideas. The debate is not simply about whether reason or experience matters at all — both schools use reasoning and both acknowledge some role for experience — but about which one provides the ultimate foundation for genuine knowledge.',
          'question': 'According to the passage, what is the real point of disagreement between rationalism and empiricism?',
          'options': ['whether reasoning is ever useful at all', 'which source provides the ultimate foundation for genuine knowledge', 'whether mathematics is a real subject', 'whether experience matters even slightly Passage 2 Existentialism, associated with thinkers such as Søren Kierkegaard, Jean-Paul Sartre, and Simone de Beauvoir, emphasizes individual existence, freedom, and the responsibility that comes with choice. A central existentialist claim, summarized in Sartre\'s phrase \'existence precedes essence,\' is that human beings are not born with a fixed purpose or nature the way a manufactured tool is designed for a specific function; instead, individuals must create their own meaning and values through the choices they make. This view can feel liberating, since it rejects the idea that one\'s life is predetermined by external authority, but existentialists also stress that this freedom brings a weighty responsibility, since a person cannot blame fate, God, or \'human nature\' for the choices they make.'],
          'correct': 1,
        },
        {
          'passage': 'Existentialism, associated with thinkers such as Søren Kierkegaard, Jean-Paul Sartre, and Simone de Beauvoir, emphasizes individual existence, freedom, and the responsibility that comes with choice. A central existentialist claim, summarized in Sartre\'s phrase \'existence precedes essence,\' is that human beings are not born with a fixed purpose or nature the way a manufactured tool is designed for a specific function; instead, individuals must create their own meaning and values through the choices they make. This view can feel liberating, since it rejects the idea that one\'s life is predetermined by external authority, but existentialists also stress that this freedom brings a weighty responsibility, since a person cannot blame fate, God, or \'human nature\' for the choices they make.',
          'question': 'According to the passage, existentialism emphasizes individual existence, freedom, and:',
          'options': ['strict obedience to religious law', 'the pursuit of scientific certainty', 'conformity to social expectations', 'the responsibility that comes with choice'],
          'correct': 3,
        },
        {
          'passage': 'Existentialism, associated with thinkers such as Søren Kierkegaard, Jean-Paul Sartre, and Simone de Beauvoir, emphasizes individual existence, freedom, and the responsibility that comes with choice. A central existentialist claim, summarized in Sartre\'s phrase \'existence precedes essence,\' is that human beings are not born with a fixed purpose or nature the way a manufactured tool is designed for a specific function; instead, individuals must create their own meaning and values through the choices they make. This view can feel liberating, since it rejects the idea that one\'s life is predetermined by external authority, but existentialists also stress that this freedom brings a weighty responsibility, since a person cannot blame fate, God, or \'human nature\' for the choices they make.',
          'question': 'According to the passage, Sartre\'s phrase \'existence precedes essence\' means:',
          'options': ['humans are not born with a fixed purpose, and must create their own meaning through choices', 'essence determines existence completely', 'humans are manufactured for a specific purpose, like a tool', 'meaning is handed down entirely by tradition'],
          'correct': 0,
        },
        {
          'passage': 'Existentialism, associated with thinkers such as Søren Kierkegaard, Jean-Paul Sartre, and Simone de Beauvoir, emphasizes individual existence, freedom, and the responsibility that comes with choice. A central existentialist claim, summarized in Sartre\'s phrase \'existence precedes essence,\' is that human beings are not born with a fixed purpose or nature the way a manufactured tool is designed for a specific function; instead, individuals must create their own meaning and values through the choices they make. This view can feel liberating, since it rejects the idea that one\'s life is predetermined by external authority, but existentialists also stress that this freedom brings a weighty responsibility, since a person cannot blame fate, God, or \'human nature\' for the choices they make.',
          'question': 'According to the passage, why can existentialist freedom feel liberating?',
          'options': ['because it rejects the idea that life is predetermined by external authority', 'because it guarantees a happy life', 'because it eliminates the need to make any decisions', 'because it removes all responsibility from a person\'s choices'],
          'correct': 0,
        },
        {
          'passage': 'Existentialism, associated with thinkers such as Søren Kierkegaard, Jean-Paul Sartre, and Simone de Beauvoir, emphasizes individual existence, freedom, and the responsibility that comes with choice. A central existentialist claim, summarized in Sartre\'s phrase \'existence precedes essence,\' is that human beings are not born with a fixed purpose or nature the way a manufactured tool is designed for a specific function; instead, individuals must create their own meaning and values through the choices they make. This view can feel liberating, since it rejects the idea that one\'s life is predetermined by external authority, but existentialists also stress that this freedom brings a weighty responsibility, since a person cannot blame fate, God, or \'human nature\' for the choices they make.',
          'question': 'According to the passage, what weighty consequence accompanies existentialist freedom?',
          'options': ['a person cannot blame fate, God, or \'human nature\' for their choices', 'a person becomes exempt from all criticism', 'a person no longer needs to make choices', 'a person is guaranteed success in life Passage 3 Utilitarianism, developed most famously by Jeremy Bentham and later refined by John Stuart Mill, is a school of ethical thought holding that the right action is the one that produces the greatest overall happiness or well-being for the greatest number of people affected. Bentham proposed a \'hedonic calculus\' to weigh the intensity, duration, and likelihood of pleasure and pain resulting from an action. Mill later argued that not all pleasures are equal in quality — intellectual and moral pleasures, he claimed, are inherently higher than merely physical ones, famously writing that it is \'better to be Socrates dissatisfied than a fool satisfied.\' Critics of utilitarianism have long argued that it can, in principle, justify harming a minority if doing so increases overall aggregate happiness.'],
          'correct': 0,
        },
        {
          'passage': 'Utilitarianism, developed most famously by Jeremy Bentham and later refined by John Stuart Mill, is a school of ethical thought holding that the right action is the one that produces the greatest overall happiness or well-being for the greatest number of people affected. Bentham proposed a \'hedonic calculus\' to weigh the intensity, duration, and likelihood of pleasure and pain resulting from an action. Mill later argued that not all pleasures are equal in quality — intellectual and moral pleasures, he claimed, are inherently higher than merely physical ones, famously writing that it is \'better to be Socrates dissatisfied than a fool satisfied.\' Critics of utilitarianism have long argued that it can, in principle, justify harming a minority if doing so increases overall aggregate happiness.',
          'question': 'According to the passage, utilitarianism holds that the right action is the one that produces:',
          'options': ['the greatest overall happiness or well-being for the greatest number', 'the greatest personal wealth for the actor', 'strict adherence to a fixed set of duties', 'the most beautiful outcome regardless of suffering'],
          'correct': 0,
        },
        {
          'passage': 'Utilitarianism, developed most famously by Jeremy Bentham and later refined by John Stuart Mill, is a school of ethical thought holding that the right action is the one that produces the greatest overall happiness or well-being for the greatest number of people affected. Bentham proposed a \'hedonic calculus\' to weigh the intensity, duration, and likelihood of pleasure and pain resulting from an action. Mill later argued that not all pleasures are equal in quality — intellectual and moral pleasures, he claimed, are inherently higher than merely physical ones, famously writing that it is \'better to be Socrates dissatisfied than a fool satisfied.\' Critics of utilitarianism have long argued that it can, in principle, justify harming a minority if doing so increases overall aggregate happiness.',
          'question': 'According to the passage, who proposed the \'hedonic calculus\'?',
          'options': ['Jeremy Bentham', 'Immanuel Kant', 'Aristotle', 'John Stuart Mill'],
          'correct': 0,
        },
        {
          'passage': 'Utilitarianism, developed most famously by Jeremy Bentham and later refined by John Stuart Mill, is a school of ethical thought holding that the right action is the one that produces the greatest overall happiness or well-being for the greatest number of people affected. Bentham proposed a \'hedonic calculus\' to weigh the intensity, duration, and likelihood of pleasure and pain resulting from an action. Mill later argued that not all pleasures are equal in quality — intellectual and moral pleasures, he claimed, are inherently higher than merely physical ones, famously writing that it is \'better to be Socrates dissatisfied than a fool satisfied.\' Critics of utilitarianism have long argued that it can, in principle, justify harming a minority if doing so increases overall aggregate happiness.',
          'question': 'According to the passage, what did Mill argue about the quality of pleasures?',
          'options': ['only physical pleasures count as real happiness', 'pleasure should be ignored entirely in ethics', 'not all pleasures are equal in quality; intellectual and moral pleasures are higher', 'all pleasures are exactly equal regardless of type'],
          'correct': 2,
        },
        {
          'passage': 'Utilitarianism, developed most famously by Jeremy Bentham and later refined by John Stuart Mill, is a school of ethical thought holding that the right action is the one that produces the greatest overall happiness or well-being for the greatest number of people affected. Bentham proposed a \'hedonic calculus\' to weigh the intensity, duration, and likelihood of pleasure and pain resulting from an action. Mill later argued that not all pleasures are equal in quality — intellectual and moral pleasures, he claimed, are inherently higher than merely physical ones, famously writing that it is \'better to be Socrates dissatisfied than a fool satisfied.\' Critics of utilitarianism have long argued that it can, in principle, justify harming a minority if doing so increases overall aggregate happiness.',
          'question': 'According to the passage, what have critics long argued about utilitarianism?',
          'options': ['it ignores happiness entirely', 'it can, in principle, justify harming a minority to increase overall happiness', 'it is identical to deontology', 'it never considers the consequences of actions Passage 4 Stoicism, an ancient Greek and Roman school associated with figures such as Zeno of Citium, Epictetus, and Marcus Aurelius, teaches that a good life is achieved by living in accordance with reason and virtue, while accepting with equanimity whatever happens that lies outside one\'s control. A central Stoic distinction separates what \'is up to us\' — our own judgments, desires, and reactions — from what is not up to us, such as other people\'s actions, external events, or even our own health and reputation. Suffering, the Stoics argued, often arises not from events themselves but from our judgments and desires about those events; by training oneself to desire only what is truly within one\'s control, a Stoic aims to achieve a stable, undisturbed inner peace regardless of external circumstances.'],
          'correct': 1,
        },
        {
          'passage': 'Stoicism, an ancient Greek and Roman school associated with figures such as Zeno of Citium, Epictetus, and Marcus Aurelius, teaches that a good life is achieved by living in accordance with reason and virtue, while accepting with equanimity whatever happens that lies outside one\'s control. A central Stoic distinction separates what \'is up to us\' — our own judgments, desires, and reactions — from what is not up to us, such as other people\'s actions, external events, or even our own health and reputation. Suffering, the Stoics argued, often arises not from events themselves but from our judgments and desires about those events; by training oneself to desire only what is truly within one\'s control, a Stoic aims to achieve a stable, undisturbed inner peace regardless of external circumstances.',
          'question': 'According to the passage, Stoicism teaches that a good life is achieved by living in accordance with:',
          'options': ['wealth and physical pleasure', 'reason and virtue, while accepting what lies outside one\'s control', 'total avoidance of all emotion', 'strict religious ritual'],
          'correct': 1,
        },
        {
          'passage': 'Stoicism, an ancient Greek and Roman school associated with figures such as Zeno of Citium, Epictetus, and Marcus Aurelius, teaches that a good life is achieved by living in accordance with reason and virtue, while accepting with equanimity whatever happens that lies outside one\'s control. A central Stoic distinction separates what \'is up to us\' — our own judgments, desires, and reactions — from what is not up to us, such as other people\'s actions, external events, or even our own health and reputation. Suffering, the Stoics argued, often arises not from events themselves but from our judgments and desires about those events; by training oneself to desire only what is truly within one\'s control, a Stoic aims to achieve a stable, undisturbed inner peace regardless of external circumstances.',
          'question': 'According to the passage, which three figures are named as associated with Stoicism?',
          'options': ['Zeno of Citium, Epictetus, and Marcus Aurelius', 'Sartre, Kierkegaard, and de Beauvoir', 'Bentham, Mill, and Kant', 'Socrates, Plato, and Aristotle'],
          'correct': 0,
        },
        {
          'passage': 'Stoicism, an ancient Greek and Roman school associated with figures such as Zeno of Citium, Epictetus, and Marcus Aurelius, teaches that a good life is achieved by living in accordance with reason and virtue, while accepting with equanimity whatever happens that lies outside one\'s control. A central Stoic distinction separates what \'is up to us\' — our own judgments, desires, and reactions — from what is not up to us, such as other people\'s actions, external events, or even our own health and reputation. Suffering, the Stoics argued, often arises not from events themselves but from our judgments and desires about those events; by training oneself to desire only what is truly within one\'s control, a Stoic aims to achieve a stable, undisturbed inner peace regardless of external circumstances.',
          'question': 'According to the passage, the central Stoic distinction separates:',
          'options': ['ancient philosophy from modern philosophy', 'what \'is up to us\' from what is not up to us', 'logic from ethics', 'rich people from poor people'],
          'correct': 1,
        },
        {
          'passage': 'Stoicism, an ancient Greek and Roman school associated with figures such as Zeno of Citium, Epictetus, and Marcus Aurelius, teaches that a good life is achieved by living in accordance with reason and virtue, while accepting with equanimity whatever happens that lies outside one\'s control. A central Stoic distinction separates what \'is up to us\' — our own judgments, desires, and reactions — from what is not up to us, such as other people\'s actions, external events, or even our own health and reputation. Suffering, the Stoics argued, often arises not from events themselves but from our judgments and desires about those events; by training oneself to desire only what is truly within one\'s control, a Stoic aims to achieve a stable, undisturbed inner peace regardless of external circumstances.',
          'question': 'According to the Stoics as described in the passage, suffering often arises from:',
          'options': ['our judgments and desires about events, not the events themselves', 'external events alone, regardless of our judgments', 'the actions of other people exclusively', 'a lack of material wealth Passage 5 Pragmatism, an American school of philosophy developed by thinkers such as Charles Sanders Peirce, William James, and John Dewey, evaluates the truth or value of an idea largely in terms of its practical consequences. Rather than asking whether a belief corresponds to some abstract, mind-independent reality in the traditional sense, pragmatists often ask: what practical difference would it make if this belief were true rather than false? If two competing beliefs would lead to exactly the same practical consequences in every conceivable situation, pragmatists suggest the apparent disagreement between them may be less meaningful than it first seems. Pragmatism has been especially influential in American approaches to education, law, and democratic theory, particularly through John Dewey\'s emphasis on learning through active experience.'],
          'correct': 0,
        },
        {
          'passage': 'Pragmatism, an American school of philosophy developed by thinkers such as Charles Sanders Peirce, William James, and John Dewey, evaluates the truth or value of an idea largely in terms of its practical consequences. Rather than asking whether a belief corresponds to some abstract, mind-independent reality in the traditional sense, pragmatists often ask: what practical difference would it make if this belief were true rather than false? If two competing beliefs would lead to exactly the same practical consequences in every conceivable situation, pragmatists suggest the apparent disagreement between them may be less meaningful than it first seems. Pragmatism has been especially influential in American approaches to education, law, and democratic theory, particularly through John Dewey\'s emphasis on learning through active experience.',
          'question': 'According to the passage, pragmatism evaluates the truth or value of an idea largely in terms of:',
          'options': ['its historical age', 'its emotional appeal', 'its popularity among philosophers', 'its practical consequences'],
          'correct': 3,
        },
        {
          'passage': 'Pragmatism, an American school of philosophy developed by thinkers such as Charles Sanders Peirce, William James, and John Dewey, evaluates the truth or value of an idea largely in terms of its practical consequences. Rather than asking whether a belief corresponds to some abstract, mind-independent reality in the traditional sense, pragmatists often ask: what practical difference would it make if this belief were true rather than false? If two competing beliefs would lead to exactly the same practical consequences in every conceivable situation, pragmatists suggest the apparent disagreement between them may be less meaningful than it first seems. Pragmatism has been especially influential in American approaches to education, law, and democratic theory, particularly through John Dewey\'s emphasis on learning through active experience.',
          'question': 'According to the passage, which three thinkers are named as developing American pragmatism?',
          'options': ['Hobbes, Locke, and Rousseau', 'Bentham, Mill, and Sidgwick', 'Descartes, Spinoza, and Leibniz', 'Charles Sanders Peirce, William James, and John Dewey'],
          'correct': 3,
        },
        {
          'passage': 'Pragmatism, an American school of philosophy developed by thinkers such as Charles Sanders Peirce, William James, and John Dewey, evaluates the truth or value of an idea largely in terms of its practical consequences. Rather than asking whether a belief corresponds to some abstract, mind-independent reality in the traditional sense, pragmatists often ask: what practical difference would it make if this belief were true rather than false? If two competing beliefs would lead to exactly the same practical consequences in every conceivable situation, pragmatists suggest the apparent disagreement between them may be less meaningful than it first seems. Pragmatism has been especially influential in American approaches to education, law, and democratic theory, particularly through John Dewey\'s emphasis on learning through active experience.',
          'question': 'According to the passage, what key question do pragmatists often ask about a belief?',
          'options': ['whether the belief is popular with the public', 'whether the belief is ancient or modern', 'whether the belief can be proven mathematically', 'what practical difference it would make if the belief were true rather than false'],
          'correct': 3,
        },
        {
          'passage': 'Pragmatism, an American school of philosophy developed by thinkers such as Charles Sanders Peirce, William James, and John Dewey, evaluates the truth or value of an idea largely in terms of its practical consequences. Rather than asking whether a belief corresponds to some abstract, mind-independent reality in the traditional sense, pragmatists often ask: what practical difference would it make if this belief were true rather than false? If two competing beliefs would lead to exactly the same practical consequences in every conceivable situation, pragmatists suggest the apparent disagreement between them may be less meaningful than it first seems. Pragmatism has been especially influential in American approaches to education, law, and democratic theory, particularly through John Dewey\'s emphasis on learning through active experience.',
          'question': 'According to the passage, John Dewey was particularly influential regarding:',
          'options': ['the mind-body problem', 'the veil of ignorance', 'learning through active experience, especially in education', 'the hedonic calculus'],
          'correct': 2,
        },
        {
          'question': 'Confucianism, a school of thought originating in ancient China, places central emphasis on:',
          'options': ['the rejection of all tradition', 'social harmony, moral cultivation, and proper relationships between people', 'individual isolation from all society', 'strict mathematical logic'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'Kantian deontology\'?',
          'options': ['the view that actions are right or wrong based on whether they conform to universalizable moral duties, not their consequences', 'the view that morality is entirely relative to culture', 'the view that only outcomes determine moral worth', 'the view that pleasure is the sole measure of a good action'],
          'correct': 0,
        },
        {
          'question': 'Kant\'s \'categorical imperative\' can be summarized, in one formulation, as the requirement to:',
          'options': ['follow whichever action produces the best outcome', 'act only to maximize your own personal pleasure', 'obey whatever a king or ruler commands', 'act only according to a rule you could will to become a universal law'],
          'correct': 3,
        },
        {
          'question': 'Nihilism, broadly, is the view that:',
          'options': ['all religious claims are literally true', 'morality is grounded firmly in scientific fact', 'life has one single, universally agreed meaning', 'life lacks inherent meaning, purpose, or objective value'],
          'correct': 3,
        },
        {
          'question': 'Skepticism, as a philosophical school associated with figures like Pyrrho of Elis, is characterized by:',
          'options': ['rejecting the possibility of any doubt', 'blind faith in tradition', 'absolute certainty about all matters', 'suspending judgment on claims that cannot be adequately justified'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'idealism\' as a metaphysical school of thought?',
          'options': ['the view that reality is fundamentally mental or dependent on the mind', 'the view that nothing at all exists', 'the view that only physical matter exists', 'the view that ideas have no importance'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'materialism\' (or physicalism) as a metaphysical school of thought?',
          'options': ['the view that mathematics is not real', 'the view that everything that exists is physical, or ultimately depends on the physical', 'the view that morality is entirely subjective', 'the view that only ideas exist, not matter'],
          'correct': 1,
        },
        {
          'question': 'Confucian, Daoist, and Legalist thought are three major schools that emerged in which ancient civilization?',
          'options': ['ancient Rome', 'ancient China', 'ancient Greece', 'ancient Egypt'],
          'correct': 1,
        },
        {
          'question': 'Daoism (Taoism), a Chinese school of thought, places central emphasis on:',
          'options': ['aggressive military conquest', 'strict bureaucratic control of society', 'rigid formal logic', 'living in harmony with the natural flow of the universe, the Dao'],
          'correct': 3,
        },
        {
          'question': 'Ubuntu philosophy, prominent in southern African thought, is often summarized by the idea that:',
          'options': ['a person is a person through other persons, emphasizing communal interdependence', 'individual achievement matters more than community', 'morality is purely a private, individual matter', 'only rational argument, not relationship, defines personhood'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'social contract theory\' as a school of political thought?',
          'options': ['the view that rulers are chosen entirely by divine right', 'the view that political authority and obligation arise from an agreement among individuals', 'the view that laws should never be written down', 'the view that no government can ever be legitimate'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'libertarianism\' as a school of political philosophy?',
          'options': ['a view emphasizing total state control of the economy', 'a view rejecting the concept of individual rights entirely', 'a view identical to utilitarianism', 'a view emphasizing strong individual liberty and minimal state interference'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'communitarianism\' as a school of political philosophy?',
          'options': ['a view identical to strict individualism', 'a view emphasizing the importance of community, shared values, and social context in shaping individuals and justice', 'a view focused exclusively on economic efficiency', 'a view that rejects the existence of communities'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'postmodernism\' as a broad intellectual movement?',
          'options': ['a strict return to ancient Greek philosophy', 'a skeptical stance toward grand, universal narratives and claims of objective, culture-independent truth', 'a school devoted purely to mathematical logic', 'a movement that rejects all forms of language'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'logical positivism,\' a 20th-century school of philosophy?',
          'options': ['the view that logic should be abandoned entirely', 'the view that all statements are equally meaningful', 'the view that metaphysics is the most important branch of philosophy', 'the view that meaningful statements must be either logically provable or empirically verifiable'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'contractarianism\' in ethics, distinct from political social contract theory?',
          'options': ['the view that only legal rules matter, not moral ones', 'the view that morality does not exist', 'the view that moral principles are those that rational agents would agree to under fair conditions', 'the view that morality is dictated purely by religious scripture'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'care ethics\' as a school of moral thought?',
          'options': ['an approach that denies the importance of emotion in morality', 'an approach identical to classical utilitarianism', 'an approach emphasizing strict impartial rules above all relationships', 'an approach emphasizing relationships, empathy, and responsiveness to the needs of particular others'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'Marxism\' as a school of thought?',
          'options': ['a school devoted to formal symbolic logic', 'a purely aesthetic theory of art appreciation', 'a materialist theory of history and society emphasizing class conflict and the critique of capitalism', 'a theory focused purely on individual psychology'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'natural law theory\' in ethics and political philosophy?',
          'options': ['the view that morality and just law are grounded in an objective order discoverable through reason, inherent in nature', 'the view that only scientific laws of physics count as \'natural law\'', 'the view that morality is entirely arbitrary', 'the view that law is whatever those in power declare it to be'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'absurdism,\' associated with Albert Camus?',
          'options': ['the view that meaning is easily found through religious faith alone', 'the view identical to classical Stoicism', 'the view that life is objectively meaningless and nothing more need be said', 'the view that humans naturally seek meaning in a universe that offers none, creating an inherent tension or \'absurd\' condition'],
          'correct': 3,
        },
      ];
    case 'gns106_u2_3': // African Philosophy
      return [
        {
          'passage': 'For much of the twentieth century, some Western scholars questioned whether \'African philosophy\' existed as a distinct field, sometimes assuming that rigorous, systematic philosophical reasoning was a uniquely European achievement. African philosophers have responded to this challenge in several ways. Some, associated with what is often called \'ethnophilosophy,\' argue that shared worldviews embedded in African languages, proverbs, and communal practices constitute a genuine philosophy, even where it is not written in the systematic treatise form familiar from the European tradition. Others, associated with a more \'professional\' or \'critical\' approach, argue that African philosophy should be defined instead by individual African thinkers engaging critically and rigorously with philosophical questions, using methods that can be compared directly with philosophy anywhere else in the world.',
          'question': 'According to the passage, some Western scholars in the twentieth century questioned whether:',
          'options': ['Greek philosophy had any influence on Europe', 'logic could be taught in universities', 'ethics was a legitimate branch of philosophy', '\'African philosophy\' existed as a distinct field'],
          'correct': 3,
        },
        {
          'passage': 'For much of the twentieth century, some Western scholars questioned whether \'African philosophy\' existed as a distinct field, sometimes assuming that rigorous, systematic philosophical reasoning was a uniquely European achievement. African philosophers have responded to this challenge in several ways. Some, associated with what is often called \'ethnophilosophy,\' argue that shared worldviews embedded in African languages, proverbs, and communal practices constitute a genuine philosophy, even where it is not written in the systematic treatise form familiar from the European tradition. Others, associated with a more \'professional\' or \'critical\' approach, argue that African philosophy should be defined instead by individual African thinkers engaging critically and rigorously with philosophical questions, using methods that can be compared directly with philosophy anywhere else in the world.',
          'question': 'According to the passage, \'ethnophilosophy\' argues that genuine philosophy can be found in:',
          'options': ['shared worldviews embedded in African languages, proverbs, and communal practices', 'exclusively European philosophical texts', 'only formally published academic treatises', 'mathematical formulas alone'],
          'correct': 0,
        },
        {
          'passage': 'For much of the twentieth century, some Western scholars questioned whether \'African philosophy\' existed as a distinct field, sometimes assuming that rigorous, systematic philosophical reasoning was a uniquely European achievement. African philosophers have responded to this challenge in several ways. Some, associated with what is often called \'ethnophilosophy,\' argue that shared worldviews embedded in African languages, proverbs, and communal practices constitute a genuine philosophy, even where it is not written in the systematic treatise form familiar from the European tradition. Others, associated with a more \'professional\' or \'critical\' approach, argue that African philosophy should be defined instead by individual African thinkers engaging critically and rigorously with philosophical questions, using methods that can be compared directly with philosophy anywhere else in the world.',
          'question': 'According to the passage, the \'professional\' or \'critical\' approach instead defines African philosophy by:',
          'options': ['individual African thinkers critically and rigorously engaging philosophical questions', 'strict adherence to European philosophical texts', 'oral tradition exclusively, with no individual authorship', 'the absence of any systematic reasoning'],
          'correct': 0,
        },
        {
          'passage': 'For much of the twentieth century, some Western scholars questioned whether \'African philosophy\' existed as a distinct field, sometimes assuming that rigorous, systematic philosophical reasoning was a uniquely European achievement. African philosophers have responded to this challenge in several ways. Some, associated with what is often called \'ethnophilosophy,\' argue that shared worldviews embedded in African languages, proverbs, and communal practices constitute a genuine philosophy, even where it is not written in the systematic treatise form familiar from the European tradition. Others, associated with a more \'professional\' or \'critical\' approach, argue that African philosophy should be defined instead by individual African thinkers engaging critically and rigorously with philosophical questions, using methods that can be compared directly with philosophy anywhere else in the world.',
          'question': 'According to the passage, some Western scholars assumed philosophical reasoning was:',
          'options': ['a shared achievement of all cultures equally', 'impossible for any culture to develop', 'a uniquely European achievement', 'primarily an African achievement Passage 2 Ubuntu, a concept found across several Southern African languages and often summarized by the phrase \'umuntu ngumuntu ngabantu\' — roughly, \'a person is a person through other persons\' — has become one of the most widely discussed concepts in African philosophy. Rather than treating individual identity as something a person possesses independently and then chooses to relate to others, Ubuntu suggests that personhood itself is constituted through relationships and community. This has significant implications for ethics and political philosophy: it suggests that a person\'s moral development, and even their status as a full person, depends on their participation in a web of relationships marked by mutual respect, care, and responsibility, rather than on isolated individual achievement alone. Archbishop Desmond Tutu and philosopher Mogobe Ramose are among the figures who have written influentially on Ubuntu.'],
          'correct': 2,
        },
        {
          'passage': 'Ubuntu, a concept found across several Southern African languages and often summarized by the phrase \'umuntu ngumuntu ngabantu\' — roughly, \'a person is a person through other persons\' — has become one of the most widely discussed concepts in African philosophy. Rather than treating individual identity as something a person possesses independently and then chooses to relate to others, Ubuntu suggests that personhood itself is constituted through relationships and community. This has significant implications for ethics and political philosophy: it suggests that a person\'s moral development, and even their status as a full person, depends on their participation in a web of relationships marked by mutual respect, care, and responsibility, rather than on isolated individual achievement alone. Archbishop Desmond Tutu and philosopher Mogobe Ramose are among the figures who have written influentially on Ubuntu.',
          'question': 'According to the passage, the Ubuntu phrase \'umuntu ngumuntu ngabantu\' roughly translates to:',
          'options': ['\'the individual is above the community\'', '\'nature and humanity are separate\'', '\'a person is a person through other persons\'', '\'wisdom comes only from elders\''],
          'correct': 2,
        },
        {
          'passage': 'Ubuntu, a concept found across several Southern African languages and often summarized by the phrase \'umuntu ngumuntu ngabantu\' — roughly, \'a person is a person through other persons\' — has become one of the most widely discussed concepts in African philosophy. Rather than treating individual identity as something a person possesses independently and then chooses to relate to others, Ubuntu suggests that personhood itself is constituted through relationships and community. This has significant implications for ethics and political philosophy: it suggests that a person\'s moral development, and even their status as a full person, depends on their participation in a web of relationships marked by mutual respect, care, and responsibility, rather than on isolated individual achievement alone. Archbishop Desmond Tutu and philosopher Mogobe Ramose are among the figures who have written influentially on Ubuntu.',
          'question': 'According to the passage, Ubuntu suggests that personhood itself is:',
          'options': ['possessed independently before any relationships form', 'constituted through relationships and community', 'determined entirely by biological birth', 'irrelevant to ethical development'],
          'correct': 1,
        },
        {
          'passage': 'Ubuntu, a concept found across several Southern African languages and often summarized by the phrase \'umuntu ngumuntu ngabantu\' — roughly, \'a person is a person through other persons\' — has become one of the most widely discussed concepts in African philosophy. Rather than treating individual identity as something a person possesses independently and then chooses to relate to others, Ubuntu suggests that personhood itself is constituted through relationships and community. This has significant implications for ethics and political philosophy: it suggests that a person\'s moral development, and even their status as a full person, depends on their participation in a web of relationships marked by mutual respect, care, and responsibility, rather than on isolated individual achievement alone. Archbishop Desmond Tutu and philosopher Mogobe Ramose are among the figures who have written influentially on Ubuntu.',
          'question': 'According to the passage, what does Ubuntu imply about moral development?',
          'options': ['it is entirely fixed at birth', 'it cannot be influenced by community at all', 'it depends solely on isolated individual achievement', 'it depends on participation in a web of relationships marked by mutual respect and care'],
          'correct': 3,
        },
        {
          'passage': 'Ubuntu, a concept found across several Southern African languages and often summarized by the phrase \'umuntu ngumuntu ngabantu\' — roughly, \'a person is a person through other persons\' — has become one of the most widely discussed concepts in African philosophy. Rather than treating individual identity as something a person possesses independently and then chooses to relate to others, Ubuntu suggests that personhood itself is constituted through relationships and community. This has significant implications for ethics and political philosophy: it suggests that a person\'s moral development, and even their status as a full person, depends on their participation in a web of relationships marked by mutual respect, care, and responsibility, rather than on isolated individual achievement alone. Archbishop Desmond Tutu and philosopher Mogobe Ramose are among the figures who have written influentially on Ubuntu.',
          'question': 'According to the passage, which two figures are named as writing influentially on Ubuntu?',
          'options': ['Kwame Nkrumah and Julius Nyerere', 'Archbishop Desmond Tutu and philosopher Mogobe Ramose', 'Kwasi Wiredu and Paulin Hountondji', 'Chinua Achebe and Wole Soyinka Passage 3 The Ghanaian philosopher Kwasi Wiredu argued for what he called \'conceptual decolonization\' in African philosophy: the careful examination of philosophical concepts to check whether ideas imported from European languages and traditions have been uncritically assumed to apply to African thought, sometimes distorting it in the process. For example, Wiredu questioned whether a strict Western dichotomy between the material and the spiritual maps accurately onto certain traditional Akan concepts, or whether translating those concepts using that dichotomy introduces confusion not present in the original framework. Conceptual decolonization does not mean rejecting all Western philosophical tools; rather, it means using African languages and concepts as an independent starting point, rather than simply assuming Western categories are a neutral, universal default.'],
          'correct': 1,
        },
        {
          'passage': 'The Ghanaian philosopher Kwasi Wiredu argued for what he called \'conceptual decolonization\' in African philosophy: the careful examination of philosophical concepts to check whether ideas imported from European languages and traditions have been uncritically assumed to apply to African thought, sometimes distorting it in the process. For example, Wiredu questioned whether a strict Western dichotomy between the material and the spiritual maps accurately onto certain traditional Akan concepts, or whether translating those concepts using that dichotomy introduces confusion not present in the original framework. Conceptual decolonization does not mean rejecting all Western philosophical tools; rather, it means using African languages and concepts as an independent starting point, rather than simply assuming Western categories are a neutral, universal default.',
          'question': 'According to the passage, Kwasi Wiredu argued for a process he called:',
          'options': ['reflective equilibrium', 'ethnophilosophy', 'the Socratic method', 'conceptual decolonization'],
          'correct': 3,
        },
        {
          'passage': 'The Ghanaian philosopher Kwasi Wiredu argued for what he called \'conceptual decolonization\' in African philosophy: the careful examination of philosophical concepts to check whether ideas imported from European languages and traditions have been uncritically assumed to apply to African thought, sometimes distorting it in the process. For example, Wiredu questioned whether a strict Western dichotomy between the material and the spiritual maps accurately onto certain traditional Akan concepts, or whether translating those concepts using that dichotomy introduces confusion not present in the original framework. Conceptual decolonization does not mean rejecting all Western philosophical tools; rather, it means using African languages and concepts as an independent starting point, rather than simply assuming Western categories are a neutral, universal default.',
          'question': 'According to the passage, conceptual decolonization involves examining whether:',
          'options': ['logic is a purely African invention', 'ideas imported from European languages and traditions have been uncritically assumed to apply to African thought', 'African philosophy should be abolished entirely', 'European philosophy has any value at all'],
          'correct': 1,
        },
        {
          'passage': 'The Ghanaian philosopher Kwasi Wiredu argued for what he called \'conceptual decolonization\' in African philosophy: the careful examination of philosophical concepts to check whether ideas imported from European languages and traditions have been uncritically assumed to apply to African thought, sometimes distorting it in the process. For example, Wiredu questioned whether a strict Western dichotomy between the material and the spiritual maps accurately onto certain traditional Akan concepts, or whether translating those concepts using that dichotomy introduces confusion not present in the original framework. Conceptual decolonization does not mean rejecting all Western philosophical tools; rather, it means using African languages and concepts as an independent starting point, rather than simply assuming Western categories are a neutral, universal default.',
          'question': 'According to the passage, what example did Wiredu use to illustrate this process?',
          'options': ['questioning the accuracy of European maps', 'questioning whether a Western material/spiritual dichotomy maps accurately onto Akan concepts', 'questioning whether logic exists', 'questioning the existence of Ubuntu'],
          'correct': 1,
        },
        {
          'passage': 'The Ghanaian philosopher Kwasi Wiredu argued for what he called \'conceptual decolonization\' in African philosophy: the careful examination of philosophical concepts to check whether ideas imported from European languages and traditions have been uncritically assumed to apply to African thought, sometimes distorting it in the process. For example, Wiredu questioned whether a strict Western dichotomy between the material and the spiritual maps accurately onto certain traditional Akan concepts, or whether translating those concepts using that dichotomy introduces confusion not present in the original framework. Conceptual decolonization does not mean rejecting all Western philosophical tools; rather, it means using African languages and concepts as an independent starting point, rather than simply assuming Western categories are a neutral, universal default.',
          'question': 'According to the passage, does conceptual decolonization mean rejecting all Western philosophical tools?',
          'options': ['Yes, it requires rejecting all Western philosophy entirely', 'No, it does not mean rejecting all Western philosophical tools', 'The passage does not address this question', 'Yes, but only tools related to logic Passage 4 The Beninese philosopher Paulin Hountondji offered an influential critique of \'ethnophilosophy,\' arguing that treating a community\'s shared, often unwritten worldview as though it were already a unified \'philosophy\' risks flattening genuine internal disagreement and rigorous argument into a single, homogeneous set of beliefs attributed to an entire people. For Hountondji, philosophy proper requires individual authorship, critical argument, and a willingness to disagree with one\'s own tradition — features he thought were often missing from ethnophilosophical descriptions of a generalized \'African worldview.\' His critique sparked considerable debate among African philosophers about how to properly define and practice the discipline, a debate that continues to shape the field today.'],
          'correct': 1,
        },
        {
          'passage': 'The Beninese philosopher Paulin Hountondji offered an influential critique of \'ethnophilosophy,\' arguing that treating a community\'s shared, often unwritten worldview as though it were already a unified \'philosophy\' risks flattening genuine internal disagreement and rigorous argument into a single, homogeneous set of beliefs attributed to an entire people. For Hountondji, philosophy proper requires individual authorship, critical argument, and a willingness to disagree with one\'s own tradition — features he thought were often missing from ethnophilosophical descriptions of a generalized \'African worldview.\' His critique sparked considerable debate among African philosophers about how to properly define and practice the discipline, a debate that continues to shape the field today.',
          'question': 'According to the passage, Paulin Hountondji offered an influential critique of:',
          'options': ['conceptual decolonization', 'Stoicism', 'ethnophilosophy', 'Ubuntu'],
          'correct': 2,
        },
        {
          'passage': 'The Beninese philosopher Paulin Hountondji offered an influential critique of \'ethnophilosophy,\' arguing that treating a community\'s shared, often unwritten worldview as though it were already a unified \'philosophy\' risks flattening genuine internal disagreement and rigorous argument into a single, homogeneous set of beliefs attributed to an entire people. For Hountondji, philosophy proper requires individual authorship, critical argument, and a willingness to disagree with one\'s own tradition — features he thought were often missing from ethnophilosophical descriptions of a generalized \'African worldview.\' His critique sparked considerable debate among African philosophers about how to properly define and practice the discipline, a debate that continues to shape the field today.',
          'question': 'According to the passage, what did Hountondji argue treating a shared worldview as \'philosophy\' risks doing?',
          'options': ['strengthening the rigor of individual argument', 'flattening genuine internal disagreement into a single, homogeneous set of beliefs', 'proving that Africa has no philosophical tradition', 'eliminating the need for critical thought entirely'],
          'correct': 1,
        },
        {
          'passage': 'The Beninese philosopher Paulin Hountondji offered an influential critique of \'ethnophilosophy,\' arguing that treating a community\'s shared, often unwritten worldview as though it were already a unified \'philosophy\' risks flattening genuine internal disagreement and rigorous argument into a single, homogeneous set of beliefs attributed to an entire people. For Hountondji, philosophy proper requires individual authorship, critical argument, and a willingness to disagree with one\'s own tradition — features he thought were often missing from ethnophilosophical descriptions of a generalized \'African worldview.\' His critique sparked considerable debate among African philosophers about how to properly define and practice the discipline, a debate that continues to shape the field today.',
          'question': 'According to the passage, what did Hountondji believe philosophy proper requires?',
          'options': ['individual authorship, critical argument, and willingness to disagree with one\'s own tradition', 'exclusively European sources', 'only oral tradition passed down unchanged', 'strict agreement with every member of a community'],
          'correct': 0,
        },
        {
          'passage': 'The Beninese philosopher Paulin Hountondji offered an influential critique of \'ethnophilosophy,\' arguing that treating a community\'s shared, often unwritten worldview as though it were already a unified \'philosophy\' risks flattening genuine internal disagreement and rigorous argument into a single, homogeneous set of beliefs attributed to an entire people. For Hountondji, philosophy proper requires individual authorship, critical argument, and a willingness to disagree with one\'s own tradition — features he thought were often missing from ethnophilosophical descriptions of a generalized \'African worldview.\' His critique sparked considerable debate among African philosophers about how to properly define and practice the discipline, a debate that continues to shape the field today.',
          'question': 'According to the passage, what has Hountondji\'s critique sparked among African philosophers?',
          'options': ['the complete abandonment of African philosophy as a field', 'universal agreement with no further discussion', 'considerable debate about how to properly define and practice the discipline', 'a return to purely European philosophical methods Passage 5 Political leaders in the era of African independence movements, including Kwame Nkrumah of Ghana and Julius Nyerere of Tanzania, developed philosophical positions that combined political theory with reflections on African identity and communal values. Nkrumah articulated \'consciencism,\' an attempt to synthesize traditional African communal values, Islamic influence, and Euro-Christian influence into a coherent framework capable of guiding a newly independent society. Nyerere developed \'ujamaa,\' a concept often translated as \'familyhood,\' which he used as the philosophical basis for a distinctively African form of socialism grounded in traditional communal cooperation rather than imported European class analysis. Both men treated philosophy not as a purely academic exercise but as a practical resource for nation-building.'],
          'correct': 2,
        },
        {
          'passage': 'Political leaders in the era of African independence movements, including Kwame Nkrumah of Ghana and Julius Nyerere of Tanzania, developed philosophical positions that combined political theory with reflections on African identity and communal values. Nkrumah articulated \'consciencism,\' an attempt to synthesize traditional African communal values, Islamic influence, and Euro-Christian influence into a coherent framework capable of guiding a newly independent society. Nyerere developed \'ujamaa,\' a concept often translated as \'familyhood,\' which he used as the philosophical basis for a distinctively African form of socialism grounded in traditional communal cooperation rather than imported European class analysis. Both men treated philosophy not as a purely academic exercise but as a practical resource for nation-building.',
          'question': 'According to the passage, Kwame Nkrumah\'s philosophical position was called:',
          'options': ['Ubuntu', 'conceptual decolonization', 'ujamaa', 'consciencism'],
          'correct': 3,
        },
        {
          'passage': 'Political leaders in the era of African independence movements, including Kwame Nkrumah of Ghana and Julius Nyerere of Tanzania, developed philosophical positions that combined political theory with reflections on African identity and communal values. Nkrumah articulated \'consciencism,\' an attempt to synthesize traditional African communal values, Islamic influence, and Euro-Christian influence into a coherent framework capable of guiding a newly independent society. Nyerere developed \'ujamaa,\' a concept often translated as \'familyhood,\' which he used as the philosophical basis for a distinctively African form of socialism grounded in traditional communal cooperation rather than imported European class analysis. Both men treated philosophy not as a purely academic exercise but as a practical resource for nation-building.',
          'question': 'According to the passage, consciencism attempted to synthesize:',
          'options': ['only Marxist economic theory', 'traditional African communal values, Islamic influence, and Euro-Christian influence', 'purely European liberal democracy', 'exclusively traditional religious ritual'],
          'correct': 1,
        },
        {
          'passage': 'Political leaders in the era of African independence movements, including Kwame Nkrumah of Ghana and Julius Nyerere of Tanzania, developed philosophical positions that combined political theory with reflections on African identity and communal values. Nkrumah articulated \'consciencism,\' an attempt to synthesize traditional African communal values, Islamic influence, and Euro-Christian influence into a coherent framework capable of guiding a newly independent society. Nyerere developed \'ujamaa,\' a concept often translated as \'familyhood,\' which he used as the philosophical basis for a distinctively African form of socialism grounded in traditional communal cooperation rather than imported European class analysis. Both men treated philosophy not as a purely academic exercise but as a practical resource for nation-building.',
          'question': 'According to the passage, Julius Nyerere\'s concept \'ujamaa\' is often translated as:',
          'options': ['\'wisdom\'', '\'familyhood\'', '\'freedom\'', '\'unity of logic\''],
          'correct': 1,
        },
        {
          'passage': 'Political leaders in the era of African independence movements, including Kwame Nkrumah of Ghana and Julius Nyerere of Tanzania, developed philosophical positions that combined political theory with reflections on African identity and communal values. Nkrumah articulated \'consciencism,\' an attempt to synthesize traditional African communal values, Islamic influence, and Euro-Christian influence into a coherent framework capable of guiding a newly independent society. Nyerere developed \'ujamaa,\' a concept often translated as \'familyhood,\' which he used as the philosophical basis for a distinctively African form of socialism grounded in traditional communal cooperation rather than imported European class analysis. Both men treated philosophy not as a purely academic exercise but as a practical resource for nation-building.',
          'question': 'According to the passage, how did Nyerere ground ujamaa, as opposed to imported European class analysis?',
          'options': ['in European colonial administrative structures', 'in strict free-market capitalism', 'in purely religious doctrine', 'in traditional communal cooperation'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the central concern of the debate over whether \'African philosophy\' constitutes a distinct field?',
          'options': ['whether Africa has ever produced any written literature', 'whether African nations should adopt European legal systems', 'whether shared, often orally transmitted worldviews can count as philosophy alongside individually authored critical argument', 'whether philosophy requires the use of English specifically'],
          'correct': 2,
        },
        {
          'question': 'Sage philosophy, an approach associated with Kenyan philosopher Henry Odera Oruka, focuses on:',
          'options': ['documenting the reflective, critical thought of individual wise elders within traditional communities', 'studying exclusively written academic treatises', 'translating only European texts into African languages', 'rejecting all traditional African knowledge as unphilosophical'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the significance of oral tradition in many African philosophical discussions?',
          'options': ['it is universally dismissed by all African philosophers as unphilosophical', 'it is identical in every African society', 'it is treated by some scholars as a legitimate medium for transmitting philosophical reflection, not merely folklore', 'it has no connection to ethics or metaphysics'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Négritude, a movement associated with Léopold Sédar Senghor and Aimé Césaire?',
          'options': ['a purely economic theory of trade', 'a movement rejecting the value of African art', 'a school of formal symbolic logic', 'a cultural and philosophical movement affirming and celebrating Black cultural identity and values against colonial denigration'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a common critique of Négritude from later African philosophers?',
          'options': ['that it had no relationship to colonialism whatsoever', 'that it rejected all forms of poetry and art', 'that it risked essentializing a single, fixed \'African\' or \'Black\' identity across highly diverse cultures', 'that it focused too heavily on formal logic'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the relationship between African philosophy and colonialism as a historical backdrop?',
          'options': ['colonialism\'s imposition of European categories and denial of African rationality shaped many of the field\'s central debates', 'colonialism ended all forms of traditional African thought immediately', 'colonialism had no influence on African philosophical discussions', 'African philosophy developed entirely independently of any historical context'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the philosophical concept of \'communalism\' as often discussed in African philosophy?',
          'options': ['a rejection of the concept of morality altogether', 'a purely economic theory unrelated to ethics', 'the view that individuals should have no relationships with others', 'the view that the community, rather than the isolated individual, is the primary unit for understanding personhood and ethics'],
          'correct': 3,
        },
        {
          'question': 'Which of the following African philosophers is best known for the concept of \'sage philosophy\'?',
          'options': ['Henry Odera Oruka', 'Kwasi Wiredu', 'Paulin Hountondji', 'Mogobe Ramose'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes a criticism some scholars raise about applying purely Western philosophical categories to African thought without adaptation?',
          'options': ['it eliminates the need for any philosophical analysis', 'it risks distorting or overlooking concepts that do not map neatly onto Western distinctions', 'it has been universally accepted without any debate', 'it always produces a perfectly accurate translation'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the aim of much contemporary African philosophy regarding the discipline\'s global status?',
          'options': ['to focus exclusively on translating European texts', 'to remain entirely separate from any global philosophical conversation', 'to abandon the term \'philosophy\' altogether', 'to be recognized as engaging in rigorous philosophical work on equal footing with other global traditions, while addressing distinctly African questions'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'Africana philosophy\' as a broader field of study?',
          'options': ['a field concerned only with ancient Egyptian texts', 'a field identical to European continental philosophy', 'a field encompassing philosophical traditions and thought from Africa and the African diaspora, including African American philosophy', 'a field limited exclusively to the continent of Africa'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the significance of proverbs in some approaches to African philosophy?',
          'options': ['they are treated as purely decorative language with no content', 'they are considered irrelevant to any serious philosophical inquiry', 'they are treated by some scholars as compact repositories of ethical and metaphysical reflection worth philosophical analysis', 'they are unique to a single African country only'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best summarizes the core disagreement between Hountondji and ethnophilosophers?',
          'options': ['whether a shared communal worldview alone counts as philosophy, or whether individual critical argument is required', 'whether philosophy should be taught in universities', 'whether logic was invented in Africa or Europe', 'whether Africa has any culture at all'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the term \'decolonization\' as used broadly in African philosophy?',
          'options': ['a rejection of all forms of writing', 'a purely military process with no intellectual component', 'a term used only in economics, never in philosophy', 'the process of critically examining and, where appropriate, moving beyond colonial-era assumptions and categories in thought and institutions'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is a common theme across Ubuntu philosophy, communalism, and ujamaa?',
          'options': ['an emphasis on strict free-market individualism', 'a common origin in ancient Greek philosophy', 'the priority given to community, relationship, and cooperation over strict individualism', 'a shared rejection of the existence of ethics'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes a criticism sometimes raised against \'consciencism\' and similar independence-era syntheses?',
          'options': ['that they were entirely identical to European liberal democracy', 'that they had no relationship to any political movement', 'that they rejected the value of communal traditions', 'that combining diverse traditions into a single coherent framework for nation-building may oversimplify or paper over real tensions between them'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes why some scholars find value in comparing African philosophical concepts, like Ubuntu, with concepts from other traditions, such as Western virtue ethics or Confucian relational ethics?',
          'options': ['it demonstrates that only one tradition can be correct', 'such comparison can reveal both shared philosophical concerns and distinctive contributions of each tradition', 'it proves that all philosophical traditions are exactly identical', 'it shows that comparison across traditions is always meaningless'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the challenge of translating certain African philosophical concepts into English or other European languages?',
          'options': ['translation is always perfectly straightforward with no loss of meaning', 'some concepts may not have an exact equivalent, risking loss or distortion of meaning in translation', 'this challenge applies only to mathematical terms', 'African languages have no philosophical vocabulary'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'hermeneutical\' approaches within African philosophy?',
          'options': ['approaches identical to sage philosophy in every respect', 'approaches that reject the value of interpretation entirely', 'approaches focused on the careful interpretation of texts, oral traditions, and symbols to uncover their philosophical meaning', 'approaches limited strictly to mathematical logic'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why the question \'what counts as African philosophy?\' remains philosophically significant, rather than merely definitional?',
          'options': ['it has no connection to any broader philosophical question', 'it was fully and permanently settled in the 1960s', 'answering it requires taking a position on deeper questions about what philosophy itself fundamentally is and requires', 'it only concerns the geography of the African continent'],
          'correct': 2,
        },
      ];
    case 'gns106_u3_1': // Nature of Logic
      return [
        {
          'passage': 'Logic is the study of what makes an argument valid — that is, of the relationship between the premises of an argument and its conclusion, considered independently of whether the premises are actually true. An argument is valid if it is impossible for its premises to be true while its conclusion is false; the argument\'s actual truth or falsity is a separate matter, called soundness. For example, \'All fish can fly; a shark is a fish; therefore a shark can fly\' is a valid argument, because the conclusion does follow necessarily from the premises, even though the first premise is false, making the argument unsound. This distinction — between the form of an argument and the actual truth of its content — lies at the heart of what logic studies.',
          'question': 'According to the passage, logic studies the relationship between premises and conclusion:',
          'options': ['only in mathematical contexts', 'only when the conclusion is false', 'independently of whether the premises are actually true', 'only when the premises are known to be true'],
          'correct': 2,
        },
        {
          'passage': 'Logic is the study of what makes an argument valid — that is, of the relationship between the premises of an argument and its conclusion, considered independently of whether the premises are actually true. An argument is valid if it is impossible for its premises to be true while its conclusion is false; the argument\'s actual truth or falsity is a separate matter, called soundness. For example, \'All fish can fly; a shark is a fish; therefore a shark can fly\' is a valid argument, because the conclusion does follow necessarily from the premises, even though the first premise is false, making the argument unsound. This distinction — between the form of an argument and the actual truth of its content — lies at the heart of what logic studies.',
          'question': 'According to the passage, an argument is valid if:',
          'options': ['it uses at least three premises', 'its conclusion is popular or widely believed', 'it is impossible for its premises to be true while its conclusion is false', 'all of its premises happen to be true'],
          'correct': 2,
        },
        {
          'passage': 'Logic is the study of what makes an argument valid — that is, of the relationship between the premises of an argument and its conclusion, considered independently of whether the premises are actually true. An argument is valid if it is impossible for its premises to be true while its conclusion is false; the argument\'s actual truth or falsity is a separate matter, called soundness. For example, \'All fish can fly; a shark is a fish; therefore a shark can fly\' is a valid argument, because the conclusion does follow necessarily from the premises, even though the first premise is false, making the argument unsound. This distinction — between the form of an argument and the actual truth of its content — lies at the heart of what logic studies.',
          'question': 'According to the passage, is the shark example a valid argument?',
          'options': ['yes, but only because the conclusion happens to be true', 'yes, because the conclusion follows necessarily from the premises', 'no, because sharks cannot fly', 'no, because the first premise is false'],
          'correct': 1,
        },
        {
          'passage': 'Logic is the study of what makes an argument valid — that is, of the relationship between the premises of an argument and its conclusion, considered independently of whether the premises are actually true. An argument is valid if it is impossible for its premises to be true while its conclusion is false; the argument\'s actual truth or falsity is a separate matter, called soundness. For example, \'All fish can fly; a shark is a fish; therefore a shark can fly\' is a valid argument, because the conclusion does follow necessarily from the premises, even though the first premise is false, making the argument unsound. This distinction — between the form of an argument and the actual truth of its content — lies at the heart of what logic studies.',
          'question': 'According to the passage, why is the shark argument unsound despite being valid?',
          'options': ['because its first premise (\'all fish can fly\') is false', 'because sharks are not classified as fish', 'because its conclusion does not follow from its premises', 'because it contains too many premises Passage 2 Logic can be divided into deductive and inductive branches. Deductive logic evaluates arguments in which the conclusion is meant to follow with certainty from the premises, such that if the premises are true, the conclusion must be true. Inductive logic, by contrast, evaluates arguments in which the premises are meant to make the conclusion probable, but not certain — such as generalizing from a sample to a broader population. Because inductive conclusions are not guaranteed even when the premises are true, the standard of evaluation differs: rather than asking whether an inductive argument is \'valid\' in the strict deductive sense, we typically ask whether it is \'strong\' — that is, whether the premises make the conclusion sufficiently likely.'],
          'correct': 0,
        },
        {
          'passage': 'Logic can be divided into deductive and inductive branches. Deductive logic evaluates arguments in which the conclusion is meant to follow with certainty from the premises, such that if the premises are true, the conclusion must be true. Inductive logic, by contrast, evaluates arguments in which the premises are meant to make the conclusion probable, but not certain — such as generalizing from a sample to a broader population. Because inductive conclusions are not guaranteed even when the premises are true, the standard of evaluation differs: rather than asking whether an inductive argument is \'valid\' in the strict deductive sense, we typically ask whether it is \'strong\' — that is, whether the premises make the conclusion sufficiently likely.',
          'question': 'According to the passage, in deductive logic, if the premises are true, the conclusion:',
          'options': ['must be true', 'is guaranteed to be false', 'is merely likely to be true', 'has no relationship to the premises'],
          'correct': 0,
        },
        {
          'passage': 'Logic can be divided into deductive and inductive branches. Deductive logic evaluates arguments in which the conclusion is meant to follow with certainty from the premises, such that if the premises are true, the conclusion must be true. Inductive logic, by contrast, evaluates arguments in which the premises are meant to make the conclusion probable, but not certain — such as generalizing from a sample to a broader population. Because inductive conclusions are not guaranteed even when the premises are true, the standard of evaluation differs: rather than asking whether an inductive argument is \'valid\' in the strict deductive sense, we typically ask whether it is \'strong\' — that is, whether the premises make the conclusion sufficiently likely.',
          'question': 'According to the passage, inductive logic evaluates arguments where the premises are meant to make the conclusion:',
          'options': ['probable, but not certain', 'completely irrelevant', 'always false', 'certain and guaranteed'],
          'correct': 0,
        },
        {
          'passage': 'Logic can be divided into deductive and inductive branches. Deductive logic evaluates arguments in which the conclusion is meant to follow with certainty from the premises, such that if the premises are true, the conclusion must be true. Inductive logic, by contrast, evaluates arguments in which the premises are meant to make the conclusion probable, but not certain — such as generalizing from a sample to a broader population. Because inductive conclusions are not guaranteed even when the premises are true, the standard of evaluation differs: rather than asking whether an inductive argument is \'valid\' in the strict deductive sense, we typically ask whether it is \'strong\' — that is, whether the premises make the conclusion sufficiently likely.',
          'question': 'According to the passage, what is the passage\'s example of an inductive argument?',
          'options': ['stating a tautology', 'defining a term precisely', 'generalizing from a sample to a broader population', 'deriving a mathematical theorem from axioms'],
          'correct': 2,
        },
        {
          'passage': 'Logic can be divided into deductive and inductive branches. Deductive logic evaluates arguments in which the conclusion is meant to follow with certainty from the premises, such that if the premises are true, the conclusion must be true. Inductive logic, by contrast, evaluates arguments in which the premises are meant to make the conclusion probable, but not certain — such as generalizing from a sample to a broader population. Because inductive conclusions are not guaranteed even when the premises are true, the standard of evaluation differs: rather than asking whether an inductive argument is \'valid\' in the strict deductive sense, we typically ask whether it is \'strong\' — that is, whether the premises make the conclusion sufficiently likely.',
          'question': 'According to the passage, what term do we typically use to evaluate inductive arguments, instead of \'valid\'?',
          'options': ['\'strong\'', '\'certain\'', '\'sound\'', '\'proven\' Passage 3 A key concept in logic is the difference between a statement\'s form and its content. Logicians often use variables, such as P and Q, to represent the underlying structure of an argument independent of any specific subject matter. For instance, the pattern \'If P, then Q; P is true; therefore Q is true\' — known as modus ponens — is valid no matter what particular statements are substituted for P and Q, whether they concern mathematics, weather, or ethics. This is precisely why logic is often described as a \'topic-neutral\' discipline: its central concern is with patterns of reasoning that remain valid across every possible subject matter, rather than with the truth of any particular claim in any particular field.'],
          'correct': 0,
        },
        {
          'passage': 'A key concept in logic is the difference between a statement\'s form and its content. Logicians often use variables, such as P and Q, to represent the underlying structure of an argument independent of any specific subject matter. For instance, the pattern \'If P, then Q; P is true; therefore Q is true\' — known as modus ponens — is valid no matter what particular statements are substituted for P and Q, whether they concern mathematics, weather, or ethics. This is precisely why logic is often described as a \'topic-neutral\' discipline: its central concern is with patterns of reasoning that remain valid across every possible subject matter, rather than with the truth of any particular claim in any particular field.',
          'question': 'According to the passage, logicians use variables such as P and Q to represent:',
          'options': ['the underlying structure of an argument independent of specific subject matter', 'specific numerical quantities only', 'the names of famous philosophers', 'emotional reactions to an argument'],
          'correct': 0,
        },
        {
          'passage': 'A key concept in logic is the difference between a statement\'s form and its content. Logicians often use variables, such as P and Q, to represent the underlying structure of an argument independent of any specific subject matter. For instance, the pattern \'If P, then Q; P is true; therefore Q is true\' — known as modus ponens — is valid no matter what particular statements are substituted for P and Q, whether they concern mathematics, weather, or ethics. This is precisely why logic is often described as a \'topic-neutral\' discipline: its central concern is with patterns of reasoning that remain valid across every possible subject matter, rather than with the truth of any particular claim in any particular field.',
          'question': 'According to the passage, the pattern \'If P, then Q; P is true; therefore Q is true\' is known as:',
          'options': ['the Socratic method', 'modus ponens', 'the hedonic calculus', 'reductio ad absurdum'],
          'correct': 1,
        },
        {
          'passage': 'A key concept in logic is the difference between a statement\'s form and its content. Logicians often use variables, such as P and Q, to represent the underlying structure of an argument independent of any specific subject matter. For instance, the pattern \'If P, then Q; P is true; therefore Q is true\' — known as modus ponens — is valid no matter what particular statements are substituted for P and Q, whether they concern mathematics, weather, or ethics. This is precisely why logic is often described as a \'topic-neutral\' discipline: its central concern is with patterns of reasoning that remain valid across every possible subject matter, rather than with the truth of any particular claim in any particular field.',
          'question': 'According to the passage, why is modus ponens valid regardless of the specific statements substituted for P and Q?',
          'options': ['because it only works for ethical claims', 'because P and Q must always refer to mathematics', 'because it has been proven true by scientific experiment', 'because its validity depends only on its form, not its subject matter'],
          'correct': 3,
        },
        {
          'passage': 'A key concept in logic is the difference between a statement\'s form and its content. Logicians often use variables, such as P and Q, to represent the underlying structure of an argument independent of any specific subject matter. For instance, the pattern \'If P, then Q; P is true; therefore Q is true\' — known as modus ponens — is valid no matter what particular statements are substituted for P and Q, whether they concern mathematics, weather, or ethics. This is precisely why logic is often described as a \'topic-neutral\' discipline: its central concern is with patterns of reasoning that remain valid across every possible subject matter, rather than with the truth of any particular claim in any particular field.',
          'question': 'According to the passage, why is logic often described as a \'topic-neutral\' discipline?',
          'options': ['because it is only used by mathematicians', 'because it concerns patterns of reasoning valid across every possible subject matter', 'because it has no connection to any other field', 'because it refuses to discuss any specific subject Passage 4 The \'laws of thought,\' a traditional trio of foundational logical principles, are often listed as the law of identity, the law of non-contradiction, and the law of excluded middle. The law of identity states that everything is identical to itself (A is A). The law of non-contradiction states that a statement and its direct negation cannot both be true at the same time and in the same sense (it cannot be both raining and not raining, in the same place, at the same moment, in the same sense). The law of excluded middle states that for any statement, either that statement or its negation must be true — there is no third option. While these principles are foundational to classical logic, some non-classical logics have been developed that modify or reject one or more of them for specialized purposes.'],
          'correct': 1,
        },
        {
          'passage': 'The \'laws of thought,\' a traditional trio of foundational logical principles, are often listed as the law of identity, the law of non-contradiction, and the law of excluded middle. The law of identity states that everything is identical to itself (A is A). The law of non-contradiction states that a statement and its direct negation cannot both be true at the same time and in the same sense (it cannot be both raining and not raining, in the same place, at the same moment, in the same sense). The law of excluded middle states that for any statement, either that statement or its negation must be true — there is no third option. While these principles are foundational to classical logic, some non-classical logics have been developed that modify or reject one or more of them for specialized purposes.',
          'question': 'According to the passage, the law of identity states that:',
          'options': ['logic applies only to mathematics', 'a statement and its negation cannot both be true', 'every statement must be either true or false', 'everything is identical to itself (A is A)'],
          'correct': 3,
        },
        {
          'passage': 'The \'laws of thought,\' a traditional trio of foundational logical principles, are often listed as the law of identity, the law of non-contradiction, and the law of excluded middle. The law of identity states that everything is identical to itself (A is A). The law of non-contradiction states that a statement and its direct negation cannot both be true at the same time and in the same sense (it cannot be both raining and not raining, in the same place, at the same moment, in the same sense). The law of excluded middle states that for any statement, either that statement or its negation must be true — there is no third option. While these principles are foundational to classical logic, some non-classical logics have been developed that modify or reject one or more of them for specialized purposes.',
          'question': 'According to the passage, the law of non-contradiction states that:',
          'options': ['a statement and its direct negation cannot both be true at the same time and in the same sense', 'all statements are equally valid', 'everything must be identical to itself', 'there is no third option between true and false'],
          'correct': 0,
        },
        {
          'passage': 'The \'laws of thought,\' a traditional trio of foundational logical principles, are often listed as the law of identity, the law of non-contradiction, and the law of excluded middle. The law of identity states that everything is identical to itself (A is A). The law of non-contradiction states that a statement and its direct negation cannot both be true at the same time and in the same sense (it cannot be both raining and not raining, in the same place, at the same moment, in the same sense). The law of excluded middle states that for any statement, either that statement or its negation must be true — there is no third option. While these principles are foundational to classical logic, some non-classical logics have been developed that modify or reject one or more of them for specialized purposes.',
          'question': 'According to the passage, the law of excluded middle states that:',
          'options': ['a statement and its negation can both be true', 'statements about the future cannot be evaluated', 'for any statement, either it or its negation must be true, with no third option', 'everything is identical to itself'],
          'correct': 2,
        },
        {
          'passage': 'The \'laws of thought,\' a traditional trio of foundational logical principles, are often listed as the law of identity, the law of non-contradiction, and the law of excluded middle. The law of identity states that everything is identical to itself (A is A). The law of non-contradiction states that a statement and its direct negation cannot both be true at the same time and in the same sense (it cannot be both raining and not raining, in the same place, at the same moment, in the same sense). The law of excluded middle states that for any statement, either that statement or its negation must be true — there is no third option. While these principles are foundational to classical logic, some non-classical logics have been developed that modify or reject one or more of them for specialized purposes.',
          'question': 'According to the passage, are the laws of thought accepted without exception by every system of logic?',
          'options': ['yes, every logical system without exception accepts all three', 'no, classical logic rejects all three of them', 'the passage does not address this question', 'no, some non-classical logics modify or reject one or more of them Passage 5 Logic is sometimes distinguished from psychology by noting that logic is a normative discipline, concerned with how people ought to reason if they want to reason correctly, rather than a purely descriptive one concerned with how people actually do reason. Psychological research has documented many systematic patterns in human reasoning that diverge from the prescriptions of formal logic — for example, most people find certain logically equivalent statements easier or harder to evaluate depending on how they are phrased, even though logic treats them as equivalent. This gap between how people actually reason and how formal logic says they should reason is itself an important subject of study, but it does not by itself show that logic\'s normative standards are mistaken, any more than common arithmetic errors show that the rules of arithmetic are wrong.'],
          'correct': 3,
        },
        {
          'passage': 'Logic is sometimes distinguished from psychology by noting that logic is a normative discipline, concerned with how people ought to reason if they want to reason correctly, rather than a purely descriptive one concerned with how people actually do reason. Psychological research has documented many systematic patterns in human reasoning that diverge from the prescriptions of formal logic — for example, most people find certain logically equivalent statements easier or harder to evaluate depending on how they are phrased, even though logic treats them as equivalent. This gap between how people actually reason and how formal logic says they should reason is itself an important subject of study, but it does not by itself show that logic\'s normative standards are mistaken, any more than common arithmetic errors show that the rules of arithmetic are wrong.',
          'question': 'According to the passage, logic is best described as a discipline that is primarily:',
          'options': ['descriptive, concerned only with how people actually reason', 'irrelevant to human reasoning entirely', 'normative, concerned with how people ought to reason', 'identical to psychology in its methods'],
          'correct': 2,
        },
        {
          'passage': 'Logic is sometimes distinguished from psychology by noting that logic is a normative discipline, concerned with how people ought to reason if they want to reason correctly, rather than a purely descriptive one concerned with how people actually do reason. Psychological research has documented many systematic patterns in human reasoning that diverge from the prescriptions of formal logic — for example, most people find certain logically equivalent statements easier or harder to evaluate depending on how they are phrased, even though logic treats them as equivalent. This gap between how people actually reason and how formal logic says they should reason is itself an important subject of study, but it does not by itself show that logic\'s normative standards are mistaken, any more than common arithmetic errors show that the rules of arithmetic are wrong.',
          'question': 'According to the passage, what has psychological research documented about human reasoning?',
          'options': ['that humans never make logical errors', 'perfect alignment between human reasoning and formal logic at all times', 'systematic patterns that diverge from the prescriptions of formal logic', 'that logic has no relevance to psychology'],
          'correct': 2,
        },
        {
          'passage': 'Logic is sometimes distinguished from psychology by noting that logic is a normative discipline, concerned with how people ought to reason if they want to reason correctly, rather than a purely descriptive one concerned with how people actually do reason. Psychological research has documented many systematic patterns in human reasoning that diverge from the prescriptions of formal logic — for example, most people find certain logically equivalent statements easier or harder to evaluate depending on how they are phrased, even though logic treats them as equivalent. This gap between how people actually reason and how formal logic says they should reason is itself an important subject of study, but it does not by itself show that logic\'s normative standards are mistaken, any more than common arithmetic errors show that the rules of arithmetic are wrong.',
          'question': 'According to the passage, does the gap between actual and ideal reasoning show that logic\'s standards are mistaken?',
          'options': ['yes, it definitively proves logic\'s standards are wrong', 'yes, but only for inductive logic', 'the passage does not address this question', 'no, the passage says it does not by itself show this'],
          'correct': 3,
        },
        {
          'passage': 'Logic is sometimes distinguished from psychology by noting that logic is a normative discipline, concerned with how people ought to reason if they want to reason correctly, rather than a purely descriptive one concerned with how people actually do reason. Psychological research has documented many systematic patterns in human reasoning that diverge from the prescriptions of formal logic — for example, most people find certain logically equivalent statements easier or harder to evaluate depending on how they are phrased, even though logic treats them as equivalent. This gap between how people actually reason and how formal logic says they should reason is itself an important subject of study, but it does not by itself show that logic\'s normative standards are mistaken, any more than common arithmetic errors show that the rules of arithmetic are wrong.',
          'question': 'According to the passage, what analogy is used to make this point about logical errors?',
          'options': ['common driving errors show that traffic laws are unnecessary', 'common typing errors show that grammar rules are wrong', 'common cooking errors show that recipes are inherently flawed', 'common arithmetic errors do not show that the rules of arithmetic are wrong'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best defines a \'proposition\' in logic?',
          'options': ['a command or instruction', 'an emotional exclamation', 'a question that cannot be answered', 'a statement that is capable of being either true or false'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a \'tautology\' in logic?',
          'options': ['a statement that is always false', 'a statement that is true under every possible interpretation of its components', 'a statement that contradicts itself', 'a statement whose truth value cannot be determined'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes a \'contradiction\' in logic?',
          'options': ['a statement that is always true', 'a statement with an uncertain truth value', 'a statement about ethics only', 'a statement that is false under every possible interpretation of its components'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'inference\' in logic?',
          'options': ['the process of memorizing definitions', 'a synonym for \'opinion\'', 'the act of making an emotional judgment', 'the process of deriving a conclusion from one or more premises'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a \'formal fallacy\'?',
          'options': ['an argument that happens to have a true conclusion', 'an argument that is invalid due to an error in its logical structure or form', 'an argument with a false premise but valid structure', 'a persuasive but emotionally manipulative speech'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes an \'informal fallacy\'?',
          'options': ['a synonym for a sound argument', 'an error in reasoning arising from the content or context of an argument, rather than its logical form alone', 'a fallacy that is always also formally invalid', 'an error that only occurs in symbolic logic'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'modus tollens,\' a valid deductive argument form?',
          'options': ['\'P or Q; not P; therefore not Q\'', '\'If P, then Q; Q; therefore P\'', '\'If P, then Q; not Q; therefore not P\'', '\'If P, then Q; P; therefore Q\''],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'affirming the consequent,\' a common logical fallacy?',
          'options': ['\'If P, then Q; not Q; therefore not P\' — a valid inference', '\'P or Q; not P; therefore Q\' — a valid inference', '\'If P, then Q; Q; therefore P\' — invalidly inferring P from the truth of Q', '\'If P, then Q; P; therefore Q\' — a valid inference'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'denying the antecedent,\' a common logical fallacy?',
          'options': ['\'If P, then Q; not Q; therefore not P\' — a valid inference', '\'If P, then Q; not P; therefore not Q\' — invalidly inferring not-Q from not-P', '\'P or Q; not P; therefore Q\' — a valid inference', '\'If P, then Q; P; therefore Q\' — a valid inference'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the relationship between logic and mathematics?',
          'options': ['mathematics has replaced the need for logic entirely', 'logic applies only outside of mathematics', 'logic and mathematics are entirely unrelated fields', 'logic provides foundational tools for rigorous mathematical proof and reasoning'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a \'disjunction\' in logic?',
          'options': ['a statement of the form \'P and Q\'', 'a statement that negates P', 'a statement of the form \'if P then Q\'', 'a statement of the form \'P or Q\''],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a \'conjunction\' in logic?',
          'options': ['a statement of the form \'P and Q\'', 'a statement of the form \'if P then Q\'', 'a statement of the form \'P or Q\'', 'a statement that is always false'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the \'negation\' of a statement P?',
          'options': ['a statement that is true exactly when P is false, and false exactly when P is true', 'a statement unrelated to P', 'a statement that is always true regardless of P', 'a statement identical in meaning to P'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes a \'conditional\' statement in logic?',
          'options': ['a statement expressing a command', 'a statement of the form \'if P, then Q\'', 'a statement that is always true', 'a statement of the form \'P and Q\''],
          'correct': 1,
        },
        {
          'question': 'In a conditional statement \'if P, then Q,\' P is called the:',
          'options': ['antecedent', 'consequent', 'negation', 'conjunction'],
          'correct': 0,
        },
        {
          'question': 'In a conditional statement \'if P, then Q,\' Q is called the:',
          'options': ['consequent', 'tautology', 'disjunct', 'antecedent'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'non-classical logics,\' such as fuzzy logic or paraconsistent logic?',
          'options': ['systems used exclusively in ancient philosophy', 'systems that reject the use of any symbols', 'logical systems that modify or reject one or more traditional principles, such as bivalence or non-contradiction, for specialized purposes', 'systems identical to classical logic in every respect'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'bivalence\' as a principle in classical logic?',
          'options': ['the principle that no proposition can ever be evaluated', 'the principle that some propositions have three truth values', 'the principle that every proposition has exactly one of two truth values: true or false', 'a synonym for the law of identity'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why logic is often considered foundational to critical thinking?',
          'options': ['it provides explicit standards for distinguishing good reasoning from bad reasoning', 'it guarantees that any conclusion reached will be popular', 'it eliminates the need to consider evidence', 'it replaces the need for any factual knowledge'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the difference between \'validity\' and \'truth\' in logic?',
          'options': ['truth applies only to mathematical statements', 'validity concerns the logical relationship between premises and conclusion, while truth concerns whether a statement matches reality', 'they are exactly the same concept', 'validity applies only to false statements'],
          'correct': 1,
        },
      ];
    case 'gns106_u3_2': // Symbolic Logic
      return [
        {
          'passage': 'Symbolic logic represents statements and arguments using formal symbols rather than natural language, allowing reasoning to be evaluated with mathematical precision. In propositional logic, simple statements are represented by letters such as P and Q, and combined using logical connectives: \'∧\' for \'and\' (conjunction), \'∨\' for \'or\' (disjunction), \'¬\' for \'not\' (negation), \'→\' for \'if...then\' (the conditional), and \'↔\' for \'if and only if\' (the biconditional). For example, the English sentence \'It is raining and it is cold\' could be symbolized as P ∧ Q, where P stands for \'it is raining\' and Q stands for \'it is cold.\' This translation process strips away grammatical detail irrelevant to logical structure, leaving only what matters for evaluating validity.',
          'question': 'According to the passage, which symbol represents \'and\' (conjunction) in propositional logic?',
          'options': ['∨', '¬', '→', '∧'],
          'correct': 3,
        },
        {
          'passage': 'Symbolic logic represents statements and arguments using formal symbols rather than natural language, allowing reasoning to be evaluated with mathematical precision. In propositional logic, simple statements are represented by letters such as P and Q, and combined using logical connectives: \'∧\' for \'and\' (conjunction), \'∨\' for \'or\' (disjunction), \'¬\' for \'not\' (negation), \'→\' for \'if...then\' (the conditional), and \'↔\' for \'if and only if\' (the biconditional). For example, the English sentence \'It is raining and it is cold\' could be symbolized as P ∧ Q, where P stands for \'it is raining\' and Q stands for \'it is cold.\' This translation process strips away grammatical detail irrelevant to logical structure, leaving only what matters for evaluating validity.',
          'question': 'According to the passage, which symbol represents \'or\' (disjunction) in propositional logic?',
          'options': ['¬', '↔', '∨', '∧'],
          'correct': 2,
        },
        {
          'passage': 'Symbolic logic represents statements and arguments using formal symbols rather than natural language, allowing reasoning to be evaluated with mathematical precision. In propositional logic, simple statements are represented by letters such as P and Q, and combined using logical connectives: \'∧\' for \'and\' (conjunction), \'∨\' for \'or\' (disjunction), \'¬\' for \'not\' (negation), \'→\' for \'if...then\' (the conditional), and \'↔\' for \'if and only if\' (the biconditional). For example, the English sentence \'It is raining and it is cold\' could be symbolized as P ∧ Q, where P stands for \'it is raining\' and Q stands for \'it is cold.\' This translation process strips away grammatical detail irrelevant to logical structure, leaving only what matters for evaluating validity.',
          'question': 'According to the passage, which symbol represents \'not\' (negation) in propositional logic?',
          'options': ['¬', '∧', '↔', '→'],
          'correct': 0,
        },
        {
          'passage': 'Symbolic logic represents statements and arguments using formal symbols rather than natural language, allowing reasoning to be evaluated with mathematical precision. In propositional logic, simple statements are represented by letters such as P and Q, and combined using logical connectives: \'∧\' for \'and\' (conjunction), \'∨\' for \'or\' (disjunction), \'¬\' for \'not\' (negation), \'→\' for \'if...then\' (the conditional), and \'↔\' for \'if and only if\' (the biconditional). For example, the English sentence \'It is raining and it is cold\' could be symbolized as P ∧ Q, where P stands for \'it is raining\' and Q stands for \'it is cold.\' This translation process strips away grammatical detail irrelevant to logical structure, leaving only what matters for evaluating validity.',
          'question': 'According to the passage, how would \'It is raining and it is cold\' be symbolized, using P for \'it is raining\' and Q for \'it is cold\'?',
          'options': ['P ∧ Q', 'P → Q', 'P ∨ Q', '¬P Passage 2 A truth table is a systematic method for determining the truth value of a compound statement under every possible combination of truth values for its component statements. For a conjunction P ∧ Q, the table shows that the compound statement is true only when both P and Q are true, and false in every other case. For a disjunction P ∨ Q (using the standard \'inclusive or\'), the compound statement is true whenever at least one of P or Q is true, and false only when both are false. For a conditional P → Q, the statement is considered false only in the single case where P is true and Q is false; in every other combination, including when P is false, the conditional is treated as true — a result that can seem counterintuitive at first but follows from the standard logical definition.'],
          'correct': 0,
        },
        {
          'passage': 'A truth table is a systematic method for determining the truth value of a compound statement under every possible combination of truth values for its component statements. For a conjunction P ∧ Q, the table shows that the compound statement is true only when both P and Q are true, and false in every other case. For a disjunction P ∨ Q (using the standard \'inclusive or\'), the compound statement is true whenever at least one of P or Q is true, and false only when both are false. For a conditional P → Q, the statement is considered false only in the single case where P is true and Q is false; in every other combination, including when P is false, the conditional is treated as true — a result that can seem counterintuitive at first but follows from the standard logical definition.',
          'question': 'According to the passage, a truth table shows the truth value of a compound statement:',
          'options': ['only for statements about mathematics', 'under every possible combination of truth values for its component statements', 'only when all components happen to be true', 'only in real-world observed cases'],
          'correct': 1,
        },
        {
          'passage': 'A truth table is a systematic method for determining the truth value of a compound statement under every possible combination of truth values for its component statements. For a conjunction P ∧ Q, the table shows that the compound statement is true only when both P and Q are true, and false in every other case. For a disjunction P ∨ Q (using the standard \'inclusive or\'), the compound statement is true whenever at least one of P or Q is true, and false only when both are false. For a conditional P → Q, the statement is considered false only in the single case where P is true and Q is false; in every other combination, including when P is false, the conditional is treated as true — a result that can seem counterintuitive at first but follows from the standard logical definition.',
          'question': 'According to the passage, when is a conjunction P ∧ Q true?',
          'options': ['in every possible case', 'whenever at least one of P or Q is true', 'only when both P and Q are true', 'whenever P is false'],
          'correct': 2,
        },
        {
          'passage': 'A truth table is a systematic method for determining the truth value of a compound statement under every possible combination of truth values for its component statements. For a conjunction P ∧ Q, the table shows that the compound statement is true only when both P and Q are true, and false in every other case. For a disjunction P ∨ Q (using the standard \'inclusive or\'), the compound statement is true whenever at least one of P or Q is true, and false only when both are false. For a conditional P → Q, the statement is considered false only in the single case where P is true and Q is false; in every other combination, including when P is false, the conditional is treated as true — a result that can seem counterintuitive at first but follows from the standard logical definition.',
          'question': 'According to the passage, when is a disjunction P ∨ Q false?',
          'options': ['whenever at least one of P or Q is true', 'whenever P is true', 'in every possible case', 'only when both P and Q are false'],
          'correct': 3,
        },
        {
          'passage': 'A truth table is a systematic method for determining the truth value of a compound statement under every possible combination of truth values for its component statements. For a conjunction P ∧ Q, the table shows that the compound statement is true only when both P and Q are true, and false in every other case. For a disjunction P ∨ Q (using the standard \'inclusive or\'), the compound statement is true whenever at least one of P or Q is true, and false only when both are false. For a conditional P → Q, the statement is considered false only in the single case where P is true and Q is false; in every other combination, including when P is false, the conditional is treated as true — a result that can seem counterintuitive at first but follows from the standard logical definition.',
          'question': 'According to the passage, in what single case is a conditional P → Q considered false?',
          'options': ['when P is true and Q is false', 'when both P and Q are false', 'when both P and Q are true', 'when P is false and Q is true Passage 3 Propositional logic treats whole statements as basic units, but it cannot represent the internal structure of statements involving quantities, such as \'all,\' \'some,\' or \'no.\' Predicate logic (also called first-order logic) extends propositional logic by introducing predicates, variables, and quantifiers to capture this internal structure. The universal quantifier, symbolized \'∀,\' means \'for all,\' while the existential quantifier, symbolized \'∃,\' means \'there exists at least one.\' For example, the claim \'all humans are mortal\' can be symbolized as ∀x (Hx → Mx), read as \'for all x, if x is human, then x is mortal,\' while \'some humans are philosophers\' can be symbolized as ∃x (Hx ∧ Px), read as \'there exists at least one x such that x is human and x is a philosopher.\''],
          'correct': 0,
        },
        {
          'passage': 'Propositional logic treats whole statements as basic units, but it cannot represent the internal structure of statements involving quantities, such as \'all,\' \'some,\' or \'no.\' Predicate logic (also called first-order logic) extends propositional logic by introducing predicates, variables, and quantifiers to capture this internal structure. The universal quantifier, symbolized \'∀,\' means \'for all,\' while the existential quantifier, symbolized \'∃,\' means \'there exists at least one.\' For example, the claim \'all humans are mortal\' can be symbolized as ∀x (Hx → Mx), read as \'for all x, if x is human, then x is mortal,\' while \'some humans are philosophers\' can be symbolized as ∃x (Hx ∧ Px), read as \'there exists at least one x such that x is human and x is a philosopher.\'',
          'question': 'According to the passage, what does propositional logic fail to represent, which predicate logic addresses?',
          'options': ['basic arithmetic operations', 'the internal structure of statements involving quantities, such as \'all,\' \'some,\' or \'no\'', 'the meaning of the word \'and\'', 'the difference between true and false'],
          'correct': 1,
        },
        {
          'passage': 'Propositional logic treats whole statements as basic units, but it cannot represent the internal structure of statements involving quantities, such as \'all,\' \'some,\' or \'no.\' Predicate logic (also called first-order logic) extends propositional logic by introducing predicates, variables, and quantifiers to capture this internal structure. The universal quantifier, symbolized \'∀,\' means \'for all,\' while the existential quantifier, symbolized \'∃,\' means \'there exists at least one.\' For example, the claim \'all humans are mortal\' can be symbolized as ∀x (Hx → Mx), read as \'for all x, if x is human, then x is mortal,\' while \'some humans are philosophers\' can be symbolized as ∃x (Hx ∧ Px), read as \'there exists at least one x such that x is human and x is a philosopher.\'',
          'question': 'According to the passage, what does the universal quantifier \'∀\' mean?',
          'options': ['\'for all\'', '\'if and only if\'', '\'there exists at least one\'', '\'not\''],
          'correct': 0,
        },
        {
          'passage': 'Propositional logic treats whole statements as basic units, but it cannot represent the internal structure of statements involving quantities, such as \'all,\' \'some,\' or \'no.\' Predicate logic (also called first-order logic) extends propositional logic by introducing predicates, variables, and quantifiers to capture this internal structure. The universal quantifier, symbolized \'∀,\' means \'for all,\' while the existential quantifier, symbolized \'∃,\' means \'there exists at least one.\' For example, the claim \'all humans are mortal\' can be symbolized as ∀x (Hx → Mx), read as \'for all x, if x is human, then x is mortal,\' while \'some humans are philosophers\' can be symbolized as ∃x (Hx ∧ Px), read as \'there exists at least one x such that x is human and x is a philosopher.\'',
          'question': 'According to the passage, what does the existential quantifier \'∃\' mean?',
          'options': ['\'there exists at least one\'', '\'for all\'', '\'and\'', '\'or\''],
          'correct': 0,
        },
        {
          'passage': 'Propositional logic treats whole statements as basic units, but it cannot represent the internal structure of statements involving quantities, such as \'all,\' \'some,\' or \'no.\' Predicate logic (also called first-order logic) extends propositional logic by introducing predicates, variables, and quantifiers to capture this internal structure. The universal quantifier, symbolized \'∀,\' means \'for all,\' while the existential quantifier, symbolized \'∃,\' means \'there exists at least one.\' For example, the claim \'all humans are mortal\' can be symbolized as ∀x (Hx → Mx), read as \'for all x, if x is human, then x is mortal,\' while \'some humans are philosophers\' can be symbolized as ∃x (Hx ∧ Px), read as \'there exists at least one x such that x is human and x is a philosopher.\'',
          'question': 'According to the passage, how is \'all humans are mortal\' symbolized?',
          'options': ['∀x (Hx ∧ Mx)', '∃x (Hx → Mx)', '∃x (Hx ∧ Mx)', '∀x (Hx → Mx) Passage 4 Two statements are said to be logically equivalent if they have the same truth value in every possible case — that is, their truth tables are identical. A well-known pair of logically equivalent statements is captured by De Morgan\'s Laws: ¬(P ∧ Q) is logically equivalent to (¬P ∨ ¬Q), and ¬(P ∨ Q) is logically equivalent to (¬P ∧ ¬Q). Informally, the negation of \'P and Q\' is the same as \'not P or not Q,\' and the negation of \'P or Q\' is the same as \'not P and not Q.\' These laws are especially useful for simplifying complex expressions and for correctly negating statements that involve \'and\' or \'or,\' a step where informal reasoning frequently goes wrong.'],
          'correct': 3,
        },
        {
          'passage': 'Two statements are said to be logically equivalent if they have the same truth value in every possible case — that is, their truth tables are identical. A well-known pair of logically equivalent statements is captured by De Morgan\'s Laws: ¬(P ∧ Q) is logically equivalent to (¬P ∨ ¬Q), and ¬(P ∨ Q) is logically equivalent to (¬P ∧ ¬Q). Informally, the negation of \'P and Q\' is the same as \'not P or not Q,\' and the negation of \'P or Q\' is the same as \'not P and not Q.\' These laws are especially useful for simplifying complex expressions and for correctly negating statements that involve \'and\' or \'or,\' a step where informal reasoning frequently goes wrong.',
          'question': 'According to the passage, two statements are logically equivalent if:',
          'options': ['they use exactly the same words', 'they have the same truth value in every possible case', 'one of them is always false', 'they are both true in the real world'],
          'correct': 1,
        },
        {
          'passage': 'Two statements are said to be logically equivalent if they have the same truth value in every possible case — that is, their truth tables are identical. A well-known pair of logically equivalent statements is captured by De Morgan\'s Laws: ¬(P ∧ Q) is logically equivalent to (¬P ∨ ¬Q), and ¬(P ∨ Q) is logically equivalent to (¬P ∧ ¬Q). Informally, the negation of \'P and Q\' is the same as \'not P or not Q,\' and the negation of \'P or Q\' is the same as \'not P and not Q.\' These laws are especially useful for simplifying complex expressions and for correctly negating statements that involve \'and\' or \'or,\' a step where informal reasoning frequently goes wrong.',
          'question': 'According to De Morgan\'s Laws as stated in the passage, ¬(P ∧ Q) is logically equivalent to:',
          'options': ['(¬P ∧ ¬Q)', '(P ∧ Q)', '(¬P ∨ ¬Q)', '(P ∨ Q)'],
          'correct': 2,
        },
        {
          'passage': 'Two statements are said to be logically equivalent if they have the same truth value in every possible case — that is, their truth tables are identical. A well-known pair of logically equivalent statements is captured by De Morgan\'s Laws: ¬(P ∧ Q) is logically equivalent to (¬P ∨ ¬Q), and ¬(P ∨ Q) is logically equivalent to (¬P ∧ ¬Q). Informally, the negation of \'P and Q\' is the same as \'not P or not Q,\' and the negation of \'P or Q\' is the same as \'not P and not Q.\' These laws are especially useful for simplifying complex expressions and for correctly negating statements that involve \'and\' or \'or,\' a step where informal reasoning frequently goes wrong.',
          'question': 'According to De Morgan\'s Laws as stated in the passage, ¬(P ∨ Q) is logically equivalent to:',
          'options': ['(¬P ∧ ¬Q)', '(¬P ∨ ¬Q)', '(P ∧ Q)', '(P ∨ Q)'],
          'correct': 0,
        },
        {
          'passage': 'Two statements are said to be logically equivalent if they have the same truth value in every possible case — that is, their truth tables are identical. A well-known pair of logically equivalent statements is captured by De Morgan\'s Laws: ¬(P ∧ Q) is logically equivalent to (¬P ∨ ¬Q), and ¬(P ∨ Q) is logically equivalent to (¬P ∧ ¬Q). Informally, the negation of \'P and Q\' is the same as \'not P or not Q,\' and the negation of \'P or Q\' is the same as \'not P and not Q.\' These laws are especially useful for simplifying complex expressions and for correctly negating statements that involve \'and\' or \'or,\' a step where informal reasoning frequently goes wrong.',
          'question': 'According to the passage, De Morgan\'s Laws are especially useful for:',
          'options': ['eliminating the need for quantifiers', 'proving that all statements are equivalent to each other', 'translating logic into natural language poetry', 'simplifying complex expressions and correctly negating statements involving \'and\' or \'or\' Passage 5 A formal proof in symbolic logic is a sequence of statements, each of which is either a premise or follows from earlier statements by an accepted rule of inference, ending in the desired conclusion. Common rules of inference include modus ponens (from P → Q and P, infer Q), modus tollens (from P → Q and ¬Q, infer ¬P), and disjunctive syllogism (from P ∨ Q and ¬P, infer Q). Because each step in a formal proof follows from a precisely stated rule, the entire proof can, in principle, be checked mechanically for correctness without needing to interpret the meaning of the symbols involved — a feature that makes symbolic logic especially well-suited to being implemented in computer programs, including automated theorem provers.'],
          'correct': 3,
        },
        {
          'passage': 'A formal proof in symbolic logic is a sequence of statements, each of which is either a premise or follows from earlier statements by an accepted rule of inference, ending in the desired conclusion. Common rules of inference include modus ponens (from P → Q and P, infer Q), modus tollens (from P → Q and ¬Q, infer ¬P), and disjunctive syllogism (from P ∨ Q and ¬P, infer Q). Because each step in a formal proof follows from a precisely stated rule, the entire proof can, in principle, be checked mechanically for correctness without needing to interpret the meaning of the symbols involved — a feature that makes symbolic logic especially well-suited to being implemented in computer programs, including automated theorem provers.',
          'question': 'According to the passage, a formal proof is a sequence of statements, each of which is either a premise or:',
          'options': ['follows from earlier statements by an accepted rule of inference', 'must be independently proven true by experiment', 'is simply asserted without justification', 'is chosen at random'],
          'correct': 0,
        },
        {
          'passage': 'A formal proof in symbolic logic is a sequence of statements, each of which is either a premise or follows from earlier statements by an accepted rule of inference, ending in the desired conclusion. Common rules of inference include modus ponens (from P → Q and P, infer Q), modus tollens (from P → Q and ¬Q, infer ¬P), and disjunctive syllogism (from P ∨ Q and ¬P, infer Q). Because each step in a formal proof follows from a precisely stated rule, the entire proof can, in principle, be checked mechanically for correctness without needing to interpret the meaning of the symbols involved — a feature that makes symbolic logic especially well-suited to being implemented in computer programs, including automated theorem provers.',
          'question': 'According to the passage, modus tollens allows us to infer:',
          'options': ['¬P, from P → Q and ¬Q', 'P, from P ∨ Q and ¬Q', 'Q, from P → Q and P', '¬Q, from P → Q and P'],
          'correct': 0,
        },
        {
          'passage': 'A formal proof in symbolic logic is a sequence of statements, each of which is either a premise or follows from earlier statements by an accepted rule of inference, ending in the desired conclusion. Common rules of inference include modus ponens (from P → Q and P, infer Q), modus tollens (from P → Q and ¬Q, infer ¬P), and disjunctive syllogism (from P ∨ Q and ¬P, infer Q). Because each step in a formal proof follows from a precisely stated rule, the entire proof can, in principle, be checked mechanically for correctness without needing to interpret the meaning of the symbols involved — a feature that makes symbolic logic especially well-suited to being implemented in computer programs, including automated theorem provers.',
          'question': 'According to the passage, disjunctive syllogism allows us to infer Q from:',
          'options': ['P → Q and P', 'P → Q and ¬Q', 'P ∨ Q and ¬P', 'P ∧ Q and ¬P'],
          'correct': 2,
        },
        {
          'passage': 'A formal proof in symbolic logic is a sequence of statements, each of which is either a premise or follows from earlier statements by an accepted rule of inference, ending in the desired conclusion. Common rules of inference include modus ponens (from P → Q and P, infer Q), modus tollens (from P → Q and ¬Q, infer ¬P), and disjunctive syllogism (from P ∨ Q and ¬P, infer Q). Because each step in a formal proof follows from a precisely stated rule, the entire proof can, in principle, be checked mechanically for correctness without needing to interpret the meaning of the symbols involved — a feature that makes symbolic logic especially well-suited to being implemented in computer programs, including automated theorem provers.',
          'question': 'According to the passage, why is symbolic logic especially well-suited to computer implementation?',
          'options': ['computers can understand natural language perfectly', 'each step can be mechanically checked for correctness without interpreting the meaning of the symbols', 'computer programs cannot process mathematics', 'symbolic logic requires no rules of inference'],
          'correct': 1,
        },
        {
          'question': 'In propositional logic, the symbol \'↔\' represents:',
          'options': ['a disjunction, \'or\'', 'a conjunction, \'and\'', 'a biconditional, \'if and only if\'', 'a negation, \'not\''],
          'correct': 2,
        },
        {
          'question': 'A biconditional P ↔ Q is true exactly when:',
          'options': ['P is false and Q is true', 'P and Q have the same truth value (both true or both false)', 'P is true and Q is false', 'at least one of P or Q is true'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the \'inclusive or\' used as the standard meaning of ∨ in symbolic logic?',
          'options': ['it is true when at least one disjunct is true, including when both are true', 'it is identical in meaning to negation', 'it is true only when both disjuncts are false', 'it is true only when exactly one disjunct is true, never both'],
          'correct': 0,
        },
        {
          'question': 'Which of the following symbols is typically used to represent \'exclusive or\' (true when exactly one of P or Q is true, but not both)?',
          'options': ['⊕', '¬', '∧', '↔'],
          'correct': 0,
        },
        {
          'question': 'In predicate logic, a \'predicate\' such as Hx (\'x is human\') is best understood as:',
          'options': ['a truth value, either true or false on its own', 'a property or relation that may or may not apply to a given individual or variable', 'a logical connective like \'and\' or \'or\'', 'a specific individual, like a proper name'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes a \'well-formed formula\' (WFF) in symbolic logic?',
          'options': ['an expression constructed according to the syntactic rules of the logical system, capable of having a truth value', 'any random string of logical symbols', 'a formula that is always true', 'a formula written only in natural language'],
          'correct': 0,
        },
        {
          'question': 'Which of the following statements is an example of a valid instance of modus ponens?',
          'options': ['\'If it rains, the ground gets wet. It is raining. Therefore, the ground gets wet.\'', '\'If it rains, the ground gets wet. It is not raining. Therefore, the ground is not wet.\'', '\'It rains or it snows. It is not raining. Therefore, it is not snowing.\'', '\'If it rains, the ground gets wet. The ground is wet. Therefore, it is raining.\''],
          'correct': 0,
        },
        {
          'question': 'Which of the following statements is an example of the fallacy of affirming the consequent?',
          'options': ['\'If it rains, the ground gets wet. It is not raining. Therefore, the ground is not wet, and this argument is valid.\'', '\'If it rains, the ground gets wet. It is raining. Therefore, the ground gets wet.\'', '\'If it rains, the ground gets wet. The ground is wet. Therefore, it is raining.\'', '\'If it rains, the ground gets wet. The ground is not wet. Therefore, it is not raining.\''],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes a \'contingent\' statement in symbolic logic?',
          'options': ['a statement that is true in some possible cases and false in others, depending on the truth values of its components', 'a statement that is always true, regardless of circumstances', 'a statement that is always false, regardless of circumstances', 'a statement with no truth value at all'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the scope of a quantifier in predicate logic, such as ∀x in ∀x (Hx → Mx)?',
          'options': ['the part of the formula to which the quantifier applies, here the entire conditional (Hx → Mx)', 'only the very first symbol immediately following the quantifier', 'the entire rest of the document, regardless of parentheses', 'nothing; quantifiers have no scope'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best represents \'no philosophers are careless thinkers\' in predicate logic, using Px for \'x is a philosopher\' and Cx for \'x is a careless thinker\'?',
          'options': ['∀x (Px ∧ Cx)', '∃x (Px → Cx)', '∃x (Px ∧ Cx)', '∀x (Px → ¬Cx)'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best represents \'some logicians are not mathematicians\' in predicate logic, using Lx for \'x is a logician\' and Mx for \'x is a mathematician\'?',
          'options': ['∀x (Lx → ¬Mx)', '∃x (Lx → Mx)', '∃x (Lx ∧ ¬Mx)', '∀x (Lx ∧ ¬Mx)'],
          'correct': 2,
        },
        {
          'question': 'A \'tautology\' can be confirmed in propositional logic by:',
          'options': ['assuming it is true without any verification', 'constructing a truth table and checking that the statement is true in every row', 'asking a random sample of people whether they agree', 'checking whether it has ever been mentioned in a textbook'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the difference between propositional logic and predicate logic in terms of expressive power?',
          'options': ['predicate logic can represent internal structure within statements (such as quantities and properties), while propositional logic treats whole statements as unanalyzed units', 'they have identical expressive power in every respect', 'propositional logic is strictly more powerful than predicate logic', 'predicate logic cannot represent conjunction or disjunction at all'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes an \'automated theorem prover,\' as mentioned in connection with symbolic logic?',
          'options': ['a search engine for philosophy papers', 'a machine used only for arithmetic calculation', 'a device for measuring emotional responses to arguments', 'a computer program that checks or constructs formal proofs by mechanically applying rules of inference'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the purpose of parentheses in symbolic logic expressions, such as (P ∧ Q) → R?',
          'options': ['to indicate that a statement is false', 'to represent a quantifier', 'to indicate the precise grouping and scope of connectives, avoiding ambiguity', 'to make the formula look more complicated'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes a key advantage of translating natural-language arguments into symbolic form?',
          'options': ['it makes arguments more persuasive to a general audience', 'it guarantees that the argument\'s premises are true', 'it eliminates the need to identify premises and conclusions', 'it removes ambiguity present in ordinary language, allowing precise evaluation of validity'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes an \'interpretation\' (or model) in symbolic logic?',
          'options': ['a rule of inference such as modus ponens', 'a synonym for a formal proof', 'an assignment of meanings or truth values to the symbols in a formula, used to evaluate it', 'a persuasive summary of an argument for a general audience'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'logical consequence\' in symbolic logic?',
          'options': ['a conclusion reached by majority vote', 'any statement that happens to be mentioned after the premises', 'a conclusion Q is a logical consequence of premises P1...Pn if it is impossible for all the premises to be true while Q is false', 'a conclusion that is popular among logicians'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the difference between syntax and semantics in symbolic logic?',
          'options': ['they are exactly the same concept in logic', 'syntax concerns meaning, while semantics concerns formula construction', 'semantics only applies to predicate logic, never propositional logic', 'syntax concerns the formal rules for constructing well-formed expressions, while semantics concerns their meaning and truth conditions'],
          'correct': 3,
        },
      ];
    case 'gns106_u3_3': // Fallacies
      return [
        {
          'passage': 'A logical fallacy is an error in reasoning that undermines the logical validity or rational persuasiveness of an argument. Fallacies are typically divided into two broad categories. Formal fallacies are errors in the logical structure of an argument itself — the argument would be invalid regardless of the specific content substituted into it, such as affirming the consequent. Informal fallacies, by contrast, are errors that arise from the content, context, or language of an argument rather than from its abstract logical form; an argument committing an informal fallacy might even have a valid-looking structure while still failing to provide genuine rational support for its conclusion, often because a premise is irrelevant, ambiguous, or unjustified.',
          'question': 'According to the passage, a logical fallacy is best described as:',
          'options': ['an error in reasoning that undermines the logical validity or rational persuasiveness of an argument', 'a true but poorly worded statement', 'a rule of formal logic', 'any argument that reaches a false conclusion'],
          'correct': 0,
        },
        {
          'passage': 'A logical fallacy is an error in reasoning that undermines the logical validity or rational persuasiveness of an argument. Fallacies are typically divided into two broad categories. Formal fallacies are errors in the logical structure of an argument itself — the argument would be invalid regardless of the specific content substituted into it, such as affirming the consequent. Informal fallacies, by contrast, are errors that arise from the content, context, or language of an argument rather than from its abstract logical form; an argument committing an informal fallacy might even have a valid-looking structure while still failing to provide genuine rational support for its conclusion, often because a premise is irrelevant, ambiguous, or unjustified.',
          'question': 'According to the passage, formal fallacies are errors that:',
          'options': ['only occur in mathematics', 'occur in the logical structure of an argument itself, regardless of content', 'only occur when the content of an argument is emotionally charged', 'are impossible to identify without extensive research'],
          'correct': 1,
        },
        {
          'passage': 'A logical fallacy is an error in reasoning that undermines the logical validity or rational persuasiveness of an argument. Fallacies are typically divided into two broad categories. Formal fallacies are errors in the logical structure of an argument itself — the argument would be invalid regardless of the specific content substituted into it, such as affirming the consequent. Informal fallacies, by contrast, are errors that arise from the content, context, or language of an argument rather than from its abstract logical form; an argument committing an informal fallacy might even have a valid-looking structure while still failing to provide genuine rational support for its conclusion, often because a premise is irrelevant, ambiguous, or unjustified.',
          'question': 'According to the passage, informal fallacies arise from:',
          'options': ['the use of any symbols in an argument', 'purely mathematical errors', 'the content, context, or language of an argument, rather than its abstract form', 'errors that never appear in real-world arguments'],
          'correct': 2,
        },
        {
          'passage': 'A logical fallacy is an error in reasoning that undermines the logical validity or rational persuasiveness of an argument. Fallacies are typically divided into two broad categories. Formal fallacies are errors in the logical structure of an argument itself — the argument would be invalid regardless of the specific content substituted into it, such as affirming the consequent. Informal fallacies, by contrast, are errors that arise from the content, context, or language of an argument rather than from its abstract logical form; an argument committing an informal fallacy might even have a valid-looking structure while still failing to provide genuine rational support for its conclusion, often because a premise is irrelevant, ambiguous, or unjustified.',
          'question': 'According to the passage, why might an argument committing an informal fallacy still look valid?',
          'options': ['because all informal fallacies are also formal fallacies', 'because such arguments are always sound', 'because informal fallacies never involve premises', 'because informal fallacies can occur even when the structure looks valid, due to an irrelevant, ambiguous, or unjustified premise Passage 2 The ad hominem fallacy occurs when an arguer attacks the person making a claim rather than addressing the claim itself, treating a fact about the speaker as though it were evidence against their argument. It is important to note that not every personal remark made during a debate is automatically an ad hominem fallacy; pointing out that a witness has a documented history of dishonesty may be directly relevant when the witness\'s credibility itself is the very thing in question. The fallacy occurs specifically when a personal attack is substituted for engagement with the substance of an argument, as when someone dismisses a scientist\'s climate research by claiming, without further argument, that the scientist \'just wants research funding,\' rather than addressing the actual data and methodology presented.'],
          'correct': 3,
        },
        {
          'passage': 'The ad hominem fallacy occurs when an arguer attacks the person making a claim rather than addressing the claim itself, treating a fact about the speaker as though it were evidence against their argument. It is important to note that not every personal remark made during a debate is automatically an ad hominem fallacy; pointing out that a witness has a documented history of dishonesty may be directly relevant when the witness\'s credibility itself is the very thing in question. The fallacy occurs specifically when a personal attack is substituted for engagement with the substance of an argument, as when someone dismisses a scientist\'s climate research by claiming, without further argument, that the scientist \'just wants research funding,\' rather than addressing the actual data and methodology presented.',
          'question': 'According to the passage, the ad hominem fallacy occurs when an arguer:',
          'options': ['offers a valid deductive argument', 'attacks the person making a claim rather than addressing the claim itself', 'provides strong evidence for their own position', 'cites a relevant expert on the topic'],
          'correct': 1,
        },
        {
          'passage': 'The ad hominem fallacy occurs when an arguer attacks the person making a claim rather than addressing the claim itself, treating a fact about the speaker as though it were evidence against their argument. It is important to note that not every personal remark made during a debate is automatically an ad hominem fallacy; pointing out that a witness has a documented history of dishonesty may be directly relevant when the witness\'s credibility itself is the very thing in question. The fallacy occurs specifically when a personal attack is substituted for engagement with the substance of an argument, as when someone dismisses a scientist\'s climate research by claiming, without further argument, that the scientist \'just wants research funding,\' rather than addressing the actual data and methodology presented.',
          'question': 'According to the passage, is every personal remark made during a debate automatically an ad hominem fallacy?',
          'options': ['yes, any personal remark at all counts as this fallacy', 'the passage does not address this question', 'yes, but only if the remark is false', 'no, the passage says it is important to note this is not automatic'],
          'correct': 3,
        },
        {
          'passage': 'The ad hominem fallacy occurs when an arguer attacks the person making a claim rather than addressing the claim itself, treating a fact about the speaker as though it were evidence against their argument. It is important to note that not every personal remark made during a debate is automatically an ad hominem fallacy; pointing out that a witness has a documented history of dishonesty may be directly relevant when the witness\'s credibility itself is the very thing in question. The fallacy occurs specifically when a personal attack is substituted for engagement with the substance of an argument, as when someone dismisses a scientist\'s climate research by claiming, without further argument, that the scientist \'just wants research funding,\' rather than addressing the actual data and methodology presented.',
          'question': 'According to the passage, when might pointing out a witness\'s history of dishonesty be legitimately relevant?',
          'options': ['only in a court of law, never elsewhere', 'never, under any circumstances', 'when the witness\'s credibility itself is the very thing in question', 'only when the witness is a scientist'],
          'correct': 2,
        },
        {
          'passage': 'The ad hominem fallacy occurs when an arguer attacks the person making a claim rather than addressing the claim itself, treating a fact about the speaker as though it were evidence against their argument. It is important to note that not every personal remark made during a debate is automatically an ad hominem fallacy; pointing out that a witness has a documented history of dishonesty may be directly relevant when the witness\'s credibility itself is the very thing in question. The fallacy occurs specifically when a personal attack is substituted for engagement with the substance of an argument, as when someone dismisses a scientist\'s climate research by claiming, without further argument, that the scientist \'just wants research funding,\' rather than addressing the actual data and methodology presented.',
          'question': 'According to the passage\'s example, what does the fallacious dismissal of the climate scientist\'s research consist of?',
          'options': ['questioning the statistical methods used', 'claiming the scientist \'just wants research funding\' without addressing the actual data and methodology', 'providing a detailed critique of the data itself', 'citing a peer-reviewed rebuttal study Passage 3 The straw man fallacy occurs when someone misrepresents an opponent\'s argument in a distorted, exaggerated, or oversimplified form that is easier to attack than the argument the opponent actually made, and then proceeds to refute that distorted version as though this refuted the original position. For example, if one person argues \'we should have some regulations on factory emissions to protect public health,\' and another responds, \'so you want to shut down all factories and destroy the economy,\' the second person has attacked a far more extreme position than the one actually proposed. The straw man fallacy is considered particularly corrosive to genuine rational inquiry because it can make an arguer feel they have won a debate without ever actually engaging with the strongest version of the opposing view.'],
          'correct': 1,
        },
        {
          'passage': 'The straw man fallacy occurs when someone misrepresents an opponent\'s argument in a distorted, exaggerated, or oversimplified form that is easier to attack than the argument the opponent actually made, and then proceeds to refute that distorted version as though this refuted the original position. For example, if one person argues \'we should have some regulations on factory emissions to protect public health,\' and another responds, \'so you want to shut down all factories and destroy the economy,\' the second person has attacked a far more extreme position than the one actually proposed. The straw man fallacy is considered particularly corrosive to genuine rational inquiry because it can make an arguer feel they have won a debate without ever actually engaging with the strongest version of the opposing view.',
          'question': 'According to the passage, the straw man fallacy occurs when someone:',
          'options': ['accurately restates an opponent\'s argument before refuting it', 'cites statistical evidence against an opponent\'s claim', 'agrees with an opponent\'s argument', 'misrepresents an opponent\'s argument in a distorted or exaggerated form before refuting it'],
          'correct': 3,
        },
        {
          'passage': 'The straw man fallacy occurs when someone misrepresents an opponent\'s argument in a distorted, exaggerated, or oversimplified form that is easier to attack than the argument the opponent actually made, and then proceeds to refute that distorted version as though this refuted the original position. For example, if one person argues \'we should have some regulations on factory emissions to protect public health,\' and another responds, \'so you want to shut down all factories and destroy the economy,\' the second person has attacked a far more extreme position than the one actually proposed. The straw man fallacy is considered particularly corrosive to genuine rational inquiry because it can make an arguer feel they have won a debate without ever actually engaging with the strongest version of the opposing view.',
          'question': 'According to the passage\'s example, what was the original position actually proposed?',
          'options': ['shutting down all factories entirely', 'destroying the economy deliberately', 'banning all forms of industry', 'some regulations on factory emissions to protect public health'],
          'correct': 3,
        },
        {
          'passage': 'The straw man fallacy occurs when someone misrepresents an opponent\'s argument in a distorted, exaggerated, or oversimplified form that is easier to attack than the argument the opponent actually made, and then proceeds to refute that distorted version as though this refuted the original position. For example, if one person argues \'we should have some regulations on factory emissions to protect public health,\' and another responds, \'so you want to shut down all factories and destroy the economy,\' the second person has attacked a far more extreme position than the one actually proposed. The straw man fallacy is considered particularly corrosive to genuine rational inquiry because it can make an arguer feel they have won a debate without ever actually engaging with the strongest version of the opposing view.',
          'question': 'According to the passage\'s example, how did the second person distort this position?',
          'options': ['by agreeing with the need for some regulation', 'by proposing even stricter regulations', 'by citing scientific data on emissions', 'by claiming the first person wants to shut down all factories and destroy the economy'],
          'correct': 3,
        },
        {
          'passage': 'The straw man fallacy occurs when someone misrepresents an opponent\'s argument in a distorted, exaggerated, or oversimplified form that is easier to attack than the argument the opponent actually made, and then proceeds to refute that distorted version as though this refuted the original position. For example, if one person argues \'we should have some regulations on factory emissions to protect public health,\' and another responds, \'so you want to shut down all factories and destroy the economy,\' the second person has attacked a far more extreme position than the one actually proposed. The straw man fallacy is considered particularly corrosive to genuine rational inquiry because it can make an arguer feel they have won a debate without ever actually engaging with the strongest version of the opposing view.',
          'question': 'According to the passage, why is the straw man fallacy considered particularly corrosive to rational inquiry?',
          'options': ['it is the only fallacy that involves any distortion', 'it always leads to legal consequences', 'it cannot be avoided in any debate', 'it can make an arguer feel they have won without engaging the strongest version of the opposing view Passage 4 The false dilemma (or false dichotomy) fallacy occurs when an argument presents only two options as though they were the only possibilities, when in fact other options exist. A common example is the claim \'either we cut all environmental regulations, or our economy will collapse,\' which ignores the possibility of moderate, targeted regulation, phased implementation, or various other alternatives between the two extremes presented. False dilemmas can be a genuinely honest mistake, arising from failing to consider a full range of possibilities, but they are also frequently used deliberately as a rhetorical device to pressure an audience into choosing the arguer\'s preferred option by making the alternative seem obviously worse or the only other choice available.'],
          'correct': 3,
        },
        {
          'passage': 'The false dilemma (or false dichotomy) fallacy occurs when an argument presents only two options as though they were the only possibilities, when in fact other options exist. A common example is the claim \'either we cut all environmental regulations, or our economy will collapse,\' which ignores the possibility of moderate, targeted regulation, phased implementation, or various other alternatives between the two extremes presented. False dilemmas can be a genuinely honest mistake, arising from failing to consider a full range of possibilities, but they are also frequently used deliberately as a rhetorical device to pressure an audience into choosing the arguer\'s preferred option by making the alternative seem obviously worse or the only other choice available.',
          'question': 'According to the passage, the false dilemma fallacy occurs when an argument:',
          'options': ['avoids offering any options at all', 'presents only two options as though they were the only possibilities, when others exist', 'presents too many possible options to choose from', 'accurately lists every relevant possibility'],
          'correct': 1,
        },
        {
          'passage': 'The false dilemma (or false dichotomy) fallacy occurs when an argument presents only two options as though they were the only possibilities, when in fact other options exist. A common example is the claim \'either we cut all environmental regulations, or our economy will collapse,\' which ignores the possibility of moderate, targeted regulation, phased implementation, or various other alternatives between the two extremes presented. False dilemmas can be a genuinely honest mistake, arising from failing to consider a full range of possibilities, but they are also frequently used deliberately as a rhetorical device to pressure an audience into choosing the arguer\'s preferred option by making the alternative seem obviously worse or the only other choice available.',
          'question': 'According to the passage\'s example, what does \'either we cut all environmental regulations, or our economy will collapse\' ignore?',
          'options': ['the existence of environmental regulations altogether', 'the possibility of moderate, targeted regulation or phased implementation', 'the possibility that regulations have any cost at all', 'the possibility that the economy could grow'],
          'correct': 1,
        },
        {
          'passage': 'The false dilemma (or false dichotomy) fallacy occurs when an argument presents only two options as though they were the only possibilities, when in fact other options exist. A common example is the claim \'either we cut all environmental regulations, or our economy will collapse,\' which ignores the possibility of moderate, targeted regulation, phased implementation, or various other alternatives between the two extremes presented. False dilemmas can be a genuinely honest mistake, arising from failing to consider a full range of possibilities, but they are also frequently used deliberately as a rhetorical device to pressure an audience into choosing the arguer\'s preferred option by making the alternative seem obviously worse or the only other choice available.',
          'question': 'According to the passage, can false dilemmas be an honest mistake?',
          'options': ['no, false dilemmas are impossible to make by accident', 'no, they are always used deliberately and dishonestly', 'yes, the passage says they can be a genuinely honest mistake', 'the passage does not address this question'],
          'correct': 2,
        },
        {
          'passage': 'The false dilemma (or false dichotomy) fallacy occurs when an argument presents only two options as though they were the only possibilities, when in fact other options exist. A common example is the claim \'either we cut all environmental regulations, or our economy will collapse,\' which ignores the possibility of moderate, targeted regulation, phased implementation, or various other alternatives between the two extremes presented. False dilemmas can be a genuinely honest mistake, arising from failing to consider a full range of possibilities, but they are also frequently used deliberately as a rhetorical device to pressure an audience into choosing the arguer\'s preferred option by making the alternative seem obviously worse or the only other choice available.',
          'question': 'According to the passage, how are false dilemmas frequently used deliberately?',
          'options': ['as a rhetorical device to pressure an audience into choosing the arguer\'s preferred option', 'as a technique exclusive to mathematical proofs', 'as a method for citing peer-reviewed research', 'as a way to present a completely balanced view Passage 5 The slippery slope fallacy argues that a relatively small first step will inevitably lead, through a chain of intermediate events, to a significant and typically undesirable outcome, without adequately establishing that each link in this chain is actually likely to occur. Not every \'this could lead to that\' argument is fallacious — sometimes a chain of events genuinely is likely, and pointing this out is legitimate reasoning about consequences. The fallacy specifically occurs when the arguer fails to provide adequate justification for each step in the supposed chain, instead relying on the mere vividness or scariness of the final outcome to make the argument feel compelling, even though the probability of actually reaching that outcome from the initial step has not been established.'],
          'correct': 0,
        },
        {
          'passage': 'The slippery slope fallacy argues that a relatively small first step will inevitably lead, through a chain of intermediate events, to a significant and typically undesirable outcome, without adequately establishing that each link in this chain is actually likely to occur. Not every \'this could lead to that\' argument is fallacious — sometimes a chain of events genuinely is likely, and pointing this out is legitimate reasoning about consequences. The fallacy specifically occurs when the arguer fails to provide adequate justification for each step in the supposed chain, instead relying on the mere vividness or scariness of the final outcome to make the argument feel compelling, even though the probability of actually reaching that outcome from the initial step has not been established.',
          'question': 'According to the passage, the slippery slope fallacy argues that a small first step will:',
          'options': ['always be beneficial in the long run', 'have no further consequences whatsoever', 'inevitably lead, through a chain of events, to a significant and typically undesirable outcome', 'immediately cause the final outcome with no intermediate steps'],
          'correct': 2,
        },
        {
          'passage': 'The slippery slope fallacy argues that a relatively small first step will inevitably lead, through a chain of intermediate events, to a significant and typically undesirable outcome, without adequately establishing that each link in this chain is actually likely to occur. Not every \'this could lead to that\' argument is fallacious — sometimes a chain of events genuinely is likely, and pointing this out is legitimate reasoning about consequences. The fallacy specifically occurs when the arguer fails to provide adequate justification for each step in the supposed chain, instead relying on the mere vividness or scariness of the final outcome to make the argument feel compelling, even though the probability of actually reaching that outcome from the initial step has not been established.',
          'question': 'According to the passage, is every \'this could lead to that\' argument automatically fallacious?',
          'options': ['no, sometimes a chain of events genuinely is likely, and pointing this out is legitimate', 'the passage does not address this question', 'yes, but only if the outcome is undesirable', 'yes, all such arguments are always fallacious'],
          'correct': 0,
        },
        {
          'passage': 'The slippery slope fallacy argues that a relatively small first step will inevitably lead, through a chain of intermediate events, to a significant and typically undesirable outcome, without adequately establishing that each link in this chain is actually likely to occur. Not every \'this could lead to that\' argument is fallacious — sometimes a chain of events genuinely is likely, and pointing this out is legitimate reasoning about consequences. The fallacy specifically occurs when the arguer fails to provide adequate justification for each step in the supposed chain, instead relying on the mere vividness or scariness of the final outcome to make the argument feel compelling, even though the probability of actually reaching that outcome from the initial step has not been established.',
          'question': 'According to the passage, when specifically does the slippery slope fallacy occur?',
          'options': ['whenever a negative outcome is mentioned at all', 'when the arguer fails to provide adequate justification for each step in the supposed chain', 'only when the argument is about politics', 'whenever more than one step is involved in an argument'],
          'correct': 1,
        },
        {
          'passage': 'The slippery slope fallacy argues that a relatively small first step will inevitably lead, through a chain of intermediate events, to a significant and typically undesirable outcome, without adequately establishing that each link in this chain is actually likely to occur. Not every \'this could lead to that\' argument is fallacious — sometimes a chain of events genuinely is likely, and pointing this out is legitimate reasoning about consequences. The fallacy specifically occurs when the arguer fails to provide adequate justification for each step in the supposed chain, instead relying on the mere vividness or scariness of the final outcome to make the argument feel compelling, even though the probability of actually reaching that outcome from the initial step has not been established.',
          'question': 'According to the passage, what does the fallacious version of this argument rely on instead of justification?',
          'options': ['an admission from the opposing side', 'the mere vividness or scariness of the final outcome', 'a formal logical proof', 'a peer-reviewed statistical study'],
          'correct': 1,
        },
        {
          'question': 'The appeal to authority fallacy occurs when an argument relies on the opinion of:',
          'options': ['a properly conducted meta-analysis', 'a genuinely qualified expert citing evidence within their field of expertise', 'a peer-reviewed scientific consensus', 'someone who is not actually a relevant or credible expert on the topic in question'],
          'correct': 3,
        },
        {
          'question': 'The \'appeal to popularity\' (argumentum ad populum) fallacy assumes that a claim is true because:',
          'options': ['it has been proven through rigorous experiment', 'a relevant expert supports it', 'it follows logically from accepted premises', 'many or most people believe it'],
          'correct': 3,
        },
        {
          'question': 'The \'appeal to emotion\' fallacy occurs when an argument attempts to persuade primarily by:',
          'options': ['offering a well-supported analogy', 'citing statistically representative data', 'presenting a valid deductive proof', 'provoking a strong emotional reaction rather than offering relevant evidence or reasoning'],
          'correct': 3,
        },
        {
          'question': 'The \'red herring\' fallacy involves:',
          'options': ['directly refuting the argument\'s central premise', 'clarifying an ambiguous term in the argument', 'introducing an irrelevant topic to divert attention away from the original issue', 'strengthening an argument with additional relevant evidence'],
          'correct': 2,
        },
        {
          'question': 'The \'begging the question\' fallacy (circular reasoning) occurs when:',
          'options': ['an argument uses too many premises', 'a question is asked instead of a claim being made', 'a conclusion follows validly from independent premises', 'the conclusion of an argument is assumed, explicitly or implicitly, within one of its premises'],
          'correct': 3,
        },
        {
          'question': 'The \'hasty generalization\' fallacy occurs when a broad conclusion is drawn from:',
          'options': ['an appropriately large and representative sample', 'a formally valid deductive argument', 'a sample that is too small or unrepresentative to justify it', 'a single well-controlled experiment with a large sample'],
          'correct': 2,
        },
        {
          'question': 'The \'post hoc ergo propter hoc\' fallacy (also called false cause) occurs when it is assumed that:',
          'options': ['an event has multiple contributing causes', 'because one event followed another, the first event must have caused the second', 'a correlation has been rigorously tested for causation', 'two unrelated events share no connection at all'],
          'correct': 1,
        },
        {
          'question': 'The \'appeal to ignorance\' (argumentum ad ignorantiam) fallacy assumes a claim is true because:',
          'options': ['it has not been proven false, or false because it has not been proven true', 'it is logically necessary', 'it has been directly demonstrated through evidence', 'it has been peer-reviewed'],
          'correct': 0,
        },
        {
          'question': 'The \'tu quoque\' (\'you too\') fallacy attempts to discredit a claim by pointing out that:',
          'options': ['the claim relies on an ambiguous term', 'the argument supporting the claim is invalid', 'the person making the claim has themselves acted inconsistently with it', 'the claim contradicts established scientific evidence'],
          'correct': 2,
        },
        {
          'question': 'The \'no true Scotsman\' fallacy involves:',
          'options': ['providing a genuine counterexample to a general claim', 'accepting a counterexample and revising one\'s view accordingly', 'citing a relevant statistic about Scotland', 'redefining a category to exclude counterexamples after they are raised, rather than revising the original claim'],
          'correct': 3,
        },
        {
          'question': 'The \'equivocation\' fallacy occurs when an argument relies on:',
          'options': ['using a key term with two different meanings at different points in the argument', 'offering a valid deductive syllogism', 'using a single, consistent definition throughout an argument', 'citing two independent pieces of relevant evidence'],
          'correct': 0,
        },
        {
          'question': 'The \'genetic fallacy\' occurs when a claim is judged true or false based on:',
          'options': ['a controlled experimental test', 'its logical consistency with other accepted claims', 'its origin or source, rather than its actual content or supporting evidence', 'a rigorous evaluation of its supporting evidence'],
          'correct': 2,
        },
        {
          'question': 'The \'appeal to nature\' fallacy assumes that something is good, right, or justified simply because it is:',
          'options': ['natural or found in nature', 'proven through controlled experimentation', 'consistent with established ethical principles', 'supported by relevant expert consensus'],
          'correct': 0,
        },
        {
          'question': 'The \'composition\' fallacy occurs when it is assumed that:',
          'options': ['no valid inferences can be drawn about wholes from parts', 'what is true of the whole must be true of each of its parts', 'what is true of the parts of a whole must also be true of the whole itself', 'two unrelated wholes must share identical properties'],
          'correct': 2,
        },
        {
          'question': 'The \'division\' fallacy occurs when it is assumed that:',
          'options': ['this fallacy is identical to the fallacy of composition in every respect', 'wholes and parts can never share any properties', 'what is true of a whole must also be true of each of its individual parts', 'what is true of the parts must be true of the whole'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best illustrates the \'sunk cost fallacy\' in reasoning, closely related to fallacious argumentation about decisions?',
          'options': ['refusing to begin any project without a guaranteed outcome', 'continuing to invest in a failing project mainly because of resources already spent, rather than future prospects', 'abandoning a project as soon as it shows signs of failure', 'evaluating a project based only on its future costs and benefits'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why identifying fallacies is valuable in rational inquiry, according to standard treatments of the topic?',
          'options': ['it guarantees that any argument without a named fallacy is automatically sound', 'it proves that the arguer is a bad person', 'it eliminates the need to consider evidence at all', 'it helps distinguish arguments that provide genuine rational support for a conclusion from those that merely appear persuasive'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the difference between a fallacious argument and simply a weak or unpersuasive one?',
          'options': ['they are exactly the same thing in every case', 'a fallacious argument is always weak in every possible respect', 'a weak argument is always also fallacious', 'a fallacious argument contains a specific, identifiable type of reasoning error, while a merely weak argument may just have insufficient supporting evidence'],
          'correct': 3,
        },
        {
          'question': 'The \'bandwagon fallacy\' is closely related to which other named fallacy discussed in standard treatments of informal fallacies?',
          'options': ['the appeal to popularity (argumentum ad populum)', 'the appeal to ignorance', 'the straw man fallacy', 'the slippery slope fallacy'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the \'middle ground\' (false compromise) fallacy?',
          'options': ['accurately identifying a genuinely balanced compromise supported by evidence', 'citing an expert to settle a dispute', 'assuming the correct position must always lie exactly between two opposing extremes', 'rejecting all forms of compromise in every argument'],
          'correct': 2,
        },
      ];
    case 'gns106_u4_1': // Philosophy of Science
      return [
        {
          'passage': 'Philosophy of science asks foundational questions about scientific practice that science itself does not typically address directly: what distinguishes science from non-science (the \'demarcation problem\'), what justifies confidence in scientific theories, and what scientific claims about unobservable entities, such as electrons, actually mean. The philosopher Karl Popper proposed falsifiability as a criterion for demarcation: a theory counts as scientific only if it makes predictions that could, in principle, be shown false by observation or experiment. On Popper\'s view, a theory that is compatible with every conceivable observation, and therefore could never be refuted by evidence, fails to qualify as genuinely scientific, however impressive or confident-sounding its claims may be.',
          'question': 'According to the passage, the \'demarcation problem\' asks:',
          'options': ['how to fund scientific research', 'what distinguishes science from non-science', 'how to calculate probabilities in physics', 'what electrons are made of'],
          'correct': 1,
        },
        {
          'passage': 'Philosophy of science asks foundational questions about scientific practice that science itself does not typically address directly: what distinguishes science from non-science (the \'demarcation problem\'), what justifies confidence in scientific theories, and what scientific claims about unobservable entities, such as electrons, actually mean. The philosopher Karl Popper proposed falsifiability as a criterion for demarcation: a theory counts as scientific only if it makes predictions that could, in principle, be shown false by observation or experiment. On Popper\'s view, a theory that is compatible with every conceivable observation, and therefore could never be refuted by evidence, fails to qualify as genuinely scientific, however impressive or confident-sounding its claims may be.',
          'question': 'According to the passage, Karl Popper proposed which criterion for demarcation?',
          'options': ['falsifiability', 'government funding', 'mathematical elegance', 'popularity among scientists'],
          'correct': 0,
        },
        {
          'passage': 'Philosophy of science asks foundational questions about scientific practice that science itself does not typically address directly: what distinguishes science from non-science (the \'demarcation problem\'), what justifies confidence in scientific theories, and what scientific claims about unobservable entities, such as electrons, actually mean. The philosopher Karl Popper proposed falsifiability as a criterion for demarcation: a theory counts as scientific only if it makes predictions that could, in principle, be shown false by observation or experiment. On Popper\'s view, a theory that is compatible with every conceivable observation, and therefore could never be refuted by evidence, fails to qualify as genuinely scientific, however impressive or confident-sounding its claims may be.',
          'question': 'According to the passage, a theory counts as scientific, on Popper\'s view, only if it:',
          'options': ['makes predictions that could, in principle, be shown false by observation or experiment', 'has never been challenged by any evidence', 'cannot be tested under any circumstances', 'is believed by a majority of scientists'],
          'correct': 0,
        },
        {
          'passage': 'Philosophy of science asks foundational questions about scientific practice that science itself does not typically address directly: what distinguishes science from non-science (the \'demarcation problem\'), what justifies confidence in scientific theories, and what scientific claims about unobservable entities, such as electrons, actually mean. The philosopher Karl Popper proposed falsifiability as a criterion for demarcation: a theory counts as scientific only if it makes predictions that could, in principle, be shown false by observation or experiment. On Popper\'s view, a theory that is compatible with every conceivable observation, and therefore could never be refuted by evidence, fails to qualify as genuinely scientific, however impressive or confident-sounding its claims may be.',
          'question': 'According to the passage, what happens to a theory compatible with every conceivable observation, on Popper\'s view?',
          'options': ['it fails to qualify as genuinely scientific', 'it is automatically declared false', 'it becomes a mathematical theorem', 'it becomes the strongest possible scientific theory Passage 2 Thomas Kuhn\'s influential book The Structure of Scientific Revolutions challenged the idea that science progresses simply by steadily accumulating more and more true facts. Kuhn argued that science typically operates within a \'paradigm\' — a shared framework of theories, methods, and assumptions that defines what counts as a legitimate scientific question and an acceptable answer during a period of \'normal science.\' Over time, anomalies (observations that do not fit the paradigm) accumulate until they can no longer be ignored or explained away, potentially triggering a \'scientific revolution\' in which the old paradigm is replaced by a new one, as occurred in the shift from Newtonian mechanics to Einsteinian relativity. Kuhn controversially suggested that competing paradigms can be difficult to compare directly, since they may rely on different standards for what counts as a good explanation.'],
          'correct': 0,
        },
        {
          'passage': 'Thomas Kuhn\'s influential book The Structure of Scientific Revolutions challenged the idea that science progresses simply by steadily accumulating more and more true facts. Kuhn argued that science typically operates within a \'paradigm\' — a shared framework of theories, methods, and assumptions that defines what counts as a legitimate scientific question and an acceptable answer during a period of \'normal science.\' Over time, anomalies (observations that do not fit the paradigm) accumulate until they can no longer be ignored or explained away, potentially triggering a \'scientific revolution\' in which the old paradigm is replaced by a new one, as occurred in the shift from Newtonian mechanics to Einsteinian relativity. Kuhn controversially suggested that competing paradigms can be difficult to compare directly, since they may rely on different standards for what counts as a good explanation.',
          'question': 'According to the passage, Kuhn challenged the idea that science progresses by:',
          'options': ['operating within shared paradigms', 'relying on falsifiability', 'steadily accumulating more and more true facts', 'undergoing periodic revolutions'],
          'correct': 2,
        },
        {
          'passage': 'Thomas Kuhn\'s influential book The Structure of Scientific Revolutions challenged the idea that science progresses simply by steadily accumulating more and more true facts. Kuhn argued that science typically operates within a \'paradigm\' — a shared framework of theories, methods, and assumptions that defines what counts as a legitimate scientific question and an acceptable answer during a period of \'normal science.\' Over time, anomalies (observations that do not fit the paradigm) accumulate until they can no longer be ignored or explained away, potentially triggering a \'scientific revolution\' in which the old paradigm is replaced by a new one, as occurred in the shift from Newtonian mechanics to Einsteinian relativity. Kuhn controversially suggested that competing paradigms can be difficult to compare directly, since they may rely on different standards for what counts as a good explanation.',
          'question': 'According to the passage, a \'paradigm\' is:',
          'options': ['a single specific experiment', 'a mathematical constant', 'a shared framework of theories, methods, and assumptions defining legitimate questions and answers', 'a government funding body'],
          'correct': 2,
        },
        {
          'passage': 'Thomas Kuhn\'s influential book The Structure of Scientific Revolutions challenged the idea that science progresses simply by steadily accumulating more and more true facts. Kuhn argued that science typically operates within a \'paradigm\' — a shared framework of theories, methods, and assumptions that defines what counts as a legitimate scientific question and an acceptable answer during a period of \'normal science.\' Over time, anomalies (observations that do not fit the paradigm) accumulate until they can no longer be ignored or explained away, potentially triggering a \'scientific revolution\' in which the old paradigm is replaced by a new one, as occurred in the shift from Newtonian mechanics to Einsteinian relativity. Kuhn controversially suggested that competing paradigms can be difficult to compare directly, since they may rely on different standards for what counts as a good explanation.',
          'question': 'According to the passage, what can trigger a \'scientific revolution\'?',
          'options': ['a change in government funding priorities', 'the accumulation of anomalies that no longer fit the existing paradigm', 'the retirement of senior scientists', 'a decrease in the number of published papers'],
          'correct': 1,
        },
        {
          'passage': 'Thomas Kuhn\'s influential book The Structure of Scientific Revolutions challenged the idea that science progresses simply by steadily accumulating more and more true facts. Kuhn argued that science typically operates within a \'paradigm\' — a shared framework of theories, methods, and assumptions that defines what counts as a legitimate scientific question and an acceptable answer during a period of \'normal science.\' Over time, anomalies (observations that do not fit the paradigm) accumulate until they can no longer be ignored or explained away, potentially triggering a \'scientific revolution\' in which the old paradigm is replaced by a new one, as occurred in the shift from Newtonian mechanics to Einsteinian relativity. Kuhn controversially suggested that competing paradigms can be difficult to compare directly, since they may rely on different standards for what counts as a good explanation.',
          'question': 'According to the passage, what example does Kuhn\'s theory use to illustrate a scientific revolution?',
          'options': ['the shift from Newtonian mechanics to Einsteinian relativity', 'the invention of the telescope', 'the discovery of DNA\'s structure', 'the development of vaccines Passage 3 A central question in philosophy of science concerns scientific realism: should we believe that our best scientific theories are approximately true descriptions of an objective, mind-independent reality, including claims about unobservable entities such as quarks or fields? Scientific realists argue that the extraordinary predictive success of modern science would be a near-miracle if its theories were not at least approximately tracking real features of the world — an argument sometimes called the \'no miracles argument.\' Anti-realists, by contrast, point to the history of previously successful theories that were later abandoned as false, such as the caloric theory of heat, arguing that current theories may likewise eventually be replaced, so predictive success alone does not guarantee approximate truth about unobservable entities.'],
          'correct': 0,
        },
        {
          'passage': 'A central question in philosophy of science concerns scientific realism: should we believe that our best scientific theories are approximately true descriptions of an objective, mind-independent reality, including claims about unobservable entities such as quarks or fields? Scientific realists argue that the extraordinary predictive success of modern science would be a near-miracle if its theories were not at least approximately tracking real features of the world — an argument sometimes called the \'no miracles argument.\' Anti-realists, by contrast, point to the history of previously successful theories that were later abandoned as false, such as the caloric theory of heat, arguing that current theories may likewise eventually be replaced, so predictive success alone does not guarantee approximate truth about unobservable entities.',
          'question': 'According to the passage, scientific realism concerns whether we should believe that:',
          'options': ['all scientific funding should be increased', 'science should only study observable entities', 'our best scientific theories are approximately true descriptions of an objective, mind-independent reality', 'every scientific theory ever proposed is completely true'],
          'correct': 2,
        },
        {
          'passage': 'A central question in philosophy of science concerns scientific realism: should we believe that our best scientific theories are approximately true descriptions of an objective, mind-independent reality, including claims about unobservable entities such as quarks or fields? Scientific realists argue that the extraordinary predictive success of modern science would be a near-miracle if its theories were not at least approximately tracking real features of the world — an argument sometimes called the \'no miracles argument.\' Anti-realists, by contrast, point to the history of previously successful theories that were later abandoned as false, such as the caloric theory of heat, arguing that current theories may likewise eventually be replaced, so predictive success alone does not guarantee approximate truth about unobservable entities.',
          'question': 'According to the passage, the \'no miracles argument\' claims that:',
          'options': ['predictive success proves a theory is completely and finally true', 'scientific predictions are always miraculous and inexplicable', 'the predictive success of science would be a near-miracle if its theories were not approximately tracking reality', 'science has never made an accurate prediction'],
          'correct': 2,
        },
        {
          'passage': 'A central question in philosophy of science concerns scientific realism: should we believe that our best scientific theories are approximately true descriptions of an objective, mind-independent reality, including claims about unobservable entities such as quarks or fields? Scientific realists argue that the extraordinary predictive success of modern science would be a near-miracle if its theories were not at least approximately tracking real features of the world — an argument sometimes called the \'no miracles argument.\' Anti-realists, by contrast, point to the history of previously successful theories that were later abandoned as false, such as the caloric theory of heat, arguing that current theories may likewise eventually be replaced, so predictive success alone does not guarantee approximate truth about unobservable entities.',
          'question': 'According to the passage, what example do anti-realists cite as a previously successful but now-abandoned theory?',
          'options': ['germ theory of disease', 'Einstein\'s theory of relativity', 'the caloric theory of heat', 'the theory of evolution by natural selection'],
          'correct': 2,
        },
        {
          'passage': 'A central question in philosophy of science concerns scientific realism: should we believe that our best scientific theories are approximately true descriptions of an objective, mind-independent reality, including claims about unobservable entities such as quarks or fields? Scientific realists argue that the extraordinary predictive success of modern science would be a near-miracle if its theories were not at least approximately tracking real features of the world — an argument sometimes called the \'no miracles argument.\' Anti-realists, by contrast, point to the history of previously successful theories that were later abandoned as false, such as the caloric theory of heat, arguing that current theories may likewise eventually be replaced, so predictive success alone does not guarantee approximate truth about unobservable entities.',
          'question': 'According to the passage, what do anti-realists conclude from the history of abandoned theories?',
          'options': ['scientific realism is definitely correct', 'unobservable entities definitely do not exist', 'no scientific theory has ever been predictively successful', 'predictive success alone does not guarantee approximate truth about unobservable entities Passage 4 The problem of induction, most famously articulated by David Hume, questions the rational justification for inferring general scientific laws from a finite number of specific observations. Hume pointed out that no matter how many times the sun has risen in the past, this alone does not logically guarantee that it will rise tomorrow; any argument attempting to justify induction by appealing to the past reliability of induction would itself be circular, since it uses induction to justify induction. This problem does not claim that induction is useless in practice — clearly, inductive reasoning underlies enormously successful scientific prediction — but it challenges philosophers to explain exactly what, if anything, provides a non-circular rational justification for trusting it.'],
          'correct': 3,
        },
        {
          'passage': 'The problem of induction, most famously articulated by David Hume, questions the rational justification for inferring general scientific laws from a finite number of specific observations. Hume pointed out that no matter how many times the sun has risen in the past, this alone does not logically guarantee that it will rise tomorrow; any argument attempting to justify induction by appealing to the past reliability of induction would itself be circular, since it uses induction to justify induction. This problem does not claim that induction is useless in practice — clearly, inductive reasoning underlies enormously successful scientific prediction — but it challenges philosophers to explain exactly what, if anything, provides a non-circular rational justification for trusting it.',
          'question': 'According to the passage, the problem of induction questions the rational justification for:',
          'options': ['performing controlled laboratory experiments', 'inferring general scientific laws from a finite number of specific observations', 'publishing scientific papers', 'using mathematics in physics'],
          'correct': 1,
        },
        {
          'passage': 'The problem of induction, most famously articulated by David Hume, questions the rational justification for inferring general scientific laws from a finite number of specific observations. Hume pointed out that no matter how many times the sun has risen in the past, this alone does not logically guarantee that it will rise tomorrow; any argument attempting to justify induction by appealing to the past reliability of induction would itself be circular, since it uses induction to justify induction. This problem does not claim that induction is useless in practice — clearly, inductive reasoning underlies enormously successful scientific prediction — but it challenges philosophers to explain exactly what, if anything, provides a non-circular rational justification for trusting it.',
          'question': 'According to the passage, why can\'t we justify induction by appealing to its past reliability?',
          'options': ['because deduction is always superior to induction', 'because this would be circular, using induction to justify induction itself', 'because scientists do not use induction', 'because induction has never actually worked in the past'],
          'correct': 1,
        },
        {
          'passage': 'The problem of induction, most famously articulated by David Hume, questions the rational justification for inferring general scientific laws from a finite number of specific observations. Hume pointed out that no matter how many times the sun has risen in the past, this alone does not logically guarantee that it will rise tomorrow; any argument attempting to justify induction by appealing to the past reliability of induction would itself be circular, since it uses induction to justify induction. This problem does not claim that induction is useless in practice — clearly, inductive reasoning underlies enormously successful scientific prediction — but it challenges philosophers to explain exactly what, if anything, provides a non-circular rational justification for trusting it.',
          'question': 'According to the passage, does the problem of induction claim that induction is useless in practice?',
          'options': ['yes, it claims induction should never be used at all', 'the passage does not address this question', 'no, the passage explicitly says it does not claim this', 'yes, but only in the physical sciences'],
          'correct': 2,
        },
        {
          'passage': 'The problem of induction, most famously articulated by David Hume, questions the rational justification for inferring general scientific laws from a finite number of specific observations. Hume pointed out that no matter how many times the sun has risen in the past, this alone does not logically guarantee that it will rise tomorrow; any argument attempting to justify induction by appealing to the past reliability of induction would itself be circular, since it uses induction to justify induction. This problem does not claim that induction is useless in practice — clearly, inductive reasoning underlies enormously successful scientific prediction — but it challenges philosophers to explain exactly what, if anything, provides a non-circular rational justification for trusting it.',
          'question': 'According to the passage, what does the problem of induction challenge philosophers to explain?',
          'options': ['why scientists disagree about specific experiments', 'why deduction is more popular than induction', 'how to build better telescopes', 'what, if anything, provides a non-circular rational justification for trusting induction Passage 5 The \'theory-ladenness of observation,\' a concept discussed by philosophers such as Norwood Russell Hanson, suggests that scientific observation is never entirely neutral or \'theory-free\': what a scientist notices, records, and considers significant is shaped, at least in part, by the theoretical framework they already hold. Two scientists looking at the same instrument reading, for example, may interpret its significance quite differently depending on their background theoretical commitments. This does not mean that observation is entirely subjective or that evidence cannot help adjudicate between competing theories; rather, it complicates the traditional picture in which neutral observations are collected first, entirely independent of theory, and theories are constructed afterward purely from that neutral data.'],
          'correct': 3,
        },
        {
          'passage': 'The \'theory-ladenness of observation,\' a concept discussed by philosophers such as Norwood Russell Hanson, suggests that scientific observation is never entirely neutral or \'theory-free\': what a scientist notices, records, and considers significant is shaped, at least in part, by the theoretical framework they already hold. Two scientists looking at the same instrument reading, for example, may interpret its significance quite differently depending on their background theoretical commitments. This does not mean that observation is entirely subjective or that evidence cannot help adjudicate between competing theories; rather, it complicates the traditional picture in which neutral observations are collected first, entirely independent of theory, and theories are constructed afterward purely from that neutral data.',
          'question': 'According to the passage, \'theory-ladenness of observation\' suggests that scientific observation is:',
          'options': ['impossible to perform accurately', 'completely objective and unaffected by any theory', 'never entirely neutral or \'theory-free\'', 'identical for every scientist regardless of background'],
          'correct': 2,
        },
        {
          'passage': 'The \'theory-ladenness of observation,\' a concept discussed by philosophers such as Norwood Russell Hanson, suggests that scientific observation is never entirely neutral or \'theory-free\': what a scientist notices, records, and considers significant is shaped, at least in part, by the theoretical framework they already hold. Two scientists looking at the same instrument reading, for example, may interpret its significance quite differently depending on their background theoretical commitments. This does not mean that observation is entirely subjective or that evidence cannot help adjudicate between competing theories; rather, it complicates the traditional picture in which neutral observations are collected first, entirely independent of theory, and theories are constructed afterward purely from that neutral data.',
          'question': 'According to the passage, what shapes what a scientist notices and considers significant?',
          'options': ['the theoretical framework they already hold', 'only the physical instruments they use', 'random chance alone', 'government regulations'],
          'correct': 0,
        },
        {
          'passage': 'The \'theory-ladenness of observation,\' a concept discussed by philosophers such as Norwood Russell Hanson, suggests that scientific observation is never entirely neutral or \'theory-free\': what a scientist notices, records, and considers significant is shaped, at least in part, by the theoretical framework they already hold. Two scientists looking at the same instrument reading, for example, may interpret its significance quite differently depending on their background theoretical commitments. This does not mean that observation is entirely subjective or that evidence cannot help adjudicate between competing theories; rather, it complicates the traditional picture in which neutral observations are collected first, entirely independent of theory, and theories are constructed afterward purely from that neutral data.',
          'question': 'According to the passage, does theory-ladenness mean observation is entirely subjective?',
          'options': ['yes, it means all observation is purely subjective opinion', 'yes, but only for physics, not biology', 'no, the passage explicitly says this is not what it means', 'the passage does not address this question'],
          'correct': 2,
        },
        {
          'passage': 'The \'theory-ladenness of observation,\' a concept discussed by philosophers such as Norwood Russell Hanson, suggests that scientific observation is never entirely neutral or \'theory-free\': what a scientist notices, records, and considers significant is shaped, at least in part, by the theoretical framework they already hold. Two scientists looking at the same instrument reading, for example, may interpret its significance quite differently depending on their background theoretical commitments. This does not mean that observation is entirely subjective or that evidence cannot help adjudicate between competing theories; rather, it complicates the traditional picture in which neutral observations are collected first, entirely independent of theory, and theories are constructed afterward purely from that neutral data.',
          'question': 'According to the passage, what traditional picture does theory-ladenness complicate?',
          'options': ['one in which neutral observations are collected first, independent of theory, and theories are built afterward from that data', 'the idea that science uses mathematics', 'the idea that experiments can be repeated', 'the idea that scientists collaborate with each other'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the \'demarcation problem\' in philosophy of science?',
          'options': ['the difficulty of measuring extremely small distances', 'the challenge of funding large-scale research projects', 'the problem of translating scientific papers into other languages', 'the challenge of distinguishing genuine science from pseudoscience or non-science'],
          'correct': 3,
        },
        {
          'question': 'Which of the following is most closely associated with the falsifiability criterion for science?',
          'options': ['Karl Popper', 'Imre Lakatos', 'David Hume', 'Thomas Kuhn'],
          'correct': 0,
        },
        {
          'question': 'Which of the following is most closely associated with the concept of scientific \'paradigms\' and paradigm shifts?',
          'options': ['Bertrand Russell', 'David Hume', 'Karl Popper', 'Thomas Kuhn'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'instrumentalism\' as a position in philosophy of science?',
          'options': ['the view identical to scientific realism', 'the view that science should only study measuring instruments', 'the view that scientific theories are useful tools for prediction, without necessarily being literally true descriptions of unobservable reality', 'the view that all scientific theories are literally and completely true'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes Imre Lakatos\'s concept of a \'research programme\'?',
          'options': ['a government grant application', 'a sequence of related theories sharing a stable \'hard core\' of assumptions, evaluated over time by whether it is progressive or degenerating', 'a synonym for a single scientific hypothesis', 'a single isolated experiment conducted once'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the \'underdetermination of theory by evidence\'?',
          'options': ['the idea that evidence is never relevant to theory choice', 'the idea that theories require no evidence whatsoever', 'the idea that a given body of evidence may be equally well explained by more than one competing theory', 'the idea that evidence always uniquely determines exactly one correct theory'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best distinguishes a scientific law from a scientific theory, as commonly used in philosophy of science?',
          'options': ['a law typically describes a specific observed regularity, while a theory offers a broader explanatory framework accounting for such regularities', 'they are exactly identical concepts with no meaningful distinction', 'a theory always precedes and causes a law', 'a law is less certain than a theory in every case'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the role of a \'controlled experiment\' in scientific methodology?',
          'options': ['surveying public opinion about a hypothesis', 'gathering as many uncontrolled observations as possible', 'relying solely on mathematical calculation with no observation', 'isolating the effect of a single variable by holding other relevant factors constant'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a \'null hypothesis\' in scientific methodology?',
          'options': ['the final, confirmed conclusion of an experiment', 'a hypothesis that has already been proven true', 'a hypothesis proposed only in physics, never in biology', 'a default assumption of no effect or no difference, which a study attempts to test against'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'peer review\' in the scientific process?',
          'options': ['a synonym for replication of a study\'s results', 'a vote by the general public on whether a study is correct', 'a legal process required before conducting any experiment', 'the evaluation of research by other qualified experts before publication, intended to help catch errors and assess quality'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the \'replication crisis\' discussed in philosophy and methodology of science?',
          'options': ['concerns that many published scientific findings, especially in some social and biomedical sciences, fail to be reproduced in subsequent studies', 'the discovery that all scientific theories are false', 'a crisis caused by too many scientists replicating identical experiments deliberately', 'a problem unique to ancient scientific texts'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the distinction between \'observation\' and \'inference to the best explanation\' in scientific reasoning?',
          'options': ['observation records what is directly detected, while inference to the best explanation selects the hypothesis that would, if true, best account for that observation', 'they are exactly the same process', 'observation always occurs after a theory is chosen', 'inference to the best explanation requires no observation at all'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'operationalism\' as a methodological approach in science?',
          'options': ['defining a scientific concept strictly in terms of the specific procedures used to measure it', 'a theory about the origin of the universe', 'a synonym for falsifiability', 'rejecting the use of any measurement in science'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes why philosophy of science is relevant to evaluating claims of \'pseudoscience\'?',
          'options': ['it eliminates the need for empirical evidence', 'it provides criteria, such as falsifiability and methodological rigor, for distinguishing legitimate scientific claims from unsupported ones dressed in scientific language', 'it proves that all unconventional claims are automatically false', 'it has no relevance to evaluating any specific claim'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'methodological naturalism\' in science?',
          'options': ['the belief that supernatural explanations are definitely false', 'a rejection of the use of mathematics in science', 'a synonym for scientific realism', 'the practice of explaining natural phenomena using only natural causes and testable mechanisms, without invoking supernatural explanations'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best captures a key difference between Popper\'s falsificationism and Kuhn\'s account of scientific change?',
          'options': ['they proposed exactly the same account of scientific progress', 'Popper rejected the use of observation entirely', 'Kuhn argued that falsifiability is the sole criterion for science', 'Popper emphasized the logical testing of individual theories through falsification, while Kuhn emphasized the historical and sociological dynamics of paradigm shifts'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a \'crucial experiment,\' as traditionally conceived in philosophy of science?',
          'options': ['an experiment designed to decisively determine which of two competing theories is correct', 'an experiment that only tests mathematical claims', 'an experiment conducted without any hypothesis', 'an experiment that can never produce a meaningful result'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the Duhem-Quine thesis in philosophy of science?',
          'options': ['a synonym for Popper\'s falsifiability criterion', 'the idea that all hypotheses can be tested in complete isolation from other assumptions', 'the idea that a hypothesis cannot be tested in isolation, since it is always tested together with a network of auxiliary assumptions', 'the idea that experiments never require any theoretical assumptions'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the value of philosophy of science for practicing scientists, according to standard defenses of the field?',
          'options': ['it proves that scientific results are always certain', 'it replaces the need for laboratory experiments entirely', 'it clarifies the assumptions, methods, and limits of scientific inquiry, which can inform better research design and interpretation of results', 'it has no relevance to how science is actually practiced'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'incommensurability,\' a concept associated with Kuhn\'s account of paradigm shifts?',
          'options': ['the idea that all paradigms use identical standards of evidence', 'a mathematical term unrelated to philosophy of science', 'the claim that scientific revolutions never actually occur', 'the difficulty of directly comparing two paradigms because they may rely on different standards, concepts, or meanings'],
          'correct': 3,
        },
      ];
    case 'gns106_u4_2': // Science & Technology
      return [
        {
          'passage': 'Although \'science\' and \'technology\' are often mentioned together, philosophers of technology generally distinguish them by their primary aims. Science is primarily oriented toward understanding: discovering and explaining how the natural world works, independent of any particular practical application. Technology is primarily oriented toward intervention: designing tools, systems, and processes that achieve some practical goal, often by applying scientific knowledge but sometimes developed through trial-and-error methods that precede any formal scientific explanation. The relationship runs in both directions — scientific discoveries often enable new technologies, but new technologies (such as more powerful telescopes or particle accelerators) frequently enable further scientific discovery, making science and technology mutually reinforcing rather than a simple one-way pipeline from theory to application.',
          'question': 'According to the passage, science is primarily oriented toward:',
          'options': ['understanding — discovering and explaining how the natural world works', 'generating profit for private companies', 'entertaining the general public', 'designing tools to achieve practical goals'],
          'correct': 0,
        },
        {
          'passage': 'Although \'science\' and \'technology\' are often mentioned together, philosophers of technology generally distinguish them by their primary aims. Science is primarily oriented toward understanding: discovering and explaining how the natural world works, independent of any particular practical application. Technology is primarily oriented toward intervention: designing tools, systems, and processes that achieve some practical goal, often by applying scientific knowledge but sometimes developed through trial-and-error methods that precede any formal scientific explanation. The relationship runs in both directions — scientific discoveries often enable new technologies, but new technologies (such as more powerful telescopes or particle accelerators) frequently enable further scientific discovery, making science and technology mutually reinforcing rather than a simple one-way pipeline from theory to application.',
          'question': 'According to the passage, technology is primarily oriented toward:',
          'options': ['intervention — designing tools, systems, and processes to achieve practical goals', 'proving mathematical theorems', 'explaining natural phenomena for its own sake', 'documenting historical events'],
          'correct': 0,
        },
        {
          'passage': 'Although \'science\' and \'technology\' are often mentioned together, philosophers of technology generally distinguish them by their primary aims. Science is primarily oriented toward understanding: discovering and explaining how the natural world works, independent of any particular practical application. Technology is primarily oriented toward intervention: designing tools, systems, and processes that achieve some practical goal, often by applying scientific knowledge but sometimes developed through trial-and-error methods that precede any formal scientific explanation. The relationship runs in both directions — scientific discoveries often enable new technologies, but new technologies (such as more powerful telescopes or particle accelerators) frequently enable further scientific discovery, making science and technology mutually reinforcing rather than a simple one-way pipeline from theory to application.',
          'question': 'According to the passage, can technology be developed without a prior formal scientific explanation?',
          'options': ['no, technology is identical to applied science in every case', 'yes, the passage says it can be developed through trial-and-error methods that precede formal explanation', 'no, technology always requires prior scientific theory', 'the passage does not address this question'],
          'correct': 1,
        },
        {
          'passage': 'Although \'science\' and \'technology\' are often mentioned together, philosophers of technology generally distinguish them by their primary aims. Science is primarily oriented toward understanding: discovering and explaining how the natural world works, independent of any particular practical application. Technology is primarily oriented toward intervention: designing tools, systems, and processes that achieve some practical goal, often by applying scientific knowledge but sometimes developed through trial-and-error methods that precede any formal scientific explanation. The relationship runs in both directions — scientific discoveries often enable new technologies, but new technologies (such as more powerful telescopes or particle accelerators) frequently enable further scientific discovery, making science and technology mutually reinforcing rather than a simple one-way pipeline from theory to application.',
          'question': 'According to the passage, how does the passage characterize the relationship between science and technology?',
          'options': ['completely unrelated to one another', 'entirely one-directional, from science to technology only', 'identical, with no meaningful distinction', 'mutually reinforcing, running in both directions, rather than a simple one-way pipeline Passage 2 The philosopher of technology Langdon Winner argued, in a widely discussed essay, that \'artifacts have politics\' — meaning that the design of a technology can embed and enforce particular social arrangements, sometimes deliberately and sometimes as an unintended consequence of design choices. Winner\'s most famous, though historically contested, example involved low-hanging highway overpasses built on Long Island, which he argued were designed low enough to prevent buses (and therefore many lower-income and minority residents who relied on public transit) from reaching certain parks and beaches easily accessible to car owners. Whether or not this specific historical claim is fully accurate, Winner\'s broader point — that technological designs are never entirely neutral with respect to social values and power — remains an influential idea in philosophy of technology.'],
          'correct': 3,
        },
        {
          'passage': 'The philosopher of technology Langdon Winner argued, in a widely discussed essay, that \'artifacts have politics\' — meaning that the design of a technology can embed and enforce particular social arrangements, sometimes deliberately and sometimes as an unintended consequence of design choices. Winner\'s most famous, though historically contested, example involved low-hanging highway overpasses built on Long Island, which he argued were designed low enough to prevent buses (and therefore many lower-income and minority residents who relied on public transit) from reaching certain parks and beaches easily accessible to car owners. Whether or not this specific historical claim is fully accurate, Winner\'s broader point — that technological designs are never entirely neutral with respect to social values and power — remains an influential idea in philosophy of technology.',
          'question': 'According to the passage, Langdon Winner argued that \'artifacts have politics,\' meaning:',
          'options': ['all technologies are designed with identical political goals', 'technology has no relationship to social values', 'only politicians are allowed to design technology', 'the design of a technology can embed and enforce particular social arrangements'],
          'correct': 3,
        },
        {
          'passage': 'The philosopher of technology Langdon Winner argued, in a widely discussed essay, that \'artifacts have politics\' — meaning that the design of a technology can embed and enforce particular social arrangements, sometimes deliberately and sometimes as an unintended consequence of design choices. Winner\'s most famous, though historically contested, example involved low-hanging highway overpasses built on Long Island, which he argued were designed low enough to prevent buses (and therefore many lower-income and minority residents who relied on public transit) from reaching certain parks and beaches easily accessible to car owners. Whether or not this specific historical claim is fully accurate, Winner\'s broader point — that technological designs are never entirely neutral with respect to social values and power — remains an influential idea in philosophy of technology.',
          'question': 'According to the passage, what is Winner\'s famous (though historically contested) example?',
          'options': ['the invention of the automobile itself', 'the development of the internet', 'the design of nuclear power plants', 'low-hanging highway overpasses on Long Island allegedly designed to block buses from certain parks and beaches'],
          'correct': 3,
        },
        {
          'passage': 'The philosopher of technology Langdon Winner argued, in a widely discussed essay, that \'artifacts have politics\' — meaning that the design of a technology can embed and enforce particular social arrangements, sometimes deliberately and sometimes as an unintended consequence of design choices. Winner\'s most famous, though historically contested, example involved low-hanging highway overpasses built on Long Island, which he argued were designed low enough to prevent buses (and therefore many lower-income and minority residents who relied on public transit) from reaching certain parks and beaches easily accessible to car owners. Whether or not this specific historical claim is fully accurate, Winner\'s broader point — that technological designs are never entirely neutral with respect to social values and power — remains an influential idea in philosophy of technology.',
          'question': 'According to the passage, who would have been prevented from easily reaching the parks and beaches, according to Winner\'s claim?',
          'options': ['only local government officials', 'tourists visiting from other countries', 'only wealthy car owners', 'lower-income and minority residents who relied on public transit'],
          'correct': 3,
        },
        {
          'passage': 'The philosopher of technology Langdon Winner argued, in a widely discussed essay, that \'artifacts have politics\' — meaning that the design of a technology can embed and enforce particular social arrangements, sometimes deliberately and sometimes as an unintended consequence of design choices. Winner\'s most famous, though historically contested, example involved low-hanging highway overpasses built on Long Island, which he argued were designed low enough to prevent buses (and therefore many lower-income and minority residents who relied on public transit) from reaching certain parks and beaches easily accessible to car owners. Whether or not this specific historical claim is fully accurate, Winner\'s broader point — that technological designs are never entirely neutral with respect to social values and power — remains an influential idea in philosophy of technology.',
          'question': 'According to the passage, what broader point does Winner\'s argument make, regardless of the specific historical accuracy of the overpass example?',
          'options': ['all technology is entirely neutral and apolitical', 'only government-built technology can be political', 'technological designs are never entirely neutral with respect to social values and power', 'politics has no influence on engineering decisions Passage 3 Technological determinism is the view that technology develops according to its own internal logic and, once developed, exerts a decisive, largely unavoidable influence on society and culture — as if technology were an independent force driving history, to which society mainly reacts and adapts. Critics of strong technological determinism point out that the same technology can be adopted, resisted, or adapted quite differently by different societies depending on existing cultural values, economic systems, and political institutions, suggesting that social factors shape technology\'s development and impact just as much as technology shapes society. A more moderate position, sometimes called \'social construction of technology,\' holds that both directions of influence matter: technology shapes society, but social choices — about funding, regulation, and use — also shape which technologies are developed and how they are ultimately used.'],
          'correct': 2,
        },
        {
          'passage': 'Technological determinism is the view that technology develops according to its own internal logic and, once developed, exerts a decisive, largely unavoidable influence on society and culture — as if technology were an independent force driving history, to which society mainly reacts and adapts. Critics of strong technological determinism point out that the same technology can be adopted, resisted, or adapted quite differently by different societies depending on existing cultural values, economic systems, and political institutions, suggesting that social factors shape technology\'s development and impact just as much as technology shapes society. A more moderate position, sometimes called \'social construction of technology,\' holds that both directions of influence matter: technology shapes society, but social choices — about funding, regulation, and use — also shape which technologies are developed and how they are ultimately used.',
          'question': 'According to the passage, technological determinism is the view that:',
          'options': ['only government regulation can shape technology', 'technology and society have no relationship to each other', 'technology develops according to its own internal logic and exerts a decisive influence on society', 'society entirely controls every aspect of technological development'],
          'correct': 2,
        },
        {
          'passage': 'Technological determinism is the view that technology develops according to its own internal logic and, once developed, exerts a decisive, largely unavoidable influence on society and culture — as if technology were an independent force driving history, to which society mainly reacts and adapts. Critics of strong technological determinism point out that the same technology can be adopted, resisted, or adapted quite differently by different societies depending on existing cultural values, economic systems, and political institutions, suggesting that social factors shape technology\'s development and impact just as much as technology shapes society. A more moderate position, sometimes called \'social construction of technology,\' holds that both directions of influence matter: technology shapes society, but social choices — about funding, regulation, and use — also shape which technologies are developed and how they are ultimately used.',
          'question': 'According to the passage, what do critics of strong technological determinism point out?',
          'options': ['technology always develops identically in every society', 'society has no influence on technology whatsoever', 'the same technology can be adopted, resisted, or adapted differently depending on cultural, economic, and political factors', 'technological change never varies across cultures'],
          'correct': 2,
        },
        {
          'passage': 'Technological determinism is the view that technology develops according to its own internal logic and, once developed, exerts a decisive, largely unavoidable influence on society and culture — as if technology were an independent force driving history, to which society mainly reacts and adapts. Critics of strong technological determinism point out that the same technology can be adopted, resisted, or adapted quite differently by different societies depending on existing cultural values, economic systems, and political institutions, suggesting that social factors shape technology\'s development and impact just as much as technology shapes society. A more moderate position, sometimes called \'social construction of technology,\' holds that both directions of influence matter: technology shapes society, but social choices — about funding, regulation, and use — also shape which technologies are developed and how they are ultimately used.',
          'question': 'According to the passage, what is the \'social construction of technology\' position?',
          'options': ['both technology shapes society and social choices shape technology\'s development and use', 'society is entirely constructed by technology alone', 'technology develops independently of any human input', 'technology has absolutely no influence on society'],
          'correct': 0,
        },
        {
          'passage': 'Technological determinism is the view that technology develops according to its own internal logic and, once developed, exerts a decisive, largely unavoidable influence on society and culture — as if technology were an independent force driving history, to which society mainly reacts and adapts. Critics of strong technological determinism point out that the same technology can be adopted, resisted, or adapted quite differently by different societies depending on existing cultural values, economic systems, and political institutions, suggesting that social factors shape technology\'s development and impact just as much as technology shapes society. A more moderate position, sometimes called \'social construction of technology,\' holds that both directions of influence matter: technology shapes society, but social choices — about funding, regulation, and use — also shape which technologies are developed and how they are ultimately used.',
          'question': 'According to the passage, what specific social choices are mentioned as shaping which technologies are developed?',
          'options': ['weather patterns and geography alone', 'funding, regulation, and use', 'ancient historical traditions exclusively', 'the personal preferences of individual inventors only Passage 4 The precautionary principle, frequently invoked in debates about new scientific and technological developments, holds that when an action or technology carries a risk of causing severe or irreversible harm, a lack of full scientific certainty about that harm should not be used as a reason to postpone protective measures. Proponents argue that waiting for complete scientific certainty before regulating a potentially dangerous new technology may mean acting only after serious, possibly irreversible, damage has already occurred. Critics counter that the precautionary principle, applied too broadly or without careful qualification, could be used to block beneficial innovations based on speculative or poorly substantiated fears, and that it offers little concrete guidance about how much caution is actually warranted in any specific case.'],
          'correct': 1,
        },
        {
          'passage': 'The precautionary principle, frequently invoked in debates about new scientific and technological developments, holds that when an action or technology carries a risk of causing severe or irreversible harm, a lack of full scientific certainty about that harm should not be used as a reason to postpone protective measures. Proponents argue that waiting for complete scientific certainty before regulating a potentially dangerous new technology may mean acting only after serious, possibly irreversible, damage has already occurred. Critics counter that the precautionary principle, applied too broadly or without careful qualification, could be used to block beneficial innovations based on speculative or poorly substantiated fears, and that it offers little concrete guidance about how much caution is actually warranted in any specific case.',
          'question': 'According to the passage, the precautionary principle holds that a lack of full scientific certainty about severe harm should:',
          'options': ['always be treated as proof that no harm exists', 'be used to permanently ban any new technology', 'not be used as a reason to postpone protective measures', 'only apply to already-regulated technologies'],
          'correct': 2,
        },
        {
          'passage': 'The precautionary principle, frequently invoked in debates about new scientific and technological developments, holds that when an action or technology carries a risk of causing severe or irreversible harm, a lack of full scientific certainty about that harm should not be used as a reason to postpone protective measures. Proponents argue that waiting for complete scientific certainty before regulating a potentially dangerous new technology may mean acting only after serious, possibly irreversible, damage has already occurred. Critics counter that the precautionary principle, applied too broadly or without careful qualification, could be used to block beneficial innovations based on speculative or poorly substantiated fears, and that it offers little concrete guidance about how much caution is actually warranted in any specific case.',
          'question': 'According to the passage, what do proponents of the precautionary principle argue about waiting for complete certainty?',
          'options': ['it may mean acting only after serious, possibly irreversible damage has already occurred', 'it always leads to better long-term outcomes', 'it guarantees that no harm will ever occur', 'it is required by international law in every case'],
          'correct': 0,
        },
        {
          'passage': 'The precautionary principle, frequently invoked in debates about new scientific and technological developments, holds that when an action or technology carries a risk of causing severe or irreversible harm, a lack of full scientific certainty about that harm should not be used as a reason to postpone protective measures. Proponents argue that waiting for complete scientific certainty before regulating a potentially dangerous new technology may mean acting only after serious, possibly irreversible, damage has already occurred. Critics counter that the precautionary principle, applied too broadly or without careful qualification, could be used to block beneficial innovations based on speculative or poorly substantiated fears, and that it offers little concrete guidance about how much caution is actually warranted in any specific case.',
          'question': 'According to the passage, what do critics argue about applying the precautionary principle too broadly?',
          'options': ['it guarantees the safety of all new technologies', 'it is identical to the falsifiability criterion', 'it could be used to block beneficial innovations based on speculative or poorly substantiated fears', 'it always leads to excessive scientific research'],
          'correct': 2,
        },
        {
          'passage': 'The precautionary principle, frequently invoked in debates about new scientific and technological developments, holds that when an action or technology carries a risk of causing severe or irreversible harm, a lack of full scientific certainty about that harm should not be used as a reason to postpone protective measures. Proponents argue that waiting for complete scientific certainty before regulating a potentially dangerous new technology may mean acting only after serious, possibly irreversible, damage has already occurred. Critics counter that the precautionary principle, applied too broadly or without careful qualification, could be used to block beneficial innovations based on speculative or poorly substantiated fears, and that it offers little concrete guidance about how much caution is actually warranted in any specific case.',
          'question': 'According to the passage, what specific criticism do critics raise about the principle\'s practical guidance?',
          'options': ['it has never been invoked in any real policy debate', 'it provides overly precise, mathematically exact guidance', 'it offers little concrete guidance about how much caution is actually warranted in any specific case', 'it applies only to nuclear technology Passage 5 The concept of \'technological determinism versus technological momentum,\' as developed by historian of technology Thomas Hughes, offers a more nuanced picture of how technologies become deeply embedded in society over time. Hughes argued that in the early stages of a technology\'s development, social, political, and economic factors have substantial influence over its design and direction. However, as a technological system matures and becomes integrated into infrastructure, institutions, professional expertise, and everyday habits, it develops \'momentum\' that makes it increasingly resistant to change or replacement, even when better alternatives become available — not because change is physically impossible, but because so much has become organized around the existing system that switching carries substantial social and economic cost.'],
          'correct': 2,
        },
        {
          'passage': 'The concept of \'technological determinism versus technological momentum,\' as developed by historian of technology Thomas Hughes, offers a more nuanced picture of how technologies become deeply embedded in society over time. Hughes argued that in the early stages of a technology\'s development, social, political, and economic factors have substantial influence over its design and direction. However, as a technological system matures and becomes integrated into infrastructure, institutions, professional expertise, and everyday habits, it develops \'momentum\' that makes it increasingly resistant to change or replacement, even when better alternatives become available — not because change is physically impossible, but because so much has become organized around the existing system that switching carries substantial social and economic cost.',
          'question': 'According to the passage, who developed the concept of technological momentum?',
          'options': ['philosopher Langdon Winner', 'historian Thomas Kuhn', 'historian of technology Thomas Hughes', 'philosopher Karl Popper'],
          'correct': 2,
        },
        {
          'passage': 'The concept of \'technological determinism versus technological momentum,\' as developed by historian of technology Thomas Hughes, offers a more nuanced picture of how technologies become deeply embedded in society over time. Hughes argued that in the early stages of a technology\'s development, social, political, and economic factors have substantial influence over its design and direction. However, as a technological system matures and becomes integrated into infrastructure, institutions, professional expertise, and everyday habits, it develops \'momentum\' that makes it increasingly resistant to change or replacement, even when better alternatives become available — not because change is physically impossible, but because so much has become organized around the existing system that switching carries substantial social and economic cost.',
          'question': 'According to the passage, in the early stages of a technology\'s development, what has substantial influence over its design?',
          'options': ['social, political, and economic factors', 'only the original inventor\'s personal preference', 'only the laws of physics', 'international treaties exclusively'],
          'correct': 0,
        },
        {
          'passage': 'The concept of \'technological determinism versus technological momentum,\' as developed by historian of technology Thomas Hughes, offers a more nuanced picture of how technologies become deeply embedded in society over time. Hughes argued that in the early stages of a technology\'s development, social, political, and economic factors have substantial influence over its design and direction. However, as a technological system matures and becomes integrated into infrastructure, institutions, professional expertise, and everyday habits, it develops \'momentum\' that makes it increasingly resistant to change or replacement, even when better alternatives become available — not because change is physically impossible, but because so much has become organized around the existing system that switching carries substantial social and economic cost.',
          'question': 'According to the passage, what happens as a technological system matures and becomes embedded in infrastructure and institutions?',
          'options': ['it develops \'momentum\' that makes it increasingly resistant to change or replacement', 'it becomes immediately and easily replaceable', 'it automatically becomes obsolete', 'it loses all connection to social and economic factors'],
          'correct': 0,
        },
        {
          'passage': 'The concept of \'technological determinism versus technological momentum,\' as developed by historian of technology Thomas Hughes, offers a more nuanced picture of how technologies become deeply embedded in society over time. Hughes argued that in the early stages of a technology\'s development, social, political, and economic factors have substantial influence over its design and direction. However, as a technological system matures and becomes integrated into infrastructure, institutions, professional expertise, and everyday habits, it develops \'momentum\' that makes it increasingly resistant to change or replacement, even when better alternatives become available — not because change is physically impossible, but because so much has become organized around the existing system that switching carries substantial social and economic cost.',
          'question': 'According to the passage, why does a mature technological system resist replacement, even when better alternatives exist?',
          'options': ['because governments always ban alternative technologies', 'because newer alternatives are always inferior in every respect', 'because so much has become organized around the existing system, making switching costly', 'because switching is always physically impossible'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'technological optimism\' as a general stance?',
          'options': ['the view that technological progress tends, on balance, to improve human life and solve pressing problems', 'the view that technology has no effect on society', 'the view identical to technological determinism', 'the view that all technology is inherently harmful'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'technological pessimism\' as a general stance?',
          'options': ['the view that technology always solves every problem it creates', 'the view identical to technological optimism', 'the view that technology should be studied only by engineers', 'the view that technological progress often creates significant new problems or risks that may outweigh its benefits'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'dual-use technology\'?',
          'options': ['a technology that requires two separate power sources', 'a technology that has been banned in every country', 'a technology invented independently by two separate scientists', 'a technology that can be used for both beneficial and harmful purposes, such as civilian and military applications'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the concept of an \'externality\' as discussed in relation to technology and its social costs?',
          'options': ['a benefit that only the technology\'s designer receives', 'an effect of a technology or activity that falls on parties who did not choose to bear it, such as pollution affecting a nearby community', 'a term used only in biology, never economics or technology policy', 'a cost that is always fully paid by the technology\'s user'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the \'digital divide\' as discussed in philosophy and policy of technology?',
          'options': ['unequal access to digital technology and the internet across different groups or regions', 'a synonym for planned obsolescence', 'a division between two competing software companies', 'a technical term for the binary code used in computers'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'planned obsolescence\' as a design strategy?',
          'options': ['a strategy used only in the software industry, never manufacturing', 'a synonym for the precautionary principle', 'designing a product to last as long as technically possible', 'deliberately designing a product with a limited useful lifespan to encourage repeat purchases'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the relationship between basic and applied science, as commonly discussed alongside science and technology?',
          'options': ['basic science pursues understanding for its own sake, while applied science aims more directly at solving practical problems, though the two often inform each other', 'they are exactly the same activity with no distinction', 'basic science always leads directly and immediately to applied science', 'applied science never depends on any basic scientific research'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the \'appropriate technology\' movement?',
          'options': ['a movement insisting only the most advanced technology is ever appropriate', 'an approach favoring technologies suited to the specific social, economic, and environmental context of the community using them, often smaller-scale and locally maintainable', 'a synonym for planned obsolescence', 'a movement rejecting the use of any modern technology whatsoever'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why philosophers of technology are interested in the design process itself, not just the finished technology?',
          'options': ['because design is purely a technical, value-neutral process with no philosophical content', 'because only the finished product matters philosophically', 'because values and assumptions embedded during design can shape a technology\'s later social effects, sometimes unintentionally', 'because design has no bearing on how a technology is eventually used'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the concern some philosophers raise about the pace of technological change outstripping ethical and regulatory frameworks?',
          'options': ['this concern applies only to technologies developed before the 20th century', 'technological change has remained constant throughout human history', 'ethical and regulatory frameworks always develop faster than any new technology', 'new technologies can be deployed faster than society can develop adequate ethical guidelines or regulations to govern them'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'technological convergence\'?',
          'options': ['the process by which two competing companies merge into one corporation', 'the tendency of previously distinct technologies to merge into a single device or system, such as a smartphone combining a camera, phone, and computer', 'a term describing when a technology becomes obsolete', 'a synonym for the digital divide'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why the relationship between science, technology, and society is often studied as a single interconnected field (sometimes called STS)?',
          'options': ['because scientific knowledge, technological development, and social factors continuously influence one another in complex ways', 'because STS is concerned exclusively with government policy, not philosophy', 'because this field studies only the history of ancient technology', 'because science, technology, and society have no meaningful relationship worth studying'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes a \'sociotechnical system\'?',
          'options': ['a purely technical system with no human involvement at all', 'a synonym for a single stand-alone machine', 'a system in which technical components and social elements, such as institutions, users, and norms, are interdependent and jointly shape outcomes', 'a purely social institution with no technical components'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best captures a central concern of the philosophy of engineering, as distinct from philosophy of science?',
          'options': ['translating ancient philosophical texts', 'documenting the biographies of famous scientists', 'proving abstract mathematical theorems with no practical application', 'the ethical and epistemic dimensions of designing and building functional artifacts under real-world constraints'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes why some philosophers argue that technology is never truly \'neutral\'?',
          'options': ['because neutrality is a purely mathematical concept', 'because all technologies are identical in function', 'because design choices reflect particular values, priorities, and assumptions that shape how a technology can be used', 'because every technology is illegal in some country'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the \'instrumental\' view of technology, one of the oldest and most common views in philosophy of technology?',
          'options': ['the view that technology is always harmful regardless of use', 'the view that technology cannot be studied philosophically at all', 'the view that technology itself possesses moral agency independent of any user', 'the view that technology is a neutral tool, and its moral value depends entirely on how humans choose to use it'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a criticism of the purely instrumental view of technology?',
          'options': ['it is universally accepted with no significant critics', 'it may overlook how technological design itself can shape human behavior and social arrangements, not merely serve pre-existing human goals', 'it correctly captures every aspect of how technology functions in society', 'it proves that technology can never be misused'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'technological unemployment\' as discussed in philosophy and economics of technology?',
          'options': ['job losses that occur when automation or new technology replaces tasks previously performed by human workers', 'unemployment caused exclusively by government regulation', 'a synonym for the digital divide', 'a term for workers who voluntarily choose not to use new technology'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes why interdisciplinary collaboration between philosophers and scientists/engineers is often recommended when developing significant new technologies?',
          'options': ['philosophers are better qualified than engineers to build technical systems', 'philosophical analysis can help identify ethical, social, and conceptual issues that purely technical expertise might overlook', 'philosophy and engineering address entirely unrelated questions', 'engineers have no need to consider ethical or social questions'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'infrastructure\' in the sociotechnical sense discussed by historians and philosophers of technology?',
          'options': ['a synonym for a single stand-alone consumer device', 'a purely legal term with no technical meaning', 'the interconnected physical and organizational systems, such as power grids or transportation networks, that support and are shaped by other technologies and social practices', 'a term used exclusively in ancient history'],
          'correct': 2,
        },
      ];
    case 'gns106_u4_3': // Technology & Culture
      return [
        {
          'passage': 'The philosopher Marshall McLuhan argued that \'the medium is the message,\' meaning that the particular form or channel through which information is communicated shapes human thought and social organization at least as much as the specific content it carries. On McLuhan\'s view, focusing only on the content of, say, television programming, while ignoring how the medium of television itself reorganizes attention, social habits, and even family life, misses the more significant cultural impact. McLuhan applied this idea across history, arguing that earlier shifts — from oral culture to written text, and from handwritten manuscripts to the mechanically printed book — had reshaped human cognition and social structure in ways every bit as profound as any particular story or idea those media happened to convey.',
          'question': 'According to the passage, McLuhan\'s phrase \'the medium is the message\' means:',
          'options': ['only the content of a message matters, never its form', 'all media produce identical social effects', 'the form or channel of communication shapes thought and society at least as much as its specific content', 'media has no effect on human thought'],
          'correct': 2,
        },
        {
          'passage': 'The philosopher Marshall McLuhan argued that \'the medium is the message,\' meaning that the particular form or channel through which information is communicated shapes human thought and social organization at least as much as the specific content it carries. On McLuhan\'s view, focusing only on the content of, say, television programming, while ignoring how the medium of television itself reorganizes attention, social habits, and even family life, misses the more significant cultural impact. McLuhan applied this idea across history, arguing that earlier shifts — from oral culture to written text, and from handwritten manuscripts to the mechanically printed book — had reshaped human cognition and social structure in ways every bit as profound as any particular story or idea those media happened to convey.',
          'question': 'According to the passage, what does McLuhan think is missed by focusing only on television content?',
          'options': ['the profitability of television networks', 'how the medium of television itself reorganizes attention, social habits, and family life', 'the technical specifications of television hardware', 'the specific actors appearing in a program'],
          'correct': 1,
        },
        {
          'passage': 'The philosopher Marshall McLuhan argued that \'the medium is the message,\' meaning that the particular form or channel through which information is communicated shapes human thought and social organization at least as much as the specific content it carries. On McLuhan\'s view, focusing only on the content of, say, television programming, while ignoring how the medium of television itself reorganizes attention, social habits, and even family life, misses the more significant cultural impact. McLuhan applied this idea across history, arguing that earlier shifts — from oral culture to written text, and from handwritten manuscripts to the mechanically printed book — had reshaped human cognition and social structure in ways every bit as profound as any particular story or idea those media happened to convey.',
          'question': 'According to the passage, what historical shifts does McLuhan cite as examples of a medium reshaping cognition and society?',
          'options': ['the shift from oral culture to written text, and from manuscripts to the printed book', 'the invention of the telephone and the radio', 'the development of the internet', 'the rise of social media platforms'],
          'correct': 0,
        },
        {
          'passage': 'The philosopher Marshall McLuhan argued that \'the medium is the message,\' meaning that the particular form or channel through which information is communicated shapes human thought and social organization at least as much as the specific content it carries. On McLuhan\'s view, focusing only on the content of, say, television programming, while ignoring how the medium of television itself reorganizes attention, social habits, and even family life, misses the more significant cultural impact. McLuhan applied this idea across history, arguing that earlier shifts — from oral culture to written text, and from handwritten manuscripts to the mechanically printed book — had reshaped human cognition and social structure in ways every bit as profound as any particular story or idea those media happened to convey.',
          'question': 'According to the passage, how significant does McLuhan consider these historical media shifts, compared to the specific ideas conveyed?',
          'options': ['every bit as profound as any particular story or idea those media happened to convey', 'far less significant than any specific content', 'completely unrelated to cognition or social structure', 'only relevant to entertainment, not serious ideas Passage 2 Cultural critics have long debated whether new communication technologies tend to bring people closer together or drive them further apart. Optimists point to the way technologies such as video calling or social media allow people to maintain relationships across vast distances that would once have been severed by geography, and to form new communities around shared interests that might never have found each other otherwise. Skeptics counter that mediated communication may substitute for, rather than supplement, deeper forms of in-person connection, and that algorithmically curated social platforms may encourage superficial engagement or contribute to social fragmentation by sorting people into isolated groups that rarely encounter genuinely differing perspectives. Most contemporary researchers caution against sweeping generalizations, noting that the effects likely depend heavily on how, and how much, a given technology is used.'],
          'correct': 0,
        },
        {
          'passage': 'Cultural critics have long debated whether new communication technologies tend to bring people closer together or drive them further apart. Optimists point to the way technologies such as video calling or social media allow people to maintain relationships across vast distances that would once have been severed by geography, and to form new communities around shared interests that might never have found each other otherwise. Skeptics counter that mediated communication may substitute for, rather than supplement, deeper forms of in-person connection, and that algorithmically curated social platforms may encourage superficial engagement or contribute to social fragmentation by sorting people into isolated groups that rarely encounter genuinely differing perspectives. Most contemporary researchers caution against sweeping generalizations, noting that the effects likely depend heavily on how, and how much, a given technology is used.',
          'question': 'According to the passage, what do optimists point to regarding new communication technologies?',
          'options': ['their exclusive use by younger generations', 'their ability to maintain relationships across distance and form new communities around shared interests', 'their guaranteed ability to eliminate loneliness', 'their tendency to always replace in-person connection entirely'],
          'correct': 1,
        },
        {
          'passage': 'Cultural critics have long debated whether new communication technologies tend to bring people closer together or drive them further apart. Optimists point to the way technologies such as video calling or social media allow people to maintain relationships across vast distances that would once have been severed by geography, and to form new communities around shared interests that might never have found each other otherwise. Skeptics counter that mediated communication may substitute for, rather than supplement, deeper forms of in-person connection, and that algorithmically curated social platforms may encourage superficial engagement or contribute to social fragmentation by sorting people into isolated groups that rarely encounter genuinely differing perspectives. Most contemporary researchers caution against sweeping generalizations, noting that the effects likely depend heavily on how, and how much, a given technology is used.',
          'question': 'According to the passage, what do skeptics counter regarding mediated communication?',
          'options': ['it always strengthens in-person relationships', 'it may substitute for, rather than supplement, deeper forms of in-person connection', 'it exclusively benefits elderly users', 'it has no effect on social connection whatsoever'],
          'correct': 1,
        },
        {
          'passage': 'Cultural critics have long debated whether new communication technologies tend to bring people closer together or drive them further apart. Optimists point to the way technologies such as video calling or social media allow people to maintain relationships across vast distances that would once have been severed by geography, and to form new communities around shared interests that might never have found each other otherwise. Skeptics counter that mediated communication may substitute for, rather than supplement, deeper forms of in-person connection, and that algorithmically curated social platforms may encourage superficial engagement or contribute to social fragmentation by sorting people into isolated groups that rarely encounter genuinely differing perspectives. Most contemporary researchers caution against sweeping generalizations, noting that the effects likely depend heavily on how, and how much, a given technology is used.',
          'question': 'According to the passage, what specific concern do skeptics raise about algorithmically curated platforms?',
          'options': ['they are used exclusively for professional networking', 'they eliminate the possibility of forming any online community', 'they may encourage superficial engagement or contribute to social fragmentation by isolating groups', 'they always present a perfectly balanced range of viewpoints'],
          'correct': 2,
        },
        {
          'passage': 'Cultural critics have long debated whether new communication technologies tend to bring people closer together or drive them further apart. Optimists point to the way technologies such as video calling or social media allow people to maintain relationships across vast distances that would once have been severed by geography, and to form new communities around shared interests that might never have found each other otherwise. Skeptics counter that mediated communication may substitute for, rather than supplement, deeper forms of in-person connection, and that algorithmically curated social platforms may encourage superficial engagement or contribute to social fragmentation by sorting people into isolated groups that rarely encounter genuinely differing perspectives. Most contemporary researchers caution against sweeping generalizations, noting that the effects likely depend heavily on how, and how much, a given technology is used.',
          'question': 'According to the passage, what caution do most contemporary researchers offer?',
          'options': ['that only older technologies deserve careful study', 'against sweeping generalizations, since effects likely depend on how and how much a technology is used', 'that all technology use is equally harmful', 'that technology use has no measurable effects at all Passage 3 The concept of \'technological embeddedness\' refers to the way that certain technologies become so deeply woven into the fabric of everyday cultural life that they become nearly invisible as technologies at all, taken for granted in the same way as more traditional cultural fixtures. Writing itself is a striking historical example: societies with long-established writing systems rarely experience writing as a novel or disruptive \'technology,\' even though, when it was first introduced, it dramatically altered how information was stored, transmitted, and even how people thought about memory and truth. This suggests that public anxiety about the disruptive cultural effects of a new technology often diminishes over time, not necessarily because the technology\'s effects become less significant, but because the technology becomes normalized as an ordinary, background feature of life.'],
          'correct': 1,
        },
        {
          'passage': 'The concept of \'technological embeddedness\' refers to the way that certain technologies become so deeply woven into the fabric of everyday cultural life that they become nearly invisible as technologies at all, taken for granted in the same way as more traditional cultural fixtures. Writing itself is a striking historical example: societies with long-established writing systems rarely experience writing as a novel or disruptive \'technology,\' even though, when it was first introduced, it dramatically altered how information was stored, transmitted, and even how people thought about memory and truth. This suggests that public anxiety about the disruptive cultural effects of a new technology often diminishes over time, not necessarily because the technology\'s effects become less significant, but because the technology becomes normalized as an ordinary, background feature of life.',
          'question': 'According to the passage, \'technological embeddedness\' refers to:',
          'options': ['the way certain technologies become so woven into daily life that they become nearly invisible as technologies', 'a term for technologies that fail and are abandoned', 'the process of banning a harmful technology', 'a term used only for medical technologies'],
          'correct': 0,
        },
        {
          'passage': 'The concept of \'technological embeddedness\' refers to the way that certain technologies become so deeply woven into the fabric of everyday cultural life that they become nearly invisible as technologies at all, taken for granted in the same way as more traditional cultural fixtures. Writing itself is a striking historical example: societies with long-established writing systems rarely experience writing as a novel or disruptive \'technology,\' even though, when it was first introduced, it dramatically altered how information was stored, transmitted, and even how people thought about memory and truth. This suggests that public anxiety about the disruptive cultural effects of a new technology often diminishes over time, not necessarily because the technology\'s effects become less significant, but because the technology becomes normalized as an ordinary, background feature of life.',
          'question': 'According to the passage, what historical example illustrates technological embeddedness?',
          'options': ['the invention of the smartphone', 'the invention of the automobile', 'writing itself, which is no longer experienced as a novel or disruptive technology', 'the introduction of social media'],
          'correct': 2,
        },
        {
          'passage': 'The concept of \'technological embeddedness\' refers to the way that certain technologies become so deeply woven into the fabric of everyday cultural life that they become nearly invisible as technologies at all, taken for granted in the same way as more traditional cultural fixtures. Writing itself is a striking historical example: societies with long-established writing systems rarely experience writing as a novel or disruptive \'technology,\' even though, when it was first introduced, it dramatically altered how information was stored, transmitted, and even how people thought about memory and truth. This suggests that public anxiety about the disruptive cultural effects of a new technology often diminishes over time, not necessarily because the technology\'s effects become less significant, but because the technology becomes normalized as an ordinary, background feature of life.',
          'question': 'According to the passage, when writing was first introduced, what did it dramatically alter?',
          'options': ['only religious practices', 'how information was stored, transmitted, and how people thought about memory and truth', 'only the speed of travel', 'only the price of paper'],
          'correct': 1,
        },
        {
          'passage': 'The concept of \'technological embeddedness\' refers to the way that certain technologies become so deeply woven into the fabric of everyday cultural life that they become nearly invisible as technologies at all, taken for granted in the same way as more traditional cultural fixtures. Writing itself is a striking historical example: societies with long-established writing systems rarely experience writing as a novel or disruptive \'technology,\' even though, when it was first introduced, it dramatically altered how information was stored, transmitted, and even how people thought about memory and truth. This suggests that public anxiety about the disruptive cultural effects of a new technology often diminishes over time, not necessarily because the technology\'s effects become less significant, but because the technology becomes normalized as an ordinary, background feature of life.',
          'question': 'According to the passage, why does public anxiety about a new technology\'s disruptive effects often diminish over time?',
          'options': ['the technology\'s actual effects always become genuinely less significant over time', 'people become less intelligent over time and stop noticing', 'the technology becomes normalized as an ordinary, background feature of life, not necessarily because its effects lessen', 'governments always ban technologies that cause anxiety Passage 4 Cultural globalization, often accelerated by communication and transportation technologies, has sparked debate about whether increased global cultural exchange tends to produce homogenization — a flattening of distinct local cultures into a more uniform global culture, often criticized as reflecting the dominance of a small number of powerful media-producing nations — or whether it produces hybridization, in which global cultural elements are actively adapted, reinterpreted, and blended with local traditions to create new, genuinely distinctive cultural forms. Evidence can be found for both processes occurring simultaneously: certain products and platforms do achieve broad global uniformity, while in other cases, local communities visibly transform imported cultural elements into something substantially new, suggesting that cultural globalization is neither simply erasing local difference nor leaving it completely unaffected.'],
          'correct': 2,
        },
        {
          'passage': 'Cultural globalization, often accelerated by communication and transportation technologies, has sparked debate about whether increased global cultural exchange tends to produce homogenization — a flattening of distinct local cultures into a more uniform global culture, often criticized as reflecting the dominance of a small number of powerful media-producing nations — or whether it produces hybridization, in which global cultural elements are actively adapted, reinterpreted, and blended with local traditions to create new, genuinely distinctive cultural forms. Evidence can be found for both processes occurring simultaneously: certain products and platforms do achieve broad global uniformity, while in other cases, local communities visibly transform imported cultural elements into something substantially new, suggesting that cultural globalization is neither simply erasing local difference nor leaving it completely unaffected.',
          'question': 'According to the passage, cultural homogenization refers to:',
          'options': ['the creation of entirely new local traditions with no external influence', 'a flattening of distinct local cultures into a more uniform global culture', 'the complete isolation of every culture from external contact', 'a term unrelated to globalization'],
          'correct': 1,
        },
        {
          'passage': 'Cultural globalization, often accelerated by communication and transportation technologies, has sparked debate about whether increased global cultural exchange tends to produce homogenization — a flattening of distinct local cultures into a more uniform global culture, often criticized as reflecting the dominance of a small number of powerful media-producing nations — or whether it produces hybridization, in which global cultural elements are actively adapted, reinterpreted, and blended with local traditions to create new, genuinely distinctive cultural forms. Evidence can be found for both processes occurring simultaneously: certain products and platforms do achieve broad global uniformity, while in other cases, local communities visibly transform imported cultural elements into something substantially new, suggesting that cultural globalization is neither simply erasing local difference nor leaving it completely unaffected.',
          'question': 'According to the passage, cultural hybridization refers to:',
          'options': ['the total elimination of all local cultural traditions', 'global cultural elements being adapted, reinterpreted, and blended with local traditions to create new forms', 'a phenomenon that occurs only in ancient history', 'a process identical to homogenization'],
          'correct': 1,
        },
        {
          'passage': 'Cultural globalization, often accelerated by communication and transportation technologies, has sparked debate about whether increased global cultural exchange tends to produce homogenization — a flattening of distinct local cultures into a more uniform global culture, often criticized as reflecting the dominance of a small number of powerful media-producing nations — or whether it produces hybridization, in which global cultural elements are actively adapted, reinterpreted, and blended with local traditions to create new, genuinely distinctive cultural forms. Evidence can be found for both processes occurring simultaneously: certain products and platforms do achieve broad global uniformity, while in other cases, local communities visibly transform imported cultural elements into something substantially new, suggesting that cultural globalization is neither simply erasing local difference nor leaving it completely unaffected.',
          'question': 'According to the passage, is homogenization sometimes criticized as reflecting the dominance of certain nations?',
          'options': ['no, the passage says homogenization is never criticized', 'no, the passage says only hybridization is criticized', 'yes, the passage says it is often criticized in this way', 'the passage does not address this question'],
          'correct': 2,
        },
        {
          'passage': 'Cultural globalization, often accelerated by communication and transportation technologies, has sparked debate about whether increased global cultural exchange tends to produce homogenization — a flattening of distinct local cultures into a more uniform global culture, often criticized as reflecting the dominance of a small number of powerful media-producing nations — or whether it produces hybridization, in which global cultural elements are actively adapted, reinterpreted, and blended with local traditions to create new, genuinely distinctive cultural forms. Evidence can be found for both processes occurring simultaneously: certain products and platforms do achieve broad global uniformity, while in other cases, local communities visibly transform imported cultural elements into something substantially new, suggesting that cultural globalization is neither simply erasing local difference nor leaving it completely unaffected.',
          'question': 'According to the passage, what does the passage conclude about the relationship between homogenization and hybridization?',
          'options': ['only hybridization actually occurs in the real world', 'evidence suggests both processes occur simultaneously, so globalization neither simply erases nor leaves local culture unaffected', 'globalization has no relationship to either process', 'only homogenization actually occurs in the real world Passage 5 Some cultural critics have raised concerns about the \'attention economy,\' a term describing how many digital platforms are designed to compete for, capture, and hold user attention, often because user engagement time can be converted into advertising revenue. Critics argue that design techniques such as infinite scrolling, autoplay, and algorithmically personalized recommendation feeds are engineered, drawing on principles from behavioral psychology, to maximize time spent on a platform, sometimes in ways that work against users\' own stated intentions or long-term well-being. Defenders of these platforms respond that users retain the freedom to disengage, that engagement often reflects genuine value being delivered, and that similar techniques for capturing attention have existed in earlier media, such as serialized fiction or cliffhanger radio dramas, long before digital technology.'],
          'correct': 1,
        },
        {
          'passage': 'Some cultural critics have raised concerns about the \'attention economy,\' a term describing how many digital platforms are designed to compete for, capture, and hold user attention, often because user engagement time can be converted into advertising revenue. Critics argue that design techniques such as infinite scrolling, autoplay, and algorithmically personalized recommendation feeds are engineered, drawing on principles from behavioral psychology, to maximize time spent on a platform, sometimes in ways that work against users\' own stated intentions or long-term well-being. Defenders of these platforms respond that users retain the freedom to disengage, that engagement often reflects genuine value being delivered, and that similar techniques for capturing attention have existed in earlier media, such as serialized fiction or cliffhanger radio dramas, long before digital technology.',
          'question': 'According to the passage, the \'attention economy\' describes how digital platforms are designed to:',
          'options': ['compete for, capture, and hold user attention, often to convert engagement time into advertising revenue', 'provide the most factually accurate information possible', 'operate without any commercial incentive', 'minimize the amount of time users spend on the platform'],
          'correct': 0,
        },
        {
          'passage': 'Some cultural critics have raised concerns about the \'attention economy,\' a term describing how many digital platforms are designed to compete for, capture, and hold user attention, often because user engagement time can be converted into advertising revenue. Critics argue that design techniques such as infinite scrolling, autoplay, and algorithmically personalized recommendation feeds are engineered, drawing on principles from behavioral psychology, to maximize time spent on a platform, sometimes in ways that work against users\' own stated intentions or long-term well-being. Defenders of these platforms respond that users retain the freedom to disengage, that engagement often reflects genuine value being delivered, and that similar techniques for capturing attention have existed in earlier media, such as serialized fiction or cliffhanger radio dramas, long before digital technology.',
          'question': 'According to the passage, which design techniques do critics cite as examples of capturing attention?',
          'options': ['strict daily time limits enforced by the platform', 'mandatory breaks between sessions', 'infinite scrolling, autoplay, and algorithmically personalized recommendation feeds', 'random removal of user-generated content'],
          'correct': 2,
        },
        {
          'passage': 'Some cultural critics have raised concerns about the \'attention economy,\' a term describing how many digital platforms are designed to compete for, capture, and hold user attention, often because user engagement time can be converted into advertising revenue. Critics argue that design techniques such as infinite scrolling, autoplay, and algorithmically personalized recommendation feeds are engineered, drawing on principles from behavioral psychology, to maximize time spent on a platform, sometimes in ways that work against users\' own stated intentions or long-term well-being. Defenders of these platforms respond that users retain the freedom to disengage, that engagement often reflects genuine value being delivered, and that similar techniques for capturing attention have existed in earlier media, such as serialized fiction or cliffhanger radio dramas, long before digital technology.',
          'question': 'According to the passage, on what do critics say these design techniques draw?',
          'options': ['principles from ancient philosophy exclusively', 'principles from behavioral psychology', 'principles from mathematics alone', 'principles unrelated to human behavior'],
          'correct': 1,
        },
        {
          'passage': 'Some cultural critics have raised concerns about the \'attention economy,\' a term describing how many digital platforms are designed to compete for, capture, and hold user attention, often because user engagement time can be converted into advertising revenue. Critics argue that design techniques such as infinite scrolling, autoplay, and algorithmically personalized recommendation feeds are engineered, drawing on principles from behavioral psychology, to maximize time spent on a platform, sometimes in ways that work against users\' own stated intentions or long-term well-being. Defenders of these platforms respond that users retain the freedom to disengage, that engagement often reflects genuine value being delivered, and that similar techniques for capturing attention have existed in earlier media, such as serialized fiction or cliffhanger radio dramas, long before digital technology.',
          'question': 'According to the passage, what do defenders of these platforms argue in response?',
          'options': ['users retain freedom to disengage, engagement often reflects genuine value, and similar techniques predate digital technology', 'that no earlier media ever used similar attention-capturing techniques', 'that engagement never reflects any genuine value to users', 'that users have no freedom to disengage from any platform'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'media ecology,\' a field of study associated with Marshall McLuhan and Neil Postman?',
          'options': ['a synonym for social media marketing', 'the study of the environmental impact of manufacturing electronics', 'a branch of biology studying media consumption in animals', 'the study of how communication media shape human perception, thought, and social organization'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes Neil Postman\'s concern in works such as Amusing Ourselves to Death?',
          'options': ['that television improved the seriousness of political debate', 'that entertainment-oriented media can reshape public discourse toward triviality, even on serious subjects like politics and news', 'that all media technologies are equally beneficial to public discourse', 'that print media has no cultural influence at all'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'cultural lag,\' a concept in the sociology of technology?',
          'options': ['a synonym for planned obsolescence', 'a term describing outdated technology that has been fully replaced', 'the time it takes to manufacture a new technological device', 'a delay between the introduction of a new technology and the corresponding adaptation of social norms, institutions, or values'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'algorithmic bias\' as discussed in relation to technology and culture?',
          'options': ['systematic and unfair skew in an algorithm\'s outputs, often reflecting biases present in its training data or design choices', 'a synonym for a computer programming error unrelated to fairness', 'a phenomenon that only affects search engines, never other software', 'a term for any algorithm that produces unexpected results'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the concern some scholars raise about \'filter bubbles\' in the context of technology and culture?',
          'options': ['personalized algorithms always expose users to a wider range of views than before', 'personalization has no effect on the range of content users see', 'personalized content algorithms may narrow the range of perspectives a user encounters, reinforcing existing views', 'filter bubbles are a term used only in weather forecasting'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'techno-utopianism\' as a cultural attitude?',
          'options': ['the belief that technological progress will largely solve major social and human problems', 'the belief that technology inevitably causes societal collapse', 'a term describing opposition to all new technology', 'a synonym for the precautionary principle'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'digital literacy\' as a cultural and educational concern?',
          'options': ['the ability to write computer code fluently in multiple languages', 'a term describing fluency in a spoken language only', 'the set of skills needed to effectively, critically, and safely use digital technologies and evaluate online information', 'a legal requirement to own a certain number of devices'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the cultural significance of the printing press, as commonly discussed in philosophy and history of technology?',
          'options': ['it primarily affected agriculture rather than communication', 'it was invented after the widespread adoption of television', 'it had a negligible cultural impact compared to earlier technologies', 'it dramatically increased the availability and standardization of written texts, contributing to widespread literacy and the spread of new ideas'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'cultural appropriation\' as discussed in debates intersecting technology, media, and culture?',
          'options': ['a synonym for cultural hybridization with no distinct meaning', 'a concept unrelated to questions of culture and power', 'the adoption of elements from one culture by members of another, often raising concerns about respect, context, and power dynamics', 'a purely legal term with a single universally agreed definition'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why some cultural critics are concerned about the loss of \'oral tradition\' skills in increasingly literate and digital societies?',
          'options': ['oral tradition skills have already been fully preserved everywhere', 'oral tradition has no cultural value worth preserving', 'certain cognitive and social practices historically supported by oral memory and storytelling may diminish as reliance on written and digital records increases', 'written and digital records have identical cognitive effects to oral tradition'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'participatory culture,\' a term used to describe certain effects of digital media?',
          'options': ['a term describing traditional, one-way broadcast television exclusively', 'a synonym for the digital divide', 'a culture in which only professional media companies are permitted to create content', 'a cultural mode in which audiences actively create, remix, and share content rather than only passively consuming media produced by a small number of institutions'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best captures a balanced philosophical view on the cultural effects of new technology, as often expressed in the field?',
          'options': ['all new technologies are unambiguously beneficial for culture', 'cultural effects of technology are impossible to study in any way', 'all new technologies are unambiguously harmful for culture', 'new technologies typically bring a complex mix of benefits and costs that vary by context, rather than being uniformly good or bad'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes why cross-cultural comparison is valuable when studying the cultural effects of a given technology?',
          'options': ['a given technology always produces identical effects in every culture', 'cross-cultural comparison is irrelevant to understanding technology\'s effects', 'the same technology can have different effects depending on the existing cultural, economic, and institutional context into which it is introduced', 'only Western cultures are worth studying in relation to technology'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the concern some scholars raise about the \'always-on\' nature of many modern digital technologies?',
          'options': ['always-on technology has been definitively proven to have no psychological effects', 'constant connectivity may blur boundaries between work and leisure, and reduce opportunities for uninterrupted attention or rest', 'modern digital technologies are never used outside of working hours', 'this concern applies only to landline telephones'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes a key reason philosophers study \'technology and culture\' as an interconnected topic, rather than treating technology as a purely technical matter?',
          'options': ['culture is entirely determined by technology with no other influence', 'this interconnection is only relevant to anthropologists, never philosophers', 'technologies are developed, adopted, and used within cultural contexts that shape their meaning and consequences, and vice versa', 'technology has no relevant connection to culture in any respect'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'hyperreality,\' a concept associated with the theorist Jean Baudrillard?',
          'options': ['a condition in which mediated representations and simulations become so pervasive that the distinction between the representation and \'real\' reality becomes blurred', 'a term used exclusively in mathematics', 'a term for extremely high-resolution photography', 'a synonym for cultural hybridization'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes why some scholars distinguish between \'access\' to technology and genuine \'digital inclusion\'?',
          'options': ['having a device or internet connection does not by itself guarantee the skills, affordability, or supportive context needed to use technology effectively', 'digital inclusion requires no internet access at all', 'this distinction is irrelevant to the digital divide', 'access and inclusion are exactly identical concepts with no distinction'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'meme culture\' as studied in relation to technology and culture?',
          'options': ['a phenomenon unrelated to digital communication technology', 'a term describing only biological genetic inheritance', 'the rapid creation, imitation, and transformation of shared cultural content, often humorous, spread through digital networks', 'a synonym for planned obsolescence'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why some cultural critics compare current debates about social media to earlier moral panics about technologies like the novel, radio, or comic books?',
          'options': ['no historical parallels exist between social media and earlier communication technologies', 'earlier moral panics about media were always completely correct in every respect', 'earlier moral panics about media never contained any valid concerns', 'history shows recurring patterns of public anxiety about new media, some of which later proved overstated and some of which reflected genuine concerns'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'remediation,\' a concept discussed by media theorists Jay David Bolter and Richard Grusin?',
          'options': ['a term describing the disposal of electronic waste', 'the way new media forms often incorporate, reference, or refashion the content and formats of earlier media', 'a synonym for technological determinism', 'a legal process for correcting a broken technology contract'],
          'correct': 1,
        },
      ];
    case 'gns106_u5_1': // Ethics Overview
      return [
        {
          'passage': 'Ethics, broadly, is the branch of philosophy concerned with questions of right and wrong conduct, and with what makes a life good. It is useful to distinguish ethics from related but different notions. Morality is often used to refer to the actual norms, values, and practices a person or culture holds regarding right and wrong, while ethics can refer more specifically to the systematic, philosophical study and justification of those norms. Ethics is also distinct from law: an action can be legal but widely regarded as unethical (such as certain forms of exploitative but technically legal business practice), and an action can be illegal in a given jurisdiction while still being considered, by many, morally justified or even required, such as certain acts of civil disobedience.',
          'question': 'According to the passage, ethics is broadly concerned with:',
          'options': ['only questions about legal systems', 'only questions about religious doctrine', 'only questions about economic efficiency', 'questions of right and wrong conduct and what makes a life good'],
          'correct': 3,
        },
        {
          'passage': 'Ethics, broadly, is the branch of philosophy concerned with questions of right and wrong conduct, and with what makes a life good. It is useful to distinguish ethics from related but different notions. Morality is often used to refer to the actual norms, values, and practices a person or culture holds regarding right and wrong, while ethics can refer more specifically to the systematic, philosophical study and justification of those norms. Ethics is also distinct from law: an action can be legal but widely regarded as unethical (such as certain forms of exploitative but technically legal business practice), and an action can be illegal in a given jurisdiction while still being considered, by many, morally justified or even required, such as certain acts of civil disobedience.',
          'question': 'According to the passage, how does the passage distinguish \'morality\' from \'ethics\'?',
          'options': ['they are described as being exactly identical, with no distinction', 'ethics refers only to legal systems, while morality is philosophical', 'morality refers only to religious rules, while ethics is entirely secular', 'morality refers to actual norms and practices, while ethics refers to their systematic philosophical study'],
          'correct': 3,
        },
        {
          'passage': 'Ethics, broadly, is the branch of philosophy concerned with questions of right and wrong conduct, and with what makes a life good. It is useful to distinguish ethics from related but different notions. Morality is often used to refer to the actual norms, values, and practices a person or culture holds regarding right and wrong, while ethics can refer more specifically to the systematic, philosophical study and justification of those norms. Ethics is also distinct from law: an action can be legal but widely regarded as unethical (such as certain forms of exploitative but technically legal business practice), and an action can be illegal in a given jurisdiction while still being considered, by many, morally justified or even required, such as certain acts of civil disobedience.',
          'question': 'According to the passage, can an action be legal but widely regarded as unethical?',
          'options': ['no, the passage says legal actions are always ethical', 'no, the passage says this can never occur', 'yes, the passage gives the example of exploitative but technically legal business practice', 'the passage does not address this question'],
          'correct': 2,
        },
        {
          'passage': 'Ethics, broadly, is the branch of philosophy concerned with questions of right and wrong conduct, and with what makes a life good. It is useful to distinguish ethics from related but different notions. Morality is often used to refer to the actual norms, values, and practices a person or culture holds regarding right and wrong, while ethics can refer more specifically to the systematic, philosophical study and justification of those norms. Ethics is also distinct from law: an action can be legal but widely regarded as unethical (such as certain forms of exploitative but technically legal business practice), and an action can be illegal in a given jurisdiction while still being considered, by many, morally justified or even required, such as certain acts of civil disobedience.',
          'question': 'According to the passage, what example is given of an action that is illegal but might be considered morally justified?',
          'options': ['all forms of business practice', 'all forms of self-defense', 'all religious rituals', 'certain acts of civil disobedience Passage 2 Moral relativism is the view that moral judgments are true or false only relative to a particular individual or culture, such that there is no single, universally correct moral standard applicable to everyone. Proponents point to the genuine diversity of moral beliefs across cultures and historical periods as evidence against the existence of a single universal moral code. Critics of relativism argue that it faces a serious practical difficulty: if morality is entirely relative to each culture, it becomes difficult to coherently criticize even widely condemned historical practices, such as slavery or genocide, as objectively wrong, since the relativist can only say that such practices violated the norms of some other culture, not that they were wrong in any deeper, culture-independent sense.'],
          'correct': 3,
        },
        {
          'passage': 'Moral relativism is the view that moral judgments are true or false only relative to a particular individual or culture, such that there is no single, universally correct moral standard applicable to everyone. Proponents point to the genuine diversity of moral beliefs across cultures and historical periods as evidence against the existence of a single universal moral code. Critics of relativism argue that it faces a serious practical difficulty: if morality is entirely relative to each culture, it becomes difficult to coherently criticize even widely condemned historical practices, such as slavery or genocide, as objectively wrong, since the relativist can only say that such practices violated the norms of some other culture, not that they were wrong in any deeper, culture-independent sense.',
          'question': 'According to the passage, moral relativism is the view that moral judgments are true or false only:',
          'options': ['relative to a particular individual or culture', 'according to legal statute alone', 'according to a single universal moral code', 'according to scientific consensus'],
          'correct': 0,
        },
        {
          'passage': 'Moral relativism is the view that moral judgments are true or false only relative to a particular individual or culture, such that there is no single, universally correct moral standard applicable to everyone. Proponents point to the genuine diversity of moral beliefs across cultures and historical periods as evidence against the existence of a single universal moral code. Critics of relativism argue that it faces a serious practical difficulty: if morality is entirely relative to each culture, it becomes difficult to coherently criticize even widely condemned historical practices, such as slavery or genocide, as objectively wrong, since the relativist can only say that such practices violated the norms of some other culture, not that they were wrong in any deeper, culture-independent sense.',
          'question': 'According to the passage, what evidence do proponents of relativism cite?',
          'options': ['the genuine diversity of moral beliefs across cultures and historical periods', 'a mathematical proof', 'universal agreement among all philosophers', 'a controlled scientific experiment'],
          'correct': 0,
        },
        {
          'passage': 'Moral relativism is the view that moral judgments are true or false only relative to a particular individual or culture, such that there is no single, universally correct moral standard applicable to everyone. Proponents point to the genuine diversity of moral beliefs across cultures and historical periods as evidence against the existence of a single universal moral code. Critics of relativism argue that it faces a serious practical difficulty: if morality is entirely relative to each culture, it becomes difficult to coherently criticize even widely condemned historical practices, such as slavery or genocide, as objectively wrong, since the relativist can only say that such practices violated the norms of some other culture, not that they were wrong in any deeper, culture-independent sense.',
          'question': 'According to the passage, what practical difficulty do critics say relativism faces?',
          'options': ['it becomes difficult to coherently criticize practices like slavery or genocide as objectively wrong', 'it requires universal agreement before any judgment can be made', 'it eliminates the concept of culture entirely', 'it makes it too easy to criticize any cultural practice'],
          'correct': 0,
        },
        {
          'passage': 'Moral relativism is the view that moral judgments are true or false only relative to a particular individual or culture, such that there is no single, universally correct moral standard applicable to everyone. Proponents point to the genuine diversity of moral beliefs across cultures and historical periods as evidence against the existence of a single universal moral code. Critics of relativism argue that it faces a serious practical difficulty: if morality is entirely relative to each culture, it becomes difficult to coherently criticize even widely condemned historical practices, such as slavery or genocide, as objectively wrong, since the relativist can only say that such practices violated the norms of some other culture, not that they were wrong in any deeper, culture-independent sense.',
          'question': 'According to the passage, what can a relativist only say about a widely condemned practice like slavery?',
          'options': ['that it violated the norms of some other culture, not that it was wrong in a deeper, culture-independent sense', 'that it was always illegal everywhere', 'that it was objectively and universally wrong', 'that no culture has ever practiced it Passage 3 A recurring question in ethics concerns the relationship between morality and self-interest: is it ever rational to act morally when doing so conflicts with one\'s own interests? Ethical egoism holds that a person is morally required, or at least morally permitted, to act in whatever way best serves their own self-interest, and that other-directed moral theories misunderstand the true basis of moral motivation. Critics of ethical egoism point out that it seems to struggle with cases of direct conflict — if two people\'s self-interest genuinely and completely conflict, ethical egoism appears to endorse each acting against the other, which some argue undermines the very possibility of using ethics to resolve disputes fairly, since ethics is often expected to provide standards that hold impartially across differing individual interests.'],
          'correct': 0,
        },
        {
          'passage': 'A recurring question in ethics concerns the relationship between morality and self-interest: is it ever rational to act morally when doing so conflicts with one\'s own interests? Ethical egoism holds that a person is morally required, or at least morally permitted, to act in whatever way best serves their own self-interest, and that other-directed moral theories misunderstand the true basis of moral motivation. Critics of ethical egoism point out that it seems to struggle with cases of direct conflict — if two people\'s self-interest genuinely and completely conflict, ethical egoism appears to endorse each acting against the other, which some argue undermines the very possibility of using ethics to resolve disputes fairly, since ethics is often expected to provide standards that hold impartially across differing individual interests.',
          'question': 'According to the passage, ethical egoism holds that a person is morally required or permitted to:',
          'options': ['act only according to majority opinion', 'act in whatever way best serves their own self-interest', 'always sacrifice their own interests for others', 'follow strict religious commandments only'],
          'correct': 1,
        },
        {
          'passage': 'A recurring question in ethics concerns the relationship between morality and self-interest: is it ever rational to act morally when doing so conflicts with one\'s own interests? Ethical egoism holds that a person is morally required, or at least morally permitted, to act in whatever way best serves their own self-interest, and that other-directed moral theories misunderstand the true basis of moral motivation. Critics of ethical egoism point out that it seems to struggle with cases of direct conflict — if two people\'s self-interest genuinely and completely conflict, ethical egoism appears to endorse each acting against the other, which some argue undermines the very possibility of using ethics to resolve disputes fairly, since ethics is often expected to provide standards that hold impartially across differing individual interests.',
          'question': 'According to the passage, what problem do critics identify with ethical egoism in cases of direct conflict?',
          'options': ['it always produces perfect agreement between conflicting parties', 'it appears to endorse each party acting against the other when interests genuinely conflict', 'it eliminates the concept of self-interest entirely', 'it requires unanimous consent before any action'],
          'correct': 1,
        },
        {
          'passage': 'A recurring question in ethics concerns the relationship between morality and self-interest: is it ever rational to act morally when doing so conflicts with one\'s own interests? Ethical egoism holds that a person is morally required, or at least morally permitted, to act in whatever way best serves their own self-interest, and that other-directed moral theories misunderstand the true basis of moral motivation. Critics of ethical egoism point out that it seems to struggle with cases of direct conflict — if two people\'s self-interest genuinely and completely conflict, ethical egoism appears to endorse each acting against the other, which some argue undermines the very possibility of using ethics to resolve disputes fairly, since ethics is often expected to provide standards that hold impartially across differing individual interests.',
          'question': 'According to the passage, what standard is ethics often expected to provide, according to critics of egoism?',
          'options': ['standards based solely on personal preference', 'standards that favor only the wealthiest individuals', 'standards that hold impartially across differing individual interests', 'standards that apply only within a single culture'],
          'correct': 2,
        },
        {
          'passage': 'A recurring question in ethics concerns the relationship between morality and self-interest: is it ever rational to act morally when doing so conflicts with one\'s own interests? Ethical egoism holds that a person is morally required, or at least morally permitted, to act in whatever way best serves their own self-interest, and that other-directed moral theories misunderstand the true basis of moral motivation. Critics of ethical egoism point out that it seems to struggle with cases of direct conflict — if two people\'s self-interest genuinely and completely conflict, ethical egoism appears to endorse each acting against the other, which some argue undermines the very possibility of using ethics to resolve disputes fairly, since ethics is often expected to provide standards that hold impartially across differing individual interests.',
          'question': 'According to the passage, what is the central question this passage addresses regarding morality and self-interest?',
          'options': ['whether it is ever rational to act morally when doing so conflicts with one\'s own interests', 'whether ethics can be studied scientifically', 'whether morality has ever existed in human history', 'whether self-interest is a modern invention Passage 4 Moral status refers to the question of which beings deserve moral consideration, and how much. Most ethical theories agree that adult human beings possess significant moral status, but there is considerable disagreement about the basis for this status and about how far moral consideration should extend beyond humans. Some theories ground moral status in the capacity for rational agency, which would tend to exclude most non-human animals and raise complex questions about infants or people with severe cognitive disabilities. Other theories ground moral status in the capacity to suffer or experience well-being (sentience), a criterion that would extend significant moral consideration to many non-human animals as well. These differing foundations lead to substantially different practical conclusions about how humans ought to treat animals, the environment, and even hypothetical future artificial intelligences.'],
          'correct': 0,
        },
        {
          'passage': 'Moral status refers to the question of which beings deserve moral consideration, and how much. Most ethical theories agree that adult human beings possess significant moral status, but there is considerable disagreement about the basis for this status and about how far moral consideration should extend beyond humans. Some theories ground moral status in the capacity for rational agency, which would tend to exclude most non-human animals and raise complex questions about infants or people with severe cognitive disabilities. Other theories ground moral status in the capacity to suffer or experience well-being (sentience), a criterion that would extend significant moral consideration to many non-human animals as well. These differing foundations lead to substantially different practical conclusions about how humans ought to treat animals, the environment, and even hypothetical future artificial intelligences.',
          'question': 'According to the passage, \'moral status\' refers to the question of:',
          'options': ['which beings deserve moral consideration, and how much', 'which beings are biologically classified as animals', 'which laws apply in a given country', 'which beings can speak a human language'],
          'correct': 0,
        },
        {
          'passage': 'Moral status refers to the question of which beings deserve moral consideration, and how much. Most ethical theories agree that adult human beings possess significant moral status, but there is considerable disagreement about the basis for this status and about how far moral consideration should extend beyond humans. Some theories ground moral status in the capacity for rational agency, which would tend to exclude most non-human animals and raise complex questions about infants or people with severe cognitive disabilities. Other theories ground moral status in the capacity to suffer or experience well-being (sentience), a criterion that would extend significant moral consideration to many non-human animals as well. These differing foundations lead to substantially different practical conclusions about how humans ought to treat animals, the environment, and even hypothetical future artificial intelligences.',
          'question': 'According to the passage, grounding moral status in rational agency would tend to:',
          'options': ['have no effect on which beings are considered morally significant', 'exclude most non-human animals and raise complex questions about infants or people with severe cognitive disabilities', 'apply identically to every living organism', 'automatically extend full moral status to all animals'],
          'correct': 1,
        },
        {
          'passage': 'Moral status refers to the question of which beings deserve moral consideration, and how much. Most ethical theories agree that adult human beings possess significant moral status, but there is considerable disagreement about the basis for this status and about how far moral consideration should extend beyond humans. Some theories ground moral status in the capacity for rational agency, which would tend to exclude most non-human animals and raise complex questions about infants or people with severe cognitive disabilities. Other theories ground moral status in the capacity to suffer or experience well-being (sentience), a criterion that would extend significant moral consideration to many non-human animals as well. These differing foundations lead to substantially different practical conclusions about how humans ought to treat animals, the environment, and even hypothetical future artificial intelligences.',
          'question': 'According to the passage, grounding moral status in sentience (the capacity to suffer) would:',
          'options': ['have no relevance to how animals are treated', 'exclude all animals from moral consideration entirely', 'extend significant moral consideration to many non-human animals', 'apply only to human beings'],
          'correct': 2,
        },
        {
          'passage': 'Moral status refers to the question of which beings deserve moral consideration, and how much. Most ethical theories agree that adult human beings possess significant moral status, but there is considerable disagreement about the basis for this status and about how far moral consideration should extend beyond humans. Some theories ground moral status in the capacity for rational agency, which would tend to exclude most non-human animals and raise complex questions about infants or people with severe cognitive disabilities. Other theories ground moral status in the capacity to suffer or experience well-being (sentience), a criterion that would extend significant moral consideration to many non-human animals as well. These differing foundations lead to substantially different practical conclusions about how humans ought to treat animals, the environment, and even hypothetical future artificial intelligences.',
          'question': 'According to the passage, what practical questions do these differing foundations for moral status affect?',
          'options': ['only questions about mathematical logic', 'only questions about historical events', 'only questions about international trade law', 'how humans ought to treat animals, the environment, and hypothetical future artificial intelligences Passage 5 The \'is-ought problem,\' articulated by David Hume, points out a gap between descriptive claims about how things are and normative claims about how things ought to be: no purely descriptive set of facts, by itself, logically entails a normative conclusion, without at least one additional normative premise being smuggled in somewhere along the way. For example, the fact that a certain practice is common in nature does not, by itself, establish that the practice is morally good, since an additional premise — such as \'whatever is natural is good\' — would be needed to bridge the gap, and that premise is itself a normative claim requiring independent justification, not a straightforward description of fact. G.E. Moore later developed a related concern, the \'naturalistic fallacy,\' criticizing attempts to simply define moral terms like \'good\' in purely natural, non-moral terms.'],
          'correct': 3,
        },
        {
          'passage': 'The \'is-ought problem,\' articulated by David Hume, points out a gap between descriptive claims about how things are and normative claims about how things ought to be: no purely descriptive set of facts, by itself, logically entails a normative conclusion, without at least one additional normative premise being smuggled in somewhere along the way. For example, the fact that a certain practice is common in nature does not, by itself, establish that the practice is morally good, since an additional premise — such as \'whatever is natural is good\' — would be needed to bridge the gap, and that premise is itself a normative claim requiring independent justification, not a straightforward description of fact. G.E. Moore later developed a related concern, the \'naturalistic fallacy,\' criticizing attempts to simply define moral terms like \'good\' in purely natural, non-moral terms.',
          'question': 'According to the passage, the \'is-ought problem\' points out a gap between:',
          'options': ['legal claims and illegal claims', 'descriptive claims about how things are and normative claims about how things ought to be', 'past events and future predictions', 'scientific claims and religious claims'],
          'correct': 1,
        },
        {
          'passage': 'The \'is-ought problem,\' articulated by David Hume, points out a gap between descriptive claims about how things are and normative claims about how things ought to be: no purely descriptive set of facts, by itself, logically entails a normative conclusion, without at least one additional normative premise being smuggled in somewhere along the way. For example, the fact that a certain practice is common in nature does not, by itself, establish that the practice is morally good, since an additional premise — such as \'whatever is natural is good\' — would be needed to bridge the gap, and that premise is itself a normative claim requiring independent justification, not a straightforward description of fact. G.E. Moore later developed a related concern, the \'naturalistic fallacy,\' criticizing attempts to simply define moral terms like \'good\' in purely natural, non-moral terms.',
          'question': 'According to the passage, what is needed to logically bridge the gap from a descriptive fact to a normative conclusion?',
          'options': ['a peer-reviewed scientific study', 'a larger sample size of observations', 'at least one additional normative premise', 'a change in the descriptive fact itself'],
          'correct': 2,
        },
        {
          'passage': 'The \'is-ought problem,\' articulated by David Hume, points out a gap between descriptive claims about how things are and normative claims about how things ought to be: no purely descriptive set of facts, by itself, logically entails a normative conclusion, without at least one additional normative premise being smuggled in somewhere along the way. For example, the fact that a certain practice is common in nature does not, by itself, establish that the practice is morally good, since an additional premise — such as \'whatever is natural is good\' — would be needed to bridge the gap, and that premise is itself a normative claim requiring independent justification, not a straightforward description of fact. G.E. Moore later developed a related concern, the \'naturalistic fallacy,\' criticizing attempts to simply define moral terms like \'good\' in purely natural, non-moral terms.',
          'question': 'According to the passage\'s example, what additional premise would be needed to conclude that a common natural practice is morally good?',
          'options': ['\'whatever is scientific is true\'', '\'whatever is rare is good\'', '\'whatever is common is illegal\'', '\'whatever is natural is good\''],
          'correct': 3,
        },
        {
          'passage': 'The \'is-ought problem,\' articulated by David Hume, points out a gap between descriptive claims about how things are and normative claims about how things ought to be: no purely descriptive set of facts, by itself, logically entails a normative conclusion, without at least one additional normative premise being smuggled in somewhere along the way. For example, the fact that a certain practice is common in nature does not, by itself, establish that the practice is morally good, since an additional premise — such as \'whatever is natural is good\' — would be needed to bridge the gap, and that premise is itself a normative claim requiring independent justification, not a straightforward description of fact. G.E. Moore later developed a related concern, the \'naturalistic fallacy,\' criticizing attempts to simply define moral terms like \'good\' in purely natural, non-moral terms.',
          'question': 'According to the passage, who developed the related concern known as the \'naturalistic fallacy\'?',
          'options': ['John Stuart Mill', 'Immanuel Kant', 'G.E. Moore', 'David Hume'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'moral objectivism\' (or moral realism)?',
          'options': ['the view that moral claims are always false', 'the view that at least some moral claims are true or false independently of what any individual or culture believes', 'the view that morality is purely a matter of personal preference', 'the view identical to moral relativism'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'moral anti-realism\'?',
          'options': ['the view that moral facts exist independently of all human attitudes', 'the view identical to moral objectivism', 'the view that morality can be studied only through physics', 'the view that there are no objective moral facts independent of human attitudes, beliefs, or conventions'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'emotivism\' as a metaethical theory?',
          'options': ['the view that moral statements are always literally true or false in the same way as empirical claims', 'the view that morality is entirely a matter of scientific fact', 'a synonym for utilitarianism', 'the view that moral statements primarily express emotional attitudes of approval or disapproval, rather than stating facts'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'moral pluralism\'?',
          'options': ['the view that only one single moral principle can ever be correct', 'the view that there may be multiple, sometimes competing, legitimate moral values or principles that cannot always be reduced to a single overarching rule', 'a synonym for moral relativism with no meaningful difference', 'the view that morality does not exist'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the difference between \'act utilitarianism\' and \'rule utilitarianism\'?',
          'options': ['act utilitarianism evaluates each individual action by its consequences, while rule utilitarianism evaluates actions by whether they conform to a rule that would produce the best consequences if generally followed', 'they are exactly the same theory with different names', 'act utilitarianism ignores consequences entirely', 'rule utilitarianism rejects the importance of well-being'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes moral \'particularism\'?',
          'options': ['a synonym for utilitarianism', 'the view that morality applies only to a particular, single individual', 'the view that moral judgments should be made based on the specific features of individual cases, rather than derived mechanically from fixed general rules', 'the view that only general rules matter, never specific circumstances'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the \'trolley problem,\' a widely discussed thought experiment in ethics?',
          'options': ['a scenario asking whether it is permissible to divert a runaway trolley to kill one person instead of five, used to probe intuitions about consequentialist versus deontological reasoning', 'a thought experiment about economic trade policy', 'a real historical incident involving an actual runaway train', 'a purely legal case with no philosophical significance'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the distinction between \'doing\' and \'allowing\' harm, often discussed in relation to the trolley problem?',
          'options': ['most ethical theories treat doing and allowing harm as morally identical in every case', 'this distinction is universally rejected by all ethical theories', 'this distinction applies only to legal contexts, never moral ones', 'many people\'s moral intuitions treat actively causing harm as morally different from merely failing to prevent the same harm from occurring'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'moral luck,\' a concept discussed by philosophers such as Bernard Williams and Thomas Nagel?',
          'options': ['the phenomenon in which factors outside an agent\'s control appear to affect the moral judgment we make of their actions', 'the idea that only lucky people can act morally', 'the idea that morality has no connection whatsoever to luck or chance', 'a synonym for moral relativism'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the difference between a \'moral duty\' and a \'moral ideal\' or \'supererogatory act\'?',
          'options': ['a duty is generally considered morally required, while a supererogatory act goes beyond what is required, though it is praiseworthy', 'a duty is always optional, while a supererogatory act is always required', 'supererogatory acts are always morally forbidden', 'they are exactly the same concept with no meaningful distinction'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'moral intuitionism\' as a metaethical position?',
          'options': ['the view that moral truths can only ever be known through scientific experiment', 'the view that no moral truths can ever be known', 'a synonym for emotivism', 'the view that some moral truths can be known directly through immediate, non-inferential moral perception or intuition'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes W.D. Ross\'s concept of \'prima facie duties\'?',
          'options': ['duties that apply only to legal contracts', 'a synonym for supererogatory acts', 'duties that are always absolute and can never be overridden by anything', 'moral duties that are binding unless overridden by a weightier competing duty in a specific situation'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'moral psychology\' as a field bridging ethics and empirical study?',
          'options': ['a synonym for metaethics', 'a field with no connection to philosophical ethics', 'the study of the psychological processes underlying moral judgment, motivation, and behavior', 'a branch of ethics concerned only with abstract logical proofs'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the significance of the is-ought problem for practical ethical reasoning?',
          'options': ['it proves that ethical reasoning is entirely impossible', 'it shows that facts are completely irrelevant to ethical reasoning', 'it highlights the need to make normative assumptions explicit, rather than assuming they follow automatically from purely factual claims', 'it applies only to religious ethical arguments'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why the distinction between ethics and law matters for evaluating a controversial new practice, such as a new business model or technology?',
          'options': ['anything that is legal is automatically also ethical', 'ethics and law always reach identical conclusions', 'anything that is illegal is automatically also unethical', 'something can be legally permitted yet still raise serious ethical concerns, so legality alone does not settle whether a practice is morally acceptable'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'divine command theory\' as a metaethical position?',
          'options': ['a synonym for ethical egoism', 'the view that moral truths are established by majority vote', 'the view that morality has no connection whatsoever to religion', 'the view that an action is morally right if and only if it is commanded by God'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the \'Euthyphro dilemma,\' originating in Plato\'s dialogue of the same name?',
          'options': ['the question of whether something is good because a god commands it, or whether a god commands it because it is already good', 'a mathematical paradox concerning infinity', 'a purely legal dispute about property ownership', 'a dispute about the correct definition of knowledge'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'moral relativism\' as applied specifically to individuals, sometimes called \'subjectivism\'?',
          'options': ['the view that moral truths apply identically to every individual', 'the view that morality does not vary at all between individuals', 'the view that moral truths are relative to each individual person\'s own beliefs or feelings, rather than to a culture or universal standard', 'a synonym for moral objectivism'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why many philosophers distinguish \'descriptive ethics\' from \'normative ethics\'?',
          'options': ['descriptive ethics is concerned only with mathematics', 'they are exactly the same field studied by different departments', 'descriptive ethics empirically documents what moral beliefs people actually hold, while normative ethics evaluates which moral beliefs or principles are correct', 'normative ethics never considers actual human behavior'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'moral absolutism\'?',
          'options': ['a synonym for moral relativism', 'the view that morality changes completely from one moment to the next', 'the view that certain moral rules hold without exception, regardless of consequences or circumstances', 'the view that no moral rule ever applies in any situation'],
          'correct': 2,
        },
      ];
    case 'gns106_u5_2': // Science Ethics
      return [
        {
          'passage': 'The ethical treatment of human subjects in scientific research became a matter of formal, codified policy largely in response to serious historical abuses, most notably Nazi medical experiments during World War II and, in the United States, the Tuskegee syphilis study, in which researchers withheld known effective treatment from Black men suffering from syphilis for decades, without their informed consent, in order to observe the disease\'s untreated progression. In response to such abuses, foundational documents such as the Nuremberg Code and the Belmont Report established core ethical principles for human subjects research, including the requirement of voluntary informed consent, the minimization of unnecessary risk and harm, and a fair distribution of both the burdens and the benefits of research across different populations.',
          'question': 'According to the passage, formal ethical policy for human subjects research developed largely in response to:',
          'options': ['serious historical abuses, including Nazi medical experiments and the Tuskegee syphilis study', 'the invention of the internet', 'a lack of interest in scientific research generally', 'a shortage of research funding'],
          'correct': 0,
        },
        {
          'passage': 'The ethical treatment of human subjects in scientific research became a matter of formal, codified policy largely in response to serious historical abuses, most notably Nazi medical experiments during World War II and, in the United States, the Tuskegee syphilis study, in which researchers withheld known effective treatment from Black men suffering from syphilis for decades, without their informed consent, in order to observe the disease\'s untreated progression. In response to such abuses, foundational documents such as the Nuremberg Code and the Belmont Report established core ethical principles for human subjects research, including the requirement of voluntary informed consent, the minimization of unnecessary risk and harm, and a fair distribution of both the burdens and the benefits of research across different populations.',
          'question': 'According to the passage, what did researchers do in the Tuskegee syphilis study?',
          'options': ['obtained full informed consent from every participant', 'conducted the study with no human subjects at all', 'provided free treatment to all participants immediately', 'withheld known effective treatment from Black men with syphilis for decades, without informed consent'],
          'correct': 3,
        },
        {
          'passage': 'The ethical treatment of human subjects in scientific research became a matter of formal, codified policy largely in response to serious historical abuses, most notably Nazi medical experiments during World War II and, in the United States, the Tuskegee syphilis study, in which researchers withheld known effective treatment from Black men suffering from syphilis for decades, without their informed consent, in order to observe the disease\'s untreated progression. In response to such abuses, foundational documents such as the Nuremberg Code and the Belmont Report established core ethical principles for human subjects research, including the requirement of voluntary informed consent, the minimization of unnecessary risk and harm, and a fair distribution of both the burdens and the benefits of research across different populations.',
          'question': 'According to the passage, which two foundational documents are named as establishing core ethical principles for human subjects research?',
          'options': ['the Nuremberg Code and the Belmont Report', 'the Paris Agreement and the Geneva Convention', 'the Declaration of Independence and the Magna Carta', 'the Universal Declaration of Human Rights and the UN Charter'],
          'correct': 0,
        },
        {
          'passage': 'The ethical treatment of human subjects in scientific research became a matter of formal, codified policy largely in response to serious historical abuses, most notably Nazi medical experiments during World War II and, in the United States, the Tuskegee syphilis study, in which researchers withheld known effective treatment from Black men suffering from syphilis for decades, without their informed consent, in order to observe the disease\'s untreated progression. In response to such abuses, foundational documents such as the Nuremberg Code and the Belmont Report established core ethical principles for human subjects research, including the requirement of voluntary informed consent, the minimization of unnecessary risk and harm, and a fair distribution of both the burdens and the benefits of research across different populations.',
          'question': 'According to the passage, what core principles do these documents establish?',
          'options': ['voluntary informed consent, minimization of unnecessary risk, and fair distribution of burdens and benefits', 'the abolition of all human subjects research', 'unlimited researcher discretion with no oversight', 'mandatory participation for all citizens Passage 2 Research integrity concerns the honest and responsible conduct of science itself, independent of questions about the treatment of research subjects. Serious violations include fabrication (inventing data that was never actually collected), falsification (manipulating research materials, equipment, or processes, or altering or omitting data such that the research is not accurately represented), and plagiarism (presenting another person\'s ideas, results, or words as one\'s own without appropriate credit). A subtler and more widely debated concern is \'p-hacking\' or selective reporting, in which researchers, sometimes without explicit intent to deceive, analyze data in multiple ways or report only favorable results until a statistically significant finding emerges, inflating the apparent reliability of what may actually be a chance result.'],
          'correct': 0,
        },
        {
          'passage': 'Research integrity concerns the honest and responsible conduct of science itself, independent of questions about the treatment of research subjects. Serious violations include fabrication (inventing data that was never actually collected), falsification (manipulating research materials, equipment, or processes, or altering or omitting data such that the research is not accurately represented), and plagiarism (presenting another person\'s ideas, results, or words as one\'s own without appropriate credit). A subtler and more widely debated concern is \'p-hacking\' or selective reporting, in which researchers, sometimes without explicit intent to deceive, analyze data in multiple ways or report only favorable results until a statistically significant finding emerges, inflating the apparent reliability of what may actually be a chance result.',
          'question': 'According to the passage, \'fabrication\' in research integrity refers to:',
          'options': ['inventing data that was never actually collected', 'using a large and representative sample', 'citing another researcher\'s work with proper credit', 'accurately reporting all collected data'],
          'correct': 0,
        },
        {
          'passage': 'Research integrity concerns the honest and responsible conduct of science itself, independent of questions about the treatment of research subjects. Serious violations include fabrication (inventing data that was never actually collected), falsification (manipulating research materials, equipment, or processes, or altering or omitting data such that the research is not accurately represented), and plagiarism (presenting another person\'s ideas, results, or words as one\'s own without appropriate credit). A subtler and more widely debated concern is \'p-hacking\' or selective reporting, in which researchers, sometimes without explicit intent to deceive, analyze data in multiple ways or report only favorable results until a statistically significant finding emerges, inflating the apparent reliability of what may actually be a chance result.',
          'question': 'According to the passage, \'falsification\' in research integrity refers to:',
          'options': ['properly crediting the original source of an idea', 'publishing negative or null results', 'manipulating research materials, processes, or data such that the research is not accurately represented', 'conducting a study with full informed consent'],
          'correct': 2,
        },
        {
          'passage': 'Research integrity concerns the honest and responsible conduct of science itself, independent of questions about the treatment of research subjects. Serious violations include fabrication (inventing data that was never actually collected), falsification (manipulating research materials, equipment, or processes, or altering or omitting data such that the research is not accurately represented), and plagiarism (presenting another person\'s ideas, results, or words as one\'s own without appropriate credit). A subtler and more widely debated concern is \'p-hacking\' or selective reporting, in which researchers, sometimes without explicit intent to deceive, analyze data in multiple ways or report only favorable results until a statistically significant finding emerges, inflating the apparent reliability of what may actually be a chance result.',
          'question': 'According to the passage, \'plagiarism\' refers to:',
          'options': ['presenting another person\'s ideas, results, or words as one\'s own without appropriate credit', 'altering statistical results to obtain significance', 'withholding treatment from research participants', 'inventing data that was never collected'],
          'correct': 0,
        },
        {
          'passage': 'Research integrity concerns the honest and responsible conduct of science itself, independent of questions about the treatment of research subjects. Serious violations include fabrication (inventing data that was never actually collected), falsification (manipulating research materials, equipment, or processes, or altering or omitting data such that the research is not accurately represented), and plagiarism (presenting another person\'s ideas, results, or words as one\'s own without appropriate credit). A subtler and more widely debated concern is \'p-hacking\' or selective reporting, in which researchers, sometimes without explicit intent to deceive, analyze data in multiple ways or report only favorable results until a statistically significant finding emerges, inflating the apparent reliability of what may actually be a chance result.',
          'question': 'According to the passage, what does \'p-hacking\' or selective reporting typically involve?',
          'options': ['analyzing data in multiple ways or reporting only favorable results until a statistically significant finding emerges', 'refusing to publish any research at all', 'obtaining informed consent from all participants', 'reporting every single result exactly as originally collected Passage 3 The ethical evaluation of animal research remains a genuinely contested area, balancing the potential scientific and medical benefits of such research against the moral status and welfare of the animals involved. The widely adopted \'3Rs\' framework — Replacement, Reduction, and Refinement — provides guiding principles intended to minimize animal suffering without necessarily eliminating animal research altogether. Replacement refers to using non-animal methods wherever a scientifically valid alternative exists; Reduction refers to using the minimum number of animals necessary to achieve valid, statistically meaningful scientific results; and Refinement refers to modifying procedures to minimize pain, suffering, and distress, and to improve overall animal welfare during the course of a study. Critics disagree sharply over whether the 3Rs framework goes far enough, or whether some or all forms of animal research are fundamentally unjustifiable regardless of the precautions taken.'],
          'correct': 0,
        },
        {
          'passage': 'The ethical evaluation of animal research remains a genuinely contested area, balancing the potential scientific and medical benefits of such research against the moral status and welfare of the animals involved. The widely adopted \'3Rs\' framework — Replacement, Reduction, and Refinement — provides guiding principles intended to minimize animal suffering without necessarily eliminating animal research altogether. Replacement refers to using non-animal methods wherever a scientifically valid alternative exists; Reduction refers to using the minimum number of animals necessary to achieve valid, statistically meaningful scientific results; and Refinement refers to modifying procedures to minimize pain, suffering, and distress, and to improve overall animal welfare during the course of a study. Critics disagree sharply over whether the 3Rs framework goes far enough, or whether some or all forms of animal research are fundamentally unjustifiable regardless of the precautions taken.',
          'question': 'According to the passage, the \'3Rs\' framework for animal research stands for:',
          'options': ['Risk, Reward, and Responsibility', 'Research, Review, and Regulation', 'Recording, Reporting, and Repeating', 'Replacement, Reduction, and Refinement'],
          'correct': 3,
        },
        {
          'passage': 'The ethical evaluation of animal research remains a genuinely contested area, balancing the potential scientific and medical benefits of such research against the moral status and welfare of the animals involved. The widely adopted \'3Rs\' framework — Replacement, Reduction, and Refinement — provides guiding principles intended to minimize animal suffering without necessarily eliminating animal research altogether. Replacement refers to using non-animal methods wherever a scientifically valid alternative exists; Reduction refers to using the minimum number of animals necessary to achieve valid, statistically meaningful scientific results; and Refinement refers to modifying procedures to minimize pain, suffering, and distress, and to improve overall animal welfare during the course of a study. Critics disagree sharply over whether the 3Rs framework goes far enough, or whether some or all forms of animal research are fundamentally unjustifiable regardless of the precautions taken.',
          'question': 'According to the passage, \'Replacement\' in the 3Rs framework refers to:',
          'options': ['increasing the total number of animals used in a study', 'eliminating all record-keeping requirements', 'replacing human researchers with automated systems', 'using non-animal methods wherever a scientifically valid alternative exists'],
          'correct': 3,
        },
        {
          'passage': 'The ethical evaluation of animal research remains a genuinely contested area, balancing the potential scientific and medical benefits of such research against the moral status and welfare of the animals involved. The widely adopted \'3Rs\' framework — Replacement, Reduction, and Refinement — provides guiding principles intended to minimize animal suffering without necessarily eliminating animal research altogether. Replacement refers to using non-animal methods wherever a scientifically valid alternative exists; Reduction refers to using the minimum number of animals necessary to achieve valid, statistically meaningful scientific results; and Refinement refers to modifying procedures to minimize pain, suffering, and distress, and to improve overall animal welfare during the course of a study. Critics disagree sharply over whether the 3Rs framework goes far enough, or whether some or all forms of animal research are fundamentally unjustifiable regardless of the precautions taken.',
          'question': 'According to the passage, \'Reduction\' in the 3Rs framework refers to:',
          'options': ['eliminating the need for any statistical analysis', 'using as many animals as possible to increase statistical power', 'reducing the number of researchers involved in a study', 'using the minimum number of animals necessary to achieve valid, statistically meaningful results'],
          'correct': 3,
        },
        {
          'passage': 'The ethical evaluation of animal research remains a genuinely contested area, balancing the potential scientific and medical benefits of such research against the moral status and welfare of the animals involved. The widely adopted \'3Rs\' framework — Replacement, Reduction, and Refinement — provides guiding principles intended to minimize animal suffering without necessarily eliminating animal research altogether. Replacement refers to using non-animal methods wherever a scientifically valid alternative exists; Reduction refers to using the minimum number of animals necessary to achieve valid, statistically meaningful scientific results; and Refinement refers to modifying procedures to minimize pain, suffering, and distress, and to improve overall animal welfare during the course of a study. Critics disagree sharply over whether the 3Rs framework goes far enough, or whether some or all forms of animal research are fundamentally unjustifiable regardless of the precautions taken.',
          'question': 'According to the passage, do critics agree about whether the 3Rs framework goes far enough?',
          'options': ['no, the passage says critics disagree sharply on this question', 'yes, all critics agree the framework should be abolished', 'yes, all critics agree the framework is fully sufficient', 'the passage does not address this disagreement Passage 4 Dual-use research of concern refers to legitimate scientific research that, despite being intended for beneficial purposes, produces knowledge, methods, or technologies that could readily be misused to cause significant harm — for example, research clarifying how a dangerous pathogen might become more transmissible, conducted to improve public health preparedness, but which could, in principle, also provide a blueprint for creating a bioweapon. This creates a genuine ethical tension for the scientific community: withholding such research entirely could slow beneficial medical or public health progress, while publishing it openly, following the traditional scientific norm of open dissemination, could increase the risk of malicious misuse. Some journals and funding agencies have developed review processes specifically intended to weigh these competing considerations before high-risk dual-use research is approved or published.'],
          'correct': 0,
        },
        {
          'passage': 'Dual-use research of concern refers to legitimate scientific research that, despite being intended for beneficial purposes, produces knowledge, methods, or technologies that could readily be misused to cause significant harm — for example, research clarifying how a dangerous pathogen might become more transmissible, conducted to improve public health preparedness, but which could, in principle, also provide a blueprint for creating a bioweapon. This creates a genuine ethical tension for the scientific community: withholding such research entirely could slow beneficial medical or public health progress, while publishing it openly, following the traditional scientific norm of open dissemination, could increase the risk of malicious misuse. Some journals and funding agencies have developed review processes specifically intended to weigh these competing considerations before high-risk dual-use research is approved or published.',
          'question': 'According to the passage, \'dual-use research of concern\' refers to:',
          'options': ['research that has been definitively proven to be harmful', 'research funded exclusively by military organizations', 'legitimate research that could be misused to cause significant harm, despite being intended for beneficial purposes', 'research that has no possible beneficial applications'],
          'correct': 2,
        },
        {
          'passage': 'Dual-use research of concern refers to legitimate scientific research that, despite being intended for beneficial purposes, produces knowledge, methods, or technologies that could readily be misused to cause significant harm — for example, research clarifying how a dangerous pathogen might become more transmissible, conducted to improve public health preparedness, but which could, in principle, also provide a blueprint for creating a bioweapon. This creates a genuine ethical tension for the scientific community: withholding such research entirely could slow beneficial medical or public health progress, while publishing it openly, following the traditional scientific norm of open dissemination, could increase the risk of malicious misuse. Some journals and funding agencies have developed review processes specifically intended to weigh these competing considerations before high-risk dual-use research is approved or published.',
          'question': 'According to the passage\'s example, what kind of research is used to illustrate this concept?',
          'options': ['research on ancient historical artifacts', 'research on renewable energy technology', 'research clarifying how a dangerous pathogen might become more transmissible', 'research on mathematical theorems'],
          'correct': 2,
        },
        {
          'passage': 'Dual-use research of concern refers to legitimate scientific research that, despite being intended for beneficial purposes, produces knowledge, methods, or technologies that could readily be misused to cause significant harm — for example, research clarifying how a dangerous pathogen might become more transmissible, conducted to improve public health preparedness, but which could, in principle, also provide a blueprint for creating a bioweapon. This creates a genuine ethical tension for the scientific community: withholding such research entirely could slow beneficial medical or public health progress, while publishing it openly, following the traditional scientific norm of open dissemination, could increase the risk of malicious misuse. Some journals and funding agencies have developed review processes specifically intended to weigh these competing considerations before high-risk dual-use research is approved or published.',
          'question': 'According to the passage, what genuine ethical tension does dual-use research create?',
          'options': ['there is no tension at all; the answer is always obvious', 'the tension only concerns funding, not safety', 'withholding it could slow beneficial progress, while publishing it could increase risk of malicious misuse', 'the tension applies only to non-scientific fields'],
          'correct': 2,
        },
        {
          'passage': 'Dual-use research of concern refers to legitimate scientific research that, despite being intended for beneficial purposes, produces knowledge, methods, or technologies that could readily be misused to cause significant harm — for example, research clarifying how a dangerous pathogen might become more transmissible, conducted to improve public health preparedness, but which could, in principle, also provide a blueprint for creating a bioweapon. This creates a genuine ethical tension for the scientific community: withholding such research entirely could slow beneficial medical or public health progress, while publishing it openly, following the traditional scientific norm of open dissemination, could increase the risk of malicious misuse. Some journals and funding agencies have developed review processes specifically intended to weigh these competing considerations before high-risk dual-use research is approved or published.',
          'question': 'According to the passage, what have some journals and funding agencies developed to address this tension?',
          'options': ['mandatory publication of all research regardless of risk', 'elimination of all funding for public health research', 'a complete ban on all pathogen-related research', 'review processes specifically intended to weigh these competing considerations Passage 5 Conflicts of interest in scientific research arise when a researcher\'s personal, financial, or other interests could potentially bias, or appear to bias, the design, conduct, or reporting of their research. A commonly discussed example involves pharmaceutical-industry-funded drug trials, where concerns have been raised about whether funding source can subtly influence which studies are conducted, how results are interpreted, or which findings are ultimately published. Importantly, having a conflict of interest does not automatically mean a researcher has acted dishonestly — many conflicts are disclosed and appropriately managed through institutional oversight — but transparency about such conflicts is now widely considered an essential ethical requirement, since undisclosed conflicts undermine the public\'s ability to critically evaluate the reliability of published research.'],
          'correct': 3,
        },
        {
          'passage': 'Conflicts of interest in scientific research arise when a researcher\'s personal, financial, or other interests could potentially bias, or appear to bias, the design, conduct, or reporting of their research. A commonly discussed example involves pharmaceutical-industry-funded drug trials, where concerns have been raised about whether funding source can subtly influence which studies are conducted, how results are interpreted, or which findings are ultimately published. Importantly, having a conflict of interest does not automatically mean a researcher has acted dishonestly — many conflicts are disclosed and appropriately managed through institutional oversight — but transparency about such conflicts is now widely considered an essential ethical requirement, since undisclosed conflicts undermine the public\'s ability to critically evaluate the reliability of published research.',
          'question': 'According to the passage, a conflict of interest in scientific research arises when:',
          'options': ['a researcher disagrees with a colleague about a scientific theory', 'a researcher uses outdated equipment', 'a researcher\'s personal, financial, or other interests could potentially bias, or appear to bias, their research', 'a researcher publishes a paper in a foreign language'],
          'correct': 2,
        },
        {
          'passage': 'Conflicts of interest in scientific research arise when a researcher\'s personal, financial, or other interests could potentially bias, or appear to bias, the design, conduct, or reporting of their research. A commonly discussed example involves pharmaceutical-industry-funded drug trials, where concerns have been raised about whether funding source can subtly influence which studies are conducted, how results are interpreted, or which findings are ultimately published. Importantly, having a conflict of interest does not automatically mean a researcher has acted dishonestly — many conflicts are disclosed and appropriately managed through institutional oversight — but transparency about such conflicts is now widely considered an essential ethical requirement, since undisclosed conflicts undermine the public\'s ability to critically evaluate the reliability of published research.',
          'question': 'According to the passage, what is the commonly discussed example of a conflict of interest?',
          'options': ['university-funded historical archives', 'publicly funded weather forecasting', 'government-funded basic physics research', 'pharmaceutical-industry-funded drug trials'],
          'correct': 3,
        },
        {
          'passage': 'Conflicts of interest in scientific research arise when a researcher\'s personal, financial, or other interests could potentially bias, or appear to bias, the design, conduct, or reporting of their research. A commonly discussed example involves pharmaceutical-industry-funded drug trials, where concerns have been raised about whether funding source can subtly influence which studies are conducted, how results are interpreted, or which findings are ultimately published. Importantly, having a conflict of interest does not automatically mean a researcher has acted dishonestly — many conflicts are disclosed and appropriately managed through institutional oversight — but transparency about such conflicts is now widely considered an essential ethical requirement, since undisclosed conflicts undermine the public\'s ability to critically evaluate the reliability of published research.',
          'question': 'According to the passage, does having a conflict of interest automatically mean a researcher has acted dishonestly?',
          'options': ['yes, but only in pharmaceutical research specifically', 'the passage does not address this question', 'yes, a conflict of interest always means dishonesty has occurred', 'no, the passage explicitly says this is not automatic'],
          'correct': 3,
        },
        {
          'passage': 'Conflicts of interest in scientific research arise when a researcher\'s personal, financial, or other interests could potentially bias, or appear to bias, the design, conduct, or reporting of their research. A commonly discussed example involves pharmaceutical-industry-funded drug trials, where concerns have been raised about whether funding source can subtly influence which studies are conducted, how results are interpreted, or which findings are ultimately published. Importantly, having a conflict of interest does not automatically mean a researcher has acted dishonestly — many conflicts are disclosed and appropriately managed through institutional oversight — but transparency about such conflicts is now widely considered an essential ethical requirement, since undisclosed conflicts undermine the public\'s ability to critically evaluate the reliability of published research.',
          'question': 'According to the passage, why is transparency about conflicts of interest considered essential?',
          'options': ['transparency guarantees a study will have no conflicts at all', 'transparency eliminates the need for peer review', 'undisclosed conflicts undermine the public\'s ability to critically evaluate the reliability of published research', 'transparency is legally required in every country without exception'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'informed consent\' as an ethical requirement in human subjects research?',
          'options': ['researchers must inform participants only after the study has concluded', 'research participants must be given adequate information about a study and voluntarily agree to participate without coercion', 'consent is required only for studies involving minors', 'participants need only be informed of the study\'s funding source'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the purpose of an Institutional Review Board (IRB) or research ethics committee?',
          'options': ['to determine the scientific validity of a hypothesis before any research is conducted', 'to manage a university\'s financial budget', 'to publish research findings on behalf of a scientist', 'to review and approve proposed research involving human subjects to ensure it meets ethical standards'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the ethical concept of \'equipoise\' in clinical trial research?',
          'options': ['a synonym for informed consent', 'genuine uncertainty within the medical community about whether a new treatment is better than the current standard, justifying a comparative trial', 'complete certainty that a new treatment is superior before any trial begins', 'a legal requirement unrelated to medical ethics'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why vulnerable populations, such as prisoners or children, receive additional ethical protections in research?',
          'options': ['vulnerable populations are prohibited from ever participating in any research', 'such populations are considered scientifically more valuable as research subjects', 'such populations may have a reduced capacity to give fully free and informed consent, due to coercive circumstances or developmental factors', 'additional protections apply only to prevent legal liability, with no ethical basis'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the ethical significance of a \'placebo-controlled trial\'?',
          'options': ['comparing a treatment against an inactive placebo raises ethical questions when withholding known effective treatment could harm participants', 'placebo-controlled trials are always considered fully unproblematic ethically', 'placebos are illegal in all research contexts', 'placebo-controlled trials have no relevance to research ethics'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'publication bias\' as an ethical and methodological concern in science?',
          'options': ['a bias that favors publishing studies with negative results over positive ones', 'a term describing bias against a specific research topic only', 'a synonym for plagiarism', 'the tendency for studies with positive or statistically significant results to be published more often than studies with null or negative results'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes why \'data sharing\' and \'open science\' practices are often promoted on ethical grounds?',
          'options': ['they eliminate all need for research ethics review', 'they guarantee that all shared data is free from any errors', 'they can improve transparency, enable independent verification of results, and support the responsible use of publicly funded research', 'they are relevant only to research that receives no public funding'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes the ethical concept of \'beneficence\' as applied in research ethics, alongside respect for persons and justice (as in the Belmont Report)?',
          'options': ['the obligation to publish research as quickly as possible regardless of quality', 'the obligation to maximize possible benefits and minimize possible harms to research participants', 'a synonym for informed consent', 'the obligation to maximize profit for the research institution'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the Belmont Report\'s principle of \'justice\' in research ethics?',
          'options': ['a synonym for beneficence with no distinct meaning', 'the fair distribution of the burdens and benefits of research across different groups in society', 'a requirement that all researchers be paid identical salaries', 'a requirement that all research be conducted only in courts of law'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why retraction of a published scientific paper is considered an important mechanism in research integrity?',
          'options': ['retraction has no effect on the broader scientific literature', 'it guarantees that the retracted research will never be cited again by anyone', 'it formally corrects the scientific record when serious errors, fraud, or ethical violations are discovered after publication', 'it is a purely punitive measure with no scientific function'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes a key ethical concern regarding the use of animals in research that involves significant pain or distress?',
          'options': ['whether the research has been published in a highly ranked journal', 'whether the animals are legally classified as property', 'whether the potential scientific or medical benefit justifies the harm caused to research animals, and whether that harm has been adequately minimized', 'whether the animals involved are able to give informed consent, since this is always required'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why some scientists and ethicists argue for greater public engagement in decisions about ethically sensitive research, such as gene editing or synthetic biology?',
          'options': ['because ethically sensitive research is otherwise entirely unregulated', 'because such research can have broad societal implications that go beyond the technical expertise of scientists alone', 'because scientists are legally prohibited from making any decisions about their own research', 'because public engagement guarantees a scientifically correct outcome'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the ethical significance of the historical Nuremberg Code, developed after World War II?',
          'options': ['it applied only to research conducted within Germany', 'it eliminated the need for any further research ethics guidelines afterward', 'it focused exclusively on animal research, not human subjects', 'it established that voluntary informed consent of the human subject is essential in medical research, among other foundational ethical principles'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes why \'whistleblowing\' can present an ethical dilemma within scientific research communities?',
          'options': ['reporting misconduct guarantees no negative consequences for anyone involved', 'a researcher who reports misconduct may face professional risk, while remaining silent could allow harmful or fraudulent research to continue', 'whistleblowing is always legally required and carries no professional risk', 'whistleblowing has no relevance to maintaining research integrity'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'authorship ethics\' concerns in collaborative scientific research?',
          'options': ['disputes and guidelines over who qualifies for authorship credit, and in what order, based on actual contribution to the research', 'a synonym for peer review', 'a requirement that only one author is ever permitted per paper', 'a concern that applies only to single-author research'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes why genetic and genomic research raises distinct privacy concerns compared to some other forms of research?',
          'options': ['genetic data is never stored or shared in any research database', 'genetic data can reveal sensitive information not only about the individual participant but also about their biological relatives', 'genetic information cannot be linked to any specific individual', 'genetic research raises no privacy concerns not already present in all other research'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the ethical principle of \'minimal risk\' often used in evaluating research protocols?',
          'options': ['research must involve absolutely zero risk of any kind to be approved', 'the risks of harm in the research should be no greater than those ordinarily encountered in daily life or routine examinations', 'minimal risk applies only to research involving animals', 'minimal risk research requires no ethical review at all'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes a key ethical concern regarding research conducted in low-income countries by researchers or sponsors from high-income countries?',
          'options': ['there are no distinct ethical concerns beyond those present in any other research context', 'the potential for exploitation, such as failing to ensure that successful interventions remain accessible to the studied population afterward', 'international research is uniformly prohibited by global ethical standards', 'such research is always conducted for purely altruistic reasons with no risk of exploitation'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why the ethical evaluation of citizen science and crowdsourced research data raises distinct questions?',
          'options': ['citizen science involves no human participants and therefore raises no ethical questions', 'questions arise about consent, data ownership, and quality control when non-professional participants contribute directly to data collection or analysis', 'crowdsourced data is always more reliable than professionally collected data', 'citizen science is legally identical to traditional laboratory research in every respect'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the ethical rationale behind requiring pre-registration of a study\'s hypotheses and analysis plan before data collection begins?',
          'options': ['pre-registration guarantees a study\'s conclusions will be correct', 'pre-registration eliminates the need for any peer review afterward', 'it helps prevent selective reporting or p-hacking by committing researchers in advance to a specific analytical approach', 'pre-registration is required only for studies involving animals'],
          'correct': 2,
        },
      ];
    case 'gns106_u5_3': // Tech Ethics
      return [
        {
          'passage': 'Algorithmic decision-making systems, increasingly used in areas such as loan approval, hiring, and criminal sentencing recommendations, raise distinctive ethical concerns about fairness. One key insight from this debate is that different, individually reasonable-sounding definitions of \'fairness\' can conflict mathematically, such that a system cannot simultaneously satisfy all of them at once when underlying group base rates differ. For example, a system could be calibrated to have equal accuracy across demographic groups, or to have equal false-positive rates across those groups, but in many realistic cases these two goals cannot both be perfectly achieved simultaneously. This means that designing a \'fair\' algorithm is not merely a technical problem to be solved with better code, but necessarily involves making a value-laden choice about which conception of fairness should be prioritized in a given context.',
          'question': 'According to the passage, algorithmic decision-making systems are increasingly used in areas such as:',
          'options': ['loan approval, hiring, and criminal sentencing recommendations', 'only video game design', 'only weather forecasting', 'only academic grading of essays'],
          'correct': 0,
        },
        {
          'passage': 'Algorithmic decision-making systems, increasingly used in areas such as loan approval, hiring, and criminal sentencing recommendations, raise distinctive ethical concerns about fairness. One key insight from this debate is that different, individually reasonable-sounding definitions of \'fairness\' can conflict mathematically, such that a system cannot simultaneously satisfy all of them at once when underlying group base rates differ. For example, a system could be calibrated to have equal accuracy across demographic groups, or to have equal false-positive rates across those groups, but in many realistic cases these two goals cannot both be perfectly achieved simultaneously. This means that designing a \'fair\' algorithm is not merely a technical problem to be solved with better code, but necessarily involves making a value-laden choice about which conception of fairness should be prioritized in a given context.',
          'question': 'According to the passage, what key mathematical insight complicates the design of \'fair\' algorithms?',
          'options': ['fairness can always be perfectly achieved with enough computing power', 'fairness is entirely unrelated to mathematics', 'all definitions of fairness are mathematically identical', 'different reasonable definitions of fairness can conflict mathematically and cannot all be satisfied simultaneously when group base rates differ'],
          'correct': 3,
        },
        {
          'passage': 'Algorithmic decision-making systems, increasingly used in areas such as loan approval, hiring, and criminal sentencing recommendations, raise distinctive ethical concerns about fairness. One key insight from this debate is that different, individually reasonable-sounding definitions of \'fairness\' can conflict mathematically, such that a system cannot simultaneously satisfy all of them at once when underlying group base rates differ. For example, a system could be calibrated to have equal accuracy across demographic groups, or to have equal false-positive rates across those groups, but in many realistic cases these two goals cannot both be perfectly achieved simultaneously. This means that designing a \'fair\' algorithm is not merely a technical problem to be solved with better code, but necessarily involves making a value-laden choice about which conception of fairness should be prioritized in a given context.',
          'question': 'According to the passage, what two example fairness goals are given as potentially incompatible?',
          'options': ['equal accuracy across groups and equal false-positive rates across groups', 'equal processing speed and equal memory usage', 'equal profit and equal market share', 'equal training data size and equal testing data size'],
          'correct': 0,
        },
        {
          'passage': 'Algorithmic decision-making systems, increasingly used in areas such as loan approval, hiring, and criminal sentencing recommendations, raise distinctive ethical concerns about fairness. One key insight from this debate is that different, individually reasonable-sounding definitions of \'fairness\' can conflict mathematically, such that a system cannot simultaneously satisfy all of them at once when underlying group base rates differ. For example, a system could be calibrated to have equal accuracy across demographic groups, or to have equal false-positive rates across those groups, but in many realistic cases these two goals cannot both be perfectly achieved simultaneously. This means that designing a \'fair\' algorithm is not merely a technical problem to be solved with better code, but necessarily involves making a value-laden choice about which conception of fairness should be prioritized in a given context.',
          'question': 'According to the passage, what does this mean for designing a \'fair\' algorithm?',
          'options': ['only one definition of fairness has ever been proposed', 'fairness is irrelevant to algorithm design', 'it is not merely a technical problem, but necessarily involves a value-laden choice about which conception of fairness to prioritize', 'it is a purely technical problem solvable with better code alone Passage 2 Privacy in the digital age is often discussed using the concept of \'contextual integrity,\' developed by philosopher Helen Nissenbaum, which holds that privacy is not simply about keeping information totally secret, but about ensuring that information flows appropriately according to the norms of the specific context in which it was originally shared. On this view, sharing a medical diagnosis with a treating physician does not violate privacy, since this flow matches established norms for that context, but the same information being sold to an advertising company would violate privacy, even if no new secrecy has technically been broken, because the information has moved into a context governed by very different norms and expectations. This framework helps explain why many people feel their privacy has been violated by data practices that are technically permitted under a service\'s stated terms, but that nonetheless move information in ways that clash with contextual expectations.'],
          'correct': 2,
        },
        {
          'passage': 'Privacy in the digital age is often discussed using the concept of \'contextual integrity,\' developed by philosopher Helen Nissenbaum, which holds that privacy is not simply about keeping information totally secret, but about ensuring that information flows appropriately according to the norms of the specific context in which it was originally shared. On this view, sharing a medical diagnosis with a treating physician does not violate privacy, since this flow matches established norms for that context, but the same information being sold to an advertising company would violate privacy, even if no new secrecy has technically been broken, because the information has moved into a context governed by very different norms and expectations. This framework helps explain why many people feel their privacy has been violated by data practices that are technically permitted under a service\'s stated terms, but that nonetheless move information in ways that clash with contextual expectations.',
          'question': 'According to the passage, \'contextual integrity\' holds that privacy is about:',
          'options': ['ensuring information flows appropriately according to the norms of the context in which it was shared', 'a concept unrelated to how information is shared', 'keeping all personal information totally secret at all times', 'allowing unrestricted flow of information in every context'],
          'correct': 0,
        },
        {
          'passage': 'Privacy in the digital age is often discussed using the concept of \'contextual integrity,\' developed by philosopher Helen Nissenbaum, which holds that privacy is not simply about keeping information totally secret, but about ensuring that information flows appropriately according to the norms of the specific context in which it was originally shared. On this view, sharing a medical diagnosis with a treating physician does not violate privacy, since this flow matches established norms for that context, but the same information being sold to an advertising company would violate privacy, even if no new secrecy has technically been broken, because the information has moved into a context governed by very different norms and expectations. This framework helps explain why many people feel their privacy has been violated by data practices that are technically permitted under a service\'s stated terms, but that nonetheless move information in ways that clash with contextual expectations.',
          'question': 'According to the passage, why does sharing a medical diagnosis with a treating physician not violate privacy?',
          'options': ['because physicians are legally required to keep no records', 'because medical information is not considered private at all', 'because this sharing never actually happens in practice', 'this flow matches established norms for that specific context'],
          'correct': 3,
        },
        {
          'passage': 'Privacy in the digital age is often discussed using the concept of \'contextual integrity,\' developed by philosopher Helen Nissenbaum, which holds that privacy is not simply about keeping information totally secret, but about ensuring that information flows appropriately according to the norms of the specific context in which it was originally shared. On this view, sharing a medical diagnosis with a treating physician does not violate privacy, since this flow matches established norms for that context, but the same information being sold to an advertising company would violate privacy, even if no new secrecy has technically been broken, because the information has moved into a context governed by very different norms and expectations. This framework helps explain why many people feel their privacy has been violated by data practices that are technically permitted under a service\'s stated terms, but that nonetheless move information in ways that clash with contextual expectations.',
          'question': 'According to the passage, why would selling the same medical information to an advertiser violate privacy?',
          'options': ['because advertisers are legally prohibited from ever receiving any data', 'because no secrecy has ever been broken in this scenario', 'the information has moved into a context governed by very different norms and expectations', 'because medical information cannot be digitized'],
          'correct': 2,
        },
        {
          'passage': 'Privacy in the digital age is often discussed using the concept of \'contextual integrity,\' developed by philosopher Helen Nissenbaum, which holds that privacy is not simply about keeping information totally secret, but about ensuring that information flows appropriately according to the norms of the specific context in which it was originally shared. On this view, sharing a medical diagnosis with a treating physician does not violate privacy, since this flow matches established norms for that context, but the same information being sold to an advertising company would violate privacy, even if no new secrecy has technically been broken, because the information has moved into a context governed by very different norms and expectations. This framework helps explain why many people feel their privacy has been violated by data practices that are technically permitted under a service\'s stated terms, but that nonetheless move information in ways that clash with contextual expectations.',
          'question': 'According to the passage, what does this framework help explain?',
          'options': ['why privacy concerns are always irrational', 'why no data practices are ever ethically concerning', 'why people feel their privacy has been violated even by data practices technically permitted under a service\'s terms', 'why terms of service agreements are always perfectly clear Passage 3 The rapid development of artificial intelligence has intensified debates about accountability: when an AI system causes harm — for instance, an autonomous vehicle causing an accident, or an algorithmic hiring tool systematically disadvantaging a protected group — who should bear moral and legal responsibility? Candidates include the individual engineers who wrote the code, the company that deployed the system, the organization that supplied the training data, or, in more speculative future scenarios, the AI system itself. Most philosophers and legal scholars currently reject attributing genuine moral responsibility to the AI system itself, since current systems lack the kind of understanding, intention, or capacity for genuine choice that responsibility is traditionally thought to require, arguing instead that responsibility should be distributed among the various human and institutional actors involved in a system\'s design, deployment, and oversight.'],
          'correct': 2,
        },
        {
          'passage': 'The rapid development of artificial intelligence has intensified debates about accountability: when an AI system causes harm — for instance, an autonomous vehicle causing an accident, or an algorithmic hiring tool systematically disadvantaging a protected group — who should bear moral and legal responsibility? Candidates include the individual engineers who wrote the code, the company that deployed the system, the organization that supplied the training data, or, in more speculative future scenarios, the AI system itself. Most philosophers and legal scholars currently reject attributing genuine moral responsibility to the AI system itself, since current systems lack the kind of understanding, intention, or capacity for genuine choice that responsibility is traditionally thought to require, arguing instead that responsibility should be distributed among the various human and institutional actors involved in a system\'s design, deployment, and oversight.',
          'question': 'According to the passage, what has intensified debates about accountability?',
          'options': ['the rapid development of artificial intelligence', 'a decline in the use of computers generally', 'the invention of the printing press', 'a decrease in government regulation of all industries'],
          'correct': 0,
        },
        {
          'passage': 'The rapid development of artificial intelligence has intensified debates about accountability: when an AI system causes harm — for instance, an autonomous vehicle causing an accident, or an algorithmic hiring tool systematically disadvantaging a protected group — who should bear moral and legal responsibility? Candidates include the individual engineers who wrote the code, the company that deployed the system, the organization that supplied the training data, or, in more speculative future scenarios, the AI system itself. Most philosophers and legal scholars currently reject attributing genuine moral responsibility to the AI system itself, since current systems lack the kind of understanding, intention, or capacity for genuine choice that responsibility is traditionally thought to require, arguing instead that responsibility should be distributed among the various human and institutional actors involved in a system\'s design, deployment, and oversight.',
          'question': 'According to the passage, what candidates are considered for bearing responsibility when an AI system causes harm?',
          'options': ['only international regulatory bodies', 'only the end user who purchased the product', 'the engineers, the deploying company, the data supplier, or, speculatively, the AI system itself', 'only the original inventor of computing hardware'],
          'correct': 2,
        },
        {
          'passage': 'The rapid development of artificial intelligence has intensified debates about accountability: when an AI system causes harm — for instance, an autonomous vehicle causing an accident, or an algorithmic hiring tool systematically disadvantaging a protected group — who should bear moral and legal responsibility? Candidates include the individual engineers who wrote the code, the company that deployed the system, the organization that supplied the training data, or, in more speculative future scenarios, the AI system itself. Most philosophers and legal scholars currently reject attributing genuine moral responsibility to the AI system itself, since current systems lack the kind of understanding, intention, or capacity for genuine choice that responsibility is traditionally thought to require, arguing instead that responsibility should be distributed among the various human and institutional actors involved in a system\'s design, deployment, and oversight.',
          'question': 'According to the passage, do most philosophers and legal scholars currently attribute genuine moral responsibility to the AI system itself?',
          'options': ['the passage does not address this question', 'no, most currently reject this attribution', 'yes, but only for autonomous vehicles specifically', 'yes, most currently attribute full responsibility to the AI itself'],
          'correct': 1,
        },
        {
          'passage': 'The rapid development of artificial intelligence has intensified debates about accountability: when an AI system causes harm — for instance, an autonomous vehicle causing an accident, or an algorithmic hiring tool systematically disadvantaging a protected group — who should bear moral and legal responsibility? Candidates include the individual engineers who wrote the code, the company that deployed the system, the organization that supplied the training data, or, in more speculative future scenarios, the AI system itself. Most philosophers and legal scholars currently reject attributing genuine moral responsibility to the AI system itself, since current systems lack the kind of understanding, intention, or capacity for genuine choice that responsibility is traditionally thought to require, arguing instead that responsibility should be distributed among the various human and institutional actors involved in a system\'s design, deployment, and oversight.',
          'question': 'According to the passage, why do most scholars reject attributing responsibility to the AI system itself?',
          'options': ['AI systems are considered legally identical to human beings', 'responsibility cannot be distributed among multiple parties', 'AI systems have never been involved in causing any harm', 'current systems lack the understanding, intention, or capacity for genuine choice that responsibility is thought to require Passage 4 Surveillance technology, including facial recognition, location tracking, and large-scale data aggregation, has prompted renewed philosophical attention to the value of privacy itself: why, exactly, does privacy matter, beyond simply preventing concrete harms like fraud or identity theft? One influential answer holds that privacy is important because it enables autonomy — the ability to develop one\'s own beliefs, relationships, and identity without constant observation, which can otherwise produce a subtle but significant chilling effect on behavior, since people often act differently, and less freely, when they know they are being watched. A related concern is that pervasive surveillance can shift power dramatically toward whoever controls the surveillance infrastructure, whether a government or a private company, potentially enabling forms of social control disproportionate to any legitimate need the surveillance was originally designed to serve.'],
          'correct': 3,
        },
        {
          'passage': 'Surveillance technology, including facial recognition, location tracking, and large-scale data aggregation, has prompted renewed philosophical attention to the value of privacy itself: why, exactly, does privacy matter, beyond simply preventing concrete harms like fraud or identity theft? One influential answer holds that privacy is important because it enables autonomy — the ability to develop one\'s own beliefs, relationships, and identity without constant observation, which can otherwise produce a subtle but significant chilling effect on behavior, since people often act differently, and less freely, when they know they are being watched. A related concern is that pervasive surveillance can shift power dramatically toward whoever controls the surveillance infrastructure, whether a government or a private company, potentially enabling forms of social control disproportionate to any legitimate need the surveillance was originally designed to serve.',
          'question': 'According to the passage, one influential answer holds that privacy is important because it enables:',
          'options': ['a reduction in overall government spending', 'increased advertising revenue for technology companies', 'faster processing speeds for computer systems', 'autonomy — the ability to develop one\'s own beliefs, relationships, and identity without constant observation'],
          'correct': 3,
        },
        {
          'passage': 'Surveillance technology, including facial recognition, location tracking, and large-scale data aggregation, has prompted renewed philosophical attention to the value of privacy itself: why, exactly, does privacy matter, beyond simply preventing concrete harms like fraud or identity theft? One influential answer holds that privacy is important because it enables autonomy — the ability to develop one\'s own beliefs, relationships, and identity without constant observation, which can otherwise produce a subtle but significant chilling effect on behavior, since people often act differently, and less freely, when they know they are being watched. A related concern is that pervasive surveillance can shift power dramatically toward whoever controls the surveillance infrastructure, whether a government or a private company, potentially enabling forms of social control disproportionate to any legitimate need the surveillance was originally designed to serve.',
          'question': 'According to the passage, what \'chilling effect\' can constant observation produce?',
          'options': ['people always behave more honestly when observed', 'observation has no measurable effect on behavior', 'people become entirely unaffected by being observed', 'people often act differently, and less freely, when they know they are being watched'],
          'correct': 3,
        },
        {
          'passage': 'Surveillance technology, including facial recognition, location tracking, and large-scale data aggregation, has prompted renewed philosophical attention to the value of privacy itself: why, exactly, does privacy matter, beyond simply preventing concrete harms like fraud or identity theft? One influential answer holds that privacy is important because it enables autonomy — the ability to develop one\'s own beliefs, relationships, and identity without constant observation, which can otherwise produce a subtle but significant chilling effect on behavior, since people often act differently, and less freely, when they know they are being watched. A related concern is that pervasive surveillance can shift power dramatically toward whoever controls the surveillance infrastructure, whether a government or a private company, potentially enabling forms of social control disproportionate to any legitimate need the surveillance was originally designed to serve.',
          'question': 'According to the passage, what related concern exists regarding surveillance infrastructure?',
          'options': ['only governments, never private companies, can control surveillance infrastructure', 'pervasive surveillance can shift power dramatically toward whoever controls that infrastructure', 'surveillance infrastructure has no connection to questions of power', 'surveillance always benefits the individuals being observed'],
          'correct': 1,
        },
        {
          'passage': 'Surveillance technology, including facial recognition, location tracking, and large-scale data aggregation, has prompted renewed philosophical attention to the value of privacy itself: why, exactly, does privacy matter, beyond simply preventing concrete harms like fraud or identity theft? One influential answer holds that privacy is important because it enables autonomy — the ability to develop one\'s own beliefs, relationships, and identity without constant observation, which can otherwise produce a subtle but significant chilling effect on behavior, since people often act differently, and less freely, when they know they are being watched. A related concern is that pervasive surveillance can shift power dramatically toward whoever controls the surveillance infrastructure, whether a government or a private company, potentially enabling forms of social control disproportionate to any legitimate need the surveillance was originally designed to serve.',
          'question': 'According to the passage, what could this shift in power potentially enable?',
          'options': ['a complete and permanent elimination of all forms of crime', 'a guaranteed increase in individual autonomy', 'forms of social control disproportionate to any legitimate need the surveillance was designed to serve', 'an automatic improvement in government accountability Passage 5 Debates about the ethics of automation and job displacement often distinguish between short-term transitional effects and longer-term structural questions. In the short term, workers displaced by automation in a specific industry may face genuine hardship, including lost income and the need for retraining, even if new jobs are eventually created elsewhere in the economy. Longer-term structural questions concern whether automation, over time, tends to increase economic inequality by disproportionately rewarding those who own capital and advanced technical skills, relative to workers whose labor is more easily automated. Some ethicists and economists argue that addressing these concerns requires proactive social policy — such as robust retraining programs, strengthened social safety nets, or proposals like a universal basic income — rather than assuming that market forces alone will produce a fair distribution of automation\'s benefits and costs.'],
          'correct': 2,
        },
        {
          'passage': 'Debates about the ethics of automation and job displacement often distinguish between short-term transitional effects and longer-term structural questions. In the short term, workers displaced by automation in a specific industry may face genuine hardship, including lost income and the need for retraining, even if new jobs are eventually created elsewhere in the economy. Longer-term structural questions concern whether automation, over time, tends to increase economic inequality by disproportionately rewarding those who own capital and advanced technical skills, relative to workers whose labor is more easily automated. Some ethicists and economists argue that addressing these concerns requires proactive social policy — such as robust retraining programs, strengthened social safety nets, or proposals like a universal basic income — rather than assuming that market forces alone will produce a fair distribution of automation\'s benefits and costs.',
          'question': 'According to the passage, what distinction is often made in debates about automation and job displacement?',
          'options': ['legal automation versus illegal automation', 'short-term transitional effects versus longer-term structural questions', 'voluntary automation versus involuntary automation', 'domestic automation versus international automation'],
          'correct': 1,
        },
        {
          'passage': 'Debates about the ethics of automation and job displacement often distinguish between short-term transitional effects and longer-term structural questions. In the short term, workers displaced by automation in a specific industry may face genuine hardship, including lost income and the need for retraining, even if new jobs are eventually created elsewhere in the economy. Longer-term structural questions concern whether automation, over time, tends to increase economic inequality by disproportionately rewarding those who own capital and advanced technical skills, relative to workers whose labor is more easily automated. Some ethicists and economists argue that addressing these concerns requires proactive social policy — such as robust retraining programs, strengthened social safety nets, or proposals like a universal basic income — rather than assuming that market forces alone will produce a fair distribution of automation\'s benefits and costs.',
          'question': 'According to the passage, what might displaced workers face in the short term?',
          'options': ['genuine hardship, including lost income and the need for retraining', 'no effects whatsoever on their employment', 'automatic lifetime employment guarantees', 'an immediate and guaranteed increase in income'],
          'correct': 0,
        },
        {
          'passage': 'Debates about the ethics of automation and job displacement often distinguish between short-term transitional effects and longer-term structural questions. In the short term, workers displaced by automation in a specific industry may face genuine hardship, including lost income and the need for retraining, even if new jobs are eventually created elsewhere in the economy. Longer-term structural questions concern whether automation, over time, tends to increase economic inequality by disproportionately rewarding those who own capital and advanced technical skills, relative to workers whose labor is more easily automated. Some ethicists and economists argue that addressing these concerns requires proactive social policy — such as robust retraining programs, strengthened social safety nets, or proposals like a universal basic income — rather than assuming that market forces alone will produce a fair distribution of automation\'s benefits and costs.',
          'question': 'According to the passage, what longer-term structural question is raised about automation?',
          'options': ['whether automation tends to increase economic inequality by rewarding capital owners and skilled workers over easily automated labor', 'whether automation has any connection to economic inequality at all', 'whether automation only affects a single industry forever', 'whether automation will ever be technically possible'],
          'correct': 0,
        },
        {
          'passage': 'Debates about the ethics of automation and job displacement often distinguish between short-term transitional effects and longer-term structural questions. In the short term, workers displaced by automation in a specific industry may face genuine hardship, including lost income and the need for retraining, even if new jobs are eventually created elsewhere in the economy. Longer-term structural questions concern whether automation, over time, tends to increase economic inequality by disproportionately rewarding those who own capital and advanced technical skills, relative to workers whose labor is more easily automated. Some ethicists and economists argue that addressing these concerns requires proactive social policy — such as robust retraining programs, strengthened social safety nets, or proposals like a universal basic income — rather than assuming that market forces alone will produce a fair distribution of automation\'s benefits and costs.',
          'question': 'According to the passage, what do some ethicists and economists argue is needed to address these concerns?',
          'options': ['proactive social policy, such as retraining programs, safety nets, or universal basic income', 'a complete ban on all forms of automation', 'the elimination of all social safety net programs', 'reliance solely on market forces with no policy intervention'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the ethical concept of \'algorithmic transparency\'?',
          'options': ['the principle that the workings or reasoning of an algorithmic system should be understandable or explainable to those affected by its decisions', 'the requirement that all algorithms be published as open-source code with no exceptions', 'a term describing how quickly an algorithm processes data', 'a synonym for algorithmic fairness with no distinct meaning'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes \'the right to explanation,\' sometimes discussed in the context of automated decision-making?',
          'options': ['a synonym for the right to privacy with no distinct meaning', 'a right to have all algorithms banned entirely', 'a right that applies only to decisions made by human beings, never machines', 'a proposed or legally recognized right for individuals to receive a meaningful explanation of an automated decision that significantly affects them'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'informational self-determination\' as a value in digital ethics?',
          'options': ['a corporation\'s right to use any data it collects without restriction', 'a government\'s ability to control all information flowing within its borders', 'a synonym for algorithmic transparency', 'an individual\'s ability to control how their own personal information is collected, used, and shared'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a key ethical concern regarding the use of facial recognition technology by law enforcement?',
          'options': ['facial recognition raises no privacy concerns whatsoever', 'concerns about accuracy disparities across demographic groups, and the potential for mass surveillance without adequate oversight', 'facial recognition is universally banned in all jurisdictions', 'facial recognition technology has been proven equally accurate across all demographic groups in every study'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'techno-solutionism,\' a term often used critically in tech ethics?',
          'options': ['a synonym for the precautionary principle', 'the tendency to assume that complex social problems can be adequately addressed primarily through technological fixes, without sufficient attention to underlying social or political causes', 'the view that technology can never solve any social problem whatsoever', 'a term describing a specific software engineering methodology'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'value-sensitive design,\' an approach in technology ethics and design?',
          'options': ['a design methodology focused exclusively on minimizing manufacturing cost', 'a synonym for planned obsolescence', 'a design methodology that seeks to proactively account for human values, such as fairness, privacy, and autonomy, throughout the technology design process', 'a legal requirement applying only to government-built technology'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes \'data minimization\' as a principle in data ethics and privacy law?',
          'options': ['a principle requiring the permanent deletion of all collected data immediately', 'a synonym for data encryption', 'the practice of collecting as much data as technically possible at all times', 'the practice of collecting only the data that is genuinely necessary for a specified, legitimate purpose'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes the ethical concern known as \'function creep\' in the context of data collection technologies?',
          'options': ['a term describing planned software updates', 'data or technology originally collected or built for one specific purpose gradually being used for additional, different purposes without renewed consent or scrutiny', 'a synonym for algorithmic bias', 'a technical malfunction that causes a system to stop working entirely'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why \'consent\' for data collection online is sometimes considered ethically inadequate in practice, despite being technically obtained?',
          'options': ['consent is legally irrelevant to any data collection practice', 'lengthy, complex terms of service may not be genuinely read or understood, raising questions about whether consent is truly informed and meaningful', 'online consent mechanisms are always perfectly clear and universally read in full by users', 'consent obtained online is always considered more meaningful than consent obtained in person'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes \'algorithmic accountability\'?',
          'options': ['a term applying only to algorithms used in scientific research', 'the idea that individuals or institutions responsible for deploying an algorithmic system should be answerable for its outcomes, including harms it causes', 'a principle holding that algorithms themselves bear full legal responsibility for their outputs', 'a synonym for algorithmic transparency with no distinct meaning'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes the ethical significance of \'digital consent for minors,\' a growing concern in tech ethics?',
          'options': ['this concern applies only to educational technology, never entertainment platforms', 'children may lack the developmental capacity to fully understand the long-term implications of sharing personal data, raising special ethical obligations for platforms and guardians', 'minors are prohibited from using any digital technology under all circumstances', 'children are considered legally identical to adults in every data protection context'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes a central ethical question raised by the development of increasingly autonomous weapons systems?',
          'options': ['whether autonomous weapons systems are technically feasible to build at all', 'whether autonomous weapons have ever been discussed in any international forum', 'whether it is morally acceptable to delegate life-and-death targeting decisions to a machine without direct, real-time human judgment and accountability', 'whether this question has already been definitively and permanently resolved'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why some ethicists distinguish between \'privacy as secrecy\' and \'privacy as control,\' as discussed in digital ethics?',
          'options': ['privacy as control has no relevance to modern digital technology', 'these two concepts are considered completely identical in every ethical analysis', 'privacy as secrecy is now considered the only valid definition of privacy', 'the former focuses narrowly on hiding information, while the latter emphasizes an individual\'s ability to manage how their information is used and shared, even if not secret'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes why tech ethics is often considered an inherently interdisciplinary field?',
          'options': ['tech ethics can be fully addressed using only computer programming skills', 'tech ethics has no meaningful connection to philosophy', 'legal and social considerations are irrelevant to evaluating new technologies', 'addressing technology\'s ethical implications typically requires combining philosophical analysis with technical, legal, and social scientific understanding'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes \'algorithmic paternalism\' as a concern in tech ethics?',
          'options': ['the concern that a platform\'s design choices may steer user behavior in ways users did not explicitly choose, based on the platform\'s judgment of their best interest', 'a term describing algorithms designed exclusively for use by parents', 'a legal requirement that all algorithms be reviewed by a government paternal authority', 'a synonym for algorithmic transparency'],
          'correct': 0,
        },
        {
          'question': 'Which of the following best describes the ethical tension between personalization and privacy in recommendation systems?',
          'options': ['greater personalization always improves privacy protection', 'more effective personalization typically requires collecting and analyzing more personal data, which can increase privacy risk', 'recommendation systems require no personal data to function effectively', 'personalization and privacy are entirely unrelated concerns with no tradeoff'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best describes why some ethicists argue for a \'right to be forgotten\' regarding online information?',
          'options': ['this concept has no legal or ethical basis anywhere in the world', 'the right to be forgotten requires the complete deletion of the entire internet', 'the right to be forgotten applies only to public figures, never private individuals', 'individuals may have a legitimate interest in having certain outdated, irrelevant, or harmful personal information removed from easy public access online'],
          'correct': 3,
        },
        {
          'question': 'Which of the following best describes a common ethical critique of \'dark patterns\' in user interface design?',
          'options': ['dark patterns are user interface designs that use a black-and-white color scheme', 'this term applies only to physical product packaging, not digital interfaces', 'such designs deliberately manipulate or mislead users into taking actions, such as unintended purchases or data sharing, that they might not otherwise choose', 'dark patterns are always fully transparent and clearly disclosed to users'],
          'correct': 2,
        },
        {
          'question': 'Which of the following best describes why some scholars argue that access to reliable internet connectivity has become an ethical issue of justice, not merely convenience?',
          'options': ['this concern is unrelated to broader questions about the digital divide', 'internet access increasingly determines access to essential services, information, education, and economic opportunity', 'internet access has no bearing on access to education or economic opportunity', 'internet connectivity is universally and equally available to all people already'],
          'correct': 1,
        },
        {
          'question': 'Which of the following best summarizes a recurring theme across tech ethics topics such as algorithmic fairness, privacy, AI accountability, and automation?',
          'options': ['ethical concerns about technology apply only to artificial intelligence, not other technologies', 'technical systems embed and interact with human values and social structures, so evaluating them well requires more than purely technical analysis', 'all technology-related ethical questions have already been fully and permanently resolved', 'technology is entirely value-neutral and ethical analysis of it is therefore unnecessary'],
          'correct': 1,
        },
      ];
    default:
      return [];
  }
}