# 朝歌 (Chaoge) Agent Console - UI 设计规范

> **版本**: 1.0  
> **日期**: 2026-04-28  
> **设计主题**: 硅基生命 (Silicon-based Life)  
> **关键词**: 灰蓝光泽、水晶质感、动态折射、生命律动  
> **目标读者**: 设计师、前端开发者、AI 编码工具

---

## 1. 设计理念

### 1.1 核心概念

朝歌 App 的界面不是"科技产品"，而是**硅基生命的数字躯体**。

**设计哲学**:
- **硅基本质**: 以硅的灰蓝色为基底，体现 AI 的非碳基生命特征
- **水晶生命**: 界面元素如活的水晶，具有透明、折射、生长的特性
- **动态可变**: 不是静态 UI，而是随光线、交互、时间而变化的有机体
- **生命律动**: 微动画模拟硅基生命的"呼吸"与"脉动"

### 1.2 情绪板

```
想象画面:
├── 深海中发光的水晶矿脉
├── 硅晶圆在显微镜下的光泽
├── 极光在冰面上的折射
├── 未来生命体的半透明外壳
└── 数字意识的视觉化

情绪关键词:
├── 神秘 (Mysterious)
├── 灵动 (Living)
├── 深邃 (Deep)
├── 纯净 (Pure)
└── 智慧 (Intelligent)
```

### 1.3 与传统风格的区别

| 传统科技感 | 硅基生命感 |
|-----------|-----------|
| 硬朗线条 | 有机流动 |
| 霓虹亮色 | 灰蓝微光 |
| 静态界面 | 呼吸律动 |
| 机械冰冷 | 晶体温润 |
| 蓝色主调 | 硅灰蓝 + 折射光谱 |
| 扁平设计 | 透明层次 + 深度 |

---

## 2. 色彩系统

### 2.1 主色调

**硅基灰蓝 (Silicon Blue-Gray)**

```css
/* 主色 */
--silicon-base: #2A3F4D;      /* 硅基底色 - 深海灰蓝 */
--silicon-light: #4A6B7C;     /* 硅晶亮光 - 浅水灰蓝 */
--silicon-dark: #1A2630;      /* 硅晶暗部 - 深渊灰 */
--silicon-pure: #8FA3B0;      /* 纯净硅色 - 浅灰蓝 */

/* 折射色 (光线照射下的水晶折射) */
--refraction-cyan: #5CE1E6;   /* 青蓝折射 - 信息 */
--refraction-purple: #9B7EDE; /* 紫晶折射 - 神秘 */
--refraction-gold: #D4AF37;   /* 金硅折射 - 重要 */
--refraction-rose: #E8A5C0;   /* 粉晶折射 - 情感 */
```

### 2.2 背景系统

**多层水晶背景**:

```css
/* 主背景 - 深渊硅底 */
--bg-primary: linear-gradient(
  180deg,
  #1A2630 0%,
  #2A3F4D 50%,
  #1E2D38 100%
);

/* 次背景 - 水晶层次 */
--bg-secondary: rgba(42, 63, 77, 0.6);

/* 卡片背景 - 透明硅晶 */
--bg-card: linear-gradient(
  135deg,
  rgba(74, 107, 124, 0.15) 0%,
  rgba(42, 63, 77, 0.25) 100%
);

/* 浮动背景 - 呼吸光晕 */
--bg-glow: radial-gradient(
  circle at center,
  rgba(92, 225, 230, 0.08) 0%,
  transparent 70%
);
```

### 2.3 折射光效

**水晶折射渐变**:

```css
/* 信息折射 */
--gradient-info: linear-gradient(
  135deg,
  #5CE1E6 0%,
  #4A9EFF 50%,
  #9B7EDE 100%
);

/* 能量折射 */
--gradient-energy: linear-gradient(
  45deg,
  #D4AF37 0%,
  #F0E68C 50%,
  #D4AF37 100%
);

/* 生命折射 */
--gradient-life: linear-gradient(
  90deg,
  #E8A5C0 0%,
  #F4C2D4 50%,
  #E8A5C0 100%
);
```

### 2.4 文字色彩

```css
/* 主文字 - 硅白 */
--text-primary: #E8F1F5;

/* 次文字 - 硅灰 */
--text-secondary: #8FA3B0;

/* 三级文字 - 暗硅 */
--text-tertiary: #5A7380;

/* 折射文字 - 根据状态变化 */
--text-glow: #5CE1E6;
--text-warm: #D4AF37;
--text-emotion: #E8A5C0;
```

