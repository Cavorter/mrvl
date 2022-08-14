function Get-Event {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidOverwritingBuiltInCmdlets", Justification = "Module adds prefix so does not clobber.")]
    Param()

    Begin {
        throw [NotImplementedException]'Get-Event is not implemented.'
    }
}

# Export-ModuleMember -Function Get-Event