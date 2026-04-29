# 朝歌 Agent Console - Claude Code 执行指令集

> **使用方式**: 逐个复制任务指令到 Claude Code 中执行  
> **执行顺序**: 按 1.1 → 1.2 → 1.3 → 1.5 → 1.4 的顺序  
> **前置条件**: Windows 电脑，已安装 Claude Code，已克隆 GitHub 仓库

---

## 🔧 前置准备（只需执行一次）

### 1. 克隆仓库

在 Windows PowerShell 或 CMD 中执行：

```powershell
cd C:\Users\YourName\Desktop
git clone https://github.com/George-Tinoo/zhaoge-agent-console.git
cd zhaoge-agent-console
```

### 2. 启动 Claude Code

```powershell
claude
```

### 3. 环境说明（每次启动后告诉 Claude）

```
【环境说明】
- 操作系统：Windows（无 Xcode）
- 项目路径：C:\Users\YourName\Desktop\zhaoge-agent-console
- GitHub 仓库：https://github.com/George-Tinoo/zhaoge-agent-console.git
- 开发方式：AI 生成 Swift 代码，后续由 Mac 开发者编译
- 请先阅读 /docs/TASKS.md 了解整体任务规划
```

---

## 📋 任务 1.1：创建 iOS 项目骨架

**目标**: 创建完整的 Xcode 项目结构和基础配置文件

**复制以下完整指令给 Claude Code：**

```
【任务 1.1】创建 iOS 项目骨架

【前置阅读】
请先读取以下文档：
1. /docs/ARCHITECTURE.md - 第 3.1 节客户端架构
2. /docs/UI_SPEC.md - 第 2 节色彩系统

【任务要求】
在 apps/ios/ 目录下创建完整的 iOS 项目，包含 .xcodeproj 项目文件：

1. 创建项目目录结构：
   apps/ios/Chaoge/
   ├── Chaoge.xcodeproj/              ← 完整的 Xcode 项目配置
   │   ├── project.pbxproj
   │   ├── project.xcworkspace/
   │   └── xcshareddata/
   ├── Chaoge/
   │   ├── App/
   │   │   └── ChaogeApp.swift        ← 应用入口
   │   ├── Core/
   │   │   ├── Networking/
   │   │   ├── Storage/
   │   │   └── State/
   │   ├── Features/
   │   │   ├── Home/
   │   │   ├── Chat/
   │   │   ├── Project/
   │   │   ├── Task/
   │   │   └── Settings/
   │   ├── Models/
   │   ├── UI/
   │   │   ├── Theme/
   │   │   └── Components/
   │   ├── Utils/
   │   └── Resources/
   │       ├── Assets.xcassets/
   │       └── Info.plist
   └── ChaogeTests/

2. 创建 ChaogeApp.swift：
   - 使用 @main 标记
   - 继承 App 协议
   - 配置全局外观为深色模式
   - 设置根视图为 ContentView

3. 创建 ContentView.swift（占位）：
   - 简单的 Text("朝歌")
   - 深色背景

4. 创建 Assets.xcassets：
   - AppIcon.appiconset（空占位）
   - Colors 目录包含：
     * siliconBase (#2A3F4D)
     * siliconDark (#1A2630)
     * siliconLight (#4A6B7C)
     * siliconPure (#8FA3B0)
     * refractionCyan (#5CE1E6)
     * refractionPurple (#9B7EDE)
     * refractionGold (#D4AF37)
     * refractionRose (#E8A5C0)
     * textPrimary (#E8F1F5)
     * textSecondary (#8FA3B0)

5. 创建 Info.plist：
   - Bundle Identifier: ai.chaoge.app
   - 部署目标: iOS 17.0
   - 支持方向: Portrait
   - 需要的权限描述（相机、麦克风、相册）

6. 创建 project.pbxproj：
   - 配置 Build Settings
   - SWIFT_VERSION = 5.9
   - IPHONEOS_DEPLOYMENT_TARGET = 17.0
   - 添加所有源文件引用

【硅基生命视觉风格】
- 主背景: 深渊灰 #1A2630 到硅基蓝 #2A3F4D 的渐变
- 深色模式优先，不要纯白/纯黑
- 所有颜色定义在 Assets.xcassets 中

【输出要求】
1. 列出创建的所有文件（完整路径）
2. 确认目录结构符合要求
3. 说明每个关键文件的作用
4. 报告：完成后执行 !git status 查看变更

【注意】
- 由于 Windows 无 Xcode，无法编译验证
- 确保 Swift 语法正确
- 项目文件结构必须完整，Mac 开发者可直接打开
```

