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
            overflowing_clamped_add(&current_code, rotation, 100);
        } else {
            overflowing_clamped_sub(&current_code, rotation, 100);
        }

        if (current_code == 0 or current_code == 100) {
            password += 1;
        }
        std.debug.print("{s} - {}\n", .{ line, current_code });
    }

    std.debug.print("password: {}\n", .{password});
}

fn overflowing_clamped_add(to_modify: *i32, value: i32, max_value: i32) void {
    if (to_modify.* + value > max_value) {
        to_modify.* = (to_modify.* + value) - max_value;
    } else {
        to_modify.* += value;
    }
}

fn overflowing_clamped_sub(to_modify: *i32, value: i32, max_value: i32) void {
    if (to_modify.* - value < 0) {
        to_modify.* = max_value - @as(i32, @intCast(@abs(to_modify.* - value)));
    } else {
        to_modify.* -= value;
    }
}

fn is_right(value: u8) bool {
    return value == 'R';
}
