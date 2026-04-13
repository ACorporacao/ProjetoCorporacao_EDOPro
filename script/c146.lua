-- Green Mushroom - Mario Bros.
-- Carta Mágica Normal
-- Efeito: Você ganha 2000 pontos de vida.

function c146.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c146.activate_op)
	c:RegisterEffect(e1)
end

function c146.activate_op(e, tp, eg, ep, ev, re, r, rp)
	Duel.RecoverLP(tp, 2000)
end