class MarvelComic : MarvelResource {
    # The ID of the digital comic representation of this comic. Will be 0 if the comic is not available digitally.
    [int]$digitalId

    # The canonical title of the comic.
    [string]$title

    # The number of the issue in the series (will generally be 0 for collection formats).
    [int]$issueNumber

    # If the issue is a variant (e.g. an alternate cover, second printing, or director's cut), a text description of the variant.
    [string]$variantDescription

    # The preferred description of the comic.
    [string]$description

    # The ISBN for the comic (generally only populated for collection formats).
    [string]$isbn

    # The UPC barcode number for the comic (generally only populated for periodical formats).
    [string]$upc

    # The Diamond code for the comic.
    [string]$diamondCode

    # The EAN barcode for the comic.
    [string]$ean

    # The ISSN barcode for the comic.
    [string]$issn

    # The publication format of the comic e.g. comic, hardcover, trade paperback.
    [string]$format

    # The number of story pages in the comic.
    [int]$pageCount

    # A set of descriptive text blurbs for the comic.
    [MarvelText[]]$textObjects

    # A summary representation of the series to which this comic belongs.
    [MarvelResource]$series

    # A list of variant issues for this comic (includes the "original" issue if the current issue is a variant).
    [MarvelComic[]]$variants

    # A list of collections which include this comic (will generally be empty if the comic's format is a collection).
    [MarvelComic[]]$collections

    # A list of issues collected in this comic (will generally be empty for periodical formats such as "comic" or "magazine").
    [MarvelComic[]]$collectedIssues

    # A list of key dates for this comic.
    [MarvelDate[]]$dates

    # A list of prices for this comic.
    [MarvelPrice[]]$prices

    # A list of promotional images associated with this comic.
    [MarvelImage[]]$images
}