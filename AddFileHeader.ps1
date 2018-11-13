
function Add-FileHeader {
        Param(
                [string] $DirectoryToSearchThrough ,
                [string] $FilePrefixToSearch,
                [sring] $FileSuffixToExclude
        )

        Get-ChildItem -Path $DirectoryToSearchThrough -Include $FilePrefixToSearch -Exclude $FileSuffixToExclude -Recurse | ForEach-Object {
                Write-Host "Working on $($_.Name)"
                $fileName = $_.Name

                $content = Get-Content $_; 
                Set-Content -Path $_.FullName -Value "/// Test`n///MyCompany`n////`n", $content;
        }
}
