class MarvelSeries : MarvelResource {
    # The canonical title of the series.
    [string]$Title

    # A description of the series.
    [string]$Description

    # The first year of publication for the series.
    [int]$StartYear

    # The last year of publication for the series (conventionally, 2099 for ongoing series).
    [int]$EndYear

    # The age-appropriateness rating for the series.
    [string]$Rating

    # A summary representation of the series which follows this series.
    [MarvelReference]$Next

    # A summary representation of the series which preceded this series.
    [MarvelReference]$Previous

    hidden [MarvelResourceList]$Series

    MarvelSeries ( [psobject]$InputObject ) : base($InputObject) {
        $simpleProps = @( 'title', 'description', 'startYear', 'endYear' , 'rating' )
        foreach ( $item in $simpleProps ) { $this."$item" = $InputObject."$item" }

        foreach ( $item in @( 'next' , 'previous' ) ) { $this."$item" = [MarvelReference]$InputObject."$item" }
    }
}