# QEArmsRace
Quake Enhanced Arms Race

This is a multiplayer deathmatch mod that adds a gameplay similar to CSGO Arms Race, where you go from powerful weapons all the way down to weakest.
The last person to score a kill after the last weapon level wins the game.

Custom weapons are available and there is multiple weapon sets you can choose from.

# Download
* [QEThings MPMods](https://mpmods.qethings.xyz) - Automatic install
* [Github Release](https://github.com/jpiolho/QEArmsRace/releases/latest) - Manual install

# Information

## How to manually install
1. Go to your 'Saved games' quake folder, NOT THE STEAM FOLDER. You can go to it by pressing Windows+R and typing: `%userprofile%\Saved Games\Nightdive Studios\Quake`
2. If a folder called '`id1`' already exists, delete it.
3. Extract zip into the 'Saved games' folder.
4. Verify that `id1` and `mpmod` folder are now inside 'Saved games'.

## How to run the mod
**NOTE:** If you're using [QEThings MPMods](https://mpmods.qethings.xyz), follow the instructions for it instead.

1. Open console and type `game mpmod`
2. Start a multiplayer game. The mod will start automatically.

## Tweaking kills per level
By default you need to score 2 kills per weapon level, but you can change this by setting the console variable: `saved4`
For example if you want to set 5 kills per level then type `saved4 5`

## All weapons

|        Weapon | Description                                                                                         |
|--------------:|-----------------------------------------------------------------------------------------------------|
|           Axe | The good ol' axe. A lot more powerful now. (Only when it's the Axe level, otherwise regular damage) |
|       Shotgun |                                                                                                     |
| Super Shotgun |                                                                                                     |
|Nailgun|
|Super Nailgun|
|Grenade Launcher|
|Rocket Launcher|
|Lightning Gun|
|Flamethrower|Melt your enemies with flames! The closer you are to them, the more damage they take|
|Acid Spitter|Spit some acid that sticks to the floor and walls. Very corrosive to anyone who touches it|
|Laser Gun|Shoot 3 laser beams whenever you fire
|Railgun|Super high damage. Instantly kill anyone or anything. Try to line up enemies to kill all in one go.|

## Weapon sets
You can select from a few weapon sets, which define the levels and which weapons go for each level. You can set this via the `saved1` variable. For example, if you want Weapon Set 2, type in the console: `saved1 2`.

### 0 (Default / Vanilla)

| Level | Weapon           |
|:-----:|------------------|
|   1   | Lightning Gun    |
|   2   | Rocket Launcher  |
|   3   | Grenade Launcher |
|   4   | Super Nailgun    |
|   5   | Nailgun          |
|   6   | Super Shotgun    |
|   7   | Shotgun          |
|   8   | Axe              |

### 1 (All weapons)
| Level | Weapon           |
|:-----:|------------------|
|   1   | Railgun          |
|   2   | Lightning Gun    |
|   3   | Rocket Launcher  |
|   4   | Grenade Launcher |
|   5   | Laser Gun        |
|   6   | Super Nailgun    |
|   7   | Acid Spitter     |
|   8   | Nailgun          |
|   9   | Flamethrower     |
|  10   | Super Shotgun    |
|  11   | Shotgun          |
|  12   | Axe              |

### 2 (No Axe)
| Level | Weapon           |
|:-----:|------------------|
|   1   | Lightning Gun    |
|   2   | Rocket Launcher  |
|   3   | Grenade Launcher |
|   4   | Super Nailgun    |
|   5   | Nailgun          |
|   6   | Super Shotgun    |
|   7   | Shotgun          |

### 3 (Inverse)
| Level | Weapon           |
|:-----:|------------------|
|   1   | Axe              |
|   2   | Shotgun          |
|   3   | Super Shotgun    |
|   4   | Nailgun          |
|   5   | Super Nailgun    |
|   6   | Grenade Launcher |
|   7   | Rocket Launcher  |
|   8   | Lightning Gun    |

### 4 (Railgun only)
| Level | Weapon  |
|:-----:|---------|
|   1   | Railgun |

### 5 (Custom weapons only)
| Level | Weapon       |
|:-----:|--------------|
|   1   | Railgun      |
|   2   | Laser        |
|   3   | Acid Spitter |
|   4   | Flamethrower |
|   5   | Axe          |

## Server things

### Mapcycler
This mod features mapcycler config support. At the start of each map the following cfg will be executed: `mapcycler_qearmsrace.cfg`

Whenever the game decides to changelevel, it will run the following alias `nextmap_<current map name>`.

An example mapcycler would be:
```
alias "nextmap_dm4" "changelevel dm5"
alias "nextmap_dm5" "changelevel dm6"
alias "nextmap_dm6" "changelevel dm7"
alias "nextmap_dm7" "changelevel dm8"
alias "nextmap_dm8" "changelevel e1m2"
alias "nextmap_e1m2" "changelevel dm2"
alias "nextmap_dm2" "changelevel dm4"
```

## Credits
JPiolho: Author
