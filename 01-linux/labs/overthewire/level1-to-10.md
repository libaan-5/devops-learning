# Bandit Level 1

Host: bandit.labs.overthewire.org
Port: 2220

- I used 'ssh' to enter the overthewire game server, prefixing the level username and the port  -> ssh -p 2220 bandit0@bandit.labs.overthewire.org 
- I ran ls to view the files in the directory, and then I used the 'cat' command to read the file contents which gave me the password.
```
bandit0@bandit:~$ ls
readme
bandit0@bandit:~$ cat readme 
Congratulations on your first steps into the bandit game!!
Please make sure you have read the rules at https://overthewire.org/rules/
If you are following a course, workshop, walkthrough or other educational activity,
please inform the instructor about the rules as well and encourage them to
contribute to the OverTheWire community so we can keep these games free!

The password you are looking for is: ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
```

- I ran ls to list the files in the directory, and it appeared like there was a file named '-'.
```
bandit1@bandit:~$ ls
-
```

- I saw that '-' was a file after running 'ls -l'. I tried a lot to read the file but I was stuck. 
```
bandit1@bandit:~$ ls -l
total 4
-rw-r----- 1 bandit2 bandit1 33 Apr  3 15:17 -
```
- I looked it up, and I had to give it a path.  
```
bandit1@bandit:~$ cat ./-
263JGJPfgU6LtdEvgfWU1XP5yac29mFx
```
The below also works
```
bandit1@bandit:~$ pwd
/home/bandit1
bandit1@bandit:~$ cat /home/bandit1/-
263JGJPfgU6LtdEvgfWU1XP5yac29mFx
```
# Bandit Level 2

- I ran ls to see that the filename is literally called '--spaces in this filename--'. I tried to add quotation marks ("") to contain the spaces, but the (--) was making it read as an option by the 'cat' command. I had to use './' to make it read the file in the current directory.  
```
bandit2@bandit:~$ ls
--spaces in this filename--
bandit2@bandit:~$ cat "--spaces in this filename--"
cat: unrecognized option '--spaces in this filename--'
Try 'cat --help' for more information.
bandit2@bandit:~$ cat "./--spaces in this filename--"
MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
```

# Bandit Level 3
- I checked the directory contents, and then I moved into the directory 'inhere' which was coloured blue from the ohmyzsh feature. 
- ls didn't show any file contents, so I used ls -a to show me hidden folder contents too (and all contents) and it showed me there was a file '...Hiding-From-You' which I was able to use the cat command to read.
```
bandit3@bandit:~$ ls
inhere
bandit3@bandit:~$ cd inhere
bandit3@bandit:~/inhere$ ls
bandit3@bandit:~/inhere$ ls -a
.  ..  ...Hiding-From-You
bandit3@bandit:~/inhere$ cat ...Hiding-From-You 
2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
```


# Bandit Level 4

- I could've checked each file individually but that would be too long, imagine if there were hundreds of files? So I had to look for a command which searched every file within the directory. Fortunately, that's what '*' does, it expands to all filenames in the current directory.
- Since the challenge said that the password was stored in the only human-readable file, the best command to use was 'file' which examines the contents of a file and shows what type of data it contains. 
- Since -file07 had the ASCIII text file, I ran 'cat' to check what it contained and surely enough that was the file that had the password.
```
bandit4@bandit:~$ ls
inhere
bandit4@bandit:~$ cd inhere/
bandit4@bandit:~/inhere$ ls
-file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09
bandit4@bandit:~/inhere$ file ./*
./-file00: data
./-file01: data
./-file02: data
./-file03: DOS executable (COM), start instruction 0x8c887e10 c3ee96c9
./-file04: data
./-file05: data
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: data
bandit4@bandit:~/inhere$ cat ./-file07
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
```

# Bandit Level 5

I used the man command and typed up '-size' to see if it was an option. Fortunately, it was and the problem asked me to find a file which was 1033 bytes in size. 
- From the man page, I could see it requested me to search in this format, -size n[cwbkMG], where n is the number and b is the bytes I can use. So from man, I could do 'find -size 1033c'.
```
bandit5@bandit:~/inhere$ man find
bandit5@bandit:~/inhere$ find . -size 1033c -readable ! -executable
./maybehere07/.file2
bandit5@bandit:~/inhere$ cat ./maybehere07/.file2
HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
                                          
```