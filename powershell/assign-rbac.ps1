Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"

$Assignments = @{
    "Adam Patton" = @(
        "SG-IT-Users",
        "SG-Cloud-Engineers",
        "SG-AWS-Developers"
    )

    "Dame Irving" = @(
        "SG-IT-Users",
        "SG-HelpDesk"
    )

    "John  Smith" = @(
        "SG-Finance-Users",
        "SG-Finance-Analysts",
        "SG-AWS-ReadOnly"
    )

    "Ron Jones" = @(
        "SG-HR-Users",
        "SG-HR-Analysts"
    )

    "Rye Sue" = @(
        "SG-IT-Users",
        "SG-Privileged-Admins"
    )
}

foreach ($UserName in $Assignments.Keys) {

    $User = Get-MgUser -Filter "displayName eq '$UserName'"

    foreach ($GroupName in $Assignments[$UserName]) {

        $Group = Get-MgGroup -Filter "displayName eq '$GroupName'"

        New-MgGroupMember `
            -GroupId $Group.Id `
            -DirectoryObjectId $User.Id

        Write-Host "Added $UserName to $GroupName"
    }
}