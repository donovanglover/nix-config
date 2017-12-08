# Profanity

- Show basic help information: `/help`
- Show all commands: `/help commands`
- Show more information about a specific command: `/help <command>`

## Window Navigation

- Go to the next window: `Alt-right`
- Go to the previous window: `Alt-left`
- Go to a specific window: `Alt-<number>` **OR** `/win <number>`
- Go to a specific window based on chat name: `/win <room@server.url>` **OR** `/win <person_to_chat_with>`
- View the details of all active windows: `/wins`
- Change the window numbers so there are no gaps inbetween: `/wins tidy`
- Close the current window: `/close`

## Common Commands

- Connect to an XMPP server: `/connect user@server.url`
- Open a new window and send a message to anyone in the world: `/msg <username@server.url> <message>`
    - If you just want to open a new window without sending a message, simply omit the `<message>` part of the command
- Open a new window and send a message to someone in your contacts list: `/msg <contact> <message>`
- Join a chat room: `/join <room@server.url>`
    - Note that your nickname is by default the username you use for the XMPP server you use (`username@server.url`)
    - To specifiy a different nickname when joining a room, use `/join <room@server.url> nick <name>`
    - If the room is located at `room@conference.server.url`, you can simply use `/join <room>`
    - If a room requires a password, add `password <password>` to the end of the command
- Change your nickname in a chat room: `/nick <name>`
- Send a file to the chat: `/sendfile <filepath>`
    - Note that it may be better to just upload the file somewhere
- Leave a chat room: `/leave`
- Logout of the current XMPP server: `/disconnect`
- Quit profanity: `/quit`

### Working with Contacts

- Add someone to your list of contacts: `/roster add <username@server.url>`
    - To specify a nickname for the contact you add, simply add `<nickname>` to the end of the command
    - Note that by convention the nickname should not contain spaces
- Request to know when someone is online or offline: `/sub request <username@server.url>`
    - Note that the official term for this is "subscribing to a contact's presence"
- To remove someone from your list of contacts: `/sub remove <username@server.url>`
    - Note that this also removes your subscription to their presence, and their subscription to yours
- Approve a contact's request to know when you're online or offline: `/sub allow <username@server.url`
    - To deny a request: `/sub deny <username@server.url`
