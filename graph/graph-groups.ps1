Connect-MgGraph -Scopes "Group.Read.All"

Get-MgGroup -All |
Select-Object DisplayName, Id |
Sort-Object DisplayName |
Format-Table -AutoSize