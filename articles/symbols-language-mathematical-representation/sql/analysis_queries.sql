.headers on
.mode column

.print 'Objects and representations'
SELECT
  o.name AS object_name,
  o.object_type,
  r.representation_type,
  r.notation_or_format,
  r.preserved_structure,
  r.omitted_detail
FROM representation r
JOIN mathematical_object o ON o.object_id = r.object_id
ORDER BY o.object_type, o.name, r.representation_type;

.print ''
.print 'Translation map'
SELECT
  s.representation_id AS source_representation,
  t.representation_id AS target_representation,
  tr.translation_rule,
  tr.validity_condition
FROM translation tr
JOIN representation s ON s.representation_id = tr.source_representation_id
JOIN representation t ON t.representation_id = tr.target_representation_id
ORDER BY tr.translation_id;

.print ''
.print 'Notation symbols'
SELECT symbol, typical_meaning, mathematical_role, ambiguity_warning
FROM notation_symbol
ORDER BY symbol_id;

.print ''
.print 'Representation warnings'
SELECT
  r.representation_type,
  r.notation_or_format,
  w.warning,
  w.mitigation
FROM representation_warning w
JOIN representation r ON r.representation_id = w.representation_id
ORDER BY w.warning_id;
