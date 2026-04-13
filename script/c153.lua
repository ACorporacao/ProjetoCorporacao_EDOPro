-- Interruptor P - Mario Bros.
-- Carta Mágica Normal
-- Efeito: Selecione 1 dos seguintes efeitos:
-- ● Envie Moedas ao cemitério e adicione igual número de Blocos Randômicos.
-- ● Envie Blocos Randômicos ao cemitério e adicione igual número de Moedas.

local MOEDA  = 148 -- Moeda - Mario Bros.
local BLOCO  = 147 -- Bloco Randômico - Mario Bros.

function c153.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c153.activate_target)
	e1:SetOperation(c153.activate_op)
	c:RegisterEffect(e1)
end

function c153.activate_target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then
		local has_moeda = Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_HAND + LOCATION_FIELD, 0, 1, nil, MOEDA)
		local has_bloco = Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_HAND + LOCATION_FIELD, 0, 1, nil, BLOCO)
		return has_moeda or has_bloco
	end
end

function c153.activate_op(e, tp, eg, ep, ev, re, r, rp)
	-- Jogador escolhe qual efeito usar
	local choice = Duel.SelectOption(tp, 
		HINTMSG_EFFECT,
		"Enviar Moedas → Adicionar Blocos",
		"Enviar Blocos → Adicionar Moedas"
	)

	local send_id, add_id
	if choice == 0 then
		send_id = MOEDA
		add_id  = BLOCO
	else
		send_id = BLOCO
		add_id  = MOEDA
	end

	-- Seleciona qualquer número de cartas para enviar ao cemitério
	local count = Duel.GetMatchingGroupCount(Card.IsCode, tp, LOCATION_HAND + LOCATION_FIELD, 0, nil, send_id)
	if count == 0 then
		Duel.Hint(HINT_MESSAGE, tp, HINTMSG_NOTARGET)
		return
	end

	Duel.SelectMatchingCard(tp, Card.IsCode, tp, LOCATION_HAND + LOCATION_FIELD, 0, 1, count, nil, send_id)
	local targets = Duel.GetTargetCards(e)
	local sent = 0

	targets:ForEach(function(tc)
		if tc:IsRelateToEffect(e) then
			Duel.SendtoGraveyard(tc, tp, REASON_EFFECT)
			sent = sent + 1
		end
	end)

	-- Adiciona o mesmo número do deck
	if sent > 0 then
		local available = Duel.GetMatchingGroupCount(Card.IsCode, tp, LOCATION_DECK, 0, nil, add_id)
		local to_add = math.min(sent, available)
		if to_add > 0 then
			Duel.SelectMatchingCard(tp, Card.IsCode, tp, LOCATION_DECK, 0, to_add, to_add, nil, add_id)
			local adds = Duel.GetTargetCards(e)
			adds:ForEach(function(tc)
				Duel.SendtoHand(tc, nil, REASON_EFFECT)
				Duel.ConfirmCards(1 - tp, tc)
			end)
		end
	end
end