# Project Description
For my final CS50G project, I created a short-form farming game with Love2D called 30 Second Farm. The premise of the game is to plant and collect as many plants as you can in a (30 second) day while avoiding two moles that randomly pop up around the garden. At the end of a day, you place your harvest in a collection chest and gain experience based on the number and type of plants you've collected. You have three lives per day, and if you run into a mole three times, that's game over. Each level that you reach introduces a new type of plant. You win when you've leveled up 9 times, having found and collected all of the 8 types of plants.  

I used a state machine rather than a state stack to control the flow between the start, play, game over, and you won states, as well as between day transitions. There were a few instances where a state stack would have been appropriate, such as the how-to menu pop-up, but I felt more familiar with the state machine system. There were several times I made a decision like this during development where a slightly more light-weight data structure would have saved me time and efficiency, but I wanted to stick with what I know for now. 

Other such times were when tiling the farm, creating a grid structure for the garden and moles, and formatting the how-to text box. When tiling the farm, I could have created a table that told the farm or play state if a specific coordinate should be grass, dirt, a fence, or the chest, but instead I placed them all on the farm separately/individually. The grid for the garden was complicated by the fact that the plant, player, and mole sprites were all different sizes. I think it all looks good/works well considering that, but all interactions between those three types of entities had to work around that fact. For example, I couldn't do collisions based solely on grid position, and there were a few places where I had to translate back and forth between grid position and x,y position. Lastly for the how-to text box, I was tempted to create a text class that worked similarly to the paneling in CS50G Pokemon that broke a long string into chunks, but untimitely I ended up formatting it manually so I could have things like bullet points and different line-spacings.

There were several places I wanted to use Timer.every or Timer.after, and I ended up making a timer manually. I'm not sure if the buggy behavior was about where I was placing the timers (i.e. in an update function rather than in an init or enter function), or where I was calling Timer.update or Timer.clear, but regardless, I had several manually timers piled up by the end. I also ended up using Events to get around some of this bugginess wihch worked out really well. For example, when I couldn't get a state change to happen inside a timer block, I dispatched an event that triggered the state change instead.

I really enjoyed figuring out the algorithms for planting and growing seeds, mole animations, leveling up, and day transitions. Similar concepts from previous projects were really helpful to have in mind throughout the process, but the details were different enough that I was excited with the process of creating something from scratch.


# Game how-to:
- Head to the garden each morning
- Plant and collect as many vegetables from your garden as you can without running into moles before the day is done (Press p to plant a seed)
- Place your day’s harvest in the bin (Press i to deposit inventory)
- Another day begins
- Discover all 8 plants to win!
- In game, press m to return to the main menu


# Future features:
- Wiggle plants once grown
- Smoke coming out of chimney
- Open backpack and view the amt of each type of plant or total plant pop-up as they go into chest - pop-up overlay
- Adjust planting in down direction
- Make higher level plants more rare
- Blinking press enter buttons on game over and you won screens
- Make leveling-up more challenging


# Credits:

### Inspirations:
- Js wack-a-mole - https://github.com/0shuvo0/whack-a-mole/blob/main/main.js 
- Darkest Moon by Jesse Millar - https://jessemillar.itch.io/darkest-moon 
### Art:
- House: Stardew Valley
- Mole by ParaKoopa: https://www.spriters-resource.com/fullview/17849/ 
- Plants: https://www.deviantart.com/love4fluffy/art/Stemlin-Cultivated-Plant-Sprites-724608640
- All other art from previous CS50G projects
### Music:
- [Start Menu]: Cipher2 by Kevin MacLeod | https://incompetech.com/ Music promoted by https://www.chosic.com/free-music/all/ Creative Commons CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
- [Game Over]: Good Fellow: https://www.chosic.com/free-music/all/ 
- [In Game]: Move Forward by Kevin MacLeod | https://incompetech.com/ Music promoted by https://www.chosic.com/free-music/all/ Creative Commons CC BY 3.0 https://creativecommons.org/licenses/by/3.0/
### Fonts:
- Credits in graphics directory