---

## 📋 任务 1.2：创建基础架构模块

**目标**: 创建数据模型和核心服务类

**前置**: 任务 1.1 已完成

```
【任务 1.2】创建基础架构模块

【前置阅读】
1. /docs/ARCHITECTURE.md - 第 3.1.2 节状态管理
2. /docs/API_SPEC.md - 第 17.1 节数据类型定义

【任务要求】
创建数据模型和核心服务类：

1. 创建 Models/User.swift：
   struct User: Codable, Identifiable {
       let id: String
       let phone: String
       let profile: UserProfile
       let preferences: UserPreferences
       let fortuneProfile: FortuneProfile?
   }
   
   struct UserProfile: Codable {
       let nickname: String?
       let avatar: String?
       let bio: String?
   }
   
   struct UserPreferences: Codable {
       let theme: String
       let language: String
       let notifications: NotificationSettings
   }

2. 创建 Models/Device.swift：
   struct Device: Codable, Identifiable {
       let id: String
       let name: String
       let type: DeviceType
       let status: DeviceStatus
       let isActive: Bool
       let storage: StorageInfo
       let resources: ResourceInfo
   }
   
   enum DeviceType: String, Codable {
       case lobsterPi = "lobster_pi"
       case aiNPC = "ai_npc"
       case cloud = "cloud"
   }
   
   enum DeviceStatus: String, Codable {
       case online, offline, busy
   }

3. 创建 Models/Agent.swift：
   struct Agent: Codable, Identifiable {
       let id: String
       let name: String
       let avatar: String?
       let type: AgentType
       let roleDescription: String
       let personality: String
       let isSupervisor: Bool
       let capabilities: [String]
       let llmConfig: LLMConfig
       let status: AgentStatus
   }
   
   enum AgentType: String, Codable {
       case supervisor, specialist
   }
   
   enum AgentStatus: String, Codable {
       case online, offline, busy
   }

4. 创建 Models/Message.swift：
   struct Message: Codable, Identifiable {
       let id: String
       let sessionId: String
       let role: MessageRole
       let agentId: String?
       let content: String
       let contentType: ContentType
       let metadata: MessageMetadata?
       let timestamp: Date
   }
   
   enum MessageRole: String, Codable {
       case user, assistant, system
   }
   
   enum ContentType: String, Codable {
       case text, image, audio, video, file
   }

5. 创建 Models/Session.swift：
   struct Session: Codable, Identifiable {
       let id: String
       let agentId: String
       let title: String
       let status: SessionStatus
       let projectId: String?
       let createdAt: Date
       let lastMessageAt: Date
   }

6. 创建 Models/Project.swift：
   struct Project: Codable, Identifiable {
       let id: String
       let name: String
       let description: String
       let status: ProjectStatus
       let relatedAgents: [String]
       let createdAt: Date
   }

7. 创建 Models/Task.swift：
   struct Task: Codable, Identifiable {
       let id: String
       let title: String
       let description: String
       let projectId: String?
       let assigneeAgentId: String
       let status: TaskStatus
       let priority: Int
       let deadline: Date?
       let createdAt: Date
   }

8. 创建 Core/Networking/NetworkManager.swift：
   class NetworkManager: ObservableObject {
       static let shared = NetworkManager()
       private let baseURL = "https://api.chaoge.ai/v1"
       
       func request<T: Decodable>(_ endpoint: String, method: String = "GET") async throws -> T
       func post<T: Decodable>(_ endpoint: String, body: Encodable) async throws -> T
   }

9. 创建 Core/Storage/LocalStorage.swift：
   class LocalStorage {
       static let shared = LocalStorage()
       
       func save<T: Codable>(_ object: T, forKey key: String)
       func load<T: Codable>(_ type: T.Type, forKey key: String) -> T?
       func delete(forKey key: String)
   }

10. 创建 Core/State/AppState.swift：
    class AppState: ObservableObject {
        @Published var user: User?
        @Published var isLoggedIn: Bool = false
        @Published var devices: [Device] = []
        @Published var agents: [Agent] = []
        @Published var supervisorAgent: Agent?
        @Published var currentSession: Session?
    }

【输出要求】
1. 列出创建的所有模型文件
2. 确认每个模型都有 Codable 协议
3. 确认使用 Swift 现代特性（async/await）
4. 报告：!git status 查看变更
```

