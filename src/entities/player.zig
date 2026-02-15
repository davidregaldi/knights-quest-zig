const std = @import("std");
const Item = @import("item.zig").Item;
const itemsDB = @import("../data/items-db.zig");

pub const Position = struct {
    x: i16 = 0,
    y: i16 = 0,
};

pub const Player = struct {
    name: []const u8,
    level: u16,
    class: Class,
    position: Position = .{},

    // Equipment slots
    head: Item = itemsDB.emptyHead,
    body: Item = itemsDB.emptyBody,
    mainHand: Item = itemsDB.emptyMainHand,
    offHand: Item = itemsDB.emptyOffHand,
    gloves: Item = itemsDB.emptyGloves,
    belt: Item = itemsDB.emptyBelt,
    boots: Item = itemsDB.emptyBoots,
    ringLeft: Item = itemsDB.emptyRingLeft,
    ringRight: Item = itemsDB.emptyRingRight,
    amulet: Item = itemsDB.emptyAmulet,
    unlockedSlots: u8,
    inventory: [16]Item = [_]Item{itemsDB.emptyItem} ** 16,
    gold: u16 = 100,

    // Base Attributes
    baseStrength: u16,
    baseDexterity: u16,
    baseVitality: u16,
    baseMagic: u16,
    baseHealthMax: u16 = 1,
    baseManaMax: u16 = 0,
    baseArmor: u16,
    baseCritical: u16 = 3,
    baseHit: u16,

    // Bonus from items
    bonusStrength: u16 = 0,
    bonusDexterity: u16 = 0,
    bonusVitality: u16 = 0,
    bonusMagic: u16 = 0,
    bonusHealthMax: u16 = 0,
    bonusManaMax: u16 = 0,
    bonusArmor: u16 = 0,
    bonusCritical: u16 = 0,
    bonusHit: u16 = 0,

    // Final Attributes (Base + Bonus)
    finalStrength: u16 = 0,
    finalDexterity: u16 = 0,
    finalVitality: u16 = 0,
    finalMagic: u16 = 0,
    finalHealthMax: u16 = 0,
    finalManaMax: u16 = 0,
    finalArmor: u16 = 0,
    finalCritical: u16 = 0,
    finalHit: u16 = 0,

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
            .baseArmor = switch (options.class) {
                .Knight => 2,
                .Rogue => 1,
                .Sorcerer => 0,
            },
            .baseHit = switch (options.class) {
                .Knight => 50,
                .Rogue => 55,
                .Sorcerer => 45,
            },
            .unlockedSlots = switch (options.class) {
                .Knight => 12,
                .Rogue => 10,
                .Sorcerer => 8,
            },
            .mainHand = switch (options.class) {
                .Knight => itemsDB.shortSword,
                .Rogue => itemsDB.shortBow,
                .Sorcerer => itemsDB.dagger,
            },
            .offHand = switch (options.class) {
                .Knight => itemsDB.buckler,
                .Rogue => itemsDB.basicArrow,
                .Sorcerer => itemsDB.smallBook,
            },
        };
        player.inventory[0] = itemsDB.smallHealthPotion;
        player.inventory[1] = itemsDB.smallManaPotion;

        player.updateStats();
        player.resetLifeAndMana();
        std.debug.print("{s} entered the game.\nLevel {d} {s}\n", .{ player.name, player.level, @tagName(player.class) });
        std.debug.print("-\n", .{});
        player.printPosition();
        player.printStats();
        player.printEquiped();
        player.printInventory();
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

    pub fn printEquiped(self: *Player) void {
        std.debug.print("Equipment: \n", .{});
        std.debug.print("Head: {s}\n", .{self.head.name});
        std.debug.print("Body: {s}\n", .{self.body.name});
        std.debug.print("Main Hand: {s}\n", .{self.mainHand.name});
        std.debug.print("Off Hand: {s}\n", .{self.offHand.name});
        std.debug.print("Gloves: {s}\n", .{self.gloves.name});
        std.debug.print("Belt: {s}\n", .{self.belt.name});
        std.debug.print("Boots: {s}\n", .{self.boots.name});
        std.debug.print("Ring Left: {s}\n", .{self.ringLeft.name});
        std.debug.print("Ring Right: {s}\n", .{self.ringRight.name});
        std.debug.print("Amulet: {s}\n", .{self.amulet.name});
        std.debug.print("-\n", .{});
    }

    pub fn printInventory(self: *Player) void {
        std.debug.print("Inventory: ", .{});
        var slotLeft = self.unlockedSlots;
        for (self.inventory) |item| {
            if (std.mem.eql(u8, item.name, "Empty")) {
                continue;
            } else {
                slotLeft -= 1;
                std.debug.print("{s}, ", .{item.name});
            }
        }
        std.debug.print("\nSlots: {d}/{d}\n", .{ slotLeft, self.unlockedSlots });
        std.debug.print("Gold: {d}\n", .{self.gold});
        std.debug.print("-\n", .{});
    }

    pub fn printPosition(self: *Player) void {
        std.debug.print("x: {d} y: {d}\n", .{ self.position.x, self.position.y });
        std.debug.print("-\n", .{});
    }

    pub fn printStats(self: *Player) void {
        std.debug.print("Base attributes: Strength: {d} | Dexterity: {d} | Vitality: {d} | Magic: {d} | Armor: {d} | Critical: {d}% | hit: {d}%\n", .{ self.baseStrength, self.baseDexterity, self.baseVitality, self.baseMagic, self.baseArmor, self.baseCritical, self.baseHit });
        std.debug.print("Bonus attributes: Strength: {d} | Dexterity: {d} | Vitality: {d} | Magic: {d} | Armor: {d} | Critical: {d}% | hit: {d}%\n", .{ self.bonusStrength, self.bonusDexterity, self.bonusVitality, self.bonusMagic, self.bonusArmor, self.bonusCritical, self.bonusHit });
        std.debug.print("Final attributes: Strength: {d} | Dexterity: {d} | Vitality: {d} | Magic: {d} | Armor: {d} | Critical: {d}% | hit: {d}%\n", .{ self.finalStrength, self.finalDexterity, self.finalVitality, self.finalMagic, self.finalArmor, self.finalCritical, self.finalHit });
        std.debug.print("Life: {d}/{d} Mana: {d}/{d}\n", .{ self.health, self.finalHealthMax, self.mana, self.finalManaMax });
        std.debug.print("Experience: {d}/{d}\n", .{ self.experience, self.experienceMax });
        std.debug.print("-\n", .{});
    }

    pub fn resetLifeAndMana(self: *Player) void {
        self.health = self.finalHealthMax;
        self.mana = self.finalManaMax;
    }

    pub fn updateStats(self: *Player) void {
        const equipment = [_]Item{
            self.head,      self.body,   self.mainHand, self.offHand,
            self.gloves,    self.belt,   self.boots,    self.ringLeft,
            self.ringRight, self.amulet,
        };

        self.bonusStrength = 0;
        self.bonusDexterity = 0;
        self.bonusVitality = 0;
        self.bonusMagic = 0;
        self.bonusArmor = 0;
        self.bonusCritical = 0;
        self.bonusHit = 0;
        self.bonusHealthMax = 0;
        self.bonusManaMax = 0;

        for (equipment) |item| {
            self.bonusStrength += item.strength;
            self.bonusDexterity += item.dexterity;
            self.bonusVitality += item.vitality;
            self.bonusMagic += item.magic;
            self.bonusArmor += item.armor;
            self.bonusCritical += item.critical;
            self.bonusHit += item.hit;
            self.bonusHealthMax += item.health;
            self.bonusManaMax += item.mana;
        }

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
        self.experienceMax = @intCast((@as(u32, 65535) * @as(u32, self.level + 1) * (self.level + 1)) / (51 * 51));

        // Final stats calculation
        self.finalStrength = self.baseStrength + self.bonusStrength;
        self.finalDexterity = self.baseDexterity + self.bonusDexterity;
        self.finalVitality = self.baseVitality + self.bonusVitality;
        self.finalMagic = self.baseMagic + self.bonusMagic;
        self.finalArmor = switch (self.class) {
            .Knight => (2 + self.level) + self.bonusArmor + (self.finalDexterity / 5),
            .Rogue => (1 + self.level * 2 / 3) + self.bonusArmor + (self.finalDexterity / 5),
            .Sorcerer => (self.level / 2) + self.bonusArmor + (self.finalDexterity / 5),
        };
        self.finalCritical = self.baseCritical + (self.level / 10) + self.bonusCritical + (self.finalDexterity / 10);
        self.finalHit = self.baseHit + self.bonusHit;
        self.finalHealthMax = self.baseHealthMax + self.bonusHealthMax;
        self.finalManaMax = self.baseManaMax + self.bonusManaMax;
    }
};
