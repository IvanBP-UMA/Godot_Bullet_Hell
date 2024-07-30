extends Node

var currentAct = null

func updateCurrentAct(newAct: LevelAct):
	currentAct = newAct
	
func resetTracker():
	currentAct = null
