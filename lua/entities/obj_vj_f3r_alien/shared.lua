ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Plasma Particle"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

if SERVER then
    util.AddNetworkString("VJ.F3R.ProjOverlay.Alien")
else
    local mat = Material("effects/shockroach_plasma")
    net.Receive("VJ.F3R.ProjOverlay.Alien", function(len, ply)
        local ent = net.ReadEntity()
        if !IsValid(ent) then return end
        local nextBlend = 0
        local flBlend = 1
        local lifeTime = 1
        local deathDelay = CurTime() +lifeTime
        local hookID = "VJ.F3R.ProjOverlay.Alien" .. math.Rand(1,999999999)
        hook.Add("RenderScreenspaceEffects",hookID,function()
            if !IsValid(ent) or CurTime() >= deathDelay +0.1 or flBlend <= 0 then
                hook.Remove("RenderScreenspaceEffects",hookID)
                return
            end
            cam.Start3D(EyePos(),EyeAngles())
                if util.IsValidModel(ent:GetModel()) then
                    render.SetBlend(flBlend)
                    render.MaterialOverride(mat)
                    ent:DrawModel()
                    render.MaterialOverride(0)
                    render.SetBlend(1)
                end
                if ent:IsPlayer() && ent.GetViewModel && IsValid(ent:GetViewModel()) then
                    if util.IsValidModel(ent:GetViewModel():GetModel()) then
                        render.SetBlend(flBlend)
                        render.MaterialOverride(mat)
                        ent:GetViewModel():DrawModel()
                        render.MaterialOverride(0)
                        render.SetBlend(1)
                    end
                end
            cam.End3D()
            if CurTime() >= nextBlend then
                nextBlend = CurTime() +0.05
                if flBlend > 0 then
                    local flBlendAdd = 0.05
                    if CurTime() >= deathDelay then
                        flBlendAdd = flBlendAdd +math.Clamp(((CurTime() -deathDelay) /100), 0, 0.05)
                    end
                    flBlend = flBlend -(lifeTime /(lifeTime ^2)) *flBlendAdd
                end
            end
        end)
    end)
end