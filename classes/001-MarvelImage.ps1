class MarvelImage {
    # The directory path of to the image.
    [ValidateNotNullOrEmpty()]
    [string]$path

    # The file extension for the image.
    [MarvelImageExtensions]$extension

    MarvelImage ([psobject]$InputObject ) {
        $This.path = $InputObject.path
        $this.extension = $InputObject.extension
    }
}