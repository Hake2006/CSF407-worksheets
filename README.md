# Artificial Intelligence Laboratory Exercises

This repository contains complete, self-contained, fully executed Jupyter Notebook implementations for all five Artificial Intelligence laboratory exercises, organized into dedicated folders for grading:

1. **[`Lab_01_Goal_Based_Agent/01_goal_based_agent.ipynb`](Lab_01_Goal_Based_Agent/01_goal_based_agent.ipynb)** — *Constructing a Goal-Based Agent using an LLM*
2. **[`Lab_02_Search_and_A_Star/02_search_and_a_star.ipynb`](Lab_02_Search_and_A_Star/02_search_and_a_star.ipynb)** — *Search and A\*: Using an LLM as an Engineering Assistant*
3. **[`Lab_03_Logical_Planning/03_logical_planning.ipynb`](Lab_03_Logical_Planning/03_logical_planning.ipynb)** — *Logical Reasoning for Planning & Prolog Verification*
4. **[`Lab_04_Neural_Models_XOR/04_neural_models_xor.ipynb`](Lab_04_Neural_Models_XOR/04_neural_models_xor.ipynb)** — *Neural Models: Learning, Depth, Activations, and Output Layers*
5. **[`Lab_05_Bayesian_Networks_Language_Models/05_bayesian_networks_language_models.ipynb`](Lab_05_Bayesian_Networks_Language_Models/05_bayesian_networks_language_models.ipynb)** — *Bayesian Networks and Autoregressive Language Models*

---

## Clean Repository Structure

```text
C:\Harish\Projects\AI\
│
├── Lab_01_Goal_Based_Agent/
│   ├── 01_goal_based_agent.ipynb                    # Executed Jupyter Notebook
│   └── README.md                                    # Lab 1 Grading Guide & Results
│
├── Lab_02_Search_and_A_Star/
│   ├── 02_search_and_a_star.ipynb                   # Executed Jupyter Notebook
│   └── README.md                                    # Lab 2 Grading Guide & Benchmark Results
│
├── Lab_03_Logical_Planning/
│   ├── 03_logical_planning.ipynb                    # Executed Jupyter Notebook
│   ├── planner.pl                                   # Standalone Prolog verification source
│   └── README.md                                    # Lab 3 Grading Guide & Logical Proofs
│
├── Lab_04_Neural_Models_XOR/
│   ├── 04_neural_models_xor.ipynb                   # Executed Jupyter Notebook
│   ├── xor_linear_separability.png                  # Geometric diagram of XOR decision space
│   └── README.md                                    # Lab 4 Grading Guide & PyTorch Diagnostics
│
├── Lab_05_Bayesian_Networks_Language_Models/
│   ├── 05_bayesian_networks_language_models.ipynb   # Executed Jupyter Notebook
│   └── README.md                                    # Lab 5 Grading Guide & Comparison Tables
│
├── requirements.txt                                 # Master environment dependencies
└── README.md                                        # Master repository documentation
```

---

## Requirements and Installation

### Prerequisites
* **Python 3.10+** (Python 3.13 tested)
* **PyTorch** (CPU version is sufficient; GPU is optional)
* **Jupyter Notebook** / **JupyterLab** or **Visual Studio Code** with Python & Jupyter extensions.

### Installation
Install all required dependencies using `pip`:

```bash
pip install -r requirements.txt
```

To run PyTorch on CPU (if installing manually):
```bash
pip install torch --index-url https://download.pytorch.org/whl/cpu
```

---

## Detailed Laboratory Summaries

