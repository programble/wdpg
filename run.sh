#!/bin/bash

set -e

for file in sql/??.*.sql; do
  psql -X -v ON_ERROR_STOP=true -e -f $file $@
done
