# Homework 2

### 问题1

​	**(a).** 我们先证明： $QSort(l, r)$ 执行后的数组 $A[l], A[l + 1], \cdots , A[r]$ 有序。

​	对 $r - l$ 的值进行归纳。  

​	$r - l = 0$ 时，有 $r = l$ ，此时 $Q(l, l)$ 无操作，而 $A[l]$ 本身有序。  

​	假设 $r - l \leq k$ 时结论成立。 讨论 $r - l = k + 1$ 。

​	此时调用 $QSort(l, r)$，考虑在再次调用 $QSort$ 之前的部分，每一次交换 $A[i], A[j]$后， 都保证了 $A[l], \cdots ,A[i]\leq pivot, A[j], \cdots, A[r] \geq pivot$， 当最外层的 $while$​ 执行完后，有 

​	$\left\{
​	\begin{equation}
​		\begin{array} {l1}
​			i = j + 1 \\ \max\limits_{ 1 \leq t \leq j}\{A[t]\} \leq \min\limits_{j + 1 \leq t \leq r}\{A[t]\}	\end{array}
​	\end{equation}
\right.$   或者 $\left\{
​	\begin{equation}
​		\begin{array} {l1}
​			A[u] = pivot \\ j + 1 = u = i - 1 \\ \max\limits_{ 1 \leq t \leq j}\{A[t]\} \leq pivot \leq \min\limits_{i \leq t \leq r}\{A[t]\}	\end{array}
​	\end{equation}
\right.$

​	对于前种情况，调用 $QSort(l, j)$ 与 $QSort(i, r)$ 之后，$A[l], A[l + 1], \cdots , A[j]$ 与 $A[i], A[i + 1], \cdots , A[r]$ 皆有序，并且有 $\max\limits_{ 1 \leq t \leq j}\{A[t]\} \leq \min\limits_{j + 1 \leq t \leq r}\{A[t]\}$ ，不难知道数组 $A[l], A[l + 1], \cdots, A[r]$ 此时已经有序。

​	对于后者，我们同理可以证明 $A[l], A[l + 1], \cdots , A[j]$ 与 $A[i], A[i + 1], \cdots , A[r]$ 皆有序，并且有 $\max\limits_{ 1 \leq t \leq j}\{A[t]\} \leq pivot \leq \min\limits_{j + 1 \leq t \leq r}\{A[t]\}$ ，知道数组 $A[l], A[l + 1], \cdots, A[r]$ 此时已经有序。

​	因此归纳假设成立，我们知道调用 $Qsort(l, r)$ 后数组由下标 $l$ 到 $r$ 的部分已经有序。

​	于是我们可以知道，调用 $Qsort(1, n)$ 后，整个数组 $A$ 也有序，故正确性得证。

**问题3**：

​	**(a).** 分析：由于数组 $X$​ 已经有序，所以我们二分答案。

​	设 $X$ 中共有 $k$ 个元素比 $key$ 值小，注意到 $k$ 应该满足如下条件：
$$
X[k] \leq key < X[k + 1]
$$
​	因此我们设初始条件 $left = 1, right = n + 1$， 判断条件为 $left < right$ ，对 $k$ 进行二分即可得到答案。

​	伪代码：
$$
\begin{array}{l1}
\hline
\textbf{Algorithm} \enspace Binary \enspace Search \\
\hline
1: \textbf{function} \enspace Bsearch(l, r) \\
2: \qquad int \enspace left = l, right = r + 1 \\
3: \qquad int \enspace mid = left + (right - left) >> 1 \\
4: \qquad \textbf{while} \enspace left < right \enspace \textbf{do}\\
5: \qquad \qquad \textbf{if} \enspace key < X[mid] \enspace \textbf{then} \\
6: \qquad \qquad \qquad right = mid \\
7: \qquad \qquad \textbf{else} \\
8: \qquad \qquad \qquad left = mid + 1 \\
9: \qquad return \enspace left \\
\hline
\end{array}
$$


​	**(b). ** 分析：数组 $X$ ， $Y$ 均有序，要做到时间复杂度 $O(log\enspace n)$，我们同样使用二分法。

​	我们取 $X$ , $Y$ 中间元素 $X[mid_x]$ 与 $Y[mid_y]$ ，这里 $mid_x = mid_y = n / 2$。不妨设有 $X[mid_x] \geq Y[mid_y]$ （另一种情况对称可得）。这时对于 $Y[mid_y]$ 有
$$
\left\{
	\begin{array}{l1}
		Y[mid_y] \geq Y[mid_y - 1] \geq \cdots \geq Y[1] \\
		Y[mid_y] \geq X[mid_x] \geq X[mid_x - 1] \geq \cdots \geq X[1]
	\end{array}
\right.
$$
​	即 $Y[mid_y]$ 至少是两个数组中第 $n$ 大的数。

​	同时对 $X[mid_x]$ 有：
$$
\left\{
	\begin{array}{l1}
		X[mid_x] \leq X[mid_x + 1] \leq \cdots \leq X[n] \\
		X[mid_x] \leq Y[mid_y] \leq Y[mid_y + 1] \leq \cdots \leq Y[n]
	\end{array}
\right.
$$
​	即 $X[mid_x]$ 至少是两个数组中第 $n$ 小的数。

#### 问题4：

​	**(a).**  $n$ 个未知元素的 全排列一共有 $n!$ 种。我们考虑其中任意 $1\%$ 的全排列，即其中 $0.01n!$​ 种排列。

​	考虑 $0.01n!$ 种排列产生的决策树，设树高为 $h$ ，则我们知道其有 $0.01n!$ 片树叶。那么可以得到关于树高的不等式：
$$
0.01n! \leq 2^{h - 1}
$$
于是有 
$$
h \geq log(0.01n!) + 1 = \Omega(nlogn)
$$
所以知道任一排序算法对至少 $99\%$ 的排列，都需要比较至少 $cnlogn$ 次，取 $c = 0.5$ ，即有
$$
\Pr\limits_{\sigma}\left[Time(A(\sigma)) \geq 0.5nlogn\right] \geq 0.99
$$
故结论成立。

​	**(b).** 假定算法 $A$ 采用固定长度 $l$ 的随机数 $r$ ， 同 $(a)$ 我们考虑 $\dfrac{n!}{2^l}$ 的全排列，有
$$
\dfrac{n!}{2^l} \leq 2^{h - 1} \\ 
\Rightarrow h \geq log(n!) + l + 1 = \Omega(nlogn)
$$
​	于是有对确定算法 $A(*, r_0)$， 其中 $r_0$ 是某一确定的随机数， 有：
$$
\Pr\limits_{\sigma}[Time(A(\sigma, r_0))\geq 0.5nlogn] \geq 1 - \dfrac{1}{2^l}
$$
​	对于所有随机数 $r$ ，一共有 $2^l$ 种可能性，每一个随机数 $r$ 会对应至少 $1 - \dfrac{1}{2^l}$ 个排列 $\sigma$ ， 其运行时间复杂度为 $\Omega(nlogn)$ 。

​	也就是说，至少存在一个排列 $\sigma_0$ ，其在 $2^l - 1$ 种随机数 $r$ 中运行时间均为 $\Omega(nlogn)$ 。我们可以求对于 $\sigma_0$ 的运行时间期望。
$$
\underset{r}{E}[Time(A(\sigma_0, r))] = \dfrac{1}{2^l}\sum\limits_{r}Time(A(\sigma_0, r)) = \dfrac{1}{2^l}((2^l - 1)\Omega(nlogn) + O(n^2)) = \Omega(nlogn)
$$










