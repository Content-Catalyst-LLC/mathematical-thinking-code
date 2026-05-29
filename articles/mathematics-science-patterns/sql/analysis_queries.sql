.headers on
.mode column

.print 'Pattern domains'
SELECT domain_id, name, description
FROM pattern_domain
ORDER BY domain_id;

.print ''
.print 'Pattern records by domain'
SELECT
  d.name AS domain,
  p.name AS pattern,
  p.pattern_type,
  p.mathematical_structure,
  p.evidence_type,
  p.proof_status,
  p.interpretive_warning
FROM pattern_record p
JOIN pattern_domain d ON d.domain_id = p.domain_id
ORDER BY d.name, p.name;

.print ''
.print 'Counterexample discipline'
SELECT
  p.name AS pattern,
  c.claim,
  c.object_description,
  c.lesson
FROM counterexample_record c
JOIN pattern_record p ON p.pattern_id = c.pattern_id
ORDER BY c.counterexample_id;

.print ''
.print 'Invariant catalog'
SELECT
  name,
  object_class,
  transformation_class,
  description,
  completeness_warning
FROM invariant_record
ORDER BY object_class, name;
