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
		Enum.MOTION_NPC, MOTION_EV_ACT_2, 0, 1.0, false, pcOwn.isEndMotin(), 
		Enum.POS_MOVE_NPC_EX, 32345.0 ,0.0 , 24985.0, MOTION_EV_ACT_4, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 32825.0 ,0.0 , 24433.0, MOTION_EV_ACT_4, fMoveSpeed,
		Enum.MOTION_NPC, MOTION_EV_ACT_2, 2, 1.0, false, pcOwn.isEndMotin(), 
		Enum.POS_MOVE_NPC_EX, 32200.0 ,0.0 , 25023.5, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 32333.0 ,0.0 , 30946.0, MOTION_WALK, fMoveSpeed,
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

