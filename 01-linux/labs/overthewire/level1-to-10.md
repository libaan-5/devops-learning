Host: bandit.labs.overthewire.org
Port: 2220

# Bandit Level 1

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
- From the man page, I could see it requested me to search in this format, -size n[cwbkMG], where n is the number and c is the bytes I can use. So from man, I could do 'find -size 1033c'.
```
bandit5@bandit:~/inhere$ man find
bandit5@bandit:~/inhere$ find . -size 1033c -readable ! -executable
./maybehere07/.file2
bandit5@bandit:~/inhere$ cat ./maybehere07/.file2
HWasnPhtq9AVKe0dmk45nxy20cvUa6EG                                 
```

# Bandit Level 6

- Initially, I was thinking of what commands could work for this level. 
- I tried to use man grep but grep is only for searching inside file contents.  find is more suitable for searching for file attributes.
- Initially, I thought running find from '.' would help me locate the file since I had used it in bandit5, but I was confused why nothing printed afterwards. However, I realised after doing some research that '.' only searches within the current working directory.
```
bandit6@bandit:~$ man find
bandit6@bandit:~$ find . -group bandit6 -size 33c -user bandit7
```

- find '.' searches the entire file system, so '/' was better.
- The output was very long because a lot of the files that appeared had 'permission denied' so I cut most of it out. 
```
bandit6@bandit:~$ find / -group bandit6 -size 33c -user bandit7
find: ‘/tmp’: Permission denied
find: ‘/etc/credstore.encrypted’: Permission denied
find: ‘/etc/sudoers.d’: Permission denied
find: ‘/etc/stunnel’: Permission denied
find: ‘/etc/multipath’: Permission denied
find: ‘/etc/ssl/private’: Permission denied
find: ‘/etc/polkit-1/rules.d’: Permission denied
...
...
...
```

- I had to research for ways to remove the permission denied, and I discovered '2>/dev/null' which sends '2' which symbolises stderr (error messages) to /dev/null which is the void/blackhole.  
```
bandit6@bandit:~$ find / -group bandit6 -size 33c -user bandit7 2>/dev/null
/var/lib/dpkg/info/bandit7.password
bandit6@bandit:~$ cat /var/lib/dpkg/info/bandit7.password
morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj
```

# Bandit Level 7
- Found this one a bit easier, simply useed the 'grep' command to find the password.
```
bandit7@bandit:~$ ls
data.txt
bandit7@bandit:~$ grep "millionth" data.txt 
millionth       dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
```

# Bandit Level 8

- This level challenged me, I didn't know how to complete it. 
- I tried to look into grep again to see if there was an option that let me if I could check lines that occur once

```
bandit8@bandit:~$ man uniq
bandit8@bandit:~$ uniq -u data.txt 
```

- After researching, I came across uniq and I was initially confused about what uniq did but it can be used to remove repeated lines.
- However, uniq has a rule where it 'groups' lines together if they are repeated and doesn't scan the entire file, so I had to sort the file and then run the uniq command.
```
bandit8@bandit:~$ sort data.txt | uniq -u
4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
```

# Bandit Level 9

- I knew grep was the command because the content was inside of a file, and I knew I had to use an option for this level because the lines was  'human-readable'
- Since the file contained a several "=" characters, and several means at least 3 or more, I tried to grep at least 3 initially.
- However, it printed that 'binary file matches'. I didn't know what this meant, so I researched and it meant it found the "===" pattern but it didn't want to paste that into the terminal. 
```
bandit9@bandit:~$ ls
data.txt
bandit9@bandit:~$ man grep
bandit9@bandit:~$ grep "===" data.txt 
grep: data.txt: binary file matches
```

- Using the grep -a command to let binary be considered as text, I was able to find the level password at the very end.  
```
bandit9@bandit:~$ grep -a  "===" data.txt 
�i�?�����s�̈́�
            �32�j�Фlf��并�9am�a$C�9�_U������+� ========== the
:�{��Q��G�g��$�K�n��C��;��V��'T
                               H�t���s-�ߒS��ʒ��.��O_���Y��p�����IϾ�~���!y�fL-(0�A�]@�g"���&�*��L�z\5�X�l�nc�罄�u�#]���ӝg<��&���9�U�     �T�u�z���»��������W���+˕6ѕN��+�s8ѐ�q?yPd������L���fC�7��$������PaR�(!��Lq�ՙ>0���l^��;(A` ���b5,����b��|u�հ���[2�§1��I�Ȯ�4����q��a�@��n�F��f6wę%C�-��}^��
�h���aFE�^;���ʽ�,��/3"��mM-gL`|�x��^========== password
\���3��"���I�����Qa�ާ`�Pb���2�?�c�rc�q����(���E��b
                                                  �����I�18={M\��5�����F_�Pv4��lC�]C���~�N��\M�����/�MyGb�gpw'�����G�wmҿ���+﬩MR��Td�}}�0𬶘�W8��,$�|��h��Q�A�l�ф�OCy���1:>A�(S7'�3Ӡ ��ä��{�z�/?7��F���B�������1�j�����K�T�����ĺ1=Z����Sy�!�+f��Q�0;�Ƀ�5޿*�DIA`��� pzZ��Ջ(3�
                                                           �����X�?$����t��X��$��========== is
"���&��Kʹ��)4�Ŭ`�CwV�
                     l�jI��p�Յ(��g�AXa�f�       u&�Ɲ�g�NwGk���#����2�����W��M)V�Tl��)F���TU��8#��#&��;�$K[��<[��q�#&����e_�|
��RzP                                                                                                                       J�i�s^�ld�mm �g\�ݡ�u���$��1��Cf�M��\�#%� j�!��GQi
��m��$=lbG�HncӬq��l�`������E~���c��^
                                    b�(2��
                                          �������k��}�������F�========== FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
bandit9@bandit:~$ 
```