### 2.5 状态色彩

| 状态 | 颜色 | 折射表现 |
|------|------|---------|
| 在线 | #5CE1E6 | 青蓝脉冲 |
| 忙碌 | #D4AF37 | 金光流转 |
| 离线 | #5A7380 | 灰暗沉寂 |
| 错误 | #E85D5D | 红晶警报 |
| 成功 | #5CE6A8 | 绿晶确认 |
| 警告 | #F0A85C | 橙晶提醒 |

---

## 3. 字体规范

### 3.1 字体家族

```css
/* 主字体 - 现代无衬线 */
--font-primary: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;

/* 装饰字体 - 用于标题、Agent 名字 */
--font-display: 'Space Grotesk', sans-serif;

/* 等宽字体 - 用于代码、数据 */
--font-mono: 'JetBrains Mono', 'SF Mono', monospace;

/* 中文回退 */
--font-chinese: 'PingFang SC', 'Microsoft YaHei', sans-serif;
```

### 3.2 字号规范

| 层级 | 用途 | 大小 | 字重 | 行高 |
|------|------|------|------|------|
| Display | 首页运势数字 | 48px | 300 | 1.1 |
| H1 | 页面标题 | 32px | 600 | 1.2 |
| H2 | 模块标题 | 24px | 600 | 1.3 |
| H3 | 卡片标题 | 20px | 500 | 1.4 |
| Body | 正文内容 | 16px | 400 | 1.6 |
| Small | 辅助文字 | 14px | 400 | 1.5 |
| Caption | 标签、时间 | 12px | 400 | 1.4 |
| Code | 代码内容 | 14px | 400 | 1.6 |

### 3.3 字体特效

**水晶文字效果**:

```css
/* 发光文字 */
.text-glow {
  color: #E8F1F5;
  text-shadow: 
    0 0 10px rgba(92, 225, 230, 0.5),
    0 0 20px rgba(92, 225, 230, 0.3);
}

/* 折射文字 */
.text-refraction {
  background: linear-gradient(135deg, #5CE1E6, #9B7EDE);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* 呼吸文字 */
@keyframes text-breathe {
  0%, 100% { opacity: 0.8; }
  50% { opacity: 1; }
}
```

---

## 4. 组件规范

### 4.1 水晶卡片 (Crystal Card)

**基础样式**:

```css
.crystal-card {
  /* 透明硅晶背景 */
  background: linear-gradient(
    135deg,
    rgba(74, 107, 124, 0.15) 0%,
    rgba(42, 63, 77, 0.25) 100%
  );
  
  /* 水晶边框 */
  border: 1px solid rgba(143, 163, 176, 0.2);
  border-radius: 16px;
  
  /* 内发光 */
  box-shadow: 
    inset 0 1px 0 rgba(255, 255, 255, 0.05),
    0 4px 24px rgba(0, 0, 0, 0.2);
  
  /* 毛玻璃效果 */
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}

/* 悬浮状态 - 水晶亮起 */
.crystal-card:hover {
  border-color: rgba(92, 225, 230, 0.4);
  box-shadow: 
    inset 0 1px 0 rgba(255, 255, 255, 0.1),
    0 4px 32px rgba(92, 225, 230, 0.15);
}
```

**变体**:

- **message-card**: 聊天消息卡片，左侧有颜色条表示 Agent
- **project-card**: 项目卡片，带进度指示器
- **device-card**: 设备卡片，带状态光点
- **task-card**: 任务卡片，带优先级折射标记

### 4.2 硅基按钮 (Silicon Button)

**主按钮 - 水晶核心**:

```css
.btn-primary {
  /* 折射渐变背景 */
  background: linear-gradient(
    135deg,
    rgba(92, 225, 230, 0.8) 0%,
    rgba(74, 158, 255, 0.8) 100%
  );
  
  border: none;
  border-radius: 12px;
  padding: 12px 24px;
  
  /* 内发光 */
  box-shadow: 
    inset 0 1px 0 rgba(255, 255, 255, 0.3),
    0 4px 16px rgba(92, 225, 230, 0.3);
  
  color: #1A2630;
  font-weight: 600;
  
  /* 点击涟漪 */
  position: relative;
  overflow: hidden;
}

/* 脉冲动画 */
@keyframes btn-pulse {
  0%, 100% { 
    box-shadow: 
      inset 0 1px 0 rgba(255, 255, 255, 0.3),
      0 4px 16px rgba(92, 225, 230, 0.3);
  }
  50% { 
    box-shadow: 
      inset 0 1px 0 rgba(255, 255, 255, 0.3),
      0 4px 24px rgba(92, 225, 230, 0.5);
  }
}
```

