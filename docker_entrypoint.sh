#! /usr/bin/env bash
set -o errexit
set -o pipefail

if psql "$DATABASE_URL" -c "\dt" | grep "No relations" > /dev/null; then
	horizon db init
fi

exec "$@"
