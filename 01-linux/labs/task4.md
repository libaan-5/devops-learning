# Lab: Task 4 - Process Management

## Objective

The objective was to learn to monitor and manage processes.

## Commands Used

**View processes**
```
ps aux
ps aux | grep nginx
```

**Real-time monitoring**
```
top
htop  # install via: sudo apt install htop
```

**Background processes**
```
sleep 100 &
jobs
fg %1  # bring to foreground
bg %1  # send to background
```

**Kill processes**
```
kill <PID>
killall sleep
```

## Output

Wwhat happened:

```
➜  ~ ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.4  0.1  21652 12252 ?        Ss   12:37   0:01 /sbin/init
root           2  0.0  0.0   3120  2048 ?        Sl   12:37   0:00 /init
root           6  0.6  0.0   4848  2564 ?        Sl   12:37   0:01 plan9 --control-socket 7 --log-level 4 --server-fd 8 --pipe-fd 10 --log-truncate
root          53  0.1  0.2  50360 18008 ?        S<s  12:37   0:00 /usr/lib/systemd/systemd-journald
root         106  0.1  0.0  24984  6016 ?        Ss   12:37   0:00 /usr/lib/systemd/systemd-udevd
systemd+     207  0.0  0.1  21460 12672 ?        Ss   12:37   0:00 /usr/lib/systemd/systemd-resolved
systemd+     211  0.0  0.0  91028  7680 ?        Ssl  12:37   0:00 /usr/lib/systemd/systemd-timesyncd
root         223  0.0  0.0   4236  2560 ?        Ss   12:37   0:00 /usr/sbin/cron -f -P
message+     224  0.0  0.0   9532  4864 ?        Ss   12:37   0:00 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         231  0.0  0.1  17968  8192 ?        Ss   12:37   0:00 /usr/lib/systemd/systemd-logind
root         246  0.0  0.1 1756096 12160 ?       Ssl  12:37   0:00 /usr/libexec/wsl-pro-service -vv
root         252  0.0  0.0   3160  1920 hvc0     Ss+  12:37   0:00 /sbin/agetty -o -p -- \u --noclear --keep-baud - 115200,38400,9600 vt220
syslog       256  0.0  0.0 222508  5504 ?        Ssl  12:37   0:00 /usr/sbin/rsyslogd -n -iNONE
root         258  0.0  0.0   3116  1792 tty1     Ss+  12:37   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         264  0.0  0.2 107012 22400 ?        Ssl  12:37   0:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
root         357  0.0  0.0   3136   896 ?        Ss   12:37   0:00 /init
root         359  0.0  0.0   3136  1160 ?        S    12:37   0:00 /init
libaa        363  0.0  0.0   8256  6632 pts/0    Ss   12:37   0:00 -zsh
root         366  0.0  0.0   6824  4352 pts/1    Ss   12:37   0:00 /bin/login -f
libaa        416  0.0  0.1  20112 11008 ?        Ss   12:37   0:00 /usr/lib/systemd/systemd --user
libaa        417  0.0  0.0  21152  3464 ?        S    12:37   0:00 (sd-pam)
libaa        451  0.0  0.0   7536  5728 pts/1    S+   12:37   0:00 -zsh
libaa        789  0.0  0.0   8280  4096 pts/0    R+   12:42   0:00 ps aux
```

```
➜  ~ ps aux | grep nginx
libaa        797  0.0  0.0   4092  1920 pts/0    S+   12:42   0:00 grep --color=auto --exclude-dir=.bzr --exclude-dir=CVS --exclude-dir=.git --exclude-dir=.hg --exclude-dir=.svn --exclude-dir=.idea --exclude-dir=.tox --exclude-dir=.venv --exclude-dir=venv nginx
```

- On the top line, it says my WSL instance has been running for 5 minutes (up 5 min). Additionally, it says 1 user (me) is logged in, and the load average is low which signifies the CPU cores on my device are not in use, which means full performance is available if I were to begin a process. 
- I have 23 total processes, which is expected for WSL. 1 is running (the 'top' command) and 22 are sleeping. There are no zombie processes (dead processes stuck in memory).
```
➜  ~ top
top - 12:43:08 up 5 min,  1 user,  load average: 0.06, 0.03, 0.00
Tasks:  23 total,   1 running,  22 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.0 us,  0.1 sy,  0.0 ni, 99.9 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st 
MiB Mem :   7540.2 total,   6607.7 free,    531.5 used,    553.0 buff/cache     
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   7008.7 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                                      
      6 root      20   0    4848   2564   1792 S   1.3   0.0   0:01.90 init                                                                                                         
      1 root      20   0   21652  12252   9308 S   0.0   0.2   0:01.27 systemd                                                                                                      
      2 root      20   0    3120   2048   1920 S   0.0   0.0   0:00.00 init-systemd(Ub                                                                                              
     53 root      19  -1   66752  18008  17112 S   0.0   0.2   0:00.32 systemd-journal                                                                                              
    106 root      20   0   24984   6016   4864 S   0.0   0.1   0:00.31 systemd-udevd                                                                                                
    207 systemd+  20   0   21460  12672  10496 S   0.0   0.2   0:00.22 systemd-resolve                                                                                              
    211 systemd+  20   0   91028   7680   6784 S   0.0   0.1   0:00.13 systemd-timesyn                                                                                              
    223 root      20   0    4236   2560   2304 S   0.0   0.0   0:00.00 cron                                                                                                         
    224 message+  20   0    9532   4864   4480 S   0.0   0.1   0:00.07 dbus-daemon                                                                                                  
    231 root      20   0   17968   8192   7296 S   0.0   0.1   0:00.14 systemd-logind   
```

