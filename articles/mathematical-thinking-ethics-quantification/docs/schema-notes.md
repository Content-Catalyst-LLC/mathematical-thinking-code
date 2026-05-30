# Schema Notes

The SQL schema models metric records, metric risks, validity reviews, governance checks, Goodhart records, aggregation reviews, ranking reviews, uncertainty reviews, justice reviews, and responsible quantification checks.

## Core tables

- `metric_record`: metric type, target concept, proxy or method, consequence level, intended use, invalid use warning.
- `metric_risk`: risk, problem, mitigation.
- `validity_review`: construct validity, uncertainty, subgroup review, context.
- `governance_check`: documentation, contestability, audit frequency, invalid use.
- `goodhart_record`: target goal, optimization pressure, distortion mechanism, countermeasure.
- `aggregation_review`: what aggregation shows and hides.
- `ranking_review`: ranking instability, context loss, responsible reporting.
- `uncertainty_review`: source, description, communication method.
- `justice_review`: recognition, distribution, voice, and harm questions.
- `responsible_quantification_check`: define-measure-contextualize-govern-justice workflow.

## Professional use cases

- metric ethics audits;
- AI benchmark review;
- sustainability metric review;
- research assessment metric review;
- public-sector algorithm review;
- performance metric governance;
- justice and accountability review.
