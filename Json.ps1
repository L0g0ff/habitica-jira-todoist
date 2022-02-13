$hash = [ordered]@{
    "01-01" = 1;
    "02-01" = 2;
    "03-01" = 3
}


$hash | ConvertTo-Json | Out-File PoC.json

Get-Content -Path ./Json.ps1

ConvertFrom-Json 


$j = (Get-Content -Path ./PoC.json -raw)

$j = ConvertFrom-Json -InputObject (Get-Content -Path ./PoC2.json -raw)
$j.data.labels += "2017"
# Why the above is working but the data.datasets.data not??????
$j.data.datasets.data += "10"
ConvertTo-Json -InputObject $j | out-file -Path ./PoC2.json

$j.data.datasets |gm


$y = ConvertFrom-Json -InputObject (Get-Content -Path ./PoC2.json -raw)

$y.data.labels

https://quickchart.io/chart?c={type:'bar',data:{labels:[2012,2013,2014,2015,2016],datasets:[{label:'Users',data:[120,60,50,180,120]}]}}



https://quickchart.io/chart?c=$QuickChartURL


$j = Get-Content -Path ./PoC2.json -raw
$ChartImage = "https://quickchart.io/chart?" + "c=$j"
$QuickChartURL = [uri]::EscapeUriString("$ChartImage")
