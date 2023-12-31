;/Whois Script (mIRC 6.35+)
;Just copt and past this into a new remote scripts file in mIRC scripts editor
;By Neo Nemesis
;Version 1.5 (2011)

raw *:*: {
  if ($numeric == 311) {
    echo -a  $+ $color(whois) $+ -
    echo -a  $+ $color(whois) Whois: $2
    echo -a  $+ $color(whois) Host: $3 $+ @ $+ $4-
    halt
  }
  if ($numeric == 379) {
    echo -a  $+ $color(whois) Modes: $6-
    halt
  }
  if ($numeric == 378) {
    echo -a  $+ $color(whois) Connecting from: $6-
    halt
  }
  if ($numeric == 307) {
    echo -a  $+ $color(whois) $2 is a registered user
    halt
  }
  if ($numeric == 319) {
    echo -a  $+ $color(whois) Channels: $3-
    halt
  }
  if ($numeric == 312) {
    echo -a  $+ $color(whois) Server: $3-
    halt
  }
  if ($numeric == 301) {
    echo -a  $+ $color(whois) Away: $3-
    halt
  }
  if ($numeric == 671) {
    echo -a  $+ $color(whois) $2-
    halt
  }
  if ($numeric == 313) {
    echo -a  $+ $color(whois) $+ $chr(32) $+ $2-
    halt
  }
  if ($numeric == 310) {
    echo -a  $+ $color(whois) $2-
    halt
  }
  if ($numeric == 320) {
    echo -a  $+ $color(whois) $3-
    halt
  }
  if ($numeric == 317) {
    echo -a  $+ $color(whois) Idle: $duration($3)
    echo -a  $+ $color(whois) Sign On: $asctime($4)
    halt
  }
  if ($numeric == 401) {
    echo -a  $+ $color(whois) $+ -
    echo -a  $+ $color(whois) $2 is not online
    halt
  }
  if ($numeric == 330) {
    echo -a  $+ $color(whois) $3- $2
    halt
  }
  if ($numeric == 318) {
    echo -a  $+ $color(whois) End of /whois
    echo -a  $+ $color(whois) $+ -
    unset %whois
    halt
  }
}
