local _, T = ...
local ALCHEMY_PK_ITEMS = {
  -- MID Treasures
  238532, -- Vial of Eversong Oddities
  238533, -- Vial of Voidstorm Oddities
  238534, -- Vial of Rootlands Oddities
  238535, -- Vial of Zul'Aman Oddities
  238536, -- Freshly Plucked Peacebloom
  238537, -- Measured Ladle
  238538, -- Pristine Potion
  238539, -- Failed Experiment
  -- Thalassian Treatise
  245755, -- Thalassian Treatise on Alchemy
  -- Work Orders
  246320, -- Flicker of Midnight Alchemy Knowledge
  246321, -- Glimmer of Midnight Alchemy Knowledge
  -- Secret
  255828, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Alchemy
  -- Chests
  259188, -- Lightbloomed Spore Sample
  259189, -- Aged Cruor
  -- Faction Vendor
  262645, -- Beyond the Event Horizon: Alchemy
  -- Weekly quest  
  263454, -- Thalassian Alchemist's Notebook
}
local BLACKSMITH_PK_ITEMS = {
  -- MID Treasures
  238540, -- Deconstructed Forge Techniques
  238541, -- Silvermoon Smithing Kit
  238542, -- Carefully Racked Spear
  238543, -- Metalworking Cheat Sheet
  238544, -- Voidstorm Defense Spear
  238545, -- Rutaani Floratender's Sword
  238546, -- Sin'dorei Master's Forgemace
  238547, -- Silvermoon Blacksmith's Hammer
  -- Thalassian Treatise
  245763, -- Thalassian Treatise on Blacksmithing
  -- Work Orders
  246322, -- Flicker of Midnight Blacksmithing Knowledge
  246323, -- Glimmer of Midnight Blacksmithing Knowledge
  -- Secret
  255829, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Blacksmithing
  -- Chests
  259190, -- Thalassian Whestone
  259191, -- Infused Quenching Oil
  -- Faction Vendor
  262644, -- Beyond the Event Horizon: Blacksmithing
  -- Weekly Quest
  263455, -- Thalassian Blacksmith's Journal
}
local ENCHANTING_PK_ITEMS = {
  -- MID Treasures
  238548, -- Enchanted Amani Mask
  238549, -- Enchanted Sunfire Silk
  238550, -- Pure Void Crystal
  238551, -- Everblazing Sunmote
  238552, -- Entropic Shard
  238553, -- Primal Essence Orb
  238554, -- Loa-Blessed Dust
  238555, -- Sin'dorei Enchanting Rod
  -- Thalassian Treatise
  245759, -- Thalassian Treatise on Enchanting
  -- Work Orders
  246324, -- Flicker of Midnight Enchanting Knowledge
  246325, -- Glimmer of Midnight Enchanting Knowledge
  -- Chel the Chip
  250445, -- Echo of Abundance: Enchanting 
  -- Secret
  255830, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Enchanting
  -- Faction Vendor
  257600, -- Skill Issue: Enchanting
  -- Chests
  259192, -- Voidstorm Ashes
  259193, -- Lost Thalassian Vellum
  -- Weekly Quest
  263464, -- Thalassian Enchanter's Folio
  -- Disenchanting
  267653, -- Glimmering Powder
  267654, -- Swirling Arcane Essence
  267655, -- Brimming Mana Shard
}
local ENGINEERING_PK_ITEMS = {
  -- MID Treasures
  238556, -- One Engineer's Junk
  238557, -- Miniaturized Transport Skiff
  238558, -- Manual of Mistakes and Mishaps
  238559, -- Expeditious Pylon
  238560, -- Ethereal Stormwrench
  238561, -- Offline Helper Bot
  238562, -- What To Do When Nothing Works
  238563, -- Handy Wrench
  -- Thalassian Treatise
  245809, -- Thalassian Treatise on Engineering
  -- Work Orders
  246326, -- Flicker of Midnight Engineering Knowledge
  246327, -- Glimmer of Midnight Engineering Knowledge
  -- Secrets
  255831, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Engineering
  -- Chests
  259194, -- Dance Gear
  259195, -- Dawn Capacitor
  -- Faction Vendor
  262646, -- Beyond the Event Horizon: Engineering
  -- Weekly Quest
  263456, -- Thalassian Engineer's Notepad 
}
local HERBALISM_PK_ITEMS = {
  -- Weekly Profession Drops
  238465, -- Thalassian Phoenix Plume
  238466, -- Thalassian Phoenix Tail
  238467, -- Thalassian Phoenix Ember
  -- MID Treasures
  238468, -- Bloomed Bud
  238469, -- Sweeping Harvester's Scythe
  238470, -- Simple Leaf Pruners
  238471, -- Lightbloom Root
  238472, -- A Spade
  238473, -- Harvester's Sickle
  238474, -- Peculiar Lotus
  238475, -- Planting Shovel
  -- Thalassian Treatise
  245761, -- Thalassian Treatise on Herbalism
  -- Vendor (Chel the Chip)
  250443, -- Echo of Abundance: Herbalism
  -- Secret
  255832, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Herbalism
  -- Faction Vendor
  258410, -- Traditions of the Haranir: Herbalism
  -- Weekly quest
  263462, -- Thalassian Herbalist's Notes
}
local INSCRIPTION_PK_ITEMS = {
  -- MID Treasures
  238572, -- Void-Touched Quill
  238573, -- Leather-Bound Techniques
  238574, -- Spare Ink
  238575, -- Intrepid Explorer's Marker
  238576, -- Leftover Sanguithorn Pigment
  238577, -- Half-Baked Techniques
  238578, -- Songwriter's Pen
  238579, -- Songwriter's Quill
  -- Thalassian Treatise
  245757, -- Thalassian Treatise on Inscription
  -- Work orders
  246328, -- Flicker of Midnight Inscription Knowledge
  246329, -- Glimmer of Midnight Inscription Knowledge
  -- Secret
  255833, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Inscription
  -- Faction Vendor
  258411, -- Traditions of the Haranir: Inscription
  -- Chests
  259196, -- Brilliant Phoenix Ink
  259197, -- Loa-Blessed Rune
  -- Weekly quest
  263457, -- Thalassian Scribe's Journal
}
local JEWELCRAFTING_PK_ITEMS = {
  -- MID Treasures
  238580, -- Sin'dorei Masterwork Chisel
  238581, -- Speculative Voidstorm Crystal
  238582, -- Dual-Function Magnifiers
  238583, -- Poorly Rounded Vial
  238584, -- Shattered Glass
  238585, -- Vintage Soul Gem
  238586, -- Ethereal Gem Pliers
  238587, -- Sin'dorei Gem Faceters
  -- Thalassian Treatise
  245760, -- Thalassian Treatise on Jewelcrafting
  -- Work Orders
  246330, -- Flicker of Midnight Jewelcrafting Knowledge
  246331, -- Glimmer of Midnight Jewelcrafting Knowledge
  -- Secret
  255834, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Jewelcrafting
  -- Faction Vendor
  257599, -- Skill Issue: Jewelcrafting
  -- Chests
  259198, -- Void-Touched Eversong Diamond Fragments
  259199, -- Harandar Stone Sample
  -- Weekly Quest
  263458, -- Thalassian Jewelcrafter's Notebook
}
local LEATHERWORKING_PK_ITEMS = {
  -- MID Treasures  
  238588, -- Amani Leatherworker's Tool
  238589, -- Ethereal Leatherworking Knife
  238590, -- Prestigiously Racked Hide
  238591, -- Bundle of Tanner's Trinkets
  238592, -- Patterns: Beyond the Void
  238593, -- Haranir Leatherworking Mallet
  238594, -- Haranir Leatherworking Knife
  238595, -- Artisan's Considered Order
  -- Thalassian Treatise
  245758, -- Thalassian Treatise on Leatherworking
  -- Work Orders
  246332, -- Flicker of Midnight Leatherworking Knowledge
  246333, -- Glimmer of Midnight Leatherworking Knowledge
  -- Faction Vendor
  250922, -- Whisper of the Loa: Leatherworking
  -- Secret
  255835, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Leatherworking
  -- Chests
  259200, -- Amani Tanning Oil
  259201, -- Thalassian Mana Oil
  -- Weekly quest
  263459, -- Thalassian Leatherworker's Journal
}
local MINING_PK_ITEMS = {
  -- Weekly Profession Drops
  237496, -- Igneous Rock Specimen
  237506, -- Septarian Nodule
  237507, -- Cloudy Quartz
  -- MID Treasures
  238596, -- Miner's Guide to Voidstorm
  238597, -- Spelunker's Lucky Charm
  238598, -- Lost Voidstorm Satchel
  238599, -- Solid Ore Punchers
  238600, -- Glimmering Void Pearl
  238601, -- Amani Expert's Chisel
  238602, -- Star Metal Deposit
  238603, -- Spare Expedition Torch
  -- Thalassian Treatise
  245762, -- Thalassian Treatise on Mining
  -- Vendor (Chel the Chip)
  250444, -- Echo of Abundance: Mining
  -- Faction Vendor
  250924, -- Whisper of the Loa: Mining
  -- Secret
  255836, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Mining
  -- Weekly Quest
  263463, -- Thalassian Miner's Notes
}
local SKINNING_PK_ITEMS = {
  -- Profession drops
  238625, -- Fine Void-Tempered Hide
  238626, -- Mana-Infused Bone
  238627, -- Manafused Sample
  -- MID Treasures
  238628, -- Lightbloom Afflicted Hide
  238629, -- Cadre Skinning Knife
  238630, -- Primal Hide
  238631, -- Voidstorm Leather Sample
  238632, -- Amani Tanning Oil
  238633, -- Sin'dorei Tanning Oil
  238634, -- Amani Skinning Knife
  238635, -- Thalassian Skinning Knife
  -- Thalassian Treatise
  245828, -- Thalassian Treatise on Skinning
  -- Vendor (Chel the Chip)
  250360, -- Echo of Abundance: Skinning
  250923, -- Whisper of the Loa: Skinning
  -- Weekly Quest
  263461, -- Thalassian Skinner's Notes
}
local TAILORING_PK_ITEMS = {
  -- MID Treasures
  238612, -- A Child's Stuffy
  238613, -- A Really Nice Curtain
  238614, -- Sin'dorei Outfitter's Ruler
  238615, -- Wooden Weaving Sword
  238616, -- Book of Sin'dorei Stitches
  238617, -- Satin Throw Pillow
  238618, -- Particularly Enchanting Tablecloth
  238619, -- Artisan's Cover Comb
  -- Thalassian Treatise
  245756, -- Thalassian Treatise on Tailoring
  -- Work Orders
  246334, -- Flicker of Midnight Tailoring Knowledge
  246335, -- Glimmer of Midnight Tailoring Knowledge
  -- Secret
  255838, -- Sr. Professor Instructaur's Top Secret Guide to Midnight Tailoring
  -- Faction Vendor
  257601, -- Skill Issue: Tailoring
  -- Chests
  259202, -- Embroidered Memento
  259203, -- Finely Woven Lynx Collar
  -- Weekly quest
  263460, -- Thalassian Tailor's Notebook
}
local ALL_PROFESSION_ITEMS = {
  227713, -- Artisan's Consortium Payout
  246585, -- Artisan's Consortium Payout
}

