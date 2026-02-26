const std = @import("std");
const Player = @import("entities/player.zig").Player;
const cls = @import("utils/colors.zig");

pub fn main() !void {
    const io = std.Io.Threaded.global_single_threaded.io();

    // init 
    const stdin = std.Io.File.stdin();
    var stdin_buffer: [4096]u8 = undefined;
    var stdin_reader = stdin.reader(io, &stdin_buffer);
    const stdin_in = &stdin_reader.interface;

    const stdout = std.Io.File.stdout();
    var stdout_buffer: [4096]u8 = undefined;
    var stdout_writer = stdout.writer(io, &stdout_buffer);
    const stdout_out = &stdout_writer.interface;

    try stdout_out.print("{s}", .{cls.clear});
    try stdout_out.print("-\n{s}{s}{s}Welcome to Knight's Quest!{s}\n-\n", .{ cls.bold, cls.underline, cls.yellow, cls.reset });
    try stdout_writer.flush();

    var p1 = Player.init(.{ .name = "Eidknab", .level = 1, .class = Player.Class.Knight });
    p1.levelUp();

    while (true) {
        try stdout_out.print("\nType {s}'start'{s} or {s}'quit'{s}: ", .{ cls.bold, cls.reset, cls.bold, cls.reset });
        try stdout_writer.flush();
        
        // Read input line
        const userInput = stdin_in.takeDelimiter('\n') catch "" orelse "";
        if (std.mem.eql(u8, userInput, "start")) {
            try stdout_out.print("Starting game...\n", .{});
            try stdout_writer.flush();
            break;
        } else if (std.mem.eql(u8, userInput, "quit")) {
            try stdout_out.print("Quitting game.\n", .{});
            try stdout_writer.flush();
            return;
        } else {
            try stdout_out.print("Invalid input.", .{});
            try stdout_writer.flush();
        }
    }
}
