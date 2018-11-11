struct Metric
    name::String
    alltime::Int
    fiveyears::Int
end

function fetchstats(userid::AbstractString)

    response = HTTP.request("GET", "https://scholar.google.com/citations?user=$(userid)")
    html = parsehtml(String(response.body))

    # Assumes a thead, tbody table structure
    tbody = first(elem for elem in PreOrderDFS(html.root)
                  if (elem isa HTMLElement{:table} &&
                     getattr(elem, "id") == "gsc_rsb_st"))[2]

    return [parsestats(tr) for tr in tbody.children if tr isa HTMLElement{:tr}]

end

parsestats(tr::HTMLElement{:tr}) = Metric(
    firsttext(tr[1]),
    parse(Int, firsttext(tr[2])),
    parse(Int, firsttext(tr[3]))
)

firsttext(node::HTMLText) = text(node)
firsttext(node::HTMLElement) =
    first(text(elem) for elem in StatelessBFS(node) if elem isa HTMLText)




