
mt_irc.register_bot_command("adm_ban", {
    params = "<name>";
    description = "Ban an user";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_ban");
            return;
        end
        if (not mt_irc_admin.users_on[from]) then
            mt_irc.say(from, "You are not logged in");
            return;
        end
        minetest.ban_player(args);
        mt_irc.say(from, "Player `"..args.."' has been banned");
    end;
});

mt_irc.register_bot_command("adm_unban", {
    params = "<name>";
    description = "Unban an user or IP address";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_unban");
            return;
        end
        if (not mt_irc_admin.users_on[from]) then
            mt_irc.say(from, "You are not logged in");
            return;
        end
        minetest.unban_player_or_ip(args);
        mt_irc.say(from, "Player `"..args.."' has been unbanned");
    end;
});

mt_irc.register_bot_command("adm_banlist", {
    params = "<name>";
    description = "Get list of banned users";
    
    func = function ( from, args )
        if (not mt_irc_admin.users_on[from]) then
            mt_irc.say(from, "You are not logged in");
            return;
        end
        local list = minetest.get_ban_list();
        mt_irc.say(from, "== BAN LIST ==");
        for _,item in ipairs(list) do
           mt_irc.say(from, item);
        end
    end;
});