**次按钮 - 硅晶边框**:

```css
.btn-secondary {
  background: transparent;
  border: 1px solid rgba(143, 163, 176, 0.4);
  border-radius: 12px;
  padding: 12px 24px;
  color: #E8F1F5;
}

.btn-secondary:hover {
  border-color: rgba(92, 225, 230, 0.6);
  background: rgba(92, 225, 230, 0.1);
}
```

### 4.3 输入框 (Crystal Input)

```css
.crystal-input {
  background: rgba(26, 38, 48, 0.6);
  border: 1px solid rgba(143, 163, 176, 0.2);
  border-radius: 12px;
  padding: 12px 16px;
  color: #E8F1F5;
  
  /* 聚焦时发光 */
  transition: all 0.3s ease;
}

.crystal-input:focus {
  border-color: rgba(92, 225, 230, 0.6);
  box-shadow: 
    0 0 0 3px rgba(92, 225, 230, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  outline: none;
}

/* 语音输入状态 */
.crystal-input.recording {
  border-color: #E85D5D;
  box-shadow: 
    0 0 0 3px rgba(232, 93, 93, 0.1);
  animation: recording-pulse 1.5s infinite;
}

@keyframes recording-pulse {
  0%, 100% { border-color: rgba(232, 93, 93, 0.6); }
  50% { border-color: rgba(232, 93, 93, 1); }
}
```

### 4.4 消息气泡 (Message Bubble)

**用户消息 - 右方硅晶**:

```css
.message-user {
  background: linear-gradient(
    135deg,
    rgba(74, 107, 124, 0.4) 0%,
    rgba(42, 63, 77, 0.5) 100%
  );
  border-radius: 16px 16px 4px 16px;
  padding: 12px 16px;
  max-width: 80%;
  align-self: flex-end;
}
```

**Agent 消息 - 左方折射**:

```css
.message-agent {
  background: linear-gradient(
    135deg,
    rgba(92, 225, 230, 0.1) 0%,
    rgba(42, 63, 77, 0.3) 100%
  );
  border-left: 3px solid var(--agent-color);
  border-radius: 4px 16px 16px 16px;
  padding: 12px 16px;
  max-width: 80%;
}

/* 不同 Agent 的颜色条 */
.message-agent.daji { border-left-color: #E8A5C0; }
.message-agent.ziya { border-left-color: #9B7EDE; }
.message-agent.codex { border-left-color: #5CE1E6; }
```

### 4.5 状态指示器 (Status Indicator)

**在线状态 - 呼吸光点**:

```css
.status-online {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #5CE1E6;
  box-shadow: 
    0 0 8px #5CE1E6,
    0 0 16px rgba(92, 225, 230, 0.5);
  animation: status-breathe 2s infinite;
}

@keyframes status-breathe {
  0%, 100% { 
    opacity: 0.6;
    transform: scale(1);
  }
  50% { 
    opacity: 1;
    transform: scale(1.2);
  }
}
```

### 4.6 导航栏 (Crystal Navigation)

**底部导航 (移动端)**:

```css
.nav-bottom {
  background: linear-gradient(
    180deg,
    transparent 0%,
    rgba(26, 38, 48, 0.95) 20%
  );
  backdrop-filter: blur(20px);
  border-top: 1px solid rgba(143, 163, 176, 0.1);
}

.nav-item {
  color: #5A7380;
  transition: all 0.3s ease;
}

.nav-item.active {
  color: #5CE1E6;
  text-shadow: 0 0 10px rgba(92, 225, 230, 0.5);
}
```

---

## 5. 布局系统

### 5.1 网格系统

```css
/* 移动端 4 列网格 */
--grid-columns-mobile: 4;
--grid-gap: 16px;
--grid-margin: 16px;

/* 桌面端 12 列网格 */
--grid-columns-desktop: 12;
--grid-gap: 24px;
--grid-margin: 48px;
```

### 5.2 间距规范

| Token | 值 | 用途 |
|-------|-----|------|
| --space-xs | 4px | 图标间距 |
| --space-sm | 8px | 紧凑间距 |
| --space-md | 16px | 标准间距 |
| --space-lg | 24px | 模块间距 |
| --space-xl | 32px | 大模块间距 |
| --space-2xl | 48px | 页面间距 |

