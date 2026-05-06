#!/bin/sh

. tools/checks.sh
. rp/$RP.sh

run_barry rd1
#start_rp "--rsync.enabled=false" "--server.interval.validation" "60"
start_rp "--server.interval.validation" "60"

check_vrps \
	"2.1.0.0/24-24 => AS20001" \
	"2.1.1.0/24-24 => AS20001" \
    "3.1.0.0/24-24 => AS30001" \
    "3.1.1.0/24-24 => AS30001"

create_delta rd2

sleep 65

check_logfile fort1 -F "valid-1-2.roa: Signed Object's signature is invalid"

check_vrps \
	"2.1.0.0/24-24 => AS20001" \
	"2.1.10.0/24-24 => AS20001" \
    "3.1.0.0/24-24 => AS30001" \
    "3.1.1.0/24-24 => AS30001" \
    "4.1.0.0/24-24 => AS40001" \
    "4.1.1.0/24-24 => AS40001"

stop_rp