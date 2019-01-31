## 50.002 - 1D Game Project
# Bing Bong Pong

![images/poster - how to play](https://github.com/cmetramexs/50.002_COMPSTRUCT/tree/master/images/poster.jpg)

*CI03 Group 5*  
Andre Hadianto Lesmana | Antonio Miguel Canlas Quizon | Sarthak Ganoorkar | Yee Celine

### Bing Bong Pong
This game was inspired by one of the earliest graphical game called Ping Pong. We adapted the
2D aspect of the game and implement it with a twist as 1D instead. In 1D, the ball only travels in
a straight line. In our implementation of the game, we used only binary system for all the
functions and features available on our game.<br/>
Under the given constraints, our team considered several game ideas, all of which involved the
clock signal of the FPGA, carefully-designed patterns, and how the game could appeal to players
aesthetically and in an engaging manner. 

### Game Description
Bing Bong Pong is an interactive 2-player game that tests each player’s ability to react to visual
stimuli through a high intensity, fast-paced game.<br/>
The game consists of a start button, a return button for each player, and a 1 x 16 LED Matrix to
represent the ball’s trajectory track. The LED Matrix has four green LEDs, two on each side, that
represents the safezone for each player. The buttons act as a ‘virtual paddle’ for each player,
which can deflect the ball when pressed on the safezone.<br/>
Player 1 serves first and player 2 will have a short period of time to return the serve by pressing
Player 2’s button when the ball reach the safezone. As the rally progress, the ball’s speed will
change at random and when either players miss the safezone, the player will lose a life. Each
players start with 3 lives.

### Test Scenarios
Functional Test Scenarios:
1. Check that the ball can be shifted left or right, using the ALU’s SHL/SHR functions.
2. The ball can be returned after pressing a player’s button.
3. Not pressing the button as the ball reaches safezone.
4. Pressing the button before the ball reaches safezone
5. Pressing the button on the other player’s turn
6. Both players return consecutively >= 3 times to increase the ball’s speed randomly.

Gameplay Test Scenarios:
1. A player loses a life, if button was not pressed.
2. A player loses a life, if button was pressed too early, or not in his/her turn.
3. A player loses a game after losing all 3 lives
4. Game goes back to IDLE/MENU after a player loses.
5. Pressing the Start button while game is still ongoing.
6. Pressing the button when a player loses a life i.e. ball should start from loser’s side.

### User Manual
Rules:
1. Each player starts with three lives, the first player to lose all lives loses the game.
2. Each player is assigned to a dedicated safe zone.
3. The player has to press the button when the ball enters their safe zone
4. The player loses a life if he/she fails to press the button when the ball is inside the
safezone.
5. As the rally progresses, the ball will change to move at random speeds to increase the
difficulty.

### Game Design
The game table will have a 16 bit LED matrix to represent the movement of the ball. The LEDs
harbored by the safezone are red and the rest are green . When the game starts, both buttons
for player 1 and player 2 will be enabled and the 3 LEDs next to each button will light up which
represents the current lives of each player. Player 1 gets to start the game by pressing the start
button. When the button is pressed, the LED next to the safe zone will turn green and start
shifting towards player 2. If player 2 presses his button when the ball is still green, player 2
loses a life, otherwise the led next to the safezone will turn green and start shifting towards
player 1. Player loses when he or she loses all three lives. As the game progresses, the shifting
speed will vary to increase the difficulty.

---