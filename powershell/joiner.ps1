Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

$DisplayName = "James Wilson"
$UserPrincipalName = "james.wilson@yonjon0011gmail.onmicrosoft.com"
$MailNickname = "james.wilson"
$Department = "IT"
$JobTitle = "Cloud Engineer"

$PasswordProfile = @{
    Password = "TempPass123!ChangeMe"
    ForceChangePasswordNextSignIn = $true
}

$User = New-MgUser `
    -DisplayName $DisplayName `
    -UserPrincipalName $UserPrincipalName `
    -MailNickname $MailNickname `
    -AccountEnabled `
    -PasswordProfile $PasswordProfile `
    -Department $Department `
    -JobTitle $JobTitle

Write-Host "Created user: $DisplayName"

$RequiredGroups = @()

if ($Department -eq "IT" -and $JobTitle -eq "Cloud Engineer") {
    $RequiredGroups = @(
        "SG-IT-Users",
        "SG-Cloud-Engineers",
        "SG-AWS-Developers"
    )
}

foreach ($GroupName in $RequiredGroups) {

    $Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

    New-MgGroupMember `
        -GroupId $Group.Id `
        -DirectoryObjectId $User.Id

    Write-Host "Added $DisplayName to $GroupName"
}