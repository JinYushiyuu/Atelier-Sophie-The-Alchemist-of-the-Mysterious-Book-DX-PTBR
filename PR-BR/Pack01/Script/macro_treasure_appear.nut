//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
@brief 宝箱(通常)出現
   
   @param       s32PlayerCharaTag		プレイヤータグ
   @param       s32TreasureCharaTag		ターゲット
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function appearNormalTreasure( s32PlayerTag, s32TreasureCharaTag )
{
	local temp = [ 
		ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_F_WAIT, 0, 0, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 128,128,128, 0, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 128,128,128, 128, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 255,255,255, 128, 
		ECT_CHARA_COLOR_MOVE_SET, s32TreasureCharaTag, 128,128,128, 128, 50, CURVE_SPEED_DOWN, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 49, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,2,0, 100, 150, 0,0,0, 200,200,200, 30,30,40, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 240, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,25,0, 80, 0, 0,0,0, 100,100,100, 0,0,128, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 130, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,50,0, 100, 0, 0,0,0, 60,60,60, 0,187,251, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 423, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,0,0, 100, 150, 0,0,0, 60,60,60, 128,128,80, 0, -1, -1, -1, 
		ECT_CHARA_TIME_WAIT, s32TreasureCharaTag, 25, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 459, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,0,0, 50, 50, 0,0,0, 50,50,50, 156,210,155, 0, -1, -1, -1, 
		ECT_END, 
	];
	
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	SQ.execProgramMacro("appearNormalTreasure");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
@brief 宝箱(レア)出現
   
   @param       s32PlayerCharaTag		プレイヤータグ
   @param       s32TreasureCharaTag		ターゲット
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function appearRareTreasure( s32PlayerTag, s32TreasureCharaTag )
{
	local temp = [ 
		ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_F_WAIT, 0, 0, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 128,128,128, 0, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 128,128,128, 128, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 255,255,255, 128, 
		ECT_CHARA_COLOR_MOVE_SET, s32TreasureCharaTag, 128,128,128, 128, 50, CURVE_SPEED_DOWN, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 49, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,2,0, 100, 150, 0,0,0, 250,250,250, 45,35,25, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 240, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,25,0, 80, 0, 0,0,0, 100,100,100, 0,0,128, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 130, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,50,0, 100, 0, 0,0,0, 60,60,60, 253,187,64, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 423, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,0,0, 100, 150, 0,0,0, 60,60,60, 73,93,66, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 128, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,2,0, 100, 150, 0,0,0, 40,40,40, 100,100,100, 0, -1, -1, -1, 
		ECT_CHARA_TIME_WAIT, s32TreasureCharaTag, 25, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 459, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,0,0, 50, 50, 0,0,0, 50,50,50, 156,210,155, 0, -1, -1, -1, 
		ECT_END,  
	];
	
	foreach ( idx, val in temp ) {
		SQ.copyProgramMacro( val, idx );
	}
	
	SQ.execProgramMacro("appearRareTreasure");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
@brief 宝箱(超レア)出現
   
   @param       s32PlayerCharaTag		プレイヤータグ
   @param       s32TreasureCharaTag		ターゲット
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function appearNobleTreasure( s32PlayerTag, s32TreasureCharaTag )
{
	local temp = [ 
		ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_F_WAIT, 0, 0,
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 128,128,128, 0, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 128,128,128, 128, 
		ECT_CHARA_COLOR_SET, s32TreasureCharaTag, 255,255,255, 128, 
		ECT_CHARA_COLOR_MOVE_SET, s32TreasureCharaTag, 128,128,128, 128, 50, CURVE_SPEED_DOWN, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 49, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,2,0, 100, 150, 0,0,0, 250,250,250, 45,35,25, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 240, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,25,0, 80, 0, 0,0,0, 100,100,100, 0,0,128, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 478, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,40,0, 95, 0, 0,0,0, 125,125,125, 128,128,128, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 479, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,40,0, 50, 70, 0,0,0, 80,80,80, 128,128,128, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 245, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,40,0, 100, 0, 0,0,0, 100,100,100, 0,0,0, 128, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 130, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,50,0, 100, 0, 0,0,0, 60,60,60, 253,187,64, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 423, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,0,0, 100, 150, 0,0,0, 60,60,60, 83,60,114, 0, -1, -1, -1, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 291, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,2,0, 100, 150, 0,0,0, 45,45,45, 100,100,100, 0, -1, -1, -1, 
		ECT_CHARA_TIME_WAIT, s32TreasureCharaTag, 25, 
		ECT_CHARA_EFF_ADD, s32TreasureCharaTag, 0, EFF_TYPE_GEOMETRY, 459, OBJ_TYPE_CHARA_SELF, s32TreasureCharaTag, MODEL_OFFSET_FOOT, 0,0,0, 50, 50, 0,0,0, 50,50,50, 156,210,155, 0, -1, -1, -1, 
		ECT_END,  
	];
	
	foreach ( idx, val in temp ) {
		SQ.copyProgramMacro( val, idx );
	}
	
	SQ.execProgramMacro("appearNobleTreasure");
	
	return;
}
