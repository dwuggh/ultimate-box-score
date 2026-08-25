# Ultimate Box Score App design

This App is used for recording box score for an ultimate frisbee game, 
or one specific team.

## tech
This App is written in flutter. main target is android. It will use
Chinese as the main language.

## logic and UI
It has these pages:
- team & roster
- game

### team & roster page
we can manage teams and there rosters here.
teams metadata include:
  - name
  - type(mixed or single)
we can modify roster for one team. each player include:
  - name
  - gender(male/female)
  - number(optional)
  - position(cutter/handler/any, optional, default to any)

### game page
we can create games records in the game page. there are 2 types: single team
recording and double team recording. we focus on single team recording mode now.
we can see the game stats table in this page, and a button to start the box score
recording.
game metadata:
  - teams(one is our team, the opponent can be only a name)
  - start offsense team
  - time caps(total time, soft cap time, optional)
  - max point(optional)
  - first point's gender ratio(only if this is a mixed team's game, optional)

player stats:
- points played 
- goal
- assist
- turnover
- touches
- catches
- throws
- catch drop
- throw drop

### box score recording page
in this mode, we will record box score for a selected team we have created.
each rounds beginning, we either choose it to be halftime, or a normal point.
- normal point:
we need to select the lineup for this point from the roster(7 of them, if team is mixed team, also show gender ratio prompt, we will always use ABBA style gender rules).
We will auto track offsense or defense for this point due to last point's result.
- half-time:
it has only one button, to stop the halftime. after it, we need to swap o/d against
the first point of this game.

#### box score recording for one point
There are 2 modes: offsense and defense. we want to have different UI for each mode,
and auto transit between them. common rules are:
1. add an unknown player for each point
2. have a undo button, to roll back to last step.
- offsense
on beginning, choose whom to pick up the disc. this requires only once per offsense.
each player has 3 buttons: catch, drop, goal. if the player is catching the disc,
s/he can also throwaway. also have a global goal button, which catch + global goal button equivalent to a player's goal button. if a turnover happens, transit to defense. if
a goal happens, transit to next point
- defense
each player has one button: steal the disc. 2 global button: throwaway by opponent, or
they scored.
if we successfully steal the disc, transit to offsense. if they scored, transit to next point.

