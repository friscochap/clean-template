$app_name = $args[0]

if ([string]::IsNullOrEmpty($app_name)) {
    $curPath = get-item . | Split-Path -Leaf
    "No application name specified. Use " + $curPath + "?"
    "[Y] Yes, [N] No (default is 'N')"
    $continue = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    ""

    if ('Y' -eq [char]::ToUpper($continue.Character)) {
        $app_name = $curPath
    }
    else  {
    "Specify a new name for the executable:"
    "    .\init.ps1 " + $curPath
    }
}
if (![string]::IsNullOrEmpty($app_name)) {
    $app_projects = Get-ChildItem .\src -Name
    $sln_contents = Get-Content -path .\CleanArchitecture.sln -Raw
    "Renaming to " + $app_name
    Rename-Item -Path .\CleanArchitecture.sln -NewName .\$app_name.sln

    foreach ($project in $app_projects) {
        $name = ".\src\" + $project + "\" + $project + ".csproj"
        $newName = $app_name + "." + $project + ".csproj"
        $oldProjectName = $project + ".csproj";
        $newProjectName = $app_name + "." + $oldProjectName;

        "Renaming " + $project + " to " + $newName

        Rename-Item -Path $name -NewName $newName

        $sln_contents = $sln_contents -replace $oldProjectName, $newProjectName

        $name = ".\tests\" + $project + "\" + $project + ".Tests.csproj"
        $newName = $app_name + "." + $project + ".Tests.csproj"
        $oldProjectName = $project + ".Tests.csproj";
        $newProjectName = $app_name + "." + $oldProjectName;

        Rename-Item -Path $name -NewName $newName

        $sln_contents = $sln_contents -replace $oldProjectName, $newProjectName
    }

    "Updating solution file " + $app_name.sln
    Set-Content -Path .\$app_name.sln -Value $sln_contents

    "Removing ReadMe.md files..."
    remove-item -Recurse ReadMe.md

    "Application renamed to " + $app_name
}
