# Laboratory 5: Bayesian Networks and Autoregressive Language Models

## Folder Contents
* **`05_bayesian_networks_language_models.ipynb`**: Complete, self-contained, pre-executed Jupyter Notebook with first-order and second-order language models, CPTs, invariant tests, generation experiments, and comparison tables.
* **`README.md`**: Summary of theoretical derivations, empirical findings, and all 14 question answers for grading.

---

## 1. Theoretical Foundations
* **Autoregressive Factorization (Chain Rule):**
  $$P(X_1, \dots, X_T) = P(X_1) \prod_{t=2}^T P(X_t \mid X_1, \dots, X_{t-1})$$
* **First-Order Markov Chain ($X_1 \to X_2 \to \dots \to X_T$):**
  $$X_t \perp\!\!\!\perp (X_1, \dots, X_{t-2}) \mid X_{t-1} \implies P(X_t \mid X_1, \dots, X_{t-1}) = P(X_t \mid X_{t-1})$$
* **Second-Order Markov Chain ($X_{t-2} \to X_t \leftarrow X_{t-1}$):**
  $$P(X_t \mid X_1, \dots, X_{t-1}) = P(X_t \mid X_{t-2}, X_{t-1})$$

---

## 2. Experimental Results & Deliverables

### Probability Normalization Invariant Check (Task VII)
* Evaluated $\sum_v P(v \mid w)$ for every token $w$.
* **Result:** All conditional distributions strictly sum to $1.000000$ (Valid).
* **Question 8 Analysis:** A sum of $0.87$ conclusively proves an implementation bug (missing transitions, flawed normalizer, or faulty token counting).

### Text Generation: Greedy Mode vs. Sampling Mode (Task X)
* **Greedy Mode ($\arg\max$):** Produced the exact same sentence across all 5 runs (`the cat sat on the mat`). Entropy = 0.
* **Sampling Mode (Probabilistic):** Produced diverse grammatical sentences (`the dog sat on the rug`, `the cat ran to the park`, `the dog ran to the park`).

### First-Order vs. Second-Order Comparison (Task XIII)

| Metric | First-Order (Bigram) | Second-Order (Trigram) |
| :--- | :---: | :---: |
| **Vocabulary Size $|V|$** | 10 tokens | 10 tokens |
| **Possible Contexts** | $|V| = 10$ | $|V|^2 = 100$ |
| **Observed Contexts** | 10 | 12 |
| **Context Sparsity (%)** | **0.0%** | **88.0%** |
| **Non-Zero CPT Parameters** | 17 | 12 |
| **Qualitative Coherence** | May mix subjects/verbs | High local phrase consistency |

* **Question 12 Analysis (Curse of Dimensionality):** Increasing context improves semantic agreement, but the parameter space explodes exponentially ($|V|^n$). For finite corpora, most higher-order contexts have frequency zero, causing severe data sparsity.

---

## 3. Connection to Modern LLMs (Transformers)
* **Shared Probabilistic Foundation:** Modern autoregressive LLMs (e.g. GPT, Claude, Gemini) optimize the exact same autoregressive factorization $\prod P(X_t \mid X_{<t})$.
* **Architectural Difference:** Classical n-gram models use explicit tabular counting (CPTs) over fixed windows ($n \le 3$), whereas modern LLMs use deep neural networks (Transformers with self-attention) across massive contexts ($8\text{k} - 1\text{M}+$ tokens) with continuous embeddings and gradient-based learning.

---

## 4. Key Questions Answered
* **Questions 1–3:** Text generation via chain rule, conditional independence notation, and exact CPT calculations for `the`, `cat`, `dog`, `sat`, `ran`.
* **Questions 4–7:** Code inspection of counts, probability computation, greedy vs. sampling, and handling unobserved tokens.
* **Questions 8–10:** Invariant failure diagnosis, probability model vs. human intuition, and entropy of sampling vs. greedy decoding.
* **Questions 11–14:** Bayesian network topology changes, context vs. sparsity trade-offs, prompt engineering (behavioral specification vs. vague requests), and the foundational role of Bayesian networks in generative AI.
