class MarvelCreator : MarvelResource {
    # The first name of the creator.
    [string]$firstName

    # The middle name of the creator.
    [string]$middleName

    # The last name of the creator.
    [string]$lastName

    # The suffix or honorific for the creator.
    [string]$suffix

    # The full name of the creator (a space-separated concatenation of the above four fields).
    [string]$fullName

    hidden [MarvelResourceList]$Creators
    hidden [MarvelResourceList]$Characters
}