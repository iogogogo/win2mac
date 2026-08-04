# win2mac

把 Windows 键盘「伪装」成 Mac 键盘的 AutoHotkey 映射脚本。
在 Windows 上还原 macOS 的常用快捷键手感——`CapsLock` 变输入法切换、用 `Alt` 顶替 `⌘ Command`、常用组合键全对齐 macOS，并针对浏览器和微信做了特调。

仓库内含两个版本：

| 文件 | 引擎 | 说明 |
|---|---|---|
| `win2mac.ahk` | AutoHotkey **v1.x** | 早期版本，功能见第 1–4 节。仅在你已固定使用 v1 引擎时保留。 |
| `win2mac_v2.ahk` | AutoHotkey **v2.x** | **推荐版本**。功能对齐 v1（第 1–4 节），并额外支持方向键相关的行首/行尾跳转与选中（第 5–6 节）。 |

> 两个版本语法不互通，但可同时安装引擎、各自单独运行。**推荐优先使用 `win2mac_v2.ahk`（v2 引擎，功能更完整）**；若你已稳定使用 v1 且无意迁移，可继续用 `win2mac.ahk`。

## 环境要求

- **AutoHotkey v1.x**（1.1 系列）：运行 `win2mac.ahk`。脚本使用 AHK v1 语法（`Send,`、`#IfWinActive`、`!s::` 等），不兼容 v2。
- **AutoHotkey v2.x**（2.0 及以上）：运行 `win2mac_v2.ahk`。脚本使用 AHK v2 语法（`Send "..."`、`#HotIf WinActive(...)`、`!s::` 等），不兼容 v1。
- 适用系统：Windows（桌面端）。

## 使用方法

1. 安装对应版本的 AutoHotkey（两个版本可并存）。
2. 用**匹配的引擎**运行脚本（**推荐 v2 版本**）：
   - v1：`AutoHotkey.exe win2mac.ahk`
   - v2：`AutoHotkey64.exe win2mac_v2.ahk`
3. 脚本在后台运行（系统托盘出现 AHK 图标）。需要退出时，右键托盘图标 → `Exit`；或修改后重新运行（脚本已设置 `#SingleInstance Force`，新实例会替换旧实例）。

> ⚠️ 不要直接用默认关联双击 `.ahk`——若系统默认关联是 v1，会用 v1 引擎去跑 v2 语法而报错。请显式用对应版本的 exe 启动。

## 功能详解

### 1. CapsLock 改造（输入法切换 + 真·大写锁定）
默认强制关闭 CapsLock，并将它改造成一个多功能键：

| 操作 | 效果 |
|---|---|
| 轻点 CapsLock（按住 < 0.3 秒） | 发送 `Ctrl+Space`，切换输入法（macOS 习惯） |
| 长按 CapsLock（按住 > 0.3 秒） | 真正打开大写锁定，松开后保持大写 |
| 按下 `Shift` | 关闭大写锁定 |

> 思路：把 CapsLock 这个在 Windows 上很少用到的键，变成高频的「输入法切换」，Mac 转 Windows 用户的经典玩法。

### 2. Alt + 字母 → 对应 Ctrl + 字母
用 `Alt` 顶替 Mac 的 `⌘`，把 macOS 的快捷键习惯平移到 Windows：

| 组合键 | 实际发送 | 作用 |
|---|---|---|
| `Alt+S` | `Ctrl+S` | 保存 |
| `Alt+A` | `Ctrl+A` | 全选 |
| `Alt+C` | `Ctrl+C` | 复制 |
| `Alt+V` | `Ctrl+V` | 粘贴 |
| `Alt+X` | `Ctrl+X` | 剪切 |
| `Alt+Z` | `Ctrl+Z` | 撤销 |
| `Alt+Y` | `Ctrl+Y` | 重做 |
| `Alt+T` | `Ctrl+T` | 新标签页 |
| `Alt+N` | `Ctrl+N` | 新建窗口/文件 |
| `Alt+O` | `Ctrl+O` | 打开 |
| `Alt+P` | `Ctrl+P` | 打印 |
| `Alt+W` | `Ctrl+W` | 关闭标签页 |
| `Alt+Q` | `Ctrl+Q` | 退出程序 |

### 3. 浏览器刷新（Edge / Chrome 专用）
仅当 **Microsoft Edge** 或 **Google Chrome** 处于前台时生效：

| 组合键 | 实际发送 | 作用 |
|---|---|---|
| `Alt+R` | `Ctrl+R` | 刷新页面 |

### 4. 微信：Alt + Enter 发送消息
仅当 **微信（Weixin.exe）** 处于前台时生效：

