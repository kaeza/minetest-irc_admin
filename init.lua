
local mt_irc_admin = { };

mt_irc_admin.password = "1234";
mt_irc_admin.users = { };

local function handle_give_command(from, cmd, giver, receiver, stackstring)
	local itemstack = ItemStack(stackstring)
	if itemstack:is_empty() then
		mt_irc.say(giver, 'error: cannot give an empty item')
		return
	elseif not itemstack:is_known() then
		mt_irc.say(giver, 'error: cannot give an unknown item')
		return
	end
	local receiverref = minetest.env:get_player_by_name(receiver)
	if receiverref == nil then
		mt_irc.say(giver, receiver..' is not a known player')
		return
	end
	local leftover = receiverref:get_inventory():add_item("main", itemstack)
	local partiality;
	if leftover:is_empty() then
		partiality = ""
	elseif leftover:get_count() == itemstack:get_count() then
		partiality = "could not be "
	else
		partiality = "partially "
	end
	stackstring = itemstack:to_string()
	if giver == receiver then
		mt_irc.say(giver, '"'..stackstring
			..'" '..partiality..'added to inventory.');
	else
		mt_irc.say(giver, '"'..stackstring
			..'" '..partiality..'added to '..receiver.."\'s inventory.");
		mt_irc.say(receiver, '"'..stackstring
			..'" '..partiality..'added to inventory.');
	end
end

mt_irc.register_bot_command("adm_login", {
    params = "<password>";
    description = "Login to use admin commands";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_login");
            return;
        end
        if (mt_irc_admin.users[from]) then
            irc.say(from, "You are already logged in");
            return;
        end
        if (args ~= mt_irc_admin.password) then
            irc.say(from, "Invalid password");
            return;
        end
        mt_irc_admin.users[from] = true;
        irc.say(from, "You are now logged in");
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
            irc.say(from, "You are not logged in");
            return;
        end
        mt_irc_admin.users[from] = false;
        irc.say(from, "You are now logged off");
    end;
});

mt_irc.register_bot_command("adm_give", {
    params = "<password>";
    description = "Authenticate to use admin commands";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_give");
            return;
        end
        if (not mt_irc_admin.users[from]) then
            irc.say(from, "You are not logged in");
            return;
        end
    end;
});
