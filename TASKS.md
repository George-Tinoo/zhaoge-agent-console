# 朝歌 Agent Console - 开发任务清单

> **当前阶段**: Phase 1 - 核心基础 (Week 1-2)  
> **目标**: iOS 项目初始化 + 基础框架搭建  
> **执行者**: Codex / AI 编码工具  
> **参考文档**: `/docs` 目录下的所有规范文档

---

## 📋 任务执行指南

### 如何阅读此文档

每个任务包含：
- **任务编号**: 便于跟踪进度
- **前置条件**: 开始前需要完成什么
- **输入**: 需要参考的文档/资源
- **输出**: 期望产出的文件/代码
- **验收标准**: 如何验证任务完成

### 执行顺序

按编号顺序执行，每个任务完成后在 `[ ]` 中打勾 `[x]`

---

## Phase 1: iOS 项目初始化

### 任务 1.1: 创建 iOS 项目骨架

**状态**: [ ] 待完成  
**预估时间**: 30 分钟  
**执行工具**: Xcode 命令行或 Swift Package Manager

**前置条件**: 
- macOS 环境
- Xcode 15+ 已安装
- Swift 5.9+ 可用

**输入**:
- `docs/ARCHITECTURE.md` - 架构设计
- `docs/UI_SPEC.md` - UI 规范

**输出**:
```
apps/ios/Chaoge/
├── Chaoge.xcodeproj
├── Chaoge/
│   ├── App/
│   │   └── ChaogeApp.swift
│   ├── Core/
│   ├── Features/
│   ├── Models/
│   └── Resources/
└── ChaogeTests/
```

**执行步骤**:

1. 创建项目目录
```bash
mkdir -p apps/ios
cd apps/ios
```

2. 使用 Xcode 命令行创建项目
```bash
xcodebuild -create-project -project Chaoge.xcodeproj
```

或手动创建 Swift Package 项目:
```bash
swift package init --type executable --name Chaoge
```

3. 配置项目基础设置:
   - Bundle Identifier: `ai.chaoge.app`
   - Deployment Target: iOS 17.0
   - Interface: SwiftUI
   - Language: Swift

**验收标准**:
- [ ] 项目能在 Xcode 中打开
- [ ] 能编译运行，显示空白页面
- [ ] 目录结构符合上述规范

---

### 任务 1.2: 创建基础架构模块

**状态**: [ ] 待完成  
**预估时间**: 45 分钟  
**前置任务**: 1.1

**输入**:
- `docs/ARCHITECTURE.md` 第 3.1 节 - 客户端架构

**输出文件**:

```
apps/ios/Chaoge/Chaoge/
├── Core/
│   ├── Networking/
│   │   └── NetworkManager.swift
│   ├── Storage/
│   │   └── LocalStorage.swift
│   └── State/
│       └── AppState.swift
├── Models/
│   ├── User.swift
│   ├── Device.swift
│   └── Agent.swift
└── Utils/
    └── Constants.swift
```

**详细要求**:

#### NetworkManager.swift
```swift
import Foundation
import Combine

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    private let baseURL = "https://api.chaoge.ai/v1"
    
    // TODO: 实现 API 请求方法
    func request<T: Decodable>(_ endpoint: String, method: String = "GET") async throws -> T {
        // 实现网络请求
    }
}
```

#### Models/User.swift
```swift
struct User: Codable, Identifiable {
    let id: String
    let phone: String
    let profile: UserProfile
    let preferences: UserPreferences
    
    struct UserProfile: Codable {
        let nickname: String?
        let avatar: String?
    }
}
```

#### Models/Device.swift
```swift
struct Device: Codable, Identifiable {
    let id: String
    let name: String
    let type: DeviceType
    let status: DeviceStatus
    
    enum DeviceType: String, Codable {
        case lobsterPi = "lobster_pi"
        case aiNPC = "ai_npc"
        case cloud = "cloud"
    }
    
    enum DeviceStatus: String, Codable {
        case online, offline, busy
    }
}
```

#### Models/Agent.swift
```swift
struct Agent: Codable, Identifiable {
    let id: String
    let name: String
    let avatar: String?
    let type: AgentType
    let isSupervisor: Bool
    let capabilities: [String]
    
    enum AgentType: String, Codable {
        case supervisor, specialist
    }
}
```

**验收标准**:
- [ ] 所有文件编译无错误
- [ ] 数据模型符合 API_SPEC.md 定义
- [ ] 使用 Swift 最新特性（async/await, Codable 等）

