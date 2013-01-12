
mt_irc_admin = { };

local MODPATH = minetest.get_modpath("irc_admin");

dofile(MODPATH.."/config.lua");

mt_irc_admin.users_on = { };

mt_irc.register_bot_command("adm_login", {
    params = "<password>";
    description = "Login to use admin commands";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_login");
            return;
        end
        if (mt_irc_admin.users_on[from]) then
            mt_irc.say(from, "You are already logged in");
            return;
        end
        if (not mt_irc_admin.users[from]) then
            mt_irc.say(from, "You are not allowed to access.");
            return;
        end
        if (args ~= mt_irc_admin.users[from]) then
            mt_irc.say(from, "Invalid password");
            return;
        end
        mt_irc_admin.users_on[from] = true;
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
        if (not mt_irc_admin.users_on[from]) then
            mt_irc.say(from, "You are not logged in");
            return;
        end
        mt_irc_admin.users_on[from] = false;
        mt_irc.say(from, "You are now logged off");
    end;
});

dofile(MODPATH.."/privs.lua");
dofile(MODPATH.."/give.lua");
dofile(MODPATH.."/ban.lua");
