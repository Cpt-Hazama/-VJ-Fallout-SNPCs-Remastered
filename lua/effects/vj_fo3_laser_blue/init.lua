function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then self.DieTime = 0 return end
	self.Player = self.WeaponEnt:GetOwner()
	self.Attachment = data:GetAttachment()
	self.ModelEnt = self.WeaponEnt.VJ_CModel or self.WeaponEnt.clMdl or self.WeaponEnt

	local muzEnt = ((self.Player != LocalPlayer()) or self.Player:ShouldDrawLocalPlayer()) && self.WeaponEnt or self.ModelEnt
	self.StartPos = muzEnt:GetAttachment(self.Attachment).Pos
	self:SetRenderBoundsWS(self.StartPos,self.EndPos)

	self.Dir = (self.EndPos -self.StartPos):GetNormalized()
	self.Dist = self.StartPos:Distance(self.EndPos)

	util.ParticleTracerEx("vj_f3r_laser_blue", self.StartPos, self.EndPos, false, self.ModelEnt:EntIndex(), self.Attachment)

	self.HasHit = false
	self.HitTime = math.min(1,self.StartPos:Distance(self.EndPos) /30000)
	self.DieTime = CurTime() +self.HitTime *1.01

	local pos = self.EndPos
	timer.Simple(self.HitTime,function()
		ParticleEffect("vj_f3r_laser_blue_impact",pos,Angle(0,0,0),nil)
	end)
end

function EFFECT:Think()
	if CurTime() > self.DieTime then
		return false
	end
	return true
end

function EFFECT:Render() end