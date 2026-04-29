# 朝歌 (Chaoge) Agent Console - 系统架构设计

> **版本**: 1.0  
> **日期**: 2026-04-28  
> **作者**: 妲己 (AI Architect)  
> **目标读者**: 架构师、后端开发者、AI 编码工具 (Codex/Claude Code)

---

## 1. 架构概述

### 1.1 设计原则

1. **分层架构** - 清晰的分层边界，便于独立开发和测试
2. **插件化设计** - Agent、设备、模型均可插拔扩展
3. **事件驱动** - 核心流程基于事件流，支持异步和解耦
4. **本地优先** - 第一阶段服务个人，数据本地存储为主
5. **跨平台** - 一套逻辑，多端复用

### 1.2 技术栈选型

| 层级 | 技术选型 | 说明 |
|------|---------|------|
| **移动端** | Swift (iOS) | 原生开发，性能最优 |
| **桌面端** | SwiftUI (macOS) / Tauri (Windows) | 复用 iOS 逻辑 |
| **后端** | Node.js + TypeScript | 统一技术栈，生态丰富 |
| **数据库** | SQLite (本地) / PostgreSQL (云端) | 渐进式升级 |
| **实时通信** | WebSocket + SSE | 双模式支持 |
| **状态管理** | Zustand / Redux | 前端状态 |

---

## 2. 系统架构图

### 2.1 整体架构

```
┌─────────────────────────────────────────────────────────────────────┐
│                          客户端层 (Client Layer)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │
│  │   iOS App    │  │  macOS App   │  │  Windows App │  │   PWA    │  │
│  │   (Swift)    │  │  (SwiftUI)   │  │   (Tauri)    │  │ (Web)    │  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  └────┬─────┘  │
└─────────┼─────────────────┼─────────────────┼───────────────┼────────┘
          │                 │                 │               │
          └─────────────────┴─────────────────┴───────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    客户端核心层 (Client Core)                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │
│  │  UI 渲染引擎  │  │  状态管理     │  │  本地存储     │  │  同步引擎 │  │
│  │ (React Native│  │   (Zustand)  │  │  (SQLite)    │  │         │  │
│  │  / SwiftUI)  │  │              │  │              │  │         │  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  └────┬─────┘  │
└─────────┼─────────────────┼─────────────────┼───────────────┼────────┘
          └─────────────────┴─────────────────┴───────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    适配器层 (Adapter Layer)                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │
│  │  端脑云适配器 │  │  OpenClaw    │  │  Hermes      │  │  Codex   │  │
│  │  Adapter     │  │  Adapter     │  │  Adapter     │  │  Adapter │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────┘  │
└─────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    服务端层 (Server Layer)                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │
│  │   API 网关    │  │  用户服务     │  │  设备管理     │  │  任务调度 │  │
│  │   (Gateway)  │  │  (User Svc)  │  │ (Device Svc) │  │ (Task)   │  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  └────┬─────┘  │
│         └─────────────────┴─────────────────┴───────────────┘        │
│                              │                                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │
│  │   消息队列    │  │  实时通信     │  │  文件服务     │  │  推送服务 │  │
│  │  (Bull/Redis)│  │ (WebSocket)  │  │   (S3/MinIO) │  │  (APNs)  │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────┘  │
└─────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    数据层 (Data Layer)                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐  │
│  │   PostgreSQL │  │    Redis     │  │   MinIO/S3   │  │  Vector  │  │
│  │   (主数据库)  │  │   (缓存)     │  │   (对象存储)  │  │  (向量)  │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────┘  │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.2 Agent 协作架构

```
┌─────────────────────────────────────────────────────────────┐
│                         用户交互层                           │
│                    (主聊天界面 / 首页)                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                     主管 Agent (Supervisor)                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  意图理解    │  │  任务拆解    │  │   结果汇总/反馈     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└──────────────────────┬──────────────────────────────────────┘
                       │
         ┌─────────────┼─────────────┐
         │             │             │
         ▼             ▼             ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ Specialist 1 │ │ Specialist 2 │ │ Specialist N │