- I installed 'htop' which is a more modern GUI-centered alternative over the built-in 'top' command (I cut out the actual installation part).
```
➜  ~ htop
zsh: command not found: htop
➜  ~ sudo apt install htop
[sudo] password for libaa: 
```

- 'sleep 100 &' waits for 100 seconds, and the '&' sybmol sent it to the background (frees terminal and allows me to type commands). 
I ran 'jobs' which displayed the sleep command was still running. 
After running 'fg %1' which moves process 1 to the foreground (the terminal), I ran 'bg %1' which sends the process back to the terminal however, there was no immediate response since the 'sleep 100' task was still running in the background. After the original 100 second timer was up (sending it to the background didn't restart the timer), the command was no longer being used in the foreground and had finished running, where it displayed there was no current job since it finished.
```
➜  ~ sleep 100 &
[1] 1796
➜  ~ jobs
[1]  + running    sleep 100
➜  ~ fg %1 
[1]  + 1796 running    sleep 100
bg %1
```

**Lab challenge: Start a long-running process in the background, find its PID, and kill it.** 
- I found the process ID after running the 'ps aux' command and killed it.
```
➜  ~ sleep 100 &
➜  ~ jobs
[1]  + running    sleep 100
➜  ~ ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.1  21848 12252 ?        Ss   13:09   0:02 /sbin/init
root           2  0.0  0.0   3120  2048 ?        Sl   13:09   0:00 /init
root           6  0.0  0.0   4716  2744 ?        Sl   13:09   0:19 plan9 --control-socket 7 --log-level 4 --server-fd 8 --pipe-fd 10 --log-truncate
root          53  0.0  0.2  66752 18904 ?        S<s  13:09   0:01 /usr/lib/systemd/systemd-journald
root         106  0.0  0.0  24984  6016 ?        Ss   13:09   0:00 /usr/lib/systemd/systemd-udevd
systemd+     207  0.0  0.1  21460 12672 ?        Ss   13:09   0:00 /usr/lib/systemd/systemd-resolved
systemd+     211  0.0  0.0  91028  7680 ?        Ssl  13:09   0:00 /usr/lib/systemd/systemd-timesyncd
root         223  0.0  0.0   4236  2560 ?        Ss   13:09   0:00 /usr/sbin/cron -f -P
message+     224  0.0  0.0   9664  4864 ?        Ss   13:09   0:00 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         231  0.0  0.1  17968  8192 ?        Ss   13:09   0:00 /usr/lib/systemd/systemd-logind
root         246  0.0  0.1 1756096 14080 ?       Ssl  13:09   0:00 /usr/libexec/wsl-pro-service -vv
root         252  0.0  0.0   3160  1920 hvc0     Ss+  13:09   0:00 /sbin/agetty -o -p -- \u --noclear --keep-baud - 115200,38400,9600 vt220
syslog       256  0.0  0.0 222508  5504 ?        Ssl  13:09   0:00 /usr/sbin/rsyslogd -n -iNONE
root         258  0.0  0.0   3116  1792 tty1     Ss+  13:09   0:00 /sbin/agetty -o -p -- \u --noclear - linux
root         264  0.0  0.2 107012 22400 ?        Ssl  13:09   0:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
root         357  0.0  0.0   3136   896 ?        Ss   13:09   0:00 /init
root         359  0.0  0.0   3136  1160 ?        S    13:09   0:00 /init
libaa        363  0.0  0.0   8660  7144 pts/0    Ss   13:09   0:00 -zsh
root         366  0.0  0.0   6824  4352 pts/1    Ss   13:09   0:00 /bin/login -f
libaa        416  0.0  0.1  20112 11008 ?        Ss   13:09   0:00 /usr/lib/systemd/systemd --user
libaa        417  0.0  0.0  21152  3464 ?        S    13:09   0:00 (sd-pam)
libaa        451  0.0  0.0   7536  5728 pts/1    S+   13:09   0:00 -zsh
polkitd     1098  0.0  0.0 308164  7552 ?        Ssl  13:27   0:00 /usr/lib/polkit-1/polkitd --no-debug
libaa       1869  0.0  0.0   3124  1664 pts/0    SN   18:58   0:00 sleep 100
libaa       1900  100  0.0   8280  4096 pts/0    R+   18:59   0:00 ps aux
➜  ~ kill 1869
[1]  + 1869 terminated  sleep 100                                                                                                                                                   
```

- 'kill %1' also works to kill the job instead of using the process ID.
```
➜  ~ jobs
[1]  + running    sleep 100
➜  ~ kill %1
[1]  + 1753 terminated  sleep 100                                                                                                                                                   
```

## Challenges

- Below, I ran into a syntax error, I literally didn't run a specific process ID I just copy and pasted '<PID>' into the terminal. Woops.
```
➜  ~ kill <PID>
killall sleep
zsh: parse error near `\n'
```

## What I Learned
- 'top' (built-in) and 'htop' (installed via zsh) are both process monitors, they are essentially task managers which tracks whatever Linux kernel you have running. In WSL that means tracking WSL Linux processes, not Windows. On a real Linux system, that means the entire Linux OS.
- 'ps aux' can be used to find processes that are currently running.