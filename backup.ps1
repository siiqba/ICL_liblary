$files_to_backup = "D:\!!HERA\Biblioteki\ProtelDXP\ICL_liblary"

$backap_location = "X:\ICL_liblary"

$files_to_coppy = (Get-ChildItem $files_to_backup -Recurse -File).FullName
$folders_to_coppy = (Get-ChildItem $files_to_backup -Recurse -Directory).FullName

$index = $files_to_backup.LastIndexOf("\")
$folder_back = $files_to_backup.substring($index)
$backupdir=$backap_location +$folder_back+"_"+ (Get-Date -format dd_MM_yyyy_HH_mm)
Write-Output $backupdir


#$new_folder = -join($backap_location,"\back11")

New-Item -Path $backap_location -Name ($folder_back+"_"+ (Get-Date -format dd_MM_yyyy_HH_mm)) -ItemType "directory" 
foreach ($folder in $folders_to_coppy) {
	$folder_to_create = $folder.replace($files_to_backup, $backupdir)
	$index = $folder_to_create.LastIndexOf("\")
	$lenght = $folder_to_create.length
	$folder_path = $folder_to_create.substring(0,$index)
	$distance = $lenght - $index - 1
	$folder_name = $folder_to_create.substring(($index+1), $distance)
	Write-Output $folder_to_create
	#Write-Output $folder_path
	#Write-Output $folder_name
	New-Item -Path $folder_path -Name $folder_name -ItemType "directory" 
}

foreach ($file in $files_to_coppy) {
	#$temp_dest = -join((Get-ChildItem $files_to_backup -Directory).FullName
	
	#$index = $file.LastIndexOf("\")
	#$SplitBackup = $file.substring(0,$index)
	#Write-Output $file.replace($files_to_backup,"")
	#Write-Output "from: "$file
	#Write-Output "SplitBackup: "$SplitBackup
	$restpath = $file.replace($files_to_backup,"")
	#Write-Output "restpath: "$restpath
	#Copy-Item -Path $file -Destination $new_folder
	
	Write-Output "from: "$file
	$file_to = -join($backupdir,$restpath)
	Write-Output "to: "$file_to
	Copy-Item -Path $file -Destination $file_to
}
