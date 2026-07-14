//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*!@file
   @brief  Function Enum Const Utility【 Utility Nut 】
   
   (c) Copyright 2012 GUST, Inc...All rights reserved.
   
   @author Yuki-Kozai
   @date   2012/02/01 Yuki-Kozai・ver-1.00 Kick Off
*/ 
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏[ tab4 ]

// 定数定義クラス
class Val {
	// キャラクタの回転時間
	static CHARA_ROT_LIFE = 0.35;
	
	// 追尾再計算までの時間
	static CHARA_TRACKING_TIME = 0.1;
	
	// 基本となるモーションブレンドフレーム
	static MOTION_BLEND_FRAME = 0.2;
	
	// 基本となるモーションスピード
	static MOTION_SPEED = 1.0;
	
	// 基本となるフェードスピード
	static ALPHA_FADE_SPEED = 0.2;
};

// ENUM
class Enum {
	// 基本的な状態遷移値
	static STATE_SELECT  = 0;		// 基底状態
	static STATE_WAIT    = 1;		// 待機状態
	static STATE_WAITING = 2;		// 待機待ち
	static STATE_MOVE_IN = 3;		// 移動前
	static STATE_MOVE    = 4;		// 移動開始
	static STATE_MOVING  = 5;		// 移動待ち
	static STATE_MOVE_OUT= 6;		// 移動後
	static STATE_MOVE_END= 7;		// 移動終了
	
	// 汎用遷移
	static STATE_EX0	 = 100;
	static STATE_EX1	 = 101;
	static STATE_EX2	 = 102;
	static STATE_EX3	 = 103;
	static STATE_EX4	 = 104;
	static STATE_EX5	 = 105;
	static STATE_EX6	 = 106;
	static STATE_EX7	 = 107;
	static STATE_EX8	 = 108;
	static STATE_EX9	 = 109;
	static STATE_EX10	 = 110;
	static STATE_EX11	 = 111;
	static STATE_EX12	 = 112;
	static STATE_EX13	 = 113;
	static STATE_EX14	 = 114;
	static STATE_EX15	 = 115;
	static STATE_EX16	 = 116;
	static STATE_EX17	 = 117;
	static STATE_EX18	 = 118;
	static STATE_EX19	 = 119;
	static STATE_EX20	 = 120;
	static STATE_EX21	 = 121;
	static STATE_EX22	 = 122;
	static STATE_EX23	 = 123;
	static STATE_EX24	 = 124;
	
	static STATE_PATTERN0 = 1000;
	static STATE_PATTERN1 = 1001;
	static STATE_PATTERN2 = 1002;
	static STATE_PATTERN3 = 1003;
	
	// 別名で
	static STATE_START = 0;
	static STATE_END   = 1000;
	
	// NPC行動パターン
	static POS_MOVE_NPC = 0;
	static POS_SET_NPC  = 1;
	static WAIT_NPC     = 2;
	static FADE_OUT_NPC = 3;
	static FADE_IN_NPC  = 4;
	static ROT_MOVE_NPC = 5;
	static MOTION_NPC   = 6;
	static END_NPC      = 7;
	static LOOP_NPC      = 8;

	static POS_MOVE_NPC_EX = 9;
	static ENABLE_MAP_SYMBOL = 10;
	
	// 上記引数
	static PARAM_POS_MOVE_NPC = 4;
	static PARAM_POS_SET_NPC  = 4;
	static PARAM_WAIT_NPC     = 2;
	static PARAM_FADE_OUT_NPC = 1;
	static PARAM_FADE_IN_NPC  = 1;
	static PARAM_ROT_MOVE_NPC = 2;
	static PARAM_MOTION_NPC   = 6;
	static PARAM_END_NPC      = 1;
	static PARAM_POS_MOVE_NPC_EX = 6;
	static PARAM_ENABLE_MAP_SYMBOL = 2;
	
};

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief printfでの出力 最大引数7
   
   @param[in]      sString		文字列 const tchar*
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function printf(sString, ...)
{
	local i   = 0;
	local arg = ::array(7);
	while(i < 7) {
		if (i < vargc) {
			arg[i] = vargv[i];
		}
		++i;
	}
	print(format(sString, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6]));
	
	return;
}


