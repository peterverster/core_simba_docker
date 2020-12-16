FROM mcr.microsoft.com/dotnet/aspnet:5.0

# Update and install unixodbc (ODBC driver manager)
RUN apt-get update
RUN apt-get -y install unixodbc

# Copy and install Simba Spark driver
COPY simbaspark_2.6.16.1019-2_amd64.deb /simbaspark_2.6.16.1019-2_amd64.deb
RUN apt-get -y install /simbaspark_2.6.16.1019-2_amd64.deb

# Copy ODBC manager configuration file
COPY odbcinst.ini /etc/

# Copy .env
COPY .env /.env

# Append environment variables to .bashrc, .bash_profile and .profile
# TODO: Do we really need to do this?
RUN cat /.env >> /root/.bashrc
RUN cat /.env >> /root/.bash_profile
RUN cat /.env >> /root/.profile
