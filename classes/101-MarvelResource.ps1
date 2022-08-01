class MarvelResource {
    # The unique ID of the resource.
    [int]$Id

    # The date the resource was most recently modified.
    [datetime]$Modified

    # The canonical URL identifier for this resource.
    [uri]$ResourceURI

    # The representative image for this resource.
    [MarvelImage]$Thumbnail

    # A set of public web site URLs for the resource.
    [MarvelUrl[]]$Urls

    # A resource list containing the creators associated with this comic.
    [MarvelResourceList]$Creators

    # A resource list containing comics which feature this resource.
    [MarvelResourceList]$Comics
    
    # A resource list containing the characters which appear in this comic.
    [MarvelResourceList]$Characters

    # A resource list of stories in which this resource appears.
    [MarvelResourceList]$Stories
    
    # A resource list of events in which this resource appears.
    [MarvelResourceList]$Events
    
    # A resource list of series in which this resource appears.
    [MarvelResourceList]$Series

    MarvelResource () {}

    MarvelResource ( [psobject]$InputObject ) {
        $simpleProps = @( 'id', 'modified', 'resourceURI' )
        foreach ( $item in $simpleProps ) { $this."$item" = $InputObject."$item" }

        $this.thumbnail = [MarvelImage]$InputObject.thumbnail
        $this.urls = [MarvelUrl[]]$InputObject.urls

        $lists = @( 'creators' , 'comics' , 'characters' , 'stories' , 'events' , 'series' )
        foreach ( $item in $lists ) { $this."$item" = [MarvelResourceList]$InputObject."$item" }
    }
}