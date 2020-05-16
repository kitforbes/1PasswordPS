function Close-1PasswordAccount {
    [CmdletBinding()]
    param (
    )

    begin {
        Write-LogMessage -Message "Started execution"
    }

    process {
        op signout
    }

    end {
        Write-LogMessage -Message "Finished execution"
    }
}
