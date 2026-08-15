#Requires AutoHotkey v2.0+

; ============================================
; 全局 Alt+Tab 切换 - AHK v2 版本
; 适用场景：SharpKeys 已将左 Ctrl ↔ 左 Alt 互换
; 物理左 Ctrl+Tab / 物理左 Alt+Tab 均触发系统应用切换
; 浏览器 Ctrl+Tab 切标签功能被全局覆盖，不再生效
; ============================================

; 系统视角说明（因 SharpKeys 已互换）：
; ^ 代表 Ctrl（实际是物理左 Alt）
; ! 代表 Alt（实际是物理左 Ctrl）

; 物理左 Alt + Tab → 系统应用切换器
^Tab::Send "{Alt down}{Tab}{Alt up}"

; 物理左 Ctrl + Tab → 系统应用切换器
!Tab::Send "{Alt down}{Tab}{Alt up}"

; 物理左 Alt + Shift + Tab → 反向切换
^+Tab::Send "{Alt down}{Shift down}{Tab}{Shift up}{Alt up}"

; 物理左 Ctrl + Shift + Tab → 反向切换
!+Tab::Send "{Alt down}{Shift down}{Tab}{Shift up}{Alt up}"


; ============================================
; 可选附加功能（Mac 手感补全，按需取消注释）
; ============================================

; 左 Ctrl + Q → Alt + F4（关闭窗口）
; ^q::Send "!{F4}"

; 左 Ctrl + W → Ctrl + W（关闭标签页，保留原功能）
; ^w::Send "^w"

; 左 Ctrl + 左/右方向键 → Home / End（行首行尾）
; ^Left::Home
; ^Right::End

; 左 Ctrl + Shift + 左/右方向键 → Shift + Home / End（选中至行首行尾）
; ^+Left::Send "+{Home}"
; ^+Right::Send "+{End}"