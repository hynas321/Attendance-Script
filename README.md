# Attendance-Script
## Description
Bash script that checks attendance of logged in users on Ubuntu.
## Configuration
All files have to be placed in the same directory as the bash script itself.
1. Create `students.txt` that contains information about the date when a student should be logged in:\
`user name` `day` `initial hour` `end hour`
- `day` in format: Mon, Tue, Wed, Thu, Fri, Sat, Sun
- `initial hour` and `end hour` in format XX:XX
2. Create an empty `register.txt`
3. Create an empty `t_register.txt`
4. Type in terminal `sudo apt-get install moreutils`
5. Set automatic execution of the script
- `crontab -e`
- `* 1 * * * /home/<user>/Desktop/attendance.sh` (in case of having files on Desktop)
Condition for the automatic execution to work:
- `chmod +x <cd and name>` - changes permission by adding "x" to let crontab execute the script\
In order to have an attendance fully checked, the script needs to be run two times.
Therefore, please adjust students' hours to crontab settings so that their attendance is checked twice.
## How does it work?
The first time the attendance is checked, the information is put into `t_register.txt`.\
If the user is still logged in during the second execution of the bash script, the attendance
is removed from `t_register.txt` and goes to a permanent `register.txt`.\
If the user is logged in only during one check, the permanent attendance is not registered.
