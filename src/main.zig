const std = @import("std");

var zero = .{ "██████", "██  ██", "██  ██", "██  ██", "██████" };
var one = .{ "  ██  ", "████  ", "  ██  ", "  ██  ", "██████" };
var two = .{ "██████", "    ██", "██████", "██    ", "██████" };
var three = .{ "██████", "    ██", "██████", "    ██", "██████" };
var four = .{ "██  ██", "██  ██", "██████", "    ██", "    ██" };
var five = .{ "██████", "██    ", "██████", "    ██", "██████" };
var six = .{ "██████", "██    ", "██████", "██  ██", "██████" };
var seven = .{ "██████", "    ██", "    ██", "    ██", "    ██" };
var eight = .{ "██████", "██  ██", "██████", "██  ██", "██████" };
var nine = .{ "██████", "██  ██", "██████", "    ██", "██████" };
var colon = [_][]const u8{ "  ", "██", "  ", "██", "  " };
var colon0 = [_][]const u8{ "  ", "░░", "  ", "░░", "  " };

var digits = [_][]const []const u8{ &zero, &one, &two, &three, &four, &five, &six, &seven, &eight, &nine };

pub fn printColon() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    for (colon) |line| {
        try stdout.print("{s}\n", .{line});
    }

    try bw.flush();
}

pub fn range(len: usize) []const u0 {
    return @as([*]u0, undefined)[0..len];
}

pub fn printNumbers(m0: usize, m1: usize, s0: usize, s1: usize) !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    // try stdout.print("{s}", .{"\x1B[2J"}); // clear screen
    try stdout.print("{s}", .{"\x1B[5A"}); // move cursor up 5 lines

    for (range(5), 0..) |_, i| {
        const colonToUse = if (@rem(s1, 2) == 1) colon else colon0;

        try stdout.print("{s} {s} {s} {s} {s}\n", .{ digits[m0][i], digits[m1][i], colonToUse[i], digits[s0][i], digits[s1][i] });
    }

    try bw.flush();
}

pub fn main() !void {
    //try stdout.print("s{}", .{"\x1B[5A]"});
    for (0..25) |m| {
        for (0..60) |s| {
            const m0 = @divTrunc(24 - m, 10);
            const m1 = @rem(24 - m, 10);
            const s0 = @divTrunc(59 - s, 10);
            const s1 = @rem(59 - s, 10);
            try printNumbers(m0, m1, s0, s1);
            std.time.sleep(1000 * 1000 * 1000);
        }
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
