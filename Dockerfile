FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /src
COPY src/*.csproj .
# Restore as distinct layers
RUN dotnet restore
COPY src .
# Build and publish a release
RUN dotnet publish -c Release -o /publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /publish
COPY  --from=build-env /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "AmonyCoffeeMIS.dll"]