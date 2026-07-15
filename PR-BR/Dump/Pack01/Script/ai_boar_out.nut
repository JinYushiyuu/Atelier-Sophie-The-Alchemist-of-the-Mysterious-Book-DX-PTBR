//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief ランダムで位置を取得して移動
   
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 対象とするプレイヤークラスを取得
	local pcPlayer = SQ.getPlayer();

	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	switch(pcOwn.getState()) {
		case Enum.STATE_SELECT:
			// そのまま移動へ
			pcOwn.setState(Enum.STATE_MOVE_IN);
		break;
		
		// 待機
		case Enum.STATE_WAIT:
			// 念のため移動を止める
			pcOwn.stopMovePosition();
				
			// 待機モーションの発行
			pcOwn.setMotionTag(MOTION_F_WAIT, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, true, true);
			
			// 待機時間も設定
			pcOwn.setTimer(pcOwn.getWaitTime());
			
			// 待機中へ
			pcOwn.setState(Enum.STATE_WAITING);
		break;
		case Enum.STATE_WAITING:
			// タイマーが無くなれば動作へ
			if (pcOwn.getTimer() <= 0.0) {
				pcOwn.setState(Enum.STATE_MOVE_IN);
			}
		break;
		
		// ランダム移動
		case Enum.STATE_MOVE_IN:
			// 既に動いていれば待機へ
			if (pcOwn.isMovePosition()) {
				// ？アイコン
				pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_QUESTION);
				
				// 待機へ
				pcOwn.setState(Enum.STATE_WAIT);
			}
			else {
				// 自身の範囲内でのランダムな座標を取得
				local vToPos = pcOwn.getRandomRangePosition();
				pcOwn.setCustomPos(vToPos);
				
				// その座標までの回転ベクトルを取得
				local vToRot = ::calcTargetRotY(pcOwn, vToPos);
				pcOwn.setCustomRot(vToRot);
				
				// 回転のみ発行
				pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
				
				// 入りモーション
				pcOwn.setMotionTag(MOTION_WALK, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
				
				// アイコン消す
				pcOwn.unsetEmotionIcon();
				
				// 移動へ
				pcOwn.setState(Enum.STATE_MOVE);
			}
		break;
		case Enum.STATE_MOVE:
			if (pcOwn.isEndMotin()) {
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed());
				
				// モーションを歩きに
				pcOwn.setMotionTag(MOTION_WALK, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, true, false);
				
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
			// 移動を止める
			pcOwn.stopMovePosition();
			
			// 戻りモーション
			pcOwn.setMotionTag(MOTION_WALK, 2, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
			
			// 終わりへ
			pcOwn.setState(Enum.STATE_MOVE_END);
		break;
		case Enum.STATE_MOVE_END:
			if (pcOwn.isEndMotin()) {
				pcOwn.setState(Enum.STATE_WAIT);
			}
		break;
		
		default:
			// 最低保証
			pcOwn.setState(Enum.STATE_MOVE_IN);
		break;
	}
	
	// レンジ判定
	if (::isRangeInOut(pcOwn, pcPlayer)) {
		pcOwn.setState(Enum.STATE_SELECT);
	}
	
	return;
}


