Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"

$UserName = "Rye Sue"
$GroupName = "SG-Privileged-Admins"

$User = Get-MgUser -Filter "displayName eq '$UserName'"
$Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

Write-Host "Temporary Privileged Access Workflow"
Write-Host "User: $UserName"

# Grant temporary privileged group membership
New-MgGroupMember `
    -GroupId $Group.Id `
    -DirectoryObjectId $User.Id `
    -ErrorAction SilentlyContinue

Write-Host "Privileged access activated"

Write-Host "Press ENTER to expire the temporary access..."
Read-Host

# Remove privileged access
Remove-MgGroupMemberByRef `
    -GroupId $Group.Id `
    -DirectoryObjectId $User.Id

Write-Host "Privileged access expired and was removed"