---

### 任务 1.3: 实现主题系统（硅基生命视觉）

**状态**: [ ] 待完成  
**预估时间**: 60 分钟  
**前置任务**: 1.1

**输入**:
- `docs/UI_SPEC.md` 第 2 节 - 色彩系统
- `docs/UI_SPEC.md` 第 3 节 - 字体规范

**输出文件**:

```
apps/ios/Chaoge/Chaoge/
└── UI/
    ├── Theme/
    │   ├── Colors.swift
    │   ├── Fonts.swift
    │   └── Theme.swift
    └── Components/
        └── CrystalCard.swift
```

**详细要求**:

#### Colors.swift
```swift
import SwiftUI

extension Color {
    // 硅基主色
    static let siliconBase = Color(hex: "#2A3F4D")
    static let siliconLight = Color(hex: "#4A6B7C")
    static let siliconDark = Color(hex: "#1A2630")
    static let siliconPure = Color(hex: "#8FA3B0")
    
    // 折射色
    static let refractionCyan = Color(hex: "#5CE1E6")
    static let refractionPurple = Color(hex: "#9B7EDE")
    static let refractionGold = Color(hex: "#D4AF37")
    static let refractionRose = Color(hex: "#E8A5C0")
    
    // 背景
    static let bgPrimary = LinearGradient(
        colors: [Color.siliconDark, Color.siliconBase],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // 文字
    static let textPrimary = Color(hex: "#E8F1F5")
    static let textSecondary = Color(hex: "#8FA3B0")
    static let textTertiary = Color(hex: "#5A7380")
}

extension Color {
    init(hex: String) {
        // 实现 hex 初始化
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
```

#### CrystalCard.swift
```swift
import SwiftUI

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
            .shadow(
                color: Color.black.opacity(0.2),
                radius: 4,
                x: 0,
                y: 4
            )
    }
}
```

**验收标准**:
- [ ] 所有颜色值与 UI_SPEC.md 一致
- [ ] CrystalCard 组件可复用
- [ ] 支持深色模式

---

### 任务 1.4: 创建首页框架

**状态**: [ ] 待完成  
**预估时间**: 90 分钟  
**前置任务**: 1.2, 1.3

**输入**:
- `docs/UI_SPEC.md` 第 7.1 节 - 首页设计
- `docs/PRODUCT_SPEC.md` 第 3.3 节 - 首页功能

**输出文件**:

```
apps/ios/Chaoge/Chaoge/
└── Features/
    └── Home/
        ├── HomeView.swift
        ├── FortuneView.swift
        ├── AgentAvatarView.swift
        └── GreetingView.swift
```

**详细要求**:

#### HomeView.swift (主页面)
```swift
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            // 背景
            Color.siliconDark
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // 运势信息区
                    FortuneView(
                        date: viewModel.currentDate,
                        fortune: viewModel.todayFortune
                    )
                    
                    // Agent 形象区
                    AgentAvatarView(
                        agent: viewModel.supervisorAgent
                    )
                    
                    // 开启新的一天按钮
                    Button(action: {
                        viewModel.startNewDay()
                    }) {
                        Text("开启新的一天")
                            .font(.headline)
                            .foregroundColor(.siliconDark)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.refractionCyan, .refractionPurple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
    }
}

class HomeViewModel: ObservableObject {
    @Published var currentDate = Date()
    @Published var todayFortune: Fortune?
    @Published var supervisorAgent: Agent?
    
    func startNewDay() {
        // 实现开启新的一天逻辑
    }
}

struct Fortune {
    let overall: Int
    let career: Int
    let wealth: Int
    let love: Int
    let health: Int
    let luckyColors: [String]
    let luckyNumbers: [Int]
}
```

