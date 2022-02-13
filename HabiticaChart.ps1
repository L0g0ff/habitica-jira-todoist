# Count
$CompletedTodos =  (Get-HabiticaTask -Type completedTodos | Where-Object { $_.dateCompleted -ge (get-date).AddDays(-1) }).Count
$CompletedDailys = (Get-HabiticaTask -Type dailys | Where-Object { $_.completed -eq 'True' }).Count

# Data is in miliseconds. So get-date minus one day (86400) times the number 1000 (seconds to miliseconds)
$score = Get-HabiticaTask -Type habits | Select-Object -ExpandProperty history | Where-Object { $_.date -ge ((get-date -UFormat %s) - 86400) * 1000 }

$scoredup = ($score | Measure-Object -Property scoredUp -Sum).Sum
$scoredown = ($score | Measure-Object -Property scoredDown -Sum).Sum

$CompletedHabits = $scoredup - $scoredown

$CompletedTotal = $CompletedTodos + $CompletedDailys + $CompletedHabits

$CompletedTotal

https://quickchart.io/chart/render/zm-b8c828c9-73e7-4d18-86c6-e4fdfeca34c6?title=An interesting chart&labels=Q1,Q2,Q3,Q4&data1=50,40,30,20


$j = ConvertFrom-Json -InputObject (Get-Content -Path ./PoC.json -raw)
$Chartlabels = Write-Host $j.Dates -NoNewline -Separator ','
$ChartData = Write-Host $j.Tasks -NoNewline -Separator ','

$j.Tasks | Out-String -NoNewline