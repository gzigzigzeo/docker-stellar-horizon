#! /usr/bin/env bash
curl http://localhost:$PORT/metrics || exit 1
