# high-school-math

高中数学专题文档生成、数学建模、LaTeX 数学文档与数学问题解答的 **AI 技能包**（面向人教版A版教材、刚学完必修课或基础较弱的学生）。

一个内容源，适配市面上绝大多数 AI 编码工具：Claude Code、opencode、GitHub Copilot、Cursor、Gemini CLI、Zed、Qwen Code、Windsurf 等。

## 特性

- 📄 **高中数学专题 Word 文档**：标准结构（标题页 → 知识梳理 → 专题 → 考点 → 例题 → 5 道星级实战+答案 → 拓展），面向基础学生、讲清来龙去脉。
- 🧮 **数学建模**：问题重述 → 假设 → 符号 → 建模 → 求解 → 分析 → 评价的完整流程。
- 🎨 **LaTeX**：ctex 中文数学文档模板、amsmath 公式风格、tikz 作图、booktabs 表格。
- ✅ **数学正确性保障**：逐题验算、公式对照教材、量纲自检、交付检查清单——降低 AI 生成数学内容的幻觉与算错风险。
- 🔌 **跨工具**：同一套规范通过 `SKILL.md` / `AGENTS.md` / Copilot instructions / Cursor rules 四种形态适配不同 AI。

## 目录结构

```
high-school-math-skill/
├── README.md                        # 本文件
├── LICENSE                          # MIT
├── AGENTS.md                        # 通用指令（Gemini CLI / Cursor / Zed / Qwen / opencode 读取）
├── high-school-math/
│   └── SKILL.md                     # 技能本体（Claude Code / opencode / agents 生态）
├── .github/
│   └── copilot-instructions.md      # GitHub Copilot 指令
├── .cursor/
│   └── rules/high-school-math.mdc   # Cursor Rules
├── install/
│   ├── install.py                   # 跨平台安装脚本（推荐）
│   ├── install.sh                   # bash 安装
│   └── install.ps1                  # PowerShell 安装
└── examples/                        # 示例与使用说明
```

## 安装

### 方式一：安装脚本（推荐）

```bash
# 全局安装到所有检测到的 AI 工具
python install/install.py            # 或 ./install/install.sh / install.ps1

# 同时安装到当前项目（.opencode/.claude/.github）
python install/install.py --project

# 只看会装到哪些位置，不实际写入
python install/install.py --list
```

脚本会自动把 `SKILL.md`、Cursor rule、Copilot instructions 复制到各工具的配置目录。

### 方式二：手动放置

| AI 工具 | 放置位置 |
|---|---|
| Claude Code | `~/.claude/skills/high-school-math/SKILL.md` 或项目 `.claude/skills/` |
| opencode | `~/.config/opencode/skills/high-school-math/SKILL.md` 或项目 `.opencode/skills/` |
| Gemini CLI / Zed / Qwen / Cursor | 把 `AGENTS.md` 放到项目根目录 |
| Cursor | `.cursor/rules/high-school-math.mdc`（或复制到 `~/.cursor/rules/`） |
| GitHub Copilot | 把 `.github/copilot-instructions.md` 放到项目根 |
| Windsurf | `.windsurf/rules/high-school-math.md` |

> 安装/放置后，**重启你的 AI 工具**使其重新加载配置。

## 使用触发词

- 高中数学专题 / 辅导文档 / 复习资料 / 讲义 / 试卷
- 数学建模
- LaTeX / 公式
- 圆锥曲线 / 空间向量 / 直线和圆 / 数列 / 三角函数 等章节名

## 支持工具矩阵

| 工具 | 读取方式 | 形态 |
|---|---|---|
| Claude Code | `~/.claude/skills/` 自动扫描 | `SKILL.md` |
| opencode | `~/.config/opencode/skills/` 或 `.opencode/skills/` 自动扫描 | `SKILL.md` |
| GitHub Copilot | `.github/copilot-instructions.md` | 纯 Markdown 指令 |
| Cursor | `.cursor/rules/*.mdc`（或 AGENTS.md） | MDC + AGENTS |
| Gemini CLI / Zed / Qwen Code | `AGENTS.md` | 纯 Markdown 指令 |
| 其他 LLM 应用 | 直接把 `AGENTS.md` 内容作为系统提示 | 纯文本 |

## 自定义

想调整规范（如改用北师大版、改变文档结构、调整难度）：
1. 编辑 `high-school-math/SKILL.md`（单事实源）。
2. 同步 `AGENTS.md`（内容一致）。
3. 重跑 `install/install.py` 更新已安装位置。

## License

MIT，详见 [LICENSE](LICENSE)。
