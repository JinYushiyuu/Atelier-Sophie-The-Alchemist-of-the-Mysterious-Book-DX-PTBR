//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief NPC パーティキャラ
   
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// 再生させるモーション
	local s32MotionTag = MOTION_EV_ACT_24;
	
	// STATEを間借りする
	switch(pcOwn.getState()) {
		case Enum.STATE_EX0:
		{
			// 使用するDIV
			local s32Div = 0;
			
			// 使用するインデクスの初期化
			local s32Index = 0;
			pcOwn.setCustomParam(s32Index);
			
			// Index0のモーションを再生
			pcOwn.setMotionTag(s32MotionTag, s32Div, 0.0, Val.MOTION_SPEED, true, false);
			
			// インデクス上げる
			pcOwn.setCustomParam(++s32Index);
		}
		break;
		
		case Enum.STATE_EX1:
		break;
		
		default:
			// 最低保証
			pcOwn.setState(Enum.STATE_EX0);
		break;
	}
	
	return;
}


//-----------------EOF---------------------------------------------------------

