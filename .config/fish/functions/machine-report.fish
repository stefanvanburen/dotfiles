# TR-100 Machine Report, ported to fish for macOS.
#
# Original (bash, Linux): https://github.com/usgraphics/usgc-machine-report
# Copyright © 2024, U.S. Graphics, LLC. BSD-3-Clause License.
#
# The layout is byte-for-byte the original's: a box `$__mr_width + 20` columns
# wide, with the column divider at position 17. Every data source is different,
# though -- macOS has no /proc, no lscpu, no lastlog, and no `uptime -p`.

# Box width is shared by every drawing helper; machine-report sets and erases it.
set -g __mr_width 0

function __mr_head
    set -l w (math $__mr_width + 20)
    printf '┌%s┐\n' (string repeat -n (math $w - 2) ┬)
    printf '├%s┤\n' (string repeat -n (math $w - 2) ┴)
end

function __mr_rule -a left mid right
    set -l w (math $__mr_width + 20)
    printf '%s%s%s%s%s\n' $left (string repeat -n 15 ─) $mid \
        (string repeat -n (math $w - 18) ─) $right
end

function __mr_center -a text
    set -l w (math $__mr_width + 18)
    set -l len (string length -- $text)
    set -l lpad (math -s0 "floor(($w - $len) / 2)")
    # Pad left then right, rather than string repeat: repeating zero times
    # produces no output at all, which would eat a printf argument.
    printf '│%s│\n' (string pad -r -w $w -- (string pad -w (math $lpad + $len) -- $text))
end

function __mr_row -a name data
    if test (string length -- $name) -gt 13
        set name (string sub -l 10 -- $name)...
    end
    if test (string length -- $data) -gt $__mr_width
        set data (string sub -l (math $__mr_width - 3) -- $data)...
    end
    printf '│ %-13s │ %s │\n' $name (string pad -r -w $__mr_width -- $data)
end

function __mr_bar -a used total
    set -l blocks 0
    if test "$total" != 0
        set blocks (math -s0 "floor(min($used / $total, 1) * $__mr_width)")
    end
    set -l filled ""
    test $blocks -gt 0; and set filled (string repeat -n $blocks █)
    string pad -r -w $__mr_width -- $filled | string replace -a ' ' ░
end

