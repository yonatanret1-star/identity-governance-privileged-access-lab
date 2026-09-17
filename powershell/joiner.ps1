Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

$DisplayName = "James Wilson"
$UserPrincipalName = "james.wilson@yonjon0011gmail.onmicrosoft.com"
$MailNickname = "james.wilson"
$Department = "IT"
$JobTitle = "Cloud Engineer"

# Prompt for a temporary password instead of storing it in the script
$SecurePassword = Read-Host "Enter temporary password" -AsSecureString
$TempPassword = [System.Net.NetworkCredential]::new("", $SecurePassword).Password

$PasswordProfile = @{
    Password = $TempPassword
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