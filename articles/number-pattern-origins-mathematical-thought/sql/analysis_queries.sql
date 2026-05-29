.headers on
.mode column

.print 'Mathematical origins'
SELECT origin_id, name, origin_type, description
FROM mathematical_origin
ORDER BY origin_type, origin_id;

.print ''
.print 'Representation practices'
SELECT
  r.practice_id,
  o.name AS origin_name,
  r.representation_type,
  r.example,
  r.preserved_structure,
  r.omitted_detail
FROM representation_practice r
JOIN mathematical_origin o ON o.origin_id = r.origin_id
ORDER BY r.representation_type;

.print ''
.print 'Pattern records and proof status'
SELECT pattern_id, pattern_type, example, possible_rule, proof_status
FROM pattern_record
ORDER BY pattern_type, pattern_id;

.print ''
.print 'Cultural practices and embedded mathematics'
SELECT name, mathematical_form, embedded_knowledge
FROM cultural_practice
ORDER BY practice_id;

.print ''
.print 'Pattern interpretation warnings'
SELECT
  p.pattern_type,
  p.example,
  p.proof_status,
  w.warning,
  w.mitigation
FROM interpretation_warning w
JOIN pattern_record p ON p.pattern_id = w.pattern_id
ORDER BY w.warning_id;
