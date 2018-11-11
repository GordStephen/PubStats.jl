function runupdate(namesfile::AbstractString, resultsfile::AbstractString; delay::Float64=5.)

    println("Updating stats in $(resultsfile) based on $(namesfile)...")

    for line in readlines(namesfile)

        # Lines in namesfile should conform to the format
        # Rearcher Name = googlescholarid
        name, gsid = strip.(split(line, '=', limit=2))

        println("Adding latest stats for $(name)"...)
        writeresults(resultsfile, name, today(), fetchstats(gsid))
        timedwait(() -> false, delay) # Don't annoy Google

    end

    println("Update finished successfully.")

end
