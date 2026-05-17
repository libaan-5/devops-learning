# Lab: Task 3 - Permissions and Ownership

## Objective

The objective of this lab was to understand more about file permissions. 

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

## What I Learned

The password prompt appeared because sudo wanted 'libaa' (me) to prove I was not somebody else. The prompt is triggered by sudo itself and not by the 'root:root' part of the command.