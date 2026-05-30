PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS responsible_quantification_check;
DROP TABLE IF EXISTS justice_review;
DROP TABLE IF EXISTS uncertainty_review;
DROP TABLE IF EXISTS ranking_review;
DROP TABLE IF EXISTS aggregation_review;
DROP TABLE IF EXISTS goodhart_record;
DROP TABLE IF EXISTS governance_check;
DROP TABLE IF EXISTS validity_review;
DROP TABLE IF EXISTS metric_risk;
DROP TABLE IF EXISTS metric_record;

CREATE TABLE metric_record (
  metric_id TEXT PRIMARY KEY,
  metric_name TEXT NOT NULL,
  metric_type TEXT NOT NULL,
  target_concept TEXT NOT NULL,
  proxy_or_method TEXT NOT NULL,
  consequence_level TEXT NOT NULL,
  intended_use TEXT NOT NULL,
  invalid_use_warning TEXT NOT NULL
);

CREATE TABLE metric_risk (
  risk_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  risk_name TEXT NOT NULL,
  problem TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE validity_review (
  review_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  construct_validity_note TEXT NOT NULL,
  uncertainty_note TEXT NOT NULL,
  subgroup_review_note TEXT NOT NULL,
  context_note TEXT NOT NULL
);

CREATE TABLE governance_check (
  check_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  documentation_available TEXT NOT NULL,
  contestability_mechanism TEXT NOT NULL,
  audit_frequency TEXT NOT NULL,
  invalid_use_warning TEXT NOT NULL
);

CREATE TABLE goodhart_record (
  goodhart_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  target_goal TEXT NOT NULL,
  optimization_pressure TEXT NOT NULL,
  distortion_mechanism TEXT NOT NULL,
  countermeasure TEXT NOT NULL
);

CREATE TABLE aggregation_review (
  aggregation_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  aggregation_method TEXT NOT NULL,
  what_it_shows TEXT NOT NULL,
  what_it_may_hide TEXT NOT NULL,
  disaggregation_needed TEXT NOT NULL
);

CREATE TABLE ranking_review (
  ranking_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  ranking_basis TEXT NOT NULL,
  instability_source TEXT NOT NULL,
  context_loss TEXT NOT NULL,
  responsible_reporting TEXT NOT NULL
);

CREATE TABLE uncertainty_review (
  uncertainty_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  uncertainty_source TEXT NOT NULL,
  description TEXT NOT NULL,
  communication_method TEXT NOT NULL
);

CREATE TABLE justice_review (
  justice_id TEXT PRIMARY KEY,
  metric_id TEXT NOT NULL,
  recognition_question TEXT NOT NULL,
  distribution_question TEXT NOT NULL,
  voice_question TEXT NOT NULL,
  harm_question TEXT NOT NULL
);

CREATE TABLE responsible_quantification_check (
  check_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  question TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO metric_record VALUES
('met_test_score','Student test score','proxy','learning','standardized assessment','high_stakes','partial evidence about tested academic performance','do not treat as complete measure of learning, potential, school quality, or student worth'),
('met_citation_count','Research citation count','indicator','research influence or scholarly attention','citation database count','moderate_stakes','contextual evidence of scholarly attention','do not use as a standalone measure of quality, rigor, originality, teaching, or public value'),
('met_ai_benchmark','AI benchmark score','benchmark','model capability or reliability','standardized evaluation dataset','high_stakes','compare system performance on tested tasks','do not treat as proof of safety, fairness, robustness, or real deployment reliability'),
('met_sustainability_score','Composite sustainability score','score','sustainability performance','weighted environmental and social indicators','high_stakes','summarize selected sustainability dimensions','do not reduce ecological responsibility or justice to a single number'),
('met_credit_score','Credit risk score','risk_score','loan repayment risk','financial history and credit behavior model','high_stakes','support lending risk evaluation','do not ignore structural exclusion, data gaps, discrimination, or appeal rights'),
('met_institution_rank','Institution ranking','ranking','comparative institutional performance','weighted composite score','moderate_stakes','summarize selected dimensions for comparison','do not treat rank order as precise, context-free, or mission-complete evaluation'),
('met_safety_incident_rate','Reported safety incident rate','indicator','workplace or institutional safety','reported incidents per exposure unit','high_stakes','monitor safety reporting and possible hazard patterns','do not treat low reporting as proof of safety without reporting-culture review');

INSERT INTO metric_risk VALUES
('risk_test_proxy','met_test_score','Proxy substitution','test score substitutes for learning itself','pair test data with classroom, contextual, qualitative, and longitudinal evidence'),
('risk_test_goodhart','met_test_score','Goodhart distortion','teaching narrows to tested content when the metric becomes target','use plural assessment and monitor curriculum narrowing'),
('risk_citation_context','met_citation_count','Context erasure','citation norms differ by field, language, publication type, and career stage','use field-normalized, qualitative, and portfolio-based review'),
('risk_ai_benchmark','met_ai_benchmark','Benchmark overfitting','systems optimize benchmark performance without real-world reliability','use stress tests, deployment-context evaluation, red-teaming, and monitoring'),
('risk_sustainability_flattening','met_sustainability_score','Value flattening','ecological and social values are collapsed into one score','show component metrics, tradeoffs, uncertainty, and justice impacts'),
('risk_credit_disadvantage','met_credit_score','Quantified disadvantage','historical exclusion may be converted into numerical risk','audit subgroup effects, data quality, explainability, and appeal mechanisms'),
('risk_rank_instability','met_institution_rank','Ranking instability','small methodological changes can alter rank order','report rank bands, component scores, and sensitivity to weighting'),
('risk_safety_underreporting','met_safety_incident_rate','Underreporting incentive','low incident count may reflect suppressed reporting rather than safety','monitor reporting culture, near misses, audits, and worker voice');

INSERT INTO validity_review VALUES
('val_test','met_test_score','captures tested performance, not full learning','affected by test conditions, preparation, language access, disability accommodation, and school resources','review score distributions by relevant educational equity groups','interpret with school conditions, curriculum, student support, and longitudinal evidence'),
('val_citation','met_citation_count','captures citation attention, not direct research quality','database coverage and field norms affect counts','review field, language, career stage, and collaboration effects','interpret with expert reading, contribution narrative, and research context'),
('val_ai','met_ai_benchmark','captures benchmark task performance only','benchmark contamination, distribution shift, and task framing may distort meaning','review performance by language, domain, demographic context, and failure type','interpret with deployment risk, red-team findings, and safety evaluation'),
('val_sustainability','met_sustainability_score','captures selected sustainability dimensions under chosen weights','data gaps, scope boundaries, and weighting choices shape score','review environmental justice, labor, community, and intergenerational impacts','interpret alongside disaggregated ecological and social indicators'),
('val_credit','met_credit_score','captures modeled repayment risk under available financial data','thin files, reporting errors, and historical exclusion affect score','audit disparate impact and error rates','interpret with appeal rights, explanation, and alternative evidence'),
('val_rank','met_institution_rank','captures weighted chosen dimensions, not total institutional value','weights, missing data, normalization, and small differences create instability','review resource and mission differences','interpret rank bands and component measures, not ordinal status alone'),
('val_safety','met_safety_incident_rate','captures reported incidents, not total hazard burden','reporting culture and definitions affect the rate','review contractor, shift, site, role, and vulnerability differences','interpret with near misses, inspections, worker voice, and safety audits');

INSERT INTO governance_check VALUES
('gov_test','met_test_score','assessment purpose, content, scoring, accommodations, error, and limitations','score review, accommodation appeal, contextual review','annual and after test redesign','do not use as sole basis for high-stakes educational judgment'),
('gov_citation','met_citation_count','database source, date, field coverage, normalization method, and exclusions','portfolio review and qualitative assessment','per review cycle','do not use as standalone proxy for research quality'),
('gov_ai','met_ai_benchmark','benchmark composition, contamination checks, task limits, subgroup results, and failure modes','independent evaluation, red-team review, incident reporting','pre-release, post-release, and after major model changes','do not infer deployment safety from benchmark score alone'),
('gov_sustainability','met_sustainability_score','scope, weights, data sources, missing data, uncertainty, and tradeoffs','community review and third-party audit','annual and after material methodology changes','do not use composite score to hide component-level harms'),
('gov_credit','met_credit_score','model factors, data rights, error correction process, and adverse action explanation','appeal, correction, and alternative evidence review','continuous monitoring and periodic fairness audit','do not treat score as context-free moral judgment'),
('gov_rank','met_institution_rank','weights, data sources, normalization, missing data, sensitivity, and uncertainty','methodology comment, correction request, and component-score review','per ranking cycle','do not treat small rank differences as meaningful'),
('gov_safety','met_safety_incident_rate','incident definitions, reporting channels, exposure denominator, and reporting-culture evidence','worker reporting protections and independent safety review','quarterly and after serious incidents','do not reward low reporting without reporting-quality review');

INSERT INTO goodhart_record VALUES
('gh_test','met_test_score','learning','high','teaching to the test and narrowing curriculum','plural assessment and curriculum-quality review'),
('gh_citation','met_citation_count','research contribution','moderate','publication strategy and citation chasing','portfolio assessment and responsible research evaluation principles'),
('gh_ai','met_ai_benchmark','real system capability and safety','high','benchmark-specific optimization and contamination','held-out tests, adversarial evaluation, and deployment monitoring'),
('gh_safety','met_safety_incident_rate','actual safety','high','suppressed reporting or incident reclassification','near-miss monitoring, anonymous reporting, and independent audits');

INSERT INTO aggregation_review VALUES
('agg_test_avg','met_test_score','school or district average','central tendency of tested performance','subgroup inequality, exclusion, disability access, language access, and resource differences','student groups, programs, support access, school context'),
('agg_ai_accuracy','met_ai_benchmark','overall benchmark score','average task performance','subgroup failures, rare harms, unsafe edge cases, and deployment mismatch','task type, language, domain, group, risk category'),
('agg_sustainability','met_sustainability_score','weighted composite score','summary of selected indicators','ecological thresholds, local harms, labor impacts, biodiversity loss, and environmental injustice','carbon, water, biodiversity, labor, community, justice, supply chain'),
('agg_safety','met_safety_incident_rate','incidents per worker-hour or exposure unit','reported incident frequency','underreporting, near misses, contractor risk, and vulnerable shifts or sites','site, role, shift, contractor status, incident severity');

INSERT INTO ranking_review VALUES
('rank_institution','met_institution_rank','weighted composite of selected indicators','weights, missing data, normalization, and small score gaps','mission, resources, community role, student population, and historical context','show rank bands, component scores, sensitivity checks, and methodology limits'),
('rank_ai','met_ai_benchmark','benchmark score leaderboard','test contamination, benchmark design, prompt conditions, and model variance','deployment safety, user context, cost, robustness, and failure severity','report benchmark limits, risk-specific metrics, confidence, and red-team results'),
('rank_sustainability','met_sustainability_score','composite sustainability score','indicator selection, weighting, missing supply-chain data, and scope boundaries','local ecological harm, Indigenous rights, labor conditions, and irreversible loss','present components, tradeoffs, uncertainty, and affected-community context');

INSERT INTO uncertainty_review VALUES
('unc_test_error','met_test_score','measurement error','individual score contains noise from test conditions and item sampling','score ranges, confidence bands, and limits'),
('unc_rank_weights','met_institution_rank','methodological uncertainty','rank changes under alternative weighting and normalization','rank bands and sensitivity tables'),
('unc_ai_deployment','met_ai_benchmark','deployment uncertainty','benchmark conditions may not match real use','deployment-context caveats and post-deployment monitoring'),
('unc_sustainability_data','met_sustainability_score','data gaps and scope uncertainty','supply-chain, biodiversity, labor, and justice data may be incomplete','data-quality flags and component uncertainty notes'),
('unc_credit_data','met_credit_score','data quality and structural uncertainty','thin files, reporting errors, and historical exclusion affect risk estimate','explanation, error correction, appeal, and alternative evidence');

INSERT INTO justice_review VALUES
('justice_test','met_test_score','which forms of learning are visible or invisible?','does the metric distribute opportunity or punishment unequally?','can students, families, and educators contest interpretation?','could the score restrict access to opportunity?'),
('justice_credit','met_credit_score','whose financial history is visible to the system?','does the score amplify historical exclusion?','can affected people understand and correct errors?','could the score deny housing, credit, employment, or stability?'),
('justice_ai','met_ai_benchmark','which languages, communities, domains, and harms are included?','does performance vary for vulnerable users?','can users report failures and contest automated decisions?','could benchmark claims mask deployment harms?'),
('justice_sustainability','met_sustainability_score','which ecological and community harms are visible?','who bears environmental costs and who receives benefits?','can affected communities review the metric?','could the score greenwash or displace harm?');

INSERT INTO responsible_quantification_check VALUES
('check_define','Define','What concept is being quantified?','metric has no clear meaning','state construct, intended use, and invalid uses'),
('check_measure','Measure','How is the concept represented numerically?','proxy does not match value','review validity, reliability, bias, and uncertainty'),
('check_contextualize','Contextualize','What background, uncertainty, and limits matter?','number is interpreted as self-explanatory','include uncertainty, qualitative context, distribution, and limitations'),
('check_govern','Govern','How will the number be used, audited, and challenged?','metric becomes unaccountable power','provide documentation, contestability, audit, and revision mechanisms'),
('check_justice','Justice','Who may be harmed, excluded, or misrepresented?','metric hides unequal consequences','perform subgroup, distributional, historical, and affected-community review');
