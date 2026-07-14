//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 犬スラグ 発見動作
   
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
		Enum.STATE_PATTERN0, Enum.STATE_PATTERN1, Enum.STATE_PATTERN2, Enum.STATE_PATTERN3,
	]; // 逃げる、突貫１、突貫２、シカト
	
	// 待機時間
	const of32WaitTime = 2.0;
	
	// 逃げるときの索敵範囲
	const of32EscapeArea = 90.0;
	
	// 逃げるときの速度倍率とモーションスピード
	const of32EscapeSpeed = 1.0;
	const of32EscapeMotionSpeed = 1.0;
	
	// 突貫１の速度倍率とモーションスピード
	const of32WalkSpeed = 1.5;
	const of32WalkMotionSpeed = 1.0;
	
	// 突貫２の速度倍率とモーションスピード
	const of32RunSpeed = 1.5;
	const of32RunMotionSpeed = 1.0;
	
	
	switch(pcOwn.getState()) {
		// 遷移選択
		case Enum.STATE_SELECT:
		{
			// ランダムで選択
			local s32Index = as32StatePattern[ SQ.randRange(0, as32StatePattern.len()-1) ];
			pcOwn.setCustomParam(s32Index);
			switch(s32Index) {
				// 逃げる
				case Enum.STATE_PATTERN0:
					pcOwn.setState(Enum.STATE_EX0);
				break;
				
				// 突貫１
				case Enum.STATE_PATTERN1:
					pcOwn.setState(Enum.STATE_EX7);
				break;
				
				// 突貫２
				case Enum.STATE_PATTERN2:
					pcOwn.setState(Enum.STATE_EX14);
				break;
				
				// シカト
				case Enum.STATE_PATTERN3:
					pcOwn.setState(Enum.STATE_EX20);
				break;
				
				default:
				break;
			}
			// 移動を止める
			pcOwn.stopMovePosition(); 
			
			// 念のためアイコン消す
			pcOwn.unsetEmotionIcon();
		}
		break;
		
		// 待機
		case Enum.STATE_WAIT:
			// アイコン消す
			pcOwn.unsetEmotionIcon();
			
			// 移動を止める
			pcOwn.stopMovePosition(); 
			
			// 待機モーションの発行
			pcOwn.setMotionTag(MOTION_WAIT, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, true, true);
			
			// 待機時間も設定
			pcOwn.setTimer(SQ.randRangeF(of32WaitTime/2.0, of32WaitTime));
			
			// 待機中へ
			pcOwn.setState(Enum.STATE_WAITING);
		break;
		case Enum.STATE_WAITING:
			if (pcOwn.getTimer() <= 0.0) {
				local s32Index = pcOwn.getCustomParam();
				if (s32Index == Enum.STATE_PATTERN0) {
					pcOwn.setState(Enum.STATE_EX0);
				}
				else if (s32Index == Enum.STATE_PATTERN1) {
					pcOwn.setState(Enum.STATE_EX7);
				}
				else {
					pcOwn.setState(Enum.STATE_SELECT);
				}
			}
		break;
		
		// 逃げる
		case Enum.STATE_EX0:
			// プレイヤーとは逆の逃げる座標取得
			local vToPos = pcOwn.getPositionToPlayerEscape(of32EscapeArea);
			if (!pcOwn.isMaxRangeIn(pcPlayer.getPosition())) {
				// 対象の座標が最大範囲外ならそのまま待機
				pcOwn.setState(Enum.STATE_WAIT);
			}
			else {
				pcOwn.setCustomPos(vToPos);
				
				// その座標までの回転ベクトルを取得
				local vToRot = ::calcTargetRotY(pcOwn, vToPos);
				pcOwn.setCustomRot(vToRot);
				
				// 回転のみ発行
				pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
				
				// 走りモーション入り
				pcOwn.setMotionTag(MOTION_WALK, 0, Val.MOTION_BLEND_FRAME, of32EscapeMotionSpeed, false, false);
				
				// 索敵を一時的に無効に
				pcOwn.setIsJudgeRange(false);
				
				// 焦りアイコン
				//pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_FEAR);
				
				// 移動へ
				pcOwn.setState(Enum.STATE_EX1);
			}
		break;
		case Enum.STATE_EX1:
			if (pcOwn.isEndMotin()) {
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed()*of32EscapeSpeed);
				
				// 走りモーション
				pcOwn.setMotionTag(MOTION_WALK, 1, Val.MOTION_BLEND_FRAME, of32EscapeMotionSpeed, true, false);
				
				// タイマーをセット
				pcOwn.setTimer(0.3);
				
				// 移動中へ
				pcOwn.setState(Enum.STATE_EX2);
			}
		break;
		case Enum.STATE_EX2:
			// 移動しているのでコリジョンとのアタリをとる
			if (pcOwn.isHitCollision() || !pcOwn.isMovePosition()) {
				// 当たっている、または移動が終了していれば移動終わりへ
				if (pcOwn.getTimer() <= 0.0) {
					pcOwn.setState(Enum.STATE_EX3);
				}
				else {
					// 索敵戻す
					pcOwn.setIsJudgeRange(true);
					
					// 待機へ
					pcOwn.setState(Enum.STATE_WAIT);
				}
			}
		break;
		case Enum.STATE_EX3:
		{
			// 移動を止める
			pcOwn.stopMovePosition();
			
			// プレイヤーの方向へ
			local vToPos = pcPlayer.getPosition();
			local vToRot = ::calcTargetRotY(pcOwn, vToPos);
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			// 走りモーション戻り
			pcOwn.setMotionTag(MOTION_WALK, 2, Val.MOTION_BLEND_FRAME, of32EscapeMotionSpeed, false, false);
			
			pcOwn.setState(Enum.STATE_EX4);
		}
		break;
		case Enum.STATE_EX4:
			if (pcOwn.isEndMotin()) {
				pcOwn.setMotionTag(MOTION_EX8, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
				
				pcOwn.setState(Enum.STATE_EX5);
			}
		break;
		case Enum.STATE_EX5:
			if (pcOwn.isEndMotin()) {
				pcOwn.setMotionTag(MOTION_EX8, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
				
				pcOwn.setState(Enum.STATE_EX6);
			}
		break;
		case Enum.STATE_EX6:
			if (pcOwn.isEndMotin()) {
				// 索敵戻す
				pcOwn.setIsJudgeRange(true);
					
				// ループ
				pcOwn.setState(Enum.STATE_EX0);
			}
		break;
		
		// 突貫１
		case Enum.STATE_EX7:
		{
			// 対象の座標を取得
			local vToPos = pcPlayer.getPosition();
			
			// その座標までの回転ベクトルを取得
			local vToRot = ::calcTargetRotY(pcOwn, vToPos);
			
			// 回転のみ発行
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			pcOwn.setMotionTag(MOTION_EX8, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
			
			// 怒りアイコン
			pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_ANGRY);
			
			pcOwn.setState(Enum.STATE_EX8);
		}
		break;
		case Enum.STATE_EX8:
			if (pcOwn.isEndMotin()) {
				pcOwn.setMotionTag(MOTION_EX8, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
				
				pcOwn.setState(Enum.STATE_EX9);
			}
		break;
		case Enum.STATE_EX9:
			if (pcOwn.isEndMotin()) {
				// 対象の座標を取得
				local vToPos = pcOwn.getPositionToPlayerBehind();
				pcOwn.setCustomPos(vToPos);
				
				// その座標までの回転ベクトルを取得
				local vToRot = ::calcTargetRotY(pcOwn, vToPos);
				pcOwn.setCustomRot(vToRot);
				
				// 回転のみ発行
				pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
				
				// 歩きモーション入り
				//pcOwn.setMotionTag(MOTION_B_RUN, 0, Val.MOTION_BLEND_FRAME, of32WalkMotionSpeed, false, false);
				
				// 移動へ
				pcOwn.setState(Enum.STATE_EX10);
			}
		break;
		case Enum.STATE_EX10:
			if (pcOwn.isEndMotin()) {
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed()*of32WalkSpeed);
				
				// モーションを歩きに
				pcOwn.setMotionTag(MOTION_B_RUN, 1, Val.MOTION_BLEND_FRAME, of32WalkMotionSpeed, true, false);
				
				// 移動中へ
				pcOwn.setState(Enum.STATE_EX11);
			}
		break;
		case Enum.STATE_EX11:
			// 移動しているのでコリジョンとのアタリをとる
			if (pcOwn.isHitCollision() || !pcOwn.isMovePosition()) {
				// 当たっている、または移動が終了していれば移動終わりへ
				pcOwn.setState(Enum.STATE_EX12);
			}
		break;
		case Enum.STATE_EX12:
			// 移動を止める
			pcOwn.stopMovePosition();
			
			// 歩きモーション戻り
			//pcOwn.setMotionTag(MOTION_WALK, 2, Val.MOTION_BLEND_FRAME, of32WalkMotionSpeed, false, false);
			
			pcOwn.setState(Enum.STATE_EX13);
		break;
		case Enum.STATE_EX13:
			//if (pcOwn.isEndMotin()) {
				// 待機へ
				pcOwn.setState(Enum.STATE_WAIT);
			//}
		break;
		
		// 突貫２
		case Enum.STATE_EX14:
		{
			// 対象の座標を取得
			local vToPos = pcPlayer.getPosition();
			
			// その座標までの回転ベクトルを取得
			local vToRot = ::calcTargetRotY(pcOwn, vToPos);
			
			// 回転のみ発行
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			pcOwn.setMotionTag(MOTION_EX9, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
			
			// 怒りアイコン
			pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_ANGRY);
			
			pcOwn.setState(Enum.STATE_EX15);
		}
		break;
		case Enum.STATE_EX15:
			if (pcOwn.isEndMotin()) {
				// 移動を発行
				local vToPos = pcOwn.getPositionToPlayerBehind();
				pcOwn.setCustomPos(vToPos);
				
				// その座標までの回転ベクトルを取得
				local vToRot = ::calcTargetRotY(pcOwn, vToPos);
				pcOwn.setCustomRot(vToRot);
				
				// 回転のみ発行
				pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
				
				// 走りモーション入り
				//pcOwn.setMotionTag(MOTION_B_RUN, 0, Val.MOTION_BLEND_FRAME, of32RunMotionSpeed, false, false);
				
				// 移動へ
				pcOwn.setState(Enum.STATE_EX16);
			}
		break;
		case Enum.STATE_EX16:
			//if (pcOwn.isEndMotin()) {
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed()*of32RunSpeed);
				
				// モーションを走りに
				pcOwn.setMotionTag(MOTION_B_RUN, 1, Val.MOTION_BLEND_FRAME, of32RunMotionSpeed, true, false);
				
				// 移動中へ
				pcOwn.setState(Enum.STATE_EX17);
			//}
		break;
		case Enum.STATE_EX17:
			// 移動しているのでコリジョンとのアタリをとる
			if (pcOwn.isHitCollision() || !pcOwn.isMovePosition()) {
				// 当たっている、または移動が終了していれば移動終わりへ
				pcOwn.setState(Enum.STATE_EX18);
			}
		break;
		case Enum.STATE_EX18:
			// 移動を止める
			pcOwn.stopMovePosition();
			
			// 走りモーション戻り
			//pcOwn.setMotionTag(MOTION_B_RUN, 2, Val.MOTION_BLEND_FRAME, of32RunMotionSpeed, false, false);
			
			pcOwn.setState(Enum.STATE_EX19);
		break;
		case Enum.STATE_EX19:
			//if (pcOwn.isEndMotin()) {
				// 待機へ
				pcOwn.setState(Enum.STATE_WAIT);
			//}
		break;
		
		// シカト
		case Enum.STATE_EX20:
		{
			// 対象の座標を取得
			local vToPos = pcPlayer.getPosition();
			
			// その座標までの回転ベクトルを取得
			local vToRot = ::calcTargetRotY(pcOwn, vToPos);
			
			// 回転のみ発行
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			pcOwn.setMotionTag(MOTION_EX8, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
			
			pcOwn.setState(Enum.STATE_EX21);
		}
		break;
		case Enum.STATE_EX21:
			if (pcOwn.isEndMotin()) {
				pcOwn.setMotionTag(MOTION_EX8, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
				
				pcOwn.setState(Enum.STATE_EX22);
			}
		break;
		case Enum.STATE_EX22:
			if (pcOwn.isEndMotin()) {
				// ループ
				pcOwn.setState(Enum.STATE_EX19);
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

