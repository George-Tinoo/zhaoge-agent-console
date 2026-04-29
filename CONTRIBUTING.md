# 贡献指南

感谢您对朝歌 (Chaoge) Agent Console 的兴趣！本文档将帮助您了解如何参与项目贡献。

## 📋 目录

- [行为准则](#行为准则)
- [如何贡献](#如何贡献)
- [开发流程](#开发流程)
- [代码规范](#代码规范)
- [提交规范](#提交规范)

## 🤝 行为准则

- 尊重所有参与者
- 接受建设性批评
- 关注什么对社区最有益
- 对其他社区成员表示同理心

## 🚀 如何贡献

### 报告 Bug

在提交 Bug 报告之前，请先检查是否已有类似 Issue。

提交时请包含：
- 问题描述
- 复现步骤
- 期望行为
- 实际行为
- 环境信息（系统版本、App 版本等）
- 截图或录屏（如有）

### 建议新功能

- 使用清晰的标题描述功能
- 详细说明使用场景
- 描述期望的行为
- 如有参考案例，请提供链接

### 提交代码

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 💻 开发流程

### 环境准备

```bash
# 克隆仓库
git clone https://github.com/chaoge/chaoge-agent-console.git
cd chaoge-agent-console

# 安装依赖
pnpm install
```

### 分支策略

- `main` - 稳定分支，只接受通过测试的代码
- `develop` - 开发分支，新功能先合并到这里
- `feature/*` - 功能分支
- `fix/*` - 修复分支

### 开发工作流

1. 从 `develop` 分支创建功能分支
2. 开发并测试您的代码
3. 确保代码通过 lint 和测试
4. 提交 PR 到 `develop` 分支
5. 等待代码审查
6. 合并后删除功能分支

## 📝 代码规范

### Swift (iOS)

- 使用 SwiftLint 检查代码风格
- 遵循 Swift API 设计指南
- 使用有意义的命名
- 添加适当的注释

### TypeScript (后端)

- 使用 ESLint 和 Prettier
- 严格模式启用
- 明确的类型定义
- 函数长度不超过 50 行

### 通用规范

- 代码自解释，注释说明"为什么"而非"是什么"
- 单一职责原则
- DRY (Don't Repeat Yourself)
- 早返回，减少嵌套

## 🎯 提交规范

### Commit Message 格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型

- `feat`: 新功能
- `fix`: 修复 Bug
- `docs`: 文档更新
- `style`: 代码格式（不影响功能）
- `refactor`: 重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

### 示例

```
feat(chat): 添加语音输入功能

- 实现长按语音输入
- 添加语音识别转文字
- 支持语音波形动画

Closes #123
```

## 🧪 测试

### 单元测试

```bash
# 运行所有测试
pnpm test

# 运行特定模块测试
pnpm test:unit

# 运行 e2e 测试
pnpm test:e2e
```

### 测试覆盖率

- 核心功能覆盖率 > 80%
- 新功能必须包含测试
- 修复 Bug 先写测试复现

## 📚 文档

- 更新代码时同步更新相关文档
- 新功能必须包含使用说明
- API 变更需更新 API_SPEC.md

## ❓ 问题咨询

如有疑问，可以通过以下方式联系：

- 提交 Issue
- 邮件联系: contact@chaoge.ai
- 社区讨论: Discussions

## 🙏 感谢

再次感谢您的贡献！
