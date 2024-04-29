<# Created by John Tomchick April 29th, 2024
No warranty implied
This uses API calls from https://locationiq.com/geocoding . Please create a free account which generates a token to use the calls in this Script.
This section declares the MDM Remote Find class. 
More information here https://learn.microsoft.com/en-us/windows/win32/dmwmibridgeprov/mdm-remotefind-location01 and https://learn.microsoft.com/en-us/windows/client-management/using-powershell-scripting-with-the-wmi-bridge-provider
#>
$namespace = "root\cimv2\mdm\dmmap"
$classname = "MDM_RemoteFind_Location01"
$lat = (Get-CimInstance -Namespace $namespace -ClassName $classname).Latitude
$lon = (Get-CimInstance -Namespace $namespace -ClassName $classname).Longitude

$APIToken = #Redacted. Please visit https://locationiq.com/geocoding to create an account and generate API token
$endpoint = "https://us1.locationiq.com/v1/reverse.php?key=$APIToken&lat=$lat&lon=$lon&format=json"
$devicegeodata = Invoke-RestMethod -Uri $endpoint
$devicegeofull = $devicegeodata.display_name
$devicegeoCountry = $devicegeodata.address.country
$devicegeoRegion = $devicegeodata.address.state
$devicegeoCounty = $devicegeodata.address.county
$devicegeoCity = $devicegeodata.address.city
$devicegeoRoad = $devicegeodata.address.road

#For example, this will return the display name containing street name, country, etc. Use whichever is needed from above list in the "Write-Output"

Write-Output $devicegeofull
