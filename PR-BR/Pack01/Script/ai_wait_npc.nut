//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief NPC 待機
   
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// STATEを初期に戻す
	pcOwn.setState(0);
	
	// 移動を止める
	pcOwn.stopMovePosition(); 
			
	// 待機モーションの発行
	pcOwn.setMotionTag(MOTION_F_WAIT, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, true, false);
	
	// アタリをとり続ける
	if (!pcOwn.isHitPreCollision()) {
		pcOwn.setIsRange(false);
	}
			
	return;
}


//-----------------EOF---------------------------------------------------------

