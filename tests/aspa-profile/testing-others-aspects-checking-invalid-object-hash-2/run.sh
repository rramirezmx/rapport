#!/bin/sh

. tools/checks.sh
. rp/$RP.sh

run_barry

truncate -s 19m "sandbox/rsyncd/content/$TEST/ca/valid-1.asa"

run_rp "--http.enabled=false"

check_logfile fort1 -F "valid-1.asa' does not match its manifest hash."

check_vrps
check_aspas \
    "6:[13001,70001,80001]"

stop_rp