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
        $SecretKey
    )

    begin {
    }

    process {
        $sessionEnvironmentVariable = "OP_SESSION_$SubDomain"
        if ($PSCmdlet.ParameterSetName -eq 'A') {
            [Environment]::SetEnvironmentVariable("$sessionEnvironmentVariable", $(op signin "$SubDomain" --output=raw))
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'B') {
            [Environment]::SetEnvironmentVariable("$sessionEnvironmentVariable", $(op signin "$Url" "$SecretKey" --output=raw))
        }
    }

    end {
    }
}
