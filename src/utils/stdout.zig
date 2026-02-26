const std = @import("std");

// Init
const io = std.Io.Threaded.global_single_threaded.io();
const stdin = std.Io.File.stdin();
var stdin_buffer: [4096]u8 = undefined;
var stdin_reader = stdin.reader(io, &stdin_buffer);
pub const stdin_in = &stdin_reader.interface;

const stdout = std.Io.File.stdout();
var stdout_buffer: [4096]u8 = undefined;
var stdout_writer = stdout.writer(io, &stdout_buffer);
pub const stdout_out = &stdout_writer.interface;

pub fn print(comptime fmt: []const u8, args: anytype) !void {
    try stdout_out.print(fmt, args);
    try stdout_out.flush();
}

pub fn flush() !void {
    try stdout_out.flush();
}
