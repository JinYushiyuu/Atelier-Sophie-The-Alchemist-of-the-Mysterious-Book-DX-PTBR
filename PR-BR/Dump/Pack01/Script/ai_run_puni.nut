//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief とにかく逃げる がおー 
   
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
		Enum.STATE_PATTERN0 // , Enum.STATE_PATTERN3
	]; // 逃げる、、シカト



	// 待機時間
	const of32WaitTimeMin = 0.2;
	const of32WaitTimeMax = 0.3;
	
	// 逃げるときの索敵範囲(角度) 
	const of32EscapeArea = 360.0;
	
	// 逃げるときの速度倍率とモーションスピード
	const of32EscapeSpeed = 6;
	const of32EscapeMotionSpeed = 2.0;
	

	
	
	switch( pcOwn.getState() )
	{
		// 初期値 
		case Enum.STATE_SELECT:
		{
			pcOwn.setCustomParam( 0 );
			pcOwn.setState( Enum.STATE_EX0 );

			// 移動を止める
			pcOwn.stopMovePosition(); 
			// 念のためアイコン消す
			pcOwn.unsetEmotionIcon();

			// 索敵もどす 
			pcOwn.setIsJudgeRange(false);
		} break;

		// 待機 
		case Enum.STATE_WAIT:
		{
			// 移動を止める
			pcOwn.stopMovePosition(); 
			// 念のためアイコン消す
			pcOwn.unsetEmotionIcon();
			// 索敵もどす 
			pcOwn.setIsJudgeRange(false);

			// 待機モーションの発行
			pcOwn.setMotionTag(MOTION_F_WAIT, 0, 0.4, Val.MOTION_SPEED, true, false);

			// 待機時間も設定
			pcOwn.setTimer(SQ.randRangeF(of32WaitTimeMin, of32WaitTimeMax));

			// 待機中へ
			pcOwn.setState(Enum.STATE_WAITING);
		} break;

		// 待機中 
		case Enum.STATE_WAITING:
		{
			if( pcOwn.getTimer() <= 0.0 )
			{
				pcOwn.setState(Enum.STATE_SELECT);
			}
		} break;

		// 逃げる
		case Enum.STATE_EX0:
		{
			// プレイヤーとは逆の逃げる座標取得
			local vToPos = pcOwn.getPositionToPlayerEscape( of32EscapeArea );

			if( !pcOwn.isMaxRangeIn( pcPlayer.getPosition() ) )
			{
				// 対象の座標が最大範囲外ならそのまま待機
				pcOwn.setState(Enum.STATE_WAIT);
			}
			else
			{
				pcOwn.setCustomPos(vToPos);
				
				// その座標までの回転ベクトルを取得
				local vToRot = ::calcTargetRotY(pcOwn, vToPos);
				pcOwn.setCustomRot(vToRot);
				
				// 回転のみ発行
				pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
				
				// 走りモーション入り
				pcOwn.setMotionTag(MOTION_RUN, 0, 0.5, of32EscapeMotionSpeed, false, false);
				
				// 索敵を一時的に無効に
				pcOwn.setIsJudgeRange(false);
				
				// 焦りアイコン
				//pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_FEAR);
				
				// 回転移動へ 
				pcOwn.setState(Enum.STATE_EX1);
			}
		} break;

		// 回転移動 
		case Enum.STATE_EX1:
		{
			if( pcOwn.isEndMotin() )
			{
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition( vToPos, pcOwn.getMoveSpeed()*of32EscapeSpeed );
				
				// 走りモーション
				pcOwn.setMotionTag(MOTION_RUN, 1, 0.3, of32EscapeMotionSpeed, true, false);
				
				// タイマーをセット
				pcOwn.setTimer( 0.3 );
				
				// ダッシュへ 
				pcOwn.setState(Enum.STATE_EX2);
			}
		} break;

		case Enum.STATE_EX2:
		{
			// 移動しているのでコリジョンとのアタリをとる
			if( pcOwn.isHitCollision() || !pcOwn.isMovePosition() )
			{
				// 移動が終了していれば移動終わりへ
				if( pcOwn.getTimer() <= 0.0 )
				{
					pcOwn.setState( Enum.STATE_EX3 );
				}
				else
				{
					// 座標再取得 
					pcOwn.setState( Enum.STATE_EX0 );
					// 索敵戻す
					pcOwn.setIsJudgeRange(true);
				}
			}
		} break;

		// 移動終わり 
		case Enum.STATE_EX3:
		{
			// 移動を止める
			pcOwn.stopMovePosition();

			// プレイヤーの方向へ
			local vToPos = pcPlayer.getPosition();
			local vToRot = ::calcTargetRotY(pcOwn, vToPos);
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			// 走りモーション戻り
			pcOwn.setMotionTag(MOTION_RUN, 2, 0.3, of32EscapeMotionSpeed, false, false);

			// がおー溜めへ 
			pcOwn.setState( Enum.STATE_EX6 );
		} break;

		// がおー溜め 
		case Enum.STATE_EX4:
			if (pcOwn.isEndMotin())
		{
				pcOwn.setMotionTag(MOTION_EX8, 0, 0.3, Val.MOTION_SPEED, false, false);

				// がおーへ 
				pcOwn.setState(Enum.STATE_EX5);
			}
		break;

		// がおー 
		case Enum.STATE_EX5:
			if (pcOwn.isEndMotin()) {
				pcOwn.setMotionTag(MOTION_EX8, 1, 0.3, Val.MOTION_SPEED, false, false);

				// 遷移する行動パターン
				local as32StatePattern = [ 
					Enum.STATE_EX4, Enum.STATE_EX6, Enum.STATE_EX6
				];

				// ランダムで更にがおー 
				pcOwn.setState( as32StatePattern[ SQ.randRange(0, as32StatePattern.len()-1) ] );
			}
		break;

		// がおー終了待ち 
		case Enum.STATE_EX6:
			if( pcOwn.isEndMotin() )
			{
				// 索敵戻す
				pcOwn.setIsJudgeRange(true);
					
				// ループ
				pcOwn.setState(Enum.STATE_EX0);
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

