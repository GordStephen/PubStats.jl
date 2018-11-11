function writeresults(file::AbstractString, name::AbstractString, date::Date, results::Array{Metric})

    open(file, truncate=false, append=true) do f::IOStream

        for r in results
            writeresults(f, [name, date, r.name, "All Time", r.alltime])
            writeresults(f, [name, date, r.name, "Five Years", r.fiveyears])
        end

    end

end

function writeresults(f::IOStream, resultdata::Vector)
    join(f, resultdata, ",")
    write(f, "\n")
end
