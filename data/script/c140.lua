--Dinossonic
function c140.initial_effect(c)
	c:EnableReviveLimit()
	
	-- Fusão: "141" + 1 monstro Dinossauro
	aux.AddFusionProcMix(c,true,true,140,aux.FilterBoolFunction(Card.IsRace,RACE_DINOSAUR))
end