GM.StartFolder = "default" --The folder to load first
GM.GamemodeName = "VaasGM" --The name of the gamemode to be used
GM.LoadRules = {
	Default = {
		Fallback = false,
	},
	gm_construct = {
		Fallback = "default",
		Inherit = "default",
		Func = function()
			if 1+1 == 2 then
				return true
			end
			
			return false
		end
	},
	gm_flatgrass = {
		Fallback = "default",
		Inherit = "default"
	}
}


