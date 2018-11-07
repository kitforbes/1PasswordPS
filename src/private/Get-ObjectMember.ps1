function Get-ObjectMember {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSCustomObject]
        $Object
    )

    begin {
    }

    process {
        $output = $Object | Get-Member -MemberType NoteProperty | ForEach-Object {
            $key = $_.Name
            [PSCustomObject] @{
                Key   = $key
                Value = $Object."$key"
            }
        }

        return $output
    }

    end {
    }
}
