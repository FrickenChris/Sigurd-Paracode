/datum/game_mode
	var/list/datum/mind/xenos = list()


/datum/game_mode/xenos
	name = "xenos"
	config_tag = "xenos"
	required_players = 15
	recommended_players = 20
	required_players_secret = 15
	required_enemies = 3
	recommended_enemies = 5

	var/const/waittime_l = 600 //lower bound on time before intercept arrives (in tenths of seconds)
	var/const/waittime_h = 1800 //upper bound on time before intercept arrives (in tenths of seconds)

	var/list/raid_objectives = list()     //Raid objectives.

/datum/game_mode/xenos/announce()
	world << "<B>The current game mode is - Xenos!</B>"
	world << "<B>There is a \red Xenos Attack\black on the station. You can't let them take over!</B>"

/datum/game_mode/xenos/can_start()

	if(!..())
		return 0

	var/list/candidates = get_players_for_role(BE_ALIEN)
	var/playersready = 0
	var/xenos_num
	for(var/mob/new_player/player in player_list)
		if((player.client)&&(player.ready))
			playersready += 1


	//Check that we have enough alien candidates
	if(candidates.len < required_enemies)
		return 0
	if (playersready < recommended_players)
		xenos_num = required_enemies
	if (playersready >= recommended_players)
		xenos_num = recommended_enemies

	//Grab candidates randomly until we have enough.
	while(xenos_num > 0)
		var/datum/mind/new_xenos = pick(candidates)
		xenos += new_xenos
		candidates -= new_xenos
		xenos_num--

	for(var/datum/mind/xeno in xenos)
		xeno.assigned_role = "MODE"
		xeno.special_role = "Alien"
	return 1

/datum/game_mode/xenos/pre_setup()
	return 1

/datum/game_mode/xenos/post_setup()

	var/list/turf/xenos_spawn = list()

	for(var/obj/effect/landmark/A in landmarks_list)
		if(A.name == "Xenos-Spawn")
			xenos_spawn += get_turf(A)
			del(A)
			continue

	var/xenoai_selected = 0
	var/xenoborg_selected=0
	var/xenoqueen_selected=0
	var/spawnpos = 1

	for(var/datum/mind/xeno_mind in xenos)
		if(spawnpos > xenos_spawn.len)
			spawnpos = 1
		xeno_mind.current.loc = xenos_spawn[spawnpos]
//XenoAI selection
		if(!xenoai_selected)
			var/mob/living/silicon/ai/O = new(xeno_mind.current.loc, base_law_type,,1)//No MMI but safety is in effect.
			O.invisibility = 0
			O.aiRestorePowerRoutine = 0

			if(xeno_mind.current)
				xeno_mind.transfer_to(O)
				O.mind.original = O
			else
				O.key = xeno_mind.current.key
			del(xeno_mind)
			var/obj/loc_landmark
			for(var/obj/effect/landmark/start/sloc in landmarks_list)
				if (sloc.name == "XenoAI")
					loc_landmark = sloc
			O.loc = loc_landmark.loc
			O.icon_state = "ai-alien"
			O.verbs.Remove(/mob/living/silicon/ai/verb/pick_icon)
			O.laws = new /datum/ai_laws/alienmov
			O.name = "Alien AI"
			xenoai_selected = 1
			spawnpos++
			continue
//XenoQueen Selection
		if(!xenoqueen_selected)
			var/mob/living/carbon/alien/humanoid/queen/large/O = new(xeno_mind.current.loc)
			if(xeno_mind.current)
				xeno_mind.transfer_to(O)
			else
				O.key = xeno_mind.current.key
			del(xeno_mind)
			xenoqueen_selected = 1
			spawnpos++
			continue
//XenoBorg Selection
		if(!xenoborg_selected)
			var/mob/living/silicon/robot/O = new(xeno_mind.current.loc,0,0,1)
			O.mmi = new /obj/item/device/mmi(O)
			O.mmi.alien = 1
			O.mmi.transfer_identity(xeno_mind.current)//Does not transfer key/client.
			O.cell = new(O)
			O.cell.maxcharge = 15000
			O.cell.charge = 15000
			O.gender = xeno_mind.current.gender
			O.invisibility = 0

			O.key = xeno_mind.current.key
			del(xeno_mind)
			O.job = "Alien Cyborg"
			O.name = "Alien Cyborg"
			O.module = new /obj/item/weapon/robot_module/alien/hunter(src)
			O.hands.icon_state = "standard"
			O.icon = "icons/mob/alien.dmi"
			O.icon_state = "xenoborg-state-a"
			O.modtype = "Xeno-Hu"
			feedback_inc("xeborg_hunter",1)


			xenoborg_selected = 1
			spawnpos++
			continue
//Additional larvas if playercount > 20
		else
			var/mob/living/carbon/alien/larva/O = new(xeno_mind.current.loc)
			if(xeno_mind.current)
				xeno_mind.transfer_to(O)
			else
				O.key = xeno_mind.current.key
			del(xeno_mind)
		spawnpos++

	spawn (rand(waittime_l, waittime_h))
		send_intercept()

	return ..()