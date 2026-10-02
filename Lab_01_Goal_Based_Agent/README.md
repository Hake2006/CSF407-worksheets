# Laboratory 1: Constructing a Goal-Based Agent using an LLM

## Folder Contents
* **`01_goal_based_agent.ipynb`**: Complete, self-contained, pre-executed Jupyter Notebook with all outputs, diagrams, code, and answers.
* **`README.md`**: Summary of problem formulation, implementation, and answers for grading.

---

## 1. Problem Specification
* **Environment:** 2D discrete, static, deterministic grid world ($6 \times 21$) with impassable obstacles (`#`) and free space (`.`).
* **Start State ($S$):** $(1, 1)$ — Loading Bay.
* **Goal State ($G$):** $(1, 19)$ — Dispatch Area.
* **Actions ($\mathcal{A}$):** $\{\text{Up}, \text{Down}, \text{Left}, \text{Right}\}$, unit step cost $c = 1$.

```text
#####################
#S....#............G#
#.##....##########..#
#....##.............#
#.######.###.#.###..#
#........#..........#
#####################
```

---

## 2. Agent Architecture & Design
* **Sensors & Percepts:** Extracts agent coordinates $(r, c)$.
* **Internal State:** Grid dimensions, obstacle locations, explored/visited set.
* **Decision-Making Engine:** Breadth-First Search (BFS) using a FIFO queue (`collections.deque`), visited set (`set`), and parent pointers (`dict`) for path reconstruction.
* **Actuators:** Executes the planned sequence of movements.

---

## 3. Key Grading Deliverables & Answers

### Task 1: Understanding the Problem
1. **Environment:** Static, discrete, fully observable, deterministic, single-agent grid world.
2. **Goal:** Find a collision-free sequence of moves from $(1, 1)$ to $(1, 19)$.
3. **Available Actions:** Up $(-1, 0)$, Down $(+1, 0)$, Left $(0, -1)$, Right $(0, +1)$.
4. **Information Maintained:** Current state $(r, c)$, explored set, frontier, and parent mappings.
5. **Goal-Based vs. Simple Reflex:** Simple reflex agents rely on immediate percepts and become permanently trapped in dead ends or concave obstacle loops. A goal-based agent explicitly plans ahead to evaluate whether future states achieve the goal.
* **Think About It (Scaling):** Doubling warehouse dimensions quadruples the area ($4\times$) and roughly doubles path length. Uninformed BFS memory complexity $O(b^d)$ explodes exponentially. For large warehouses, informed search ($A^*$) with admissible heuristics and hierarchical waypoint planning is required.

### Task 3: Prompt Engineering & Execution
1. **First Attempt:** The LLM generated a working program on the first attempt because the prompt provided explicit architectural constraints (coordinates, FIFO queue, visited set, and parent reconstruction).
2. **Prompt Improvements:** Explicitly specify coordinate ordering `(row, col)`, boundary checks, and cycle detection to avoid infinite loops.
3. **Algorithm Chosen:** Breadth-First Search (BFS).
4. **Justification:** BFS is mathematically guaranteed to find the shortest path in unweighted graphs with uniform step costs.

---

## 4. Execution Results
* **Solution Found:** `True`
* **Optimal Path Length:** **24 steps**
* **States Expanded:** **64 states**
* **Solution Path:** Visualized on the grid with `*` markers in the notebook.
