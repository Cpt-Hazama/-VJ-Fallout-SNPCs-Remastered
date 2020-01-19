ENT.Base 			= "npc_vj_f3r_mirelurk"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Instructions 	= ""
ENT.Category		= "NPC"

if(CLIENT) then
	local mat = Material("effects/magmalurk_hotglow")
	function ENT:Initialize()
		local index = self:EntIndex()
		hook.Add("RenderScreenspaceEffects","VJ_F3R_Overlay" .. index,function()
			if !IsValid(self) then
				hook.Remove("RenderScreenspaceEffects","VJ_F3R_Overlay" .. index)
				return
			end
			if !IsValid(self) then return end
			cam.Start3D(EyePos(),EyeAngles())
				if util.IsValidModel(self:GetModel()) then
					render.SetBlend(0.8)
					render.MaterialOverride(mat)
					self:DrawModel()
					render.MaterialOverride(0)
					render.SetBlend(1)
				end
			cam.End3D()
		end)
	end
end