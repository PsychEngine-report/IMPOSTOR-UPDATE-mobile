package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import AmongFreeplayState.FreeplayWeek;

enum FinaleState{
	NOT_UNLOCKED;
	NOT_PLAYED;
	COMPLETED;
}

class ClientPrefs {
	//TO DO: Redo ClientPrefs in a way that isn't too stupid
	public static var downScroll:Bool = false;
	public static var extraKeys:Int = 2;
    public static var hitboxLocation:String = 'Bottom';
    public static var hitboxmode:String = 'New';
    public static var hitboxtype:String = 'Gradient';
    public static var storageType:String = 'EXTERNAL_DATA';
    public static var hitboxhint:Bool = false;
    public static var mobilePadAlpha:Float = 0.6;
    public static var hitboxalpha:Float = 0.7;
    public static var extraKeyReturn1:String = 'SHIFT';
    public static var extraKeyReturn2:String = 'SPACE';
    public static var extraKeyReturn3:String = 'Q';
    public static var extraKeyReturn4:String = 'E';
	public static var wideScreen:Bool = false;
	public static var middleScroll:Bool = false;
	public static var showFPS:Bool = true;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = true;
	public static var lowQuality:Bool = false;
	public static var framerate:Int = 60;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var ghostTapping:Bool = true;
	public static var hideTime:Bool = false;

