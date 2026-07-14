/*******************************************************************************

   @brief Kosako Order
   
   @return         -
   @author         Takaaki Ohta

*******************************************************************************/


// 便利関数まとめクラスのimport 
SQ.import( "_aiHelper" );
util<-AIHelper();


// ランダム動作発行 
function state_select()
{
	// 移動(2)もしくはWaitのoffset0ループ(3)へランダムで遷移 
	if( util.randMax(100) < 50 )
	{
		util.setState( Enum.STATE_MOVE_IN );
	}
	else
	{
		util.setState( Enum.STATE_EX0 );
	}
}

// 移動前回転開始 
function state_move_in()
{
	// ランダムな座標を取得して移動 
	local vToPos = util.own.getRandomRangePosition();
	
	// 移動先を保存しておく 
	util.own.setCustomPos(vToPos);

	// その座標までの回転ベクトルを取得
	local vToRot = ::calcTargetRotY(util.own, vToPos);
	util.own.setCustomRot(vToRot);

	// 回転のみ発行
	util.own.moveRotation(vToRot, Val.CHARA_ROT_LIFE);

	// 入りモーション
	util.setMotionTag(MOTION_WALK, 1, Val.MOTION_SPEED); // ( motionTag, divOffset, speed )
				
	// アイコン消す
	util.own.unsetEmotionIcon();
				
	// 移動へ
	util.setState(Enum.STATE_MOVE);
}


// 回転終了待ち 
function state_move()
{
	
	if( !util.own.isMoveRotation() )
	{
		// 移動を発行
		local vToPos = util.own.getCustomPos();
		util.own.movePosition(vToPos, util.own.getMoveSpeed());

		// 移動中へ
		util.setState(Enum.STATE_MOVING);
	}
}


// 移動終了待ち 
function state_moving()
{
	// あたってない && まだ動いてるなら待つ 
	if ( !util.own.isHitCollision() && util.own.isMovePosition())
	{
		return;
	}

	// 移動を止める
	util.own.stopMovePosition();

	// 戻りモーション
	util.own.setMotionTag(MOTION_WALK, 2, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);

	// モーション終了まち(いるかなぁ？) 
	util.setState(Enum.STATE_MOVE_END);
}


// モーション終了まち 
function state_move_end()
{
	if( !util.own.isEndMotin() )
	{
		return;
	}

	// 終了したら（1）へ 
	util.own.setState( Enum.STATE_SELECT );
}



// 待機動作 
function state_ex0()
{
	// Waitのoffset0を3ループする 
	// ループカウンタとして使用する為に0に。 
	util.own.setCustomParam( 0 );
	printf("----\n%d,%d\n", util.own.getState(), util.own.getCustomParam() );

	// 待機モーションを設定 
	util.own.setMotionTag( MOTION_F_WAIT, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED*0.5, false, true);

	util.own.setState( Enum.STATE_EX1 );
}


// 待機動作カウント 
function state_ex1()
{
	// モーションが終了してない 
	if( !util.own.isEndMotin() )
	{
		return;
	}

	local loopCount = util.own.getCustomParam();

	printf("----\n%d,%d\n", util.own.getState(), util.own.getCustomParam() );
	// 3回はループする 
	if( loopCount < 3 )
	{
		util.own.setCustomParam( loopCount + 1 );
		util.own.setMotionTag( MOTION_F_WAIT, 0, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED*0.5, false, true);
		return;
	}

	// 3回ループした 

	// その後ランダムで(1)/(4)/(5)へ
	local randVal = util.randMax(100);
	
	// 1/3ずつ？Randomで決める 
	if( randVal < 33 )
	{
		util.setState( Enum.STATE_SELECT );
	}
	else if( randVal < 66 )
	{
		util.own.setMotionTag( MOTION_F_WAIT, 1, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
		util.setState( Enum.STATE_EX2 );
	}
	else
	{
		util.own.setMotionTag( MOTION_F_WAIT, 2, Val.MOTION_BLEND_FRAME, Val.MOTION_SPEED, false, false);
		util.setState( Enum.STATE_EX2 );
	}
}



// 待機動作EX終了待ち 
function state_ex2()
{
	// モーションが終了してない 
	if( !util.own.isEndMotin() )
	{
		return;
	}
	util.setState( Enum.STATE_SELECT );
}




//----
// ここからメイン 
{
	switch( util.own.getState() )
	{

	// ランダム動作発行 
	case Enum.STATE_SELECT:
		state_select();
		break;

	// 移動前回転開始 
	case Enum.STATE_MOVE_IN:
		state_move_in();
		break;

	// 回転終了待ち 
	case Enum.STATE_MOVE:
		state_move();
		break;

	// 移動終了待ち 
	case Enum.STATE_MOVING:
		state_moving();
		break;

	// モーション終了まち 
	case Enum.STATE_MOVE_END:
		state_move_end();
		break;

	// 待機動作  
	case Enum.STATE_EX0:
		state_ex0();
		break;

	// 待機動作カウント 
	case Enum.STATE_EX1:
		state_ex1();
		break;

	// 待機動作EX終了待ち 
	case Enum.STATE_EX2:
		state_ex2();
		break;

	default:
		state_select();
		break;
	}
}


