#!/usr/bin/env bash

echo Stop current sqlsvrtest Docker container
sudo -S <<< "password" docker stop sqlsvrtest

echo Remove current sqlsvrtest Docker container
sudo -S <<< "password" docker rm sqlsvrtest

echo Create a fresh Docker sqlsvrtest container
echo Starting microsoft/mssql-server-linux:latest in Docker container
sudo -S <<< "password" sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Strong!Passw0rd' \
   -p 1433:1433 --name sqlsvrtest \
   -d microsoft/mssql-server-linux:latest

echo Pause 10 seconds to allow SQL Server to start up
sleep 10

echo Install tSQLt
mkdir -p target/tSQLt
sqlcmd -S localhost,1433 -U SA -P 'Strong!Passw0rd' -Q "ALTER DATABASE master SET TRUSTWORTHY ON;"
sqlcmd -S localhost,1433 -U SA -P 'Strong!Passw0rd' -i "tSQLt/tSQLt.class.sql" -o "target/tSQLt/Sales_Database_tSQLt_Install.txt"

echo Create database
liquibase --changeLogFile=src/test/db/changelog-with-unit-tests.xml update

echo Run the tSQLt unit tests
sqlcmd -S localhost,1433 -U SA -P 'Strong!Passw0rd' -Q "sp_configure @configname=clr_enabled, @configvalue=1"
sqlcmd -S localhost,1433 -U SA -P 'Strong!Passw0rd' -Q "RECONFIGURE"
sqlcmd -S localhost,1433 -U SA -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"

echo Make sure that the unit tests ran
sqlcmd -S localhost,1433 -U SA -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"

echo Commit the Docker SQLSVR container as a Docker image
sudo docker commit -a howarddeiner -m "finsihed provisioning" sqlsvrtest howarddeiner/sqlsvrtest:releasecopy

echo Authenticate to Docker Hub
sudo docker login

echo Push the Docker SQLSVR release image to the Docker Hub registry
sudo docker push howarddeiner/sqlsvrtest:releasecopy