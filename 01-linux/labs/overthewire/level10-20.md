Host: bandit.labs.overthewire.org
Port: 2220

# Bandit Level 10

- Pretty easy bandit level, I knew base64 was a command from the overthewire level 10 page, and I used man to work out how to decode it.
```
bandit10@bandit:~$ man base64
bandit10@bandit:~$ base64 -d data.txt 
The password is dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr
bandit10@bandit:~$ 
```

# Bandit Level 11

- I checked where data.txt was located using ls and I used cat to read the file contents.
- This challenge was challenging for me, I didn't know what command to use so I researched and came across tr, used to translate/delete characters.
- Translating characters forwards 13 positions was exactly what we were required to do in this level.
```
bandit11@bandit:~$ ls
data.txt
bandit11@bandit:~$ cat data.txt 
Gur cnffjbeq vf 7k16JArUVv5LxVuJfsSVdbbtaHGlw9D4
bandit11@bandit:~$ man tr
```

- This level required me to shift both the undercase and UPPERCASE alphabet forwards by 13, so I needed to map the alphabet to its rotated version:
```
abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM
```

- What the commands inputted below does is, the tr command changes the mapped characters displayed from 'cat data.txt', not the file directly.
- The hyphen e.g. N-Z considers all letters within the range. However, to go since A is before N, it has to start a new range afterwards A-M.
```
bandit11@bandit:~$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
The password is 7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4
```

# Bandit Level 12

What I Learned:

I had to rename each file to match the format detected by file, because gzip/bzip2/tar rely on suffixes.

- The 'xxd' makes a hex dump or reverses one.
```
bandit12@bandit:~$ mktemp -d
/tmp/tmp.Kf2Orq3Sgs
bandit12@bandit:~$ ls
data.txt
bandit12@bandit:~$ cd /tmp/tmp.Kf2Orq3Sgs
```

- '.' represents the current path. 
```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ cp ~/data.txt .
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data.txt
```

```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ man mv
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv data.txt dump.hex
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
dump.hex
```

- There is no filetype 'hex' I jsut decided to rename it as 'dump.hex'.
```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file dump.hex
dump.hex: ASCII text
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$
```

I remembered the '>' operator can redirect output to a new file so I used it and checked the file type, which was a gzip.
```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ xxd -r dump.hex > newdump.hex
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
dump.hex  newdump.hex
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file newdump.hex 
newdump.hex: gzip compressed data, was "data2.bin", last modified: Fri Apr  3 15:17:36 2026, max compression, from Unix, original size modulo 2^32 576
```

- I learnt here that I had to rename the file to end in .gz since the filetype was gzip.
```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ gzip -d newdump.hex
gzip: newdump.hex: unknown suffix -- ignored
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv newdump.hex newdump.gz
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ gzip newdump.gz -d
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
dump.hex  newdump
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file newdump 
newdump: bzip2 compressed data, block size = 900k
```

- After seeing the above filetype was 'bzip2' I had to check what it was and how to use it.
```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ man bzip2
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ bzip2 newdump -d
bzip2: Can't guess original name for newdump -- using newdump.out
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
dump.hex  newdump.out
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file newdump.out 
newdump.out: gzip compressed data, was "data4.bin", last modified: Fri Apr  3 15:17:36 2026, max compression, from Unix, original size modulo 2^32 20480
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv newdump.out newdump.gz
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ gzip -d newdump.gz 
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
dump.hex  newdump
```

- tar filetypes do not decompress, they are extracted. 
I didn't know this at first, I tried to search for '-d' but so I had to do research but the command is '-x'.
```
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file newdump 
newdump: POSIX tar archive (GNU)
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ man tar

bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv newdump newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ tar -x -f newdump.tar 
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.bin  dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file data5.bin 
data5.bin: POSIX tar archive (GNU)

bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv data5.bin data5.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.tar  dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ tar -x -f data5.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.tar  data6.bin  dump.hex  newdump.tar

bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv data6.bin data6.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.tar  data6.tar  dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ tar -x -f data6.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.tar  data6.tar  data8.bin  dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ file data8.bin 
data8.bin: gzip compressed data, was "data9.bin", last modified: Fri Apr  3 15:17:36 2026, max compression, from Unix, original size modulo 2^32 49
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ mv data8.bin data8.gz
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.tar  data6.tar  data8.gz  dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ gzip -d data8.gz 
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ ls
data5.tar  data6.tar  data8  dump.hex  newdump.tar
bandit12@bandit:/tmp/tmp.Kf2Orq3Sgs$ cat data8
The password is FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn
```

# Bandit Level 13

- I realised that I couldnt ssh from the overthewire server into another bandit server
- So I had to exit into my own system, and I created a file using the touch command in /tmp/

```
➜  /tmp touch private.key
➜  /tmp vim private.key 
```

- I looked at the 'ssh' command using man, and I ran 'cat sshkey.private' to see the private key.
- From the terminal, I copied the file contents 
```
bandit13@bandit:~$ man ssh
bandit13@bandit:~$ cat sshkey.private 
```

- I pasted the file contents into /tmp which is a temporary directory
- I created private.key in /tmp since it will naturally delete and I don't really need the private key for that long
- After attempting to ssh using the '-i' command, I was told that I must change the file to make it not accessible by others
```
➜  ~ cd /tmp
➜  /tmp ls
➜  /tmp cd ~ 
➜  ~ ssh -p 2220 -i /tmp/private.key bandit14@bandit.labs.overthewire.org

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0644 for '/tmp/private.key' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "/tmp/private.key": bad permissions
bandit14@bandit.labs.overthewire.org's password: 
```

