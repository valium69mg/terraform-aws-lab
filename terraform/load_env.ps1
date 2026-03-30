Get-Content .env | ForEach-Object { 
    $parts = $_ -split '='
    if ($parts.Count -eq 2) { Set-Item -Path Env:$($parts[0]) -Value $parts[1] }
}