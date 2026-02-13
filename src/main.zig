const std = @import("std");
const Player = @import("entities/player.zig").Player;

pub fn main() void {
    std.debug.print("-\nWelcome to Knight's Quest!\n-\n", .{});
    var p1 = Player.init(.{});
    var p2 = Player.init(.{ .name = "Zëss", .level = 50, .class = Player.Class.Sorcerer });
    p1.levelUp();
    p2.levelUp();
    p1.printStats();
}
