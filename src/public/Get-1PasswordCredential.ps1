function Get-1PasswordCredential {
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Name,
        [Parameter(Mandatory = $true)]
        [String]
        $Vault
    )

    end {
        $fields = (op get item "$Name" "--vault=$Vault" | ConvertFrom-Json).details.fields

        $parameters = @{
            TypeName     = 'System.Management.Automation.PSCredential'
            ArgumentList = @(
                ($fields | Where-Object { $_.name -eq 'username' }).value,
                ($fields | Where-Object { $_.name -eq 'password' }).value
            )
        }

        Remove-Variable -Name 'fields' -Force -Verbose
        return New-Object @parameters
    }
}
