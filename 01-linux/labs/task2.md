# Lab: Task 2 - File System Navigation

## Objective

The goal of this lab was to become familiar with several Linux commands.

## Commands Used

**Navigation**
```
cd /var/log
ls -lah
pwd
```

**File operations**
```
touch test.txt
mkdir -p projects/demo
cp test.txt projects/demo/
mv projects/demo/test.txt projects/demo/backup.txt
rm projects/demo/backup.txt
```

**Viewing files**
```
cat /etc/passwd
less /var/log/syslog
head -n 20 /etc/services
tail -f /var/log/auth.log
```

## Output

**Navigating the filesystem**  
- I moved into /var/log and inspected the directory contents.
```
➜  ~ cd /var/log
ls -lah
pwd
total 5.1M
drwxrwxr-x   8 root      syslog          4.0K May 15 09:05 .
drwxr-xr-x  13 root      root            4.0K Jan  3 21:59 ..
lrwxrwxrwx   1 root      root              39 Aug  5  2025 README -> ../../usr/share/doc/systemd/README.logs
-rw-r--r--   1 root      root             15K May  9 14:55 alternatives.log
-rw-r--r--   1 root      root             20K Aug  5  2025 alternatives.log.1
drwxr-xr-x   2 root      root            4.0K May 12 10:31 apt
-rw-r-----   1 syslog    adm              18K May 15 09:17 auth.log
-rw-r-----   1 syslog    adm              11K May  9 23:17 auth.log.1
-rw-r-----   1 syslog    adm              537 May  6 18:25 auth.log.2.gz
-rw-r-----   1 syslog    adm             1.5K Apr 10 19:00 auth.log.3.gz
-rw-r--r--   1 root      root            116K Aug  5  2025 bootstrap.log
-rw-rw----   1 root      utmp               0 May  6 18:25 btmp
-rw-rw----   1 root      utmp               0 Aug  5  2025 btmp.1
drwxr-xr-x   2 root      root            4.0K Jul 25  2025 dist-upgrade
-rw-r-----   1 root      adm              36K May 15 09:05 dmesg
-rw-r-----   1 root      adm              36K May 14 13:40 dmesg.0
-rw-r-----   1 root      adm              11K May 14 11:40 dmesg.1.gz
-rw-r-----   1 root      adm              11K May 13 22:03 dmesg.2.gz
-rw-r-----   1 root      adm              21K May 12 10:22 dmesg.3.gz
-rw-r-----   1 root      adm              11K May 12 10:21 dmesg.4.gz
-rw-r--r--   1 root      root            112K May 12 10:31 dpkg.log
-rw-r--r--   1 root      root            361K Aug  5  2025 dpkg.log.1
-rw-r--r--   1 root      root               0 Aug  5  2025 faillog
-rw-r--r--   1 root      root             790 Aug  5  2025 fontconfig.log
drwxr-sr-x+  3 root      systemd-journal 4.0K Jan  3 21:59 journal
-rw-r-----   1 syslog    adm             315K May 15 09:16 kern.log
-rw-r-----   1 syslog    adm             136K May  9 18:13 kern.log.1
-rw-r-----   1 syslog    adm              21K May  6 18:25 kern.log.2.gz
-rw-r-----   1 syslog    adm              22K Apr 10 19:00 kern.log.3.gz
drwxr-xr-x   2 landscape landscape       4.0K Aug  5  2025 landscape
-rw-rw-r--   1 root      utmp               0 Aug  5  2025 lastlog
drwx------   2 root      root            4.0K Aug  5  2025 private
-rw-r-----   1 syslog    adm             2.7M May 15 09:28 syslog
-rw-r-----   1 syslog    adm             950K May 10 00:00 syslog.1
-rw-r-----   1 syslog    adm              35K May  6 18:25 syslog.2.gz
-rw-r-----   1 syslog    adm              51K Apr 10 19:00 syslog.3.gz
drwxr-x---   2 root      adm             4.0K May  9 14:49 unattended-upgrades
-rw-rw-r--   1 root      utmp             56K May 15 09:05 wtmp
/var/log
➜  log 
```

