<#
    .SYNOPSIS
        Find an available SamAccountName.

    .DESCRIPTION
        This finds an available SamAccountName from a given First Name and Surname. It will check if the Given Name of the user is an available SamAccountName. If it is already taken it will extend the Given Name of the user with an additional letter from its Surname. If this is also taken it will continue until a combintaion of the Given Name of the user plus some letters from its Surname is available as a SamAccountName.

    .PARAMETER  GivenName
        Given Name of the user.

    .PARAMETER  Surname
        Surname of the user.

    .EXAMPLE
        PS C:\> Find-AvailableSamAccountName -GivenName 'Johann' -Surname 'Strauss'

    .EXAMPLE
        PS C:\> Find-AvailableSamAccountName -GivenName 'Albert' -Surname 'Einstein'

    .INPUTS
        System.String

    .OUTPUTS
        System.String

#>
Function Find-AvailableSamAccountName {
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [alias('GN','FirstName','Name')]
        [System.String]
        $GivenName,

        [Parameter(Position=1, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [alias('LastName','FamilyName')]
        [System.String]
        $Surname
    )
    try {
        If(Get-ADUser -Identity $GivenName){
            $GivenName = $GivenName + $Surname.substring(0,1)
            $Surname = $Surname.Substring(1)
            Find-AvailableSamAccountName -GivenName $GivenName -Surname $Surname
        }
    }
    catch {
        $GivenName
    }
}