T.professionMap[Enum.Profession.Alchemy][Enum.ExpansionLevel.Midnight] = ALCHEMY_PK_ITEMS
T.professionMap[Enum.Profession.Blacksmithing][Enum.ExpansionLevel.Midnight] = BLACKSMITH_PK_ITEMS
T.professionMap[Enum.Profession.Enchanting][Enum.ExpansionLevel.Midnight] = ENCHANTING_PK_ITEMS
T.professionMap[Enum.Profession.Engineering][Enum.ExpansionLevel.Midnight] = ENGINEERING_PK_ITEMS
T.professionMap[Enum.Profession.Herbalism][Enum.ExpansionLevel.Midnight] = HERBALISM_PK_ITEMS
T.professionMap[Enum.Profession.Inscription][Enum.ExpansionLevel.Midnight] = INSCRIPTION_PK_ITEMS
T.professionMap[Enum.Profession.Jewelcrafting][Enum.ExpansionLevel.Midnight] = JEWELCRAFTING_PK_ITEMS
T.professionMap[Enum.Profession.Leatherworking][Enum.ExpansionLevel.Midnight] = LEATHERWORKING_PK_ITEMS
T.professionMap[Enum.Profession.Mining][Enum.ExpansionLevel.Midnight] = MINING_PK_ITEMS
T.professionMap[Enum.Profession.Skinning][Enum.ExpansionLevel.Midnight] = SKINNING_PK_ITEMS
T.professionMap[Enum.Profession.Tailoring][Enum.ExpansionLevel.Midnight] = TAILORING_PK_ITEMS
T.professionMap[T.ENUM_PROFESSION_ALL][Enum.ExpansionLevel.Midnight] = ALL_PROFESSION_ITEMS
