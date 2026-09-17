Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

$UPN = "james.wilson@yonjon0011gmail.onmicrosoft.com"

$User = Get-MgUser -UserId $UPN

# Disable the account
Update-MgUser `
    -UserId $User.Id `
    -AccountEnabled:$false

Write-Host "Disabled account: $UPN"

# Revoke active sign-in sessions
Revoke-MgUserSignInSession -UserId $User.Id

Write-Host "Revoked sign-in sessions"

# Remove the user from all current groups
$Memberships = Get-MgUserMemberOf -UserId $User.Id

foreach ($Membership in $Memberships) {

    try {
        Remove-MgGroupMemberByRef `
            -GroupId $Membership.Id `
            -DirectoryObjectId $User.Id

        Write-Host "Removed user from group $($Membership.Id)"
    }
    catch {
        Write-Host "Skipped membership $($Membership.Id)"
    }
}