### Lab 1: Constructing a Goal-Based Agent (`Lab_01_Goal_Based_Agent/`)
* **Topic:** Goal-Based Agent Architecture vs. Simple Reflex Agent.
* **Environment:** 2D grid world ($6 \times 21$) representing a warehouse loading dock (`S`) and dispatch area (`G`) separated by shelving units (`#`).
* **Key Tasks Completed:**
  * **Task 1 (Problem Understanding):** Formal analysis of the environment (discrete, static, deterministic, fully observable), actions, state estimation, and why reflex agents fail in obstacle-rich mazes due to lack of foresight.
  * **Task 2 (Agent Design):** Decomposition into Percepts, State Estimator, Goal Test, Transition Model, and Search Engine (BFS).
  * **Task 3 (Prompt Engineering & Implementation):** Python implementation of `WarehouseEnvironment` and `GoalBasedAgent` using Breadth-First Search (`collections.deque`, explored set, parent-pointer reconstruction).
  * **Results:** Optimal collision-free path discovered in **24 steps**, expanding 64 states, with visual trajectory overlay marked on the ASCII grid.
  * **Prompt Engineering Reflection:** Analysis of first-attempt generation, prompt constraints, and why BFS is optimal for unit step cost.

---

### Lab 2: Search and A* (`Lab_02_Search_and_A_Star/`)
* **Topic:** Informed Search, Evaluation Function $f(n) = g(n) + h(n)$, and Heuristic Design.
* **Environment:** 9-row by 17-column warehouse grid with complex shelving corridors.
* **Key Tasks Completed:**
  * **Task 0 (Search Problem Formulation):** Formal 6-tuple definition $\mathcal{P} = (S, A, T, s_0, G, c)$, state representation $(r, c)$, invalid actions, determinism, and solution definition.
  * **Task 1 & 2 (Agent Design & A\* Code):** Modular `WarehouseSearch` engine using `heapq` priority queue, tie-breaking counter, `g_score` dictionary, and customizable heuristics.
  * **Task 3 (Test Suite):**
    1. *Test 1 (Original Warehouse):* Successfully found 28-step optimal path.
    2. *Test 2 (Trivial 1-Step Map):* Verified immediate adjacent goal detection.
    3. *Test 3 (No-Solution Map):* Verified clean termination (`found: False`) without infinite loops.
    4. *Test 4 (Alternative Paths Map):* Verified that A* selects the shortest route over a longer detour.
  * **Task 4 (Inspection):** Comprehensive mapping table linking theoretical concepts (State, Action, $g(n)$, $h(n)$, $f(n)$, Frontier, Closed Set) to exact code lines.
  * **Task 5 (A\* vs. BFS Comparison):**
    * BFS: Found path length 28, expanded **71 states**.
    * A* (Manhattan): Found path length 28, expanded **49 states** (31% reduction in search effort).
  * **Task 6 (Heuristic Investigation):**
    * $h(n) = 0$ (Uniform Cost): Path 28, 71 states expanded.
    * $h(n) = \text{Euclidean}$: Path 28, 59 states expanded.
    * $h(n) = \text{Manhattan}$: Path 28, 49 states expanded (optimal informed admissible heuristic).
    * $h(n) = 2 \times \text{Manhattan}$ (Inadmissible / Weighted A*): Path 28, 43 states expanded.
  * **Task 7 & Section 6:** Critical reflection on LLM as engineering assistant, testing principles, and why $h(n) \le h^*(n)$ matters.

---

