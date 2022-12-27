#------------------------------- Import Modules BEGIN -------------------------------
# 引入 posh-git
# Import-Module posh-git

# 引入 ps-read-line
Import-Module PSReadLine

# 设置 PowerShell 主题
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\M365Princess.omp.json" | Invoke-Expression 
Write-Host "As The Stars Fall." -ForegroundColor Magenta -BackgroundColor DarkBlue

#------------------------------- Import Modules END   -------------------------------



#-------------------------------  Set Hot-keys BEGIN  -------------------------------
# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History

# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# 设置 Ctrl+d 为退出 PowerShell
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit

#-------------------------------  Set Hot-keys END    -------------------------------


#-------------------------------   Set Alias BEGIN    -------------------------------
# 1. 编译函数 make
function MakeThings {
	nmake.exe $args -nologo
}
Set-Alias -Name make -Value MakeThings

# 2. 更新系统 os-update
Set-Alias -Name os-update -Value Update-Packages

# 3. 查看目录 ls & ll
function ListDirectory {
	(Get-ChildItem).Name
	Write-Host("")
}
Set-Alias -Name ls -Value ListDirectory
Set-Alias -Name ll -Value Get-ChildItem

# 4. 打开当前工作目录
# OpenCurrentFolder
function ocf {
	param
	(
		# 输入要打开的路径
		# 用法示例：open C:\
		# 默认路径：当前工作文件夹
		$Path = '.'
	)
	Invoke-Item $Path
}
Set-Alias -Name open -Value ocf

# Set-Alias lvim 'C:\Users\Asthestarsfall\.local\bin\lvim.ps1'

Set-Alias lvim 'C:\Users\Asthestarsfall\.local\bin\lvim.ps1'
Set-Alias vim 'C:\Users\Asthestarsfall\.local\bin\vim.ps1'

function md5 {
	Get-FileHash -Algorithm md5 $args
}
Set-Alias -Name md5sum -Value md5
#-------------------------------    Set Alias END     -------------------------------
