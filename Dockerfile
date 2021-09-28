FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY ./*.sln .
COPY ./ConversaoPeso.Web/*.csproj ./ConversaoPeso.Web/
RUN dotnet restore

# copy everything else and build app
COPY ./ConversaoPeso.Web/. ./ConversaoPeso.Web/
WORKDIR /source/ConversaoPeso.Web
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]