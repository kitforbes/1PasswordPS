function Open-1PasswordAccount {
    [CmdletBinding(DefaultParameterSetName = 'Second')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Second')]
        [String]
        $SubDomain,
        [Parameter(Mandatory = $false, ParameterSetName = 'First')]
        [String]
        $Url = 'my.1password.com',
        [Parameter(Mandatory = $true, ParameterSetName = 'First')]
        [String]
        $EmailAddress,
        [Parameter(Mandatory = $true, ParameterSetName = 'First')]
        [String]
        $SecretKey
    )

    begin {
        Write-LogMessage -Message "Started execution"
    }

    process {
        if ($PSCmdlet.ParameterSetName -eq 'Second') {
            $sessionEnvironmentVariable = "OP_SESSION_$SubDomain"
            Set-EnvironmentVariable -Name "$sessionEnvironmentVariable" -Value $(op signin "$SubDomain" --output=raw)
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'First') {
            $sessionEnvironmentVariable = "OP_SESSION_$($Url.Split('.')[0])"
            Set-EnvironmentVariable -Name "$sessionEnvironmentVariable" -Value $(op signin "$Url" "$EmailAddress" "$SecretKey" --output=raw)
        }
    }

    end {
        Write-LogMessage -Message "Finished execution"
    }
}
