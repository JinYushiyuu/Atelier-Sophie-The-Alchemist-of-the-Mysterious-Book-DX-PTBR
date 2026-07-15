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
				
		Enum.ENABLE_MAP_SYMBOL, false,
		Enum.FADE_OUT_NPC,
		Enum.POS_MOVE_NPC_EX, 33252.4 ,96.0 , 41006.0, MOTION_WALK, fMoveSpeed,
		Enum.FADE_IN_NPC,
		Enum.POS_MOVE_NPC_EX, 32487.8 ,96.0 , 41240.7, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 32068.4, 0.0, 41671.7, MOTION_WALK, fMoveSpeed,
		Enum.ENABLE_MAP_SYMBOL, true,
		Enum.POS_MOVE_NPC_EX, 31638.4 ,0.0 , 42083.2, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 32562.1 ,0.0 , 44200.4, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 32045.4 ,0.0 , 46852.5, MOTION_WALK, fMoveSpeed,
		Enum.ENABLE_MAP_SYMBOL, false,
		Enum.POS_MOVE_NPC_EX, 31444.4 ,0.0 , 47927.7, MOTION_WALK, fMoveSpeed,
		Enum.POS_MOVE_NPC_EX, 31513.2 ,0.0 , 50782.8, MOTION_WALK, fMoveSpeed,,
		Enum.FADE_OUT_NPC, 
		Enum.WAIT_NPC, 300.0,
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

