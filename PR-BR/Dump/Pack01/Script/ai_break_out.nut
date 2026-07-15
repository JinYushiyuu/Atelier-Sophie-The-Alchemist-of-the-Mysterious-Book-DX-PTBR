//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief フィールド離脱動作
   
   @return         -
   @author         Mori
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 対象とするプレイヤークラスを取得
	local pcPlayer = SQ.getPlayer();

	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// 逃げるときの範囲
	const of32EscapeArea = 10.0;
	
	// 歩くときの速度倍率とモーションスピード
	const of32WalkSpeed 		= 1.0;
	const of32WalkMotionSpeed 	= 1.0;
	
	switch( pcOwn.getState() ) {
	case Enum.STATE_SELECT:
		{
			// 進行座標取得
			local vToPos = pcOwn.getPositionToPlayerLeave( of32EscapeArea );
			pcOwn.setCustomPos(vToPos);
					
			// その座標までの回転ベクトルを取得
			local vToRot = ::calcTargetRotY( pcOwn, vToPos );
			pcOwn.setCustomRot(vToRot);
			
			// 回転のみ発行
			pcOwn.moveRotation( vToRot, Val.CHARA_ROT_LIFE );
			
			// 入りモーション
			local s32MotionTag 		= MOTION_WALK;
			local f32MotionSpeed 	= of32WalkMotionSpeed;
			pcOwn.setMotionTag( s32MotionTag, 0, Val.MOTION_BLEND_FRAME, f32MotionSpeed, false, false );
			
			// 索敵を一時的に無効に
			pcOwn.setIsJudgeRange(false);
			
			// 移動開始
			pcOwn.setState( Enum.STATE_MOVE );
		}
		break;
		
	case Enum.STATE_MOVE:
			if ( pcOwn.isEndMotin() ) {
				// モーションを歩きに
				local s32MotionTag 		= MOTION_WALK;
				local f32MotionSpeed 	= of32WalkMotionSpeed;
				local f32Speed 			= of32WalkSpeed;
				
				// 移動を発行
				local vToPos = pcOwn.getCustomPos();
				pcOwn.movePosition( vToPos, pcOwn.getMoveSpeed() * f32Speed );
				
				pcOwn.setMotionTag( s32MotionTag, 1, Val.MOTION_BLEND_FRAME, f32MotionSpeed, true, false );
				
				// 移動中へ
				pcOwn.setState(Enum.STATE_MOVING);
			}
		break;
	case Enum.STATE_MOVING:

		break;
	default:
		pcOwn.setState( Enum.STATE_SELECT );
		
		break;
	}
	
	return;
}

//-----------------EOF---------------------------------------------------------
