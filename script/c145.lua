-- Mushroom - Mario Bros.
-- Carta Mágica de Equipamento
-- Efeito: O monstro equipado ganha 1000 ATK.

function c145.initial_effect(c)
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
end