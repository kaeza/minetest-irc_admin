
Remote Administration Mod
-------------------------

This is a mod fomr Minetest-C55 that allows some basic administration tasks
 to be performed on a game server via IRC.


Requirements
------------
  - Minetest 0.4.3+ (https://github.com/celeron55/minetest)
  - IRC Mod for Minetest (https://github.com/kaeza/minetest-irc)


Usage
-----
These are the bot commands added by this mod:

!adm_login <password>
  Authenticates the user to the system. Only authenticated users can use
   the other commands described here.

!adm_logout
  Closes the administration session. Once this is called, you must login
   again (with `!adm_login') to be able to use the admin commands.

!adm_grant <name> <privs>
  Grant privilege(s) <privs> to the player named <name>. It uses the same
   syntax as the /grant chat command.

!adm_revoke <name> <privs>
  Revoke privilege(s) <privs> to the player named <name>. It uses the same
   syntax as the /revoke chat command.

!adm_give <name> <stackstring>
  Give items <stackstring> to the player named <name>. It uses the same
   syntax as the /give chat command.

!adm_ban <name>
  Bans the player named <name>. Same as the /ban chat command.

!adm_unban <name>
  Unbans the player named <name> (may be name or IP). Same as the /unban
   chat command.

!adm_banlist <name>
  Lists the players currently banned.


Settings
--------
These settings are changed in `config.lua'.

mt_irc_admin.users (table)
  This table specifies which users are allowed to log-in, and their
   passwords.
  Example:
    mt_irc_admin.users = {
      admin = "1234",
      joemtuser = "abcd",
    }


License
-------
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                    Version 2, December 2004 

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO. 
