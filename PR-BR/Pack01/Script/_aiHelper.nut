/*******************************************************************************
   @brief AIヘルパークラス 
   
   @return         -
   @author         Takaaki Ohta
*******************************************************************************/

class AIHelper
{
	own = SQ.getActiveChara();
	player = SQ.getPlayer();

	constructor(){}

	//--------------------------------------------------------------------------------
	// min以上max未満のランダムな値を取得する 
	function randRange( min, max )
	{
		return SQ.randRange( min, max );
	}
	// max未満のランダムな値を取得する 
	function randMax( max )
	{
		return randRange( 0, max );
	}

	//--------------------------------------------------------------------------------
	// モーションの設定 
	function setMotionTagEx( motionTag, divOffset, blendTime, speed, loopFlag, forceFlag )
	{
		own.setMotionTag( motionTag, divOffset, blendTime, speed, loopFlag, forceFlag );
	}
	// 簡易モーションの設定 
	function setMotionTag( motionTag, divOffset, speed )
	{
		own.setMotionTag( motionTag, divOffset, 0.3, speed, true, false );
	}

	//--------------------------------------------------------------------------------
	// タイマーセット 
	function setTimer( time )
	{
		own.setTimer( time );
	}
	// タイマーに待機時間をセット 
	function setWaitTime()
	{
		own.setTimer( own.getWaitTime() );
	}
	// タイマーの残り時間取得 
	function getTimer()
	{
		return own.getTimer();
	}

	//--------------------------------------------------------------------------------
	// Stateの設定 
	function setState( state )
	{
		own.setState( state );
	}
	// Stateの取得 
	function getState()
	{
		return own.getState();
	}

	//--------------------------------------------------------------------------------
	// SEの再生処理
	function playSE( seTag, volume )
	{
		local temp = [ 
		ECT_CHARA_SE_PLAY, own.getCharaTag(), seTag, 0, volume, 6400, 0, 
		ECT_END,
		];
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		// マクロ実行
		SQ.execProgramMacroFast("playSE");
	}


	//--------------------------------------------------------------------------------
	// イベントフラグ 
	function getEventFlag( flag )
	{
		return SQ.getEventFlagValue( flag );
	}
	function eventFlagSet( flag, value )
	{
		local temp = [ 
		ECT_EVENT_EVENT_FLAG_SET, flag, value,
		ECT_END,
		];
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		// マクロ実行
		SQ.execProgramMacro("eventFlagSet");
	}
	function eventFlagAdd( flag, add )
	{
		local temp = [ 
		ECT_EVENT_EVENT_FLAG_ADD, flag, add,
		ECT_END,
		];
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		// マクロ実行
		SQ.execProgramMacro("eventFlagAdd");
	}

	//--------------------------------------------------------------------------------
	// イベントタグ 
	function isEventExec( tag )
	{
		return SQ.isEventExec( tag );
	}
	function eventRiseSet( tag, rise )
	{
		local temp = [ 
		ECT_EVENT_EVENT_RISE_SET, tag, rise,
		ECT_END,
		];
		// マクロ転送
		foreach (idx, val in temp) {
			SQ.copyProgramMacro(val, idx);
		}
		// マクロ実行
		SQ.execProgramMacro("eventRiseSet");
	}

};


//-----------------EOF---------------------------------------------------------

