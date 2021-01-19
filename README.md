# MC Mission Framework

This is the MC mission making framework, used for Arma 3 missions played with
MC. There are quite a few documents on how to use it and achieve different
things with it:

https://www.misfit-company.com/arma3/

For questions about the framework, or mission making for MC in general, find
us in `#mission-making` on our Discord.

## Main features

### Safe start

Safe start activates several safeties at mission start for a set duration:
- players are invincible
- fired bullets are removed
- player-crewed vehicle damage and guns are disabled

This is a mission parameter and can be set on the slotting screen. Default value is 5 minutes.

You can change the available values and the default in [description.ext](../description.ext), look for `class f_param_mission_timer`.

File: [f_safeStart.sqf](./f/safeStart/f_safeStart.sqf)

### Buddy team colors

Playable characters can automatically be assigned to fireteam colors depending on their name (`variable name`).  
Make sure you name your units accordingly:

- Squad leader: `xxx_SL`
- Fireteam leader: `xxx_FTL`
- Medic: `xxx_M`
- Automatic Rifleman: `xxx_AR`
- Assistant Automatic Rifleman: `xxx_AAR`
- Anti-Tank: `xxx_AT`

By default, teams will be setup like this:

- Green: SL, Medic
- Blue: FTL, AT
- Red: AR, AAR
- White: everyone else

File: [f_setTeamColours.sqf](./f/setTeamColours/f_setTeamColours.sqf)

### BLUFOR tracker system (map markers)

ACE3's BLUFOR tracker system is enabled and customizable in the framework.  

See [dedicated documentation](https://www.misfit-company.com/arma3/mission_making/new_bft/).

### Automated briefing notes

- Automated map-screen briefing that can be customized by faction side. See `f/briefing/f_briefing_[SIDE].sqf` files.
- Automated loadout notes for each player on mission start. See [f_loadoutNotes.sqf](./f/briefing/f_loadoutNotes.sqf).
- Automated ORBAT notes for each player on mission start. Customizable through [f_orbatNotes.sqf](./f/briefing/f_orbatNotes.sqf).
- Dedicated ADMIN notes for zeuses/host, adds a bunch of useful quick-actions. See [f_briefing_admin.sqf](./f/briefing/f_briefing_admin.sqf).

Main file: [briefing.sqf](./briefing.sqf)

### Murk

A utility script (and functions) to improve overall performance by taking care of editor-placed units.

See [dedicated documentation and examples](https://www.misfit-company.com/arma3/mission_making/murk/).

## Extra features

### Mission intro

Displays players actual location, date and time at mission start in the bottom right corner of the screen.

File: [PM_missionIntro.sqf](./extras/PM_missionIntro.sqf)

### Force AIs flashlight

Replaces any lasers with flashlights on all AIs, and forces flashlights to be toggle on.

File: [forceFlashlightAI.sqf](./extras/forceFlashlightAI.sqf)

### Custom airdrops for SSS

Our lord and savior Klausman created a custom script to get airdrops with [Simplex Support Services](https://steamcommunity.com/sharedfiles/filedetails/?id=1850026051).  
The main file is self-documented and contains instructions on how to use it.

Main file: [sss_airdrops.sqf](./extras/sss_airdrops.sqf)

### Log helper functions

Several helper functions are available for your logging needs:
- [mc_fnc_chatlog](./extras/log/fnc_chatlog.sqf) for global chat
- [mc_fnc_rptlog](./extras/log/fnc_rptlog.sqf) for RPT file
- [mc_fnc_bothlog](./extras/log/fnc_bothlog.sqf) for both RPT file and global chat
