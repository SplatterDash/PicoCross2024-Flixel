package substates;

import Paths;

class ImageSubState extends FlxSubState
{
    var image:String;
    var graphic:FlxSprite;
    var text:FlxText;
    var imageData:CreditData;
    var back:FlxSprite;
    override public function new(image:String) {
        super();
        this.image = image;
    }

    override public function create() {
        final bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.alpha = 0.25;
        add(bg);

        imageData = Paths.getData().artwork.filter(i -> i.id == image)[0];

        graphic = new FlxSprite(0, 0).loadGraphic(Paths.loadAsset(IMAGE, 'artwork/' + imageData.id));
        if((graphic.height > FlxG.height) || (graphic.width > FlxG.width)) {
            final scaleVal:Float = (graphic.height > FlxG.height) ? (graphic.height / FlxG.height) : (graphic.width / FlxG.width);
            graphic.scale.set(scaleVal, scaleVal);
            graphic.updateHitbox();
        }
        graphic.screenCenter();
        graphic.active = false;
        add(graphic);

        text = new FlxText(0, 0, FlxG.width, '"${imageData.title}" by ${imageData.author}\nClick here to view this art on NG');
        text.setFormat('', 16, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        if(Controls.model != 'mobile') text.text += '\n${Controls.model == 'mouse' ? 'Right-click' : 'Press ' + (Controls.model == 'keyboard' ? 'BACKSPACE' : 'BACK')} to return to the game';
        text.y = FlxG.height - text.height - 20;
        text.active = false;
        add(text);

        if(Controls.model == 'mobile') {

        }

        super.create();
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if(Controls.justReleasedSecond[0] || (Controls.checkForHover(back) && Controls.justReleasedLead[0]))
            close();

        if(Controls.pressedDirection.contains(true)) switch(Controls.pressedDirection.indexOf(true)) {
            case 0: graphic.y -= 1;
            case 1: graphic.x -= 1;
            case 2: graphic.y += 1;
            case 3: graphic.x += 1;
        }

        if(Controls.checkForHover(text) && Controls.justReleasedLead[0])
            FlxG.openURL(imageData.link);
    }
}