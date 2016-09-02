#!/bin/bash
#
# Adjusts velocities for pseudo-linear plate motion and
# converts file to format suitable for input to dMODELS

for i in 1 2 3 4 5 6 7 8 9 10 11 12 
do
	if [ ${i} == 1 ]
		then SEGMENT=01; START=2005.80; END=2006.48;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 28 OCT 05 - 24 JUN 06"'
	elif [ ${i} == 2 ]
		then SEGMENT=02; START=2006.48; END=2008.00;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 25 JUN 06 - 31 DEC 07"'
	elif [ ${i} == 3 ]
		then SEGMENT=03; START=2008.00; END=2009.00;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 08 - 31 DEC 08"'
	elif [ ${i} == 4 ]
		then SEGMENT=04; START=2009.00; END=2010.00;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 09 - 31 DEC 09"'
	elif [ ${i} == 5 ]
		then SEGMENT=05; START=2010.00; END=2010.41;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 10 - 30 MAY 10"'
	elif [ ${i} == 6 ]
		then SEGMENT=06; START=2010.41; END=2010.80;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 31 MAY 10 - 19 OCT 10"'
	elif [ ${i} == 7 ]
		then SEGMENT=07;	START=2010.80; END=2011.50;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 20 OCT 10 - 02 JUL 11"'
	elif [ ${i} == 8 ]
		then SEGMENT=08; START=2011.50; END=2012.02;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 03 JUL 11 - 06 JAN 12"'
	elif [ ${i} == 9 ]
		then SEGMENT=09; START=2012.02; END=2012.40;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 07 JAN 12 - 26 MAY 12"'
	elif [ ${i} == 10 ]
		then SEGMENT=10;	START=2012.40; END=2013.50;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 27 MAY 12 - 01 JUL 13"'
	elif [ ${i} == 11 ]
		then SEGMENT=11; START=2013.50; END=2014.00;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 02 JUL 13 - 31 DEC 13"'
	elif [ ${i} == 12 ]
		then SEGMENT=12; START=2014.00; END=2015.30;
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 14 - 11 APR 15"'
	fi

#====================================================================================
echo "Processing segment: ${SEGMENT} ..."
glps=../Data/GLPS.dat
velos=../Data/SegmentedTS/${START}-${END}/velocities.dat
stations=../Data/SierraNegraStations/stationLocationsUTM.dat
output=../Data/SegmentedTS/Analysis/S${SEGMENT}_dModels.dat

# Assign GLPS velocity values to 'local' variables 
east=`awk '{a=$2;print a}' $glps`
north=`awk '{a=$3;print a}' $glps`
up=`awk '{a=$4;print a}' $glps`

# Join files on 'station name' column
join -1 1 -2 1 $stations $velos > tempVelo.dat

# Print VENT line
echo ${MESSAGE} > $output								
echo "%SITE	X(UTM)	Y(UTM)	E(m)	StdE(m)	N(m)	StdN(m)	U(m)	StdU(m)" >> $output
echo "VENT	0	0	9.999	9.999	9.999	9.999	9.999	9.999" >> $output

# Writes new files for EN and UP vectors
awk -v OFS='\t' -v e="${east}" -v n="${north}" -v u="${up}" '{printf "%s\t%.1f\t%.1f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\n", $1, $2, $3, ($4-e)/1000, $7/1000, ($5-n)/1000, $8/1000, ($6-u)/1000, $9/1000}' tempVelo.dat >> $output

rm tempVelo.dat
done