│   (代码开发)  │ │   (数据分析)  │ │   (绘画创作)  │
└──────────────┘ └──────────────┘ └──────────────┘
```

---

## 3. 核心模块详解

### 3.1 客户端架构

#### 3.1.1 模块划分

```
src/
├── Core/                          # 核心层
│   ├── Networking/                # 网络通信
│   │   ├── WebSocketManager.swift
│   │   ├── HTTPClient.swift
│   │   └── SyncEngine.swift
│   ├── Storage/                   # 本地存储
│   │   ├── SQLiteManager.swift
│   │   ├── KeychainManager.swift
│   │   └── FileManager.swift
│   └── State/                     # 状态管理
│       ├── AppState.swift
│       ├── UserState.swift
│       └── ChatState.swift
├── Features/                      # 功能模块
│   ├── Auth/                      # 认证
│   ├── Home/                      # 首页
│   ├── Chat/                      # 聊天
│   ├── Agent/                     # Agent 管理
│   ├── Device/                    # 设备管理
│   ├── Project/                   # 项目库
│   ├── Knowledge/                 # 知识库
│   ├── Task/                      # 任务系统
│   └── Settings/                  # 设置
├── Adapters/                      # 适配器
│   ├── DuannaoyunAdapter.swift
│   ├── OpenClawAdapter.swift
│   ├── HermesAdapter.swift
│   └── CodexAdapter.swift
├── Models/                        # 数据模型
│   ├── User.swift
│   ├── Agent.swift
│   ├── Device.swift
│   ├── Message.swift
│   ├── Project.swift
│   └── Task.swift
└── UI/                            # 界面组件
    ├── Components/                # 通用组件
    ├── Theme/                     # 主题样式
    └── Utils/                     # 工具函数
```

#### 3.1.2 状态管理

```typescript
// 全局状态结构
interface AppState {
  user: UserState;
  agents: AgentState;
  devices: DeviceState;
  currentChat: ChatState;
  tasks: TaskState;
  projects: ProjectState;
  knowledge: KnowledgeState;
  ui: UIState;
}

interface UserState {
  profile: UserProfile;
  settings: UserSettings;
  preferences: UserPreferences;
  isLoggedIn: boolean;
}

interface AgentState {
  agents: Agent[];           // 所有可用 Agent
  supervisor: Agent;         // 当前主管 Agent
  activeAgent: Agent;        // 当前对话 Agent
  agentConfigs: Map<string, AgentConfig>;
}