| 组合键 | 实际发送 | 作用 |
|---|---|---|
| `Alt+Enter` | `Ctrl+Enter` | 发送消息 |

（脚本中保留了第二种写法的注释备用方案，默认不启用。）

### 5. Alt + ← / → 跳到行首 / 行尾（v2 版本专属）

对应 macOS 的 `⌘←` / `⌘→`。在大部分编辑器、记事本、输入框里，把 `Alt+方向键` 映射为 `Home` / `End`：

| 组合键 | 实际发送 | 作用 |
|---|---|---|
| `Alt+←` | `Home` | 跳到行首 |
| `Alt+→` | `End` | 跳到行尾 |

> 排除规则：在 **Edge / Chrome**（Alt+←/→ 是后退/前进）与**文件资源管理器**（Alt+← 是后退）中保留其原生行为，不做映射。

### 6. Alt + Shift + ← / → 按单词选中（v2 版本专属）

对应 macOS 的 `⌥+Shift+←` / `⌥+Shift+→`。在 `Alt+方向键` 基础上叠加 `Shift`，映射为 `Ctrl+Shift+←` / `Ctrl+Shift+→`，每按一次向左右扩展选中一个单词（可连按）：

| 组合键 | 实际发送 | 作用 |
|---|---|---|
| `Alt+Shift+←` | `Ctrl+Shift+←` | 向左逐词选中 |
| `Alt+Shift+→` | `Ctrl+Shift+→` | 向右逐词选中 |
| `Alt+Ctrl+Shift+←` | `Shift+Home` | 从光标选中到行首 |
| `Alt+Ctrl+Shift+→` | `Shift+End` | 从光标选中到行尾 |

> 同样沿用第 5 节的排除规则，浏览器与资源管理器走原生行为。
> 说明：「选中到行首/行尾」改用三键组合（`Alt+Ctrl+Shift+方向键`），与上面的逐词选中互不冲突（Ctrl 同时按下时不会误触发逐词选中那一行）。

## 注意事项

- 这些 `Alt+字母` 映射会覆盖 Windows 部分程序的菜单快捷键（如 `Alt+F` 打开文件菜单）。如果你的常用软件依赖原生 Alt 快捷键，建议按需删减或限定到特定程序。
- v1 脚本中第 1 行 `#NoEnv` 表示不读取系统环境变量（避免外部变量干扰），并将进程优先级设为 `High` 让按键更跟手；v2 版本无需 `#NoEnv`，改用 `ProcessSetPriority "High"`。

## 自定义

编辑对应文件（`win2mac.ahk` 或 `win2mac_v2.ahk`）即可增删映射：

**v1（AHK 1.x 语法）：**
- 新增全局 Alt 映射：`!k::Send, ^k`（Alt+K → Ctrl+K）
- 限定到某程序：`#IfWinActive ahk_exe notepad.exe` … `#IfWinActive`
- 修改 CapsLock 的轻点/长按阈值：调整 `KeyWait, CapsLock, T0.3` 中的 `0.3`（单位秒）。

**v2（AHK 2.x 语法）：**
- 新增全局 Alt 映射：`!k::Send "^k"`
- 限定到某程序：`#HotIf WinActive("ahk_exe notepad.exe")` … `#HotIf`
- 新增方向键跳转/选中（参考第 5–6 节）：`!Left::Send "{Home}"`、`!+Left::Send "+{Home}"`
- 调整排除程序：修改第 5–6 节 `#HotIf` 中 `!WinActive(...)` 的条件即可。

## 打包为 exe（图形界面）

把 `win2mac_v2.ahk` 编译成**自包含 exe**，目标机器无需安装 AutoHotkey 即可运行，也更适合放进启动目录自启。

1. 打开编译器 **Ahk2Exe**：从开始菜单搜索 `Ahk2Exe`，或运行 AutoHotkey 安装目录下的 `Compiler\Ahk2Exe.exe`。
2. 在 Ahk2Exe 窗口中填写：
   - **Source (script)**：选择仓库里的 `win2mac_v2.ahk`
   - **Base file**：选择 **v2 引擎** `AutoHotkey64.exe`（位于 AutoHotkey v2 安装目录内）
   - **Destination**：填写 `win2mac_v2.exe`（与脚本同目录即可）
3. 点击 **Convert**，状态栏显示成功即完成。

> ⚠️ **Base file 必须选 v2 的 `AutoHotkey64.exe`**，不能留默认（默认会指向 v1 引擎，导致编译 v2 脚本失败）。
>
> 生成的 `win2mac_v2.exe` 已打包 v2 引擎，可直接双击运行。它是构建产物，**不建议提交进仓库**；需要长期保留时，建议将其加入 `.gitignore`。
