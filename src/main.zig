const std = @import("std");
const Player = @import("entities/player.zig").Player;
const cls = @import("utils/colors.zig");

pub fn main() !void {

    // init buffers
    var stdin_buffer: [4096]u8 = undefined;
    var stdin_reader = std.fs.File.stdin().reader(&stdin_buffer);
    const reader = &stdin_reader.interface;

    var stdout_buffer: [4096]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    try stdout.print("{s}", .{cls.clear});
    try stdout.print("-\n{s}{s}{s}Welcome to Knight's Quest!{s}\n-\n", .{ cls.bold, cls.underline, cls.yellow, cls.reset });
    try stdout.flush();

    var p1 = Player.init(.{ .name = "Eidknab", .level = 1, .class = Player.Class.Knight });
    p1.levelUp();

    // _ = try reader.discardDelimiterInclusive('\n');
    while (true) {
        try stdout.print("\nType {s}'start'{s} or {s}'quit'{s}: ", .{ cls.bold, cls.reset, cls.bold, cls.reset });
        try stdout.flush();
        const userInput = try reader.takeDelimiter('\n') orelse "";
        if (std.mem.eql(u8, userInput, "start")) {
            try stdout.print("Starting game...\n", .{});
            try stdout.flush();
            break;
        } else if (std.mem.eql(u8, userInput, "quit")) {
            try stdout.print("Quitting game.\n", .{});
            try stdout.flush();
            return;
        } else {
            try stdout.print("Invalid input.", .{});
            try stdout.flush();
        }
    }
}
