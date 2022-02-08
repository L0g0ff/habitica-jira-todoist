## Habitica
$HabiticaUserID 	= 'ENTER-USERIDAPI'
$HabiticaPassword 	= 'ENTER-PASSWORDAPI' | ConvertTo-SecureString -Force -AsPlainText
$HabiticaCredential = New-Object PSCredential($HabiticaUserID , $HabiticaPassword)

Connect-Habitica -Credential $HabiticaCredential -Save

## Jira
Set-JiraConfigServer -Server "https://cloudURL.atlassian.net"

$Email 		= 'ENTER-EMAIL'
$Password 	= 'ENTER-APIPASSWORD' | ConvertTo-SecureString -Force -AsPlainText
$Credential = New-Object PSCredential($Email, $Password)


## Todoist
$Headers = @{
    'Content-Type'='application/json'
    'Authorization'= 'Bearer ENTERTODOISTAPI'
    }
  
