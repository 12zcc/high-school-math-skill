# Examples

本目录存放该技能包的示例，帮助理解规范如何落地。

## 参考实现（本仓库已有真实样例）

`E:\workspace\高中数学A选修一专题\` 下有三个按本规范生成的文档与脚本，可直接作为模板：

| 脚本 | 对应文档 | 章节 |
|---|---|---|
| `build_space.py` | 第一章_空间向量与立体几何.docx | 空间向量与立体几何 |
| `build_line_circle.py` | 第二章_直线和圆的方程.docx | 直线和圆的方程 |
| `build_conic.py` | 第三章_圆锥曲线的方程.docx | 圆锥曲线的方程 |
| `docx_helpers.py` | —（共享排版模块） | 排版辅助 |

## 最小示例：生成一份 .docx 专题文档

```python
import docx_helpers as H   # 复制本仓库同目录的 docx_helpers.py

doc = H.create_document()
H.add_title_page(doc, "高二数学专题复习——数列", "选择性必修第二册 第四章")

H.add_knowledge_review_title(doc)
H.add_knowledge_subtitle(doc, "一、本章知识网络")
H.add_knowledge_tree(doc, [
    (0, "等差数列"),
    (1, "通项 aₙ=a₁+(n−1)d，前n项和 Sₙ=na₁+n(n−1)d/2"),
    (0, "等比数列"),
    (1, "通项 aₙ=a₁qⁿ⁻¹，前n项和 Sₙ=a₁(1−qⁿ)/(1−q)"),
])

H.add_section_heading(doc, "专题一：等差数列")
H.add_section_heading(doc, "考点1：通项与前n项和", level=2)
H.add_body_text(doc, "等差数列中，aₙ=a₁+(n−1)d，Sₙ=na₁+n(n−1)d/2。")
H.add_example(doc, "【例题1】",
    "等差数列{aₙ}中，a₁=2，d=3，求a₁₀与S₁₀。",
    "a₁₀=2+9×3=29；S₁₀=10×2+10×9×3/2=155。")
H.add_practice_header(doc)
H.add_practice(doc, [
    ("★☆☆", "等差数列{aₙ}中，a₁=1，d=2，求a₈。",
     "a₈=1+7×2=15。"),
])
H.add_extension(doc, "等差中项", "a、A、b 成等差数列 ⇔ 2A=a+b。")

H.save_document(doc, "示例_数列.docx")
print("OK")
```

运行方式：把 `docx_helpers.py`（位于本仓库参考实现的 `高中数学A选修一专题/` 目录）放到脚本同目录，然后 `python build_sample.py`。

## LaTeX 最小示例

```latex
\documentclass[12pt]{ctexart}
\usepackage{amsmath, amssymb}
\begin{document}
等差数列：$a_n=a_1+(n-1)d$，前 $n$ 项和
\[ S_n = na_1 + \frac{n(n-1)}{2}d \]
\end{document}
```
