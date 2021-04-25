/mob/living/carbon/alien/larva
	name = "alien larva"
	real_name = "alien larva"
	adult_form = /mob/living/carbon/human
	speak_emote = list("hisses")
	icon_state = "larva"
	language = "Hivemind"
	maxHealth = 30
	health = 30
	faction = "xenomorph"
	species_language = "Xenomorph"
	density = 0
	max_grown = 180
	see_in_dark = 8

/mob/living/carbon/alien/larva/Initialize()
	. = ..()
	add_language("Xenomorph") //Bonus language.
	internal_organs |= new /obj/item/organ/internal/xenos/hivenode(src)

/obj/structure/alien/egg/CanUseTopic(mob/user)
	return isghost(user) ? STATUS_INTERACTIVE : STATUS_CLOSE

/mob/living/carbon/alien/larva/Topic(href, href_list)
	if(..())
		return TRUE

	if(href_list["occupy"])
		attack_ghost(usr)

/mob/living/carbon/alien/larva/attack_ghost(mob/observer/ghost/user)
	if(client)
		return ..()

	if(jobban_isbanned(user, MODE_XENOMORPH))
		to_chat(user, SPAN("danger", "You are banned from playing a xenomorph."))
		return

	var/confirm = alert(user, "Are you sure you want to join as a xenomorph larva?", "Become Larva", "No", "Yes")

	if(!src || confirm != "Yes")
		return

	if(!user || !user.ckey)
		return

	if(client) //Already occupied.
		to_chat(user, "Too slow...")
		return

	ckey = user.ckey
	GLOB.xenomorphs.add_antagonist(mind, 1)
	spawn(-1)
		if(user)
			qdel(user) // Remove the keyless ghost if it exists.
