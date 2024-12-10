import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.input.touch.FlxTouch;
import flixel.input.mouse.FlxMouse;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.graphics.FlxGraphic;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;

#if html5
import js.html.FileSystem;
#elseif desktop
import sys.FileSystem;
#end

import lime.utils.Assets;