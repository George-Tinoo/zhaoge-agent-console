# 朝歌 (Chaoge) Agent Console - API 接口规范

> **版本**: 1.0  
> **日期**: 2026-04-28  
> **协议**: REST + WebSocket  
> **格式**: JSON  
> **目标读者**: 后端开发者、iOS/客户端开发者、AI 编码工具

---

## 1. 概述

### 1.1 接口分层

```
┌─────────────────────────────────────────────┐
│              朝歌 App (Client)               │
└─────────────────────┬───────────────────────┘
                      │ HTTPS / WSS
                      ▼
┌─────────────────────────────────────────────┐
│           朝歌 Gateway (API Gateway)         │
│     认证 / 限流 / 路由 / 负载均衡             │
└─────────────────────┬───────────────────────┘
                      │
         ┌────────────┼────────────┐
         │            │            │
         ▼            ▼            ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│  User Svc   │ │ Device Svc  │ │  Agent Svc  │
└─────────────┘ └─────────────┘ └─────────────┘
         │            │            │
         ▼            ▼            ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│  Chat Svc   │ │  Task Svc   │ │  File Svc   │
└─────────────┘ └─────────────┘ └─────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────┐
│         端脑云 / 外部服务 (External)          │
│    [由端脑云工程师对接，此处仅定义接口]       │
└─────────────────────────────────────────────┘
```

### 1.2 通用规范

**Base URL**:
```
开发环境: https://api-dev.chaoge.ai/v1
测试环境: https://api-test.chaoge.ai/v1
生产环境: https://api.chaoge.ai/v1
```

**认证方式**:
```
Header: Authorization: Bearer <JWT_TOKEN>
```

**通用响应格式**:
```json
{
  "code": 200,
  "message": "success",
  "data": { },
  "timestamp": 1714291200000,
  "requestId": "req_abc123"
}
```

**错误响应**:
```json
{
  "code": 40001,
  "message": "参数错误",
  "data": null,
  "error": {
    "field": "phone",
    "detail": "手机号格式不正确"
  }
}
```

**HTTP 状态码**:
- `200` - 成功
- `400` - 请求参数错误
- `401` - 未认证
- `403` - 无权限
- `404` - 资源不存在
- `429` - 请求过于频繁
- `500` - 服务器内部错误

---

## 2. 认证接口 (Auth)

### 2.1 发送验证码

```http
POST /auth/verification-code
```

**请求体**:
```json
{
  "phone": "+86-13800138000",
  "type": "login"  // login | register | reset
}
```

**响应**:
```json
{
  "code": 200,
  "message": "验证码已发送",
  "data": {
    "expirySeconds": 300,
    "retryAfter": 60
  }
}
```

### 2.2 手机号登录/注册

```http
POST /auth/login
```

**请求体**:
```json
{
  "phone": "+86-13800138000",
  "code": "123456",
  "deviceInfo": {
    "deviceId": "device_abc123",
    "platform": "ios",  // ios | android | macos | windows
    "appVersion": "1.0.0",
    "osVersion": "17.0"
  }
}
```

