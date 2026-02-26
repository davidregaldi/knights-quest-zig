const Item = @import("../entities/item.zig").Item;

// Constantes pour les objets vides
pub const emptyHead = Item{ .name = "Empty", .itemType = .head };
pub const emptyBody = Item{ .name = "Empty", .itemType = .body };
pub const emptyMainHand = Item{ .name = "Empty", .itemType = .mainHand };
pub const emptyOffHand = Item{ .name = "Empty", .itemType = .offHand };
pub const emptyGloves = Item{ .name = "Empty", .itemType = .gloves };
pub const emptyBelt = Item{ .name = "Empty", .itemType = .belt };
pub const emptyBoots = Item{ .name = "Empty", .itemType = .boots };
pub const emptyRing = Item{ .name = "Empty", .itemType = .ring };
pub const emptyAmulet = Item{ .name = "Empty", .itemType = .amulet };
pub const emptyItem = Item{ .name = "Empty", .itemType = .head }; // for inventory

// Objets du jeu

// head
pub const cap = Item{
    .name = "Cap",
    .itemType = .head,
    .armor = 2,
    .price = 10,
};

pub const skullCap = Item{
    .name = "Skull Cap",
    .itemType = .head,
    .armor = 4,
    .price = 25,
};

// mainHand
pub const dagger = Item{
    .name = "Dagger",
    .itemType = .mainHand,
    .minDamage = 1,
    .maxDamage = 3,
    .magic = 1,
    .price = 15,
};

pub const shortBow = Item{
    .name = "Short Bow",
    .itemType = .mainHand,
    .minDamage = 1,
    .maxDamage = 3,
    .dexterity = 1,
    .price = 20,
};

pub const shortSword = Item{
    .name = "Short Sword",
    .itemType = .mainHand,
    .minDamage = 2,
    .maxDamage = 4,
    .strength = 1,
    .price = 18,
};

// offHand
pub const basicArrow = Item{
    .name = "Basic Arrow",
    .itemType = .offHand,
    .damage = 1,
    .price = 2,
};

pub const buckler = Item{
    .name = "Buckler",
    .itemType = .offHand,
    .armor = 2,
    .price = 12,
};

pub const smallBook = Item{
    .name = "Small Book",
    .itemType = .offHand,
    .magic = 1,
    .price = 15,
};

// Boots
pub const raggedBoots = Item{
    .name = "Ragged Boots",
    .itemType = .boots,
    .armor = 2,
    .price = 15,
};

pub const heavyBoots = Item{
    .name = "Heavy Boots",
    .itemType = .boots,
    .armor = 6,
    .vitality = 2,
    .price = 55,
};

pub const swiftBoots = Item{
    .name = "Swift Boots",
    .itemType = .boots,
    .armor = 4,
    .dexterity = 2,
    .hit = 5,
    .price = 60,
};

pub const spiritBoots = Item{
    .name = "Spirit Boots",
    .itemType = .boots,
    .armor = 3,
    .magic = 1,
    .mana = 20,
    .price = 75,
};

// Amulets
pub const amuletOfVigor = Item{
    .name = "Amulet Of Vigor",
    .itemType = .amulet,
    .vitality = 2,
    .health = 10,
    .price = 50,
};

pub const amuletOfPrecision = Item{
    .name = "Amulet Of Precision",
    .itemType = .amulet,
    .dexterity = 2,
    .hit = 5,
    .price = 55,
};

pub const amuletOfWisdom = Item{
    .name = "Amulet Of Wisdom",
    .itemType = .amulet,
    .magic = 1,
    .mana = 20,
    .price = 60,
};

pub const amuletOfProtection = Item{
    .name = "Amulet Of Protection",
    .itemType = .amulet,
    .armor = 3,
    .price = 40,
};

// potions
pub const smallHealthPotion = Item{
    .name = "Small Health Potion",
    .itemType = .potion,
    .health = 40,
    .price = 8,
};

pub const smallManaPotion = Item{
    .name = "Small Mana Potion",
    .itemType = .potion,
    .mana = 40,
    .price = 8,
};

pub const strengthElixir = Item{
    .name = "Elixir Of Strength",
    .itemType = .potion,
    .strength = 1,
    .price = 2500,
};

pub const dexerityElixir = Item{
    .name = "Elixir Of Dexterity",
    .itemType = .potion,
    .dexterity = 1,
    .price = 2500,
};

pub const vitalityElixir = Item{
    .name = "Elixir Of Vitality",
    .itemType = .potion,
    .vitality = 1,
    .price = 2500,
};

pub const magicElixir = Item{
    .name = "Elixir Of Magic",
    .itemType = .potion,
    .magic = 1,
    .price = 2500,
};
