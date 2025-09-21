# Roadmap

This document outlines the planned development phases for the project.

## Phase 1: Graph schema and sample dataset
- Define nodes: student, project, task, signal
- Define edges: works_on, assigned, has_signal
- Create a small mock dataset (CSV or JSON)

## Phase 2: Risk prediction walker
- Write a Jac walker to check overdue tasks and low attendance
- Assign risk levels: low, medium, high
- Output basic text reports

## Phase 3: Explainable outputs
- Add reasons to risk predictions (e.g., "4 overdue tasks", "attendance below 70%")
- Return structured outputs that can be logged or visualized

## Phase 4: Evaluation
- Compare with a baseline machine learning model in Python
- Metrics: accuracy, precision, recall
- Add fairness and transparency checks

## Phase 5: Integration
- Connect with Firebase or an LMS
- Generate weekly reports
- Prepare for integration with an Android or web app
