local _, AutoKnowledgeMacro = ...
local ALCHEMY_PK_ITEMS = {
  222546, -- Algari Treatise on Alchemy
  224024, -- Theories of Bodily Transmutation, Chapter 8
  224645, -- Jewel-Etched Alchemy Notes
  226265, -- Earthen Iron Powder
  226266, -- Metal Dornogal Frame
  226267, -- Reinforced Beaker
  226268, -- Engraved Stirring Rod
  226269, -- Chemist's Purified Water
  226270, -- Sanctified Mortar and Pestle
  226271, -- Nerubian Mixing Salts
  226272, -- Dark Apothecary's Vial
  227409, -- Faded Alchemist's Research
  227420, -- Exceptional Alchemist's Research
  227431, -- Pristine Alchemist's Research
  228724, -- Flicker of Alchemy Knowledge
  228725, -- Glimmer of Alchemy Knowledge
  232499, -- Undermine Treatise on Alchemy
  235865, -- Ethereal Tome of Alchemy Knowledge
}
local BLACKSMITH_PK_ITEMS = {
  222554, -- Algari Treatise on Blacksmithing
  224038, -- Smithing After Saronite
  224647, -- Jewel-Etched Blacksmithing Notes
  226276, -- Ancient Earthen Anvil
  226277, -- Dornogal Hammer
  226278, -- Ringing Hammer Vise
  226279, -- Earthen Chisels
  226280, -- Holy Flame Forge
  226281, -- Radiant Tongs
  226282, -- Nerubian Smith's Kit
  226283, -- Spiderling's Wire Brush
  227407, -- Faded Blacksmith's Diagrams
  227418, -- Exceptional Blacksmith's Diagrams
  227429, -- Pristine Blacksmith's Diagrams
  228726, -- Flicker of Blacksmithing Knowledge
  228727, -- Glimmer of Blacksmithing Knowledge
  232500, -- Undermine Treatise on Blacksmithing
  235864, -- Ethereal Tome of Blacksmithing Knowledge
}
local ENCHANTING_PK_ITEMS = {
  222550, -- Algari Treatise on Enchanting
  224050, -- Web Sparkles: Pretty and Powerful
  224652, -- Jewel-Etched Enchanting Notes
  226284, -- Grinded Earthen Gem
  226285, -- Silver Dornogal Rod
  226286, -- Soot-Coated Orb
  226287, -- Animated Enchanting Dust
  226288, -- Essence of Holy Fire
  226289, -- Enchanted Arathi Scroll
  226290, -- Book of Dark Magic
  226291, -- Void Shard
  227411, -- Faded Enchanter's Research
  227422, -- Exceptional Enchanter's Research
  227433, -- Pristine Enchanter's Research
  227659, -- Fleeting Arcane Manifestation
  227661, -- Gleaming Telluric Crystal
  227662, -- Shimmering Dust
  228728, -- Flicker of Enchanting Knowledge
  228729, -- Glimmer of Enchanting Knowledge
  232501, -- Undermine Treatise on Enchanting
  235863, -- Ethereal Tome of Enchanting Knowledge
}
local ENGINEERING_PK_ITEMS = {
  222621, -- Algari Treatise on Engineering
  224052, -- Clocks, Gears, Sprockets, and Legs
  224653, -- Machine-Learned Engineering Notes
  226292, -- Rock Engineer's Wrench
  226293, -- Dornogal Spectacles
  226294, -- Inert Mining Bomb
  226295, -- Earthen Construct Blueprints
  226296, -- Holy Firework Dud
  226297, -- Arathi Safety Gloves
  226298, -- Puppeted Mechanical Spider
  226299, -- Emptied Venom Canister
  227412, -- Faded Engineer's Scribblings
  227423, -- Exceptional Engineer's Scribblings
  227434, -- Pristine Engineer's Scribblings
  228730, -- Flicker of Engineering Knowledge
  228731, -- Glimmer of Engineering Knowledge
  232507, -- Undermine Treatise on Engineering
  235862, -- Ethereal Tome of Engineering Knowledge
}
local HERBALISM_PK_ITEMS = {
  222552, -- Algari Treatise on Herbalism
  224023, -- Herbal Embalming Techniques
  224264, -- Deepgrove Petal
  224265, -- Deepgrove Rose
  224656, -- Void-Lit Herbalism Notes
  226300, -- Ancient Flower
  226301, -- Dornogal Gardening Scythe
  226302, -- Earthen Digging Fork
  226303, -- Fungarian Slicer's Knife
  226304, -- Arathi Garden Trowel
  226305, -- Arathi Herb Pruner
  226306, -- Web-Entangled Lotus
  226307, -- Tunneler's Shovel
  227415, -- Faded Herbalist's Notes
  227426, -- Exceptional Herbalist's Notes
  227437, -- Pristine Herbalist's Notes
  232503, -- Undermine Treatise on Herbalism
  235861, -- Ethereal Tome of Herbalism Knowledge
}
local INSCRIPTION_PK_ITEMS = {
  222548, -- Algari Treatise on Inscription
  224053, -- Eight Views on Defense against Hostile Runes
  224654, -- Machine-Learned Inscription Notes
  226308, -- Dornogal Scribe's Quill
  226309, -- Historian's Dip Pen
  226310, -- Runic Scroll
  226311, -- Blue Earthen Pigment
  226312, -- Informant's Fountain Pen
  226313, -- Calligrapher's Chiseled Marker
  226314, -- Nerubian Texts
  226315, -- Venomancer's Ink Well
  227408, -- Faded Scribe's Runic Drawings
  227419, -- Exceptional Scribe's Runic Drawings
  227430, -- Pristine Scribe's Runic Drawings
  228732, -- Flicker of Inscription Knowledge
  228733, -- Glimmer of Inscription Knowledge
  232508, -- Undermine Treatise on Inscription
  235860, -- Ethereal Tome of Inscription Knowledge
}
local JEWELCRAFTING_PK_ITEMS = {
  222551, -- Algari Treatise on Jewelcrafting
  224054, -- Emergent Crystals of the Surface-Dwellers
  224655, -- Void-Lit Jewelcrafting Notes
  226316, -- Gentle Jewel Hammer
  226317, -- Earthen Gem Pliers
  226318, -- Carved Stone File
  226319, -- Jeweler's Delicate Drill
  226320, -- Arathi Sizing Gauges
  226321, -- Librarian's Magnifiers
  226322, -- Ritual Caster's Crystal
  226323, -- Nerubian Bench Blocks
  227413, -- Faded Jeweler's Illustrations
  227424, -- Exceptional Jeweler's Illustrations
  227435, -- Pristine Jeweler's Illustrations
  228734, -- Flicker of Jewelcrafting Knowledge
  228735, -- Glimmer of Jewelcrafting Knowledge
  232504, -- Undermine Treatise on Jewelcrafting
  235859, -- Ethereal Tome of Jewelcrafting Knowledge
}
local LEATHERWORKING_PK_ITEMS = {
  222549, -- Algari Treatise on Leatherworking
  224056, -- Uses for Leftover Husks (After You Take Them Apart)
  224658, -- Void-Lit Leatherworking Notes
  226324, -- Earthen Lacing Tools
  226325, -- Dornogal Craftsman's Flat Knife
  226326, -- Underground Stropping Compound
  226327, -- Earthen Awl
  226328, -- Arathi Beveler Set
  226329, -- Arathi Leather Burnisher
  226330, -- Nerubian Tanning Mallet
  226331, -- Curved Nerubian Skinning Knife
  227414, -- Faded Leatherworker's Diagrams
  227425, -- Exceptional Leatherworker's Diagrams
  227436, -- Pristine Leatherworker's Diagrams
  228736, -- Flicker of Leatherworking Knowledge
  228737, -- Glimmer of Leatherworking Knowledge
  232505, -- Undermine Treatise on Leatherworking
  235858, -- Ethereal Tome of Leatherworking Knowledge
}
local MINING_PK_ITEMS = {
  222553, -- Algari Treatise on Mining
  224055, -- A Rocky Start
  224583, -- Slab of Slate
  224584, -- Erosion-Polished Slate
  224651, -- Machine-Learned Mining Notes
  226332, -- Earthen Miner's Gavel
  226333, -- Dornogal Chisel
  226334, -- Earthen Excavator's Shovel
  226335, -- Regenerating Ore
  226336, -- Arathi Precision Drill
  226337, -- Devout Archaeologist's Excavator
  226338, -- Heavy Spider Crusher
  226339, -- Nerubian Mining Supplies
  227416, -- Faded Miner's Notes
  227427, -- Exceptional Miner's Notes
  227438, -- Pristine Miner's Notes
  232509, -- Undermine Treatise on Mining
  235857, -- Ethereal Tome of Mining Knowledge
}
local SKINNING_PK_ITEMS = {
  222649, -- Algari Treatise on Skinning
  224007, -- Uses for Leftover Husks (How to Take Them Apart)
  224657, -- Void-Lit Skinning Notes
  224780, -- Toughened Tempest Pelt
  224781, -- Abyssal Fur
  226340, -- Dornogal Carving Knife
  226341, -- Earthen Worker's Beams
  226342, -- Artisan's Drawing Knife
  226343, -- Fungarian's Rich Tannin
  226344, -- Arathi Tanning Agent
  226345, -- Arathi Craftsman's Spokeshave
  226346, -- Nerubian's Slicking Iron
  226347, -- Carapace Shiner
  227417, -- Faded Skinner's Notes
  227428, -- Exceptional Skinner's Notes
  227439, -- Pristine Skinner's Notes
  232506, -- Undermine Treatise on Skinning
  235856, -- Ethereal Tome of Skinning Knowledge
}
local TAILORING_PK_ITEMS = {
  222547, -- Algari Treatise on Tailoring
  224036, -- And That's A Web-Wrap!
  224648, -- Jewel-Etched Tailoring Notes
  226348, -- Dornogal Seam Ripper
  226349, -- Earthen Tape Measure
  226350, -- Runed Earthen Pins
  226351, -- Earthen Stitcher's Snips
  226352, -- Arathi Rotary Cutter
  226353, -- Royal Outfitter's Protractor
  226354, -- Nerubian Quilt
  226355, -- Nerubian's Pincushion
  227410, -- Faded Tailor's Diagrams
  227421, -- Exceptional Tailor's Diagrams
  227432, -- Pristine Tailor's Diagrams
  228738, -- Flicker of Tailoring Knowledge
  228739, -- Glimmer of Tailoring Knowledge
  232502, -- Undermine Treatise on Tailoring
  235855, -- Ethereal Tome of Tailoring Knowledge
}
local ALL_PROFESSION_ITEMS = {
  --227713, -- Artisan's Consortium Payout
}

