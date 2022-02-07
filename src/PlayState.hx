package;

import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxCamera;
import flixel.FlxG;

class PlayState extends FunkinState
{
    public var voices:FlxSound;

    public var game:FlxCamera;
    public var hud:FlxCamera;
    public var target:FlxSprite;

    public var song:String = "null";

    public var player1:String = "bf";
    public var player2:String = "dad";
    public var gf:String = "gf";

    public var boyfriend:Character;
    public var girlfriend:Character;
    public var dad:Character;

    public var stage:String = "stage";

    public var background:Stage;

    public function new(lSong:String, ?p1:String = "bf", ?p2:String = "dad", ?p3:String = "gf", ?bg:String = "stage")
    {
        super();

        song = lSong;
        player1 = p1;
        player2 = p2;
        gf = p3;
        stage = bg;

        if (FlxG.sound.music != null)
        {
            FlxG.sound.music.stop();
        }
    }

    override function create()
    {
        super.create();

        target = new FlxSprite().makeGraphic(1, 1, FlxColor.TRANSPARENT, true, "targettedlol");
        target.antialiasing = false;
        target.screenCenter();
        add(target);

        game = new FlxCamera();
        game.follow(target, FlxCameraFollowStyle.NO_DEAD_ZONE, 1);
        game.zoom = 1.3;
        FlxG.cameras.reset(game);
        FlxG.cameras.setDefaultDrawTarget(game, true);

        hud = new FlxCamera();
        hud.follow(new FlxSprite(-69420, -69420).makeGraphic(1, 1, FlxColor.TRANSPARENT, true, "targettedtoolol"), FlxCameraFollowStyle.NO_DEAD_ZONE, 1);
        hud.bgColor.alpha = 0;
        FlxG.cameras.add(hud);

        background = new Stage(stage);
        add(background);

        girlfriend = new Character(gf, false);
        girlfriend.screenCenter();
        add(girlfriend);
        girlfriend.y += 100;

        dad = new Character(player2, false);
        dad.screenCenter();
        add(dad);
        dad.x -= 450;
        dad.y += 200;

        switch (player2)
        {
            case "dad":
                dad.y -= 100;
            case "pico":
                dad.y += 50;
            case "mom" | "mom-car":
                dad.y -= 100;
        }

        boyfriend = new Character(player1, true);
        boyfriend.screenCenter();
        add(boyfriend);
        boyfriend.x += 450;
        boyfriend.y += 360;

        switch (stage)
        {
            case "limo":
                dad.x += 180;
                dad.y += 50;
                boyfriend.x += 25;
                boyfriend.y -= 175;
            case "mall":
                dad.y += 480;
                girlfriend.y += 480;
                boyfriend.y += 480;
        }

        countdown();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.pressed.UP)
        {
            boyfriend.up();
        }

        if (FlxG.keys.pressed.DOWN)
        {
            boyfriend.down();
        }

        if (FlxG.keys.pressed.LEFT)
        {
            boyfriend.left();
        }

        if (FlxG.keys.pressed.RIGHT)
        {
            boyfriend.right();
        }

        /*if (!voices.playing)
        {
            FunkinState.switchState(new FreeplayState());
        }*/

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FunkinState.switchState(new MainMenuState());
        }
    }

    public function countdown()
    {
        moveCam(girlfriend);
        new FlxTimer().start(0.5, function(tmr:FlxTimer) {
            switch (player1)
            {
                case "bf-pixel":
                    FlxG.sound.play(Files.sound("intro3-pixel", "week6"));
                default:
                    FlxG.sound.play(Files.sound("intro3", "shared"));
            }
            new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                switch (player1)
                {
                    case "bf-pixel":
                        var count02:FlxSprite = new ReadyCard(Files.image("weeb/pixelUI/ready-pixel", "week6"));
                        add(count02);
                        FlxG.sound.play(Files.sound("intro2-pixel", "week6"));
                    default:
                        var count02:FlxSprite = new ReadyCard(Files.image("ready", "preload"));
                        add(count02);
                        FlxG.sound.play(Files.sound("intro2", "shared"));
                }
                new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                    switch (player1)
                    {
                        case "bf-pixel":
                            var count01:FlxSprite = new ReadyCard(Files.image("weeb/pixelUI/set-pixel", "week6"));
                            add(count01);
                            FlxG.sound.play(Files.sound("intro1-pixel", "week6"));
                        default:
                            var count01:FlxSprite = new ReadyCard(Files.image("set", "preload"));
                            add(count01);
                            FlxG.sound.play(Files.sound("intro1", "shared"));
                    }
                    new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                        switch (player1)
                        {
                            case "bf-pixel":
                                var count00:FlxSprite = new ReadyCard(Files.image("weeb/pixelUI/go-pixel", "week6"));
                                add(count00);
                                FlxG.sound.play(Files.sound("introGo-pixel", "week6"));
                            default:
                                var count00:FlxSprite = new ReadyCard(Files.image("go", "preload"));
                                add(count00);
                                FlxG.sound.play(Files.sound("introGo", "shared"));
                        }
                        new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                            startSong();
                        });
                    });
                });
            });
        });
    }

    public function startSong()
    {
        FlxG.sound.playMusic(Files.inst(song), 1, false);
        voices = FlxG.sound.play(Files.voices(song));
        FlxG.sound.music.time = voices.time;

        moveCam(boyfriend);
        loop();
    }

    public function moveCam(char:Character)
    {
        FlxTween.cancelTweensOf(game);
        FlxTween.tween(game, {zoom: background.camZoom}, 1, {
            ease: FlxEase.expoOut,
        });
        FlxTween.cancelTweensOf(target);
        FlxTween.tween(target, {x: char.getGraphicMidpoint().x}, 2.5, {
            ease: FlxEase.expoOut,
        });
        FlxTween.tween(target, {y: char.getGraphicMidpoint().y}, 2.5, {
            ease: FlxEase.expoOut,
        });
    }

    public function loop() //Temporary
    {
        new FlxTimer().start(3.5, function(tmr:FlxTimer) {
            moveCam(dad);
            new FlxTimer().start(3.5, function(tmr:FlxTimer) {
                moveCam(boyfriend);
                loop();
            });
        });
    }
}

class ReadyCard extends FlxSprite
{
    public function new(card:String)
    {
        super();
        loadGraphic(card);
        setPosition(-69420 - (width / 2), -69420 - (height / 2));

        new FlxTimer().start(0.1, function(tmr:FlxTimer) {
            FlxTween.tween(this, {alpha: 0}, 0.4, {
                ease: FlxEase.linear,
            });
        });
    }
}