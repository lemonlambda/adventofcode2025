const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    // Get the contents of the puzzle_input file
    const puzzle_input = try std.fs.cwd().readFileAlloc(alloc, "puzzle_input", std.math.maxInt(usize));
    defer alloc.free(puzzle_input);

    var puzzle_input_split = std.mem.splitScalar(u8, puzzle_input, '\n');

    var password: i32 = 0;
    var current_code: i32 = 50;

    while (puzzle_input_split.next()) |line| {
        if (line.len == 0) {
            continue;
        }

        const rotation = try std.fmt.parseInt(i32, line[1..], 10);

        if (is_right(line[0])) {
            go_right(&current_code, rotation, 100);
        } else {
            go_left(&current_code, rotation, 100);
        }

        if (current_code == 0 or current_code == 100) {
            password += 1;
        }
        std.debug.print("{s} - {}\n", .{ line, current_code });
    }

    std.debug.print("password: {}\n", .{password});
}

fn go_right(to_modify: *i32, value: i32, max_value: i32) void {
    to_modify.* = @mod(to_modify.* + value, max_value);
}

fn go_left(to_modify: *i32, value: i32, max_value: i32) void {
    to_modify.* = @mod(to_modify.* - value, max_value);
}

fn is_right(value: u8) bool {
    return value == 'R';
}