-- Map of Treatises and the QuestIDs flagged when you learn them
local TREATISES_AND_QUESTIDS = {
  { itemID = 222546, questID = 82633 }, -- Algari Treatise on Alchemy
  { itemID = 222547, questID = 83735 }, -- Algari Treatise on Tailoring
  { itemID = 222548, questID = 83730 }, -- Algari Treatise on Inscription
  { itemID = 222549, questID = 83732 }, -- Algari Treatise on Leatherworking
  { itemID = 222550, questID = 83727 }, -- Algari Treatise on Enchanting
  { itemID = 222551, questID = 83731 }, -- Algari Treatise on Jewelcrafting
  { itemID = 222552, questID = 83729 }, -- Algari Treatise on Herbalism
  { itemID = 222553, questID = 83733 }, -- Algari Treatise on Mining
  { itemID = 222554, questID = 83726 }, -- Algari Treatise on Blacksmithing
  { itemID = 222621, questID = 83728 }, -- Algari Treatise on Engineering
  { itemID = 222649, questID = 83734 }, -- Algari Treatise on Skinning
}

AutoKnowledgeMacro.professionMap[Enum.Profession.Alchemy][Enum.ExpansionLevel.WarWithin] = ALCHEMY_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Blacksmithing][Enum.ExpansionLevel.WarWithin] = BLACKSMITH_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Enchanting][Enum.ExpansionLevel.WarWithin] = ENCHANTING_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Engineering][Enum.ExpansionLevel.WarWithin] = ENGINEERING_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Herbalism][Enum.ExpansionLevel.WarWithin] = HERBALISM_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Inscription][Enum.ExpansionLevel.WarWithin] = INSCRIPTION_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Jewelcrafting][Enum.ExpansionLevel.WarWithin] = JEWELCRAFTING_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Leatherworking][Enum.ExpansionLevel.WarWithin] = LEATHERWORKING_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Mining][Enum.ExpansionLevel.WarWithin] = MINING_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Skinning][Enum.ExpansionLevel.WarWithin] = SKINNING_PK_ITEMS
AutoKnowledgeMacro.professionMap[Enum.Profession.Tailoring][Enum.ExpansionLevel.WarWithin] = TAILORING_PK_ITEMS
AutoKnowledgeMacro.professionMap[AutoKnowledgeMacro.ENUM_PROFESSION_ALL][Enum.ExpansionLevel.WarWithin] = ALL_PROFESSION_ITEMS
AutoKnowledgeMacro.questFlaggedItems[Enum.ExpansionLevel.WarWithin] = TREATISES_AND_QUESTIDS