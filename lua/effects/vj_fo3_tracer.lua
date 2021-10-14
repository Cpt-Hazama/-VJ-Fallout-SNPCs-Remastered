local Tracer = Material("trails/smoke")
local Tracer2  = Material("cpthazama/fallout/tracer")
local Width = 2.65
local Width2 = 7

function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.WeaponEnt = data:GetEntity()
	if !IsValid(self.WeaponEnt) then self.DieTime = 0 return end
	self.Player = self.WeaponEnt:GetOwner()
	self.Attachment = data:GetAttachment()
	self.ModelEnt = self.WeaponEnt.clMdl or self.WeaponEnt

	local muzEnt = ((self.Player != LocalPlayer()) or self.Player:ShouldDrawLocalPlayer()) && self.WeaponEnt or self.ModelEnt
	-- self.StartPos = self:GetTracerShootPos(self.Position,self.ModelEnt,self.Attachment)
	self.StartPos = muzEnt:GetAttachment(self.Attachment).Pos
	self:SetRenderBoundsWS(self.StartPos,self.EndPos)

	self.Dir = (self.EndPos -self.StartPos):GetNormalized()
	self.Dist = self.StartPos:Distance(self.EndPos)
	
	self.LifeTime = 0.5
	self.LifeTime2 = 0.1 *self.LifeTime
	self.DieTime = CurTime() +self.LifeTime
	self.DieTime2 = CurTime() +self.LifeTime2

	-- ParticleEffect("vj_rifle_full",self.StartPos,self.Dir:Angle(),nil)

	self.ShouldDrawSmoke = math.random(1,3) == 1
end

function EFFECT:Think()
	if CurTime() > self.DieTime then
		return false
	end
	return true
end

function EFFECT:Render()
	if CurTime() > self.DieTime then return end
	local r = 255
	local g = 220
	local b = 120
	
	local v = (self.DieTime -CurTime()) /self.LifeTime
	local v2 = (self.DieTime2 -CurTime()) /self.LifeTime2

	if self.ShouldDrawSmoke then
		render.SetMaterial(Tracer)
		render.DrawBeam(self.StartPos,self.EndPos,(v *Width),0,self.Dist /10,Color(20,20,20,v *90))
	end
	render.SetMaterial(Tracer2)
	render.DrawBeam(self.StartPos,self.EndPos,(v2 *Width2) *0.66,0,self.Dist /10,Color(r,g,b,(v2 *95) *0.5))
end