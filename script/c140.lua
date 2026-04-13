-- Princesa Peach
-- Precisa sofrer 2 ataques no mesmo turno para ser destruída em batalha.

function c140.initial_effect(c)
	-- Substituição de destruição em batalha (primeiro ataque não destrói)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REPLACE)
	e1:SetTarget(c140.reptg)
	e1:SetOperation(c140.repop)
	c:RegisterEffect(e1)
end

function c140.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		return c:IsReason(REASON_BATTLE) and (c:GetTurnCounter() or 0)<1
	end
	return true
end

function c140.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=(c:GetTurnCounter() or 0)+1
	c:SetTurnCounter(ct)

	-- Reset no fim do turno
	if ct==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetOperation(c140.resetop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

function c140.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():SetTurnCounter(0)
end