function Get-1PasswordPassword {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Name,
        [Parameter(Mandatory = $true)]
        [String]
        $Vault
    )

    begin {
        Write-LogMessage -Message "Started execution"
    }

    process {
        return (op get item "$Name" "--vault=$Vault" | ConvertFrom-Json).details.password
    }

    end {
        Write-LogMessage -Message "Finished execution"
    }
}