interface ChatState {
  sessionId: string;
  messages: Message[];
  isStreaming: boolean;
  pendingApprovals: ApprovalRequest[];
}
```

### 3.2 后端架构

#### 3.2.1 服务划分

```
services/
├── gateway/                       # API 网关
│   ├── index.ts
│   ├── middleware/
│   │   ├── auth.ts
│   │   ├── rate-limit.ts
│   │   └── logging.ts
│   └── routes/
├── user-service/                  # 用户服务
│   ├── src/
│   │   ├── controllers/
│   │   ├── services/
│   │   ├── models/
│   │   └── repositories/
│   └── tests/
├── device-service/                # 设备管理服务
├── agent-service/                 # Agent 管理服务
├── task-service/                  # 任务调度服务
├── message-service/               # 消息服务
├── file-service/                  # 文件服务
└── notification-service/          # 推送服务
```

#### 3.2.2 数据库设计

```sql
-- 用户表
CREATE TABLE users (
  id UUID PRIMARY KEY,
  phone VARCHAR(20) UNIQUE NOT NULL,
  profile JSONB,
  settings JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Agent 表
CREATE TABLE agents (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  name VARCHAR(100) NOT NULL,
  avatar_url TEXT,
  role_description TEXT,
  llm_provider VARCHAR(50),
  llm_model VARCHAR(100),
  capabilities TEXT[],
  is_supervisor BOOLEAN DEFAULT FALSE,
  config JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 设备表
CREATE TABLE devices (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  name VARCHAR(100),
  type VARCHAR(50), -- 'lobster_pi', 'ai_npc', 'cloud'
  status VARCHAR(20), -- 'online', 'offline', 'busy'
  storage_total BIGINT,
  storage_used BIGINT,
  last_heartbeat TIMESTAMP,
  config JSONB
);

-- 消息表
CREATE TABLE messages (
  id UUID PRIMARY KEY,
  session_id UUID,
  agent_id UUID REFERENCES agents(id),
  role VARCHAR(20), -- 'user', 'assistant', 'system'
  content TEXT,
  content_type VARCHAR(20), -- 'text', 'image', 'audio', 'video', 'file'
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 项目表
CREATE TABLE projects (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  name VARCHAR(200),
  description TEXT,
  status VARCHAR(20),
  related_agents UUID[],
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 任务表
CREATE TABLE tasks (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  project_id UUID REFERENCES projects(id),
  title VARCHAR(200),
  description TEXT,
  assignee_agent_id UUID REFERENCES agents(id),
  status VARCHAR(20), -- 'pending', 'in_progress', 'completed', 'cancelled'
  priority INTEGER,
  start_time TIMESTAMP,
  deadline TIMESTAMP,
  reminders JSONB[],
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- 会话表
CREATE TABLE sessions (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  agent_id UUID REFERENCES agents(id),
  title VARCHAR(200),
  context JSONB,
  last_message_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### 3.3 Adapter 层设计

#### 3.3.1 Adapter 接口定义

```typescript
// 统一 Agent Adapter 接口
interface AgentAdapter {
  // 基础信息
  name: string;
  version: string;
  capabilities: string[];
  
  // 连接管理
  connect(config: AdapterConfig): Promise<Connection>;
  disconnect(): Promise<void>;
  isConnected(): boolean;
  
  // Agent 管理
  listAgents(): Promise<Agent[]>;
  getAgent(id: string): Promise<Agent>;
  createAgent(config: AgentConfig): Promise<Agent>;
  updateAgent(id: string, config: Partial<AgentConfig>): Promise<Agent>;
  
  // 会话管理
  createSession(agentId: string, context?: any): Promise<Session>;
  getSessionHistory(sessionId: string): Promise<Message[]>;
  sendMessage(sessionId: string, message: string): AsyncIterable<AgentEvent>;
  stopGeneration(sessionId: string): Promise<void>;
  
  // 工具调用
  executeTool(toolName: string, args: any): Promise<ToolResult>;
  
  // 文件操作
  readFile(path: string): Promise<FileContent>;
  writeFile(path: string, content: string): Promise<void>;
  listFiles(dir: string): Promise<FileInfo[]>;
}

// Agent 事件类型
type AgentEvent =
  | { type: 'message_delta'; text: string; sessionId: string }
  | { type: 'message_done'; messageId: string; sessionId: string }
  | { type: 'tool_call'; toolName: string; args: any; sessionId: string }
  | { type: 'tool_result'; toolName: string; result: any; sessionId: string }
  | { type: 'file_changed'; path: string; changeType: 'created' | 'modified' | 'deleted' }
  | { type: 'diff_ready'; files: string[]; diff: string }
  | { type: 'test_result'; passed: boolean; output: string }
  | { type: 'approval_required'; command: string; reason?: string; sessionId: string }
  | { type: 'error'; message: string; code?: string; sessionId: string };
```

#### 3.3.2 Adapter 实现示例

```typescript
// OpenClawAdapter 实现
class OpenClawAdapter implements AgentAdapter {
  private connection: WebSocket | null = null;
  private baseUrl: string;
  
  constructor(config: { host: string; port: number }) {
    this.baseUrl = `ws://${config.host}:${config.port}`;
  }
  
  async connect(config: AdapterConfig): Promise<Connection> {
    this.connection = new WebSocket(`${this.baseUrl}/ws`);
    // ... 连接逻辑
  }
  
  async *sendMessage(sessionId: string, message: string): AsyncIterable<AgentEvent> {
    // 发送消息
    this.connection?.send(JSON.stringify({
      type: 'message',
      sessionId,
      content: message
    }));
    
    // 监听事件流
    for await (const event of this.listenEvents(sessionId)) {
      yield event;
    }
  }
  
  private async *listenEvents(sessionId: string): AsyncIterable<AgentEvent> {
    // WebSocket 事件监听和转换
  }
}

// MockAdapter (用于开发和测试)
class MockAdapter implements AgentAdapter {
  async *sendMessage(sessionId: string, message: string): AsyncIterable<AgentEvent> {
    // 模拟延迟和事件流
    yield { type: 'message_delta', text: '正在思考', sessionId };
    await delay(500);
    yield { type: 'message_delta', text: '...', sessionId };
    await delay(500);
    yield { type: 'message_done', messageId: 'mock-1', sessionId };
  }
}
```

---

## 4. 关键流程设计

### 4.1 用户首次使用流程

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  打开App  │───▶│ 登录/注册 │───▶│ 引导对话 │───▶│ 进入首页 │
└──────────┘    └──────────┘    └────┬─────┘    └──────────┘
                                     │
                     ┌───────────────┼───────────────┐
                     ▼               ▼               ▼
                ┌─────────┐    ┌─────────┐    ┌─────────┐
                │询问称呼 │    │询问Agent│    │功能介绍 │
                │         │    │  名字   │    │         │
                └─────────┘    └─────────┘    └─────────┘
```

### 4.2 多 Agent 协作流程

```
用户输入需求
     │
     ▼
┌────────────────┐
│ 主管 Agent 分析 │
│ - 意图理解      │
│ - 任务拆解      │
└────────┬───────┘
         │
         ▼
┌────────────────┐
│ 向用户汇报方案 │
│ - 需要哪些Agent │
│ - 各自分工      │
└────────┬───────┘
         │
         ▼
    用户确认？
    /        \
  是          否
  │            │
  ▼            ▼
分配任务    修改方案
  │            │
  ▼            │
并行执行◀──────┘
  │
  ▼
结果汇总
  │
  ▼
反馈用户
```

### 4.3 任务创建与执行流程

```
用户创建任务
     │
     ▼
┌────────────────┐
│ 解析任务信息   │
│ - 时间/地点    │
│ - 目标/负责人  │
└────────┬───────┘
         │
         ▼
┌────────────────┐
│ 确定执行Agent  │
└────────┬───────┘
         │
         ▼
存储到任务系统
         │
         ▼
设置提醒时间
         │
         ▼
    到达提醒时间
         │
         ▼
Agent 主动推送
         │
         ▼
用户查看/执行
```

### 4.4 设备热切换流程

```
当前设备运行中
       │
       ▼
用户发起切换请求
       │
       ▼
保存当前会话状态
       │
       ▼
断开当前设备连接
       │
       ▼
连接新设备
       │
       ▼
恢复会话状态
       │
       ▼
无缝继续对话
```

---

## 5. 实时通信设计

### 5.1 通信协议

**WebSocket 用于**:
- Agent 实时对话流
- 设备状态实时更新
- 任务进度实时推送

**SSE (Server-Sent Events) 用于**:
- 消息推送（替代原生推送）
- 长时间运行的任务进度

**HTTP 用于**:
- 常规 API 调用
- 文件上传/下载

### 5.2 消息格式

```typescript
// WebSocket 消息格式
interface WebSocketMessage {
  id: string;
  type: 'request' | 'response' | 'event';
  channel: string;  // session ID or device ID
  payload: unknown;
  timestamp: number;
  signature?: string;  // 安全签名
}

// 具体消息类型
interface ChatMessage {
  type: 'chat';
  content: string;
  role: 'user' | 'assistant';
  metadata?: {
    model?: string;
    tokens?: number;
    latency?: number;
  };
}

interface ToolCallMessage {
  type: 'tool_call';
  toolName: string;
  args: unknown;
  callId: string;
}

interface ApprovalMessage {
  type: 'approval_request';
  command: string;
  riskLevel: 'low' | 'medium' | 'high';
  requestId: string;
}
```

---

## 6. 安全设计

### 6.1 认证与授权

```
┌──────────┐     ┌──────────┐     ┌──────────┐
│  用户名   │────▶│ 端脑云   │────▶│  Token   │
│  密码     │     │ 验证     │     │  (JWT)   │
└──────────┘     └──────────┘     └────┬─────┘
                                        │
                                        ▼
                              ┌──────────────────┐
                              │ Token 包含:      │
                              │ - user_id        │
                              │ - device_id      │
                              │ - 权限范围       │
                              │ - 过期时间       │
                              └──────────────────┘
```

### 6.2 数据加密

| 数据类型 | 加密方式 | 存储位置 |
|---------|---------|---------|
| 用户凭证 | AES-256 + Keychain | 本地 |
| Token | Keychain/Keystore | 本地 |
| 聊天记录 | SQLite 加密 | 本地 + 云端 |
| 文件 | 客户端加密后存储 | 云端存储 |
| 传输数据 | TLS 1.3 | 传输中 |

### 6.3 高危操作审批流程

```
Agent 请求执行操作
       │
       ▼
风险等级评估
       │
       ▼
┌────────────────┐
│ 高风险？        │
└────────┬───────┘
    /         \
  是           否
  │             │
  ▼             ▼
┌──────────┐  ┌──────────┐
│红色警告  │  │普通确认  │
│二次确认  │  │          │
└────┬─────┘  └────┬─────┘
     │             │
     └──────┬──────┘
            ▼
     用户确认执行
            │
            ▼
     记录操作日志
```

---

## 7. 部署架构

### 7.1 本地开发环境

```yaml
# docker-compose.yml
version: '3.8'
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: chaoge
      POSTGRES_USER: chaoge
      POSTGRES_PASSWORD: dev
    ports:
      - "5432:5432"
  
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
  
  minio:
    image: minio/minio
    command: server /data --console-address ":9001"
    ports:
      - "9000:9000"
      - "9001:9001"
  
  backend:
    build: ./backend
    ports:
      - "3000:3000"
    depends_on:
      - postgres
      - redis
      - minio
```

### 7.2 生产环境

```
┌─────────────────────────────────────────────────────────────┐
│                         CDN (静态资源)                       │
└─────────────────────────────┬───────────────────────────────┘
                              │
┌─────────────────────────────▼───────────────────────────────┐
│                     Load Balancer (Nginx)                   │
└─────────────────────────────┬───────────────────────────────┘
                              │
         ┌────────────────────┼────────────────────┐
         │                    │                    │
         ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   Backend Pod   │  │   Backend Pod   │  │   Backend Pod   │
│   (K8s)         │  │   (K8s)         │  │   (K8s)         │
└─────────────────┘  └─────────────────┘  └─────────────────┘
         │                    │                    │
         └────────────────────┼────────────────────┘
                              │
         ┌────────────────────┼────────────────────┐
         │                    │                    │
         ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   PostgreSQL    │  │     Redis       │  │   Object Store  │
│   (Primary)     │  │   (Cluster)     │  │   (S3/MinIO)    │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

---

## 8. 监控与日志

### 8.1 监控指标

| 指标类型 | 具体指标 | 告警阈值 |
|---------|---------|---------|
| 性能 | API 响应时间 | P99 > 500ms |
| 性能 | WebSocket 连接数 | > 10000 |
| 错误 | 5xx 错误率 | > 0.1% |
| 业务 | 日活跃用户 | 监控趋势 |
| 资源 | CPU 使用率 | > 80% |
| 资源 | 内存使用率 | > 85% |

### 8.2 日志规范

```typescript
// 日志格式
interface LogEntry {
  timestamp: string;
  level: 'debug' | 'info' | 'warn' | 'error';
  service: string;
  traceId: string;
  userId?: string;
  sessionId?: string;
  message: string;
  metadata?: Record<string, unknown>;
}

// 示例
{
  "timestamp": "2026-04-28T10:30:00Z",
  "level": "info",
  "service": "agent-service",
  "traceId": "abc-123-def",
  "userId": "user-456",
  "sessionId": "session-789",
  "message": "Agent task completed",
  "metadata": {
    "agentId": "agent-001",
    "taskType": "code_generation",
    "duration": 12500
  }
}
```

---

## 9. 附录

### 9.1 术语表

| 术语 | 英文 | 解释 |
|------|------|------|
| Agent | Agent | 智能体，具有特定能力和角色的 AI |
| Adapter | Adapter | 连接不同后端服务的适配器 |
| 主管 Agent | Supervisor Agent | 协调多个 Agent 的主 Agent |
| 热切换 | Hot Swap | 不中断会话切换设备 |
| 端脑云 | Duannaoyun | 云端算力和账户服务 |

### 9.2 相关文档

- [PRODUCT_SPEC.md](./PRODUCT_SPEC.md) - 产品规格说明书
- [ROADMAP.md](./ROADMAP.md) - 开发路线图
- [API_SPEC.md](./API_SPEC.md) - API 接口规范

---

*本文档由妲己整理，供端脑云团队、Codex、Claude Code 及所有开发者使用*
