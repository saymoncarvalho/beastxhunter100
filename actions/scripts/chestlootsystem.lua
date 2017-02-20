local chest_areas = {
	[8001] = {name = 'Hunt Spider', time = 60, monster = {'Dworc Voodoomaster', 50}, storage = 178740, container = 1988, items = {{50,2160,1},{50,2173,1},{5,2494,1},{30,2466,1},{80,2495,1},{100,2148,15}}},
	[8002] = {name = 'Hunt Spider', time = 60, monster = {'Dworc Voodoomaster', 50}, storage = 178741, container = 1988, items = {{50,2160,1},{5,2160,1},{5,2160,1},{5,2160,1},{5,2160,1},{5,2160,1}}},
	[8003] = {name = 'Hunt Dragon', time = 60, monster = {'Dworc Voodoomaster', 60}, storage = 178742, container = 1988, items = {{50,2160,1},{5,2160,1},{5,2160,1},{5,2160,1},{5,2160,1},{5,2160,1}}}
}
function onUse(cid, item, frompos, item2, topos)
	local v = chest_areas[item.actionid]
	if not v then return true end
	if getPlayerStorageValue(cid, v.storage) >= os.time() then
		doPlayerSendTextMessage(cid,22,'você só pode pegar outro premio em '..os.date("%X", getPlayerStorageValue(cid, v.storage))..'.') return true
	end
	local items, quest_container, str = v.items, doPlayerAddItem(cid, v.container, 1), 'BackPack from '..v.name..', Your Rewards:\n'
	for i = 1, table.maxn(items) do
		local chance, item_id, amount = items[i][1], items[i][2], items[i][3]
		if chance >= math.random(1, 100) then
			str = str .. amount .. ' ' .. getItemNameById(item_id) .. ' '..(i ~= table.maxn(items) and ', ' or '.')
			if isItemStackable(item_id) or amount == 1 then
				doAddContainerItem(quest_container, item_id, amount)
			else
				for i = 1, amount do
					doAddContainerItem(quest_container, 1)
				end
			end
		end
	end
	if v.monster[2] >= math.random(1, 100) then
	doSummonCreature(v.monster[1], getPlayerPosition(cid))
	doCreatureSay(cid, "você não roubará meu tesouro!!", TALKTYPE_ORANGE_1)
	end
	doSendMagicEffect(getPlayerPosition(cid), math.random(28,30))
	setPlayerStorageValue(cid, v.storage, os.time()+v.time*60)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,'You have found a '..str) return true
end