**File Operations and Debugging Explanation**
- text.txt was copied and moved inside projects/demo. After, it was renamed to backup.txt using the 'mv' command, and was then removed from projects/demo.
- I was attempting to debug what happened to test.txt using /'ls' and 'ls -a'.
- To clean up my home folder (not shown below), I decided to run 'rm test.txt' from the home directory to get rid of the empty file, and I also ran 'rm -r projects' to get rid of the directory which had the empty projects/demo directory.
```
➜  ~ touch test.txt
mkdir -p projects/demo
cp test.txt projects/demo/
mv projects/demo/test.txt projects/demo/backup.txt
rm projects/demo/backup.txt
➜  ~ ls
devops-learning  projects  set_permissions.sh  test.txt  testfolder
➜  ~ cd projects 
➜  projects ls
demo
➜  projects cd demo 
➜  demo ls
➜  demo ls -a
.  ..
➜  demo 
```

**Understanding /etc/passwd**
- Initially I was confused but /etc/passwd is simpler than it looks: 
- /etc/passwd - It stores basic user account info. 
- There are 7 fields separated by the ':'. Looking at 'libaa' (the username), the password is x (encrypted for safety), the userid is 1000, groupid is 1000, the directory which opens immediately on signin is /home/libaa, and the final shell executes '/usr/bin/zsh' which is the zsh shell. 
- Looking at the final field (which is ran after signing in), I can see programs run '/usr/sbin/nologin' which denies login - these users aren't useable.
```
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

**Understanding the 'less' command**
- The less command allows you to read incredibly long files using pages and navigate using commands.
I won't paste the contents of 'less /var/log/syslog' since it's too long but '/var/log/syslog' is the main system log file containing events, warnings and messages.

less key commands:
- q   to quit
- g	Go to top
- G	Go to bottom
- /text	Search for “text”
- n	Next search result

**Understanding /etc/services**
- /etc/services maps services (e.g., echo) to their corresponding port numbers and protocols (e.g., 7/tcp, 13/udp).
The command head -n 20 runs the first 20 lines of the file.
```
➜  ~ head -n 20 /etc/services
# Network services, Internet style
#
# Updated from https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml .
#
# New ports will be added on request if they have been officially assigned
# by IANA and used in the real-world or are needed by a debian package.
# If you need a huge list of used numbers please install the nmap package.

tcpmux          1/tcp                           # TCP port service multiplexer
echo            7/tcp
echo            7/udp
discard         9/tcp           sink null
discard         9/udp           sink null
systat          11/tcp          users
daytime         13/tcp
daytime         13/udp
netstat         15/tcp
qotd            17/tcp          quote
chargen         19/tcp          ttytst source
chargen         19/udp          ttytst source
```

**Understanding the tail -f command**
- tail lists the last 10 lines, and -f allows me to see a live continuous stream of authentication events. From what can be seen below, cron jobs are running automatically every hour.
```
➜  ~ tail -f /var/log/auth.log
2026-05-15T09:40:34.978416+01:00 L polkitd[1444]: Loading rules from directory /etc/polkit-1/rules.d
2026-05-15T09:40:34.978722+01:00 L polkitd[1444]: Loading rules from directory /usr/share/polkit-1/rules.d
2026-05-15T09:40:34.981067+01:00 L polkitd[1444]: Finished loading, compiling and executing 4 rules
2026-05-15T09:40:34.982006+01:00 L polkitd[1444]: Acquired the name org.freedesktop.PolicyKit1 on the system bus
2026-05-15T10:17:07.457210+01:00 L CRON[1765]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-05-15T10:17:07.465658+01:00 L CRON[1765]: pam_unix(cron:session): session closed for user root
2026-05-15T11:17:07.109716+01:00 L CRON[1779]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-05-15T11:17:07.123865+01:00 L CRON[1779]: pam_unix(cron:session): session closed for user root
2026-05-15T12:17:09.071410+01:00 L CRON[1910]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
2026-05-15T12:17:09.074430+01:00 L CRON[1910]: pam_unix(cron:session): session closed for user root
```

## What I Learned

5 useful commands discovered during this task:

- 'ls' lists the contents in the current directory.
- 'cat' displays and reads file contents.
- 'mkdir' creates a new directory.
- 'rm' removes files or directories 'rm -r'. 
- 'mv' moves files/directories and can also rename.