#!/bin/bash
set -euo pipefail
user_agent_flag=0
method_flag=0
remove_logs() {
  rm -r logs
}
trap remove_logs EXIT

while [[ $# -gt 0 ]]; do
    case "$1" in
        --user-agent)
            if [[ $# -lt 2 ]]; then
                echo "Error: --user-agent option requires an argument."
                exit 2
            fi
            user_agent_flag=1
            user_agent=$2
            shift 2
            ;;
        --method)
            method_flag=1
            shift
            ;;
    esac
done

tar -xf logs.tar.bz2

if [[ "$method_flag" -eq 1 ]]
then
  printf "%-30s %-30s %-30s\n" "ADDRESS" "METHOD" "REQUESTS"
  awk_printf_command='"%-30s %-30s %-30s\n", $2, $3, $1'
  awk_command='if ($12) print $12" "$4; else print "missing_ip "$4'

else
  printf "%-30s %-30s\n" "ADDRESS" "REQUESTS"
  awk_printf_command='"%-30s %-30s\n", $2, $1'
  awk_command='if ($12) print $12; else print "missing_ip"'
fi

if [[ "$user_agent_flag" -eq 1 ]]
then
  grep "$user_agent" ./logs/logs.log | awk -F\" "{$awk_command}" | sort | uniq -c | awk "{printf $awk_printf_command}"
else
  awk -F\" "{$awk_command}" ./logs/logs.log | sort | uniq -c | awk "{printf $awk_printf_command}"
fi