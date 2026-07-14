//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief ミニ竜 未発見動作
   
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 対象とするプレイヤークラスを取得
	local pcPlayer = SQ.getPlayer();

	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// 遷移する行動パターン
	local as32StatePattern = [ 
		Enum.STATE_PATTERN0, Enum.STATE_PATTERN2, Enum.STATE_PATTERN3,
	]; // 吠える、歩く、走る
	
	// 歩くときの速度倍率とモーションスピード
	const of32WalkSpeed = 1.0;
	const of32WalkMotionSpeed = 1.0;
	
	// 走るときの速度倍率とモーションスピード
	const of32RunSpeed = 1.2;
	const of32RunMotionSpeed  = 1.0;
	
	
	switch(pcOwn.getState()) {
		// 遷移選択
		case Enum.STATE_SELECT:
			// まずは待機へ
			pcOwn.setState(Enum.STATE_WAIT);
		break;
		
		// 待機
		case Enum.STATE_WAIT:
			// 既に動いていればアイコン表示
			if (pcOwn.isMovePosition()) {
				// ？アイコン
				pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_QUESTION);
			}
			else {
				// アイコン消す
				pcOwn.unsetEmotionIcon();
			}
			
			// 移動を止める
			pcOwn.stopMovePosition(); 
			
			// 待機モーションの発行
			pcOwn.setMotionTag(MOTION_F_WAIT, 0, 0.5, Val.MOTION_SPEED, true, true);
			
			// 待機時間も設定
			pcOwn.setTimer(pcOwn.getWaitTime());
			
			// 待機中へ
			pcOwn.setState(Enum.STATE_WAITING);
		break;
		case Enum.STATE_WAITING:
			// タイマーが無くなれば動作へ
			if (pcOwn.getTimer() <= 0.0) {
				// ランダムで選択
				local s32Index = as32StatePattern[ SQ.randRange(0, as32StatePattern.len()-1) ];
				pcOwn.setCustomParam(s32Index);
				switch(s32Index) {
					case Enum.STATE_PATTERN0:
						pcOwn.setState(Enum.STATE_EX2);
					break;
					
					// 歩く
					case Enum.STATE_PATTERN2:
						pcOwn.setState(Enum.STATE_MOVE_IN);
					break;
					
					// 走る
					case Enum.STATE_PATTERN3:
						pcOwn.setState(Enum.STATE_MOVE_IN);
					break;
					
					default:
					break;
				}
				// アイコン消す
				pcOwn.unsetEmotionIcon();
			}
		break;
		
		// 移動
		case Enum.STATE_MOVE_IN:
		{
			// 自身の範囲内でのランダムな座標を取得
			local vToPos = pcOwn.getRandomRangePosition();
			pcOwn.setCustomPos(vToPos);
			
			// その座標までの回転ベクトルを取得
			local vToRot = ::calcTargetRotY(pcOwn, vToPos);
			pcOwn.setCustomRot(vToRot);
			
			// 回転のみ発行
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			// 入りモーション
			local s32MotionTag = MOTION_WALK;
			local f32MotionSpeed = of32WalkMotionSpeed;
			if (pcOwn.getCustomParam() == Enum.STATE_PATTERN3) {
				s32MotionTag = MOTION_WALK;
				f32MotionSpeed = of32RunMotionSpeed;
			}
			pcOwn.setMotionTag(s32MotionTag, 0, Val.MOTION_BLEND_FRAME, f32MotionSpeed, false, false);
			
			// 移動へ
			pcOwn.setState(Enum.STATE_MOVE);
		}
		break;
		case Enum.STATE_MOVE:
			if (pcOwn.isEndMotin()) {
				// モーションを歩きに
				local s32MotionTag = MOTION_WALK;
				local f32MotionSpeed = of32WalkMotionSpeed;
				local f32Speed = of32WalkSpeed;
				if (pcOwn.getCustomParam() == Enum.STATE_PATTERN3) {
					s32MotionTag = MOTION_WALK;
					f32MotionSpeed = of32RunMotionSpeed;
					f32Speed = of32RunSpeed;
				}
				
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed()*f32Speed);
				
				pcOwn.setMotionTag(s32MotionTag, 1, Val.MOTION_BLEND_FRAME, f32MotionSpeed, true, false);
				
				// 移動中へ
				pcOwn.setState(Enum.STATE_MOVING);
			}
		break;
		case Enum.STATE_MOVING:
			// 移動しているのでコリジョンとのアタリをとる
			if (pcOwn.isHitCollision() || !pcOwn.isMovePosition()) {
				// 当たっている、または移動が終了していれば移動終わりへ
				pcOwn.setState(Enum.STATE_MOVE_OUT);
			}
		break;
		case Enum.STATE_MOVE_OUT:
		{
			// 移動を止める
			pcOwn.stopMovePosition();
			
			// 戻りモーション
			local s32MotionTag = MOTION_WALK;
			local f32MotionSpeed = of32WalkMotionSpeed;
			if (pcOwn.getCustomParam() == Enum.STATE_PATTERN3) {
				s32MotionTag = MOTION_WALK;
				f32MotionSpeed = of32RunMotionSpeed;
			}
			pcOwn.setMotionTag(s32MotionTag, 2, Val.MOTION_BLEND_FRAME, f32MotionSpeed, false, false);
			
			// 終わりへ
			pcOwn.setState(Enum.STATE_MOVE_END);
		}
		break;
		case Enum.STATE_MOVE_END:
			if (pcOwn.isEndMotin()) {
				pcOwn.setState(Enum.STATE_SELECT);
			}
		break;
		
		// 動作１
		case Enum.STATE_EX0:
			// モーション発行
			pcOwn.setMotionTag(MOTION_EX9, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
			pcOwn.setState(Enum.STATE_EX1);
		break;
		case Enum.STATE_EX1:
			if (pcOwn.isEndMotin()) {
				pcOwn.setState(Enum.STATE_SELECT);
			}
		break;
		
		// 動作２
		case Enum.STATE_EX2:
			// モーション発行
			pcOwn.setMotionTag(MOTION_EX8, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
			pcOwn.setState(Enum.STATE_EX3);
		break;
		case Enum.STATE_EX3:
			if (pcOwn.isEndMotin()) {
				pcOwn.setMotionTag(MOTION_EX8, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
				pcOwn.setState(Enum.STATE_EX4);
			}
		break;
		case Enum.STATE_EX4:
			if (pcOwn.isEndMotin()) {
				pcOwn.setState(Enum.STATE_SELECT);
			}
		break;
		
		default:
			// 最低保証
			pcOwn.setState(Enum.STATE_SELECT);
		break;
	}
	
	// レンジ判定
	if (::isRangeInOut(pcOwn, pcPlayer)) {
		pcOwn.setState(Enum.STATE_SELECT);
	}
	
	return;
}


//-----------------EOF---------------------------------------------------------

