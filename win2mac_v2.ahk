#SingleInstance Force
; ============================================================
; win2mac v2 —— AutoHotkey 2.x 版本
; 与 win2mac.ahk（v1）功能完全一致，仅语法移植到 AHK v2：
;   - CapsLock 轻点 = 输入法切换(Ctrl+Space)，长按 = 真·大写锁定
;   - Alt 顶替 ⌘，Alt+字母 映射为对应 Ctrl+字母
;   - 浏览器(Edge/Chrome) Alt+R 刷新
;   - 微信 Alt+Enter 发送
; 注意：本文件使用 AHK v2 语法，不兼容 v1，请用 AutoHotkey 2.x 运行。
; ============================================================

; 进程高优先级，按键更跟手
ProcessSetPriority "High"

; 强制关闭 CapsLock，并禁止应用抢回其状态
SetCapsLockState "AlwaysOff"
SetStoreCapsLockMode false

; ---------- CapsLock：轻点=输入法切换，长按=真大写锁定 ----------
CapsLock:: {
    if !KeyWait("CapsLock", "T0.3") {   ; 超时 => 长按
        SetCapsLockState "On"
        KeyWait "CapsLock"
    } else {                            ; 及时松开 => 轻点
        Send "{Ctrl down}{Space}{Ctrl up}"
    }
}

; 按 Shift 关闭大写锁定
Shift::SetCapsLockState "Off"

; ---------- Alt + 字母 映射为 Ctrl + 字母（Alt 顶替 ⌘），与 v1 一致 ----------
!s::Send "^s"   ; 保存
!a::Send "^a"   ; 全选
!c::Send "^c"   ; 复制
!v::Send "^v"   ; 粘贴
!x::Send "^x"   ; 剪切
!z::Send "^z"   ; 撤销
!y::Send "^y"   ; 重做
!t::Send "^t"   ; 新标签页
!n::Send "^n"   ; 新建
!o::Send "^o"   ; 打开
!p::Send "^p"   ; 打印
!w::Send "^w"   ; 关闭标签页
!q::Send "^q"   ; 退出

; ---------- 浏览器刷新（仅 Edge / Chrome 前台时生效） ----------
#HotIf WinActive("ahk_exe msedge.exe")
!r::Send "^r"
#HotIf

#HotIf WinActive("ahk_exe chrome.exe")
!r::Send "^r"
#HotIf

; ---------- 微信专用：消除 Alt 菜单掩码竞态（避免偶发"Alt 没释放"） ----------
; 微信(Chromium 内核) 对 AHK 自动注入的 menu mask Ctrl 敏感，会与热键体 Send "^x" 的 Ctrl
; 在修饰键状态机里竞态，偶发残留 Alt/Ctrl 状态 → 表现"Alt 没释放"。这里发送前先 {Alt up}，
; 让 AHK 检测到 Alt 已释放、不再补注入掩码 Ctrl，消除竞态。
; 仅微信窗口生效（本块在全局 Alt+字母定义之后）；其它窗口仍走上方全局定义（不加 {Alt up}），互不影响。
#HotIf WinActive("ahk_exe Weixin.exe") || WinActive("微信")
!a::Send "{Alt up}^a"   ; 全选
!c::Send "{Alt up}^c"   ; 复制
!x::Send "{Alt up}^x"   ; 剪切
!v::Send "{Alt up}^v"   ; 粘贴
!s::Send "{Alt up}^s"   ; 保存
!z::Send "{Alt up}^z"   ; 撤销
!y::Send "{Alt up}^y"   ; 重做
!Enter::Send "^{Enter}" ; 发送
#HotIf

; ---------- Alt+←/→ 跳到行首/行尾（macOS ⌘←/→ 习惯） ----------
; 排除 Edge/Chrome（Alt+←/→ 是后退/前进）与资源管理器（Alt+← 是后退），保留其原生行为；
; 其余程序（VS Code、记事本、输入框等）里 Alt+方向键 = Home/End，即行首/行尾。
#HotIf !WinActive("ahk_exe msedge.exe") && !WinActive("ahk_exe chrome.exe") && !WinActive("ahk_exe Explorer.exe")
!Left::Send "{Home}"    ; 行首
!Right::Send "{End}"    ; 行尾
#HotIf

; ---------- Alt+Shift+←/→ 按单词选中（macOS ⌥+Shift+←/→ 习惯） ----------
; 与上一节同样的排除逻辑；Win 里"按单词选中"即 Ctrl+Shift+←/→，每按一次扩展一个单词。
#HotIf !WinActive("ahk_exe msedge.exe") && !WinActive("ahk_exe chrome.exe") && !WinActive("ahk_exe Explorer.exe")
!+Left::Send "^+{Left}"    ; 向左逐词选中
!+Right::Send "^+{Right}"  ; 向右逐词选中
; 选中到行首/行尾改用三键组合 Alt+Ctrl+Shift+←/→（对应 macOS ⌘+Shift+←/→），
; 与上面逐词选中互不冲突（Ctrl 同时按下时 AHK 不会触发 !+Left 那行）。
!+^Left::Send "+{Home}"    ; 选中到行首
!+^Right::Send "+{End}"    ; 选中到行尾
#HotIf
