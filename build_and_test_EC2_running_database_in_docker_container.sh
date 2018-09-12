#!/usr/bin/env bash

# create the test infrasctucture
cd terraform
terraform apply -auto-approve
export SQLSVR=$(echo `terraform output sqlsvr_dns`)
cd ..

echo Give MSSQLSVR a minute to get online
sleep 60

echo Run our unit tests in lieu of some real smoke tests
sqlcmd -S $SQLSVR,1433 -U SA -P 'Strong!Passw0rd' -Q "EXEC tSQLt.RunAll"
