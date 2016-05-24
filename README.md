# Karol_Regula_William_Ostlund_Final_Project_2016_Spring

May 13, 2016

(Karol) Created the initial tabs, added some variables. So far, very basic structuring. Can make stations.

May 15, 2016

(Karol) Worked on Rail class, can now create a rail between two stations. Intergrated Rails into GameEngine class.

(Karol) Working on Train class, con now spawn a Train, Trains take a start Station and an end Station. Working on function that moves the train, so far it calculates the distance between the two stations. FIX: Offset the drawing of the rail startpoint and endpoint to center it on the station.

(Karol) Worked on train movement, created the draw() function which is now in charge of drawing and moving. Trains can now move endlessly between two stations. Their moveemnt is calculated based on the distance formula and the distance remaining to the station. Changed the order of drawing stuff to keep trains on top of rails. Train not yet properly rotated. Only one HARDCODED train exists so far.

May 16, 2016

(Will) Created an interface (Locatable) in order to create an effective class called Operations, it contains many key functions that we may end up using a lot. With the interface, both stations and rails can be called upon as a Locatable variable.

(Will) Created a functions designed to find the angle at which each rail is inclined. This will be useful in animating the trains along the line.

May 18, 2016

(Will) Moved the original GameEngine class to a new one called TrainLine, this name is more appropriate and it allows us to place the real GameEngine in the tab. I also created a function that spawns stations where the user clicks, it has a built in timer as to prevent many stations from spawning on a single click.

May 19, 2016
(Will) Continued to work on the addStation function (this was the one I worked on yesterday).

