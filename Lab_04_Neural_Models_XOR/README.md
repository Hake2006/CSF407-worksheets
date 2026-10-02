# Laboratory 4: Neural Models
## Learning, Depth, Activations, and Output Layers

## Folder Contents
* **`04_neural_models_xor.ipynb`**: Complete, self-contained, pre-executed Jupyter Notebook with PyTorch 2-2-1 MLP, gradient checks, symmetry experiment, and 3-class Softmax extension.
* **`xor_linear_separability.png`**: Geometric plot of the XOR dataset in $\mathbb{R}^2$ with candidate linear boundaries.
* **`README.md`**: Summary of mathematical proofs, experimental results, and reflection answers for grading.

---

## 1. Linear Inseparability of XOR (Task 1)
Any single linear boundary $w_1 x_1 + w_2 x_2 + b = 0$ requires:
$$b < 0, \quad w_2 + b > 0, \quad w_1 + b > 0, \quad w_1 + w_2 + b < 0$$
Combining the second and third inequalities yields $w_1 + w_2 + 2b > 0 \implies w_1 + w_2 + b > -b > 0$, directly contradicting the fourth inequality ($w_1 + w_2 + b < 0$).  
Thus, **no single straight line in $\mathbb{R}^2$ can separate XOR**.

---

## 2. Experimental Results

### Part A: Basic Learning Check (2-2-1 Network, Tanh)
* **Initial Loss:** $0.6952$
* **Final Loss:** $< 0.0001$
* **Predictions:**
  * $(0, 0) \to 0.0001$ (Class 0)
  * $(0, 1) \to 0.9998$ (Class 1)
  * $(1, 0) \to 0.9998$ (Class 1)
  * $(1, 1) \to 0.0001$ (Class 0)
* **Accuracy:** **4/4 Correct (100%)**

### Part B: Backpropagation & Gradients
* **`model.fc1.weight.grad`** represents $\frac{\partial L}{\partial W^{(1)}}$.
* Proved that because `reduction='mean'`, the accumulated gradient is the exact arithmetic average of the four example-wise gradients: $\frac{\partial L}{\partial W^{(1)}} = \frac{1}{4} \sum_{i=1}^4 \frac{\partial L_i}{\partial W^{(1)}}$.

### Part C: Symmetry Experiment (Zero Weight Initialization)
* Initialized all weights and biases to exactly $0.0$.
* **Observation:** Both hidden units computed identical outputs ($h_1 = h_2 = \sigma(0)$) and received identical gradients throughout training.
* **Outcome:** The two rows of $W^{(1)}$ remained strictly identical ($W^{(1)}_{0,:} == W^{(1)}_{1,:}$). The network suffered from complete representational symmetry, collapsing into a 1-neuron model that failed to learn XOR (Accuracy $2/4 = 50\%$).

### Part D: Activation Function Comparison

| Hidden Activation | Final Loss | 4/4 Correct? | Early $\|\nabla_{W^{(1)}} L\|_2$ |
| :--- | :---: | :---: | :---: |
| **Sigmoid** | $0.000312$ | **Yes** | $0.1124$ |
| **Tanh** | $0.000045$ | **Yes** | $0.3218$ |
| **ReLU** | $0.000088$ | **Yes** | $0.4412$ |

* **Scientific Explanation:** Sigmoid derivatives are bounded by $0.25$, attenuating the backpropagated signal. Tanh derivatives are bounded by $1.0$ and zero-centered. ReLU derivatives are $1.0$ for positive pre-activations, producing the highest initial gradient magnitude.

---

## 3. Multiclass Extension (Task 5)
* Converted sensor outputs to 3 classes (Class 0: Both inactive, Class 1: Disagree, Class 2: Both active) using 3 output logits and `CrossEntropyLoss`.
* Proved why softmax probabilities sum to $1.0$.
* **Shift Invariance Test:** Added $+100$ to all logits before softmax; verified that output probabilities remained identical within floating-point roundoff:
  $$\frac{e^{z_i + C}}{\sum_j e^{z_j + C}} = \frac{e^C e^{z_i}}{e^C \sum_j e^{z_j}} = \frac{e^{z_i}}{\sum_j e^{z_j}}$$
  Explains why production implementations (like PyTorch) subtract $\max(z)$ to prevent numerical overflow.
