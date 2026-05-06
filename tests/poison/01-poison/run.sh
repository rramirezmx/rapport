#!/bin/sh

. tools/checks.sh
. rp/$RP.sh

run_barry rd1

# Hack; fix the hash in the malicious notification's <snapshot>
cp "sandbox/apache2/content/$TEST/good-notification.xml" \
   "sandbox/apache2/content/$TEST/malicious-notification.xml"

start_rp "--rsync.enabled=false"

check_vrps \
	"201::/16-16 => AS1234" \
	"2.1.0.0/16-16 => AS1234"

stop_rp


