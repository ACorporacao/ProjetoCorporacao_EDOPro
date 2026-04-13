-- Bowser, o Rei Koopa
-- Efeito: Uma vez por turno: você pode causar 1000 de dano ao oponente.

function c144.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c144.dmg_target)
	e1:SetOperation(c144.dmg_op)
	c:RegisterEffect(e1)
end

function c144.dmg_target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then return true end
end

function c144.dmg_op(e, tp, eg, ep, ev, re, r, rp)
	Duel.Damage(1 - tp, 1000, REASON_EFFECT)
end