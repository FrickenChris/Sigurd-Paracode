/*
	Datum-based species. Should make for much cleaner and easier to maintain mutantrace code.
*/

/datum/species
	var/name                     // Species name.
	var/path 					// Species path
	var/icobase = 'icons/mob/human_races/r_human.dmi'    // Normal icon set.
	var/deform = 'icons/mob/human_races/r_def_human.dmi' // Mutated icon set.
	var/eyes = "eyes_s"                                  // Icon for eyes.

	var/primitive                // Lesser form, if any (ie. monkey for humans)
	var/tail                     // Name of tail image in species effects icon file.
	var/language                 // Default racial language, if any.
	var/attack_verb = "punch"    // Empty hand hurt intent verb.
	var/mutantrace               // Safeguard due to old code.

	var/breath_type = "oxygen"   // Non-oxygen gas breathed, if any.

	var/cold_level_1 = 260  // Cold damage level 1 below this point.
	var/cold_level_2 = 200  // Cold damage level 2 below this point.
	var/cold_level_3 = 120  // Cold damage level 3 below this point.

	var/heat_level_1 = 360  // Heat damage level 1 above this point.
	var/heat_level_2 = 400  // Heat damage level 2 above this point.
	var/heat_level_3 = 1000 // Heat damage level 3 above this point.

	var/darksight = 2
	var/hazard_high_pressure = HAZARD_HIGH_PRESSURE   // Dangerously high pressure.
	var/warning_high_pressure = WARNING_HIGH_PRESSURE // High pressure warning.
	var/warning_low_pressure = WARNING_LOW_PRESSURE   // Low pressure warning.
	var/hazard_low_pressure = HAZARD_LOW_PRESSURE     // Dangerously low pressure.

	// This shit is apparently not even wired up.
	var/brute_resist    // Physical damage reduction.
	var/burn_resist     // Burn damage reduction.

	var/flags = 0       // Various specific features.
	var/bloodflags=0
	var/bodyflags=0

	// For grays
	var/max_hurt_damage = 5 // Max melee damage dealt + 5 if hulk
	var/default_mutations = list()

	var/list/abilities = list()  // For species-derived or admin-given powers

/datum/species/human
	name = "Human"
	icobase = 'icons/mob/human_races/r_human.dmi'
	deform = 'icons/mob/human_races/r_def_human.dmi'
	primitive = /mob/living/carbon/monkey
	path = /mob/living/carbon/human/human
	flags = HAS_SKIN_TONE | HAS_LIPS | HAS_UNDERWEAR | CAN_BE_FAT

/datum/species/unathi
	name = "Unathi"
	icobase = 'icons/mob/human_races/r_lizard.dmi'
	deform = 'icons/mob/human_races/r_def_lizard.dmi'
	path = /mob/living/carbon/human/unathi
	language = "Sinta'unathi"
	tail = "sogtail"
	attack_verb = "scratch"
	primitive = /mob/living/carbon/monkey/unathi
	darksight = 3

	flags = HAS_LIPS | HAS_UNDERWEAR | HAS_TAIL
	bodyflags = FEET_CLAWS

	cold_level_1 = 280 //Default 260 - Lower is better
	cold_level_2 = 220 //Default 200
	cold_level_3 = 130 //Default 120

	heat_level_1 = 420 //Default 360 - Higher is better
	heat_level_2 = 480 //Default 400
	heat_level_3 = 1100 //Default 1000

/datum/species/tajaran
	name = "Tajaran"
	icobase = 'icons/mob/human_races/r_tajaran.dmi'
	deform = 'icons/mob/human_races/r_def_tajaran.dmi'
	path = /mob/living/carbon/human/tajaran
	language = "Siik'tajr"
	tail = "tajtail"
	attack_verb = "scratch"
	darksight = 8

	cold_level_1 = 200
	cold_level_2 = 140
	cold_level_3 = 80

	heat_level_1 = 330
	heat_level_2 = 380
	heat_level_3 = 800

	primitive = /mob/living/carbon/monkey/tajara

	flags = HAS_LIPS | HAS_UNDERWEAR | HAS_TAIL | CAN_BE_FAT
	bodyflags = FEET_PADDED

/datum/species/skrell
	name = "Skrell"
	icobase = 'icons/mob/human_races/r_skrell.dmi'
	deform = 'icons/mob/human_races/r_def_skrell.dmi'
	path = /mob/living/carbon/human/skrell
	language = "Skrellian"
	primitive = /mob/living/carbon/monkey/skrell

	flags = HAS_LIPS | HAS_UNDERWEAR
	bloodflags = BLOOD_GREEN

/datum/species/vox
	name = "Vox"
	icobase = 'icons/mob/human_races/r_vox.dmi'
	deform = 'icons/mob/human_races/r_def_vox.dmi'
	path = /mob/living/carbon/human/vox
	language = "Vox-pidgin"

	warning_low_pressure = 50
	hazard_low_pressure = 0

	cold_level_1 = 80
	cold_level_2 = 50
	cold_level_3 = 0

	eyes = "vox_eyes_s"
	breath_type = "nitrogen"

	flags = NO_SCAN | IS_WHITELISTED | NO_BLOOD

/datum/species/diona
	name = "Diona"
	icobase = 'icons/mob/human_races/r_plant.dmi'
	deform = 'icons/mob/human_races/r_def_plant.dmi'
	path = /mob/living/carbon/human/diona
	language = "Rootspeak"
	attack_verb = "slash"
	primitive = /mob/living/carbon/monkey/diona

	warning_low_pressure = 50
	hazard_low_pressure = -1

	cold_level_1 = 50
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 300
	heat_level_2 = 350
	heat_level_3 = 700

	flags = NO_BREATHE | REQUIRE_LIGHT | NO_SCAN | IS_PLANT | RAD_ABSORB | NO_BLOOD | IS_SLOW | NO_PAIN



/datum/species/kidan
	name = "Kidan"
	icobase = 'icons/mob/human_races/r_kidan.dmi'
	deform = 'icons/mob/human_races/r_def_kidan.dmi'
	path = /mob/living/carbon/human/kidan
	language = "Chittin"
	attack_verb = "slash"

	flags = IS_WHITELISTED | HAS_CHITTIN
	bloodflags = BLOOD_GREEN
	bodyflags = FEET_CLAWS



/datum/species/slime
	name = "Slime People"
	language = "Bubblish"
	attack_verb = "bludgeon"
	path = /mob/living/carbon/human/slime
	primitive = /mob/living/carbon/slime/adult

	flags = IS_WHITELISTED | NO_BREATHE | HAS_LIPS | NO_INTORGANS
	bloodflags = BLOOD_SLIME
	bodyflags = FEET_NOSLIP
	abilities = list(/mob/living/carbon/human/slime/proc/slimepeople_ventcrawl)

/datum/species/grey
	name = "Grey"
	icobase = 'icons/mob/human_races/r_grey.dmi'
	deform = 'icons/mob/human_races/r_def_grey.dmi'
	language = "Galactic Standard"
	attack_verb = "punch"
	path = /mob/living/carbon/human/grey
	darksight = 5 // BOOSTED from 2
	eyes = "grey_eyes_s"
	max_hurt_damage = 3 // From 5 (for humans)
//	default_mutations=list(mRemotetalk) // TK is also another candidate, but TK is overpowered as fuck.

	flags = IS_WHITELISTED | HAS_LIPS | CAN_BE_FAT
