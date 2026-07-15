//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*!@file
   @brief  NPC move Squirrel Script【 AI NPC Nut 】
   
   (c) Copyright 2012 GUST, Inc...All rights reserved.
   
   @author Yuki-Kozai
   @date   2012/04/24 Yuki-Kozai・ver-1.00 Kick Off
   		   2015/09/18 Takaaki-Ohta・ver-1.10 Recreate
*/ 
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏[ tab4 ]


//------- Import

//------- Global Variable
local pcOwn = SQ.getActiveChara();
local fMoveSpeed = pcOwn.getMoveSpeed() + 0.2;
// ScheduleMovingで使用するパスデータ 



class VData
{
	// トラッキングタイマー 
	static TRACKING_TIMER = 5.0;
	// トラッキング速度 
	static fTrackingSpeed = pcOwn.getMoveSpeed() + 1.7;

	// トラッキングしないタイマー 
	static NONTRACKING_TIMER = 2.0;
	// スケジュール移動時速度
	static fMoveSpeed = pcOwn.getMoveSpeed() - 0.5;

	// トラッキングする距離 
	static AREA_SIZE = 10.0; // メートル 
	// トラッキングする距離 
	static TRACKING_ROT = 45;

	static dataList =
	[
		{ pos=::toPos(15038.4 ,170.1 , 27218.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(15276.5 ,170.1 , 26820.3), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16165.4 ,170.1 , 26805.0), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16581.4 ,170.0 , 26405.6), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16601.5 ,170.0 , 25466.7), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16601.5 ,180.1 , 24845.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16224.5 ,180.1 , 24417.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(15841.7 ,180.1 , 24621.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(15412.7 ,180.1 , 25144.3), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(14411.4 ,180.1 , 25628.8), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(13647.7 ,180.1 , 25059.8), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(13647.7 ,200.1 , 24143.4), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(13647.7 ,200.1 , 23550.8), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(13647.7 ,200.1 , 24143.4), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(13647.7 ,180.1 , 25059.8), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(14411.4 ,180.1 , 25628.8), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(15412.7 ,180.1 , 25144.3), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(15841.7 ,180.1 , 24621.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16224.5 ,180.1 , 24417.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16601.5 ,180.1 , 24845.5), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16601.5 ,170.0 , 25466.7), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(16581.4 ,170.0 , 26461.0), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(14768.8 ,170.0 , 27207.6), motion=MOTION_WALK, speed=fMoveSpeed },
		{ pos=::toPos(13767.0 ,170.0 , 27214.0), motion=MOTION_WALK, speed=fMoveSpeed }
	];

	static STATE_SCHEDULE = 0;
	static STATE_TRACKING = 1;
}




//------- Function
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief isInRangePlayer
   
   @return         -
   @author         Takaaki-Ohta
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function isInRangePlayer()
{
	local pcOwn = SQ.getActiveChara();
	local pcPlayer = SQ.getPlayer();
	local vFromPos = pcOwn.getPosition();
	local vToPos = pcPlayer.getPosition();
	
	// 距離計算 
	local x = ( vFromPos.getX() - vToPos.getX() ) * 0.01;
	local y = ( vFromPos.getY() - vToPos.getY() ) * 0.01;
	local z = ( vFromPos.getZ() - vToPos.getZ() ) * 0.01;
	local len = x*x + y*y + z*z;
	
	if( len >= VData.AREA_SIZE * VData.AREA_SIZE )
		return false;

	// 角度計算 
	local vToRotY = ::calcTargetRotY(pcOwn, vToPos).getY() * 57.3;
	local vFromRotY = pcOwn.getRotation().getY() * 57.3;
	
	vToRotY -= vFromRotY;
	
	while( vToRotY > 180 )
		vToRotY -= 360;

	while( vToRotY < -180 )
		vToRotY += 360;

	::printf( "%f\n", vToRotY );

	if( vToRotY < VData.TRACKING_ROT && vToRotY > -VData.TRACKING_ROT )
	{
		return true;
	}
	
	
	return false;
}



//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief PlayerTracking
   
   @return         -
   @author         Takaaki-Ohta
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
function PlayerTracking()
{

	local pcOwn = SQ.getActiveChara();
	local cParam = pcOwn.getCustomParam();

	// 初期化されてない場合は初期化する 
	if( cParam >= 0 )
	{
		pcOwn.setTimer( VData.TRACKING_TIMER );
		pcOwn.setCustomParam( -1 );
		pcOwn.setState( VData.STATE_TRACKING );

		// 怒りアイコン
		pcOwn.setEmotionIcon(EMOTION_ICON_ENEMY_EX);
	}

	local pcPlayer = SQ.getPlayer();
	local vToPos = pcPlayer.getPosition();
	// その座標までの回転ベクトルを取得
	local vToRot = ::calcTargetRotY(pcOwn, vToPos);

	// 座標移動と回転移動を発行
	pcOwn.movePosition(vToPos, VData.fTrackingSpeed );
	pcOwn.moveRotation(vToRot, Val.CHARA_ROT_LIFE);

	// モーションを歩きに
	pcOwn.setMotionTag(MOTION_B_RUN, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, true, false);
}


//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief ScheduleMoving
   
   @return         -
   @author         Takaaki-Ohta
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏


function ScheduleMoving()
{

	local pcOwn = SQ.getActiveChara();
	local cParam = pcOwn.getCustomParam();
	// 初期化されてない場合はタイマーを初期化する 
	if( cParam < 0 )
	{
		pcOwn.setTimer( VData.NONTRACKING_TIMER );
		pcOwn.setState( VData.STATE_SCHEDULE );

		// アイコン消す
		pcOwn.unsetEmotionIcon();
	}

	local cSchedule = ScheduleMove( pcOwn, VData.dataList );

	cSchedule.update();

	// アタリをとり続ける
	if (pcOwn.isHitPreCollision()) {
		pcOwn.setIsRange(true);
	}
			
	return;
}



//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
/*! 
   @brief main
   
   @return         -
   @author         Takaaki-Ohta
*/
//┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏┏
{
	local pcOwn = SQ.getActiveChara();

	if( pcOwn.getState() == VData.STATE_SCHEDULE )
	{
		// NONTRACKING_TIMERがきれているのに、範囲内にいる場合はトラッキングに遷移する 
		if (pcOwn.getTimer() <= 0.0 && isInRangePlayer() )
		{
			PlayerTracking();
		}
		else
		{
			ScheduleMoving();
		}
	}
	else
	{
		// TRACKING_TIMERがきれている場合は、ScheduleMovingに遷移する  
		if (pcOwn.getTimer() <= 0.0)
		{
			ScheduleMoving();
		}
		else
		{
			if( isInRangePlayer() )
			{
				PlayerTracking();
			}
			else
			{
				// Rangeに入ってない場合もScheduleに遷移する 
				ScheduleMoving();
			}
		}
		
	}

}


//-----------------EOF---------------------------------------------------------

