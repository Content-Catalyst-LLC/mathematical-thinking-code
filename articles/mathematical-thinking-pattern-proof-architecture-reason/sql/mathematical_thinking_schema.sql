-- Mathematical Thinking SQL schema
-- Educational schema for concepts, examples, theorems, and proof steps.

CREATE TABLE IF NOT EXISTS mathematical_concepts (
    concept_id INTEGER PRIMARY KEY,
    concept_name TEXT NOT NULL,
    domain TEXT NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS mathematical_examples (
    example_id INTEGER PRIMARY KEY,
    concept_id INTEGER NOT NULL,
    example_label TEXT NOT NULL,
    example_expression TEXT NOT NULL,
    interpretation TEXT NOT NULL,
    FOREIGN KEY (concept_id) REFERENCES mathematical_concepts(concept_id)
);

CREATE TABLE IF NOT EXISTS theorems (
    theorem_id INTEGER PRIMARY KEY,
    theorem_name TEXT NOT NULL,
    statement TEXT NOT NULL,
    domain TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS proof_steps (
    proof_step_id INTEGER PRIMARY KEY,
    theorem_id INTEGER NOT NULL,
    step_order INTEGER NOT NULL,
    step_type TEXT NOT NULL,
    step_description TEXT NOT NULL,
    depends_on_step_id INTEGER,
    FOREIGN KEY (theorem_id) REFERENCES theorems(theorem_id),
    FOREIGN KEY (depends_on_step_id) REFERENCES proof_steps(proof_step_id)
);

INSERT INTO mathematical_concepts
(concept_id, concept_name, domain, description)
VALUES
(1, 'Pattern', 'Foundations', 'A recurring or invariant structure that invites generalization.'),
(2, 'Proof', 'Logic', 'A structured justification showing why a mathematical claim follows from assumptions.'),
(3, 'Recursion', 'Discrete Mathematics', 'A definition or process in which later states depend on earlier states.'),
(4, 'Graph', 'Discrete Mathematics', 'A structure consisting of vertices and edges used to model relationships.');

INSERT INTO theorems
(theorem_id, theorem_name, statement, domain)
VALUES
(1, 'Triangular Number Formula', 'For every positive integer n, 1 + 2 + ... + n = n(n+1)/2.', 'Number and Proof');

INSERT INTO proof_steps
(proof_step_id, theorem_id, step_order, step_type, step_description, depends_on_step_id)
VALUES
(1, 1, 1, 'Base Case', 'Verify the statement for n = 1.', NULL),
(2, 1, 2, 'Inductive Hypothesis', 'Assume the statement holds for n = k.', NULL),
(3, 1, 3, 'Inductive Step', 'Show the statement holds for n = k + 1.', 2),
(4, 1, 4, 'Conclusion', 'By induction, the statement holds for all positive integers.', 3);
