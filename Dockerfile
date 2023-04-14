FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

WORKDIR /app

EXPOSE 80

EXPOSE 443

 

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /src

COPY ["BlazorServerDocker4.csproj", "."]

RUN dotnet restore "BlazorServerDocker4.csproj"

COPY . .

RUN dotnet build "BlazorServerDocker4.csproj" -c Release -o /app/build

 

FROM build AS publish

RUN dotnet publish "BlazorServerDocker4.csproj" -c Release -o /app/publish

 

FROM base AS final

WORKDIR /app

COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "BlazorServerDocker4.dll"]
