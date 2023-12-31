; #INDEX# ======[mIRC Script UDF]============================================================================================================
; Title........: Duck Hunter Script v1.1 (with ZombieHunt Extension) 
; mIRC Version.: mIRC 7.25+
; Description..: Event script and command functions that assist with DuckHunt IRC bot games, including a radar notification when a duck is
;                present in an unactive chat window. Duck Hunt bot originally by Menz Agitat.
;                Dual channel duck radar, notifies you when a duck is detected on the channel(s).
;                Built in shop menu (just use /shop)
;                HotKeys assigned for !bang (F12), !reload (F11)
;                Simplified commands like /b (!bang), /r (!reload), /s <id> <target> (!shop [id] [target])
;                ZombieHunt extension for the variant ZombieHunt bots.
;                And more!
; Version Info.: Version 1.0 - Original rough draft (unavailable)
;                Version 1.1 - First Beta Release (Added ZombieHunt extension)
; Author.......: Neo_Nemesis
; Instructions.: Copy and paste this script into a new remote file in mIRC. Click okay and allow initialization commands to run. 
;                MAKE SURE YOU INPUT YOUR CHANNEL AND BOT INFORMATION BELOW IN THE VARIABLES FUNCTION. 
; ==========================================================================================================================================

; #CURRENT USER COMMANDS# ==================================================================================================================
; Description..: List of basic ease of use commands. (more commands listed in functions list below)
; /duck <ON/OFF> - Turns Duck Hunter Assist ON/OFF
; /radar <ON/OFF> - Turns Duck Hunter Radar ON/OFF
; F12 KEY - !bang
; F11 KEY - !reload
; /b - !bang
; /r - !reload
; /shop - Brings up shop menu
; /s - Brings up shop menu
; /s <number> <user> - For !shop [id] [target]
; /td - !topduck
; /ds - !duckstats
; ==========================================================================================================================================

; #VARIABLES FUNCTION# =====================================================================================================================
; Description..: This command is the start up and maintainence command for Duck Hunter Script. It is run every time the script loads or
;                when mIRC stats up with Duck Hunt script already loaded. Please take notice of the notes below, and make the changes
;                so that this script will work in your channel this function directly handles all of the variables in this script.
;                (SEE *** NOTES BELOW)
; ==========================================================================================================================================

alias -l _duckstart {

  ;### PUT YOUR SETTINGS HERE!!! ###
  
  ;*** Put the name of Duck Hunt channel here
  set %duckchan #Channel1
  set %duckchan2 #Channel2 |     ;*** <--- If not using Channel 2 put None here

  ;*** Put the name of the Duck Hunt bot here
  set %duckbot BotName1
  set %duckbot2 BotNam2 |    ;*** <--- If not using Channel 2 put None here

  ;*** Put the name of the Zombie Hunter bot and channel here
  set %zombiebot ExtBotName |       ;*** <--- If not using Channel Ext put None here
  set %zombiechan #ExtChannel |      ;*** <--- If not using Channel Ext put None here

  ;*** Set your preferences here.
  ;*** RECOMMENDED SETTINGS & DEFAULT: "duck off", "radar on" and "zombie off"
  duck off
  radar on
  zombie off
  return 	
}

; #EVENTS SCRIPT# ==========================================================================================================================
; Description..: This events script handles _duckstart commands on starting and loading, as well as handling all on TEXT events.
; ==========================================================================================================================================

;Loading and Starting
on *:START: { _duckstart | return }

;Text Events for Channel 1, Channel 2 and Channel Ext
on *:TEXT:*:*: {

  ;==================================================
  ;Duck Channel 1
  ;==================================================

  ;Duck Hunter Assist
  If (%duck == ON) && ($nick == %duckbot) && ($chan == %duckchan) && (QUACK isin $1-) { 
    if ($active == $chan) {
      msg $chan !bang 
      return
    }
    if ($active != $chan) && (%radar == OFF) {
      echo -a 7,4 * DUCK DETECTED IN $upper(%duckchan) $+ !!!
      return
    }
  }

  ;Duck Hunter Radar
  If (%radar == ON) && ($nick == %duckbot) && ($chan == %duckchan) && (QUACK isin $1-) { 
    if ($active != $chan) {
      echo -a 9,3 * Duck Hunter Radar: [8DUCK DETECTED9] Channel 1: $chan
      return
    }

    if ($active == $chan) && (%duck == OFF) {
      echo -a 9,3 * Duck Hunter Radar: [8DUCK DETECTED9] Channel 1
      return
    }
  }

  ;==================================================
  ;Duck Channel 2
  ;==================================================

  ;Duck Hunter Assist
  If (%duck == ON) && ($nick == %duckbot2) && ($chan == %duckchan2) && (QUACK isin $1-) {
    if ($active == $chan) {
      ;.timerduck 1 1 msg $chan !bang
      msg $chan !bang
      return
    }
    If ($active != $chan) {
      echo -a 7,4 * DUCK DETECTED IN $upper(%duckchan2) $+ !!!
      return
    }
  }

  ;Duck Hunter Radar
  If (%radar == ON) && ($nick == %duckbot2) && ($chan == %duckchan2) && (QUACK isin $1-) { 
    if ($active != $chan) {
      echo -a 9,3 * Duck Hunter Radar: [8DUCK DETECTED9] Channel 2: $chan
      return
    }

    if ($active == $chan) && (%duck == OFF) {
      echo -a 9,3 * Duck Hunter Radar: [8DUCK DETECTED9] Channel 2
      return
    }
  }

  ;==================================================
  ;Zombie Extension Channel
  ;==================================================

  if (%zombie == ON) && ($nick == %zombiebot) && ($chan == %zombiechan) && (ZOMBIE ALERT isin $1-) {
    if ($active == $chan) {
      echo -a 1,4 Zombie Mode Extension - RADAR [7ZOMBIE DETECTED1] >
      msg $chan .shoot
      return
    }
    if ($active != $chan) {
      echo -a 1,4 Zombie Mode Extension - RADAR [7ZOMBIE DETECTED1] > Channel Ext: %zombiechan
      return
    }
  }
}

