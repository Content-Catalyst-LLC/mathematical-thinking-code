.headers on
.mode column

.print 'Geometric objects'
SELECT object_id, object_type, name
FROM geometric_object
ORDER BY object_type, object_id;

.print ''
.print 'Representations and omitted detail'
SELECT
  r.representation_id,
  o.name AS object_name,
  r.representation_type,
  r.preserved_structure,
  r.omitted_detail
FROM geometric_representation r
JOIN geometric_object o ON o.object_id = r.object_id
ORDER BY r.representation_type, r.representation_id;

.print ''
.print 'Transformations and preserved structures'
SELECT name, transformation_type, changes, preserves, risk_note
FROM transformation_audit
ORDER BY transformation_id;

.print ''
.print 'Diagram warnings'
SELECT
  r.representation_type,
  r.representation_text,
  w.warning,
  w.mitigation
FROM diagram_warning w
JOIN geometric_representation r ON r.representation_id = w.representation_id
ORDER BY w.warning_id;

.print ''
.print 'Invariants'
SELECT name, preserved_by, description
FROM invariant
ORDER BY invariant_id;

.print ''
.print 'Visualization risks'
SELECT name, description, responsible_check
FROM visualization_risk
ORDER BY risk_id;
