//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 移動先決定時のカメラ
// selectMoveCamera, s32IsFirst
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function selectMoveCamera(s32IsFirst)
{
	if( s32IsFirst ){
		local temp = [ 
			ECT_EVENT_SET_POST_EFFECT, -1, 0, 25, POST_EFFECT_CROSS_FADE, 
			ECT_CHARA_ROT_SET_TARGET, CHARA_EX_CUR, OBJ_TYPE_WORLD, 0, 0, 0,0,0, 
			ECT_CAMERA_C_TYPE_SET, CAMERA_C_MANUAL, 
			ECT_CAMERA_EYE_POS_SET, OBJ_TYPE_CHARA_SELF, CHARA_EX_CUR, MODEL_OFFSET_BODY, 0, 150, -500, 
			ECT_CAMERA_AT_POS_SET, OBJ_TYPE_WORLD, 0, 0, 0,0,0,
			ECT_END,
		];
		
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		
		// マクロ実行
		SQ.execProgramMacroFast("selectMoveCamera");
	}else{
		local temp = [ 
//			ECT_EVENT_SET_POST_EFFECT, -1, 0, 25, POST_EFFECT_CROSS_FADE, 
			ECT_CHARA_ROT_SET_TARGET, CHARA_EX_CUR, OBJ_TYPE_WORLD, 0, 0, 0,0,0, 
			ECT_CAMERA_C_TYPE_SET, CAMERA_C_MANUAL, 
			ECT_CAMERA_EYE_POS_SET, OBJ_TYPE_CHARA_SELF, CHARA_EX_CUR, MODEL_OFFSET_BODY, 0, 150, -500, 
			ECT_CAMERA_AT_POS_SET, OBJ_TYPE_WORLD, 0, 0, 0,0,0,
			ECT_END,
		];
		
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		
		// マクロ実行
		SQ.execProgramMacroFast("selectMoveCamera");
	}
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 移動コマンド
// setCommandMove, toX, toY, toZ, dirY, isLeftMove, isCenter
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setCommandMove(s32ToX, s32ToY, s32ToZ, s32DirY, s32IsLeftMove, s32IsCenter, d6, d7)
{
	local s32XAccel = s32IsCenter?1100:400;
	if( !s32IsLeftMove ){
		s32XAccel *= -1;
	}
	local temp = [ 
		ECT_EVENT_SET_POST_EFFECT, -1, 0, 25, POST_EFFECT_CROSS_FADE, 
		ECT_BATTLE_ADD_EFFECT_ID, 0, CHARA_E3D_COMMON_ITEM_DUMMY_01, 
		ECT_CHARA_POS_SET, CHARA_EX_ID0, OBJ_TYPE_WORLD, 0, 0, s32ToX, s32ToY, s32ToZ, 
		ECT_CHARA_ROT_SET, CHARA_EX_ID0, 0, s32DirY, 0,
//		ECT_CHARA_SE_NON_STREAM_PLAY, CHARA_EX_CUR, SE_FURU01, 0, 100, 6400, 3703, 
//		ECT_CHARA_SE_NON_STREAM_PLAY, CHARA_EX_CUR, SE_JUMP01, 0, 100, 6400, -822, 
		ECT_CHARA_MOTION_SET, CHARA_EX_CUR, MOTION_B_RUN, 1, 10, 
		ECT_CHARA_MOTION_SET_SPEED, CHARA_EX_CUR, 110, 
		ECT_CHARA_MOVE_SET, CHARA_EX_CUR, OBJ_TYPE_CHARA_SELF, CHARA_EX_ID0, MODEL_OFFSET_FOOT, 0,0,0, MOVE_LOOK_Y, MOVE_NORMAL, 1000, s32XAccel,0,0, 
//		ECT_CHARA_SE_NON_STREAM_PLAY, CHARA_EX_CUR, SE_LAND01, 0, 33, 6400, 1851, 
		ECT_CHARA_MOVE_PRE_WAIT, CHARA_EX_CUR, 10, 
		ECT_CHARA_MOTION_SET, CHARA_EX_CUR, MOTION_B_RUN, 2, 10, 
		ECT_CHARA_MOVE_WAIT, CHARA_EX_CUR, 
		ECT_CHARA_ROT_MOVE_SET, CHARA_EX_CUR, 0, s32DirY, 0, 30, CURVE_LINEAR, 
		ECT_CHARA_MOTION_WAIT, CHARA_EX_CUR, 
		ECT_CHARA_SET_MARKER, CHARA_EX_CUR, BTL_MARKER_WAIT, 0, -1, 100, 
//		ECT_CHARA_ROT_SET_TARGET, CHARA_EX_CUR, OBJ_TYPE_WORLD, CHARA_EX_CUR, MODEL_OFFSET_HOME, 0,0,0, 
//		ECT_CHARA_ROT_SET, CHARA_EX_CUR, 0, s32DirY, 0,
//		ECT_CHARA_ROT_MOVE_SET, CHARA_EX_CUR, 0, (int)toDegree(rot[1]), 0, 40, CURVE_LINEAR, 
		ECT_CAMERA_C_TYPE_SET, CAMERA_C_MANUAL, 
//		ECT_CAMERA_EYEAT_POS_SET, OBJ_TYPE_CHARA_SELF, CHARA_EX_TGT, MODEL_OFFSET_BOTTOM, 0,0,0, OBJ_TYPE_CHARA_SELF, CHARA_EX_CUR, MODEL_OFFSET_BODY, 0,50,-200, 
		ECT_CAMERA_EYEAT_POS_SET, OBJ_TYPE_CHARA_SELF, CHARA_EX_CUR, MODEL_OFFSET_BODY, 0,0,0, OBJ_TYPE_CHARA_SELF, CHARA_EX_CUR, MODEL_OFFSET_BODY, 0,50,-200, 
		ECT_CAMERA_AT_MOVE_SET, OBJ_TYPE_CHARA_SELF, CHARA_EX_ID0, MODEL_OFFSET_FOOT, s32IsLeftMove?150:-150, 70, 0, MOVE_FIX_ACCEL, 100, 15, 
//		ECT_CHARA_TIME_WAIT, CHARA_EX_CUR, 10, 
		ECT_MACRO_CHARA_MARKER_WAIT, CHARA_EX_CUR, 
		ECT_END,
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacro("setCommandMove");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// ターゲット選択時の俯瞰カメラ
// setTargetCameraCraneShot, s32IsFirst, s32IsUp
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setTargetCameraCraneShot(s32IsFirst, s32IsUp)
{
	local s32X = s32IsUp?0:-100;
	local s32Y = s32IsUp?800:250;
	local s32Z = s32IsUp?1100:900;

	if( s32IsFirst ){
		local temp = [ 
			ECT_EVENT_SET_POST_EFFECT, -1, 0, 25, POST_EFFECT_CROSS_FADE, 
			ECT_CAMERA_C_TYPE_SET, CAMERA_C_MANUAL, 
			ECT_CAMERA_EYE_POS_SET, OBJ_TYPE_WORLD, 0, 0, s32X, s32Y, s32Z, 
			ECT_CAMERA_AT_POS_SET, OBJ_TYPE_WORLD, 0, 0, s32IsUp?0:0, 0, 0, 
			ECT_END,
		];
		
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		
		// マクロ実行
		SQ.execProgramMacroFast("setTargetCameraCraneShot");
	}else{
		local temp = [ 
	//		ECT_EVENT_SET_POST_EFFECT, -1, 0, 25, POST_EFFECT_CROSS_FADE, 
	//		ECT_CHARA_ROT_SET_TARGET, CHARA_EX_CUR, OBJ_TYPE_WORLD, 0, 0, 0,0,0, 
	//		ECT_CAMERA_C_TYPE_SET, CAMERA_C_MANUAL, 
			ECT_CAMERA_EYE_MOVE_SET, OBJ_TYPE_WORLD, 0, 0, s32X, s32Y, s32Z, MOVE_FIX_ACCEL, 100, 100, 
			ECT_CAMERA_AT_MOVE_SET, OBJ_TYPE_WORLD, 0, 0, s32IsUp?0:0, 0, 0, MOVE_FIX_ACCEL, 100, 100, 
			ECT_END,
		];
		
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		
		// マクロ実行
		SQ.execProgramMacroFast("setTargetCameraCraneShot");
	}
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 散開位置
// setProgramPosACEvade, s32Ranks
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setProgramPosACEvade(s32Ranks)
{
	// 隊列にあった退出位置を設定
	switch( s32Ranks ){
	case 0:	SQ.setProgramPosXYZ(0,  2.0, 0.0, -2.0);	break;
	case 1:	SQ.setProgramPosXYZ(0,  0.0, 0.0, -4.0);	break;
	case 2:	SQ.setProgramPosXYZ(0, -2.0, 0.0, -2.0);	break;
	}
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 散開キャラ部分
// setEvadeChara, s32BcID, toX, toY, toZ, d4, d5, d6, d7
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setEvadeChara(s32BcID, s32ToX, s32ToY, s32ToZ, d4, d5, d6, d7)
{
	local temp = [ 
		ECT_SET_DEFCHARA_BCID, s32BcID,
		ECT_CHARA_MOTION_SET, CHARA_EX_DEF, MOTION_B_BACK, 0, 10, 
		ECT_CHARA_MOTION_WAIT, CHARA_EX_DEF, 
		ECT_CHARA_MOTION_SET, CHARA_EX_DEF, MOTION_B_BACK, 1, 5, 
		ECT_CHARA_MOVE_SET, CHARA_EX_DEF, OBJ_TYPE_WORLD, 0, 0, s32ToX, s32ToY, s32ToZ, MOVE_LOOK_NONE, MOVE_ABSH, 1000, 40, 
		ECT_CHARA_SE_NON_STREAM_PLAY, CHARA_EX_DEF, SE_JUMP01, 0, 100, 6400, 0, 
		ECT_CHARA_MOVE_PRE_WAIT, CHARA_EX_DEF, 30, 
		ECT_CHARA_COLOR_MOVE_SET, CHARA_EX_DEF, 128,128,128, 0, 30, CURVE_SPEED_DOWN, 
		ECT_CHARA_MOVE_PRE_WAIT, CHARA_EX_DEF, 10, 
		ECT_CHARA_MOTION_SET, CHARA_EX_DEF, MOTION_B_BACK, 3, 5, 
		ECT_CHARA_MOVE_WAIT, CHARA_EX_DEF, 
		ECT_CHARA_POS_SET, CHARA_EX_DEF, OBJ_TYPE_CHARA, CHARA_EX_DEF, MODEL_OFFSET_HOME, 0,0,0, 
//		ECT_CHARA_SE_NON_STREAM_PLAY, CHARA_EX_DEF, SE_LAND01, 0, 100, 6400, 0, 
		ECT_CHARA_MOTION_WAIT, CHARA_EX_DEF, 
		ECT_CHARA_MOTION_SET_LOOP, CHARA_EX_DEF, MOTION_WAIT, 10, 1, 
		ECT_END, 
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroFast("setEvadeChara");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 散開カメラ部分
// setEvadeCamera
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setEvadeCamera()
{
	local temp = [ 
		ECT_CAMERA_C_TYPE_SET, CAMERA_C_MANUAL, 
//		ECT_CAMERA_AT_MOVE_SET, OBJ_TYPE_CHARA, CHARA_EX_TGT, MODEL_OFFSET_ATTACK, 0, 100, -150, MOVE_FIX_ACCEL, 100, 100,
//		ECT_CAMERA_EYE_MOVE_SET, OBJ_TYPE_CHARA, CHARA_EX_TGT, MODEL_OFFSET_ND_ATTACK, (int)(dir0[0]*eyeLen), (int)(dir0[1]*eyeLen), (int)(dir0[2]*eyeLen), MOVE_FIX_ACCEL, 100, 100, 
		ECT_CAMERA_EYE_MOVE_SET, OBJ_TYPE_CHARA_SELF, CHARA_EX_CUR, MODEL_OFFSET_DEFENCE, 0, 300, -600, MOVE_FIX_ACCEL, 40, 100, 
		ECT_CAMERA_EYE_MOVE_WAIT,
		ECT_MACRO_CAMERA_WAIT, 
		ECT_MACRO_TIME_WAIT, 50, // キャラの移動を正しく待たないとダメージを受けてしまうので注意
		ECT_END,
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacro("setEvadeCamera");
	
	return;
}



//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 竜巻巻上げ
// setTornadoRolling, s32ID, s32Index, s32AddMode, d3, d4, d5, d6, d7
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setTornadoRolling(s32ID, s32Index, s32AddMode, d3, d4, d5, d6, d7)
{
	local rotAdd = [0, 120, 240];

	local temp = [ 
		ECT_SET_DEFCHARA_BCID, s32ID,
		ECT_CHARA_TIME_WAIT, CHARA_EX_DEF, 500, 
//		ECT_CHARA_MOTION_SET, CHARA_EX_DEF, MOTION_GUARD, 3, 0, 
//		ECT_CHARA_MOVE_SET, CHARA_EX_DEF, OBJ_TYPE_WORLD, CHARA_EX_CUR, MODEL_OFFSET_HOME, 0,0,0, MOVE_LOOK_ALL, MOVE_CIRCLE, 0,0,0, 400, 700, 2000, 0+rotAdd[s32Index], 1440+rotAdd[s32Index], 40000, 180000, 
//		ECT_CHARA_MOVE_WAIT, CHARA_EX_DEF,
		ECT_END,
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroAddMode("setTornadoRolling", s32AddMode);

	return;
}
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
// 竜巻落とし
// setTornadoFalling, s32ID, s32AddMode
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function setTornadoFalling(s32ID, s32AddMode)
{
	local temp = [ 
		ECT_SET_DEFCHARA_BCID, s32ID,
		ECT_CHARA_SET_PROGRAM_ROT, CHARA_EX_DEF,
//		ECT_CHARA_POS_SET, CHARA_EX_DEF, OBJ_TYPE_CHARA, CHARA_EX_DEF, MODEL_OFFSET_HOME, 0,700,0, 
		ECT_CHARA_MOTION_SET, CHARA_EX_DEF, MOTION_GUARD, 3, 0, 
		ECT_CHARA_MOVE_SET, CHARA_EX_DEF, OBJ_TYPE_CHARA, CHARA_EX_DEF, MODEL_OFFSET_HOME, 0,0,0, MOVE_LOOK_NONE, MOVE_FIX_ACCEL, 70, -100, 
		ECT_CHARA_TIME_WAIT, CHARA_EX_DEF, 70, 
		ECT_CHARA_MOTION_SET, CHARA_EX_DEF, MOTION_DAMAGE, 0, 0, 
		ECT_CHARA_EFF_ADD, CHARA_EX_DEF, 0, EFF_TYPE_GEOMETRY, 38, OBJ_TYPE_CHARA, CHARA_EX_DEF, MODEL_OFFSET_HOME, 0,0,0, 0, 0, 0,0,0, 100,100,100, 0,0,0, -1, -1, -1, -1, 
		ECT_END, 
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroAddMode("setTornadoFalling", s32AddMode);
	
	return;
}

