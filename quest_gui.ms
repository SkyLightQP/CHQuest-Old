proc(_quest_gui, @name, @text, @text1, @text2, @text3, @npc1, @npc2, @npc3, @ptext, @npcname, @npcid,@player,
	#quest_name_ing.player | ����Ʈ�� ���� ���� (true, false)
	#quest_name_status.player | ����Ʈ�� �޼� ���� (true, false)
	#quest_name_count.player | ����Ʈ ī��Ʈ �� ��ǥ �޼��� �ʿ��� �� (mix, [integer])
	#quest_name.title | ����Ʈ GUI �̸� (string) (�ӽ� ����)
	#quest_name_iclick.player | ����Ʈ GUI �̺�Ʈ ID (mix) (�ӽ� ����)
	#quest_~.player | ����Ʈ ����
	# ��) quest_text.player
	@q = 'quest_'.@name
	@chest = array(
		'id': @name,
		'size': 45,
		'title': 'NPC|'.@npcname,
	)
	store_value('quest_name.'.@player,@name) # �ٸ� ������ �̿�Ǳ� ���� �����ϴ� �ӽ� ����
	store_value('quest_npc1.'.@player, @npc1)
	store_value('quest_npc2.'.@player, @npc2)
	store_value('quest_npc3.'.@player, @npc3)
	store_value('quest_ptext.'.@player, @ptext)
	store_value('quest_npcname.'.@player, @npcname)
	store_value('quest_npcid.'.@player, @npcid)
	
	store_value(@q.'.title','NPC|'.@npcname) # �Ʒ� �̺�Ʈ �� ���������� ����Ʈ GUI Ÿ��Ʋ�� ���ϱ� ���� �ӽ� ����
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
	# �̺�Ʈ ID�� ���ϱ� ���� �ӽ� ���� + �̺�Ʈ
	store_value(@q.'_iclick.'.@player, bind(inventory_click,null,null,@e,
		@n = get_value('quest_name.'.@e['player'])
		@n1 = get_value('quest_npc1.'.@e['player'])
		@n2 = get_value('quest_npc2.'.@e['player'])
		@n3 = get_value('quest_npc3.'.@e['player'])
		@nn = get_value('quest_npcname.'.@e['player'])
		if(get_value('quest_'.@n.'.title') == 'NPC|'.@nn){ # ����Ʈ GUI ���� �����ϴ� IF
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