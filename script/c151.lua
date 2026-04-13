-- Star - Mario Bros.
-- Carta Mágica de Equipamento

function c151.initial_effect(c)
	-- Ativação (equipar)
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_EQUIP)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetTarget(c151.target)
	e0:SetOperation(c151.operation)
	c:RegisterEffect(e0)

	-- Indestrutível em batalha
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)

	-- Sem dano de batalha
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetValue(1)
	c:RegisterEffect(e2)

	-- Destrói monstro em batalha
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DESTROY_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)

	-- Vai para o cemitério após 2 End Phases
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetOperation(c151.expire_op)
	c:RegisterEffect(e4)
end

function c151.filter(c)
	return c:IsFaceup()
end

function c151.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c151.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end

function c151.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end

function c151.expire_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=(c:GetTurnCounter() or 0)+1
	c:SetTurnCounter(ct)
	if ct>=2 then
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end