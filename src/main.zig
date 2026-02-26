const std = @import("std");
const Player = @import("entities/player.zig").Player;
const clr = @import("utils/colors.zig");
const csl = @import("utils/stdout.zig");

pub fn main() !void {
    try csl.print("{s}", .{clr.clear});
    try csl.print("-\n{s}{s}{s}Welcome to Knight's Quest!{s}\n-\n", .{ clr.bold, clr.underline, clr.brightYellow, clr.reset });
    try csl.flush();

    var p1 = Player.init(.{ .name = "Eidknab", .level = 1, .class = Player.Class.Knight });
    p1.levelUp();

    while (true) {
        try csl.print("\nType {s}{s}'start'{s} or {s}{s}'quit'{s}: ", .{ clr.brightGreen, clr.bold, clr.reset, clr.red, clr.bold, clr.reset });
        try csl.flush();

        // Read input line
        const userInput = csl.stdin_in.takeDelimiter('\n') catch "" orelse "";
        if (std.mem.eql(u8, userInput, "start")) {
            try csl.print("Starting game...\n", .{});
            try csl.flush();
            break;
        } else if (std.mem.eql(u8, userInput, "quit")) {
            try csl.print("Quitting game.\n", .{});
            try csl.flush();
            return;
        } else {
            try csl.print("Invalid input.", .{});
            try csl.flush();
        }
    }
}
