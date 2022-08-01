class MarvelCharacter : MarvelResource {
    # The name of the character.
    [string]$name

    # A short bio or description of the character.
    [string]$description

    hidden [MarvelResourceList]$Creators
    hidden [MarvelResourceList]$Characters
}