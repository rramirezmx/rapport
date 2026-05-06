#!/bin/sh

# We replaced the signed object with a non-genuine one. 
# This will cause the hash to not match, 
# discarding all objects within the same certificate.
#
# https://www.rfc-editor.org/rfc/rfc9286.txt
# 6.5.  Matching File Names and Hashes
#
#   The RP MUST verify that the hash value of each file listed in the
#   manifest matches the value obtained by hashing the file acquired from
#   the publication point.  If the computed hash value of a file listed
#   on the manifest does not match the hash value contained in the
#   manifest, then the fetch has failed, and the RP MUST respond
#   accordingly.  Proceed to Section 6.6.
#
# 6.6.  Failed Fetches
#
#   If a fetch fails for any of the reasons cited in Sections 6.2 through
#   6.5, the RP MUST issue a warning indicating the reason(s) for
#   termination of processing with regard to this CA instance.  It is
#   RECOMMENDED that a human operator be notified of this warning.
#
#   Termination of processing means that the RP SHOULD continue to use
#   cached versions of the objects associated with this CA instance,
#   until such time as they become stale or they can be replaced by
#   objects from a successful fetch.  This implies that the RP MUST NOT
#   try to acquire and validate subordinate signed objects, e.g.,
#   subordinate CA certificates, until the next interval when the RP is
#   scheduled to fetch and process data for this CA instance.

. tools/checks.sh
. rp/$RP.sh

run_barry

truncate -s 1m "sandbox/rsyncd/content/$TEST/ca/valid-1.asa"

run_rp "--http.enabled=false"

check_logfile fort1 -F "valid-1.asa' does not match its manifest hash."

check_vrps
check_aspas \
    "6:[13001,70001,80001]"

stop_rp