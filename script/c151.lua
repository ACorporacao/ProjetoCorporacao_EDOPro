-- Star - Mario Bros.
-- Carta Mágica de Equipamento
-- Efeito: O monstro equipado não pode ser destruído em batalha,
-- você não sofre dano de batalha, destrói qualquer monstro que batalhar
-- com ele. Enviada ao cemitério na 2ª Fase Final após ativação.

function c151.initial_effect(c)
	-- 1) Monstro equipado não pode ser destruído em batalha
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)

	-- 2) Controlador não sofre dano de batalha
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)

	-- 3) Qualquer monstro que batalhar com o equipado é destruído
	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DESTROY_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)

	-- 4) Contador de End Phase: enviada ao cemitério na 2ª End Phase
	local e4 = Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_PHASE + PHASE_END)
	e4:SetCondition(c151.expire_con)
	e4:SetOperation(c151.expire_op)
	e4:SetReset(RESET_EVENT + 0x1fe0000 + EVENT_PHASE + PHASE_END)
	c:RegisterEffect(e4)
end

-- Contador de End Phases armazenado em SAuxiliary
function c151.expire_con(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	return c:IsLocation(LOCATION_SZONE)
end

function c151.expire_op(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	local count = c:GetSAuxiliary() + 1
	if count >= 2 then
		Duel.SendtoGraveyard(c, c:GetOwner(), REASON_EFFECT)
	else
		c:SetSAuxiliary(count)
	end
end