# Karol_Regula_William_Ostlund_Final_Project_2016_Spring

May 13, 2016

(Karol) Created the initial tabs, added some variables. So far, very basic structuring. Can make stations.

May 15, 2016

(Karol) Worked on Rail class, can now create a rail between two stations. Intergrated Rails into GameEngine class.

(Karol) Working on Train class, con now spawn a Train, Trains take a start Station and an end Station. Working on function that moves the train, so far it calculates the distance between the two stations. FIX: Offset the drawing of the rail startpoint and endpoint to center it on the station.

(Karol) Worked on train movement, created the draw() function which is now in charge of drawing and moving. Trains can now move endlessly between two stations. Their moveemnt is calculated based on the distance formula and the distance remaining to the station. Changed the order of drawing stuff to keep trains on top of rails. Train not yet properly rotated. Only one HARDCODED train exists so far.

May 16, 2016

(Karol) Worked on train movement and rail spawning in class, now all the stations are connected by rails, a train moves around them in a loop. Wrote plans for future classes in comments on in the main class.

(Will) Created an interface (Locatable) in order to create an effective class called Operations, it contains many key functions that we may end up using a lot. With the interface, both stations and rails can be called upon as a Locatable variable.

(Will) Created a functions designed to find the angle at which each rail is inclined. This will be useful in animating the trains along the line.

May 17, 2016

(Karol) Pull changes made by William, re-added looping train tracks, stopped train movement code from switching entire stations, sped up fps to 120 to decrease waiting time for while testing. Will attempt to merge.

May 18, 2016

(Karol) Added function that randomly spawns stations, disabled code that let the user create a station upon mouse click because it was causing null pointer exceptions.

(Will) Moved the original GameEngine class to a new one called TrainLine, this name is more appropriate and it allows us to place the real GameEngine in the tab. I also created a function that spawns stations where the user clicks, it has a built in timer as to prevent many stations from spawning on a single click.

May 19, 2016

(Will) Continued to work on the addStation function (this was the one I worked on yesterday).

(Karol) Worked on rotation logic, turns out to be more complicated than expected, set up basis for creation of more trainlines. Considering making stations in each trainline a doubly linked list.

May 20, 2016

(Karol) Made funcion that prints text based on a time limit. Clarified the purpose of the two butons on the side. One makes a new TrainLine, the other cylcles the current TrainLine to the next next one in the list. Based on the current TrainLine, the player will be able to connect stations with rails belonging to it.

(Karol) Worked on user interface, first button creates new trainLine and increments the counter visible to the user, second button cycles the current trainLine and turn its color to match. Each TrainLine now has its own color. Moved the trainLine creation out of Main into GameEngine class.

(Will) Started working on rail connection. This allows the user to use his/her mouse to select two stations and a rail will be built in between. It is triggered by a global variable that is also triggered by the click of a button. The distance formula is used to determine which Station is to be selected.

May 21, 2016

