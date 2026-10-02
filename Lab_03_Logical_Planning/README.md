# Laboratory 3: Logical Reasoning for Planning
## Using an LLM to Construct and Test a Simple Planning Agent

## Folder Contents
* **`03_logical_planning.ipynb`**: Complete, self-contained, pre-executed Jupyter Notebook with STRIPS planner, tests, and Prolog resolution simulator.
* **`planner.pl`**: Standalone Prolog source file with knowledge base facts, rules, and verification queries.
* **`README.md`**: Summary of formal planning, manual plan trace, test results, and Prolog answers for grading.

---

## 1. Problem Formalization: $(I, A, G)$
* **Locations:** $A \leftrightarrow B \leftrightarrow C$
* **Initial State ($I$):** $\{\text{At}(\text{Robot}, A), \text{At}(\text{Package}, A)\}$
* **Goal State ($G$):** $\{\text{At}(\text{Package}, C)\}$
* **Actions ($A$):**
  * $\text{Move}(X, Y)$: Pre: $\text{At}(\text{Robot}, X)$, Eff: $+\text{At}(\text{Robot}, Y), -\text{At}(\text{Robot}, X)$
  * $\text{PickUp}(\text{Package}, X)$: Pre: $\text{At}(\text{Robot}, X), \text{At}(\text{Package}, X), \neg\text{Holding}(\text{Package})$, Eff: $+\text{Holding}(\text{Package}), -\text{At}(\text{Package}, X)$
  * $\text{Drop}(\text{Package}, X)$: Pre: $\text{At}(\text{Robot}, X), \text{Holding}(\text{Package})$, Eff: $+\text{At}(\text{Package}, X), -\text{Holding}(\text{Package})$

---

## 2. Manual Plan Construction (Task 1)

| Step | Action | Resulting State Facts | Goal Satisfied? |
| :---: | :--- | :--- | :---: |
| $S_0$ | *(Start)* | $\{\text{At}(\text{Robot}, A), \text{At}(\text{Package}, A)\}$ | False |
| $S_1$ | $\text{PickUp}(\text{Package}, A)$ | $\{\text{At}(\text{Robot}, A), \text{Holding}(\text{Package})\}$ | False |
| $S_2$ | $\text{Move}(A, B)$ | $\{\text{At}(\text{Robot}, B), \text{Holding}(\text{Package})\}$ | False |
| $S_3$ | $\text{Move}(B, C)$ | $\{\text{At}(\text{Robot}, C), \text{Holding}(\text{Package})\}$ | False |
| $S_4$ | $\text{Drop}(\text{Package}, C)$ | $\{\text{At}(\text{Robot}, C), \text{At}(\text{Package}, C)\}$ | **True** ($S_4 \models G$) |

---

## 3. Test Suite Results (Task 3)
* **Test A (Solvable Problem):** Planner discovered the 4-step plan, expanding 5 states.
* **Test B (Impossible Problem):** With `PickUp` removed, planner cleanly reported `"No plan found"` without hallucinating an invalid step.
* **Test C (Irrelevant Actions):** Verified that the planner does not treat the robot reaching $C$ as equivalent to the package reaching $C$.

---

## 4. Prolog as a Plan Verifier (Section 7)
* **Knowledge Base (`planner.pl`):**
  ```prolog
  connected(a, b). connected(b, a). connected(b, c). connected(c, b).
  can_move(X, Y) :- connected(X, Y).
  valid_move(X, Y) :- connected(X, Y).
  ```
* **Query Results:**
  * `?- can_move(a, b).` $\implies$ **`true`** (Direct fact match).
  * `?- can_move(a, c).` $\implies$ **`false`** (Unprovable under Closed-World Assumption).
  * Proposed Sequence `Move(a,b), Move(b,c)` $\implies$ **`Valid`**.
  * Proposed Sequence `Move(a,c)` $\implies$ **`Invalid`** (Rejected by Prolog).
* **Task 8 Deduction Chain:**
  $$\text{Fact (wet\_road)} \implies \text{Rule (wet\_road } \to \text{ slippery)} \implies \text{Rule (slippery } \to \text{ reduce\_speed)} \implies \text{Conclusion (reduce\_speed)}$$

---

## 5. Key Conceptual Takeaways
* **Logic + Search = Planning:** Logic determines what is possible ($S \models \text{Preconditions}(a)$); search determines what to try.
* **Neuro-Symbolic Architecture:** Generated explanations are not independent verifications. An AI system can propose plans, while a separate formal logical system (like Prolog) deterministically checks and guarantees validity.