---

## 📋 任务 1.3：实现主题系统（硅基生命视觉）

**目标**: 创建颜色、字体、组件等 UI 基础

**前置**: 任务 1.1 完成

```
【任务 1.3】实现主题系统（硅基生命视觉）

【前置阅读】
1. /docs/UI_SPEC.md - 第 2 节色彩系统
2. /docs/UI_SPEC.md - 第 3 节字体规范
3. /docs/UI_SPEC.md - 第 4 节组件规范

【任务要求】
创建完整的硅基生命视觉主题系统：

1. 创建 UI/Theme/Colors.swift：
   - 定义所有颜色常量
   - 实现 Color(hex:) 初始化器
   - 包含硅基主色、折射色、文字色、状态色
   
   例如：
   extension Color {
       static let siliconBase = Color(hex: "#2A3F4D")
       static let siliconDark = Color(hex: "#1A2630")
       static let refractionCyan = Color(hex: "#5CE1E6")
       // ... 其他颜色
   }

2. 创建 UI/Theme/Fonts.swift：
   - 定义字体规范
   - 创建字体修饰器
   
   例如：
   extension Font {
       static let display = Font.system(size: 48, weight: .light)
       static let h1 = Font.system(size: 32, weight: .semibold)
       // ... 其他字体
   }

3. 创建 UI/Theme/Theme.swift：
   - 定义主题配置
   - 包含圆角、间距等常量
   
   struct Theme {
       static let cornerRadius: CGFloat = 16
       static let padding: CGFloat = 16
       static let cardPadding: CGFloat = 20
   }

4. 创建 UI/Components/CrystalCard.swift（水晶卡片）：
   struct CrystalCard<Content: View>: View {
       let content: Content
       
       init(@ViewBuilder content: () -> Content) {
           self.content = content()
       }
       
       var body: some View {
           content
               .padding()
               .background(
                   LinearGradient(
                       colors: [
                           Color.siliconLight.opacity(0.15),
                           Color.siliconBase.opacity(0.25)
                       ],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
                   )
               )
               .cornerRadius(16)
               .overlay(
                   RoundedRectangle(cornerRadius: 16)
                       .stroke(Color.siliconPure.opacity(0.2), lineWidth: 1)
               )
       }
   }

5. 创建 UI/Components/SiliconButton.swift（硅基按钮）：
   - 主按钮：折射渐变背景
   - 次按钮：透明背景 + 边框
   - 危险按钮：红色调

6. 创建 UI/Components/CrystalInput.swift（水晶输入框）：
   - 深色背景
   - 聚焦时青蓝色发光边框
   - 支持语音输入状态（红色脉冲）

7. 创建 UI/Components/MessageBubble.swift（消息气泡）：
   - 用户消息：右侧，硅晶渐变
   - Agent 消息：左侧，左侧彩色条标识
   - 支持不同 Agent 的颜色区分

8. 创建 UI/Components/StatusIndicator.swift（状态指示器）：
   - 在线：青蓝色呼吸光点
   - 忙碌：金色
   - 离线：灰色
   - 带动画效果

【硅基视觉关键点】
- 深色背景优先（siliconDark, siliconBase）
- 毛玻璃效果（blur + opacity）
- 水晶边框（细边框 + 渐变背景）
- 呼吸动画（opacity 变化）
- 折射高光（亮色文字 + shadow）

【输出要求】
1. 列出创建的所有主题文件
2. 展示 CrystalCard 的用法示例
3. 确认所有颜色与 UI_SPEC.md 一致
4. 报告：!git status
```