### Lab 3: Logical Planning & Prolog Verification (`Lab_03_Logical_Planning/`)
* **Topic:** STRIPS-Style Logical Planning, Action Preconditions & Effects, and Neuro-Symbolic Verification.
* **Thesis:** $\text{Logic} + \text{Search} = \text{Planning}$.
* **Scenario:** Robot moving across locations $A \leftrightarrow B \leftrightarrow C$, picking up a package at $A$, and delivering to $C$.
* **Key Tasks Completed:**
  * **Task 0 (Problem Formalization):** Initial state $I = \{\text{At}(\text{Robot}, A), \text{At}(\text{Package}, A)\}$, Goal $G = \{\text{At}(\text{Package}, C)\}$, and action table (Move, PickUp, Drop) with positive/negative preconditions and add/delete effects.
  * **Task 1 (Manual Plan Construction):** State-by-state trace: $S_0 \xrightarrow{\text{PickUp}(A)} S_1 \xrightarrow{\text{Move}(A,B)} S_2 \xrightarrow{\text{Move}(B,C)} S_3 \xrightarrow{\text{Drop}(C)} S_4$.
  * **Task 2 (Python STRIPS Planner):** `LogicalPlanner` class performing BFS over propositional sets (`frozenset` states).
  * **Task 3 (Test Suite):**
    * *Test A (Solvable):* Found 4-step plan; verified state transitions.
    * *Test B (Impossible):* Removed `PickUp` action; planner cleanly reported failure.
    * *Test C (Irrelevant Actions):* Verified planner does not confuse robot reaching $C$ with package reaching $C$.
  * **Task 4 (Logic + Search Integration):** Detailed analysis and flowchart of how logic filters legal moves while search selects sequences.
  * **Task 5 (LLM Explanation vs. Verification):** Philosophical and engineering analysis of why independently executed state transitions must be trusted over LLM narrative explanations.
  * **Section 7 (Prolog as Logical Verifier):**
    * Interactive Python resolution engine simulating Prolog Horn-clause rules (`planner.pl`).
    * Proved `can_move(a,b)` succeeds while `can_move(a,c)` fails under Closed-World Assumption.
    * Verified multi-step plans and Task 8 deduction chain: $\text{Fact} \implies \text{Rule} \implies \text{Rule} \implies \text{Conclusion}$.

---

### Lab 4: Neural Models: Learning, Depth, & Activations (`Lab_04_Neural_Models_XOR/`)
* **Topic:** Linear Separability, Depth vs. Nonlinearity, PyTorch Autograd, Weight Symmetry, and Softmax.
* **Scenario:** Redundant Safety Sensors implementing XOR logic for disagreement warnings.
* **Key Tasks Completed:**
  * **Task 1 (Linear Inseparability):** Mathematical proof showing no single straight boundary $w_1 x_1 + w_2 x_2 + b = 0$ can separate $(0,0),(1,1)$ from $(0,1),(1,0)$. Rendered dataset plot (`xor_linear_separability.png`).
  * **Task 2 (Agent Design):** Specified 2-2-1 MLP architecture, explaining why hidden nonlinearities warp latent space to enable separation, and why `BCEWithLogitsLoss` provides stable logit gradients ($\hat{y} - y$).
  * **Task 3 & 4 (PyTorch Implementation & Diagnostics):**
    * *Part A (Learning Check):* Trained 2-2-1 network; loss converged from $0.695$ to $<0.001$, classifying $4/4$ points correctly.
    * *Part B (Backpropagation Check):* Inspected $\frac{\partial L}{\partial W^{(1)}}$ via `.grad`; proved why the tensor represents the exact average of example-wise gradients under mean loss.
    * *Part C (Symmetry Experiment):* Initialized all weights and biases to zero. Confirmed that hidden unit rows remained mathematically identical throughout training, causing complete representational collapse (failed on XOR, accuracy 50%).
    * *Part D (Activation Experiment):* Evaluated Sigmoid, Tanh, and ReLU. Tanh achieved fastest convergence; Sigmoid suffered from small derivative scaling ($\le 0.25$); ReLU produced highest initial gradient norm.
  * **Task 5 (Multiclass Extension):** Extended to 3 classes (Class 0: Both inactive, Class 1: Disagree, Class 2: Both active) using 3 output logits and `CrossEntropyLoss`. Verified that predicted softmax probabilities sum to $1.0$. Proved softmax shift invariance ($z_i + 100$) and explained the numerical log-sum-exp trick.
  * **Section 6 (Reflection):** Addressed all 7 reflection questions regarding depth vs. nonlinearity, backpropagation signals, symmetry breaking, and scaling to production models.

---

### Lab 5: Bayesian Networks and Autoregressive Language Models (`Lab_05_Bayesian_Networks_Language_Models/`)
* **Topic:** Chain Rule of Probability, Directed Graphical Models, Markov Assumptions, Maximum Likelihood CPTs, and Autoregressive Text Generation.
* **Theoretical Foundation:**
  $$P(X_1, \dots, X_T) = P(X_1) \prod_{t=2}^T P(X_t \mid X_1, \dots, X_{t-1})$$
