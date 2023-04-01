#!/bin/bash

echo "checking for ${SCHEMA_BACPAC}"

if test -f "${SCHEMA_BACPAC}"
then

	echo "Schema exists, waiting for sql server to be ready"

	/wait-for.sh --timeout=60 127.0.0.1:1433 

	echo "starting schema import"
	sleep 5

	/opt/sqlpackage/sqlpackage /a:Import /sf:"${SCHEMA_BACPAC}" /tsn:127.0.0.1 /tdn:db /tu:sa /tp:"${SA_PASSWORD}"

else
	echo "No schema"
fi
