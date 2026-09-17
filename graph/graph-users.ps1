Connect-MgGraph -Scopes "User.Read.All"

Get-MgUser -All -Property `
    DisplayName,
    Department,
    JobTitle,
    AccountEnabled |
Select-Object `
    DisplayName,
    Department,
    JobTitle,
    AccountEnabled |
Format-Table -AutoSize