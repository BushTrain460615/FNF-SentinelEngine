package;

import openfl.utils.AssetManifest;
import flixel.graphics.frames.FlxAtlasFrames;

#if MODS_ALLOWED
import sys.io.FileInput;
import sys.io.File;
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end

using StringTools;

class Files
{
    #if MODS_ALLOWED
    private static function getMods(file:String, extension:String, directory:String, library:String):Array<String>
    {
        var array:Array<String> = FileSystem.readDirectory("mods");

        var output:Array<String> = new Array<String>();

        for (i in 0...array.length)
        {
            if (library == "preload")
            {
                if (FileSystem.exists("mods/" + array[i] + "/" + directory + "/" + file + "." + extension))
                {
                    output.insert(array.length + 1, array[i] + "/" + directory + "/" + file + "." + extension);
                }
            }
            else
            {
                if (FileSystem.exists("mods/" + array[i] + "/" + library + "/" + directory + "/" + file + "." + extension))
                {
                    output.insert(array.length + 1, array[i] + "/" + library + "/" + directory + "/" + file + "." + extension);
                }
            }
        }

        return output;
    }
    #end

    private static function getLibrary(file:String, extension:String, directory:String):String //TODO: Improve On This So It's Not So Chunky -Generalisk
    {
        if (FileSystem.exists("assets/" + directory + "/" + file + "." + extension))
        {
            return "preload";
        }
        else if (FileSystem.exists("assets/shared/" + directory + "/" + file + "." + extension))
        {
            return "shared";
        }
        else if (FileSystem.exists("assets/tutorial/" + directory + "/" + file + "." + extension))
        {
            return "tutorial";
        }
        else if (FileSystem.exists("assets/week1/" + directory + "/" + file + "." + extension))
        {
            return "week1";
        }
        else if (FileSystem.exists("assets/week2/" + directory + "/" + file + "." + extension))
        {
            return "week2";
        }
        else if (FileSystem.exists("assets/week3/" + directory + "/" + file + "." + extension))
        {
            return "week3";
        }
        else if (FileSystem.exists("assets/week4/" + directory + "/" + file + "." + extension))
        {
            return "week4";
        }
        else if (FileSystem.exists("assets/week5/" + directory + "/" + file + "." + extension))
        {
            return "week5";
        }
        else if (FileSystem.exists("assets/week6/" + directory + "/" + file + "." + extension))
        {
            return "week6";
        }
        else if (FileSystem.exists("assets/week7/" + directory + "/" + file + "." + extension))
        {
            return "week7";
        }

        return "shared";
    }

    private static function getPath(file:String, extension:String, directory:String, library:String, ?ignoreMods:Bool = false):Dynamic
    {
        if (library == null)
        {
            library = getLibrary(file, extension, directory);
        }

        var output:String = null;
        if (library == "preload")
        {
            output = "assets/" + directory + "/" + file + "." + extension;
        }
        else
        {
            output = "assets/" + library + "/" + directory + "/" + file + "." + extension;
        }

        #if MODS_ALLOWED
        var mods:Array<String> = [];

        if (!ignoreMods)
        {
            mods = getMods(file, extension, directory, library);
        }

        if (!FileSystem.exists(output) && mods.length < 1)
        #else
        if(!Assets.exists(output))
        #end
        {
            trace(output + " Is Invalid For Some F-ing Reason");
            switch (extension)
            {
                case "png":
                    output = "assets/MissingTexture.png";
                case "ogg" | "mp3":
                    output = "assets/MissingSound." + extension;
                default:
                    output = null;
            }
        }
        #if MODS_ALLOWED
        else if (FileSystem.exists("mods/" + mods[0]))
        {
            output = null;

            switch(extension)
            {
                case "png":
                    new AssetManifest().addBitmapData("mods/" + mods[0]);
                    return "mods/" + mods[0];
                case "ogg" | "mp3":
                    new AssetManifest().addSound(["mods/" + mods[0]]);
                    return "mods/" + mods[0];
                case "txt" | "xml":
                    return "mods/" + mods[0];
                default:
                    return "mods/" + mods[0];
            }
        }
        #end

        return output;
    }

    #if MODS_ALLOWED
    inline static public function getModsList():Array<String>
    {
        var array:Array<String> = FileSystem.readDirectory("mods");

        var output:Array<String> = new Array<String>();

        for (i in 0...array.length)
        {
            output.insert(array.length + 1, "mods/" + array[i]);
        }

        output.remove("README.txt");

        return output;
    }
    #end

    inline static public function file(file:String, extension:String, directory:String, ?library:String = null):Dynamic
    {
        return getPath(file, extension, directory, library);
    }

    inline static public function txt(file:String, directory:String, ?library:String = null):Dynamic
    {
        return getPath(file, "txt", directory, library);
    }

    inline static public function image(file:String, ?library:String = null):Dynamic
    {
        return getPath(file, "png", "images", library);
    }

    inline static public function sound(file:String, ?library:String = null):Dynamic
    {
        #if web
        return getPath(file, "mp3", "sounds", library);
        #else
        return getPath(file, "ogg", "sounds", library);
        #end
    }

    inline static public function music(file:String, ?library:String = null):Dynamic
    {
        #if web
        return getPath(file, "mp3", "music", library);
        #else
        return getPath(file, "ogg", "music", library);
        #end
    }

    inline static public function inst(songName:String):Dynamic
    {
        #if web
        return getPath("Inst", "mp3", songName.toLowerCase().replace(" ", "-"), "songs");
        #else
        return getPath("Inst", "ogg", songName.toLowerCase().replace(" ", "-"), "songs");
        #end
    }

    inline static public function voices(songName:String):Dynamic
    {
        #if web
        return getPath("Voices", "mp3", songName.toLowerCase().replace(" ", "-"), "songs");
        #else
        return getPath("Voices", "ogg", songName.toLowerCase().replace(" ", "-"), "songs");
        #end
    }

    inline static public function font(file:String):Dynamic
    {
        return "assets/fonts/" + file;
    }

    inline static public function getSparrowAtlas(fileName:String, ?library:String = null):FlxAtlasFrames
    {
        return FlxAtlasFrames.fromSparrow(image(fileName, library), file(fileName, "xml", "images", library));
    }

    inline static public function readTextFile(file:String, directory:String, ?library:String = null, ?modAdditions:Bool = false):Array<String>
    {
        var textFile:Array<String> = [];
        var temp:Array<String> = [];
		#if sys
		if(FileSystem.exists(getPath(file, "txt", directory, library, modAdditions))) temp = File.getContent(getPath(file, "txt", directory, library, modAdditions)).trim().split('\n');
		#else
		if(Assets.exists(getPath(file, "txt", directory, library, modAdditions))) temp = Assets.getText(getPath(file, "txt", directory, library, modAdditions)).trim().split('\n');
		#end

		for (i in 0...temp.length)
		{
			textFile.insert(textFile.length + 10, temp[i].trim());
		}

        #if MODS_ALLOWED
        if (modAdditions)
        {
            var mods:Array<String> = getMods(file, "txt", directory, library);

            for (mod in 0...mods.length)
            {
                temp = [];
		        #if sys
		        if(FileSystem.exists("mods/" + mods[mod])) temp = File.getContent("mods/" + mods[mod]).trim().split('\n');
		        #else
		        if(Assets.exists("mods/" + mods[mod])) temp = Assets.getText("mods/" + mods[mod]).trim().split('\n');
		        #end

		        for (i in 0...temp.length)
		        {
			        textFile.insert(textFile.length + 10, temp[i].trim());
		        }
            }
        }
        #end

        return textFile;
    }
}