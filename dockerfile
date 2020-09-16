FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS base
WORKDIR /app

WORKDIR /sourcecode
COPY ./ProtoActor.Docker.sln ./
COPY ./src ./src/
copy ./benchmarks ./benchmarks/
RUN ls -la /sourcecode/*
RUN dotnet restore ProtoActor.Docker.sln

WORKDIR /sourcecode/benchmarks/ClusterBenchmark
RUN dotnet build -c Release -o /app

FROM base AS publish

RUN dotnet publish -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ClusterBenchmark.dll", "follow"]