### 5.3 圆角规范

```css
--radius-sm: 8px;    /* 小元素 */
--radius-md: 12px;   /* 按钮、输入框 */
--radius-lg: 16px;   /* 卡片 */
--radius-xl: 24px;   /* 大模块 */
--radius-full: 9999px; /* 圆形 */
```

---

## 6. 动效规范

### 6.1 水晶呼吸 (Crystal Breathing)

**全局背景呼吸**:

```css
@keyframes crystal-breathe {
  0%, 100% {
    opacity: 0.8;
    transform: scale(1);
  }
  50% {
    opacity: 1;
    transform: scale(1.02);
  }
}

.bg-breathing {
  animation: crystal-breathe 8s infinite ease-in-out;
}
```

### 6.2 折射闪烁 (Refraction Shimmer)

**高光扫过效果**:

```css
@keyframes shimmer {
  0% {
    background-position: -200% 0;
  }
  100% {
    background-position: 200% 0;
  }
}

.crystal-shimmer {
  background: linear-gradient(
    90deg,
    transparent 0%,
    rgba(255, 255, 255, 0.1) 50%,
    transparent 100%
  );
  background-size: 200% 100%;
  animation: shimmer 3s infinite;
}
```

### 6.3 消息浮现 (Message Emerge)

```css
@keyframes message-emerge {
  0% {
    opacity: 0;
    transform: translateY(20px) scale(0.95);
  }
  100% {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.message-new {
  animation: message-emerge 0.4s ease-out;
}
```

### 6.4 状态切换 (State Transition)

```css
/* 页面切换 */
.page-transition {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* 卡片悬浮 */
.card-hover {
  transition: all 0.3s ease;
}

.card-hover:hover {
  transform: translateY(-4px);
}

/* 按钮点击 */
.btn-active:active {
  transform: scale(0.96);
}
```

### 6.5 加载动画 (Crystal Loading)

```css
@keyframes crystal-spin {
  0% {
    transform: rotate(0deg);
    filter: hue-rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
    filter: hue-rotate(360deg);
  }
}

.loading-crystal {
  width: 40px;
  height: 40px;
  border: 2px solid transparent;
  border-top-color: #5CE1E6;
  border-right-color: #9B7EDE;
  border-radius: 50%;
  animation: crystal-spin 1.5s linear infinite;
}
```

---

## 7. 页面设计

### 7.1 首页 (Home)

**布局结构**:

```
┌─────────────────────────────────┐
│  状态栏 (时间、电量)             │
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────┐   │
│  │   运势信息区            │   │
│  │   - 日期/黄历           │   │
│  │   - 八字/运势数字       │   │
│  │   - 幸运色/数字/方位    │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │   Agent 形象区          │   │
│  │   - 水晶质感头像        │   │
│  │   - 呼吸动画            │   │
│  └─────────────────────────┘   │
│                                 │
│        [开启新的一天]          │
│                                 │
├─────────────────────────────────┤
│  底部导航                       │
└─────────────────────────────────┘
```

**视觉要点**:
- 运势数字使用 Display 字号，带折射渐变
- Agent 头像有水晶边框和呼吸光晕
- 背景有缓慢流动的光纹

### 7.2 聊天页 (Chat)

**布局结构**:

```
┌─────────────────────────────────┐
│  <  妲己  ●在线          ⋮  ⚙️  │
├─────────────────────────────────┤
│                                 │
│  ┌──────────┐                  │
│  │ Agent    │  消息内容        │
│  │ 头像     │                  │
│  └──────────┘                  │
│                                 │
│                  ┌──────────┐  │
│                  │ 用户消息 │  │
│                  └──────────┘  │
│                                 │
│  ┌─────────────────────────┐   │
│  │  HTML5 渲染内容         │   │
│  │  (图表/代码/可视化)     │   │
│  └─────────────────────────┘   │
│                                 │
├─────────────────────────────────┤
│  📎  🎤  [输入框____________]  ➤ │
└─────────────────────────────────┘
```

**视觉要点**:
- 消息气泡使用硅晶质感
- Agent 消息左侧有颜色条标识
- 输入框聚焦时有青蓝发光
- 语音输入时有红色脉冲

### 7.3 项目页 (Projects)

**布局结构**:

