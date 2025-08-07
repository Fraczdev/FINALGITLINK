# PowerShell script to download missing assets from Linktree
# Run this script to download missing files

$baseUrl = "https://linktr.ee"
$assetsUrl = "https://assets.production.linktr.ee/profiles/_next/static"
$ugcUrl = "https://ugc.production.linktr.ee"

# Create directories if they don't exist
if (!(Test-Path "static\css")) { New-Item -ItemType Directory -Path "static\css" -Force }
if (!(Test-Path "static\logo-assets")) { New-Item -ItemType Directory -Path "static\logo-assets" -Force }

# Download missing CSS file
Write-Host "Downloading CSS file..."
try {
    Invoke-WebRequest -Uri "$assetsUrl/css/f14941bedd3564cd.css" -OutFile "static/css/f14941bedd3564cd.css"
    Write-Host "CSS file downloaded successfully"
} catch {
    Write-Host "Failed to download CSS file: $($_.Exception.Message)"
}

# Download missing manifest file
Write-Host "Downloading manifest file..."
try {
    Invoke-WebRequest -Uri "$assetsUrl/manifest.json" -OutFile "static/manifest.json"
    Write-Host "Manifest file downloaded successfully"
} catch {
    Write-Host "Failed to download manifest file: $($_.Exception.Message)"
}

# Download favicon files
Write-Host "Downloading favicon files..."
$faviconFiles = @(
    "favicon.ico",
    "favicon.png", 
    "favicon-96x96.png",
    "favicon-32x32.png",
    "favicon-16x16.png",
    "apple-icon-180x180.png",
    "apple-icon-152x152.png",
    "apple-icon-144x144.png",
    "apple-icon-120x120.png",
    "apple-icon-114x114.png",
    "apple-icon-72x72.png",
    "apple-icon-76x76.png",
    "apple-icon-60x60.png",
    "apple-icon-57x57.png",
    "ms-icon-310x310.png",
    "ms-icon-150x150.png",
    "ms-icon-70x70.png",
    "ms-icon-144x144.png"
)

foreach ($file in $faviconFiles) {
    try {
        Invoke-WebRequest -Uri "$assetsUrl/logo-assets/$file" -OutFile "static/logo-assets/$file"
        Write-Host "Downloaded $file"
    } catch {
        Write-Host "Failed to download $file : $($_.Exception.Message)"
    }
}

# Download profile images (these might not be available due to CORS)
Write-Host "Attempting to download profile images..."
$profileImages = @(
    "2c0d385b-d6fe-4a3e-90a5-06d2d2315290_7273dd07149113e0790c6019ece6ce1a-tplv-tiktokx-cropcenter-720-72042dc.jpg",
    "72172512-c9f4-4f97-a026-cc69b37c0c69_IMG-4004.qt",
    "1be3d36e-4a81-4ab4-860e-69fb247f4e3f_image31d8.jpg",
    "1be3d36e-4a81-4ab4-860e-69fb247f4e3f_image.png",
    "ebd27519-ac87-485e-b25c-f35752480961_thumbnail.jpeg"
)

if (!(Test-Path "static\images")) { New-Item -ItemType Directory -Path "static\images" -Force }

foreach ($image in $profileImages) {
    try {
        Invoke-WebRequest -Uri "$ugcUrl/$image`?io=true`&size=avatar-v3_0" -OutFile "static/images/$image"
        Write-Host "Downloaded $image"
    } catch {
        Write-Host "Failed to download $image : $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "Download complete! Check the static folder for downloaded files."
Write-Host "Note: Some external images may not be downloadable due to CORS restrictions."
