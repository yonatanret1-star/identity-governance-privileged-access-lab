Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"

$UserName = "Rye Sue"
$GroupName = "SG-Privileged-Admins"

$User = Get-MgUser -Filter "displayName eq '$UserName'"
$Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

Write-Host "Privileged Access Review"
Write-Host "User: $($User.DisplayName)"
Write-Host "Privileged Group: $($Group.DisplayName)"

$Members = Get-MgGroupMember -GroupId $Group.Id -All

$IsMember = $Members.Id -contains $User.Id

if ($IsMember) {
    Write-Host "Status: User currently has privileged group membership"
}
else {
    Write-Host "Status: User does not have privileged group membership"
}