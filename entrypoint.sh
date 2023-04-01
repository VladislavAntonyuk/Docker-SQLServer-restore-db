#!/bin/bash

/import.sh &
exec /opt/mssql/bin/sqlservr --accept-eula