- Following this, I changed the permission of the file to 600, allowing the user to read and write but groups and others no permissions.
- I managed to sign in after changing the permission of the file. 
```
➜  ~ chmod 600 /tmp/private.key 
➜  ~ ssh -p 2220 -i /tmp/private.key bandit14@bandit.labs.overthewire.org
```

# Bandit Level 14

```
bandit14@bandit:~$ cat /etc/bandit_pass/bandit14
MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
bandit14@bandit:~$ nc localhost 30000
MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS
Correct!
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
```

# Bandit Level 15

- I typed up 'SSL' in the ncat man page and I saw that there was a --ssl option
- I typed in the '--ssl' option incorrectly initially, but then corrected it.
- I then inserted the password I got from the cat command of the current level to receive the password of the next level.
```
bandit15@bandit:~$ cat /etc/bandit_pass/bandit15
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
bandit15@bandit:~$ man ncat
bandit15@bandit:~$ ncat -ssl localhost 30001 
Ncat: Could not resolve source address "sl": Temporary failure in name resolution. QUITTING.
bandit15@bandit:~$ man ncat
bandit15@bandit:~$ ncat --ssl localhost 30001
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
Correct!
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
```

# Bandit Level 16

- I tried this command but noticed that the service column was empty, so I couldn't tell if SSL was being used or not (required for the level).
```
bandit16@bandit:~$ man nmap
bandit16@bandit:~$ nmap localhost -p31000-32000
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-05-25 10:36 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00016s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 0.09 seconds
```

- I then learnt about the -sV option after checking the 'nmap' manual page.
- This narrowed it down to two possible ports, 31518/tcp (ssl/unknown) and 31790/tcp (ssl/unknown).
- However, there was a hint at which port it was from the two as it (SF-Port31790-TCP) as it returned data.
```
bandit16@bandit:~$ man nmap
bandit16@bandit:~$ nmap localhost -p31000-32000 -sV
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-05-25 10:50 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00012s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT      STATE SERVICE     VERSION
31046/tcp open  echo
31518/tcp open  ssl/echo
31691/tcp open  echo
31790/tcp open  ssl/unknown
31960/tcp open  echo
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port31790-TCP:V=7.94SVN%T=SSL%I=7%D=5/25%Time=6A14296E%P=x86_64-pc-linu
SF:x-gnu%r(GenericLines,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x2
SF:0current\x20password\.\n")%r(GetRequest,32,"Wrong!\x20Please\x20enter\x
SF:20the\x20correct\x20current\x20password\.\n")%r(HTTPOptions,32,"Wrong!\
SF:x20Please\x20enter\x20the\x20correct\x20current\x20password\.\n")%r(RTS
SF:PRequest,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x20current\x20
SF:password\.\n")%r(Help,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x
SF:20current\x20password\.\n")%r(FourOhFourRequest,32,"Wrong!\x20Please\x2
SF:0enter\x20the\x20correct\x20current\x20password\.\n")%r(LPDString,32,"W
SF:rong!\x20Please\x20enter\x20the\x20correct\x20current\x20password\.\n")
SF:%r(SIPOptions,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x20curren
SF:t\x20password\.\n");

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 133.03 seconds
```

- I then ran the ncat command and inputted the current level password and received the private key for the next level. 
- I then rank mktemp -d
```
bandit16@bandit:~$ ncat --ssl localhost 31790
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
Correct!
```

```
➜  ~ mktemp -d
/tmp/tmp.t5ZkP7C4lb
➜  ~ cd /tmp/tmp.XB251aMvE2
➜  tmp.XB251aMvE2 vim private.key
➜  tmp.XB251aMvE2 ls
private.key
➜  tmp.XB251aMvE2 cd ~
➜  ~ chmod 600 /tmp/tmp.XB251aMvE2/private.key
➜  ~ ssh -p 2220 -i /tmp/tmp.XB251aMvE2/private.key bandit17@bandit.labs.overthewire.org
bandit17@bandit:~$ cat /etc/bandit_pass/bandit17
EReVavePLFHtFlFsjn3hyzMlvSuSAcRD
```

# Bandit Level 17

- '<' is the first line which is passwords.new
- line 42 of passwords.new has been changed from passwords.old
```
bandit17@bandit:~$ ls
passwords.new  passwords.old
bandit17@bandit:~$ man diff
bandit17@bandit:~$ diff passwords.new passwords.old
42c42
< x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
---
> 390zFj2NETFVZkqYw8UEFdN6h40oGVtT
```

# Bandit Level 18

```
➜  ~ ssh -p 2220 bandit18@bandit.labs.overthewire.org cat readme
                         _                     _ _ _   
                        | |__   __ _ _ __   __| (_) |_ 
                        | '_ \ / _` | '_ \ / _` | | __|
                        | |_) | (_| | | | | (_| | | |_ 
                        |_.__/ \__,_|_| |_|\__,_|_|\__|
                                                       

                      This is an OverTheWire game server. 
            More information on http://www.overthewire.org/wargames

backend: gibson-0
bandit18@bandit.labs.overthewire.org's password: 
cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
```

# Bandit Level 19 -> 20

- I didn't have permission to know what the password was for bandit20, however I was able to run the bandit20-do file by doing ./bandit20-do 
```
bandit19@bandit:~$ ls
bandit20-do
bandit19@bandit:~$ ls -l
total 16
-rwsr-x--- 1 bandit20 bandit19 14888 Apr  3 15:17 bandit20-do
bandit19@bandit:~$ ./bandit20-do 
bandit19@bandit:~$ cat /etc/bandit_pass/bandit20
cat: /etc/bandit_pass/bandit20: Permission denied
bandit19@bandit:~$ ./bandit20-do cat /etc/bandit_pass/bandit20
0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
```