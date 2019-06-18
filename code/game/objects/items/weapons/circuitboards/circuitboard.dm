/obj/item/weapon/stock_parts/circuitboard
	name = "circuit board"
	icon = 'icons/obj/module.dmi'
	icon_state = "id_mod"
	item_state = "electronic"
	origin_tech = list(TECH_DATA = 2)
	density = 0
	anchored = 0
	w_class = ITEM_SIZE_SMALL
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 15
	lazy_initialize = FALSE
	var/build_path = null
	var/board_type = "computer"
	var/list/req_components = null
	var/buildtype_select = FALSE

//Called when the circuitboard is used to contruct a new machine.
/obj/item/weapon/stock_parts/circuitboard/proc/construct(var/obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0

//Called when a computer is deconstructed to produce a circuitboard.
//Only used by computers, as other machines store their circuitboard instance.
/obj/item/weapon/stock_parts/circuitboard/proc/deconstruct(var/obj/machinery/M)
	if (istype(M, build_path))
		return 1
	return 0

// Used with the build type selection multitool extension. Return a list of possible build types to allow multitool toggle.
/obj/item/weapon/stock_parts/circuitboard/proc/get_buildable_types()

/obj/item/weapon/stock_parts/circuitboard/Initialize()
	. = ..()
	if(buildtype_select)
		if(get_extension(src, /datum/extension/interactive/multitool))
			CRASH("A circuitboard of type [type] has conflicting multitool extensions")
		set_extension(src, /datum/extension/interactive/multitool, /datum/extension/interactive/multitool/circuitboards/buildtype_select)

/obj/item/weapon/stock_parts/circuitboard/on_uninstall(obj/machinery/machine)
	. = ..()
	if(buildtype_select && machine)
		build_path = machine.base_type || machine.type
		SetName(T_BOARD(machine.name))