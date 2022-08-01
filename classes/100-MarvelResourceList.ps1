class MarvelResourceList {
    # The number of total available resources in this list
    [int]$Available

    # The number of resources returned in this resource list (up to 20).
    [int]$Returned

    # The path to the list of full view representations of the items in this resource list.
    [uri]$CollectionURI

    # summary representations]	A list of summary views of the items in this resource list.
    [MarvelReference[]]$Items

    MarvelResourceList ([psobject]$InputObject) {
        foreach ( $item in @( 'available' , 'returned' , 'collectionURI' ) ) { $this."$item" = $InputObject."$item" }
        $this.items = [MarvelReference[]]$InputObject.items
    }
}