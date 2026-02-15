const std = @import("std");
const Player = @import("entities/player.zig").Player;

pub fn main() void {
    std.debug.print("-\nWelcome to Knight's Quest!\n-\n", .{});
    // var p1 = Player.init(.{});
    var p2 = Player.init(.{ .name = "Staïss", .level = 1, .class = Player.Class.Rogue });
    // var p3 = Player.init(.{ .name = "Zëss", .level = 1, .class = Player.Class.Sorcerer });

    p2.levelUp();
}
