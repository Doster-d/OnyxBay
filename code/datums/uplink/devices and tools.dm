/********************
* Devices and Tools *
********************/
/datum/uplink_item/item/tools
	category = /datum/uplink_category/tools

/datum/uplink_item/item/tools/toolbox
	name = "Fully Loaded Toolbox"
	item_cost = 8
	path = /obj/item/weapon/storage/toolbox/syndicate

/datum/uplink_item/item/tools/ductape
	name = "Duct Tape"
	desc = "A roll of duct tape. changes \"HELP\" in to sexy \"mmm\"."
	item_cost = 8
	path = /obj/item/weapon/tape_roll

/datum/uplink_item/item/tools/std
	name = "Syndicate Teleportation Device (STD)"
	desc = "It's contain an unstable wormhole, that used to teleport all items inside to our base, on complete of teleportation sequances the device self destroyed to safety reasons, just try to put your uplink device in it for authorization, remove uplink, put items inside and follow instructions that writed down on device."
	item_cost = 1
	path = /obj/item/weapon/storage/briefcase/std

/datum/uplink_item/item/tools/std/buy(obj/item/device/uplink/U)
	. = ..()
	if(.)
		var/obj/item/weapon/storage/briefcase/std/STD = .
		if(istype(STD))
			STD.uplink = U

/datum/uplink_item/item/tools/money
	name = "Operations Funding"
	item_cost = 8
	path = /obj/item/weapon/storage/secure/briefcase/money
	desc = "A briefcase with 10,000 untraceable credits for funding your sneaky activities."

datum/uplink_item/item/tools/cleaning_kit
	name = "Cleaning Kit"
	item_cost = 15
	path = /obj/item/weapon/storage/backpack/satchel/syndie_kit/cleaning_kit

/datum/uplink_item/item/tools/clerical
	name = "Morphic Clerical Kit"
	item_cost = 16
	path = /obj/item/weapon/storage/backpack/satchel/syndie_kit/clerical

/datum/uplink_item/item/tools/plastique
	name = "C-4 (Destroys walls)"
	item_cost = 16
	path = /obj/item/weapon/plastique

/datum/uplink_item/item/tools/heavy_armor
	name = "Heavy Armor Vest and Helmet"
	item_cost = 16
	path = /obj/item/weapon/storage/backpack/satchel/syndie_kit/armor

/datum/uplink_item/item/tools/encryptionkey_radio
	name = "Encrypted Radio Channel Key"
	item_cost = 1
	path = /obj/item/device/encryptionkey/syndicate

/datum/uplink_item/item/tools/shield_diffuser
	name = "Handheld Shield Diffuser"
	item_cost = 16
	path = /obj/item/weapon/shield_diffuser

/datum/uplink_item/item/tools/sindicuffs
	name = "Explosive Handcuffs"
	item_cost = 16
	path = /obj/item/weapon/handcuffs/syndicate

/datum/uplink_item/item/tools/suit_sensor_mobile
	name = "Suit Sensor Jamming Device"
	desc = "This device will affect suit sensor data using method and radius defined by the user."
	item_cost = 20
	path = /obj/item/device/suit_sensor_jammer

/datum/uplink_item/item/tools/encryptionkey_binary
	name = "Binary Translator Key"
	item_cost = 20
	path = /obj/item/device/encryptionkey/binary

/datum/uplink_item/item/tools/emag
	name = "Cryptographic Sequencer"
	item_cost = 24
	path = /obj/item/weapon/card/emag

/datum/uplink_item/item/tools/hacking_tool
	name = "Door Hacking Tool"
	item_cost = 24
	path = /obj/item/device/multitool/hacktool
	desc = "Appears and functions as a standard multitool until the mode is toggled by applying a screwdriver appropriately. \
			When in hacking mode this device will grant full access to any standard airlock within 20 to 40 seconds. \
			This device will also be able to immediately access the last 6 to 8 hacked airlocks."

/datum/uplink_item/item/tools/space_suit
	name = "Space Suit"
	item_cost = 28
	path = /obj/item/weapon/storage/backpack/satchel/syndie_kit/space

/datum/uplink_item/item/tools/thermal
	name = "Thermal Imaging Goggles"
	item_cost = 24
	path = /obj/item/clothing/glasses/hud/standard/thermal

/datum/uplink_item/item/tools/flashdark
	name = "Flashdark"
	item_cost = 65
	antag_costs = list(MODE_MERCENARY = 129)
	path = /obj/item/device/flashlight/flashdark

/datum/uplink_item/item/tools/powersink
	name = "Powersink (DANGER!)"
	item_cost = 85
	path = /obj/item/device/powersink

/datum/uplink_item/item/tools/teleporter
	name = "Teleporter Circuit Board"
	item_cost = 40
	path = /obj/item/weapon/circuitboard/teleporter
	antag_roles = list(MODE_NUKE)

/datum/uplink_item/item/tools/ai_module
	name = "Hacked AI Upload Module"
	item_cost = 52
	path = /obj/item/weapon/aiModule/syndicate

/datum/uplink_item/item/tools/supply_beacon
	name = "Hacked Supply Beacon (DANGER!)"
	item_cost = 52
	path = /obj/item/supply_beacon

/datum/uplink_item/item/tools/camera_mask
	name = "Camera MIU"
	item_cost = 32
	antag_costs = list(MODE_NUKE = 15)
	path = /obj/item/clothing/mask/ai

/datum/uplink_item/item/tools/interceptor
	name = "Radio Interceptor"
	item_cost = 30
	path = /obj/item/device/radio/intercept
	desc = "A radio that can intercept secure radio channels. Doesn't fit in pockets."

/datum/uplink_item/item/tools/c4explosive
	name = "Small Package Bomb"
	item_cost = 25
	path = /obj/item/weapon/syndie/c4explosive

/datum/uplink_item/item/tools/c4explosive/heavy
	name = "Large Package Bomb"
	item_cost = 50
	path = /obj/item/weapon/syndie/c4explosive/heavy