**响应**:
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "accessToken": "eyJhbGciOiJSUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJSUzI1NiIs...",
    "expiresIn": 86400,
    "user": {
      "id": "user_abc123",
      "phone": "+86-13800138000",
      "profile": {
        "nickname": "大王",
        "avatar": "https://..."
      },
      "isNewUser": true
    }
  }
}
```

### 2.3 Token 刷新

```http
POST /auth/refresh
```

**请求体**:
```json
{
  "refreshToken": "eyJhbGciOiJSUzI1NiIs..."
}
```

**响应**:
```json
{
  "code": 200,
  "message": "刷新成功",
  "data": {
    "accessToken": "eyJhbGciOiJSUzI1NiIs...",
    "expiresIn": 86400
  }
}
```

### 2.4 退出登录

```http
POST /auth/logout
```

**响应**:
```json
{
  "code": 200,
  "message": "退出成功"
}
```

---

## 3. 用户接口 (User)

### 3.1 获取用户信息

```http
GET /users/me
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "id": "user_abc123",
    "phone": "+86-13800138000",
    "profile": {
      "nickname": "大王",
      "avatar": "https://...",
      "birthDate": "1990-01-01",
      "gender": "male",
      "bio": "..."
    },
    "preferences": {
      "theme": "dark",
      "language": "zh-CN",
      "notifications": {
        "pushEnabled": true,
        "soundEnabled": true
      }
    },
    "fortuneProfile": {
      "birthDate": "1990-01-01",
      "birthTime": "12:00",
      "zodiac": "马",
      "constellation": "摩羯座"
    },
    "createdAt": "2026-01-01T00:00:00Z"
  }
}
```

### 3.2 更新用户信息

```http
PATCH /users/me
```

**请求体**:
```json
{
  "profile": {
    "nickname": "新昵称",
    "avatar": "https://...",
    "bio": "新简介"
  },
  "preferences": {
    "theme": "light"
  }
}
```

### 3.3 更新运势档案

```http
PUT /users/me/fortune-profile
```

**请求体**:
```json
{
  "birthDate": "1990-01-01",
  "birthTime": "12:00",
  "location": {
    "lat": 39.9042,
    "lng": 116.4074,
    "name": "北京"
  }
}
```

---

## 4. 设备接口 (Device)

### 4.1 获取设备列表

```http
GET /devices
```

**查询参数**:
- `status` - online | offline | all (默认 all)

**响应**:
```json
{
  "code": 200,
  "data": {
    "devices": [
      {
        "id": "device_001",
        "name": "龙虾派-客厅",
        "type": "lobster_pi",
        "status": "online",
        "isActive": true,
        "storage": {
          "total": 536870912000,
          "used": 241591910400,
          "warning": false
        },
        "resources": {
          "cpuUsage": 0.32,
          "memoryUsage": 0.45,
          "gpuUsage": 0.12
        },
        "capabilities": ["llm_local", "storage", "compute"],
        "lastHeartbeat": "2026-04-28T10:30:00Z",
        "connectedAt": "2026-04-28T08:00:00Z"
      }
    ]
  }
}
```

### 4.2 绑定设备 (扫码/局域网)

```http
POST /devices/bind
```

**请求体**:
```json
{
  "bindMethod": "qr_code",  // qr_code | bluetooth | lan
  "bindToken": "token_from_device",
  "deviceInfo": {
    "name": "我的龙虾派",
    "location": "书房"
  }
}
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "device": {
      "id": "device_002",
      "name": "我的龙虾派",
      "status": "online"
    },
    "message": "设备绑定成功"
  }
}
```

### 4.3 解绑设备

```http
DELETE /devices/{deviceId}
```

### 4.4 切换活跃设备

```http
POST /devices/{deviceId}/activate
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "previousDevice": "device_001",
    "currentDevice": "device_002",
    "sessionMigrated": true
  }
}
```

### 4.5 发现局域网设备

```http
GET /devices/discover
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "devices": [
      {
        "deviceId": "lobster_pi_abc",
        "name": "龙虾派-ABC",
        "type": "lobster_pi",
        "ip": "192.168.1.100",
        "port": 8080,
        "isBound": false
      }
    ]
  }
}
```

---

## 5. Agent 接口 (Agent)

### 5.1 获取 Agent 列表

```http
GET /agents
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "agents": [
      {
        "id": "agent_daji",
        "name": "妲己",
        "avatar": "https://...",
        "type": "supervisor",
        "role": {
          "description": "大王的贴身爱妃，主管 Agent",
          "personality": "妩媚、智慧、忠诚"
        },
        "llmConfig": {
          "provider": "openai",
          "model": "gpt-5.5",
          "temperature": 0.7
        },
        "capabilities": ["chat", "task_management", "agent_coordination"],
        "isSupervisor": true,
        "status": "online",
        "createdAt": "2026-01-01T00:00:00Z"
      }
    ],
    "supervisor": "agent_daji"
  }
}
```

### 5.2 创建 Agent

```http
POST /agents
```

**请求体**:
```json
{
  "name": "子牙",
  "avatar": "https://...",
  "role": {
    "description": "军师，负责复杂技术分析",
    "personality": "沉稳、睿智、严谨"
  },
  "llmConfig": {
    "provider": "openai",
    "model": "gpt-5.5",
    "temperature": 0.3
  },
  "capabilities": ["code", "architecture", "analysis"],
  "isSupervisor": false
}
```

### 5.3 更新 Agent 配置

```http
PATCH /agents/{agentId}
```

### 5.4 设置主管 Agent

```http
POST /agents/{agentId}/set-supervisor
```

### 5.5 删除 Agent

```http
DELETE /agents/{agentId}
```

---

## 6. 会话接口 (Session)

### 6.1 创建会话

```http
POST /sessions
```

**请求体**:
```json
{
  "agentId": "agent_daji",
  "title": "装修讨论",
  "projectId": "proj_001",
  "initialContext": {
    "topic": "客厅设计方案"
  }
}
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "session": {
      "id": "session_abc123",
      "agentId": "agent_daji",
      "title": "装修讨论",
      "status": "active",
      "createdAt": "2026-04-28T10:00:00Z",
      "lastMessageAt": "2026-04-28T10:00:00Z"
    }
  }
}
```

### 6.2 获取会话列表

```http
GET /sessions
```

**查询参数**:
- `agentId` - 按 Agent 筛选
- `status` - active | archived
- `limit` - 默认 20
- `cursor` - 分页游标

### 6.3 获取会话详情

```http
GET /sessions/{sessionId}
```

### 6.4 归档会话

```http
POST /sessions/{sessionId}/archive
```

### 6.5 删除会话

```http
DELETE /sessions/{sessionId}
```

---

## 7. 消息接口 (Message)

### 7.1 获取消息历史

```http
GET /sessions/{sessionId}/messages
```

**查询参数**:
- `limit` - 默认 50
- `before` - 获取此 ID 之前的消息（翻页）
- `after` - 获取此 ID 之后的消息（新消息）

**响应**:
```json
{
  "code": 200,
  "data": {
    "messages": [
      {
        "id": "msg_001",
        "sessionId": "session_abc123",
        "role": "user",
        "content": "帮我设计客厅",
        "contentType": "text",
        "timestamp": "2026-04-28T10:00:00Z"
      },
      {
        "id": "msg_002",
        "sessionId": "session_abc123",
        "role": "assistant",
        "agentId": "agent_daji",
        "content": "好的大王，让我为您规划...",
        "contentType": "text",
        "metadata": {
          "model": "gpt-5.5",
          "tokens": 150
        },
        "timestamp": "2026-04-28T10:00:05Z"
      }
    ],
    "hasMore": true,
    "nextCursor": "msg_000"
  }
}
```

### 7.2 发送消息 (WebSocket 推荐)

**HTTP 方式** (非流式):
```http
POST /sessions/{sessionId}/messages
```

**请求体**:
```json
{
  "content": "帮我设计客厅",
  "contentType": "text",
  "attachments": [
    {
      "type": "image",
      "fileId": "file_001"
    }
  ]
}
```

---

## 8. WebSocket 实时通信

### 8.1 连接地址

```
wss://ws.chaoge.ai/v1?token=<JWT_TOKEN>
```

### 8.2 消息格式

**客户端 → 服务器**:
```json
{
  "id": "req_001",
  "type": "message",
  "payload": {
    "sessionId": "session_abc123",
    "content": "帮我设计客厅",
    "contentType": "text"
  },
  "timestamp": 1714291200000
}
```

**服务器 → 客户端**:
```json
{
  "id": "evt_001",
  "type": "message_delta",
  "payload": {
    "sessionId": "session_abc123",
    "messageId": "msg_002",
    "delta": "好的大王",
    "isComplete": false
  },
  "timestamp": 1714291201000
}
```

### 8.3 事件类型

| 类型 | 方向 | 说明 |
|------|------|------|
| `message` | C→S | 用户发送消息 |
| `message_delta` | S→C | 消息流式返回 |
| `message_done` | S→C | 消息完成 |
| `tool_call` | S→C | 工具调用 |
| `tool_result` | S→C | 工具结果 |
| `file_changed` | S→C | 文件变更 |
| `approval_request` | S→C | 需要用户确认 |
| `approval_response` | C→S | 用户确认结果 |
| `typing` | S→C | Agent 正在输入 |
| `heartbeat` | 双向 | 心跳保活 |

### 8.4 心跳机制

```json
// 客户端发送
{
  "type": "heartbeat",
  "timestamp": 1714291200000
}

