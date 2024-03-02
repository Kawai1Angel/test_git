## Homework 1

#### 	问题1：

​		**(a).** 时间复杂度的最紧估计为 $O(2^n)$。 

​		分析过程：

​			记 $T(n)$ 为输入 $n$ 时执行指令的时间。

​			当 $n = 1$ 时，有 $T(1) = 1 + 			1 = 2$。

​			当 $n > 1$ 时，有 $T(n) = 1 + 1 + \sum\limits_{k = 1}^{n - 1} (T(k) + 1) + 1$。			于是我们得到 $T(n) = \sum\limits_{k = 1}^{n - 1}T(k) + n + 2$。

​			同理可得 $T(n - 1) = \sum\limits_{k = 1}^{n - 2}T(k) + n + 1$​。

​			两式相减，可得 $T(n) - T(n - 1) = T(n - 1) + 1$。

​			即 $T(n) + 1 = 2 (T(n - 1) + 1)$。

​			于是有 $T(n) = 2^{n - 1} (T(1) + 1) - 1 = 3 \times 2^{n - 1} - 1$。

​			因此可知该段代码时间复杂度的最紧估计为 $T(n) = O(2^n)$

​		**(b).** 代码功能：返回长度为n的数组，其中下标为质数的项的值全部为1，其余项（下标为合数或1）的值全部为0。

​		最紧时间复杂度：

​			当 $n = 1$ 时，有 $T(1) = 1 + 1 + 1 = 3$。

​			当 $n > 1$ 时，有 $T(n) = 1 + \sum\limits_{i = 2}^{n} (1 + \sum\limits_{j = 2}^{\lfloor\sqrt{i}\rfloor}(1 + 1) + 1)$。

​			于是我们有 $T(n) = 2\sum\limits_{i = 2}^{n}\sum\limits_{j = 2}^{\lfloor\sqrt{i}\rfloor}1 + O(n)$。

​			即 $T(n) = 2\sum\limits_{i = 2}^{n}\lfloor\sqrt{i}\rfloor + O(n)$。

​			由于有
$$
\begin{aligned}
\lim\limits_{n \rightarrow \infin}\frac{\sum\limits_{k = 1}^{n}\sqrt{k}}{n^{1.5}} &= \lim\limits_{n \rightarrow\infin} \frac{\sqrt{n}}{n^{1.5} - (n - 1)^{1.5}} \\ &= \lim\limits_{x \rightarrow 0^+} \frac{1}{x^{0.5}(x^{-1.5} - (\frac{1}{x} - 1)^{1.5})} \\ &= \lim\limits_{x \rightarrow 0^+}\frac{x}{1 - (1 - x)^{1.5}} \\ &= \lim\limits_{x \rightarrow 0^+}\frac{1}{1.5(1 - x)^{0.5}} \\ &= \frac{2}{3}
\end{aligned}
$$
​			即 $\sum\limits_{k = 1}^{n}\sqrt{k} \enspace \text{与} \enspace n^{1.5}$ 为同阶无穷大。

​			因此有 $T(n) = 2\sum\limits_{i = 2}^{n}\lfloor\sqrt{i}\rfloor + O(n) = O(n^{1.5})$。

​			记 $N = input \enspace  length$，用 $N$ 表示可得 $T(N) = O(2^{1.5N})$。

#### 问题2：

​	**(a).** 考虑问题的反面，先求第一个盒子中只有0个或一个球的概率。

​		$P(\text{1号盒恰有1个球}) = \frac{C_n^1 (N-1)^{n - 1}}{N^n}$

​		$P(\text{1号盒恰有0个球}) = \frac{(N-1)^n}{N^n}$

​		于是我们所求的概率
$$
\begin{aligned}
P(\text{1号盒至少2个球}) &= 1 - P(\text{1号盒恰好0个球}) - P(\text{1号盒恰好1个球}) \\ &= 1 - \frac{C_n^1 (N-1)^{n - 1}}{N^n} - \frac{(N - 1)^n}{N^n} = 
\end{aligned}
$$
