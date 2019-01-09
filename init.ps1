$app_name = $args[0]
$app_projects = Get-ChildItem .\src -Name
$sln_contents = Get-Content -path .\CleanArchitecture.sln -Raw
$message = "Renaming to " + $app_name
Write-Output $message
Rename-Item -Path .\CleanArchitecture.sln -NewName .\$app_name.sln
foreach ($project in $app_projects) {
    $name = ".\src\" + $project + "\" + $project + ".csproj"
    $newName = $app_name + "." + $project + ".csproj"
    $message = "Renaming " + $name + " to " + $newName
    $oldProjectName = $project + ".csproj";
    $newProjectName = $app_name + "." + $oldProjectName;

    Write-Output $message

    Rename-Item -Path $name -NewName $newName

    $sln_contents = $sln_contents -replace $oldProjectName, $newProjectName

    $name = ".\tests\" + $project + "\" + $project + ".Tests.csproj"
    $newName = $app_name + "." + $project + ".Tests.csproj"
    $oldProjectName = $project + ".Tests.csproj";
    $newProjectName = $app_name + "." + $oldProjectName;

    Rename-Item -Path $name -NewName $newName

    $sln_contents = $sln_contents -replace $oldProjectName, $newProjectName
}

$message = "Updating solution file " + $app_name.sln
Write-Output $message
Set-Content -Path .\$app_name.sln -Value $sln_contents

$message = "Application renamed to " + $app_name
Write-Output $message

