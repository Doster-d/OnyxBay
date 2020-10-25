/obj/item/clothing/suit/storage
	var/obj/item/weapon/storage/internal/pockets/pockets
	var/initial_closed = FALSE

/obj/item/clothing/suit/storage/New()
	..()
	pockets = new /obj/item/weapon/storage/internal/pockets(src, slots = 2, slot_size = 2) //two slots, fit only pocket sized items
	if(initial_closed)
		flags_inv += HIDEJUMPSUITACCESSORIES

/obj/item/clothing/suit/storage/Destroy()
	QDEL_NULL(pockets)
	. = ..()

/obj/item/clothing/suit/storage/attack_hand(mob/user as mob)
	if (pockets.handle_attack_hand(user))
		..(user)

/obj/item/clothing/suit/storage/MouseDrop(obj/over_object as obj)
	if (pockets.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/suit/storage/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(!(W in accessories))		//Make sure that an accessory wasn't successfully attached to suit.
		pockets.attackby(W, user)

/obj/item/clothing/suit/storage/emp_act(severity)
	pockets.emp_act(severity)
	..()

//Jackets with buttons, used for labcoats, IA jackets, First Responder jackets, and brown jackets.
/obj/item/clothing/suit/storage/toggle
	var/icon_open
	var/icon_closed

/obj/item/clothing/suit/storage/toggle/verb/toggle()
	set name = "Toggle Coat Buttons"
	set category = "Object"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return 0

	if(icon_state == icon_open) //Will check whether icon state is currently set to the "open" or "closed" state and switch it around with a message to the user
		icon_state = icon_closed
		to_chat(usr, "You button up the coat.")
		flags_inv |= HIDEJUMPSUITACCESSORIES
	else if(icon_state == icon_closed)
		icon_state = icon_open
		to_chat(usr, "You unbutton the coat.")
		flags_inv &= HIDEJUMPSUITACCESSORIES
	else
		to_chat(usr, "You attempt to button-up the velcro on your [src], before promptly realising how silly you are.")
		return
	update_clothing_icon()	//so our overlays update