- List all of the sub requests you have sent that are waiting for approval: `/sub sent`
- List all the sub requests that you have received but not yet approved or denied: `/sub received`
- Invite a contact to the current chat room: `/invite <contact>`
    - You can add a `<message>` at the end to specify a reason for them to join
    - Note that, like other commands, you must put the contact name in quotations if it contains spaces (avoid doing this)
    - To show all the rooms that you have been invited to (and haven't accepted or declined yet), use `/invites`
- View all your contacts: `/roster`
- Remove a nickname from a contact: `/roster clearnick <username@server.url>`

Note that if you're already in a chat window with the user, you can use the `/sub` commands without specifying the user.

### Contact Groups

- List all the current groups: `/group`
- Show contacts in a particular group: `/group show <group_name>`
    - The group name can be, for example, `friends`, `family`, or even more specific like `project` or `service`.
- Add a contact to a group: `/group add <group_name> <contact>`
    - Note that there is no command to add a group
    - Adding a contact to a group that doesn't exist will create it
- Remove a contact from a group: `/group remove <group_name> <contact>`

### Presence (aka status)

- Set your status to away: `/away`
- Set your status to extended away: `/xa`
- Set your status to available for chat: `/chat`
- Set your status to online: `/online`
- Set your status to do not disturb: `/dnd`

**NOTE**: Each of these commands accept an optional `<message>`.

- Get the status of a user: `/status <contact|nick>`

## Direct Messages

- To direct a message towards a specific person, type the name of the person you want to direct the message to then press tab for Profanity to autocomplete it
- To start a private chat session with someone in the chat room, use `/msg <nickname> <message>`

### Off The Record Messaging

**Do this first:** Generate a private key for the account you're using: `/otr gen`

- Start a new conversation using OTR: `/otr start <username@server.url>`
- Start sending encrypted messages in an existing conversation window: `/otr start`

At this point, the conversation is encrypted with OTR, but the contact has not yet been authenticated.

#### Question and Answer

**To verify that a recipient is really who they say they are** you need to ask the contact a question that *only they would know* with an expected answer.

- Ask a question to verify that the recipient is really who they say they are: `/otr question "<question_that_only_they_could_answer>" "<answer>"`
    - If the recipient answers correctly, the OTR session becomes trusted, otherwise the authentication will fail and the OTR session is untrusted
- To answer a question sent to you, use: `/otr answer "<answer>"`

**You should always authenticate both ways.** That is, after Bob verifies that Alice is really who she says she is, Alice needs to verify that Bob is really who he says he is. More specifically, each contact will send a question to the other contact.

#### Shared Secret

Another way to verify that a recipient is **really who they say they are**, you can use a shared "secret" (aka passphrase) that only you and the recipient know.

- Authenticate with a shared secret: `/otr secret <passphrase>`
    - Note that both parties must enter the same secret before both parties are authenticated

#### Fingerprint

The final way to verify that a recipient is who they say they are is manually with their key's fingerprint.

**You must exchange fingerprints with your contact via another secure communication channel**, preferrably in person.

- Display your key's fingerprint: `/otr myfp`
- View the fingerprint of a recipient whilst in an OTR session: `/otr theirfp`
    - When you verify someone, this fingerprint should match the one that they gave you in real life (or, arguably less secure, on another communication channel considered secure).
- Manually authenticate the recipient: `/otr trust`
    - You should only manually verify a recipient **if and only if** the fingerprints match.
    - Note that you can untrust the recipient at any time with `/otr untrust`

**NOTE**: You can only use off the record messaging with other people that have it enabled.

#### OTR Options

The default settings in Profanity allow for unencrypted messages. OTR must be started manually with `/otr start`.

You have the option to change this setting to force an encrypted conversation.

- Allow unencrypted messages, OTR must be started manually: `/otr policy manual`
- Attempt to start an OTR session by default (both parties must have a policy set to `opportunistic` or `always`): `/otr policy opportunistic`
- Always use encrypted messages (unencrypted messages will not be sent): `/otr policy always`
- View the current policy for OTR: `/prefs otr`
- To use OTR always for a specific account: `/account set <account_name> otr always`
- To show all the settings for a specific account: `/account show <account_name>`
- To always use OTR for a particular contact: `/otr policy always <contact>`
- Show the current settings for a particular contact: `/account show <contact>`

#### Logging

- Log OTR messages in plaintext:    `/otr log on`
- Log redacted messages:            `/otr log redact`
- Do not log OTR messages:          `/otr log off`
- Show the current log file location: `/log where`

**NOTE**: Messages will only be logged if `/chlog` is set to `on`. Use `/chlog on|off` to turn chat logging on or off respectfully.

### GPG Encrypted Messaging

**NOTE**: Although the default command is `/pgp`, the config file makes `/gpg` work as well.

- List all the keys on your system: `/pgp keys`
- Assign a GPG key to your account (required for other contacts to send GPG-encrypted messages to you): `/account set <your_account@server.url> pgpkeyid <your_pgpkeyid>`
- Manually assign a GPG key to a contact: `/pgp setkey <their_account@server.url> <their_pgpkeyid>`
- List all currently known public keys (both received through signed presence and set manually): `/pgp contacts`

- Sending GPG-encrypted messages: `/pgp start <user@server.url>`
    - Note that if you're already in the conversation window, the last part isn't needed
- Stop sending GPG-encrypted messages: `/pgp end`
    - Unlike OTR, GPG encryption is one-way. That is, it is possible for you to send encrypted messages and not the recipient. Ensure that both you (`send`) and the other party (`recv`) are sending encrypted messages

Note that GPG message logging works the same way as OTR, except with `/pgp log` instead of `/otr log`

**NOTE**: Both parties must have GPG encryption enabled for this to work.

To change the message symbol used for OTR and GPG (by default `~` for both), use `/otr char <symbol>` and `/pgp char <symbol>` respectfully.

## Other Commands

- Change the affiliation of a user in a room: `/affiliation set <affiliation> <user@server.url> [<reason>]`
    - To list all affiliations (or a specific one), use `/affiliation list [<affiliation>]`
    - Note that an affiliation may be either `owner`, `admin`, `member`, `outcast`, or `none`.
- Change the role of a user in the room: `/role set <role> <nick> [<reason>]`
    - To list all roles (or a specific one), use `/role list [<role>]`
    - A role may be either `moderator`, `participant`, `visitor`, or `none`.
- Automatically connect to a particular account on startup: `/autoconnect set <user@server.url>`
    - To turn off autoconnect: `/autoconnect off`
- Kick a user from a chat room: `/kick <user@server.url> [<reason>]`
- Ban a user from a chat room: `/ban <user@server.url> [<reason>]`
- Show all the clients that a user uses: `/caps <user@server.url>`
    - If you're in a conversation with that user, the last part isn't needed
- Clear the current window: `/clear`
- Export contacts to a csv file: `/export ~/contacts.csv`
- Enable or disable logging for a chat room (not personal messages): `/grlog on|off`
- Show information about a contact, room, or room member: `/info <contact>`
- Ping an XMPP server: `/ping <server.url>`
    - If `<server.url>` is not supplied, your chat server will be pinged by default
- Show all preferences: `/prefs`
- Enable or disable the splash screen: `/splash on|off`
- Set the status bar text (can also be used for time): `/time statusbar set <text>`

### Aliases

- Add an alias: `/alias add <name> <value>`
- Remove an alias: `/alias remove <name>`
- List all aliases: `/alias list`

### Blocked Users

- Add a blocked user: `/blocked add <user@server.url>`
- Remove a blocked user: `/blocked remove <user@server.url>`
- List all blocked users: `/blocked`

### Bookmarks

Bookmarks allow you to easily join rooms that you save.

- List all bookmarks: `/bookmark list`
- Add a bookmark: `/bookmark add <room>`
    - Add `nick <nick>` to use a specific nickname
    - Add `password <password>` to specify a room password
    - Add `autojoin <on|off>` to automatically join the room
- Update an existing bookmark: `/bookmark update <room> <things_to_change>`
- Remove a bookmark: `/bookmark remove <room>`
- Join a bookmarked room: `/bookmark join <room>`

### Working with Occupants

- Show the occupants panel in the current room: `/occupants show`
- Hide the occupants panel in the current room: `/occupants hide`
- Show user ids in the occupants panel: `/occupants show|hide jid`
- Change the size of the occupants panel: `/occupants size <percent>`
    - Note that percent should be a value between 1 and 99
- Group the occupants panel by role: `/privileges on|off`

### Real-time Notifications

- Show when a contact is typing (on by default): `/intype on|off`
- Send typing notifications to others (off by default): `/outtype on|off`
- Show when a message has been received: `/receipts request on|off`
- Let others know when you've read a message (by sending a receipt): `/receipts send on|off`
- Send chat state notifications such as typing, paused, active, and gone (defaults to off): `/states on|off`

Note that receipts are off by default (since they do affect privacy quite a bit).

### Other Room Commands

- Accept the default room configuration: `/room accept`
- Reject the default room configuration and destroy the room: `/room destroy`
- Edit the room configuration: `/room config`
- List all the chat rooms available to a specific XMPP server: `/rooms [<service>]`
- Set the room subject: `/subject set <subject>`
- Clear the room subject: `/subject clear`
- Edit the current room subject (use tab completion to auto-display the subject): `/subject edit <subject>`
- Prepend text to the subject: `/subject prepend <text>`
- Append text to the subject: `/subject append <text>`

### Roster Panel

- Show the roster panel: `/roster show`
- Hide the roster panel: `/roster hide`
- Print all online contacts to the console: `/roster`

### Themes

- List all themes: `/theme list`
- Load a specific theme: `/theme load <theme>`
- Show all available colors from the terminal: `/color`
- Show the color settings for the current theme: `/theme properties`

### Who

- Show contacts or room occupants with a specified presence: `/who <online|offline|away|dnd|xa|chat>`
    - Note that you can specify a `<group>` to the end of this command to get, for example, everyone online in the friends group
- Show room occupants with a specific role: `/who moderator|participant|visitor`
- Show room occupants with a specific affiliation: `/who owner|admin|member`