; #FUNCTIONS# ==========================================================================================================================
; /duck ON/OFF - Turns Duck Hunter Assist ON or OFF. This aides by automating !bang to get a first shot in quicker.
;                When turned on this only works when user is active on the duck channel.
; /radar ON/OFF - Turns Duck Hunter Radar ON or OFF. This will send a pop-up message to the active window notifying the user that a
;                 has been detected on one of the duck channels. 
; /zombie ON/OFF - Turns Zombie Mode Extension ON or OFF. When turned on this mode combined Assist and Radar for ZombieHunt. While user
;                  is active on the Channel Ext with Zombie mode on, it will help the same as Duck Hunter Assist.
;                  While user is not active on the Channel Ext with Zombie mode on, it will use Zombie Radar to send pop-up message to
;                  the active window to notify user of zombie detection on the Channel Ext. 
; /shop - This will bring up the DuckHunt shop menu. (If performed in ZombieHunt channel window will displat ZombieHunt shop menu)
; /foolsgold - Sends a fake golden duck message to the active chat window (Trick gun confiscation)
; /fakeduck - Sends a fake duck message to the active chat window (Trick gun confiscation)
; /falseduck - Sends a false duck message to the active chat window (Trick gun confiscation)
; ======================================================================================================================================

;==================================================
;Shop Menu Command
;==================================================
alias shop {
  if ($active == %zombiechan) { echo -a 1,4 * Zombie Mode Extension: [/shop] (ZombieHunt Shop Menu) }
  if ($active != %zombiechan) { echo -a 7,4 * Duck Hunter Script: [/shop] OR [/s] (DuckHunt Shop Menu) }
  echo -a 4 * [id]-[Name]-(xp cost)
  echo -a 4 *  1- Extra bullet (7 xp) 
  echo -a 4 *  2- Extra clip (20 xp) 7,4[/ammo]
  echo -a 4 *  3- AP ammo (15 xp) 
  echo -a 4 *  4- Explosive ammo (25 xp) 
  echo -a 4 *  5- Repurchase confiscated gun (40 xp) 7,4[/gun]
  echo -a 4 *  6- Grease (8 xp) 
  echo -a 4 *  7- Sight (6 xp) 
  echo -a 4 *  8- Infrared detector (15 xp) 
  echo -a 4 *  9- Silencer (5 xp) 7,4[/s9]
  echo -a 4 *  10- Four-leaf clover (13 xp) 
  echo -a 4 *  11- Sunglasses (5 xp) 
  echo -a 4 *  12- Spare clothes (7 xp) 7,4[/s12]
  echo -a 4 *  13- Brush for gun (7 xp) 
  echo -a 4 *  14- Mirror (7 xp) 
  echo -a 4 *  15- Handful of sand (7 xp) 
  echo -a 4 *  16- Water bucket (10 xp) 7,4[/s16]
  echo -a 4 *  17- Sabotage (14 xp) 
  echo -a 4 *  18- Life insurance (10 xp) 
  echo -a 4 *  19- Liability insurance (5 xp)
  if ($active == %zombiechan) { echo -a 4 * 20- Scarecrow (50 xp) }
  if ($active != %zombiechan) { echo -a 4 * 20- Decoy (80 xp) }
  if ($active == %zombiechan) { echo -a 4 * 21- Piece of flesh (2000 xp) }
  if ($active != %zombiechan) { echo -a 4 * 21- Piece of bread (50 xp) }
  if ($active == %zombiechan) { echo -a 4 * 22- Zombie detector (5 xp) }
  if ($active != %zombiechan) { echo -a 4 * 22- Ducks detector (50 xp) }
  if ($active == %zombiechan) { echo -a 4 * 23- Mechanica Zombie (50 xp) }
  if ($active != %zombiechan) { echo -a 4 * 23- Mechanical duck (50 xp) }
  if ($active == %zombiechan) { echo -a 4 * Syntax: .shop [id] [target] }
  if ($active != %zombiechan) { echo -a 4 *  Syntax: !shop [id [target]] }
  if ($active != %zombiechan) { echo -a 7,4 * Duck Hunter Syntax: /s <id> <username> (See also /s12 and /s16) }
  return
}

