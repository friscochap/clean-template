# Clean Architecture Template

A .NET Core folder layout with initial projects that can be used when creating an application in support of the Clean Architecture approach to software development. Projects have been defined to help better distribute the code and their responsibilities into smaller chunks that can then be developed and tested independent of the rest of the application.

Projects reside under the src folder and were created using the following dotnet commands:

    dotnet new classlib -o src\Application
    dotnet new classlib -o src\Common
    dotnet new classlib -o src\Core
    dotnet new classlib -o src\Domain
    dotnet new classlib -o src\Infrastructure
    dotnet new classlib -o src\Persistance
    dotnet new webapi   -o src\WebApi
    dotnet new webapp   -o src\WebApp
    dotnet new console  -o src\Console

An mstest unit test project for each of the above projects was also created under the tests folder with ".Test" added to the end of the project name:

    dotnet new mstest -o tests\Application.Test
    dotnet new mstest -o tests\Common.Test
    dotnet new mstest -o tests\Core.Test
    dotnet new mstest -o tests\Domain.Test
    dotnet new mstest -o tests\Infrastructure.Test
    dotnet new mstest -o tests\Persistance.Test
    dotnet new mstest -o tests\WebApi.Test
    dotnet new mstest -o tests\WebApp.Test
    dotnet new mstest -o tests\Console.Test
