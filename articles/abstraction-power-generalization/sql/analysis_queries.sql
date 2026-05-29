.headers on
.mode column

.print 'Abstractions: preserved and omitted structure'
SELECT name, preserved_structure, omitted_detail
FROM abstraction
ORDER BY name;

.print ''
.print 'Generalizations with proof status'
SELECT
  g.generalization_id,
  a.name AS abstraction,
  g.claim,
  g.domain,
  g.required_assumptions,
  g.proof_status
FROM generalization g
JOIN abstraction a ON a.abstraction_id = g.abstraction_id
ORDER BY g.generalization_id;

.print ''
.print 'Counterexample audit'
SELECT
  g.claim,
  c.object_description,
  c.failure_mode,
  c.lesson
FROM counterexample c
JOIN generalization g ON g.generalization_id = c.generalization_id
ORDER BY c.counterexample_id;

.print ''
.print 'Mappings and preservation warnings'
SELECT name, source_structure, target_structure, preserved_relation, warning
FROM mapping
ORDER BY mapping_id;

.print ''
.print 'Invariant catalog'
SELECT name, object_class, transformation_class, description
FROM invariant
ORDER BY object_class, name;
