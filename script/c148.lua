-- Moeda - Mario Bros.
-- Carta Mágica Normal
-- Efeito: Selecione 1 Monstro que você controla e compre 2 cartas.

function c148.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c148.activate_target)
	e1:SetOperation(c148.activate_op)
	c:RegisterEffect(e1)
end

function c148.is_valid(c)
	return c:IsType(TYPE_MONSTER)
		and c:IsSetCard(0x1) -- substitua pelo SetCode do arquétipo Mario Bros.
end

function c148.activate_target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
	if chkc then
		return chkc:IsLocation(LOCATION_MZONE)
			and chkc:IsControler(tp)
			and c148.is_valid(chkc)
	end
	if chk == 0 then
		return Duel.IsExistingTarget(c148.is_valid, tp, LOCATION_MZONE, 0, 1, nil)
	end
	Duel.SelectTarget(tp, c148.is_valid, tp, LOCATION_MZONE, 0, 1, 1, nil)
end

function c148.activate_op(e, tp, eg, ep, ev, re, r, rp)
	local tc = Duel.GetFirstTarget()
	if tc == nil or not tc:IsRelateToEffect(e) then return end
	Duel.Draw(tp, 2, REASON_EFFECT)
end