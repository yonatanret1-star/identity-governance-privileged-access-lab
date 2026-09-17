Connect-MgGraph -Scopes "User.Read.All","Group.Read.All"

$Users = Get-MgUser -All -Property `
    Id,
    DisplayName,
    UserPrincipalName,
    Department,
    JobTitle,
    AccountEnabled

$Report = @()

foreach ($User in $Users) {

    $Groups = Get-MgUserMemberOfAsGroup -UserId $User.Id -All

    if ($Groups.Count -eq 0) {

        $Report += [PSCustomObject]@{
            DisplayName       = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            Department        = $User.Department
            JobTitle          = $User.JobTitle
            AccountEnabled    = $User.AccountEnabled
            Group             = "None"
        }

    }
    else {

        foreach ($Group in $Groups) {

            $Report += [PSCustomObject]@{
                DisplayName       = $User.DisplayName
                UserPrincipalName = $User.UserPrincipalName
                Department        = $User.Department
                JobTitle          = $User.JobTitle
                AccountEnabled    = $User.AccountEnabled
                Group             = $Group.DisplayName
            }
        }
    }
}

$Report |
    Sort-Object DisplayName, Group |
    Export-Csv "./reports/identity-access-report.csv" -NoTypeInformation

Write-Host "Audit report created: reports/identity-access-report.csv"