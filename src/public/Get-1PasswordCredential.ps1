function Get-1PasswordCredential {
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
        try {
            $fields = (op get item "$Name" "--vault=$Vault" | ConvertFrom-Json).details.fields

            return New-Credential `
                -UserName ($fields | Where-Object { $_.name -eq 'username' }).value `
                -Password (ConvertTo-SecureString -String ($fields | Where-Object { $_.name -eq 'password' }).value -AsPlainText -Force)
        }
        catch {
            return $null;
        }
    }

    end {
        Remove-Variable -Name 'fields' -Force
        Write-LogMessage -Message "Finished execution"
    }
}
