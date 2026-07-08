Write-Host "Checking formatting..."
stylua --check .
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Running Selene..."
selene .
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "All quality checks passed."