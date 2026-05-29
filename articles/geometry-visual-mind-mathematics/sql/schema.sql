PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS visualization_risk;
DROP TABLE IF EXISTS invariant;
DROP TABLE IF EXISTS diagram_warning;
DROP TABLE IF EXISTS transformation_audit;
DROP TABLE IF EXISTS geometric_representation;
DROP TABLE IF EXISTS geometric_object;

CREATE TABLE geometric_object (
  object_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  object_type TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE geometric_representation (
  representation_id TEXT PRIMARY KEY,
  object_id TEXT NOT NULL,
  representation_type TEXT NOT NULL,
  representation_text TEXT NOT NULL,
  preserved_structure TEXT NOT NULL,
  omitted_detail TEXT NOT NULL,
  FOREIGN KEY (object_id) REFERENCES geometric_object(object_id)
);

CREATE TABLE transformation_audit (
  transformation_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  transformation_type TEXT NOT NULL,
  changes TEXT NOT NULL,
  preserves TEXT NOT NULL,
  risk_note TEXT NOT NULL
);

CREATE TABLE diagram_warning (
  warning_id TEXT PRIMARY KEY,
  representation_id TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL,
  FOREIGN KEY (representation_id) REFERENCES geometric_representation(representation_id)
);

CREATE TABLE invariant (
  invariant_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  preserved_by TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE visualization_risk (
  risk_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  responsible_check TEXT NOT NULL
);

INSERT INTO geometric_object VALUES
('obj_point_origin','Origin point','point','The point (0,0) in the Cartesian plane.'),
('obj_segment_ab','Segment AB','segment','A line segment between points A and B.'),
('obj_triangle_345','Three-four-five triangle','triangle','A right triangle with vertices (0,0), (4,0), and (0,3).'),
('obj_unit_square','Unit square','polygon','A square with side length one and four vertices.'),
('obj_unit_circle','Unit circle','circle','All points at distance one from the origin.'),
('obj_cycle_graph','Cycle graph visual layout','graph','A graph representation of a four-node cycle.'),
('obj_topological_loop','Simple loop','topological_object','A closed curve considered up to continuous deformation.');

INSERT INTO geometric_representation VALUES
('rep_triangle_diagram','obj_triangle_345','diagram','drawn right triangle','visual adjacency and approximate shape','exact proof of side lengths and angles'),
('rep_triangle_coordinates','obj_triangle_345','coordinates','(0,0),(4,0),(0,3)','exact coordinate position','visual intuition and construction history'),
('rep_triangle_lengths','obj_triangle_345','measurement_table','3 4 5','side length relation','orientation and placement'),
('rep_circle_equation','obj_unit_circle','equation','x^2+y^2=1','distance-from-origin condition','visual drawing and parametrization'),
('rep_square_vertices','obj_unit_square','coordinate_list','(0,0),(1,0),(1,1),(0,1)','vertex structure','continuous boundary detail'),
('rep_graph_layout','obj_cycle_graph','graph_drawing','cycle graph drawn as square','connectivity if edges are respected','geometric distances may be meaningless'),
('rep_loop_topology','obj_topological_loop','topological_description','simple closed curve','connectivity and hole relation','metric shape and length');

INSERT INTO transformation_audit VALUES
('tr_translate','Translation','isometry','position','distance angle area shape','visual location changes but intrinsic shape does not'),
('tr_rotate90','Rotation','isometry','orientation and coordinates','distance angle area shape','rotation center and orientation must be specified'),
('tr_reflect_x','Reflection','isometry','handedness','distance angle area shape','orientation changes while lengths remain'),
('tr_scale2','Scaling','similarity','size','shape angle ratios','length and area are not preserved'),
('tr_project','Projection','projection','dimension and apparent distance','selected incidence or coordinate relation','information may be lost'),
('tr_deform','Continuous deformation','topological','metric shape','connectivity and holes','requires rules about cutting and gluing');

INSERT INTO diagram_warning VALUES
('warn_special_case','rep_triangle_diagram','A diagram may show a special case with extra symmetry.','Test the general configuration and prove from definitions.'),
('warn_not_to_scale','rep_triangle_diagram','The drawing may not be to scale.','Use measurements or coordinate proof where scale matters.'),
('warn_layout_distance','rep_graph_layout','Graph layout distances may not represent graph distance.','Document whether layout is aesthetic or metric.'),
('warn_projection_loss','rep_square_vertices','Coordinate or projected views may omit higher-dimensional information.','State the represented dimension and lost structure.'),
('warn_visual_realism','rep_circle_equation','A smooth drawing may hide discrete or numerical approximation.','Record exact equation and numerical tolerance.');

INSERT INTO invariant VALUES
('inv_distance','Distance','translation rotation reflection','Euclidean distance between points.'),
('inv_angle','Angle','translation rotation reflection scaling','Angular relation between lines or rays.'),
('inv_area','Area','translation rotation reflection','Two-dimensional measure preserved by isometries but not non-unit scaling.'),
('inv_orientation','Orientation','translation rotation scaling_positive','Handedness or signed direction not preserved by reflection.'),
('inv_connectivity','Connectivity','continuous deformation','Topological connectedness preserved under homeomorphism.'),
('inv_holes','Holes','continuous deformation','Topological hole structure preserved under allowable deformation.');

INSERT INTO visualization_risk VALUES
('risk_special_case','Special case illusion','A diagram appears general but encodes a special case.','Vary the configuration and prove generally.'),
('risk_scale_distortion','Scale distortion','Visual scale exaggerates or hides geometric relation.','Inspect units axes scale and measurement.'),
('risk_projection_loss','Projection loss','A lower-dimensional view loses structure from the original object.','Document what the projection preserves and omits.'),
('risk_numerical_artifact','Numerical artifact','A computational image reflects step size or precision rather than true structure.','Run sensitivity and convergence checks.'),
('risk_false_visual_proof','False visual proof','A picture suggests a theorem without valid justification.','Translate into definitions or proof.');