---

## 📋 任务 1.5：创建底部导航栏

**目标**: 创建主 Tab 导航结构

**前置**: 任务 1.3 完成

```
【任务 1.5】创建底部导航栏

【前置阅读】
1. /docs/UI_SPEC.md - 第 4.4 节导航栏设计
2. /docs/PRODUCT_SPEC.md - 首页和导航相关章节

【任务要求】
创建底部 Tab 导航和占位页面：

1. 创建 Features/MainTab/MainTabView.swift：
   - 使用 TabView
   - 5 个 Tab：首页、聊天、项目、任务、设置
   - 自定义 TabBar 样式（硅基深色风格）
   - 激活状态使用 refractionCyan
   
   结构：
   struct MainTabView: View {
       @State private var selectedTab = 0
       
       var body: some View {
           TabView(selection: $selectedTab) {
               HomeView()
                   .tabItem { Image(systemName: "diamond.fill"); Text("首页") }
                   .tag(0)
               
               ChatListView()
                   .tabItem { Image(systemName: "bubble.left.fill"); Text("聊天") }
                   .tag(1)
               
               ProjectListView()
                   .tabItem { Image(systemName: "folder.fill"); Text("项目") }
                   .tag(2)
               
               TaskListView()
                   .tabItem { Image(systemName: "checkmark.circle.fill"); Text("任务") }
                   .tag(3)
               
               SettingsView()
                   .tabItem { Image(systemName: "gear"); Text("设置") }
                   .tag(4)
           }
           .accentColor(.refractionCyan)
           .onAppear {
               // 自定义 TabBar 外观
               let appearance = UITabBarAppearance()
               appearance.configureWithOpaqueBackground()
               appearance.backgroundColor = UIColor(Color.siliconDark)
               UITabBar.appearance().standardAppearance = appearance
           }
       }
   }

2. 更新 ChaogeApp.swift：
   - 将 ContentView() 改为 MainTabView()
   - 确保应用启动后显示底部导航

3. 创建 Features/Home/HomeView.swift（占位）：
   - 使用 ZStack + 深色背景
   - 中间显示 "首页" 文字
   - 硅基视觉风格

4. 创建 Features/Chat/ChatListView.swift（占位）：
   - 深色背景
   - 显示 "聊天列表"

5. 创建 Features/Project/ProjectListView.swift（占位）：
   - 深色背景
   - 显示 "项目列表"

6. 创建 Features/Task/TaskListView.swift（占位）：
   - 深色背景
   - 显示 "任务列表"

7. 创建 Features/Settings/SettingsView.swift（占位）：
   - 深色背景
   - 显示 "设置"

【视觉要求】
- 所有页面背景使用 Color.siliconDark
- 文字使用 Color.textPrimary
- TabBar 背景与页面背景一致
- 激活状态有发光效果

【输出要求】
1. 确认 5 个 Tab 可以切换
2. 每个 Tab 有独立的 View 文件
3. 导航栏样式符合硅基视觉
4. 报告：!git status
```

---

## 📋 任务 1.4：创建首页框架

**目标**: 实现首页的运势展示和 Agent 形象

**前置**: 任务 1.3 和 1.5 完成

