class MarvelUrl {
    # A text identifier for the URL.
    [MarvelUrlTypes]$type

    # A full URL (including scheme, domain, and path).
    [string]$url

    MarvelUrl ( [psobject]$InputObject ) {
        $this.url = $InputObject.url
        $this.type = [MarvelUrlTypes]$InputObject.type
    }
}