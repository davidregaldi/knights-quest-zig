const std = @import("std");

pub const Player = struct {
    name: []const u8,
    level: u16,
    class: Class,

    // Base Attributes
    baseStrength: u16,
    baseDexterity: u16,
    baseVitality: u16,
    baseMagic: u16,
    baseHealthMax: u16 = 1,
    baseManaMax: u16 = 0,

    // Bonus from items
    bonusStrength: u16 = 0,
    bonusDexterity: u16 = 0,
    bonusVitality: u16 = 0,
    bonusMagic: u16 = 0,
    bonusHealthMax: u16 = 0,
    bonusManaMax: u16 = 0,

    // Final Attributes (Base + Bonus)
    finalStrength: u16 = 0,
    finalDexterity: u16 = 0,
    finalVitality: u16 = 0,
    finalMagic: u16 = 0,
    finalHealthMax: u16 = 0,
    finalManaMax: u16 = 0,

    health: u16 = 1,
    mana: u16 = 0,
    experience: u16 = 0,
    experienceMax: u16 = 1,

    pub const Class = enum {
        Knight,
        Rogue,
        Sorcerer,
    };

    pub fn init(options: struct { name: []const u8 = "Eidknab", level: u16 = 1, class: Class = .Knight }) Player {
        var player = Player{
            .name = options.name,
            .level = options.level,
            .class = options.class,
            .baseStrength = switch (options.class) {
                .Knight => 30,
                .Rogue => 20,
                .Sorcerer => 15,
            },
            .baseDexterity = switch (options.class) {
                .Knight => 20,
                .Rogue => 30,
                .Sorcerer => 15,
            },
            .baseVitality = switch (options.class) {
                .Knight => 25,
                .Rogue => 20,
                .Sorcerer => 20,
            },
            .baseMagic = switch (options.class) {
                .Knight => 10,
                .Rogue => 20,
                .Sorcerer => 35,
            },
        };
        player.updateStats();
        player.resetLifeAndMana();
        player.printStats();
        return player;
    }

    pub fn levelUp(self: *Player) void {
        if (self.level >= 50) {
            self.level = 50;
        } else {
            self.level += 1;
            self.experience = 0;
            self.updateStats();
            std.debug.print("Level Up! {s} is now level {d}.\n", .{ self.name, self.level });
            std.debug.print("-\n", .{});
            self.resetLifeAndMana();
        }
    }

    pub fn printStats(self: *Player) void {
        std.debug.print("{s} entered the game.\nLevel {d} {s}\n", .{ self.name, self.level, @tagName(self.class) });
        std.debug.print("Base attributes: Strength: {d} | Dexterity: {d} | Vitality: {d} | Magic: {d}\n", .{ self.baseStrength, self.baseDexterity, self.baseVitality, self.baseMagic });
        std.debug.print("Bonus attributes: Strength: {d} | Dexterity: {d} | Vitality: {d} | Magic: {d}\n", .{ self.bonusStrength, self.bonusDexterity, self.bonusVitality, self.bonusMagic });
        std.debug.print("Final attributes: Strength: {d} | Dexterity: {d} | Vitality: {d} | Magic: {d}\n", .{ self.finalStrength, self.finalDexterity, self.finalVitality, self.finalMagic });
        std.debug.print("Life: {d}/{d} Mana: {d}/{d}\n", .{ self.health, self.finalHealthMax, self.mana, self.finalManaMax });
        std.debug.print("Experience: {d}/{d}\n", .{ self.experience, self.experienceMax });
        std.debug.print("-\n", .{});
    }

    pub fn resetLifeAndMana(self: *Player) void {
        self.health = self.finalHealthMax;
        self.mana = self.finalManaMax;
    }

    pub fn updateStats(self: *Player) void {
        self.baseHealthMax = switch (self.class) {
            .Knight => self.baseVitality * 2 + self.level * 2 + 20,
            .Rogue => self.baseVitality * 3 / 2 + self.level * 2 + 15,
            .Sorcerer => self.baseVitality + self.level + 10,
        };
        self.baseManaMax = switch (self.class) {
            .Knight => self.baseMagic + self.level,
            .Rogue => self.baseMagic * 3 / 2 + self.level * 2,
            .Sorcerer => self.baseMagic * 2 + self.level * 2,
        };

        // Gauss quadratic formula (max level 50)
        self.experienceMax = @intCast((@as(u32, 65535) * @as(u32, self.level + 1) * (self.level + 1)) / (51*51));
        self.finalStrength = self.baseStrength + self.bonusStrength;
        self.finalDexterity = self.baseDexterity + self.bonusDexterity;
        self.finalVitality = self.baseVitality + self.bonusVitality;
        self.finalMagic = self.baseMagic + self.bonusMagic;
        self.finalHealthMax = self.baseHealthMax + self.bonusHealthMax;
        self.finalManaMax = self.baseManaMax + self.bonusManaMax;
    }
};
