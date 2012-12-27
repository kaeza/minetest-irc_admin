
mt_irc_admin = { };

local MODPATH = minetest.get_modpath("irc_admin");

mt_irc_admin.password = "1234";
mt_irc_admin.users = { };

mt_irc.register_bot_command("adm_login", {
    params = "<password>";
    description = "Login to use admin commands";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_login");
            return;
        end
        if (mt_irc_admin.users[from]) then
            mt_irc.say(from, "You are already logged in");
            return;
        end
        if (args ~= mt_irc_admin.password) then
            mt_irc.say(from, "Invalid password");
            return;
        end
        mt_irc_admin.users[from] = true;
        mt_irc.say(from, "You are now logged in");
    end;
});

mt_irc.register_bot_command("adm_logout", {
    params = nil;
    description = "Logout";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_logout");
            return;
        end
        if (not mt_irc_admin.users[from]) then
            mt_irc.say(from, "You are not logged in");
            return;
        end
        mt_irc_admin.users[from] = false;
        mt_irc.say(from, "You are now logged off");
    end;
});

dofile(MODPATH.."/privs.lua");
dofile(MODPATH.."/give.lua");