(Karol) Rails that are created by the user are in the color of the line to which they correspond to. The cycleLines button is now assumes the color of the active lines upon game startup, (previously it had to be clicked once for this to happen. Working on stopping the addition of rails from discriminating between randomly spawned and user made stations.

(Karol) Rail creation no longer discriminates between user made and randomly spawned stations, all new stations are added to the masterStationList in GameEngine. Moved rail creation code out of the draw function into a function in the GameENgine class. Will work on making trains run on each TrainLine now.

(Will) Improved the visual feedback for users. Before, the user would have a difficult time figuring out whether it is in range of buttons or not. Now colors change with mouse clicks and mouse hovers. It also affects stations that need to be selected to build rails in between.

May 22, 2016

(Karol) Fixed a whole bunch of errors with stuff not creating itself properly (i.e. Stations if the current TrainLine was changed), after that fixed errors with the display functions that only displayed stuff related to TrainLine #0.

(Karol) Added basic train spawning capabilities, next need to work on train AI, has to distinguish between circular and linear TrainLines and needs to know when to stop.

May 23, 2016

(Karol) Worked on TrainLine continuity, train deceleration, and waiting at stations. NOTE: All rails have to be built in the order the trains will travel (for now). Looped lines with 3+ stations work perfectly with one or many trains. Color coded the trains to match the TrainLines.

(Karol) Restricted the Trainlines to 5 unique Trainlines with predetermined colors. Increased station and train size. Changed background color.

(Will) Fixed a considerable error in the createRail() function (not really an error, more like a flaw). Before, our program would not match the fronts and backs of rails creating many discontinuities for the train's journey accross them. Now, the programs checks to see if the fronts and backs of rails match up before adding them into the train line.

May 24, 2016

(Karol) Worked on adding another type of station, turned out rails look uncentered on ellipse stations, had to add 4 cases of adjustment for rails. Each station has Txcor and Tycor variables that are offset properly to make sure the trains do not stray off the offset rails.

(Karol) Started to implement Passenger class, passengers are spawned at a random rate at all Stations using the spawnPassengers() function in GameEngine, the drawPassengers() function draws the passengers next to their respective stations. The passengers still need to be properly offset and need to be able to interact with trains.

(Will) Fixed a big flaw in the moveTrain() function, before our program treated every train line like a loop so when reaching the end of the station, a train would travel accross emptiness to the otherside of the train line. Now it knows to turn around and go to the other end the way it came from. I did this by creating an instance variable in the train (a boolean) called forward. This changes whenever it reaches the end of a linear trainline.

(Karol) Aesthetic changes to passengers at Stations, changed their size, spawn rate, color and created offsets that place them in the correct spot for both elliptical and rectangular stations. Also changed draw location for elliptical Passengers to make them line up with the rectangular ones.

(Karol) Created board() and deboard() functions for trains that are executed when the train reaches a Station. They cause respective passengers to first deboard and then passengers who can fit on the train will board(). Created a drawPassengersOnTrains() function that correctly draws the Passengers on the train in their positions. (They are a tiny bit squished even though I increased the size of the trains.) Made a change to draw(), all trains are now drawn separately after all rails and Stations have been drawn (previously was by line color). Revisions to moveTrains() function to stop it from executing deboard() several times per station. ---WHAT IS NOT DONE FOR PASSENGERS: Passengers do not know how to transfer between lines, square passengers will spawn at square stations (they will go to the next square station, this is intentionally left in,) same for circles.

May 25, 2016

(Karol) Changed Station aesthetics, strokeWeight changed to 4, color changed to white. (Small changes during class)

May 26, 2016

(Will) Changed the aesthetic of trains, now they are angled more correctly along the rails than they were previously. I also changed how they were drawn completely: before, they were just sketches, now they are actual PShapes. I used four vertices centered around the instance variables in the train class, xcor and ycor, along with some trigonometry (to calculate where they were according to the angle of the rail).

May 27, 2016

(Karol) Working on function that properly draws rails that are running parallel between the same stations (before they were drawn one on top on the other), the function, drawDuplicateRails(), as of now creates an ArrayList of ArrayLists of all the rail drawing conflicts. Now it just needs to draw them correctly. Also revised the paint() method for the rails, making it more future proof and cleaner. Created an alternate version of the method that will draw the rails by xcor/ycor (which can be offset slightly) rather than by station during conflict cases.

(Karol) Change to adding rails, now if the user clicks the Add Rail button while adding a rail (and previously having clicked the button to do so), railAdding will be canceled and all highlighted and stored stations that the rail adding function was using will be returned to normal.

(Karol) Worked on the random station spawning in spawnStations(), now the function checks if a another station is in the vicinity (radius) of the station it is trying to spawn and retires 100 times until it can find a spot. Stations can no longer spawn on top of each other.

(Karol) Created 3 stations that are always present upon game start. Changed the passenger boarding behavior, now passengers board and deboard one by one. (Not done in the cleanest way possible, I'll just make it use modulo if needed). Did some more work on function that offsets rails that are on top of one another.

(Will) Changed station sketched to PShapes (they look the same but are easier to use since many shapes that we may use in the future may require intricate designs that only PShapes can bring and all Stations should be the same).

(Will) Added highlighted versions of stations and the conditions in which these would be implemented (highlighted versions of stations are just bigger PShapes with a different color)

May 29, 2016

(Karol) Worked some more on rail separation, decided to finally leave it enabled. So far it works when 2 lines have their rails running parallel, and behaves unpredictable at some angles. In most cases it works well, I can't quite work out why it hates only a very specific angle. Removed duplicate train that was visible due to an additional rect() function in the train paint() function.

May 30, 2016

(Karol) Working on adding another shape to the array of stations. Removed rhombus, I think it can be easily confused with a sqaure when the train is traveling at an angle. Fixed all PShapes, they all lacked a createShape() function at the beginning. Partially implemented 3rd Station shape, a trangle, using the PSHape format. Created a rule for highlighting the triangle, will work on passenger and rail implementations in triangle stations next.

(Karol) Fully implemented traingle passengers. Changed the passenger display location for all station types (was too close to station in some cases). The rotated trains do not behave well on the rails since rectangles are drawn from a vertex, this and the issue of rotation must be adressed in the next class discussion.

(Karol) Small tweak, passengers no longer spawn at a station with the same type as them, this is possible since we now have 3 station types.

June 1, 2016

(Will) Tweaked the removeRail() function for looped train lines. Before problems existed whenever a rail was removed from a looped train line for almost all trains, now the only problem that occurs is when one of the trains is on top of the removed rail.

June 2, 2016

(Karol) Working on transferring of passengers between different lines. Made each station hold an array of lines that stop at it. Made each TrainLine actaully update its array of Stations (StationList[]) when adding a new Station.

(Karol) Worked on drawExtra() that I added in the last commit but didn't mention, fixed it, its purpose is to aid debugging, it draws the letter identifier of each trainLine that stops at a particular Station over that particular station.

(Karol) Each TrainLine has been supplumented with a typesHere<> ArrayList that lists all of the types of Station avalaibe at that TrainLine. TypesHere<> is similar to stopHere<> in stations (stopHere holds a list of TrainLines that stop at a particular Station).

(Karol) Now a Passenger will only board a Train if the TrainLine of that Train has a Station of the same shape the passenger is. Exceptions are made for passengers who need to use that TrainLine to transfer to another TrainLine. This has been accounted for in the board function, however, the Passengers are not yer able to compute their path to the target TrainLine through all the TrainLines they need transfers on. Additionally, Trains now have a referenceto which TrainLine they belong to.

(Karol) Minor commit, wrote method name, decided to work on it tomorrow, want to commit anyway so I don't have to rewrite the method name.