* **Key Tasks Completed:**
  * **Part I & II (Probability to Language):** Derived the autoregressive chain-rule decomposition; formalized the first-order Markov assumption $X_t \perp\!\!\!\perp (X_1, \dots, X_{t-2}) \mid X_{t-1}$.
  * **Part III & IV (Corpus & CPT Construction):** Tokenized the 6-sentence benchmark corpus with `<START>` and `<END>` tokens; constructed Maximum Likelihood Conditional Probability Tables (CPTs) for `the`, `cat`, `dog`, `sat`, and `ran`; identified zero-probability transitions.
  * **Part V & VI (First-Order Model):** Implemented `FirstOrderLanguageModel` with transition counting, CPT calculation, and inspectable data structures. Addressed Questions 4–7.
  * **Part VII & VIII (Invariant Testing & Predictions):** Verified the probability normalization invariant $\sum_v P(v \mid w) = 1.0$ across all conditioning contexts; proved why a sum of $0.87$ signals an implementation error (Question 8); analyzed $\arg\max_w P(w \mid \text{context})$ vs. human linguistic expectations (Question 9).
  * **Part IX & X (Text Generation):** Generated and saved 20 sentences via iterative conditional sampling; compared Greedy Mode ($\arg\max$) with Sampling Mode (probabilistic sampling), showing why sampling preserves lexical diversity while greedy decoding collapses to zero entropy (Question 10).
  * **Part XI & XII (Second-Order Bayesian Network):** Formulated and implemented `SecondOrderLanguageModel` ($X_{t-2} \to X_t \leftarrow X_{t-1}$); answered Question 11 on graph topology, CPT expansion, context window, and data sparsity.
  * **Part XIII (Comparative Analysis):** Quantitative comparison table measuring parameters ($|V|$ vs. $|V|^2$), context sparsity (0% vs 87.6%), and text coherence; answered Question 12 on the bias-variance trade-off and the curse of dimensionality.
  * **Part XIV–XVI (Modern LLM Connection & Reflection):** Contrasted classical tabular n-gram models with modern Transformer LLMs; evaluated prompt engineering (Approach A vs. Approach B in Question 13); synthesized the foundational benefits of Bayesian networks for understanding generative AI (Question 14).

---

## How to Run the Notebooks

### In VS Code:
1. Open folder `C:\Harish\Projects\AI` in VS Code.
2. Navigate into any lab folder (e.g., `Lab_01_Goal_Based_Agent/`).
3. Open the `.ipynb` file.
4. Select the Python kernel (Python 3.10+).
5. All cells are already pre-executed with outputs visible, but can be rerun via **"Run All"**.

### In JupyterLab / Jupyter Notebook:
```bash
cd C:\Harish\Projects\AI
jupyter notebook
```
Navigate to any lab folder from the web UI.

---

## Summary of Results

| Lab Folder | Core Algorithm / Framework | Key Benchmark / Task | Main Result |
| :--- | :--- | :--- | :--- |
| **`Lab_01_Goal_Based_Agent/`** | BFS Grid Search | $6 \times 21$ Warehouse Navigation | Optimal 24-step path found; 64 states expanded. |
| **`Lab_02_Search_and_A_Star/`** | A* with Manhattan Heuristic | $9 \times 17$ Warehouse Navigation | Optimal 28-step path found; expanded 49 states (vs 71 for BFS). |
| **`Lab_03_Logical_Planning/`** | STRIPS Propositional BFS + Prolog | 3-Location Warehouse Delivery | 4-step plan verified; Prolog Horn-clause resolution confirms valid moves. |
| **`Lab_04_Neural_Models_XOR/`** | PyTorch 2-2-1 MLP + 3-Class Softmax | XOR Safety Sensor Warning | 100% accuracy on binary XOR and 3-class extension; proved zero-init symmetry failure. |
| **`Lab_05_Bayesian_Networks_Language_Models/`** | 1st & 2nd Order Markov Autoregressive Models | 6-Sentence Animal Story Corpus | Strict normalization $\sum P = 1.0$ verified; 2nd-order model eliminates grammatical incongruities; proved exponential context sparsity ($|V|^2$). |

---
