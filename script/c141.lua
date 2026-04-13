-- Yoshi
-- Efeito: Uma vez por turno: você pode selecionar 1 monstro do oponente
-- e equipá-lo a esta carta como Carta Mágica de Equipamento.

function c141.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c141.equip_target)
	e1:SetOperation(c141.equip_op)
	c:RegisterEffect(e1)
end

function c141.equip_target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
	if chkc then
		return chkc:IsLocation(LOCATION_MZONE)
			and chkc:IsControler(1 - tp)
			and chkc:IsAbleToChangeControler()
	end
	if chk == 0 then
		return Duel.IsExistingTarget(nil, tp, 0, LOCATION_MZONE, 1, nil)
	end
	Duel.SelectTarget(tp, nil, tp, 0, LOCATION_MZONE, 1, 1, nil)
end

function c141.equip_op(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	local tc = Duel.GetFirstTarget()
	if tc == nil or not tc:IsRelateToEffect(e) then return end

	-- Move o monstro alvo para a Zona de Magia/Armadilha como equipamento
	Duel.SendtoField(tc, tp, LOCATION_SZONE, POS_FACEUP, REASON_EFFECT)

	-- Efeito de equipamento: Yoshi ganha ATK/DEF do monstro equipado
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(tc:GetAttack())
	e2:SetReset(RESET_EVENT + 0x1fe0000 + EVENT_LEAVES_FIELD)
	c:RegisterEffect(e2)

	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(tc:GetDefense())
	e3:SetReset(RESET_EVENT + 0x1fe0000 + EVENT_LEAVES_FIELD)
	c:RegisterEffect(e3)

	-- Se Yoshi for destruído, o monstro equipado vai para o cemitério do oponente
	local e4 = Effect.CreateEffect(tc)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetReset(RESET_EVENT + 0x1fe0000 + EVENT_LEAVES_FIELD)
	e4:SetValue(c141.equip_limit)
	tc:RegisterEffect(e4)
end

-- Devolve o monstro ao cemitério do dono se o equipamento quebrar
function c141.equip_limit(e, c)
	if c:IsLocation(LOCATION_SZONE) then
		Duel.SendtoGraveyard(c, c:GetOwner(), REASON_EFFECT)
	end
	return false
end