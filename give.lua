
local function handle_give_command ( giver, receiver, stackstring )
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

mt_irc.register_bot_command("adm_give", {
    params = "<player> <itemstring>";
    description = "Give item to player";
    
    func = function ( from, args )
        if (args == "") then
            mt_irc.bot_help(from, "adm_give");
            return;
        end
        if (not mt_irc_admin.users_on[from]) then
            mt_irc.say(from, "You are not logged in");
            return;
        end
		local to, item = string.match(args, "^([^ ]+) +(.+)$");
		if ((not to) or (not item)) then
            mt_irc.bot_help(from, "adm_give");
			return;
		end
        handle_give_command(from, to, item);
    end;
});
