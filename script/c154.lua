-- Ovo de Yoshi - Mario Bros.
-- Carta Mágica Normal
-- Efeito: Adicione 1 yoshi do seu deck à sua mão.

local YOSHI = 141 -- Yoshi (c141)

function c154.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c154.activate_target)
	e1:SetOperation(c154.activate_op)
	c:RegisterEffect(e1)
end

function c154.activate_target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then
		return Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_DECK, 0, 1, nil, YOSHI)
	end
end

function c154.activate_op(e, tp, eg, ep, ev, re, r, rp)
	Duel.SelectMatchingCard(tp, Card.IsCode, tp, LOCATION_DECK, 0, 1, 1, nil, YOSHI)
	local tc = Duel.GetFirstTarget()
	if tc then
		Duel.SendtoHand(tc, nil, REASON_EFFECT)
		Duel.ConfirmCards(1 - tp, tc)
	end
end