#### FortuneView.swift
```swift
struct FortuneView: View {
    let date: Date
    let fortune: Fortune?
    
    var body: some View {
        CrystalCard {
            VStack(alignment: .leading, spacing: 12) {
                // 日期
                Text(formatDate(date))
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                
                // 运势分数（大数字）
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(fortune?.overall ?? 0)")
                            .font(.system(size: 48, weight: .light))
                            .foregroundColor(.refractionCyan)
                        Text("今日运势")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                    
                    Spacer()
                    
                    // 分项运势
                    VStack(alignment: .trailing, spacing: 4) {
                        FortuneItem(label: "事业", value: fortune?.career ?? 0)
                        FortuneItem(label: "财运", value: fortune?.wealth ?? 0)
                        FortuneItem(label: "情感", value: fortune?.love ?? 0)
                    }
                }
                
                // 幸运信息
                if let fortune = fortune {
                    HStack {
                        Label(fortune.luckyColors.joined(separator: ", "), systemImage: "paintbrush")
                        Spacer()
                        Label(fortune.luckyNumbers.map(String.init).joined(separator: ", "), systemImage: "number")
                    }
                    .font(.caption)
                    .foregroundColor(.textTertiary)
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 EEEE"
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: date)
    }
}

struct FortuneItem: View {
    let label: String
    let value: Int
    
    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.textTertiary)
            Text("\(value)")
                .font(.caption)
                .foregroundColor(value >= 80 ? .refractionGold : .textSecondary)
        }
    }
}
```

**验收标准**:
- [ ] 首页显示完整布局
- [ ] 运势卡片显示分数和幸运信息
- [ ] 水晶卡片样式正确
- [ ] "开启新的一天"按钮有交互反馈

---

### 任务 1.5: 创建底部导航栏

**状态**: [ ] 待完成  
**预估时间**: 45 分钟  
**前置任务**: 1.3

**输入**:
- `docs/UI_SPEC.md` 第 4.4 节 - 导航栏设计

**输出文件**:

```
apps/ios/Chaoge/Chaoge/
└── Features/
    └── MainTab/
        └── MainTabView.swift
```

**详细要求**:

#### MainTabView.swift
```swift
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "diamond.fill")
                    Text("首页")
                }
                .tag(0)
            
            ChatListView()
                .tabItem {
                    Image(systemName: "bubble.left.fill")
                    Text("聊天")
                }
                .tag(1)
            
            ProjectListView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("项目")
                }
                .tag(2)
            
            TaskListView()
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("任务")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
                .tag(4)
        }
        .accentColor(.refractionCyan)
        .onAppear {
            // 自定义 TabBar 样式
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.siliconDark)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// 占位视图（后续任务实现）
struct ChatListView: View {
    var body: some View {
        Text("聊天列表")
            .foregroundColor(.textPrimary)
    }
}

struct ProjectListView: View {
    var body: some View {
        Text("项目列表")
            .foregroundColor(.textPrimary)
    }
}

struct TaskListView: View {
    var body: some View {
        Text("任务列表")
            .foregroundColor(.textPrimary)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("设置")
            .foregroundColor(.textPrimary)
    }
}
```

**验收标准**:
- [ ] 5 个 Tab 正常切换
- [ ] 激活状态显示折射青色
- [ ] 背景色为硅基深色
- [ ] 导航栏样式符合 UI 规范

---

## 📊 任务进度追踪

| 任务 | 状态 | 完成时间 | 负责人 |
|------|------|---------|--------|
| 1.1 创建 iOS 项目骨架 | [ ] | | Codex |
| 1.2 创建基础架构模块 | [ ] | | Codex |
| 1.3 实现主题系统 | [ ] | | Codex |
| 1.4 创建首页框架 | [ ] | | Codex |
| 1.5 创建底部导航栏 | [ ] | | Codex |

---

## 🚀 如何开始

### 步骤 1: 启动 Codex

在终端运行：
```bash
codex apps/ios/Chaoge
```

或 Claude Code:
```bash
claude apps/ios/Chaoge
```

### 步骤 2: 给 Codex 的指令

```
请按照 TASKS.md 的任务 1.1 开始执行：
1. 阅读 docs/ARCHITECTURE.md 和 docs/UI_SPEC.md
2. 在 apps/ios/ 目录下创建 iOS 项目
3. 项目要求：
   - 名称：Chaoge
   - Bundle ID：ai.chaoge.app
   - 目标：iOS 17.0+
   - 界面：SwiftUI
   - 目录结构符合 TASKS.md 1.1 要求
4. 完成后告诉我验收标准是否达成
```

### 步骤 3: 验证

每个任务完成后：
1. 检查生成的文件是否符合要求
2. 编译项目看是否有错误
3. 运行看效果是否符合预期
4. 在 TASKS.md 中标记完成

---

## 💡 提示

- 每个任务完成后提交一次 Git
- 遇到不确定的参考 docs/ 目录下的文档
- 复杂任务可以拆分成更小的子任务
- 保持代码风格一致

---

*任务清单由妲己创建，供 Codex / Claude Code / 其他 AI 编码工具使用*
