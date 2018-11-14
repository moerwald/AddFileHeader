<#
.SYNOPSIS

Recursive search in given $DirectoryToSearchThrough for $IncludeFilePattern. 
Adds file header to all found files.

.EXAMPLE
C:\PS>$fh = "///`r`n// MyCompany Bla Bla Bla`r`n///`r`n"
C:\PS>Add-FileHeader -DirectoryToSearchThrough . -IncludeFilePattern "*.cs" -FileHeaderToAdd $fh




#>

function Add-FileHeader {
        [CmdletBinding()]
        Param(
                [Parameter(Mandatory=$true)]
                [ValidateScript({ Test-Path $_ })] 
                [string] $DirectoryToSearchThrough,

                [Parameter(Mandatory=$true)]
                [ValidateNotNullOrEmpty ()]
                [ValidateScript({ $_ -ge 1 })] 
                [string[]] $IncludeFilePattern,

                [Parameter(Mandatory=$true)]
                [ValidateNotNull()] 
                [string] $FileHeaderToAdd,

                [Parameter(Mandatory=$false)]
                [ValidateNotNullOrEmpty ()]
                [ValidateScript({ $_ -ge 1 })] 
                [string[]] $ExcludeFilePattern
        )

        Get-ChildItem -Path $DirectoryToSearchThrough -Include $IncludeFilePattern -Exclude $ExcludeFilePattern -Recurse | `
        ForEach-Object {
                Write-Host "Working on $($_.Name)"

                $content = Get-Content $_; 
                Set-Content -Path $_.FullName -Value $FileHeaderToAdd, $content;
        }
}
