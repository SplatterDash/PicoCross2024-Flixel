package objects;

import flixel.util.FlxTimer;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class Grid extends FlxTypedSpriteGroup<FlxSprite>
{
    var gridSize:Array<Int> = [];
    var reference:FlxGraphic = null;
    var imageArray:Array<String> = [];
    var grid:Array<Array<PicoSquare>> = [];

    override function new(width:Int, height:Int, reference:FlxGraphic, imageArray:Array<String>) {
        super();
        this.reference = reference;
        this.imageArray = imageArray;
        gridSize = [width, height];

        for(y in 0...gridSize[1] - 1) {
            var row:Array<PicoSquare> = [];
            for(x in 0...gridSize[0] - 1) {
                final square:PicoSquare = new PicoSquare(x, y, null);
                row.push(square);
                add(square);
            }
            grid.push(row);
        }

        for(y in 0...gridSize[1] - 1)
            for(x in 0...gridSize[0] - 1)
                if(reference.bitmap.getPixel(x, y) == 0)
                    grid[y][x].image = imageArray.pop();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        //check rows first, then columns
        if(FlxG.mouse.justReleased || FlxG.mouse.justReleasedRight) for(row in 0...grid.length - 1) {
            for (member in 0...grid[row].length - 1) {
                if(checkRows(member, row));
                checkColumns(member);
            }
        }
    }

    function checkRows(x:Int, y:Int):Bool {
        final daThing:PicoSquare = grid[y][x];
        if((daThing.image == null && daThing.selected) || (daThing.image != null && !daThing.selected)) return false;
        if(!daThing.displayingImage) daThing.displayChange(x);
        return true;
    }

    public static var counter:Int = 0;
    function checkColumns(x:Int):Bool {
        for (y in 0...grid.length - 1) {
            final daThing:PicoSquare = grid[y][x];
            if((daThing.image == null && daThing.selected) || (daThing.image != null && !daThing.selected)) {
                counter = 0;
                return false;
                break;
            }
        }
    }
}

class PicoSquare extends FlxSprite {
    public var image:String;
    public var displayingImage:Bool;
    public var selected:Bool;

    public override function new(x:Int, y:Int, image:String = null) {
        super(x, y);
        this.image = image;
        loadGraphic(Paths.loadAsset(IMAGE, 'ui/playstate/tile'), true, 40, 40);
        animation.add('clear', [0], 1, false);
        animation.add('crossout', [1], 1, false);
        animation.add('fill', [2], 1, false);
        animation.add('void', [3], 1, false);
        animation.add('frame', [4], 1, false);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        if(Controls.checkForHover(this)) {
            if(displayingImage && scale.x != 1.25) scale.set(1.25, 1.25);
            if(Controls.justReleasedLead[0])
                if(displayingImage) FlxG.state.openSubState(new substates.ImageSubState(image))
                    else {

                    }
        } else if(displayingImage && scale.x != 1) scale.set(1, 1);
    }

    public function displayChange(index:Int) {
        displayingImage = true;
        final tmr:FlxTimer = new FlxTimer().start(0.1 * index, function(tmr:FlxTimer) {
            if(image == null) animation.play('void') else loadGraphic(Paths.loadAsset(IMAGE, 'artwork/' + image));
        }, 1);
    }
}