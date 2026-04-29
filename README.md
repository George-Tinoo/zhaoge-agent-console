# 朝歌 (Chaoge) Agent Console

<p align="center">
  <img src="docs/assets/logo.png" alt="朝歌 Logo" width="120">
</p>

<p align="center">
  <b>随身 AI 伴侣，数字生命中枢</b>
</p>

<p align="center">
  <a href="./docs/PRODUCT_SPEC.md">产品规格</a> •
  <a href="./docs/ARCHITECTURE.md">架构设计</a> •
  <a href="./docs/UI_SPEC.md">UI 规范</a> •
  <a href="./docs/API_SPEC.md">API 文档</a> •
  <a href="./docs/ROADMAP.md">开发路线</a>
</p>

---

## 🌟 项目简介

**朝歌 (Chaoge)** 是一款面向未来的 AI 原生操作系统前端，旨在打造用户与多个 AI Agent 之间的智能协作中枢。

### 核心理念

- **硅基生命美学** - 独特的灰蓝水晶视觉风格，体现 AI 生命的灵动与深邃
- **多 Agent 协作** - 主管 Agent 统筹协调，多个 Specialist Agent 分工执行
- **主动服务** - Agent 主动推送、任务提醒，而非被动等待提问
- **知识沉淀** - 项目 + 知识双维度管理，构建个人 AI 外脑

### 支持平台

| 平台 | 状态 | 优先级 |
|------|------|--------|
| iOS | 🚧 开发中 | P0 |
| macOS | 📋 计划中 | P1 |
| Android | 📋 计划中 | P2 |
| Windows | 📋 计划中 | P2 |

---

## 📚 文档导航

### 产品文档

- [PRODUCT_SPEC.md](./docs/PRODUCT_SPEC.md) - 完整产品规格说明书
  - 功能模块详述
  - 用户流程设计
  - 交互规范

- [ROADMAP.md](./docs/ROADMAP.md) - 开发路线图
  - 5 阶段开发计划
  - 里程碑定义
  - 风险评估

### 技术文档

- [ARCHITECTURE.md](./docs/ARCHITECTURE.md) - 系统架构设计
  - 模块划分
  - 数据库设计
  - 部署架构

- [API_SPEC.md](./docs/API_SPEC.md) - API 接口规范
  - REST API 定义
  - WebSocket 协议
  - 错误码说明

- [UI_SPEC.md](./docs/UI_SPEC.md) - UI 设计规范
  - 硅基生命视觉风格
  - 色彩系统
  - 组件规范

---

## 🏗️ 项目结构

```
chaoge-agent-console/
├── apps/
│   ├── ios/              # iOS 原生应用 (Swift)
│   ├── android/          # Android 应用 (计划中)
│   ├── desktop/          # 桌面端应用 (计划中)
│   └── web/              # Web/PWA 版本 (计划中)
├── server/               # 后端服务 (Node.js)
│   ├── src/
│   │   ├── services/     # 业务服务
│   │   ├── models/       # 数据模型
│   │   ├── controllers/  # 控制器
│   │   └── adapters/     # 外部适配器
│   └── tests/
├── packages/
│   └── shared/           # 共享类型和工具
├── docs/                 # 文档
│   ├── PRODUCT_SPEC.md
│   ├── ARCHITECTURE.md
│   ├── API_SPEC.md
│   ├── UI_SPEC.md
│   └── ROADMAP.md
└── scripts/              # 工具脚本
```

---

## 🚀 快速开始

### 环境要求

- **iOS 开发**: macOS 12+, Xcode 15+, Swift 5.9+
- **后端开发**: Node.js 20+, pnpm/npm
- **设计**: Figma (设计文件待补充)

### iOS 开发

```bash
# 克隆仓库
git clone https://github.com/chaoge/chaoge-agent-console.git
cd chaoge-agent-console/apps/ios

# 安装依赖
pod install

# 打开项目
open Chaoge.xcworkspace
```

### 后端开发

```bash
# 进入后端目录
cd chaoge-agent-console/server

# 安装依赖
pnpm install

# 配置环境变量
cp .env.example .env
# 编辑 .env 配置数据库等

# 启动开发服务器
pnpm dev
```

---

## 🤝 参与贡献

我们欢迎所有形式的贡献！

### 贡献方式

1. **提交 Issue** - 报告 Bug 或提出新功能建议
2. **提交 PR** - 修复问题或实现新功能
3. **完善文档** - 帮助改进文档质量
4. **分享使用经验** - 在社区分享你的使用心得

### 开发规范

- 遵循现有的代码风格
- 提交前确保通过测试
- 重大变更请先开 Issue 讨论
- 保持 commit message 清晰明确

---

## 📄 许可证

[MIT License](./LICENSE) © 2026 朝歌团队

---

## 🙏 致谢

- 感谢端脑云提供云端算力支持
- 感谢所有参与设计和开发的贡献者

---

<p align="center">
  <sub>Designed with 💎 by 妲己 for 大王</sub>
</p>
