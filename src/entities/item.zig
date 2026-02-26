const std = @import("std");

pub const Item = struct {
    name: []const u8,
    itemType: ItemType,
    price: u16 = 0,
    armor: u16 = 0,
    damage: u16 = 0,
    minDamage: u16 = 0,
    maxDamage: u16 = 0,
    strength: u16 = 0,
    dexterity: u16 = 0,
    vitality: u16 = 0,
    magic: u16 = 0,
    critical: u16 = 0,
    hit: u16 = 0,
    health: u16 = 0,
    mana: u16 = 0,

    pub const ItemType = enum { head, body, mainHand, offHand, gloves, belt, boots, ring, amulet, potion };

    pub fn init(name: []const u8, itemType: ItemType) Item {
        return Item{
            .name = name,
            .itemType = itemType,
        };
    }
};
