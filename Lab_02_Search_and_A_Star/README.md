# Laboratory 2: Search and A*
## Using an LLM as an Engineering Assistant

## Folder Contents
* **`02_search_and_a_star.ipynb`**: Complete, self-contained, pre-executed Jupyter Notebook with all outputs, comparisons, code, and answers.
* **`README.md`**: Summary of problem formulation, implementation, test suite results, and reflection answers for grading.

---

## 1. Problem Formulation: $\mathcal{P} = (S, A, T, s_0, G, c)$
* **State Space $S$:** Valid grid coordinates $(r, c)$ where $\text{grid}[r][c] \neq \text{'#'}$.
* **Action Set $A$:** $\{\text{Up}, \text{Down}, \text{Left}, \text{Right}\}$.
* **Transition Model $T(s, a)$:** Deterministic translation by 1 unit in the specified direction.
* **Initial State $s_0$:** $(1, 1)$ corresponding to `'S'`.
* **Goal State $G$:** $(7, 15)$ corresponding to `'G'`.
* **Step Cost $c(s, a, s')$:** Uniform cost $1.0$.

```text
#################
#S....#.........#
#.###.#.#######.#
#...#.#.......#.#
###.#.#######.#.#
#...#.........#.#
#.###########.#.#
#.............#G#
#################
```

---

## 2. Benchmark Test Suite Results

| Test Case | Description | Expected Behavior | Observed Result | Pass/Fail |
| :--- | :--- | :--- | :--- | :--- |
| **Test 1: Original Warehouse** | Complex $9 \times 17$ maze | Finds optimal path | Length 28, 49 states expanded | **PASS** |
| **Test 2: Trivial Case** | Goal immediately adjacent | 1-step solution | Length 1, 2 states expanded | **PASS** |
| **Test 3: No Solution** | Goal enclosed by walls | Terminates cleanly | `found: False`, no loop | **PASS** |
| **Test 4: Alternative Paths** | Short route vs. detour | Chooses shortest route | Finds optimal 7-step path | **PASS** |

---

## 3. Comparative Experiments

### A* vs. BFS (Blind Search)
* **BFS:** Found path length 28, expanded **71 states**.
* **A\* (Manhattan):** Found path length 28, expanded **49 states**.
* **Takeaway:** Both guarantee optimal path length, but A\* reduces expanded states by **31%** by biasing exploration towards the target using heuristic $h(n)$.

### Heuristic Investigation ($f(n) = g(n) + h(n)$)

| Heuristic Function | Admissible? | Consistent? | Path Length | States Expanded |
| :--- | :---: | :---: | :---: | :---: |
| **$h(n) = 0$ (Uniform Cost / Dijkstra)** | Yes | Yes | 28 | 71 |
| **$h(n) = \text{Euclidean Distance}$** | Yes | Yes | 28 | 59 |
| **$h(n) = \text{Manhattan Distance}$** | Yes | Yes | 28 | 49 |
| **$h(n) = 2 \times \text{Manhattan}$ (Weighted A*)**| No | No | 28 | 43 |

* **Analysis:** Manhattan distance dominates Euclidean distance on a 4-connected grid ($h_{\text{Euc}} \le h_{\text{Man}} \le h^*$), expanding strictly fewer states while preserving admissibility. $2 \times \text{Manhattan}$ is inadmissible and greedier, expanding fewer states, but risks sub-optimality in general domains.

---

## 4. Key Questions Answered
* **Task 0 (a–d):** Determinism, invalid action conditions, and solution path definition.
* **Task 4 (a–e):** `heapq` priority queue, tie-breaking counter, closed set pruning, and explicit $f = g + h$ calculation.
* **Task 7 & Final Reflection (1–5):** Distinction between design, LLM generation, independent testing, and the engineering lesson: *Working output $\neq$ Validated algorithm*.
