#### 问题4：

​	**(a). ** 也即是要证明一个 $h_2-$有序的数组 $(\forall \enspace 0 < i \leq n - h_2, A_i \leq A_{i + h_2})$ ，执行 $h_1-$排序 $((\forall \enspace 0 < i \leq n - h_1, A'_i \leq A'_{i + h_1}))$ 之后，它仍然是 $h_2-$有序的。

​	设 $h_1-$排序前的数组为 $A$， $h_1-$排序后的数组为 $B$，那么我们有：
$$
\left\{
	\begin{equation}
		\begin{array} {l1}
			A_i \leq A_{i + h_2}, \forall \enspace 0 < i \leq n - h_2 \\
			B_i \leq B_{i + h_1}, \forall \enspace 0 < i \leq n - h_1
		\end{array}
	\end{equation}
\right.
$$
​	考虑 $\forall \enspace 0 < i \leq h_1$， 我们有：
$$
B_i \leq B_{i + h_1} \leq B_{i + 2h_1} \leq \cdots \leq B_{i + m_ih_1}, \text{其中} i + m_ih_1 < n < i + (m_i + 1)h_1
$$

$$
\cdots \leq B_{i + h_2} \leq B_{i + h_2 + h_1} \leq B_{i + h_2 + 2h_1} \leq \cdots \leq B_{i + h_2 + m_ih_1}
$$

​	对于 $B_i$， 我们知道 $B_i = \min\limits_{0 \leq k \leq m_i}\{A_{i + kh_1}\} \leq \min\limits_{0 \leq k \leq m_i}{A_{i + h_2 + kh_1}}$ 。

​	由于 $\cdots, B_{i + h_2}, B_{i + h_2 + h_1} , \cdots , B_{i + h_2 + m_ih_1}$ 为 $\cdots, A_{i + h_2}, A_{i + h_2 + h_1} , \cdots , A_{i + h_2 + m_ih_1}$ 的有序排列。

​	因此 $A_{i + h_2 + kh_1}, 0 \leq k \leq m_i$ 中比 $B_{i + h_2}$ 大的数不超过 $m_i$ 个， 而 $A_{i + h_2 + kh_1}, 0 \leq k \leq m_i$ 中共有 $m_i + 1$ 个数。于是我们可以得到：
$$
B_i = \min\limits_{0 \leq k \leq m_i}\{A_{i + kh_1}\} \leq \min\limits_{0 \leq k \leq m_i}{A_{i + h_2 + kh_1}} \leq B_{i + h_2}
$$
​	对于 $B_{i + th_1}, 0 < t \leq m_i$， 同理有 $B_{i + th_1} = \min\limits_{0 \leq k \leq m_i}^{t}\{A_{i + kh_1}\}, \text{这里用}\min\limits^{t}\text{表示第}t\text{小的数}$​。

​	同样有 $B_{i + th_1} = \min\limits_{0 \leq k \leq m_i}^{t}\{A_{i + kh_1}\} \leq \min\limits_{0 \leq k \leq m_i}^{t}{A_{i + h_2 + kh_1}}$ 。

​	而 $A_{i + h_2 + kh_1}, 0 \leq k \leq m_i$ 中比 $B_{i + h_2 + th_1}$ 大的数不超过 $m_i - t$ 个。所以其中一定有至少 $t + 1$ 个数比 $B_{i + h_2 + th_1}$ 小

​	因此得到 $B_{i + th_1} = \min\limits_{0 \leq k \leq m_i}^{t}\{A_{i + kh_1}\} \leq \min\limits_{0 \leq k \leq m_i}^{t}{A_{i + h_2 + kh_1}} \leq B_{i + h_2 + th_1}$。

​	这个结果对所有的 $i$ 和 $t$ 成立，而这覆盖了整个 $B_i, 0 < i \leq n - h_2$。

​	因此我们就证明了结果，对于 $\forall \enspace 0 < i \leq n - h_2, B_i \leq B_{i + h_2}$。

​	**(b).** 设数组 $A$ 执行完 $InsertionSort(h_{t + 1})$ 和 $InsertionSort(h_t)$，那么我们知道数组 $A$ 既是 $h_{t+1}-$有序的，也是$h_t-$有序的。

​	即有：
$$
\left\{
	\begin{equation}
		\begin{array} {l1}
			A_i \leq A_{i + h_{t + 1}}, \forall \enspace 0 < i \leq n - h_{t + 1} \\
			A_i \leq A_{i + h_t}, \forall \enspace 0 < i \leq n - h_t
		\end{array}
	\end{equation}
\right.
$$
​	要证明执行 $InsertionSort(h_{t - 1})$ 的时间复杂度为 $O(\dfrac{n\cdot h_{t + 1}\cdot h_t}{h_{t - 1}})$ ，我们只需要证明对于 $\forall h_{t + 1}h_t < j \leq n$, 都有 $A_j \geq A_k, \forall \enspace 0 < k \leq j - h_{t+1}t_t$。 若上式成立，则每个数在执行 $InsertionSort(h_{t - 1})$ 时的交换次数都不会超过 $\dfrac{h_{t + 1}h_t}{h_{t - 1}}$ 次，我们很容易证明要证的结论成立。

​	对于 $\forall h_{t + 1}h_t < j \leq n$， 我们有
$$
\left\{
	\begin{equation}
		\begin{array} {l1}
			A_j \geq A_{j - h_{t + 1}} \geq A_{j - 2h_{t + 1}} \geq \cdots \geq A_{j - m_1h_{t + 1}}, \text{其中}\enspace j - (m_1 + 1)h_{t + 1} < 0 < j - m_1h_{t + 1} \\
			A_j \geq A_{j - h_t} \geq A_{j - 2h_t} \geq \cdots \geq A_{j - m_2h_t},\text{其中}\enspace j - (m_1 + 1)h_t < 0 < j - m_1h_t
		\end{array}
	\end{equation}
\right.
$$
​	于是我们可以得到 $A_j \geq A_j - (ah_{t + 1} + bh_t), \text{其中}\enspace 0 \leq a \leq m_1, 0 \leq b \leq m_2$​。

​	于是我们只需要证明 $ah_{t + 1} + bh_t$ 覆盖所有 $k$， $h_{t + 1}h_t \leq k < j$。

​	我们设 $ah_{t + 1} + bh_t = k, k \geq h_{t + 1}h_t$。

​	我们可以写出它的一组通解（由于 $h_{t + 1}$ 与 $h_t$ 互质，一定能找到特解 $a_0, b_0$）：
$$
\left\{
	\begin{equation}
		\begin{array} {l1}
			a = kh_t + a_0	\\
			b = -kh_{t + 1} + b_0
		\end{array}
	\end{equation}
\right.
$$
​	于是我们可以找到 $a^* = k^*h_t + a_0, 0 \leq a^* < h_t $ 。

​	于是有
$$
	b^*h_t = k - a^*h_{t + 1} \geq h_{t + 1}h_t - h_th_{t + 1} = 0
$$
​	由于 $h_t > 0$ ， 因此我们知道 $b^* \geq 0$。

​	所以 $a^*, b^*$为 $ah_{t + 1} + bh_t = k, k \geq h_{t + 1}h_t$ 的一组非负整数解。

​	所以 $ah_{t + 1} + bh_t$ 将覆盖所有大于等于 $h_{t + 1}h_t$ 的数。

​	所以 $A_j \geq A_j - k, \text{其中}\enspace h_{t + 1}h_t \leq k < j$。

​	所以对于 $ \forall \enspace 0 < j \leq n $ ，$A_j$ 移动次数不超过 $\dfrac{h_{t + 1}h_t}{h_{t - 1}}$ 次。

​	所以 $InsertionSort(h_{t - 1})$ 的时间复杂度为 $O(\dfrac{n\cdot h_{t+1}\cdot h_t}{h_{t - 1}})$。

​	故引理得证。

​	