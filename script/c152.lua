-- Flower - Mario Bros.
-- Carta Mágica de Equipamento
-- Efeito: Uma vez por turno: cause 800 de dano ao oponente.

function c152.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1)
	e1:SetTarget(c152.dmg_target)
	e1:SetOperation(c152.dmg_op)
	c:RegisterEffect(e1)
end

function c152.dmg_target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then return true end
end

function c152.dmg_op(e, tp, eg, ep, ev, re, r, rp)
	Duel.Damage(1 - tp, 800, REASON_EFFECT)
end