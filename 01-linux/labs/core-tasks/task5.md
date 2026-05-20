# Lab: Task 5 - Text Processing

## Objective

The objective was to gain familiarity with grep, awk, sed, and piping.

## Commands Used

**Search with grep**
```
grep "error" /var/log/syslog
```

**Advanced grep**
```
grep -i "failed" /var/log/auth.log | wc -l  # count failed login attempts
```

**awk examples**
```
ps aux | awk '{print $1, $11}'  # print user and command
cat /etc/passwd | awk -F: '{print $1, $6}'  # print username and home dir
```

**sed examples**
```
sed 's/old/new/g' file.txt  # replace text
sed -n '10,20p' file.txt    # print lines 10-20
```

**Piping chains**
```
cat /var/log/syslog | grep "error" | awk '{print $1, $2, $3}' | sort | uniq
```

## Output

```
➜  ~ grep "error" /var/log/syslog
2026-05-17T12:40:57.069565+01:00 L systemd[1]: apport-autoreport.path - Process error reports when automatic reporting is enabled (file watch) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-17T12:40:57.069573+01:00 L systemd[1]: apport-autoreport.timer - Process error reports when automatic reporting is enabled (timer based) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-18T12:37:26.681159+01:00 L systemd[1]: apport-autoreport.path - Process error reports when automatic reporting is enabled (file watch) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-18T12:37:26.681166+01:00 L systemd[1]: apport-autoreport.timer - Process error reports when automatic reporting is enabled (timer based) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-18T20:52:09.550936+01:00 L systemd[1]: apport-autoreport.path - Process error reports when automatic reporting is enabled (file watch) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-18T20:52:09.550941+01:00 L systemd[1]: apport-autoreport.timer - Process error reports when automatic reporting is enabled (timer based) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-19T01:14:11.898996+01:00 L systemd[1]: apport-autoreport.path - Process error reports when automatic reporting is enabled (file watch) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
2026-05-19T01:14:11.899251+01:00 L systemd[1]: apport-autoreport.timer - Process error reports when automatic reporting is enabled (timer based) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
grep: /var/log/syslog: binary file matches
```


- wc -l counts how many lines the output of the previous command had after the pipe (|). 
```
➜  ~ grep -i "failed" /var/log/auth.log | wc -l 
0
```

