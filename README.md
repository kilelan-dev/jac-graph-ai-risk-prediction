# Graph-Based AI for Early Detection of Underperformance
Jac (Jaseci) + Explainable AI

This project explores how graph-based AI can help organizations and institutions detect early signs of underperformance or dropout risk among students, staff, or associates.

We use Jac (Jaseci Language) to model relationships (people, tasks, projects, signals) as a knowledge graph. The system then computes risk scores (low / medium / high), explains the reasons, and suggests supportive interventions.

## Problem
Many organizations discover struggling individuals too late.  
Learning systems, task trackers, and attendance data exist, but they are often disconnected.  
Graph-based AI allows us to combine multiple signals into an early warning system.  

This enables timely and supportive interventions, reducing the chances of dropout, failure, or burnout.

## Why Jac
- Graph-first design: nodes, edges, and walkers naturally represent relationships.  
- Walkers: traversal logic for detecting and reasoning about risk.  
- Python bridge: integration with machine learning models for scoring and evaluation.  

## Planned Features
- Knowledge graph schema of people, projects, tasks, and performance signals  
- Risk scoring with explainable reasons  
- Intervention suggestions such as mentor check-ins or workload balancing  
- Weekly organizational reports  
- Fairness and privacy considerations  

## Roadmap
- Phase 1: Graph schema and sample dataset  
- Phase 2: Risk prediction walker with baseline thresholds  
- Phase 3: Explainable outputs and reason codes  
- Phase 4: Evaluation (accuracy, fairness, transparency)  
- Phase 5: Integration with LMS, Firebase, or Android app  

## Quick Run
For now, you can run the hello world example:

```bash
jac run hello.jac