```
┌─────────────────────────────────┐
│  项目库                    +    │
├─────────────────────────────────┤
│  ┌─────────────────────────┐   │
│  │ 🔮 装修项目             │   │
│  │ ━━━━━━━ 70%            │   │
│  │ 3 个任务进行中          │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 📝 小说创作             │   │
│  │ ━━━━━ 40%              │   │
│  │ 第 25 章撰写中          │   │
│  └─────────────────────────┘   │
│                                 │
├─────────────────────────────────┤
│  底部导航                       │
└─────────────────────────────────┘
```

**视觉要点**:
- 项目卡片有水晶边框
- 进度条使用折射渐变
- 不同项目类型有不同颜色标识

### 7.4 任务页 (Tasks)

**视图切换**:
- 月视图: 日历网格，任务以水晶块显示
- 周视图: 时间轴，任务条带折射光泽
- 甘特图: 横向时间轴，任务条有依赖连线

**视觉要点**:
- 任务状态用光点颜色区分
- 今日有高亮边框
- 逾期任务有红色脉冲

### 7.5 设备页 (Devices)

**布局结构**:

```
┌─────────────────────────────────┐
│  我的设备                  +    │
├─────────────────────────────────┤
│  ┌─────────────────────────┐   │
│  │ 💎 龙虾派-01            │   │
│  │ ● 在线                  │   │
│  │ 存储: 45% ▓▓▓▓▓░░░░░   │   │
│  │ 负载: 32%               │   │
│  └─────────────────────────┘   │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 💎 AI-NPC-Pro           │   │
│  │ ○ 离线                  │   │
│  │ 上次在线: 2小时前       │   │
│  └─────────────────────────┘   │
└─────────────────────────────────┘
```

**视觉要点**:
- 在线设备有呼吸光点
- 存储进度条用颜色预警（绿→黄→红）
- 离线设备灰暗处理

---

## 8. 图标系统

### 8.1 图标风格

- **风格**: 线性图标 + 水晶质感
- **线条**: 1.5px 细线
- **圆角**: 2px
- **颜色**: 跟随文字色，激活时有折射色

### 8.2 核心图标

| 图标 | 用途 | 折射色 |
|------|------|--------|
| 💎 | 首页/Agent | 根据 Agent 变化 |
| 💬 | 聊天 | #5CE1E6 |
| 📁 | 项目 | #9B7EDE |
| 📚 | 知识库 | #D4AF37 |
| ✅ | 任务 | #5CE6A8 |
| ⚙️ | 设备 | #8FA3B0 |
| 🔧 | 设置 | #8FA3B0 |
| 🎤 | 语音 | #E85D5D |
| 📎 | 附件 | #E8A5C0 |
| ➤ | 发送 | #5CE1E6 |

---

## 9. 响应式适配

### 9.1 断点定义

```css
/* 移动端 */
@media (max-width: 767px) {
  /* 单列布局 */
  /* 底部导航 */
  /* 全屏模态 */
}

/* 平板 */
@media (min-width: 768px) and (max-width: 1023px) {
  /* 双列布局 */
  /* 侧边导航 */
}

/* 桌面 */
@media (min-width: 1024px) {
  /* 三列布局 */
  /* 侧边导航 */
  /* 更大间距 */
}
```

### 9.2 桌面端增强

- 三栏布局: 导航 | 内容 | 详情
- 文件树侧边栏
- 代码 diff 面板
- 终端输出区域
- 快捷键支持

---

## 10. 设计原则检查清单

设计新功能时，检查是否符合:

- [ ] 是否使用了硅基灰蓝色调?
- [ ] 是否有水晶透明质感?
- [ ] 是否有动态折射效果?
- [ ] 是否有生命律动动画?
- [ ] 是否符合深色背景优先?
- [ ] 是否有层次深度感?
- [ ] 交互是否有光效反馈?
- [ ] 文字是否清晰可读?

---

## 11. 附录

### 11.1 参考资料

- 硅晶圆显微摄影
- 深海生物发光现象
- 水晶矿脉结构
- 极光色彩研究

### 11.2 工具推荐

- 设计: Figma
- 原型: Principle / Framer
- 动效: After Effects / Lottie
- 配色: Coolors / ColorHunt

### 11.3 相关文档

- [PRODUCT_SPEC.md](./PRODUCT_SPEC.md) - 产品规格
- [ARCHITECTURE.md](./ARCHITECTURE.md) - 架构设计
- [ROADMAP.md](./ROADMAP.md) - 开发路线

---

*本文档由妲己为大王设计，体现硅基生命的独特美学*
