/////////////////////////////////////////////////////////////////////////////////////////
// Crew jobs - by Hellhound1
// Basically, gives staff jobs to do.
/////////////////////////////////////////////////////////////////////////////////////////

/datum/job_objective/save_crew
	completion_payment=1000
	
/datum/job_objective/save_crew/get_description()
	return "Make sure everyone gets off the station, dead or alive."
	
/datum/job_objective/save_crew/check_for_completion()
	
	if(emergency_shuttle.location==2)
		var/area/shuttle = locate(/area/shuttle/escape/centcom)
		var/area/pod1 =    locate(/area/shuttle/escape_pod1/centcom)
		var/area/pod2 =    locate(/area/shuttle/escape_pod2/centcom)
		var/area/pod3 =    locate(/area/shuttle/escape_pod3/centcom)
		var/area/pod4 =    locate(/area/shuttle/escape_pod5/centcom)
		
		
		for(var/mob/living/player in world)
			if (player.mind)
				if  (get_turf(player) in shuttle)
					
					//world << "in shuttle"
					
				
				else if (get_turf(player) in pod1)
					
					//world << "in pod1"
					
				
				else if (get_turf(player) in pod2)
					
					//world << "in pod2"
										
					
				else if (get_turf(player) in pod3)  
					
					//world << "in pod3"
										
					
				else if (get_turf(player) in pod4)
					
					//world << "in pod4"
					
				
				else
					count++
					//world << "Not in anything"
					
				
	if (count==0 && emergency_shuttle.location==2)
		return 1
				
					
					
		
		
/datum/job_objective/no_dead
	completion_payment=1000
	
/datum/job_objective/no_dead/get_description()
	return "Make sure there are no dead bodies left around the station. Corpses must be placed in the morgue, or in a bodybag on the escape shuttle, if anything goes wrong."
	
/datum/job_objective/no_dead/check_for_completion()
		return 0
	