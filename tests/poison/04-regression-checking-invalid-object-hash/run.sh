#!/bin/sh

. tools/checks.sh
. rp/$RP.sh

run_barry rd1

start_rp "--http.enabled=false" "--server.interval.validation" "60"

check_vrps \
	"2.1.0.0/24-24 => AS20001" \
	"2.1.1.0/24-24 => AS20001" \
    "3.1.0.0/24-24 => AS30001" \
    "3.1.1.0/24-24 => AS30001"

create_delta rd2

rm "sandbox/rsyncd/content/$TEST/ca/valid-1-2.roa"

sleep 65
# Here fort runs second validation cycle.

check_vrps \
	"2.1.0.0/24-24 => AS20001" \
	"2.1.1.0/24-24 => AS20001" \
    "3.1.0.0/24-24 => AS30001" \
    "3.1.1.0/24-24 => AS30001" \
    "4.1.0.0/24-24 => AS40001" \
    "4.1.1.0/24-24 => AS40001"

stop_rp