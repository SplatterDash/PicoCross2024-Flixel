package;

import haxe.Json;

class Paths
{
    public static var cache:Map<String, String> = new Map<String, String>();
    public static function getData():DaData
        return cast Json.stringify('assets/data.json');

    public static function loadAsset(type:PicoAssetType, path:String):String {
        final ext:String = convertToExt(type);
        final cleanName:String = path.split('/').pop();
        switch(type)
        {
            case IMAGE: path = 'images/' + path + ext;
            case SOUND: path = 'sounds/sfx/' + path + ext;
            case MUSIC: path = 'sounds/music/' + path + ext;
            case SCENE: path = 'sounds/interrogations/' + path + ext;
            case VIDEO: path = 'videos/' + path + ext;
        }
        if(cache.exists(cleanName))
            return path;
        if(!Assets.exists(path)) {
            trace("Unable to find asset: " + path + ext);
            return null;
        }
        cache.set(cleanName, path);
        return path;
    }

    static function convertToExt(type:PicoAssetType):String
    {
        switch(type)
        {
            case IMAGE: return '.png';
            case SOUND | MUSIC | SCENE: #if (html5 || mobile) return '.ogg' #else return '.mp3' #end;
            case VIDEO: return '.mp4';
        }
        return '';
    }
}

enum PicoAssetType {
    IMAGE;
    SOUND;
    MUSIC;
    SCENE;
    VIDEO;
}

typedef DaData = {
    var artwork:Array<CreditData>;
    var music:Array<String>;
    var voices:Array<CreditData>;
}

typedef CreditData = {
    @:optional var id:String;
    var title:String;
    var author:String;
    var link:String;
    @:optional var authorLink:String; //yknow, for the artists n whatnot
}