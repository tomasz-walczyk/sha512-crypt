#
# Copyright (C) 2022 Tomasz Walczyk
#
# This software may be modified and distributed under the terms
# of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
# See the LICENSE file for details.
#
############################################################

Set-StrictMode -Version Latest

#-----------------------------------------------------------
# Check preconditions.
#-----------------------------------------------------------

$PackagePath=Get-Content -Path ENV:PACKAGE_PATH
$InstallPath=Get-Content -Path ENV:INSTALL_PATH
$PackageVersion=Get-Content -Path ENV:PACKAGE_VERSION

#-----------------------------------------------------------
# Create package.
#-----------------------------------------------------------

$PackageFileName="sha512-crypt-$PackageVersion-windows.zip"
$PackageFilePath="$PackagePath/$PackageFileName"
$HashFileName="${PackageFileName}.sha512"
$HashFilePath="${PackageFilePath}.sha512"

New-Item -Type Directory -Path $PackagePath | Out-Null
Compress-Archive -DestinationPath $PackageFilePath -Path $InstallPath/*
$PackageFileHash=(Get-FileHash -Path $PackageFilePath -Algorithm SHA512).Hash.ToLower()
$PackageFileHash | Out-File -FilePath $HashFilePath -Encoding ASCII -NoNewline

#-----------------------------------------------------------
# Set output variables.
#-----------------------------------------------------------

Write-Output "package_file_name=$PackageFileName" >> $env:GITHUB_OUTPUT
Write-Output "package_file_path=$PackageFilePath" >> $env:GITHUB_OUTPUT
Write-Output "hash_file_name=$HashFileName" >> $env:GITHUB_OUTPUT
Write-Output "hash_file_path=$HashFilePath" >> $env:GITHUB_OUTPUT
