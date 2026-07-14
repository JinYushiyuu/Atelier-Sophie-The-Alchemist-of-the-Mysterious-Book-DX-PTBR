//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*!@file
   @brief  NPC move Squirrel Script【 AI NPC Nut 】
   
   (c) Copyright 2012 GUST, Inc...All rights reserved.
   
   @author Yuki-Kozai
   @date   2012/04/24 Yuki-Kozai・ver-1.00 Kick Off
*/ 
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏[ tab4 ]


//------- Import


//------- Global Variable


//------- Function


//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief NPC TOWN_R_00 COW_PANA
   
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	// 自身となるキャラクラスを取得
	local pcOwn = SQ.getActiveChara();
	
	// excelで設定された自身の初期位置
	local vOPos = pcOwn.getOriginPosition();
	local vORot = pcOwn.getOriginRotation();
	
	local fMoveSpeed = pcOwn.getMoveSpeed() + 0.2;
	
	//港からギルドまでの往復
	local as32CommandArray = [
		Enum.POS_MOVE_NPC_EX, 3000.0 ,440.0 , 3970.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3030.0 ,240.0 , 4370.0, MOTION_WALK, fMoveSpeed,
		
		Enum.POS_MOVE_NPC_EX, 3050.0 ,240.0 , 4520.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3100.0 ,60.0 , 4900.0, MOTION_WALK, fMoveSpeed,
		
		Enum.POS_MOVE_NPC_EX, 3830.0 ,60.0 , 4900.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3960.0 ,0.0 , 4900.0, MOTION_WALK, fMoveSpeed,
		
		Enum.POS_MOVE_NPC_EX, 5900.0 ,0.0 , 5100.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 6800.0 ,0.0 , 5490.0, MOTION_WALK, fMoveSpeed,
		Enum.FADE_OUT_NPC, 
		Enum.WAIT_NPC, 300.0,
		Enum.FADE_IN_NPC,
		Enum.POS_MOVE_NPC_EX, 5900.0 ,0.0 , 5100.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3960.0 ,0.0 , 4900.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3830.0 ,60.0 , 4900.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3100.0 ,60.0 , 4900.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3050.0 ,240.0 , 4520.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3030.0 ,240.0 , 4370.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 3000.0 ,440.0 , 3970.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 2470.0 ,450.0 , 3970.0, MOTION_WALK, fMoveSpeed,
		Enum.FADE_OUT_NPC, 
		Enum.WAIT_NPC, 1200.0,
		Enum.FADE_IN_NPC,
		Enum.LOOP_NPC, // 最初に戻る 



		Enum.WAIT_NPC, 5.0,
		Enum.POS_MOVE_NPC_EX, 7810.0 ,0.0 , 12580.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 7823.0 ,0.0 , 12600.0, MOTION_WALK, fMoveSpeed,
		Enum.FADE_IN_NPC, 
	
		Enum.POS_MOVE_NPC_EX, 10200.0 ,0.0 , 14338.0, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 10977.0 ,0.0 , 18209.0, MOTION_WALK, fMoveSpeed,
		Enum.FADE_OUT_NPC, 

		Enum.FADE_IN_NPC, 
		Enum.MOTION_NPC, MOTION_WALK, 0, 1.0, false, pcOwn.isEndMotin(), 
		Enum.LOOP_NPC, // 最初に戻る 

	];
/*
	local as32CommandArray = [
		Enum.POS_MOVE_NPC, 1.0 ,0.0 , 33.5,
		Enum.FADE_OUT_NPC, 
		Enum.POS_SET_NPC, 0.0, -100.0, 0.0,
		Enum.ROT_MOVE_NPC, 180.0,
		Enum.WAIT_NPC, 5.0,
		Enum.POS_SET_NPC, 3.7, 0.0, 33.5,
		Enum.FADE_IN_NPC, 

		Enum.POS_MOVE_NPC, 3.4 ,0.0 , -10.7,
		Enum.FADE_OUT_NPC, 
		Enum.POS_SET_NPC, 0.0, -100.0, 0.0,
		Enum.ROT_MOVE_NPC, 0.0,
		Enum.POS_SET_NPC, 0.3, 0.0, 33.5,
		Enum.FADE_IN_NPC, 

		Enum.POS_MOVE_NPC, 0.3 ,0.0 , -10.7,
		Enum.FADE_OUT_NPC, 
		Enum.POS_SET_NPC, 0.0, -100.0, 0.0,
		Enum.ROT_MOVE_NPC, 0.0,
		Enum.WAIT_NPC, 5.0,
		Enum.POS_SET_NPC, 1.0,  0.0, -10.7,
		Enum.FADE_IN_NPC, 
	
//		Enum.WAIT_NPC, 10.0,
	];
*/
	// 遷移
	::conditionSelector(pcOwn, as32CommandArray);
	
	// アタリをとり続ける
	if (pcOwn.isHitPreCollision()) {
		pcOwn.setIsRange(true);
	}
			
	return;
}


//-----------------EOF---------------------------------------------------------

