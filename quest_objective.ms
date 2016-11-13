proc(_quest_objective, @objective, @oa, @reward, @ra, @rtext, @npcname, @e, @player,
	#tmsg(@player, 'DEBUG : 이벤트가 작동되었습니다')
	#tmsg(@player, @e)
	#quest_name_ing.player | 퀘스트가 진행 여부 (true, false)
	#quest_name_status.player | 퀘스트를 달성 여부 (true, false)
	#quest_name_count.player | 퀘스트 카운트 등 목표 달성에 필요한 것 (mix, [integer])
	#quest_name.title | 퀘스트 GUI 이름 (string) (임시 변수)
	#quest_name_iclick.player | 퀘스트 GUI 이벤트 ID (mix) (임시 변수)
	#quest.player | 퀘스트 이름 (임시 변수)
	#quest_~.player | 퀘스트 정보
	# 예) quest_text.player
	@n = get_value('quest_name.'.@player)
	@ing = ('quest_'.@n.'_ing.'.@player)
	@count = ('quest_'.@n.'_count.'.@player)
	@objective = array('type': '')
	@oa = array('entitytype': '', 'name': '', 'qty': '')
	@oa = array('item': '', 'qty': '')
	@oa = array('command': '')
	@reward = array('type': '')
	@ra = array('qty': '')
	#tmsg(@player, 'DEBUG : 중간 디버그')
	if(@objective['type'] == 'entitykill'){
		#msg('DEBUG : 목표 종류가 엔티디 죽이기입니다.')
		if(@ra['type'] == 'money'){
			#tmsg(@player, 'DEBUG : 보상 종류가 돈입니다.')
		@player = @e['cause']
		if(!is_null(@player) && array_index_exists(@e, 'cause')){
			if(strip_colors(get_mob_name(@e['id'])) == @oa['name']){
				#tmsg(@player, 'DEBUG : 죽인 엔티디와 설정한 몹 이름이 같습니다.')
				if((get_value(@ing) != false) && (!is_null(get_value(@ing)))){
					#tmsg(@player, 'DEBUG : 해당 퀘스트가 진행중입니다.')
					if(get_value(@count) < @oa['qty']){
						store_value(@count, add(get_value(@count), 1))
						tmsg(@player['damager'],colorize('&f[&b퀘스트&f] &6퀘스트 진행중 &e['.get_value(@count).']'))
					}
					else{
						if(get_value(@count) >= subtract(integer(@oa['qty']),1)){
						if(get_value(@ing) == true){
							tmsg(@player['damager'],colorize('&6['.@npcname.'] : &f'.@rtext))
							tmsg(@player['damager'],colorize('&f[&b퀘스트&f] &e'.@ra['qty'].' 리아&6를 얻으셨습니다!'))
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