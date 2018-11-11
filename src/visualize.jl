function genhtml(resultsfile::AbstractString)

    data = DataFrame(CSV.File(resultsfile, header=[:name, :date, :metric, :window, :value]))
    
    for metric in unique(data[:metric]), window in unique(data[:window])
        genhtml(data, metric, window)
    end

end

function genhtml(data::DataFrame, metric::AbstractString, window::AbstractString)

    preamble = """<!DOCTYPE html><html>
<head><script src="https://cdn.plot.ly/plotly-latest.min.js"></script></head>
<body><h1>$metric - $window</h1>
"""
    postamble = "</body></html>"

    plotdata = @where(data, :metric .== metric, :window .== window)
    p = Plot(plotdata, group=:name, x=:date, y=:value, kind="scatter", mode="lines+markers")
    html = PlotlyJS.html_body(p)
    write("plots/$(metric)_$(window).html", preamble * html * postamble)

end
