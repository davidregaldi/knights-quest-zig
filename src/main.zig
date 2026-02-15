const std = @import("std");
const Player = @import("entities/player.zig").Player;
const cls = @import("utils/colors.zig");

pub fn main() void {
    std.debug.print("{s}\n", .{cls.clear});
    std.debug.print("-\n{s}{s}{s}Welcome to Knight's Quest!{s}\n-\n", .{ cls.bold, cls.underline, cls.yellow, cls.reset });
    // var p1 = Player.init(.{});
    var p2 = Player.init(.{ .name = "Staïss", .level = 10, .class = Player.Class.Sorcerer });
    // var p3 = Player.init(.{ .name = "Zëss", .level = 1, .class = Player.Class.Sorcerer });

    p2.levelUp();
}
