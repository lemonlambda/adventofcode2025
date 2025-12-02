using day2

function main()
    puzzle_input :: Vector{String} = day2.load_puzzle_input()

    invalid_id_total :: Int = 0

    for range_string in puzzle_input
        a, b :: Int = day2.get_range(range_string)
        print("Range $a to $b\n")

        for num in a:b
            if day2.has_repeated_sequence(num)
                print("Found invalid id: $num\n")
                invalid_id_total += num
            end
        end
    end

    print("Total: $invalid_id_total\n")
end

main()
