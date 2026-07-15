//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 杖振り 弱 
   
   @param		   s32PlayerTag プレイヤータグ
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function wandAttack(s32PlayerTag)
{
	local temp = [ 
	ECT_CHARA_SE_NON_STREAM_PLAY, s32PlayerTag, SE_BELL01, 0, 43, 6400, 800, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 0, 0, 
	ECT_CHARA_MOTION_SET_SPEED, s32PlayerTag, 200, 
	ECT_CHARA_MOTION_WAIT, s32PlayerTag, 
	ECT_CHARA_SE_NON_STREAM_PLAY, s32PlayerTag, SE_WAND01, 0, 100, 6400, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 5, 0, EFF_TYPE_GEOMETRY, 241, 0,60,0, 0,0,0, 8000,8000,8000, 255,159,59, 0, -1, 0, 0, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 1, 0, 
	ECT_CHARA_MOTION_SET_SPEED, s32PlayerTag, 110, 
	ECT_CHARA_TIME_WAIT, s32PlayerTag, 7, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 0, 0, EFF_TYPE_GEOMETRY, 280, -15,115,0, 27000,-17000,-1000, 10500,10500,10500, 255,145,235, 0, -1, 0, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 1, 0, EFF_TYPE_GEOMETRY, 692, -15,140,-80, 0,0,17000, 8000,8000,8000, 255,145,235, 0, -1, 100, 150, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 2, 0, EFF_TYPE_GEOMETRY, 692, -10,135,-100, 0,0,17000, 7500,7500,7500, 255,145,101, 0, -1, 100, 150, 
	ECT_CHARA_MOTION_WAIT, s32PlayerTag, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 0, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 5, 
	ECT_CHARA_TIME_WAIT, s32PlayerTag, 5, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 1, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 2, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 2, 0, 
	ECT_CHARA_MOTION_WAIT, s32PlayerTag, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 3, 0, 
	ECT_END, 
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroFast("wandAttack");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 杖振り 強
   
   @param		   s32PlayerTag プレイヤータグ
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function wandAttackForce(s32PlayerTag)
{
	local temp = [
	ECT_CHARA_SE_NON_STREAM_PLAY, s32PlayerTag, SE_BELL01, 0, 49, 6400, -617, 
	ECT_CHARA_SE_NON_STREAM_PLAY, s32PlayerTag, SE_AURA03, 0, 30, 6400, 2000, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 0, 0, 
	ECT_CHARA_OFFSET_ROT_MOVE_WITHOUT_SORTROT, s32PlayerTag, 0, -360, 0, 20, CURVE_LINEAR, 
	ECT_CHARA_MOTION_SET_SPEED, s32PlayerTag, 200, 
	ECT_CHARA_MOTION_WAIT, s32PlayerTag, 
	ECT_CHARA_SE_NON_STREAM_PLAY, s32PlayerTag, SE_WAND01, 0, 100, 6400, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 5, 0, EFF_TYPE_GEOMETRY, 241, 0,110,0, 0,0,0, 6500,6500,6500, 170,197,250, 0, -1, 0, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 6, 0, EFF_TYPE_GEOMETRY, 221, 0,80,0, 0,0,0, 7500,7500,7500, 255,150,250, 0, -1, 0, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 7, 0, EFF_TYPE_GEOMETRY, 241, 0,110,0, 0,0,0, 5000,5000,5000, 253,197,92, 0, -1, 0, 0, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 1, 0, 
	ECT_CHARA_MOTION_SET_SPEED, s32PlayerTag, 123, 
	ECT_CHARA_TIME_WAIT, s32PlayerTag, 7, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 3, 0, EFF_TYPE_GEOMETRY, 692, -10,135,-100, 0,0,17000, 8000,8000,8000, 255,145,101, 0, -1, 100, 150, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 2, 0, EFF_TYPE_GEOMETRY, 76, 0,115,0, -500,6000,16500, 12000,1000,12000, 174,85,135, 0, -1, 0, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 0, 0, EFF_TYPE_GEOMETRY, 280, 0,120,0, 27000,-17000,-1000, 13000,13000,13000, 255,115,65, 0, -1, 0, 0, 
	ECT_CHARA_NODEEFF_ADD, s32PlayerTag, 1, 0, EFF_TYPE_GEOMETRY, 26, 0,120,20, 27000,-17000,-1000, 7500,7500,7500, 255,180,94, 0, -1, 0, 0, 
	ECT_CHARA_MOTION_WAIT, s32PlayerTag, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 0, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 1, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 3, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 5, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 6, 
	ECT_CHARA_NODEEFF_STOP, s32PlayerTag, 7, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 2, 0, 
	ECT_CHARA_TIME_WAIT, s32PlayerTag, 10, 
	ECT_CHARA_NODEEFF_KILL, s32PlayerTag, 2, 
	ECT_CHARA_MOTION_WAIT, s32PlayerTag, 
	ECT_CHARA_MOTION_SET, s32PlayerTag, MOTION_KNOCK, 3, 0, 
	ECT_END,
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroFast("wandAttackForce");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 杖振り ヒットエフェクト
   
   @param		   s32EnemyTag		発生させる敵キャラタグ
   @param		   s32IsDeathAttack 即死攻撃かどうか
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function wandHitEffect(s32EnemyTag, s32IsDeathAttack)
{
	// 即死がどうかによってSEを変化させる
	local s32AttackNormalSeTag = SE_FIELDHIT01;
	if (s32IsDeathAttack) {
		s32AttackNormalSeTag = SE_DEAD01;
	}
	
	local temp = [ 
		ECT_CHARA_EFF_ADD, s32EnemyTag, 7, EFF_TYPE_GEOMETRY, 27, OBJ_TYPE_FIELDMAP_CHARA, s32EnemyTag, MODEL_OFFSET_BODY, 0,0,0, 20, 0, 0,0,0, 100,100,100, 255,180,64, -1, 0, -1, -1,
		ECT_CHARA_EFF_ADD, s32EnemyTag, 7, EFF_TYPE_GEOMETRY, 30, OBJ_TYPE_FIELDMAP_CHARA, s32EnemyTag, MODEL_OFFSET_BODY, 0,0,0, 20, 0, 0,0,0, 150,150,150, 255,52,160, -1, 0, -1, -1,
		ECT_CHARA_EFF_ADD, s32EnemyTag, 7, EFF_TYPE_GEOMETRY, 130, OBJ_TYPE_FIELDMAP_CHARA, s32EnemyTag, MODEL_OFFSET_BODY, 0,0,0, 20, 0, 0,0,0, 70,70,70, 255,32,128, -1, 0, -1, -1,
		ECT_CHARA_SE_PLAY, s32EnemyTag, s32AttackNormalSeTag, 0, 100, 6400, 0,
		
		ECT_END,
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroFast("wandHitEffect");
	
	return;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 杖振り 無効エフェクト
   
   @param		   s32EnemyTag		発生させる敵キャラタグ
   @return         -
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function deviateEffect(s32EnemyTag)
{
	local temp = [ 
		ECT_CHARA_EFF_ADD, s32EnemyTag, 7, EFF_TYPE_GEOMETRY, 34, OBJ_TYPE_FIELDMAP_CHARA, s32EnemyTag, MODEL_OFFSET_BODY, 0,0,0, 20, 0, 0,0,0, 70,70,70, 0,0,0, -1, 0, -1, -1,
		ECT_CHARA_EFF_ADD, s32EnemyTag, 7, EFF_TYPE_GEOMETRY, 485, OBJ_TYPE_FIELDMAP_CHARA, s32EnemyTag, MODEL_OFFSET_BODY, 0,0,0, 20, 0, 0,0,0, 150,150,150, 0,0,0, -1, 0, -1, -1,
		//ECT_CHARA_EFF_ADD, s32EnemyTag, 7, EFF_TYPE_GEOMETRY, 130, OBJ_TYPE_FIELDMAP_CHARA, s32EnemyTag, MODEL_OFFSET_BODY, 0,0,0, 20, 0, 0,0,0, 70,70,70, 255,32,128, -1, 0, -1, -1,
		ECT_CHARA_SE_PLAY, s32EnemyTag, SE_FIELDHIT01, 0, 100, 6400, 0,
		
		ECT_END,
	];
	
	// マクロ転送
	foreach (idx, val in temp) {
		SQ.copyProgramMacro(val, idx);
	}
	
	// マクロ実行
	SQ.execProgramMacroFast("deviateEffect");
	
	return;
}