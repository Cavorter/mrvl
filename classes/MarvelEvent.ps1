class MarvelEvent : MarvelResource {
    # The title of the event.
    [string]$title

    # A description of the event.
    [string]$description

    # The date of publication of the first issue in this event.
    [datetime]$start

    # The date of publication of the last issue in this event.
    [datetime]$end

    # A summary representation of the event which follows this event.
    [MarvelEvent]$next

    # A summary representation of the event which preceded this event.
    [MarvelEvent]$previous

    hidden [MarvelResourceList]$Events
}