function machine-report -d 'TR-100 machine report'
    set -l report_title "UNITED STATES GRAPHICS COMPANY"

    # -- Operating system ---------------------------------------------------
    set -l os_name (sw_vers -productName)" "(sw_vers -productVersion)" ("(sw_vers -buildVersion)")"
    set -l os_kernel (uname)" "(uname -r)
    set -l hw_model (sysctl -n hw.model)

    # -- Network ------------------------------------------------------------
    set -l net_current_user (whoami)
    set -l net_hostname (hostname -f 2>/dev/null)
    test -n "$net_hostname"; or set net_hostname "Not Defined"

    # Ask the routing table which interface actually carries traffic: en0 is
    # Wi-Fi on laptops but Ethernet on desktops, and neither wins over a VPN.
    set -l net_machine_ip
    set -l default_if (route -n get default 2>/dev/null | awk '/interface:/ {print $2; exit}')
    if test -n "$default_if"
        set net_machine_ip (ipconfig getifaddr $default_if 2>/dev/null)
        test -n "$net_machine_ip"; or set net_machine_ip \
            (ifconfig $default_if 2>/dev/null | awk '/inet6 / && $2 !~ /^fe80/ {print $2; exit}')
    end
    test -n "$net_machine_ip"; or set net_machine_ip "No IP found"

    set -l net_client_ip (who am i 2>/dev/null | sed -n 's/.*(\(.*\)).*/\1/p')
    test -n "$net_client_ip"; or set net_client_ip "Not connected"

    # scutil reports each resolver's servers, and the same server appears under
    # several resolvers; keep first-seen order and show at most three.
    set -l net_dns_ip
    set -l net_dns_v6
    for ip in (scutil --dns 2>/dev/null | awk '/nameserver\[[0-9]+\]/ {print $3}')
        if string match -q '*:*' -- $ip
            contains -- $ip $net_dns_v6; or set -a net_dns_v6 $ip
        else
            contains -- $ip $net_dns_ip; or set -a net_dns_ip $ip
        end
    end
    set -a net_dns_ip $net_dns_v6
    set net_dns_ip $net_dns_ip[1..(math "min(3, "(count $net_dns_ip)")")]

    # -- CPU ----------------------------------------------------------------
    set -l cpu_model (sysctl -n machdep.cpu.brand_string)
    set -l cpu_cores (sysctl -n hw.logicalcpu)
    set -l cpu_sockets (sysctl -n hw.packages 2>/dev/null)
    test -n "$cpu_sockets"; or set cpu_sockets 1

    # Apple silicon splits its cores into performance and efficiency levels,
    # which is more interesting than the socket count (always 1).
    set -l cpu_topology "$cpu_cores vCPU(s) / $cpu_sockets Socket(s)"
    set -l p_cores (sysctl -n hw.perflevel0.logicalcpu 2>/dev/null)
    set -l e_cores (sysctl -n hw.perflevel1.logicalcpu 2>/dev/null)
    if test -n "$p_cores" -a -n "$e_cores"
        set cpu_topology (printf '%s Core(s) / %dP + %dE' $cpu_cores $p_cores $e_cores)
    end

    set -l cpu_hypervisor "Bare Metal"
    test (sysctl -n kern.hv_vmm_present 2>/dev/null; or echo 0) -eq 1
    and set cpu_hypervisor "Virtual Machine"

    # Intel Macs expose a nominal clock; Apple silicon does not (only
    # powermetrics knows, and it needs root), so the row is dropped there.
    set -l cpu_freq (sysctl -n hw.cpufrequency_max 2>/dev/null)
    test -n "$cpu_freq"; and set cpu_freq (printf '%.2f' (math "$cpu_freq / 1000000000"))

    set -l load (sysctl -n vm.loadavg | string trim -c '{} ' | string split ' ')

    # -- Memory -------------------------------------------------------------
    # "Used" here matches Activity Monitor's Memory Used: anonymous pages that
    # are resident, wired, or compressed. Inactive and speculative pages are
    # reclaimable on demand, so they count as free.
    set -l mem_total (sysctl -n hw.memsize)
    set -l mem_used (vm_stat | awk -v ps=(sysctl -n hw.pagesize) '
        /Pages active/                 { gsub(/\./, "", $3); a = $3 }
        /Pages wired down/             { gsub(/\./, "", $4); w = $4 }
        /Pages occupied by compressor/ { gsub(/\./, "", $5); c = $5 }
        END { printf "%d", (a + w + c) * ps }')
    set -l mem_percent (printf '%.2f' (math "$mem_used / $mem_total * 100"))
    set -l mem_total_gb (printf '%.2f' (math "$mem_total / 1024^3"))
    set -l mem_used_gb (printf '%.2f' (math "$mem_used / 1024^3"))

    # -- Disk ---------------------------------------------------------------
    # On APFS every volume in the container reports the container's size, so
    # "used" has to come from total minus available or the sealed system volume
    # would claim the whole Mac is 15% full.
    set -l disk_mount /System/Volumes/Data
    test -d $disk_mount; or set disk_mount /
    set -l disk_stats (df -k $disk_mount | awk 'NR==2 {print $2; print $4}')
    set -l disk_total $disk_stats[1]
    set -l disk_used (math $disk_total - $disk_stats[2])
    set -l disk_total_gb (printf '%.2f' (math "$disk_total / 1024^2"))
    set -l disk_used_gb (printf '%.2f' (math "$disk_used / 1024^2"))
    set -l disk_percent (printf '%.2f' (math "$disk_used / $disk_total * 100"))

    # -- Last login and uptime ----------------------------------------------
    # macOS has no lastlog(8). `last` pads its columns, and the host column is
    # empty for console logins, so anchor the parse on the weekday instead.
    set -l last_login (last -1 $net_current_user 2>/dev/null | head -n1 | awk '
        { for (i = 1; i <= NF; i++)
              if ($i ~ /^(Mon|Tue|Wed|Thu|Fri|Sat|Sun)$/) {
                  if (i > 3) print $(i - 1); else print ""
                  printf "%s %s %s %s\n", $i, $(i+1), $(i+2), $(i+3)
                  exit
              } }')
    set -l last_login_ip $last_login[1]
    set -l last_login_time $last_login[2]
    test -n "$last_login_time"; or set last_login_time "Never logged in"

    set -l boot (sysctl -n kern.boottime | awk '{gsub(/,/, ""); print $4}')
    set -l up (math (date +%s) - $boot)
    set -l sys_uptime (printf '%dd %dh %dm' \
        (math -s0 "floor($up / 86400)") \
        (math -s0 "floor($up % 86400 / 3600)") \
        (math -s0 "floor($up % 3600 / 60)"))

    # -- Layout -------------------------------------------------------------
    # The box is as wide as its widest datum, capped at 32 columns. Bar graphs
    # are excluded: they are sized to the result, not an input to it.
    set -g __mr_width 0
    for datum in $report_title $os_name $os_kernel $hw_model $net_hostname \
        $net_machine_ip $net_client_ip $net_dns_ip $net_current_user \
        $cpu_model $cpu_topology $cpu_hypervisor "$cpu_freq GHz" \
        "$disk_used_gb/$disk_total_gb GB [$disk_percent%]" \
        "$mem_used_gb/$mem_total_gb GiB [$mem_percent%]" \
        $last_login_time $last_login_ip $sys_uptime

        set -l len (string length -- $datum)
        test $len -gt $__mr_width; and set -g __mr_width $len
    end
    test $__mr_width -gt 32; and set -g __mr_width 32

    # -- Report -------------------------------------------------------------
    __mr_head
    __mr_center $report_title
    __mr_center "TR-100 MACHINE REPORT"
    __mr_rule ├ ┬ ┤
    __mr_row OS $os_name
    __mr_row KERNEL $os_kernel
    __mr_row MODEL $hw_model
    __mr_rule ├ ┼ ┤
    __mr_row HOSTNAME $net_hostname
    __mr_row "MACHINE IP" $net_machine_ip
    __mr_row "CLIENT  IP" $net_client_ip
    for i in (seq (count $net_dns_ip))
        __mr_row "DNS  IP $i" $net_dns_ip[$i]
    end
    __mr_row USER $net_current_user
    __mr_rule ├ ┼ ┤
    __mr_row PROCESSOR $cpu_model
    __mr_row CORES $cpu_topology
    __mr_row HYPERVISOR $cpu_hypervisor
    test -n "$cpu_freq"; and __mr_row "CPU FREQ" "$cpu_freq GHz"
    __mr_row "LOAD  1m" (__mr_bar $load[1] $cpu_cores)
    __mr_row "LOAD  5m" (__mr_bar $load[2] $cpu_cores)
    __mr_row "LOAD 15m" (__mr_bar $load[3] $cpu_cores)
    __mr_rule ├ ┼ ┤
    __mr_row VOLUME "$disk_used_gb/$disk_total_gb GB [$disk_percent%]"
    __mr_row "DISK USAGE" (__mr_bar $disk_used $disk_total)
    __mr_rule ├ ┼ ┤
    __mr_row MEMORY "$mem_used_gb/$mem_total_gb GiB [$mem_percent%]"
    __mr_row USAGE (__mr_bar $mem_used $mem_total)
    __mr_rule ├ ┼ ┤
    __mr_row "LAST LOGIN" $last_login_time
    test -n "$last_login_ip"; and __mr_row "" $last_login_ip
    __mr_row UPTIME $sys_uptime
    __mr_rule └ ┴ ┘

    set -e -g __mr_width
end
