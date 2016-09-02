#!/bin/bash
#
# Adjusts velocities for pseudo-linear plate motion
# 	Takes one file (file1) and removes its values from approprate columns in other files
#	Produces files to be read directly into GMT 

for i in 1 2 3 4 5 6 7 8 9 10 11 12 
do
	if [ ${i} == 1 ]
		then SEGMENT=01; START=2005.80; END=2006.48;
	elif [ ${i} == 2 ]
		then SEGMENT=02; START=2006.48; END=2008.00;
	elif [ ${i} == 3 ]
		then SEGMENT=03; START=2008.00; END=2009.00;
	elif [ ${i} == 4 ]
		then SEGMENT=04; START=2009.00; END=2010.00;
	elif [ ${i} == 5 ]
		then SEGMENT=05; START=2010.00; END=2010.41;
	elif [ ${i} == 6 ]
		then SEGMENT=06; START=2010.41; END=2010.80;
	elif [ ${i} == 7 ]
		then SEGMENT=07; START=2010.80; END=2011.50;
	elif [ ${i} == 8 ]
		then SEGMENT=08; START=2011.50; END=2012.02;
	elif [ ${i} == 9 ]
		then SEGMENT=09; START=2012.02; END=2012.40;
	elif [ ${i} == 10 ]
		then SEGMENT=10; START=2012.40; END=2013.50;
	elif [ ${i} == 11 ]
		then SEGMENT=11; START=2013.50; END=2014.00;
	elif [ ${i} == 12 ]
		then SEGMENT=12; START=2014.00; END=2015.30;
	fi

file1=../Data/GLPS.dat	  # Nazca plate motion
file2=../Data/SegmentedTS/${START}-${END}/velocities.dat
file3=../Data/SegmentedTS/Velocities/S${SEGMENT}adjustedVelosEN.dat
file4=../Data/SegmentedTS/Velocities/S${SEGMENT}adjustedVelosUP.dat
file5=../Data/SierraNegraStations/stationLocations.dat

# Assign GLPS velocity values to 'local' variables 
east=`awk '{a=$2;print a}' $file1`
north=`awk '{a=$3;print a}' $file1`
up=`awk '{a=$4;print a}' $file1`

# Join files on 'station name' column 
join -1 3 -2 1 $file5 $file2 > tempVelo.dat

# Writes new files for EN and UP vectors
awk -v OFS='\t' -v e="${east}" -v n="${north}" '{ print $2, $3, $4-e, $5-n, $7, $8, $1 }' tempVelo.dat > $file3
awk -v OFS='\t' -v u="${up}" '{ print $2, $3, 0, $6-u, 0.1, $9, $1 }' tempVelo.dat > $file4

rm tempVelo.dat
done