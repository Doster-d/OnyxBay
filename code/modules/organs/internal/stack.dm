/mob/living/carbon/human/proc/create_stack()
	internal_organs_by_name[BP_STACK] = new /obj/item/organ/internal/stack(src,1)
	to_chat(src, SPAN("notice", "You feel a faint sense of vertigo as your neural lace boots."))

/obj/item/organ/internal/stack
	name = "neural lace"
	parent_organ = BP_HEAD
	icon_state = "cortical-stack"
	organ_tag = BP_STACK
	status = ORGAN_ROBOTIC
	vital = TRUE
	origin_tech = list(TECH_BIO = 4, TECH_MATERIAL = 4, TECH_MAGNET = 2, TECH_DATA = 3)
	relative_size = 10

	var/override_check = TRUE
	var/ownerckey
	var/invasive
	var/default_language
	var/list/languages = list()
	var/datum/mind/backup

/obj/item/organ/internal/stack/emp_act()
	return

/obj/item/organ/internal/stack/getToxLoss()
	return 0

/obj/item/organ/internal/stack/vox
	name = "cortical stack"
	invasive = 1

/obj/item/organ/internal/stack/proc/do_backup()
	if(owner && owner.stat != DEAD && !is_broken() && owner.mind)
		languages = owner.languages.Copy()
		backup = owner.mind
		default_language = owner.default_language
		if(owner.ckey)
			ownerckey = owner.ckey
		return TRUE
	return FALSE

/obj/item/organ/internal/stack/New()
	..()
	do_backup()
	robotize()

/obj/item/organ/internal/stack/proc/backup_inviable()
	return 	(!istype(backup) || backup == owner.mind || (backup.current && backup.current.stat != DEAD))

/obj/item/organ/internal/stack/replaced()
	if(!..()) return 0

	if(owner && !backup_inviable())
		var/current_owner = owner
		var/response = input(find_dead_player(ownerckey, 1), "Your neural backup has been placed into a new body. Do you wish to return to life?", "Resleeving") as anything in list("Yes", "No")
		if(src && response == "Yes" && owner == current_owner)
			overwrite()
	sleep(-1)
	do_backup()

	return 1

/obj/item/organ/internal/stack/removed()
	do_backup()
	..()

/obj/item/organ/internal/stack/vox/removed()
	var/obj/item/organ/external/head = owner.get_organ(parent_organ)
	owner.visible_message(SPAN("danger", "\The [src] rips gaping holes in \the [owner]'s [head.name] as it is torn loose!"))
	head.take_external_damage(rand(15,20))
	for(var/obj/item/organ/internal/O in head.contents)
		O.take_internal_damage(rand(30,70))
	..()

/obj/item/organ/internal/stack/proc/overwrite()
	if(owner.mind && owner.ckey) //Someone is already in this body!
		owner.visible_message(SPAN("danger", "\The [owner] spasms violently!"))
		if(override_check && prob(66))
			to_chat(owner, SPAN("danger", "You fight off the invading tendrils of another mind, holding onto your own body!"))
			return FALSE
		owner.ghostize() // Remove the previous owner to avoid their client getting reset.
	//owner.dna.real_name = backup.name
	//owner.real_name = owner.dna.real_name
	//owner.SetName(owner.real_name)
	//The above three lines were commented out for
	backup.active = 1
	backup.transfer_to(owner)
	if(default_language) owner.default_language = default_language
	owner.languages = languages.Copy()
	to_chat(owner, SPAN("notice", "Consciousness slowly creeps over you as your new body awakens."))
	return TRUE

/obj/item/organ/internal/stack/remote_control
	name = "VX1 neural chip"
	vital = FALSE

	var/active = FALSE
	var/mob/living/carbon/human/original_body
	var/obj/item/organ/internal/stack/remote_control/slave/slave

/obj/item/organ/internal/stack/remote_control/verb/take_control
	set name = "Take control"
	set desc = "Takes control of connected neural device, that transfer your mind into new body."
	set category = "Neural Chip"
	set src = null
	if(!istype(slave))
		return
	if(usr == backup.current && !active)
		set src = usr

	var/confirm = input(find_dead_player(ownerckey, 1), "Your neural backup has been placed into a new body. Do you wish to take control of the body?", "Body Stealer") as anything in list("Yes", "No")
	if(src && response == "Yes" && owner == current_owner)
		original_body = owner
		owner.ghostize() // remove owner from body
		slave.original_body = owner
		slave.overwrite() // start replace
		active = TRUE
		slave.active = TRUE

/obj/item/organ/internal/stack/remote_control/do_backup()
	. = ..()
	if(.)
		slave.backup = backup
		slave.ownerckey = ownerckey
		slave.default_language = default_language
		slave.languages = languages
		return TRUE

// can't be used in resleever
/obj/item/organ/internal/stack/remote_control/backup_inviable()
	return TRUE

/obj/item/organ/internal/stack/remote_control/slave
	name = "VX0 neural chip"
	override_check = FALSE

	var/list/original_languages = list()
	var/datum/mind/original_mind
	var/original_default_language
	var/original_ownerckey

/obj/item/organ/internal/stack/remote_control/on_owner_death()
	to_chat(owner, SPAN("danger", "Accepting reaplied neural power. Operation \"Phoenix\" activated, releasing dead body."))
	do_release_control()

/obj/item/organ/internal/stack/remote_control/slave/do_backup()
	if(owner?.mind == backup)
		return
	if(owner?.stat != DEAD && !is_broken() && owner?.mind)
		original_languages = owner.languages.Copy()
		original_mind = owner.mind
		original_default_language = owner.default_language
		if(owner.ckey)
			original_ownerckey = owner.ckey

/obj/item/organ/internal/stack/remote_control/slave/verb/release_control()
	set name = "Release control"
	set desc = "Release control of connected neural device, that action transfer your mind into your old body."
	set category = "Neural Chip"
	set src = null
	if(usr == backup.current && active)
		set src = usr

	var/confirm = input(owner, "Are you sure?", "Body release") as anything in list("Yes", "No")
	if(src && response == "Yes" && owner == current_owner)
		do_release_control()

/obj/item/organ/internal/stack/remote_control/slave/proc/do_release_control()
	var/datum/mind/old_backup = backup
	var/old_ownerckey = ownerckey
	var/list/old_languages = languages
	var/old_default_language = default_language

	languages = original_languages
	backup = original_mind
	default_language = original_default_language
	ownerckey = original_ownerckey

	owner.ghostize()
	old_backup.active = 1
	old_backup.transfer_to(original_body)
	overwrite()

	languages = old_languages
	backup = old_backup
	default_language = old_default_language
	ownerckey = old_ownerckey
