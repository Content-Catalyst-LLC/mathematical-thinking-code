PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS responsible_modeling_check;
DROP TABLE IF EXISTS model_risk;
DROP TABLE IF EXISTS sensitivity_record;
DROP TABLE IF EXISTS uncertainty_source;
DROP TABLE IF EXISTS validation_record;
DROP TABLE IF EXISTS calibration_record;
DROP TABLE IF EXISTS variable_parameter_record;
DROP TABLE IF EXISTS model_assumption;
DROP TABLE IF EXISTS scientific_model_record;

CREATE TABLE scientific_model_record (
  model_id TEXT PRIMARY KEY,
  model_name TEXT NOT NULL,
  model_type TEXT NOT NULL,
  purpose TEXT NOT NULL,
  target_system TEXT NOT NULL,
  intended_use TEXT NOT NULL,
  scope_limit TEXT NOT NULL
);

CREATE TABLE model_assumption (
  assumption_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  assumption_text TEXT NOT NULL,
  assumption_type TEXT NOT NULL,
  failure_consequence TEXT NOT NULL
);

CREATE TABLE variable_parameter_record (
  record_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  name TEXT NOT NULL,
  role TEXT NOT NULL,
  unit TEXT,
  uncertainty_note TEXT NOT NULL
);

CREATE TABLE calibration_record (
  calibration_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  calibration_method TEXT NOT NULL,
  data_used TEXT NOT NULL,
  risk TEXT NOT NULL,
  review_question TEXT NOT NULL
);

CREATE TABLE validation_record (
  validation_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  validation_type TEXT NOT NULL,
  evidence_used TEXT NOT NULL,
  limitation TEXT NOT NULL,
  credibility_note TEXT NOT NULL
);

