PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS graph_model_warning;
DROP TABLE IF EXISTS graph_algorithm_audit;
DROP TABLE IF EXISTS centrality_case;
DROP TABLE IF EXISTS bipartite_edge;
DROP TABLE IF EXISTS graph_edge;
DROP TABLE IF EXISTS graph_node;

CREATE TABLE graph_node (
  node_id TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  node_type TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE graph_edge (
  edge_id TEXT PRIMARY KEY,
  source_node_id TEXT NOT NULL,
  target_node_id TEXT NOT NULL,
  graph_id TEXT NOT NULL,
  directed INTEGER NOT NULL,
  weight REAL,
  relation_type TEXT NOT NULL,
  evidence_note TEXT NOT NULL,
  interpretation TEXT NOT NULL,
  FOREIGN KEY (source_node_id) REFERENCES graph_node(node_id),
  FOREIGN KEY (target_node_id) REFERENCES graph_node(node_id)
);

CREATE TABLE bipartite_edge (
  edge_id TEXT PRIMARY KEY,
  left_node TEXT NOT NULL,
  right_node TEXT NOT NULL,
  left_type TEXT NOT NULL,
  right_type TEXT NOT NULL,
  relation_type TEXT NOT NULL,
  interpretation TEXT NOT NULL
);

CREATE TABLE centrality_case (
  case_id TEXT PRIMARY KEY,
  node_id TEXT NOT NULL,
  metric TEXT NOT NULL,
  value_note TEXT NOT NULL,
  interpretation_risk TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE graph_algorithm_audit (
  algorithm_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  graph_type TEXT NOT NULL,
  input_assumption TEXT NOT NULL,
  output TEXT NOT NULL,
  complexity_note TEXT NOT NULL,
  audit_note TEXT NOT NULL
);

CREATE TABLE graph_model_warning (
  warning_id TEXT PRIMARY KEY,
  graph_id TEXT NOT NULL,
  structure_type TEXT NOT NULL,
  warning TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO graph_node VALUES
('A','Node A','concept','hub-like node in toy undirected graph'),
('B','Node B','concept','bridge between A and D'),
('C','Node C','concept','leaf-like neighbor of A'),
('D','Node D','concept','terminal node connected through B'),
('E','Node E','concept','isolated node'),
('task_define','Define Graph','task','dependency source task'),
('task_traverse','Traverse Graph','task','depends on graph definition'),
('task_interpret','Interpret Network','task','depends on traversal and metrics');

INSERT INTO graph_edge VALUES
('edge_AB','A','B','graph_main',0,1.0,'adjacency','synthetic edge','A adjacent to B'),
('edge_AC','A','C','graph_main',0,1.0,'adjacency','synthetic edge','A adjacent to C'),
('edge_BD','B','D','graph_main',0,1.0,'adjacency','synthetic edge','B adjacent to D'),
('edge_AD_weighted','A','D','graph_weighted',1,7.0,'route','synthetic weight','direct but costly route'),
('edge_AB_weighted','A','B','graph_weighted',1,2.0,'route','synthetic weight','lower-cost route segment'),
('edge_BD_weighted','B','D','graph_weighted',1,3.0,'route','synthetic weight','lower-cost route segment'),
('edge_AC_weighted','A','C','graph_weighted',1,5.0,'route','synthetic weight','alternate route segment'),
('edge_CD_weighted','C','D','graph_weighted',1,1.0,'route','synthetic weight','short final route segment'),
('edge_dep_1','task_define','task_traverse','graph_dependency',1,1.0,'depends_before','synthetic dependency','definition precedes traversal'),
('edge_dep_2','task_traverse','task_interpret','graph_dependency',1,1.0,'depends_before','traversal precedes interpretation');

INSERT INTO bipartite_edge VALUES
('b1','worker_1','task_A','worker','task','can_perform','worker 1 can perform task A'),
('b2','worker_1','task_B','worker','task','can_perform','worker 1 can perform task B'),
('b3','worker_2','task_B','worker','task','can_perform','worker 2 can perform task B'),
('b4','worker_3','task_C','worker','task','can_perform','worker 3 can perform task C'),
('b5','worker_2','task_C','worker','task','can_perform','worker 2 can perform task C');

INSERT INTO centrality_case VALUES
('cent_A','A','degree','high local degree in toy graph','degree may be mistaken for importance','state edge meaning and compare measures'),
('cent_B','B','betweenness_proxy','bridge-like node in path A-B-D','broker position may be burden or vulnerability','interpret in domain context'),
('cent_E','E','isolation','degree zero','isolation may reflect missing data','audit data coverage before interpretation');

INSERT INTO graph_algorithm_audit VALUES
('alg_bfs','Breadth-first search','unweighted graph','valid adjacency list and start vertex','reachable component and shortest unweighted distances','O(V+E)','visited set prevents repeated traversal'),
('alg_dfs','Depth-first search','graph','valid adjacency list and start vertex','traversal order or component','O(V+E)','visited set required for cycles'),
('alg_dijkstra','Dijkstra shortest path','weighted directed graph','nonnegative edge weights','minimum cost distances from source','implementation dependent','weight meaning must be documented'),
('alg_toposort','Topological sort','directed acyclic graph','no directed cycles','dependency-respecting order','O(V+E)','cycle detection required'),
('alg_centrality','Degree centrality','simple graph','edge meaning is consistent','degree count by node','O(V+E)','centrality is structural summary not moral value');

INSERT INTO graph_model_warning VALUES
('warn_layout','graph_main','visualization','Graph layout may imply distances not present in the graph.','State whether layout is aesthetic or metric.'),
('warn_edge_meaning','graph_main','edge','An edge can imply more than the evidence supports.','Define edge meaning, evidence, and provenance.'),
('warn_centrality','graph_main','centrality','Centrality may be confused with importance, authority, or value.','Interpret centrality measure by measure.'),
('warn_weight','graph_weighted','weight','A shortest path depends entirely on what weight means.','Document whether weight means distance, cost, risk, similarity, or capacity.'),
('warn_direction','graph_dependency','direction','A directed relation should not be treated as symmetric.','Audit reachability and direction explicitly.'),
('warn_ai_graph','graph_model','inference','Graph-based inference can propagate false associations or biased edges.','Track provenance, confidence, and downstream consequences.');
