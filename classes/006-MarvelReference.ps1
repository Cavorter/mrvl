class MarvelReference {
    # The canonical URL identifier for this resource.
    [uri]$resourceURI

    # The name for the resource
    [string]$name

    MarvelReference ( [psobject]$InputObject ) {
        $this.resourceURI = $InputObject.resourceURI
        $this.name = $InputObject.name
    }
}