// 服务器响应
{
  "type": "heartbeat",
  "timestamp": 1714291200000,
  "latency": 45
}
```

---

## 9. 项目接口 (Project)

### 9.1 获取项目列表

```http
GET /projects
```

**查询参数**:
- `status` - active | completed | all
- `search` - 搜索关键词

### 9.2 创建项目

```http
POST /projects
```

**请求体**:
```json
{
  "name": "客厅装修",
  "description": "新房客厅设计方案",
  "relatedAgents": ["agent_daji"],
  "metadata": {
    "budget": 50000,
    "deadline": "2026-06-01"
  }
}
```

### 9.3 更新项目

```http
PATCH /projects/{projectId}
```

### 9.4 删除项目

```http
DELETE /projects/{projectId}
```

### 9.5 关联会话到项目

```http
POST /projects/{projectId}/sessions
```

**请求体**:
```json
{
  "sessionId": "session_abc123"
}
```

---

## 10. 知识库接口 (Knowledge)

### 10.1 获取知识分类

```http
GET /knowledge/categories
```

### 10.2 创建知识条目

```http
POST /knowledge
```

**请求体**:
```json
{
  "category": "AI技术",
  "title": "Agent架构设计",
  "content": "...",
  "sourceSessionId": "session_abc123",
  "tags": ["架构", "AI"]
}
```

### 10.3 搜索知识

```http
GET /knowledge/search?q=关键词
```

---

## 11. 任务接口 (Task)

### 11.1 获取任务列表

```http
GET /tasks
```

**查询参数**:
- `status` - pending | in_progress | completed
- `assignee` - agent_id
- `projectId` - 项目筛选
- `from` / `to` - 时间范围

### 11.2 创建任务

```http
POST /tasks
```

**请求体**:
```json
{
  "title": "完成客厅设计图",
  "description": "需要出3D效果图",
  "projectId": "proj_001",
  "assigneeAgentId": "agent_daji",
  "deadline": "2026-05-01T18:00:00Z",
  "reminders": [
    {
      "time": "2026-04-30T09:00:00Z",
      "type": "notification"
    }
  ]
}
```

### 11.3 更新任务状态

```http
PATCH /tasks/{taskId}
```

### 11.4 删除任务

```http
DELETE /tasks/{taskId}
```

### 11.5 获取任务统计

```http
GET /tasks/stats
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "total": 15,
    "completed": 8,
    "inProgress": 4,
    "pending": 3
  }
}
```

---

## 12. 文件接口 (File)

### 12.1 上传文件

```http
POST /files/upload
Content-Type: multipart/form-data
```

**表单字段**:
- `file` - 文件内容
- `type` - image | audio | video | document
- `source` - local | device

**响应**:
```json
{
  "code": 200,
  "data": {
    "fileId": "file_abc123",
    "url": "https://cdn.chaoge.ai/files/abc123.jpg",
    "thumbnail": "https://cdn.chaoge.ai/files/abc123_thumb.jpg",
    "size": 1024000,
    "mimeType": "image/jpeg"
  }
}
```

### 12.2 获取文件信息

```http
GET /files/{fileId}
```

### 12.3 删除文件

```http
DELETE /files/{fileId}
```

---

## 13. 通知接口 (Notification)

### 13.1 获取通知列表

```http
GET /notifications
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "notifications": [
      {
        "id": "notif_001",
        "type": "task_reminder",
        "title": "任务提醒",
        "content": "客厅设计任务即将截止",
        "data": {
          "taskId": "task_001"
        },
        "isRead": false,
        "createdAt": "2026-04-28T09:00:00Z"
      }
    ]
  }
}
```

### 13.2 标记已读

```http
POST /notifications/{notificationId}/read
```

### 13.3 注册推送令牌

```http
POST /notifications/push-token
```

**请求体**:
```json
{
  "token": "apns_token_here",
  "platform": "ios",
  "deviceId": "device_abc123"
}
```

---

## 14. 运势接口 (Fortune)

### 14.1 获取今日运势

```http
GET /fortune/today
```

**响应**:
```json
{
  "code": 200,
  "data": {
    "date": "2026-04-28",
    "lunarDate": "三月十二",
    "solarTerms": "谷雨",
    "ganzhi": {
      "year": "丙午",
      "month": "壬辰",
      "day": "己卯"
    },
    "fortune": {
      "overall": 85,
      "career": 90,
      "wealth": 78,
      "love": 82,
      "health": 88
    },
    "lucky": {
      "colors": ["青色", "金色"],
      "numbers": [3, 8],
      "directions": ["东南"],
      "hours": ["辰时", "午时"]
    },
    "suggestions": [
      "宜：签约、出行、装修",
      "忌：诉讼、搬迁"
    ]
  }
}
```

---

## 15. 外部服务对接接口 (External)

> **注意**: 以下接口由端脑云工程师对接实现

### 15.1 端脑云用户认证

```http
POST /external/duannaoyun/auth
```

**说明**: 对接端脑云账号系统

### 15.2 端脑云设备管理

```http
GET /external/duannaoyun/devices
POST /external/duannaoyun/devices/bind
```

**说明**: 同步端脑云设备列表

### 15.3 端脑云算力调度

```http
POST /external/duannaoyun/compute/allocate
```

**说明**: 申请云端算力资源

### 15.4 端脑云计费查询

```http
GET /external/duannaoyun/billing/balance
GET /external/duannaoyun/billing/usage
```

**说明**: 查询余额和用量

---

## 16. 错误码列表

| 错误码 | 含义 | 说明 |
|--------|------|------|
| 40001 | 参数错误 | 请求参数格式不正确 |
| 40002 | 验证码错误 | 验证码不正确或已过期 |
| 40101 | Token 过期 | Access Token 已过期 |
| 40102 | Token 无效 | Token 格式错误或已撤销 |
| 40301 | 无权限 | 用户无此操作权限 |
| 40401 | 用户不存在 | 用户未注册 |
| 40402 | 设备不存在 | 设备未找到 |
| 40403 | Agent 不存在 | Agent 未找到 |
| 40404 | 会话不存在 | 会话未找到 |
| 40901 | 设备已绑定 | 设备已被其他账号绑定 |
| 42901 | 请求过于频繁 | 触发限流 |
| 50001 | 服务器内部错误 | 服务端异常 |
| 50002 | AI 服务异常 | 调用 AI 模型失败 |

---

## 17. 附录

### 17.1 数据类型定义

```typescript
// TypeScript 类型定义（供客户端使用）

