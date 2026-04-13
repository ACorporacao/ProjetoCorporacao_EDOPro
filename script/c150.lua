-- Leaf - Mario Bros.
-- Carta Mágica de Equipamento
-- Efeito: Uma vez por turno: descarte 1 carta da mão do oponente.

function c150.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetTarget(c150.discard_target)
	e1:SetOperation(c150.discard_op)
	c:RegisterEffect(e1)
end

function c150.discard_target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then
		return Duel.IsExistingMatchingCard(nil, tp, 0, LOCATION_HAND, 1, nil)
	end
end

function c150.discard_op(e, tp, eg, ep, ev, re, r, rp)
	if Duel.IsExistingMatchingCard(nil, tp, 0, LOCATION_HAND, 1, nil) then
		Duel.SelectMatchingCard(1 - tp, nil, tp, 0, LOCATION_HAND, 1, 1, nil)
		local tc = Duel.GetFirstTarget()
		if tc then
			Duel.SendtoGraveyard(tc, tp, REASON_EFFECT + REASON_DISCARD)
		end
	end
end