CREATE TABLE uncertainty_source (
  uncertainty_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  source_type TEXT NOT NULL,
  description TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE sensitivity_record (
  sensitivity_id TEXT PRIMARY KEY,
  model_id TEXT NOT NULL,
  factor_tested TEXT NOT NULL,
  method TEXT NOT NULL,
  finding TEXT NOT NULL,
  decision_relevance TEXT NOT NULL
);

CREATE TABLE model_risk (
  risk_id TEXT PRIMARY KEY,
  risk_name TEXT NOT NULL,
  problem TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

CREATE TABLE responsible_modeling_check (
  check_id TEXT PRIMARY KEY,
  stage TEXT NOT NULL,
  question TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  mitigation TEXT NOT NULL
);

INSERT INTO scientific_model_record VALUES
('mod_predator_prey','Predator-prey population model','mechanistic','understanding','interacting ecological populations','explore qualitative feedback and oscillation behavior','does not represent habitat, climate pressure, age structure, or spatial heterogeneity'),
('mod_epidemic','Epidemic transmission model','simulation','decision_support','disease spread in a population','compare intervention scenarios and transmission assumptions','sensitive to contact structure, reporting rates, behavior change, and variant dynamics'),
('mod_climate_scenario','Climate scenario model','hybrid','scenario_analysis','coupled Earth system and human forcing pathways','evaluate climate behavior under alternative forcing scenarios','scenario, structural, parameter, and internal variability uncertainty'),
('mod_material_failure','Material failure model','mechanistic_statistical','prediction','material stress and degradation','estimate failure probability under stress conditions','depends on microstructure, boundary conditions, and test regime'),
('mod_infrastructure_resilience','Infrastructure resilience model','systems','decision_support','interdependent infrastructure networks','stress-test cascading failure and recovery scenarios','requires careful network, demand, hazard, and repair assumptions'),
('mod_ai_surrogate','AI surrogate simulation model','machine_learning_hybrid','prediction','expensive scientific simulation emulator','approximate simulation output across tested parameter ranges','may fail outside training distribution or under unseen regimes');

INSERT INTO model_assumption VALUES
('assump_pred_closed','mod_predator_prey','population changes are driven mainly by simplified predator-prey interaction rates','mechanistic simplification','external ecological drivers may dominate modeled dynamics'),
('assump_epi_contact','mod_epidemic','contact structure adequately represents transmission opportunity','network and behavior assumption','transmission estimates may be biased under behavior change or heterogeneity'),
('assump_climate_pathway','mod_climate_scenario','forcing pathway describes a plausible future scenario','scenario assumption','outputs describe scenario consequences, not guaranteed predictions'),
('assump_material_boundary','mod_material_failure','test conditions represent field stress conditions','boundary condition','failure risk may be underestimated outside tested regimes'),
('assump_infra_network','mod_infrastructure_resilience','network dependencies capture major interconnections','system boundary assumption','hidden dependencies may cause unmodeled cascading failures'),
('assump_surrogate_distribution','mod_ai_surrogate','training simulations cover the intended parameter domain','data coverage assumption','surrogate may extrapolate unreliably');

INSERT INTO variable_parameter_record VALUES
('var_pred_prey','mod_predator_prey','prey population','state variable','individuals or density','observational uncertainty and spatial heterogeneity'),
('par_pred_interaction','mod_predator_prey','interaction rate','parameter','rate','estimated from limited ecological data'),
('var_epi_infected','mod_epidemic','infected population','state variable','people','underreporting and testing bias'),
('par_epi_beta','mod_epidemic','transmission rate','parameter','rate per contact or period','changes with behavior, immunity, variant, and intervention'),
('var_climate_temp','mod_climate_scenario','temperature anomaly','output variable','degrees Celsius','ensemble spread and internal variability'),
('par_climate_feedback','mod_climate_scenario','feedback parameter','parameter','model-dependent','structural and parameter uncertainty'),
('var_infra_service','mod_infrastructure_resilience','service availability','state or output variable','percent or index','depends on network representation and recovery assumptions'),
('par_surrogate_latent','mod_ai_surrogate','learned latent representation','model component','dimensionless','interpretability and distribution shift concerns');

INSERT INTO calibration_record VALUES
('cal_pred_rates','mod_predator_prey','fit interaction parameters to population time series','observed population counts','equifinality and ecological confounding','can different parameter sets produce similar cycles?'),
('cal_epi_cases','mod_epidemic','fit transmission parameters to case and hospitalization data','reported cases, hospitalization, serology where available','reporting change and behavior feedback','are reporting biases and behavior change represented?'),
('cal_climate_history','mod_climate_scenario','evaluate historical simulation against observations','observed climate records and forcing history','historical fit may not resolve future structural uncertainty','does validation cover relevant variables, scales, and extremes?'),
('cal_material_tests','mod_material_failure','fit degradation parameters from laboratory tests','stress tests and failure observations','laboratory-field mismatch','do test conditions match field conditions?'),
('cal_surrogate_train','mod_ai_surrogate','train surrogate on simulation ensemble','simulation input-output pairs','overfitting or distribution shift','does validation cover held-out and stress-test regions?');

INSERT INTO validation_record VALUES
('val_pred_qualitative','mod_predator_prey','process and qualitative validation','ecological theory and observed oscillation patterns','does not validate detailed population forecasts','useful for understanding feedback, not full ecosystem prediction'),
('val_epi_out_of_sample','mod_epidemic','out-of-sample and scenario validation','later case, hospitalization, and intervention data','behavior and reporting changes can shift model validity','update model as evidence and conditions change'),
('val_climate_ensemble','mod_climate_scenario','historical simulation and ensemble comparison','observational records, model intercomparison, process diagnostics','regional extremes and feedbacks may remain uncertain','interpret through ensembles and scenarios'),
('val_material_field','mod_material_failure','laboratory and field validation','test data and field failure records','rare failures may be underrepresented','combine tests with stress scenarios'),
('val_infra_stress','mod_infrastructure_resilience','stress testing and expert review','past disruption events, network data, engineering review','unobserved cascading events remain uncertain','use as decision support rather than deterministic forecast'),
('val_surrogate_holdout','mod_ai_surrogate','held-out simulation validation','unseen simulation runs and error analysis','validity bounded by training domain','document parameter domain and extrapolation warnings');

INSERT INTO uncertainty_source VALUES
('unc_measurement_epi','mod_epidemic','measurement','cases and infections are imperfectly observed','model observation error and triangulate with hospitalization or serology'),
('unc_parameter_pred','mod_predator_prey','parameter','interaction rates are uncertain','use sensitivity analysis and parameter intervals'),
('unc_initial_climate','mod_climate_scenario','initial_condition','initial states affect trajectories and internal variability','use ensembles with varied initial conditions'),
('unc_structural_climate','mod_climate_scenario','structural','model structure and parameterizations differ','compare model ensembles and process diagnostics'),
('unc_scenario_climate','mod_climate_scenario','scenario','future emissions and policy choices are uncertain','report scenario assumptions rather than a single prediction'),
('unc_numerical_material','mod_material_failure','numerical','mesh, discretization, and solver choices affect results','perform convergence and stability checks'),
('unc_distribution_surrogate','mod_ai_surrogate','distribution_shift','AI surrogate may see inputs unlike training simulations','use out-of-distribution detection and domain bounds');

INSERT INTO sensitivity_record VALUES
('sens_pred_interaction','mod_predator_prey','interaction rate','parameter sweep','cycle amplitude and period vary strongly','avoid overinterpreting exact cycle timing'),
('sens_epi_beta','mod_epidemic','transmission rate and reporting rate','global sensitivity and scenario analysis','intervention ranking may change with behavior assumptions','communicate uncertainty before policy comparison'),
('sens_climate_feedback','mod_climate_scenario','feedback parameter and forcing pathway','ensemble and scenario analysis','long-term outcomes vary across feedback and scenario assumptions','use scenario ranges and risk framing'),
('sens_infra_repair','mod_infrastructure_resilience','repair time and dependency strength','stress testing','recovery outcomes depend on hidden network dependencies','prioritize dependency mapping and redundancy planning'),
('sens_surrogate_domain','mod_ai_surrogate','parameter domain boundary','held-out and stress-region validation','surrogate error increases near domain boundary','restrict operational use to validated regions');

INSERT INTO model_risk VALUES
('risk_false_precision','False precision','numerical output appears more certain than it is','report uncertainty, assumptions, and validity scope'),
('risk_model_overreach','Model overreach','model is used beyond its intended domain','state intended use, scope limits, and invalid use cases'),
('risk_hidden_assumptions','Hidden assumptions','simplifications are buried inside technical form','document assumptions explicitly and test alternatives'),
('risk_data_bias','Data bias','input data misrepresent the target system','audit measurement, sampling, exclusions, and missing data'),
('risk_black_box_authority','Black-box authority','model cannot be inspected or explained','require transparency, testing, interpretability, and independent review'),
('risk_policy_misuse','Policy misuse','model is treated as decision rather than decision support','separate model evidence from values, governance, and policy judgment'),
('risk_visual_realism','Visual realism','simulation visuals make a model feel more faithful than evidence supports','label simulation assumptions, uncertainty, and validation status');

INSERT INTO responsible_modeling_check VALUES
('check_represent','Represent','What system, variables, boundaries, and assumptions are chosen?','model frames the wrong problem','document target system, scope, variables, parameters, and assumptions'),
('check_relate','Relate','How do variables, mechanisms, and uncertainties interact?','relationships are oversimplified or unjustified','state equations, mechanisms, data relationships, and causal assumptions'),
('check_test','Test','How does the model compare with evidence and alternatives?','fit is mistaken for validity','separate calibration, verification, validation, and sensitivity analysis'),
('check_revise','Revise','What must change in light of error, uncertainty, or new use?','model becomes frozen despite changing evidence','update model when data, purpose, or assumptions change'),
('check_responsibility','Responsibility','Who may be affected by model output or misuse?','technical output hides unequal consequences','document stakeholders, uncertainty, limitations, and decision accountability');
