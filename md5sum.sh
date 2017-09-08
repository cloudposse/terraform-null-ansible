#!/bin/sh
set -ueo pipefail
query_path=$(cat | jq -r '.path')
md5=$(tar -cf - $query_path | md5sum| cut -d' ' -f1)
printf "{\\\"md5\\\":\\\"$md5\\\"}"
