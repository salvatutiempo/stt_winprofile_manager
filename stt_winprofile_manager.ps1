<#
Name: STT User Profile Manager - by SalvaTuTiempo
Date: 2022-01-17
Author: Miguel Mora <info@salvatutiempo.com>
Description: Windows Profiles Manager - to show and remove profiles
Version: 1.1
History:
    1.1 Size added
    1.0 First release
Notes:
	- Need to be run as Administrator

    - Run with size column included: : stt_winprofile_manager.ps1 with-size
    - Run without size column: : stt_winprofile_manager.ps1
#>

#########################################################################
# FUNCTIONS
#########################################################################

#ShowMenu: Display main menu
function ShowMenu {
    $Menu = [ordered]@{
      1 = 'Show Users'
      5 = 'Remove Multiple Users'
      q = 'Exit'
      }
    return $Menu
}

#ShowUsers: display users
function ShowUsers {
    param (
        [Object[]]$User,
        [String]$Title
    )
    $ShowUsersTemp = $User | Out-GridView -PassThru -Title $Title
    return  $ShowUsersTemp
}

#RemoveUsers: Display and remove users
function RemoveUsers {
    param (
        [Object[]]$User,
        [Object[]]$Userpath
    )

    $title    = 'Remove Users'
    $question1 = "The following profiles will be deleted:"
    $question2 = $Userpath -Join "`r"
    $question3 = "Are you sure you want to proceed?"

    $question = "$question1{0}$question2{0}$question3" -f [environment]::NewLine
    $choices  = '&Yes', '&No'

	$popup = New-Object -ComObject wscript.shell
	$decision = $popup.Popup("$question",0,"$title",64+1)

    if ($decision -eq 1) 
	{
        $User | Remove-WmiObject
    } else {
        Write-Host 'Cancelled'
    }
}

#########################################################################
# MAIN
#########################################################################
do
 {
    $accounts = Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.Special -ne 'Special'}
    
    $selection = ShowMenu | Out-GridView -PassThru  -Title 'STT User Profile Manager - [by SalvaTuTiempo]'
    if ($args[0] -eq "with-size")
    {    
        $allusers = $accounts | Select-Object @{Name='UserName';Expression={Split-Path $_.LocalPath -Leaf}}, LocalPath, @{Name='Size (MB)';Expression={ [math]::round((Get-ChildItem $_.LocalPath -Recurse -File | Measure-Object -Property Length -Sum).Sum / 1MB, 2) }}, Loaded, SID, @{Name='LastUsed';Expression={$_.ConvertToDateTime($_.LastUseTime)}} 
    }
    else
    {
        $allusers = $accounts | Select-Object @{Name='UserName';Expression={Split-Path $_.LocalPath -Leaf}}, LocalPath, Loaded, SID, @{Name='LastUsed';Expression={$_.ConvertToDateTime($_.LastUseTime)}} 
    }
    switch ($selection)
    {
        {$Selection.Name -eq 1} 
		{        
            ShowUsers -User $allusers -Title "Show User Profiles"
        } 
       
        {$Selection.Name -eq 5} 
		{
          $_Selectuser = ShowUsers -User $allusers -Title "Remove Users"

          if ($_Selectuser) 
		  {
            $rmvuser = $accounts | Where-Object {$_.SID -in $_Selectuser.SID}
            RemoveUsers -User $rmvuser -Userpath $_SelectUser.LocalPath
          } 
        }
    }
 }
 until ($selection.Name -eq 'q')