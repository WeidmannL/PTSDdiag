% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analysis.R
\name{analyze_best_six_symptoms_four_required_clusters}
\alias{analyze_best_six_symptoms_four_required_clusters}
\title{Find optimal hierarchical six-symptom combinations for PTSD diagnosis}
\usage{
analyze_best_six_symptoms_four_required_clusters(
  data,
  score_by = "false_cases"
)
}
\arguments{
\item{data}{A dataframe containing exactly 20 columns with PCL-5 item scores
  (output of rename_ptsd_columns). Each symptom should be scored on a 0-4
  scale where:

\itemize{
  \item 0 = Not at all
  \item 1 = A little bit
  \item 2 = Moderately
  \item 3 = Quite a bit
  \item 4 = Extremely
}}

\item{score_by}{Character string specifying optimization criterion:

\itemize{
  \item "false_cases": Minimize total misclassifications
  \item "newly_nondiagnosed": Minimize false negatives only
}}
}
\value{
A list containing:

\itemize{
  \item best_symptoms: List of three vectors, each containing six symptom numbers
    representing the best combinations found
  \item diagnosis_comparison: Dataframe comparing original DSM-5 diagnosis with
    diagnoses based on the three best combinations
  \item summary: Interactive datatable (DT) showing diagnostic accuracy metrics
    for each combination
}
}
\description{
Identifies the three best six-symptom combinations for PTSD diagnosis
where four symptoms must be present and must include at least one symptom from
each DSM-5 criterion cluster. This approach maintains the hierarchical structure
of PTSD diagnosis while reducing the total number of required symptoms.
}
\details{
The function:

\enumerate{
\item Generates valid combinations ensuring representation from all clusters
\item Requires 4 symptoms to be present (≥2 on original 0-4 scale) for diagnosis
\item Validates that present symptoms include at least one from each cluster
\item Identifies the three combinations that best match the original DSM-5 diagnosis
}

DSM-5 PTSD symptom clusters:

\itemize{
\item Cluster 1 (B) - Intrusion: Items 1-5
\item Cluster 2 (C) - Avoidance: Items 6-7
\item Cluster 3 (D) - Negative alterations in cognitions and mood: Items 8-14
\item Cluster 4 (E) - Alterations in arousal and reactivity: Items 15-20
}

Optimization can be based on either:

\itemize{
\item Minimizing false cases (both false positives and false negatives)
\item Minimizing only false negatives (newly non-diagnosed cases)
}
}
\examples{
# Create example data
ptsd_data <- data.frame(matrix(sample(0:4, 200, replace=TRUE), ncol=20))
names(ptsd_data) <- paste0("symptom_", 1:20)

# Find best hierarchical combinations minimizing false cases
results <- analyze_best_six_symptoms_four_required_clusters(ptsd_data, score_by = "false_cases")

# Find best hierarchical combinations minimizing false negatives
results_min_fn <- analyze_best_six_symptoms_four_required_clusters(ptsd_data,
score_by = "newly_nondiagnosed")

## Access results
# Get symptom numbers
results$best_symptoms

# View raw comparison data
results$diagnosis_comparison

# View summary statistics (basic format)
summary_data <- results$summary$x$data  # Extract underlying data
print(summary_data)  # Display in basic format

\dontrun{
# For interactive table display
if (requireNamespace("DT", quietly = TRUE)) {
  results$summary  # Display as interactive table
}
}

}
