. \habitica-jira\Credentials.ps1

$Body = @{
    limit = '30'
    since = (get-date).AddDays(-1)
}

$JsonBody = $Body | ConvertTo-Json

$TodoistTasks24h = (Invoke-RestMethod -Uri https://api.todoist.com/sync/v8/completed/get_all -Method Post -Headers $Headers -Body $JsonBody).items 

$ToHabiticaTasks = ForEach ($task in $TodoistTasks24h) {
    Invoke-RestMethod -Uri https://api.todoist.com/rest/v1/tasks/$($task.task_id) -Method Get -Headers $headers
}

$ToHabiticaTasks | Select-Object Id, Content, Priority

## Get high score for prio 1's
foreach ($ToHabiticaTask in $ToHabiticaTasks) {
    # Hard tasks (Prio 4)
    if ($ToHabiticaTask.Priority -eq 4) {
        Write-Host 'Habitica Task Hard'
        Write-Host $ToHabiticaTask.Content
        Write-Host $ToHabiticaTask.url
        New-HabiticaTask -Text $ToHabiticaTask.url -Priority 'Hard'
        Get-HabiticaTask -Name $ToHabiticaTask.url | Complete-HabiticaTask

    }
    # Medium tasks (Prio 3)
    elseif ($ToHabiticaTask.Priority -eq 3) {
        Write-Host 'Habitica Task Medium'
        Write-Host $ToHabiticaTask.Content
        Write-Host $ToHabiticaTask.url
        New-HabiticaTask -Text $ToHabiticaTask.url -Priority 'Medium'
        Get-HabiticaTask -Name $ToHabiticaTask.url | Complete-HabiticaTask
    }
    # Easy tasks (Prio 2 & 1)
    else {
        Write-Host 'Habitica Task Easy'
        Write-Host $ToHabiticaTask.Content
        Write-Host $ToHabiticaTask.url
        New-HabiticaTask -Text $ToHabiticaTask.url -Priority 'Easy'
        Get-HabiticaTask -Name $ToHabiticaTask.url | Complete-HabiticaTask
    }
}