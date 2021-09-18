ENT.Base 			= "npc_vj_human_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Instructions 	= ""
ENT.Category		= "NPC"

ENT.VJ_FalloutHumanoid = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Mouth")
end

if CLIENT then
    function ENT:Think()
        self:SetPoseParameter("mouth",self:GetMouth())
    end
end

//Bip01 Ponytail1