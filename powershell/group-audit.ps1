Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"

$UserName = "Adam Patton"
$GroupName = "SG-AWS-Developers"

$User = Get-MgUser -Filter "displayName eq '$UserName'"
$Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

Write-Host "Access Review"
Write-Host "User: $($User.DisplayName)"
Write-Host "Group: $($Group.DisplayName)"
Write-Host "Decision: Remove access"

Remove-MgGroupMemberByRef `
    -GroupId $Group.Id `
    -DirectoryObjectId $User.Id

Write-Host "Remediation complete: $UserName removed from $GroupName"