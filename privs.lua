
local function set_privs ( from, param, val )
    local grantname, grantprivstr = string.match(param, "([^ ]+) (.+)");
    if ((not grantname) or (not grantprivstr)) then
        mt_irc.bot_help(from, "adm_"..((val and "grant") or "revoke"));
        return;
    end
    if (not mt_irc_admin.users[from]) then
        mt_irc.say(from, "You are not logged in");
        return;
    end
    local grantprivs = minetest.string_to_privs(grantprivstr);
    if (grantprivstr == "all") then
        grantprivs = minetest.registered_privileges;
    end
    local privs = minetest.get_player_privs(grantname);
    local privs_known = true;
    local unk_privs = "";
    for priv, _ in pairs(grantprivs) do
        if (not minetest.registered_privileges[priv]) then
            privs_known = false;
            unk_privs = unk_privs.." "..priv;
        else
            privs[priv] = (val or nil);
        end
    end
    if (not privs_known) then
        mt_irc.say(from, "Unknown privilege(s): "..unk_privs);
        return;
    end
    minetest.set_player_privs(grantname, privs);
    mt_irc.say(from, "Privileges of "..grantname..": "..minetest.privs_to_string(minetest.get_player_privs(grantname), ' '));
    minetest.chat_send_player(grantname, from.." granted you privileges: "..minetest.privs_to_string(grantprivs, ' '));
end

mt_irc.register_bot_command("adm_grant", {
	params = "<player> {<priv>|all}";
	description = "Give privilege to player",
	func = function ( from, args )
	    set_privs(from, args, true);
	end;
});

mt_irc.register_bot_command("adm_revoke", {
	params = "<player> {<priv>|all}";
	description = "Remove privilege from player";
	func = function ( from, args )
	    set_privs(from, args, nil);
	end;
})