function toPos( x,y,z )
{
	return SQ.getVector3( x, y, z);
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 到達位置までのY回転角を計算
   
   @param[in]      pcChara		判定するキャラクタ FMChara
   @param[in]	   vToPos		到達位置           Vector3
   @return         回転ベクトル Vector3
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function calcTargetRotY(pcChara, vToPos)
{
	// 現在位置を取得
	local vFromPos = pcChara.getPosition();
	
	// 現在の回転を取得
	local vFromRot = pcChara.getRotation();
	
	// 到達までの回転ベクトルを計算
	return SQ.getVector3(SQ.getXByVector3(vFromRot), SQ.getDirY(vFromPos, vToPos), SQ.getZByVector3(vFromRot))
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief 対象が自分のレンジに入っているかを判定して通知
   
   @param[in]      pcOwn		自分	   FMChara
   @param[in]	   pcTarget		対象キャラ FMChara
   @return         切り替わっていればtrue bool
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function isRangeInOut(pcOwn, pcTarget)
{
	local bIsRet      = false;
	local bIsNowRange = false;
	local bIsRange    = pcOwn.getIsRange();
	
	// 対象が自分のレンジに入っているかを判定
	if (pcOwn.isRangeIn(pcTarget.getPosition())) {
		bIsNowRange = true;
	}

	// レンジが切り替わる場合は変数を初期化
	if (pcOwn.getIsJudgeRange() && bIsNowRange != bIsRange) {
		// 切り替わったことを通知
		pcOwn.setIsRange(bIsNowRange);
		
		// タイマーをリセット
		pcOwn.setTimer(0.0);
		
		// 念のためリセット
		pcOwn.setIsJudgeRange(true);
		
		// 切り替わる
		bIsRet = true;
	}
	
	return bIsRet;
}

//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief NPC 移動思考
   
   @param[in]      pcOwn		自分	   FMChara
   @return         -
   @author         Yuki-Kozai
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function conditionSelector(pcOwn, as32Command)
{
	// 現在の参照インデクス
	local s32Index = pcOwn.getCustomParam();
	
	// インデクスを上げるかどうか
	local bIsIndexUp  = false;
	local s32IndexAdd = 0;
	
	switch(as32Command[s32Index]) {
		case Enum.POS_MOVE_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// 移動の発行
						local vToPos = SQ.getVector3(as32Command[s32Index+1], as32Command[s32Index+2], as32Command[s32Index+3]);
						pcOwn.movePosition(vToPos, pcOwn.getMoveSpeed());
						
						// 回転の発行
						local vToRot = ::calcTargetRotY(pcOwn, vToPos);
						pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
						
						// モーションの発行
						pcOwn.setMotionTag(MOTION_WALK, 1, Val.MOTION_BLEND_FRAME, 1.4, true, false);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						if (!pcOwn.isMovePosition()) {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_POS_MOVE_NPC;
						}
					break;
					default:
					break;
				}
			}
		break;

		case Enum.POS_MOVE_NPC_EX:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// 移動の発行
						local vToPos = SQ.getVector3(as32Command[s32Index+1], as32Command[s32Index+2], as32Command[s32Index+3]);
						pcOwn.movePosition(vToPos, as32Command[s32Index+5]);
						
						// 回転の発行
						local vToRot = ::calcTargetRotY(pcOwn, vToPos);
						pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
						
						// モーションの発行
						pcOwn.setMotionTag(as32Command[s32Index+4], 1, Val.MOTION_BLEND_FRAME, 1.0, true, false);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						if (!pcOwn.isMovePosition()) {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_POS_MOVE_NPC_EX;
						}
					break;
					default:
					break;
				}
				
			}
		break;
		
		
		case Enum.POS_SET_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// 移動の発行
						local vToPos = SQ.getVector3(as32Command[s32Index+1], as32Command[s32Index+2], as32Command[s32Index+3]);
						pcOwn.setPosition(vToPos, pcOwn.getMoveSpeed());
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						bIsIndexUp = true;
						s32IndexAdd = Enum.PARAM_POS_SET_NPC;
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.WAIT_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						local f32WaitTime = as32Command[s32Index+1];
						
						// 待機時間設定
						pcOwn.setTimer(f32WaitTime);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						if (pcOwn.getTimer() <= 0.0) {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_WAIT_NPC;
						}
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.FADE_OUT_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// アルファフェードイン
						pcOwn.setAlpha(0.0, Val.ALPHA_FADE_SPEED, CURVE_LINEAR);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						if (!pcOwn.isAlphaCurve()) {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_FADE_OUT_NPC;
						}
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.FADE_IN_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// アルファフェードアウト
						pcOwn.setAlpha(1.0, Val.ALPHA_FADE_SPEED, CURVE_LINEAR);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						if (!pcOwn.isAlphaCurve()) {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_FADE_IN_NPC;
						}
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.ROT_MOVE_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// 回転の発行
						local vToRot = as32Command[s32Index+1];
						pcOwn.moveRotationY(vToRot, Val.CHARA_ROT_LIFE);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						if (!pcOwn.isMoveRotation()) {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_ROT_MOVE_NPC;
						}
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.MOTION_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						local s32MotionTag    = as32Command[s32Index+1];
						local s32MotionDiv    = as32Command[s32Index+2];
						local f32MotionSpeed  = as32Command[s32Index+3];
						local bMotionLoop     = as32Command[s32Index+4];
						
						// モーションの発行
						pcOwn.setMotionTag(s32MotionTag, s32MotionDiv, Val.MOTION_BLEND_FRAME, f32MotionSpeed, bMotionLoop, false);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
					{
						local bMotionEnd  = as32Command[s32Index+5];
						
						if (bMotionEnd) {
							if (pcOwn.isEndMotin()) {
								bIsIndexUp = true;
								s32IndexAdd = Enum.PARAM_MOTION_NPC;
							}
						}
						else {
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_MOTION_NPC;
						}
					}
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.END_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						bIsIndexUp = false;
						s32IndexAdd = 0;
					break;
					default:
					break;
				}
			}
		break;

	case Enum.LOOP_NPC:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						bIsIndexUp = true;
						s32IndexAdd = -s32Index;
					break;
					default:
					break;
				}
			}
		break;
		
		case Enum.ENABLE_MAP_SYMBOL:
			{
				switch(pcOwn.getState()) {
					case Enum.STATE_START:
					{
						// マップシンボルの表示切替
						pcOwn.enableMapSymbol(as32Command[s32Index+1]);
						
						// 遷移
						pcOwn.setState(Enum.STATE_END);
					}
					break;
					case Enum.STATE_END:
						{
							bIsIndexUp = true;
							s32IndexAdd = Enum.PARAM_ENABLE_MAP_SYMBOL;
						}
					break;
					default:
					break;
				}
				
			}
		break;
				
		default:
		break;
	}
	
	if (bIsIndexUp) {
		s32Index += s32IndexAdd;
		if (s32Index >= as32Command.len()) {
			s32Index = 0;
		}
		pcOwn.setCustomParam(s32Index);
		pcOwn.setState(Enum.STATE_START);
		
		//::printf("len %d\n", as32Command.len());
		//::printf("Index %d\n", s32Index);
	}
	
	return;
}

