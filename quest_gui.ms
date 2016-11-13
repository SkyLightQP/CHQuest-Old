proc(_quest_gui, @name, @text, @text1, @text2, @text3, @npc1, @npc2, @npc3, @ptext, @npcname, @npcid,@player,
	#quest_name_ing.player | 퀘스트가 진행 여부 (true, false)
	#quest_name_status.player | 퀘스트를 달성 여부 (true, false)
	#quest_name_count.player | 퀘스트 카운트 등 목표 달성에 필요한 것 (mix, [integer])
	#quest_name.title | 퀘스트 GUI 이름 (string) (임시 변수)
	#quest_name_iclick.player | 퀘스트 GUI 이벤트 ID (mix) (임시 변수)
	#quest_~.player | 퀘스트 정보
	# 예) quest_text.player
	@q = 'quest_'.@name
	@chest = array(
		'id': @name,
		'size': 45,
		'title': 'NPC|'.@npcname,
	)
	store_value('quest_name.'.@player,@name) # 다른 곳에서 이용되기 위해 저장하는 임시 변수
	store_value('quest_npc1.'.@player, @npc1)
	store_value('quest_npc2.'.@player, @npc2)
	store_value('quest_npc3.'.@player, @npc3)
	store_value('quest_ptext.'.@player, @ptext)
	store_value('quest_npcname.'.@player, @npcname)
	store_value('quest_npcid.'.@player, @npcid)
	
	store_value(@q.'.title','NPC|'.@npcname) # 아래 이벤트 및 나머지에서 퀘스트 GUI 타이틀을 구하기 위한 임시 변수
	array_set(@chest,13,array(type: 323, data: 0, qty: 1, meta: array(
		display: colorize('&f'.@npcname), lore: array(
		0: @text))))
	array_set(@chest,28,array(type: 332, data: 0, qty: 1, meta: array(
		display: colorize('&f1'), lore: array(
		0: @text1))))
	array_set(@chest,31,array(type: 332, data: 0, qty: 1, meta: array(
		display: colorize('&f2'), lore: array(
		0: @text2))))
	array_set(@chest,34,array(type: 332, data: 0, qty: 1, meta: array(
		display: colorize('&f3'), lore: array(
		0: @text3))))
	create_virtualchest(@chest)
	popen_virtualchest(@name)
	# 이벤트 ID를 구하기 위한 임시 변수 + 이벤트
	store_value(@q.'_iclick.'.@player, bind(inventory_click,null,null,@e,
		@n = get_value('quest_name.'.@e['player'])
		@n1 = get_value('quest_npc1.'.@e['player'])
		@n2 = get_value('quest_npc2.'.@e['player'])
		@n3 = get_value('quest_npc3.'.@e['player'])
		@nn = get_value('quest_npcname.'.@e['player'])
		if(get_value('quest_'.@n.'.title') == 'NPC|'.@nn){ # 퀘스트 GUI 인지 구별하는 IF
			switch(@e['slot']){
				case '13':
					cancel()
					break()
				case '28':
					msg(colorize('&6['.@nn.'] &f'.@n1))
					cancel()
					break()
				case '31':
					msg(colorize('&6['.@nn.'] &f'.@n2))
					cancel()
					break()
				case '34':
					msg(colorize('&6['.@nn.'] &f'.@n3))
					cancel()
					break()
			}
		}
	))
)