;==================================================
;/duck <ON/OFF> - Duck Hunter Assist ON/OFF function
;==================================================
alias duck {
  if ($1 == ON) {
    echo -a 7,4 * DuckHunt Duck Hunter Assist Turned > 8ON7 < [Channel 1: %duckchan $+ ][Channel 2: %duckchan2 $+ ]
    set %duck ON
    return
  }
  if ($1 == OFF) {
    echo -a 7,4 * DuckHunt Duck Hunter Assist Turned > 8OFF7 [Channel 1: %duckchan $+ ][Channel 2: %duckchan2 $+ ]
    set %duck OFF
    return
  }
}

;==================================================
;/radar <ON/OFF> - Duck Hunter Radar ON/OFF function
;==================================================
alias radar {
  if ($1 == ON) {
    echo -a 9,3 * DuckHunt Duck Hunter Radar Turned > 8ON9 < [Channel 1: %duckchan $+ ][Channel 2: %duckchan2 $+ ]
    set %radar ON
    return
  }
  if ($1 == OFF) {
    echo -a 9,3 * DuckHunt Duck Hunter Radar Turned > 8OFF9 < [Channel 1: %duckchan $+ ][Channel 2: %duckchan2 $+ ]
    set %radar OFF
    return
  }
}

;==================================================
;/zombie ON/OFF - Zombie Hunter extension ON/OFF function 
;==================================================
alias zombie {
  if ($1 == ON) {
    echo -a 1,4 * Zombie Mode Turned > 3ON1 < [Zombie Extension Channel: %zombiechan $+ ]
    set %zombie ON
    return
  }
  if ($1 == OFF) {
    echo -a 1,4 * Zombie Mode Turned > 7OFF1 < [Zombie Extension Channel: %zombiechan $+ ]
    set %zombie OFF
    return
  }
}

;==================================================
;F12 Key - !bang
;==================================================
alias F12 { 
  if ($active == %zombiechan) {
    msg $active .shoot
    return
  }
  msg $active !bang 
  return
}

;==================================================
;F11 Key - !reload
;==================================================
alias F11 { 
  if ($active == %zombiechan) {
    msg $active .reload
    return
  }
  msg $active !reload 
  return
}

;==================================================
;/foolsgold - sends a false golden duck message to chat (trick gun confiscation)
;==================================================
alias foolsgold { msg $active -.,¸¸.-·°'`'°·-.,¸¸.-·°'`'°· \_O<   QUOCK   7* GOLDEN DOCK DETECTED * }

;==================================================
;/fakeduck - sends a fake duck message to chat (trick gun confiscation)
;==================================================
alias fakeduck { msg $active -.,¸¸.-·°'`'°·-.,¸¸.-·°'`'°· \_O<   KWAK }

;==================================================
;/falseduck - sends a false duck message to chat (trick gun confiscation)
;==================================================
alias falseduck { msg $active -.,¸¸.-·°'`'°·-.,¸¸.-·°'`'°· ><))°>   QUACK }

;==================================================
;reduck - remedial duck
;==================================================
alias reduck { msg $active  \_҈< ɊևԬҀҠ }

;==================================================
;rebang - remedial !bang
;==================================================
alias rebang { msg $active !ɮѧӤԍ }

;==================================================
;/b - for !bang
;==================================================
alias b { msg $active !bang }

;==================================================
;/r - for !reload
;==================================================
alias r { msg $active !reload }

;==================================================
;/s9 - for !shop 9 (buy silencer, wont scare ducks for 24hrs)
;==================================================
alias s9 { msg $active !shop 9 }

;==================================================
;/s12 - for !shop 12 (buy dry clothes when soggy)
;==================================================
alias s12 { msg $active !shop 12 }

;==================================================
;/s16 <username> - for !shop 16 (make <username> soggy)
;==================================================
alias s16 { msg $active !shop 16 $1 }

;==================================================
;/ammo - for !shop 2 (buy extra clip)
;==================================================
alias ammo { msg $active !shop 2 }

;==================================================
;/gun - for !shop 5 (return confiscated gun)
;==================================================
alias gun { msg $active !shop 5 }

;==================================================
;/s <number> <user> - for !shop X N (shopping) if just /s then brings up menu
;==================================================
alias s { 
  if ($1- == $null) { 
    shop 
    return
  }
  msg $active !shop $1- 
  return
}

;==================================================
;/td - for !topduck stats
;==================================================
alias td { msg $active !topduck }

;==================================================
;/ds - for !duckstats
;==================================================
alias ds { msg $active !duckstats }

; #UDF END# ================================================================================================================================
; Foot Note...: Duck Hunter Script v1.1 (with ZombieHunt Extension) by Neo_Nemesis
; ==========================================================================================================================================
