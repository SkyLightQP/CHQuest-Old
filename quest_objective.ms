proc(_quest_objective, @objective, @oa, @reward, @ra, @rtext, @npcname, @e, @player,
	#tmsg(@player, 'DEBUG : �̺�Ʈ�� �۵��Ǿ����ϴ�')
	#tmsg(@player, @e)
	#quest_name_ing.player | ����Ʈ�� ���� ���� (true, false)
	#quest_name_status.player | ����Ʈ�� �޼� ���� (true, false)
	#quest_name_count.player | ����Ʈ ī��Ʈ �� ��ǥ �޼��� �ʿ��� �� (mix, [integer])
	#quest_name.title | ����Ʈ GUI �̸� (string) (�ӽ� ����)
	#quest_name_iclick.player | ����Ʈ GUI �̺�Ʈ ID (mix) (�ӽ� ����)
	#quest.player | ����Ʈ �̸� (�ӽ� ����)
	#quest_~.player | ����Ʈ ����
	# ��) quest_text.player
	@n = get_value('quest_name.'.@player)
	@ing = ('quest_'.@n.'_ing.'.@player)
	@count = ('quest_'.@n.'_count.'.@player)
	@objective = array('type': '')
	@oa = array('entitytype': '', 'name': '', 'qty': '')
	@oa = array('item': '', 'qty': '')
	@oa = array('command': '')
	@reward = array('type': '')
	@ra = array('qty': '')
	#tmsg(@player, 'DEBUG : �߰� �����')
	if(@objective['type'] == 'entitykill'){
		#msg('DEBUG : ��ǥ ������ ��Ƽ�� ���̱��Դϴ�.')
		if(@ra['type'] == 'money'){
			#tmsg(@player, 'DEBUG : ���� ������ ���Դϴ�.')
		@player = @e['cause']
		if(!is_null(@player) && array_index_exists(@e, 'cause')){
			if(strip_colors(get_mob_name(@e['id'])) == @oa['name']){
				#tmsg(@player, 'DEBUG : ���� ��Ƽ��� ������ �� �̸��� �����ϴ�.')
				if((get_value(@ing) != false) && (!is_null(get_value(@ing)))){
					#tmsg(@player, 'DEBUG : �ش� ����Ʈ�� �������Դϴ�.')
					if(get_value(@count) < @oa['qty']){
						store_value(@count, add(get_value(@count), 1))
						tmsg(@player['damager'],colorize('&f[&b����Ʈ&f] &6����Ʈ ������ &e['.get_value(@count).']'))
					}
					else{
						if(get_value(@count) >= subtract(integer(@oa['qty']),1)){
						if(get_value(@ing) == true){
							tmsg(@player['damager'],colorize('&6['.@npcname.'] : &f'.@rtext))
							tmsg(@player['damager'],colorize('&f[&b����Ʈ&f] &e'.@ra['qty'].' ����&6�� �����̽��ϴ�!'))
							acc_add(@player['damager'],integer(@ra['qty']))
							play_sound(ploc(@player['damager']),array('sound':'LEVEL_UP','volume':1,'pitch':'0.5'))
							store_value(@ing, false)
							exit()
						}
						}
					}
				}
			}
		}
		}
	}
)