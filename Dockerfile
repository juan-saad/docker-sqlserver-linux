# Utilizamos la imagen oficial de Microsoft SQL Server en Linux
FROM mcr.microsoft.com/mssql/server:2022-latest

# Cambiar a usuario root para la instalación de herramientas
USER root

# Instalar curl y configurar repositorios de Microsoft
RUN apt-get -y update && apt-get install -y curl && \
    curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && apt-get install -y mssql-tools18 unixodbc-dev

# Añadir mssql-tools18 al PATH de manera persistente
ENV PATH="$PATH:/opt/mssql-tools18/bin"

# Crear directorio de scripts y copiar el script de inicialización
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# Dar permisos de ejecución a los scripts
RUN chmod +x /usr/src/app/entrypoint.sh /usr/src/app/configure-db.sh

# Exponer el puerto para SQL Server
EXPOSE 1433

# Cambiar a usuario mssql para ejecutar SQL Server
USER mssql

# Configuración inicial del contenedor
ENTRYPOINT ["./entrypoint.sh"]
