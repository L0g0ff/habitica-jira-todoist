. \habitica-jira\Credentials.ps1

$JiraTickets = Get-JiraIssue -Credential $Credential `
    -Query "assignee in (currentUser()) AND statusCategoryChangedDate >= -1d AND status in (Canceled, Closed, Completed, Declined, Done) order by created DESC"

## Goal get rid of old tasks
foreach ($JiraTicket in $JiraTickets) {
    $JiraTicketDay = (($JiraTicket.Created) - (Get-date)).Days
    # Less older then 2 days = Easy
    if (-2 -le $JiraTicketDay) {
        Write-Host 'Habitica Task Easy'
        Write-Host $JiraTicket.key
        New-HabiticaTask -Text $JiraTicket.key -Priority 'Easy'
        Get-HabiticaTask -Name $JiraTicket.key | Complete-HabiticaTask
    }
    # Less older then 14 days = Medium
    elseif (-14 -lt $JiraTicketDay) {
        Write-Host 'Habitica Task Medium'
        Write-Host $JiraTicket.key
        New-HabiticaTask -Text $JiraTicket.key -Priority 'Medium'
        Get-HabiticaTask -Name $JiraTicket.key | Complete-HabiticaTask
    }
    # Older then 14 days = Hard
    else {
        Write-Host 'Habitica Task Hard'
        Write-Host $JiraTicket.key
        New-HabiticaTask -Text $JiraTicket.key -Priority 'Hard'
        Get-HabiticaTask -Name $JiraTicket.key | Complete-HabiticaTask
    }
}