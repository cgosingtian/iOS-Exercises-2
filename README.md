iOS-Exercises-2-Air-Raid
========================

Top-down shooter "Air Raid": iOS exercises post-exam, implemented in a game. Exercise topics handled are listed in the README file.

70% complete; remaining: Spawn enemy ships, implement collision, air bomb.
Optional target: ground enemies, ground bullets

----- Object Details and Relationships -----
[Controllers]
Battle View Controller
 - main view controller, sets up game elements in a XIB file.
    - creates 1 Player Ship View
    - creates 4 Cloud Views
    - creates 1 Background View
 - Instantiates Player Controller
    - For each Turret in Player's Ship, instantiate Turret Controllers
 - Has Touch Control Recognition (Long Press and Swipe)
    - Delegates control to Player Controller

Player Controller
 - Instantiates Player Ship and Player
 - Performs Player Ship movement (touch control comes Battle View Controller)
     - Instructs Player Ship View to animate when necessary

Turret Controller
 - Creates Bullet Controllers based on Turret data (firing speed, bullet type, etc)
    - Repeatedly creates and releases Bullet Controllers per Bullet
 - Ensures that Bullet Controllers are fired from the Player Ship that owns the Turret

Bullet Controllers
 - Creates a Bullet View from a Bullet
 - Handles the Bullet's movement
 - Plays a sound when a Bullet is fired

[Views]
Ship View
 - Contains method for moving View frame

Player Ship View : Ship View
 - Animates movement of Player Ship

Bullet View
 - Displays and animates Bullets created by Bullet Controller

[Models]
Ship
 - Owns a mutable array of Turrets
 - Contains health, air bombs, velocity, coordinates, points awarded (if enemy), "is player" flag

Turret
 - Weak reference to Ship (that owns it) and Bullet
 - Contains turret type, firing speed and angle data

Bullet
 - Contains velocity, damage, "is air bullet" flag, "is player bullet" flag, bullet type

Player
 - Contains score and name

Miscellaneous Views:
Cloud View
 - UIImageView with cloud graphic, set up in Battle View Controller's XIB
 - Core animation translates it downward, fading in and out over its lifetime
 - Respawns at a random location and with a random size (width is always 2.5x height) after animation

Background View
 - UIImageView with floor graphic, set up in Battle View Controller's XIB
 - Manual animation through NSTimer and a repeating selector
 - Resets its location before the whole image is traversed to create a fake "unlimited floor" effect

----- EXERCISE TOPICS ADDRESSED -----
1. Non-ARC Memory Management
2. Animations
  - View Animation: (KLBCloudView, KLBBackgroundView)
  - UIImageView Animation: (KLBBulletView)
  - Core Animation: (KLBPlayerShipView)
3. Custom Font: (KLBBattleViewController.xib)
4. Audio (AVAudioPlayer): (KLBBulletController)
5. MVC
6. Blocks: (KLBBulletView, KLBCloudView - mostly in animations)
