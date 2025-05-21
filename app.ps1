param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("start", "stop")]
    [string]$Action
)

$AppName = "node-api"
# Option 1: Ensure this line is clean (re-type it)
# $ImageTag = "$AppName:1.0"
# Option 2: Use the -f format operator (recommended for robustness here)
$ImageTag = "{0}:{1}" -f $AppName, "1.0"

if ($Action -eq "stop") {
    Write-Host ">>> Stopping container '$AppName' if it's running..."
    docker kill $AppName 2>$null # Suppress error if not running

    Write-Host ">>> Removing container '$AppName' if it exists..."
    docker rm $AppName 2>$null    # Suppress error if not existing

    Write-Host ">>> Done. Container '$AppName' has been stopped and removed."
}
elseif ($Action -eq "start") {
    Write-Host "--- Debug ---"
    Write-Host "Debug: AppName  = '$AppName'"
    Write-Host "Debug: ImageTag = '$ImageTag'" # This should now show 'node-api:1.0'
    Write-Host "---------------"

    Write-Host ">>> Starting new container '$AppName' from image '$ImageTag'..."
    docker run --name $AppName -d -p 80:80 $ImageTag # Ensure $ImageTag is correct here

    # Check for errors from docker run before printing "Done"
    if ($LASTEXITCODE -ne 0) {
        Write-Error ">>> Failed to start container '$AppName'. Docker exit code: $LASTEXITCODE"
    } else {
        Write-Host ">>> Done. Container '$AppName' should now be running on port 80."
    }
}