//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 適当なウェイトモーションの発行
   
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 対象とするプレイヤークラスを取得
	local pcPlayer = SQ.getPlayer();

	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// 再生するモーションタグ
	local as32MTag = [
		MOTION_F_WAIT,
	];
	
	// 移動は止める
	pcOwn.stopMovePosition();
	
	// アイコン消す
	pcOwn.unsetEmotionIcon();
	
	// ランダムでモーションを選ぶ
		//local s32MotionTag = as32MTag[SQ.randRange(0, as32MTag.len()-1)];
		local s32MotionTag = MOTION_EX9;
		
		// モーションの発行
		pcOwn.setMotionTag(s32MotionTag, 0, 0, Val.MOTION_SPEED, false, true);
		if (s32MotionTag != pcOwn.getOldMotionTag()) {
			pcOwn.setRandomMotion();
		}

	
	// レンジ判定 待機からは即座に移動してもよい
	if (::isRangeInOut(pcOwn, pcPlayer)) {
		pcOwn.setState(Enum.STATE_SELECT);
	}
	
	return;
}


