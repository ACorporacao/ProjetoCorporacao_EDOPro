-- Pena - Mario Bros.
-- Carta Mágica de Equipamento
-- Efeito: Uma vez por turno: destrua 1 Carta Mágica do oponente.

function c149.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetTarget(c149.destroy_target)
	e1:SetOperation(c149.destroy_op)
	c:RegisterEffect(e1)
end

function c149.is_valid(c)
	return c:IsType(TYPE_SPELL)
end

function c149.destroy_target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
	if chkc then
		return chkc:IsLocation(LOCATION_SZONE)
			and chkc:IsControler(1 - tp)
			and c149.is_valid(chkc)
	end
	if chk == 0 then
		return Duel.IsExistingTarget(c149.is_valid, tp, 0, LOCATION_SZONE, 1, nil)
	end
	Duel.SelectTarget(tp, c149.is_valid, tp, 0, LOCATION_SZONE, 1, 1, nil)
end

function c149.destroy_op(e, tp, eg, ep, ev, re, r, rp)
	local tc = Duel.GetFirstTarget()
	if tc == nil or not tc:IsRelateToEffect(e) then return end
	Duel.Destroy(tc, REASON_EFFECT)
end