#! /usr/bin/env bash
set -e

export STELLAR_BIN=/usr/local/bin/horizon
export DATABASE_URL=$HORIZON_DATABASE_URL

function main() {
	echo "stellar-horizon"

	init
  start
}

function init() {
	if db_empty "$DATABASE_URL"; then
    echo "db init: ok"
	  $STELLAR_BIN db init
	fi

  echo "init: ok"
}

function start() {
  echo "starting..."
  exec $STELLAR_BIN
}

function db_empty() {
	psql "$1" -c "\dt" | grep "No relations" > /dev/null
}

main $@