/*******************************************************************************
	Schedule Move Class
	
*******************************************************************************/
class ScheduleMove
{
	dataList = []; // pos, speed, motion 
	dataIdx = 0; // dataListのidx
	pcOwn = null;

	constructor( own, dataArray )
	{
		pcOwn = own;
		dataList = [ {pos=::toPos(0,-9999,0),motion=MOTION_WALK, speed=1000} ];
		dataList.extend( dataArray );
	}

	function update()
	{
		dataIdx = pcOwn.getCustomParam();
		local pos = pcOwn.getPosition();
		local setNext = false;

		if( dataIdx < 0 )
		{
			dataIdx = searchMostNearIdx( pos );
			setNext = true;
		}
		else if( dataIdx == 0 )
		{
			// 初期化されてないなら、1へ。
			dataIdx = 1;
			setNext = true;
		}
		else
		{
			// ちょっと余裕を持たせるが、指定座標付近に来たら、次の座標をセットする。
			local localSq = lengthSq( pos, dataList[dataIdx].pos );
			if( localSq < 5 * 5 || !pcOwn.isMovePosition() )
			{
				setNext = true;
				++dataIdx;
				// 最後まで行ったら最初に戻る。
				if( dataIdx >= dataList.len() )
				{
					dataIdx = 1;
				}
			}
			
		}

		if( setNext )
		{
			pcOwn.movePosition( dataList[dataIdx].pos,  dataList[dataIdx].speed );
			
			// 回転の発行
			local vToRot = ::calcTargetRotY(pcOwn, dataList[dataIdx].pos );
			pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);
			
			// モーションの発行
			pcOwn.setMotionTag( dataList[dataIdx].motion, 1, Val.MOTION_BLEND_FRAME, 1.4, true, false);

			pcOwn.setCustomParam( dataIdx );
		}
	}
	
	
	
	// ルートは不要だろう…
	function lengthSq( a, b )
	{
		local x = ( a.getX() - b.getX() ) * 0.01;
		local y = ( a.getY() - b.getY() ) * 0.01;
		local z = ( a.getZ() - b.getZ() ) * 0.01;
		return x*x + y*y + z*z;
	}

	// 最も近いposListのIdxを返却する 
	function searchMostNearIdx( pos )
	{
		local posSize = dataList.len();
		local nearLen = -1;
		local nearIdx = -1;
		for(local i=0; i<posSize; ++i )
		{
			local tmpLen = lengthSq( pos, dataList[i].pos );
			if( nearIdx < 0 || nearLen > tmpLen )
			{
				nearIdx = i;
				nearLen = tmpLen;
			}
		}
		
		return nearIdx;
	}

};

