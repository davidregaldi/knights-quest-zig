const Item = @import("../entities/item.zig").Item;

// Constantes pour les objets vides
pub const emptyHead = Item{ .name = "Empty", .itemType = .head };
pub const emptyBody = Item{ .name = "Empty", .itemType = .body };
pub const emptyMainHand = Item{ .name = "Empty", .itemType = .mainHand };
pub const emptyOffHand = Item{ .name = "Empty", .itemType = .offHand };
pub const emptyGloves = Item{ .name = "Empty", .itemType = .gloves };
pub const emptyBelt = Item{ .name = "Empty", .itemType = .belt };
pub const emptyBoots = Item{ .name = "Empty", .itemType = .boots };
pub const emptyRingLeft = Item{ .name = "Empty", .itemType = .ringLeft };
pub const emptyRingRight = Item{ .name = "Empty", .itemType = .ringRight };
pub const emptyAmulet = Item{ .name = "Empty", .itemType = .amulet };
pub const emptyItem = Item{ .name = "Empty", .itemType = .head }; // for inventory

// Objets du jeu

// mainHand
pub const dagger = Item{
    .name = "Dagger",
    .itemType = .mainHand,
    .minDamage = 1,
    .maxDamage = 3,
    .magic = 1,
};

pub const shortBow = Item{
    .name = "Short Bow",
    .itemType = .mainHand,
    .minDamage = 1,
    .maxDamage = 3,
    .dexterity = 1,
};

pub const shortSword = Item{
    .name = "Short Sword",
    .itemType = .mainHand,
    .minDamage = 2,
    .maxDamage = 4,
    .strength = 1,
};

// offHand
pub const basicArrow = Item{
    .name = "Basic Arrow",
    .itemType = .offHand,
    .damage = 1,
};

pub const buckler = Item{
    .name = "Buckler",
    .itemType = .offHand,
    .armor = 2,
};

pub const smallBook = Item{
    .name = "Small Book",
    .itemType = .offHand,
    .magic = 1,
};

// potions
pub const smallHealthPotion = Item{
    .name = "Health Potion",
    .itemType = .potion,
    .health = 40,
};

pub const smallManaPotion = Item{
    .name = "Mana Potion",
    .itemType = .potion,
    .mana = 40,
};
