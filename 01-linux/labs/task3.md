# Lab: Task 3 - Permissions and Ownership

## Objective

The objective of this lab was to understand more about file ownership and I learned how to modify file permissions

## Commands Used 

**Create a script**
```
echo '#!/bin/bash\necho "Hello DevOps"' > hello.sh
```

**Make it executable**
```
chmod +x hello.sh
```

**Run it**
```
./hello.sh
```

**Change ownership**
```
sudo chown root:root hello.sh
```

**Understanding permissions**
```
ls -l hello.sh
```

## Output

What happened:

**Creating the script**
- Below, I wanted to check the contents of the home '~' folder before and after creating the hello.sh script.
- The '>' command created a file 'hello.sh' and wrote "Hello DevOps" into it.
```
➜  ~ ls                                                
devops-learning  set_permissions.sh  testfolder
➜  ~ echo '#!/bin/bash\necho "Hello DevOps"' > hello.sh
➜  ~ ls
devops-learning  hello.sh  set_permissions.sh  testfolder
```

**Making it executable**
- The 'chmod +x' command gave users, groups, and others permission to execute the file 'hello.sh'. 
- './hello.sh' was used to execute the file. Since the user group had permissions, it was able to run.
```
➜  ~ chmod +x hello.sh
➜  ~ ./hello.sh
Hello DevOps
```

**Changing ownership**
- The command below changed the user and group ownership from the logged in user (libaa) to root.
- I was prompted to enter my user password after using the sudo (superuser do) command which enables me to temporarily act as root. 
```
➜  ~ sudo chown root:root hello.sh
[sudo] password for libaa: 
```

**Viewing permissions for 'hello.sh'**
- For 'hello.sh' below, users group and others were given executable permissions.
```
➜  ~ ls -l hello.sh
-rwxr-xr-x 1 root root 32 May 17 15:14 hello.sh
```

**Lab challenge: Making a file only I can read/write/execute but others can read**

- I was thinking of running 'sudo chmod u+rw' but that forgets about letting others read. 
- The 'chmod (numbers)' alternative is better, where it would enable me to set the permissions quickly in one command. The exact command for users=read/write,others=read is 'chmod 604 {file}'.
- Originally I was planning on making the file user = read/write and others = read, however at this stage I learnt that is the default permissions of files which are created. So I changed the lab challenge to make users read/write/execute and kept others=read. The command became 'chmod 704 {file}'.
```
➜  ~ ls 
devops-learning  hello.sh  set_permissions.sh  testfolder
➜  ~ cd testfolder 
➜  testfolder ls
example.txt  file-system-notes.md
➜  testfolder echo 'Test file!' > testfile.txt
➜  testfolder ls
example.txt  file-system-notes.md  testfile.txt
➜  testfolder cat testfile.txt 
Test file!
➜  testfolder ls -a
.  ..  example.txt  file-system-notes.md  testfile.txt
➜  testfolder ls -l  
total 12
-rw-r--r-- 1 libaa libaa 161 May 12 12:49 example.txt
-rw-r--r-- 1 libaa libaa 357 May 13 22:19 file-system-notes.md
-rw-r--r-- 1 libaa libaa  11 May 17 18:10 testfile.txt
➜  testfolder chmod 704 testfile.txt 
➜  testfolder ls -l
total 12
-rw-r--r-- 1 libaa libaa 161 May 12 12:49 example.txt
-rw-r--r-- 1 libaa libaa 357 May 13 22:19 file-system-notes.md
-rwx---r-- 1 libaa libaa  11 May 17 18:10 testfile.txt
➜  testfolder 
```

## What I Learned

The password prompt appeared because sudo wanted 'libaa' (me) to prove I was not somebody else. The prompt is triggered by sudo itself and not by the 'root:root' part of the command.