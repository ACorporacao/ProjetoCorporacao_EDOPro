-- Princesa Peach
-- Efeito: Precisa sofrer 2 ataques no mesmo turno para ser destruída em batalha.

function c140.initial_effect(c)
	-- Efeito de substituição: impede destruição no 1º ataque e conta
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REPLACE)
	e1:SetCondition(c140.rep_con)
	e1:SetOperation(c140.rep_op)
	c:RegisterEffect(e1)
end

-- Condição: só substitui se ainda não foi atacada este turno (contador < 1)
function c140.rep_con(e, re, r, rp)
	return e:GetHandler():GetFieldID() ~= 0
		and (e:GetHandler():GetTurnID() ~= Game.GetTurnCount()
			 or (e:GetHandler():GetFieldID() ~= 0
				 and c140.get_hit_count(e:GetHandler()) < 1))
end

-- Operação: incrementa o contador e cancela a destruição
function c140.rep_op(e, re, r, rp)
	local c = e:GetHandler()
	local aux = c:GetSAuxiliary()
	c:SetSAuxiliary(aux + 1)
	-- Reseta o contador no fim do turno
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PHASE + PHASE_END)
	e2:SetCondition(c140.reset_con)
	e2:SetOperation(c140.reset_op)
	e2:SetReset(RESET_EVENT + 0x1fe0000 + EVENT_PHASE + PHASE_END)
	c:RegisterEffect(e2)
end

function c140.get_hit_count(c)
	return c:GetSAuxiliary()
end

function c140.reset_con(e, tp, eg, ep, ev, re, r, rp)
	return true
end

function c140.reset_op(e, tp, eg, ep, ev, re, r, rp)
	e:GetHandler():SetSAuxiliary(0)
end