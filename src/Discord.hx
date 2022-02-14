package;

import sys.thread.Thread;
import Sys.sleep;
import discord_rpc.DiscordRpc;

class Discord
{
    public function new()
    {
        DiscordRpc.start({
            clientID: "942728867100123146",
			onReady: OnReady
        });

        while (true)
        {
            DiscordRpc.process();
            sleep(1);
        }

        DiscordRpc.shutdown();
    }

    public static function NewInstance()
    {
        var SexyDiscordRPC = Thread.create(() ->
		{
			new Discord();
		});
    }

    public static function OnReady()
    {
        #if LOGIN_ALLOWED
        UpdateStatus("Logging Into A Sentinel Engine Account", null);
        #else
        UpdateStatus("In The Intro Menu", null);
        #end
    }

    public static function UpdateStatus(details:String, state:String)
    {
        DiscordRpc.presence({
            details: details,
            state: state,
            largeImageKey: "title-card",
            largeImageText: "Sentinel Engine"
        });
    }
}