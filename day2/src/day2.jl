module day2

function load_puzzle_input() :: Vector{String}
    contents :: String = read("puzzle_input", String)
    return split(contents, ",")
end

function get_range(range :: String) :: Tuple{Int, Int}
    splitted :: Vector{String} = split(range, "-") # should always be length of 2
    return (parse(Int, splitted[1]), parse(Int, splitted[2]))
end

function has_repeated_sequence(n :: Int)
    n_string :: String = string(n)
    len :: Int = length(n_string)

    if len % 2 != 0
        return false
    end

    a = n_string[1:div(len, 2)]
    b = n_string[div(len, 2) + 1:len]

    return a == b
end

end # module day2
