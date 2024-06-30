# Partial Reinforcement Optimizer (PRO)

## Introduction

The Partial Reinforcement Optimizer (PRO) is a novel evolutionary optimization algorithm inspired by the Partial Reinforcement Effect (PRE) theory from psychology. PRO is designed to solve global optimization problems more efficiently by leveraging principles from PRE, including dynamic reinforcement schedules and adaptive learning mechanisms.

## Reference

Taheri, Ahmad, Keyvan RahimiZadeh, Amin Beheshti, Jan Baumbach, Ravipudi Venkata Rao, Seyedali Mirjalili, and Amir H. Gandomi. "Partial reinforcement optimizer: an evolutionary optimization algorithm." Expert Systems with Applications 238 (2024): 122070.


## Key Concepts

### Learner
A learner is represented as a solution vector in the search space.

### Behavior
Each component of the solution vector is a decision variable or behavior.

### Population
A group of learners forms the population for the algorithm.

### Fitness Evaluation
The quality of solutions is assessed using an objective function to guide learning and improvement.

## Reinforcement Schedules

PRO incorporates various reinforcement schedules inspired by PRE theory:
- **Continuous Reinforcement**: Reinforcement after every response.
- **Fixed-Ratio Schedules**: Reinforcement after a set number of responses.
- **Variable-Ratio Schedules**: Reinforcement after varying numbers of responses.
- **Fixed-Interval Schedules**: Reinforcement after a fixed time interval.
- **Variable-Interval Schedules**: Reinforcement after varying time intervals.

## Algorithm Steps

1. **Initialization**: Initialize the population and set reinforcement schedules.
2. **Selection**: Choose behaviors to stimulate based on schedule priorities.
3. **Stimulation**: Apply changes to generate new solutions.
4. **Evaluation**: Assess new solutions using the objective function.
5. **Reinforcement**: Apply positive or negative reinforcement based on evaluation results.
6. **Rescheduling**: Update schedules if necessary to improve learning efficiency.

## Installation

To install the PRO algorithm, clone this repository:

```bash
git clone https://github.com/yourusername/PRO.git
```

## Usage

Here is an example of how to use the PRO algorithm in your project:

```python
from pro_optimizer import PRO

# Define your objective function
def objective_function(x):
    return sum(x**2)

# Initialize PRO
optimizer = PRO(objective_function, population_size=50, max_iterations=100)

# Run the optimizer
best_solution, best_value = optimizer.run()

print(f"Best Solution: {best_solution}")
print(f"Best Value: {best_value}")
```

## Experimental Results

PRO has been tested on 75 complex benchmark functions from the CEC2005, CEC2014, and CEC-BC-2017 test suites, consistently outperforming several well-known meta-heuristic algorithms. Additionally, PRO was successfully applied to optimize a federated deep learning classifier for ECG diagnostics, achieving high accuracy and robustness.

## Contributing

We welcome contributions to improve the PRO algorithm. Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

We would like to thank all the institutions and individuals who contributed to the development of the Partial Reinforcement Optimizer.

---

Feel free to customize this README to better fit your specific implementation and project details.
