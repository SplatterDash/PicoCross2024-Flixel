package;

class Controls {
    public static var justPressedLead:Array<Bool> = [false];
    public static var justReleasedLead:Array<Bool> = [false];
    public static var pressedLead:Array<Bool> = [false];

    public static var justPressedSecond:Array<Bool> = [false];
    public static var justReleasedSecond:Array<Bool> = [false];
    public static var pressedSecond:Array<Bool> = [false];

    public static var justPressedDirection:Array<Bool> = [false, false, false, false];
    public static var justReleasedDirection:Array<Bool> = [false, false, false, false];
    public static var pressedDirection:Array<Bool> = [false, false, false, false];

    public static var pressedPause:Array<Bool> = [false];

    public static var model:String = #if switch 'switch' #elseif mobile 'mobile' #else 'mouse' #end;
    
    public function new() {}

    public function update() {
        if(model == 'mobile') {
            justPressedLead = [(FlxG.touches.justStarted().length > 0)];
            justReleasedLead = [(FlxG.touches.justReleased().length > 0)];
            pressedLead = [(FlxG.touches.list.length > 0)];
        } else if(model == 'keyboard') {
            justPressedLead = [FlxG.keys.anyJustPressed([SPACE])];
            justReleasedLead = [FlxG.keys.anyJustReleased([SPACE])];
            pressedLead = [FlxG.keys.anyPressed([SPACE])];

            justPressedSecond = [FlxG.keys.anyJustPressed([BACKSPACE])];
            justReleasedSecond = [FlxG.keys.anyJustReleased([BACKSPACE])];
            pressedSecond = [FlxG.keys.anyPressed([BACKSPACE])];

            justPressedDirection = [FlxG.keys.anyJustPressed([UP]), FlxG.keys.anyJustPressed([RIGHT]), FlxG.keys.anyJustPressed([DOWN]), FlxG.keys.anyJustPressed([LEFT])];
            justReleasedDirection = [FlxG.keys.anyJustReleased([UP]), FlxG.keys.anyJustReleased([RIGHT]), FlxG.keys.anyJustReleased([DOWN]), FlxG.keys.anyJustReleased([LEFT])];
            pressedDirection = [FlxG.keys.anyPressed([UP]), FlxG.keys.anyPressed([RIGHT]), FlxG.keys.anyPressed([DOWN]), FlxG.keys.anyPressed([LEFT])];
        } else if (model == 'switch' || model == 'controller') {
            final gamepad:FlxGamepad = FlxG.gamepads.getFirstActiveGamepad();

            justPressedLead = [gamepad.anyJustPressed([A])];
            justReleasedLead = [gamepad.anyJustReleased([A])];
            pressedLead = [gamepad.anyPressed([A])];

            justPressedSecond = [gamepad.anyJustPressed([B])];
            justReleasedSecond = [gamepad.anyJustReleased([B])];
            pressedSecond = [gamepad.anyPressed([B])];

            justPressedDirection = [gamepad.anyJustPressed([FlxGamepadInputID.DPAD_UP]), gamepad.anyJustPressed([FlxGamepadInputID.DPAD_LEFT]), gamepad.anyJustPressed([FlxGamepadInputID.DPAD_DOWN]), gamepad.anyJustPressed([FlxGamepadInputID.DPAD_RIGHT])];
            justPressedDirection = [gamepad.anyJustReleased([FlxGamepadInputID.DPAD_UP]), gamepad.anyJustReleased([FlxGamepadInputID.DPAD_LEFT]), gamepad.anyJustReleased([FlxGamepadInputID.DPAD_DOWN]), gamepad.anyJustReleased([FlxGamepadInputID.DPAD_RIGHT])];
            pressedDirection = [gamepad.analog.value.LEFT_STICK_Y > 0 || gamepad.anyPressed([FlxGamepadInputID.DPAD_UP]), gamepad.analog.value.LEFT_STICK_X < 0 || gamepad.anyPressed([FlxGamepadInputID.DPAD_LEFT]), gamepad.analog.value.LEFT_STICK_Y < 0 || gamepad.anyPressed([FlxGamepadInputID.DPAD_DOWN]), gamepad.analog.value.LEFT_STICK_X > 0 || gamepad.anyPressed([FlxGamepadInputID.DPAD_RIGHT])];
        } else if (model == 'mouse') {
            justPressedLead = [FlxG.mouse.justPressed];
            justReleasedLead = [FlxG.mouse.justReleased];
            pressedLead = [FlxG.mouse.pressed];

            justPressedSecond = [FlxG.mouse.justPressedRight];
            justReleasedSecond = [FlxG.mouse.justReleasedRight];
            pressedSecond = [FlxG.mouse.pressedRight];

            justPressedDirection = [FlxG.keys.anyJustPressed([UP]), FlxG.keys.anyJustPressed([RIGHT]), FlxG.keys.anyJustPressed([DOWN]), FlxG.keys.anyJustPressed([LEFT])];
            justReleasedDirection = [FlxG.keys.anyJustReleased([UP]), FlxG.keys.anyJustReleased([RIGHT]), FlxG.keys.anyJustReleased([DOWN]), FlxG.keys.anyJustReleased([LEFT])];
            pressedDirection = [FlxG.keys.anyPressed([UP]), FlxG.keys.anyPressed([RIGHT]), FlxG.keys.anyPressed([DOWN]), FlxG.keys.anyPressed([LEFT])];
        }
    }

    public static function checkForHover(sprite:FlxSprite):Bool {
        if(model == 'mobile') return FlxG.touches.getFirst().overlaps(sprite) else if(model == 'mouse') return FlxG.mouse.overlaps(sprite) else return false;
    }
}