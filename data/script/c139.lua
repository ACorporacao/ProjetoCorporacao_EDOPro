--Nome da carta
local s,id=GetID()

function s.initial_effect(c)
	c:EnableReviveLimit()
	
	-- Procedimento de Fusão
	Fusion.AddProcMixN(c,true,true,s.matfilter,5)
end

-- Filtro de materiais
function s.matfilter(c,fc,sumtype,tp)
	return c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINGEDBEAST,fc,sumtype,tp)
end