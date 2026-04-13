-- Toad
-- Efeito: Uma vez por turno: você pode selecionar 1 Carta Mágica
-- ou Armadilha virada para baixo do oponente e destruí-la.

function c142.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c142.destroy_target)
	e1:SetOperation(c142.destroy_op)
	c:RegisterEffect(e1)
end

function c142.is_valid(c)
	return (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
		and c:IsFacedown()
end

function c142.destroy_target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
	if chkc then
		return chkc:IsLocation(LOCATION_SZONE)
			and chkc:IsControler(1 - tp)
			and c142.is_valid(chkc)
	end
	if chk == 0 then
		return Duel.IsExistingTarget(c142.is_valid, tp, 0, LOCATION_SZONE, 1, nil)
	end
	Duel.SelectTarget(tp, c142.is_valid, tp, 0, LOCATION_SZONE, 1, 1, nil)
end

function c142.destroy_op(e, tp, eg, ep, ev, re, r, rp)
	local tc = Duel.GetFirstTarget()
	if tc == nil or not tc:IsRelateToEffect(e) then return end
	Duel.Destroy(tc, REASON_EFFECT)
end