```
【任务 1.4】创建首页框架

【前置阅读】
1. /docs/UI_SPEC.md - 第 7.1 节首页设计
2. /docs/PRODUCT_SPEC.md - 第 3.3.2 节正式首页
3. 已完成的 CrystalCard、Colors 等组件

【任务要求】
实现完整的首页功能：

1. 更新 Features/Home/HomeView.swift：
   - 使用 ScrollView 实现可滚动内容
   - 背景：硅基深色渐变
   - 包含以下模块：

2. 创建 Features/Home/FortuneView.swift（运势卡片）：
   - 使用 CrystalCard 包装
   - 显示：
     * 当前日期（2026年4月28日 星期三）
     * 今日运势分数（大数字显示）
     * 分项运势（事业、财运、情感）
     * 幸运色、幸运数字
   - 使用折射青色高亮重要数字

3. 创建 Features/Home/AgentAvatarView.swift（Agent 形象）：
   - 圆形头像占位
   - 水晶边框效果
   - 呼吸动画（可选）
   - 显示 Agent 名字

4. 创建 Features/Home/GreetingView.swift（问候语）：
   - 根据时间显示不同问候
   - 早上："大王，早安"
   - 中午："大王，午安"
   - 晚上："大王，晚安"

5. 创建 Features/Home/HomeViewModel.swift：
   class HomeViewModel: ObservableObject {
       @Published var currentDate = Date()
       @Published var todayFortune: Fortune?
       @Published var supervisorAgent: Agent?
       
       func startNewDay() {
           // 开启新一天的逻辑
       }
       
       func loadFortune() {
           // 加载今日运势（先用模拟数据）
           todayFortune = Fortune(
               overall: 85,
               career: 90,
               wealth: 78,
               love: 82,
               health: 88,
               luckyColors: ["青色", "金色"],
               luckyNumbers: [3, 8]
           )
       }
   }

6. 创建 Models/Fortune.swift：
   struct Fortune {
       let overall: Int
       let career: Int
       let wealth: Int
       let love: Int
       let health: Int
       let luckyColors: [String]
       let luckyNumbers: [Int]
   }

7. 添加 "开启新的一天" 按钮：
   - 使用 SiliconButton（主按钮样式）
   - 折射渐变背景
   - 点击后有反馈

8. 实现首页布局：
   VStack(spacing: 24) {
       // 运势卡片
       FortuneView(...)
       
       // Agent 形象
       AgentAvatarView(...)
       
       // 开启新的一天按钮
       Button(...) { ... }
   }
   .padding()

【模拟数据】
今日运势：
- 整体：85分
- 事业：90分
- 财运：78分
- 情感：82分
- 健康：88分
- 幸运色：青色、金色
- 幸运数字：3、8

Agent：
- 名字：妲己
- 角色：主管 Agent

【视觉要求】
- 使用 CrystalCard 包装各个模块
- 运势分数使用大字号 Display 字体
- 数字使用折射色（80分以上用金色）
- 背景使用硅基深色渐变

【输出要求】
1. 首页显示完整布局
2. 运势信息正确显示
3. 按钮有交互反馈
4. 使用所有已创建的组件
5. 报告：!git status
```

---

## ✅ 任务完成后提交代码

每个任务完成后，在 Claude Code 中执行：

```
!git add .
!git commit -m "Task X.X: 任务描述"
!git push origin main
```

或在终端执行：
```bash
git add .
git commit -m "Task 1.1: Create iOS project skeleton"
git push origin main
```

---

## 📊 任务依赖关系

```
任务 1.1（项目骨架）
    ↓
任务 1.2（架构模块）
    ↓
任务 1.3（主题系统）
    ↓
    ├──→ 任务 1.5（底部导航）
    │         ↓
    └──→ 任务 1.4（首页框架）
```

**执行顺序**: 1.1 → 1.2 → 1.3 → 1.5 → 1.4

---

## 🎯 验收标准汇总

| 任务 | 验收标准 |
|------|---------|
| 1.1 | 项目文件完整，目录结构正确，有 .xcodeproj |
| 1.2 | 所有模型定义完成，使用 Codable 协议 |
| 1.3 | 所有组件可用，颜色符合硅基视觉 |
| 1.5 | 5 个 Tab 可切换，导航栏样式正确 |
| 1.4 | 首页显示运势、Agent 形象、按钮 |

---

*指令集由妲己准备，供大王在 Windows 上使用 Claude Code 开发 iOS 项目*
