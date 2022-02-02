$TMPFolder = "./../TMP"
$SHPUrl = "https://lvmgeo.lvm.lv/PublicData/SHP/LVM_MEZA_AUTOCELI.zip" # from LVM OpenData

if (Test-Path $TMPFolder) { # clear TEMP folder
    Remove-Item $TMPFolder -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $TMPFolder
Invoke-WebRequest -Uri https://lvmgeo.lvm.lv/PublicData/SHP/LVM_MEZA_AUTOCELI.zip -OutFile $TMPFolder/achive.zip
Expand-Archive $TMPFolder/achive.zip -DestinationPath $TMPFolder


