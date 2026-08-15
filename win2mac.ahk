#SingleInstance Force
 ;无环境变量
#NoEnv
 
#MenuMaskKey vkE8

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
SendInput, {Alt up}^s
Return

!a::
SendInput, {Alt up}^a
Return

!c::
SendInput, {Alt up}^c
Return

!v::
SendInput, {Alt up}^v
Return

!x::
SendInput, {Alt up}^x
Return

!z::
SendInput, {Alt up}^z
Return

!t::
SendInput, {Alt up}^t
Return

!n::
SendInput, {Alt up}^n
Return

!o::
SendInput, {Alt up}^o
Return

!p::
SendInput, {Alt up}^p
Return

!y::
SendInput, {Alt up}^y
Return

!w::
SendInput, {Alt up}^w
Return

!q::
SendInput, {Alt up}^q
Return

; ========== Microsoft Edge浏览器刷新 ==========
#IfWinActive ahk_exe msedge.exe
  !r::SendInput {Alt up}^r  ; Alt+R = 刷新页面（Chrome）
#IfWinActive

; ========== Google Chrome浏览器刷新 ==========
#IfWinActive ahk_exe chrome.exe
  !r::SendInput {Alt up}^r  ; Alt+R = 刷新页面（Chrome）
#IfWinActive


; ========== 微信 Alt+Enter 发送消息，方式1 ==========
#If WinActive("ahk_exe Weixin.exe") || WinActive("微信")
!Enter::
SendInput {Alt up}^{Enter}
return
#If


; ========== Alt+方向键：行首/行尾 ==========
#If !WinActive("ahk_exe msedge.exe") && !WinActive("ahk_exe chrome.exe") && !WinActive("ahk_exe Explorer.exe")
!Left::SendInput, {Alt up}{Home}
!Right::SendInput, {Alt up}{End}
#If


; ========== 微信 Alt+Enter 发送消息，方式2 ==========
;#IfWinActive ahk_exe Weixin.exe
;!Enter::
;Send {Ctrl down}{Enter}{Ctrl up}
;return
;#IfWinActive
