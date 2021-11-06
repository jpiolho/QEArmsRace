# QEArmsRace
A multiplayer gamemode for Quake Enhanced similar to CSGO Arms Race 

## What is it?
This is a multiplayer deathmatch mod that adds a gameplay similar to CSGO Arms Race, where you go from powerful weapons all the way down to weakest.
The last person to score a kill after the last weapon level wins the game.

## How to install
1. Go to your 'Saved games' quake folder, NOT THE STEAM FOLDER. You can go to it by pressing Windows+R and typing: %userprofile%\Saved Games\Nightdive Studios\Quake
2. Create a folder called 'id1'
3. Create another folder and call it 'mpmod'. If you already have this folder, skip this step.
4. Extract zip into the 'id1' folder you created on step 2. If you already have an 'id1' folder, it's likely from another mod. Unfortunately, you'll have to replace it.

## How to run the mod
1. Open console and type 'game mpmod'
2. Start a multiplayer game

### Technical explanation
When you change to mpmod, it sets the root folder to be Saved Games, so next time the game goes into id1 it will use the files from Saved Games and override.

## Tweaking levels
By default you need to score 2 kills per weapon level, but you can change this by setting the console variable: `saved4`
For example if you want to set 5 kills per level then type `saved4 5`

## Credits
JPiolho: Author