	public static var charOverrides:Array<String> = ['', '', ''];
	public static var beans:Int = 0;
	public static var boughtArray:Array<Bool> = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	// should be enough if u add more stuff fuck you >:(
	public static var forceUnlockedSongs:Array<FreeplayWeek>;
	public static var finaleState:FinaleState = NOT_UNLOCKED;
		
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],
		
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];

	public static function startControls() {
		//Key Bind, Name for ControlsSubState
		keyBinds.set('note_left', [A, LEFT]);
		keyBinds.set('note_down', [S, DOWN]);
		keyBinds.set('note_up', [W, UP]);
		keyBinds.set('note_right', [D, RIGHT]);
		
		keyBinds.set('ui_left', [A, LEFT]);
		keyBinds.set('ui_down', [S, DOWN]);
		keyBinds.set('ui_up', [W, UP]);
		keyBinds.set('ui_right', [D, RIGHT]);
		
		keyBinds.set('accept', [SPACE, ENTER]);
		keyBinds.set('back', [BACKSPACE, ESCAPE]);
		keyBinds.set('pause', [ENTER, ESCAPE]);
		keyBinds.set('reset', [R, NONE]);

		// Don't delete this
		defaultKeys = keyBinds.copy();
	}

	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function saveSettings() {
		FlxG.save.data.charOverrides = charOverrides;
		FlxG.save.data.boughtArray = boughtArray;
		FlxG.save.data.forceUnlockedSongs = forceUnlockedSongs;
		FlxG.save.data.beans = beans;
		FlxG.save.data.finaleState = finaleState;

		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.extraKeys = extraKeys;
        FlxG.save.data.hitboxLocation = hitboxLocation;
        FlxG.save.data.hitboxhint = hitboxhint;
        FlxG.save.data.hitboxmode = hitboxmode;
        FlxG.save.data.hitboxtype = hitboxtype;
        FlxG.save.data.storageType = storageType;
        FlxG.save.data.mobilePadAlpha = mobilePadAlpha;
        FlxG.save.data.hitboxalpha = hitboxalpha;
        FlxG.save.data.extraKeyReturn1 = extraKeyReturn1;
        FlxG.save.data.extraKeyReturn2 = extraKeyReturn2;
        FlxG.save.data.extraKeyReturn3 = extraKeyReturn3;
        FlxG.save.data.extraKeyReturn4 = extraKeyReturn4;
		FlxG.save.data.wideScreen = wideScreen;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.noteSplashes = noteSplashes;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.framerate = framerate;
		FlxG.save.data.cursing = cursing;
		FlxG.save.data.violence = violence;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.hideTime = hideTime;

		var achieves:Array<String> = [];
		for (i in 0...Achievements.achievementsUnlocked.length) {
			if(Achievements.achievementsUnlocked[i][1]) {
				achieves.push(Achievements.achievementsUnlocked[i][0]);
			}
		}
		FlxG.save.data.achievementsUnlocked = achieves;
		FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		if(FlxG.save.data.charOverrides != null) {
			charOverrides = FlxG.save.data.charOverrides;
		}
		if(FlxG.save.data.boughtArray != null){
			boughtArray = FlxG.save.data.boughtArray;
		}
		if(FlxG.save.data.forceUnlockedSongs != null){
			forceUnlockedSongs = FlxG.save.data.forceUnlockedSongs;
		}
		if(FlxG.save.data.beans != null){
			beans = FlxG.save.data.beans;
		}
		if(FlxG.save.data.finaleState != null){
			finaleState = FlxG.save.data.finaleState;
		}

		if(FlxG.save.data.downScroll != null) {
			downScroll = FlxG.save.data.downScroll;
		}
		if(FlxG.save.data.extraKeys != null)
        	extraKeys = FlxG.save.data.extraKeys;
        if(FlxG.save.data.hitboxLocation != null)
        	hitboxLocation = FlxG.save.data.hitboxLocation;
        if(FlxG.save.data.hitboxhint != null)
        	hitboxhint = FlxG.save.data.hitboxhint;
        if(FlxG.save.data.hitboxmode != null)
        	hitboxmode = FlxG.save.data.hitboxmode;
        if(FlxG.save.data.hitboxtype != null)
        	hitboxtype = FlxG.save.data.hitboxtype;
        if(FlxG.save.data.storageType != null)
        	storageType = FlxG.save.data.storageType;
        if(FlxG.save.data.mobilePadAlpha != null)
        	mobilePadAlpha = FlxG.save.data.mobilePadAlpha;
        if(FlxG.save.data.hitboxalpha != null)
        	hitboxalpha = FlxG.save.data.hitboxalpha;
        if(FlxG.save.data.extraKeyReturn1 != null)
        	extraKeyReturn1 = FlxG.save.data.extraKeyReturn1;
        if(FlxG.save.data.extraKeyReturn2 != null)
        	extraKeyReturn2 = FlxG.save.data.extraKeyReturn2;
        if(FlxG.save.data.extraKeyReturn3 != null)
        	extraKeyReturn3 = FlxG.save.data.extraKeyReturn3;
        if(FlxG.save.data.extraKeyReturn4 != null)
        	extraKeyReturn4 = FlxG.save.data.extraKeyReturn4;
		if(FlxG.save.data.wideScreen != null)
			wideScreen = FlxG.save.data.wideScreen;
		if(FlxG.save.data.middleScroll != null) {
			middleScroll = FlxG.save.data.middleScroll;
		}
		if(FlxG.save.data.showFPS != null) {
			showFPS = FlxG.save.data.showFPS;
			if(Main.fpsVar != null) {
				Main.fpsVar.visible = showFPS;
			}
		}
		if(FlxG.save.data.flashing != null) {
			flashing = FlxG.save.data.flashing;
		}
		if(FlxG.save.data.globalAntialiasing != null) {
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if(FlxG.save.data.noteSplashes != null) {
			noteSplashes = FlxG.save.data.noteSplashes;
		}
		if(FlxG.save.data.lowQuality != null) {
			lowQuality = FlxG.save.data.lowQuality;
		}
		if(FlxG.save.data.framerate != null) {
			framerate = FlxG.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		/*if(FlxG.save.data.cursing != null) {
			cursing = FlxG.save.data.cursing;
		}
		if(FlxG.save.data.violence != null) {
			violence = FlxG.save.data.violence;
		}*/
		if(FlxG.save.data.camZooms != null) {
			camZooms = FlxG.save.data.camZooms;
		}
		if(FlxG.save.data.hideHud != null) {
			hideHud = FlxG.save.data.hideHud;
		}
		if(FlxG.save.data.noteOffset != null) {
			noteOffset = FlxG.save.data.noteOffset;
		}
		if(FlxG.save.data.arrowHSV != null) {
			arrowHSV = FlxG.save.data.arrowHSV;
		}
		if(FlxG.save.data.ghostTapping != null) {
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if(FlxG.save.data.hideTime != null) {
			hideTime = FlxG.save.data.hideTime;
		}

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99');
		if(save != null && save.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
