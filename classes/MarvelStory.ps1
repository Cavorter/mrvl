class MarvelStory : MarvelResource {
    # The story title.
    [string]$title

    # A short description of the story.
    [string]$description

    # The story type e.g. interior story, cover, text story.
    [string]$type

    hidden [MarvelResourceList]$Stories

    # A summary representation of the issue in which this story was originally published.
    [MarvelComic]$originalissue
}