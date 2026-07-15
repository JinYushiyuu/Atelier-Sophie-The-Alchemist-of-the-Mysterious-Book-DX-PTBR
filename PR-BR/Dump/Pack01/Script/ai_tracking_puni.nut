//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 対象位置を取得して追尾(A16用新モーション対応版)
   
   @return         -
   @author         Yuki-Kozai_Yuichiro-Kosako
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 対象とするプレイヤークラスを取得
	local pcPlayer = SQ.getPlayer();

	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// モーション速度
	const of32RunMotionSpeed = 0.3;
	
	
	switch(pcOwn.getState()) {
		case Enum.STATE_SELECT:
			// そのまま移動へ
			pcOwn.setState(Enum.STATE_MOVE);
		break;
		
		case Enum.STATE_WAIT:
			// 移動を止める
			pcOwn.stopMovePosition();
			
			// アイコン消す
			pcOwn.unsetEmotionIcon();
				
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
				pcOwn.setState(Enum.STATE_MOVE);
			}
		break;
		
		case Enum.STATE_MOVE:
		{
			// 対象の座標を取得
			local vToPos = pcPlayer.getPosition();
			if (!pcOwn.isMaxRangeIn(vToPos)) {
			
				// 対象の座標が最大範囲外ならそのまま待機
				pcOwn.setState(Enum.STATE_WAIT);
			}
			else {	
				// その座標までの回転ベクトルを取得
				local vToRot = ::calcTargetRotY(pcOwn, vToPos);
				
				// 座標移動と回転移動を発行
				pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed());
				pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
				
				// モーションを歩きに
				pcOwn.setMotionTag(MOTION_RUN, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED * of32RunMotionSpeed, true, false);
				
				// 再計算用のタイマーをセット
				pcOwn.setTimer(Val.CHARA_TRACKING_TIME);
				
				// 怒りアイコン
				pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_EX);
				
				// 移動中へ
				pcOwn.setState(Enum.STATE_MOVING);
			}
		}
		break;
		
		case Enum.STATE_MOVING:
			// 移動しているのでコリジョンとのアタリをとる
			if (pcOwn.isHitCollision()) {
				// コリジョンに当たっていれば待機へ
				pcOwn.setState(Enum.STATE_WAIT);
			}
			else if ( pcOwn.getTimer() <= 0.0 || !pcOwn.isMovePosition()) {
				// タイマーが無くなった、または移動が終了していれば追尾へ
				pcOwn.setState(Enum.STATE_MOVE);
			}
		break;
		
		default:
			// 最低保証
			pcOwn.setState(Enum.STATE_MOVE);
		break;
	}
	
	// レンジ判定
	if (::isRangeInOut(pcOwn, pcPlayer)) {
		pcOwn.setState(Enum.STATE_SELECT);
	}
	
	return;
}