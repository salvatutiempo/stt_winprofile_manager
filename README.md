# Description

Working in a dynamic work environment makes "recycling" PCs that has been
previously used for new users, a very common task.

We usually do not have that time to be able to completely reinstall the
Operating System, install all the company applications and other necessary
operations; that is why deleting user profiles from a computer is the most
efficient task.

On this website we like to optimize our time, so we are going to show you how to
show and delete user profiles for Windows computers using Powershell. Let's go
for it!

# stt_winprofile_manager.ps1

Script with GUI to display and delete user profiles in a Windows PC

# Prerrequisites

For this lab we will need:

-   A PC with Windows Operating System

-   Admin permissions on that PC

-   At least Powershell 3.0 installed



# Run as Admin

In order to delete user profiles it will be necessary to run our code as
Administrator.

To do this, we can launch the "Run" window by pressing CTRL+R

![image](https://user-images.githubusercontent.com/94779390/149981326-196701a1-9aab-4909-92fc-8944d6b4ac9b.png)

And we need to write the following code inside:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
powershell -Command "Start-Process PowerShell -Verb RunAs"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This will open a Powershell shell as Administrator.

Once we are inside the Shell, we will run our code

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PS C:\WINDOWS\system32> & D:\salvatutiempo\stt_winprofile_manager.ps1"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
