The script contained in the file "run_analysis.R" will allow you to obtain a tidy data set of several smartphone sensors measurements.
The script will download the data from the web and will store the results in the folder that contains it.

The resulting data frame it is called "dataSet" will contain 6 variables:
- subject (integer): Indicates the subject ID
- activity_code (integer): Indicates the activity (number-coded)
- sensor (character): Contains the name of the variable measured by a particular sensor.
The variables containing a strings "total" and "acc" in the name indicates the acceleration signal from the smartphone accelerometer in standard gravity units 'g'. Each variable indicates in which axis the acceleration has been recorded (x,y or z). 
The string "body" and "acc" in the name of the variable indicates the acceleration signal obtained by subtracting the gravity from the total acceleration. 
The string "gyro" in the name of the variable indicates the angular velocity vector measured by the gyroscope. The units are radians/second. 
- Value (double): Contains the values of each variable in each case.
- dataSet (character): Indicates the origin of the data ("train" or "test" data sets)
 
