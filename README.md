# Karol_Regula_William_Ostlund_Final_Project_2016_Spring

May 13, 2016

(Karol) Created the initial tabs, added some variables. So far, very basic structuring. Can make stations.

May 15, 2016

(Karol) Worked on Rail class, can now create a rail between two stations. Intergrated Rails into GameEngine class.

(Karol) Working on Train class, con now spawn a Train, Trains take a start Station and an end Station. Working on function that moves the train, so far it calculates the distance between the two stations. FIX: Offset the drawing of the rail startpoint and endpoint to center it on the station.

(Karol) Worked on train movement, created the draw() function which is now in charge of drawing and moving. Trains can now move endlessly between two stations. Their moveemnt is calculated based on the distance formula and the distance remaining to the station. Changed the order of drawing stuff to keep trains on top of rails. Train not yet properly rotated. Only one HARDCODED train exists so far.
