# haxtreme

Competitive programming solutions. Each problem lives in its own directory with
the statement summary, a solution, and sample tests.

## Layout

```
solutions/<problem-slug>/
├── solution.cpp     # accepted solution
├── README.md        # problem link, constraints, approach, complexity
└── tests/
    ├── 01.in        # sample input
    └── 01.ans       # expected output
```

## Workflow

```bash
# Scaffold a new problem
./scripts/new-problem.sh 1234a "Two Sum"

# Compile and run all sample tests for a problem
./scripts/test.sh solutions/1234a-two-sum

# Run one solution manually
g++ -std=c++20 -O2 -Wall solutions/1234a-two-sum/solution.cpp -o /tmp/sol
/tmp/sol < solutions/1234a-two-sum/tests/01.in
```

## Solutions

| Problem | Solution | Approach |
| --- | --- | --- |
| A+B (pipeline test) | [0000-a-plus-b](solutions/0000-a-plus-b) | Fast I/O |
