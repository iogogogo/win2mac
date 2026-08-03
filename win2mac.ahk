#SingleInstance Force
 ;无环境变量
#NoEnv
 
SetCapsLockState, AlwaysOff  
SetStoreCapslockMode,Off
 
;高进程
Process Priority,,High

CapsLock::
KeyWait, CapsLock, T0.3
If ErrorLevel {
    SetCapsLockState, On
    KeyWait, CapsLock
} else {
    Send, {ctrl down}{space}{ctrl up}
}
Return

Shift::
SetCapsLockState, Off
Return

!s::
Send, ^s
Return

!a::
Send, ^a
Return

!c::
Send, ^c
Return

!v::
Send, ^v
Return

!x::
Send, ^x
Return

!z::
Send, ^z
Return

!t::
Send, ^t
Return

!n::
Send, ^n
Return

!o::
Send, ^o
Return

!p::
Send, ^p
Return

!y::
Send, ^y
Return

!w::
Send, ^w
Return

!q::
Send, ^q
Return

; ========== Microsoft Edge浏览器刷新 ==========
#IfWinActive ahk_exe msedge.exe
  !r::Send ^r  ; Alt+R = 刷新页面（Chrome）
#IfWinActive

; ========== Google Chrome浏览器刷新 ==========
#IfWinActive ahk_exe chrome.exe
  !r::Send ^r  ; Alt+R = 刷新页面（Chrome）
#IfWinActive


; ========== 微信 Alt+Enter 发送消息，方式1 ==========
#If WinActive("ahk_exe Weixin.exe") || WinActive("微信")
!Enter::
SendInput ^{Enter}
return
#If


; ========== 微信 Alt+Enter 发送消息，方式2 ==========
;#IfWinActive ahk_exe Weixin.exe
;!Enter::
;Send {Ctrl down}{Enter}{Ctrl up}
;return
;#IfWinActive