- Below, I ran ps aux and the pipe sent that output to the awk command which printed the 1st and 11th parameters. 
- To verify that it was the 1st and 11th, I ran ps aux by itself and 'USER' and 'COMMAND' appeared with more parameters inside.
- Since ps aux provides a snapshot, it does not include the 'awk' command in the second output which ran first.
```
➜  ~ ps aux | awk '{print $1, $11}'
USER COMMAND
root /sbin/init
root /init
root plan9
root /usr/lib/systemd/systemd-journald
root /usr/lib/systemd/systemd-udevd
systemd+ /usr/lib/systemd/systemd-resolved
systemd+ /usr/lib/systemd/systemd-timesyncd
root /usr/sbin/cron
message+ @dbus-daemon
root /usr/lib/systemd/systemd-logind
root /usr/libexec/wsl-pro-service
syslog /usr/sbin/rsyslogd
root /sbin/agetty
root /sbin/agetty
root /usr/bin/python3
root /init
root /init
libaa -zsh
root /bin/login
libaa /usr/lib/systemd/systemd
libaa (sd-pam)
libaa -zsh
polkitd /usr/lib/polkit-1/polkitd
libaa ps
libaa awk
➜  ~ ps aux 
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.1  21816 12252 ?        Ss   12:21   0:01 /sbin/init
root           2  0.0  0.0   3120  1920 ?        Sl   12:21   0:00 /init
root           6  0.0  0.0   4720  2880 ?        Sl   12:21   0:11 plan9 --control-socket 7 --log-level 4 --server-fd 8 --pipe-fd 10 --log-truncate
root          52  0.0  0.2  66824 15632 ?        S<s  12:21   0:01 /usr/lib/systemd/systemd-journald
root         127  0.0  0.0  25144  6144 ?        Ss   12:21   0:00 /usr/lib/systemd/systemd-udevd
systemd+     211  0.0  0.1  21460 12672 ?        Ss   12:21   0:00 /usr/lib/systemd/systemd-resolved
systemd+     215  0.0  0.0  91028  7680 ?        Ssl  12:21   0:00 /usr/lib/systemd/systemd-timesyncd
root         227  0.0  0.0   4236  2432 ?        Ss   12:21   0:00 /usr/sbin/cron -f -P
message+     228  0.0  0.0   9628  4992 ?        Ss   12:21   0:00 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         244  0.0  0.1  17968  8320 ?        Ss   12:21   0:00 /usr/lib/systemd/systemd-logind
root         246  0.0  0.1 1756096 13312 ?       Ssl  12:21   0:00 /usr/libexec/wsl-pro-service -vv
syslog       262  0.0  0.0 222508  5248 ?        Ssl  12:21   0:00 /usr/sbin/rsyslogd -n -iNONE
root         267  0.0  0.0   3160  1920 hvc0     Ss+  12:21   0:00 /sbin/agetty -o -p -- \u --noclear --keep-baud - 115200,38400,9600 vt220
root         270  0.0  0.0   3116  1792 tty1     Ss+  12:21   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         279  0.0  0.2 107012 22272 ?        Ssl  12:21   0:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
root         377  0.0  0.0   3136   768 ?        Ss   12:21   0:00 /init
root         378  0.0  0.0   3136  1156 ?        S    12:21   0:00 /init
libaa        379  0.0  0.0   8388  6488 pts/0    Ss   12:21   0:00 -zsh
root         380  0.0  0.0   6820  4480 pts/1    Ss   12:21   0:00 /bin/login -f
libaa        428  0.0  0.1  20108 10880 ?        Ss   12:21   0:00 /usr/lib/systemd/systemd --user
libaa        429  0.0  0.0  21156  3520 ?        S    12:21   0:00 (sd-pam)
libaa        460  0.0  0.0   7536  5468 pts/1    S+   12:21   0:00 -zsh
polkitd     1079  0.0  0.0 308164  7552 ?        Ssl  12:37   0:00 /usr/lib/polkit-1/polkitd --no-debug
libaa       1346  0.0  0.0   8280  4096 pts/0    R+   16:25   0:00 ps aux
➜  ~ 
```

- Similarly below, the 'awk' command prints the 1st and 6th parameter.
```
➜  ~ cat /etc/passwd | awk -F: '{print $1, $6}'
root /root
daemon /usr/sbin
bin /bin
sys /dev
sync /bin
games /usr/games
man /var/cache/man
lp /var/spool/lpd
mail /var/mail
news /var/spool/news
uucp /var/spool/uucp
proxy /bin
www-data /var/www
backup /var/backups
list /var/list
irc /run/ircd
_apt /nonexistent
nobody /nonexistent
systemd-network /
systemd-timesync /
dhcpcd /usr/lib/dhcpcd
messagebus /nonexistent
syslog /nonexistent
systemd-resolve /
uuidd /run/uuidd
landscape /var/lib/landscape
polkitd /
libaa /home/libaa
➜  ~ cat /etc/passwd                           
root:x:0:0:root:/root:/bin/zsh
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
_apt:x:42:65534::/nonexistent:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:998:998:systemd Network Management:/:/usr/sbin/nologin
systemd-timesync:x:996:996:systemd Time Synchronization:/:/usr/sbin/nologin
dhcpcd:x:100:65534:DHCP Client Daemon,,,:/usr/lib/dhcpcd:/bin/false
messagebus:x:101:101::/nonexistent:/usr/sbin/nologin
syslog:x:102:102::/nonexistent:/usr/sbin/nologin
systemd-resolve:x:991:991:systemd Resolver:/:/usr/sbin/nologin
uuidd:x:103:103::/run/uuidd:/usr/sbin/nologin
landscape:x:104:105::/var/lib/landscape:/usr/sbin/nologin
polkitd:x:990:990:User for polkitd:/:/usr/sbin/nologin
libaa:x:1000:1000:,,,:/home/libaa:/usr/bin/zsh
```

## Challenges

Will need to revisit the 'sed' command.

## What I Learned

Learnt more about piping and the 'awk' command. 