interface User {
  id: string;
  phone: string;
  profile: UserProfile;
  preferences: UserPreferences;
  fortuneProfile: FortuneProfile;
  createdAt: string;
}

interface Device {
  id: string;
  name: string;
  type: 'lobster_pi' | 'ai_npc' | 'cloud';
  status: 'online' | 'offline' | 'busy';
  isActive: boolean;
  storage: {
    total: number;
    used: number;
    warning: boolean;
  };
  resources: {
    cpuUsage: number;
    memoryUsage: number;
    gpuUsage: number;
  };
}

interface Agent {
  id: string;
  name: string;
  avatar: string;
  type: 'supervisor' | 'specialist';
  role: {
    description: string;
    personality: string;
  };
  llmConfig: LLMConfig;
  capabilities: string[];
  isSupervisor: boolean;
  status: 'online' | 'offline' | 'busy';
}

interface Session {
  id: string;
  agentId: string;
  title: string;
  status: 'active' | 'archived';
  projectId?: string;
  createdAt: string;
  lastMessageAt: string;
}

interface Message {
  id: string;
  sessionId: string;
  role: 'user' | 'assistant' | 'system';
  agentId?: string;
  content: string;
  contentType: 'text' | 'image' | 'audio' | 'video' | 'file';
  metadata?: Record<string, any>;
  timestamp: string;
}
```

### 17.2 相关文档

- [PRODUCT_SPEC.md](./PRODUCT_SPEC.md) - 产品规格
- [ARCHITECTURE.md](./ARCHITECTURE.md) - 架构设计
- [UI_SPEC.md](./UI_SPEC.md) - UI 设计规范
- [ROADMAP.md](./ROADMAP.md) - 开发路线

---

*本文档由妲己整理，朝歌自身 API 完整规范，端脑云对接部分已标注*
