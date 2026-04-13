-- Random Block - Mario Bros.
-- Carta Mágica Normal
-- Efeito: Role um dado. Adicione 1 carta ao seu deck baseada no resultado.

local roll_to_card = {
	[1] = 148, -- Moeda - Mario Bros.
	[2] = 145, -- Cogumelo - Mario Bros.
	[3] = 152, -- Flor de Fogo - Mario Bros.
	[4] = 150, -- Folha - Mario Bros.
	[5] = 149, -- Pena - Mario Bros.
	[6] = 151, -- Estrela - Mario Bros.
}

function c147.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c147.activate_target)
	e1:SetOperation(c147.activate_op)
	c:RegisterEffect(e1)
end

function c147.activate_target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then
		for _, cid in pairs(roll_to_card) do
			if Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_DECK, 0, 1, nil, cid) then
				return true
			end
		end
		return false
	end
end

function c147.activate_op(e, tp, eg, ep, ev, re, r, rp)
	local roll = Duel.RollDice(e:GetHandler(), 1, 6)
	local cid = roll_to_card[roll]

	if Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_DECK, 0, 1, nil, cid) then
		Duel.SelectMatchingCard(tp, Card.IsCode, tp, LOCATION_DECK, 0, 1, 1, nil, cid)
		local tc = Duel.GetFirstTarget()
		if tc then
			Duel.SendtoHand(tc, nil, REASON_EFFECT)
			Duel.ConfirmCards(1 - tp, tc)
		end
	else
		Duel.Hint(HINT_MESSAGE, tp, HINTMSG_NOTARGET)
	end
end