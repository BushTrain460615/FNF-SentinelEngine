package;

import flixel.FlxSprite;

class Character extends FlxSprite
{
    public var facingLeft:Bool;

    public function new(character:String)
    {
        super();

        antialiasing = Config.antialiasing;

        switch (character)
        {
            case "bf":
                frames = Files.getSparrowAtlas("characters/BOYFRIEND", "shared");
                animation.addByPrefix("idle", "BF idle dance", 24, true);

                animation.addByPrefix("left", "BF NOTE LEFT", 24, false);
                animation.addByPrefix("right", "BF NOTE RIGHT", 24, false);
                animation.addByPrefix("up", "BF NOTE UP", 24, false);
                animation.addByPrefix("down", "BF NOTE DOWN", 24, false);

                animation.addByPrefix("left-miss", "BF NOTE LEFT MISS", 24, false);
                animation.addByPrefix("right-miss", "BF NOTE RIGHT MISS", 24, false);
                animation.addByPrefix("up-miss", "BF NOTE UP MISS", 24, false);
                animation.addByPrefix("down-miss", "BF NOTE DOWN MISS", 24, false);

                animation.addByPrefix("death", "BF dies", 24, false);
                animation.addByPrefix("deathLoop", "BF Dead Loop", 24, true);
                animation.addByPrefix("deathConfirm", "BF Dead confirm", 24, false);

                animation.addByPrefix("cheer", "BF HEY!!", 24, false);
                animation.addByPrefix("scared", "BF idle shaking", 24, false); //Week 2

                facingLeft = true;
            case "bf-car":
                frames = Files.getSparrowAtlas("characters/bfCar", "shared");
                animation.addByPrefix("idle", "BF idle dance", 24, true);

                animation.addByPrefix("left", "BF NOTE LEFT", 24, false);
                animation.addByPrefix("right", "BF NOTE RIGHT", 24, false);
                animation.addByPrefix("up", "BF NOTE UP", 24, false);
                animation.addByPrefix("down", "BF NOTE DOWN", 24, false);

                animation.addByPrefix("left-miss", "BF NOTE LEFT MISS", 24, false);
                animation.addByPrefix("right-miss", "BF NOTE RIGHT MISS", 24, false);
                animation.addByPrefix("up-miss", "BF NOTE UP MISS", 24, false);
                animation.addByPrefix("down-miss", "BF NOTE DOWN MISS", 24, false);

                facingLeft = true;
            case "bf-christmas":
                frames = Files.getSparrowAtlas("characters/bfChristmas", "shared");
                animation.addByPrefix("idle", "BF idle dance", 24, true);

                animation.addByPrefix("left", "BF NOTE LEFT", 24, false);
                animation.addByPrefix("right", "BF NOTE RIGHT", 24, false);
                animation.addByPrefix("up", "BF NOTE UP", 24, false);
                animation.addByPrefix("down", "BF NOTE DOWN", 24, false);

                animation.addByPrefix("left-miss", "BF NOTE LEFT MISS", 24, false);
                animation.addByPrefix("right-miss", "BF NOTE RIGHT MISS", 24, false);
                animation.addByPrefix("up-miss", "BF NOTE UP MISS", 24, false);
                animation.addByPrefix("down-miss", "BF NOTE DOWN MISS", 24, false);

                animation.addByPrefix("cheer", "BF HEY!!", 24, false);

                facingLeft = true;
        }

        idle();
    }

    public function idle()
    {
        animation.play("idle");
    }
}