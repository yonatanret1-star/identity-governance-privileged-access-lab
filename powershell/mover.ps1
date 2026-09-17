Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

$UPN = "james.wilson@yonjon0011gmail.onmicrosoft.com"

$User = Get-MgUser -UserId $UPN

# Update the user's job title
Update-MgUser `
    -UserId $User.Id `
    -JobTitle "Help Desk Analyst"

Write-Host "Updated job title to Help Desk Analyst"

# Groups to remove because James is no longer a Cloud Engineer
$RemoveGroups = @(
    "SG-Cloud-Engineers",
    "SG-AWS-Developers"
)

# Group to add for the new role
$AddGroups = @(
    "SG-HelpDesk"
)

foreach ($GroupName in $RemoveGroups) {

    $Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

    Remove-MgGroupMemberByRef `
        -GroupId $Group.Id `
        -DirectoryObjectId $User.Id

    Write-Host "Removed $UPN from $GroupName"
}

foreach ($GroupName in $AddGroups) {

    $Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

    New-MgGroupMember `
        -GroupId $Group.Id `
        -DirectoryObjectId $User.Id

    Write-Host "Added $UPN to $GroupName"
}