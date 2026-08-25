# Ultimate Box Score implementation design

`design.md` is the original product brief and remains unchanged. This document
defines the implemented architecture and the clarified product rules.

## Product structure

The application has three persistent bottom-navigation branches on Android and
Linux:

- **Team** manages teams and rosters and shows totals from completed games.
- **Games** manages events, event rosters, line presets, and games.
- **Stats** owns pre-game setup, live recording, completed-game statistics, and
  the point-by-point action timeline.

Each navigation branch keeps its own stack and state. The selected Stats game is
stored locally so it survives an application restart.

## Events, rosters, and lines

An event belongs to one managed team and contains many games. Its name is
required; dates, location, and notes are optional. New events initially include
all active team players. Later team additions require explicit opt-in, while a
player archived on the Team page remains usable in an event that already
selected them.

Line presets are free-form names with any number of event-roster members. They
remain live while a game is active. Applying a preset replaces the current
point selection with members also present in the game's roster snapshot and
reports unavailable members. Removing an event-roster member also removes them
from every preset.

Players are ordered by natural jersey number, then non-numeric jersey text,
then players without a number, with name as the tie-breaker.

## Games and historical identity

Games move through `draft`, `inProgress`, and `completed`. Only one game may be
in progress globally. Starting a draft snapshots the current event roster and
starts a continuous wall clock that includes background time and halftime.
Completed games may be reopened only when no other game is active; reopened
games are excluded from team totals until completed again.

After a game starts, its event/team, opening possession, and ratio basis are
fixed. Opponent name, cap settings, and target score remain editable.

## Point-scoped action log

Points own an ordered set of participants copied from the game snapshot plus a
point-scoped Unknown participant. Point setup begins empty, and presets or
manual selection may produce a non-seven lineup after an override warning. The
lineup is frozen when the point starts.

Every action stores a game sequence, point, timestamp, typed actor and target,
and an optional related action. Completed passes, receiver drops, and catch
goals therefore retain an explicit passer-to-receiver relationship. Opponent
actions remain anonymous in single-team mode.

Score, possession, current holder, timelines, and statistics are derived by
replaying non-voided actions. Undo marks only the latest active action void and
retains it for audit and export; counters are never an independent source of
truth.

The recording UI never moves the holder out of the ordered player list. The
holder row shows throwaway and, when the holder arrived via a recorded catch,
goal confirmation. Other offensive rows show catch, receiver drop, and catch
goal. Defense rows show D, while opponent throwaway and opponent goal are global
actions.

## Export

Full-database, team, event, and game exports produce one ZIP containing a
versioned lossless JSON document and relational UTF-8 CSV files. Exports include
snapshots, point participants, raw and voided actions, timestamps, explicit pass
endpoints, score summaries, and derived player statistics. Android uses the
system share sheet; Linux uses a native save dialog. Import is intentionally out
of scope.

## Compatibility

This redesign intentionally has no database compatibility guarantee. Opening an
older schema recreates the local database. The application remains offline,
single-team focused, and Chinese-first.
