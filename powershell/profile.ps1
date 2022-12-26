
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\ProgramData\Miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

$colors = @{}
$colors['Variable'] = [System.ConsoleColor]::DarkCyan
$colors['Member'] = [System.ConsoleColor]::Blue
$colors['Command'] = [System.ConsoleColor]::Blue
$colors['Number'] = [System.ConsoleColor]::DarkGreen
$colors['None'] = [System.ConsoleColor]::Black
$colors['Parameter'] = [System.ConsoleColor]::DarkGray
$colors['Keyword'] = [System.ConsoleColor]::DarkMagenta
$colors['Type'] = [System.ConsoleColor]::DarkBlue
$colors['String'] = [System.ConsoleColor]::DarkGreen
$colors['Operator'] = [System.ConsoleColor]::DarkGray