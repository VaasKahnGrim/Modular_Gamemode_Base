local MainFolder = ""
local Abort = false

local folder_block = {
	global = true,
	cfg = true
}

local function AttemptLoad(name)
	name = string.lower(name) --Ensure that people don't try to do stupid shit on linux

	--This will automatically prevent trying to load folders that are not meant for subsections
	if GM.LoadRules[name] and folder_block[name] or then
		local Check
		if GM.LoadRules[name].Func then --Check if the LoadRule has a function to check
			Check = GM.LoadRules[name].Func()
		else
			check = true
		end

		if Check then
			MainFolder = name
		elseif GM.LoadRules[name].Fallback then
			--If the check function returned false we try to use its fallback folder
			MainFolder = string.lower(GM.LoadRules[name].Fallback)
		else
			--if we can't pass the checker function and the Fallback is false then clearly we can't continue here so return false
			return false
		end

		return true
	end

	return false --if the rule didn't exist then we return false
end

if not AttemptLoad(game.GetMap()) then
	if not AttemptLoad(GM.StartFolder or "default") or MainFolder == "" then
		Abort = true
	end
end

if Abort then
	MsgC(Color(255,0,0),"VaasGM | We failed to load a gamemode section. Double check that you have either a map specific section put into the gamemode and that the GM.StartFolder exists. If you removed the default section then expect problems for sure.")
else
	local fol = GM.FolderName.."/gamemode/"
	--Load Global portions that are used everywhere
	AddCSLuaFile(fol.."global/loader.lua")
	include(fol.."global/loader.lua")

	--Load the subsections inherit portion if it has one
	if GM.LoadRules[MainFolder].Inherit then
		AddCSLuaFile(fol..GM.LoadRules[MainFolder].Inherit.."/loader.lua")
		include(fol..GM.LoadRules[MainFolder].Inherit.."/loader.lua")
	end

	--Load the sub-section using MainFolder
	AddCSLuaFile(fol..MainFolder.."/loader.lua")
	include(fol..MainFolder.."/loader.lua")
end

local Category = GM.GamemodeName or "VaasGM"
function GM:GetGameDescription()
	return Category
end


