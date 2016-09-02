#!/bin/bash
#
# Adjusts velocities for pseudo-linear plate motion
# 	Takes one file (file1) and removes its values from approprate columns in other files
#	Produces files to be read directly into GMT 


# Choose segment (Number between 01 ~ 10)

#SEGMENT=04	# 01 - 10 (lead zeros are important)
#COMP=EN		# EN or UP

#echo "Enter segment number (01-10):"
#read SEGMENT	# Enter segment number 01 - 10

#echo "Enter component (EN or UP):"
#read COMP	# Enter component (EN or UP)

MODEL=sill #sphere or sill
COMP=EN
fNf=FI

# NF or FI
# These dates are correct

for i in 1 2 3 4 5 6 7 8 9 10 11 12 
do
	if [ ${i} == 1 ]
	then 
		SEGMENT=01
		START=2005.80
		END=2006.48
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 28 OCT 05 - 24 JUN 06"'

	elif [ ${i} == 2 ]
	then 
		SEGMENT=02
		START=2006.48
		END=2008.00
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 24 JUN 06 - 01 JAN 08"'
		
	elif [ ${i} == 3 ]
	then 
		SEGMENT=03
		START=2008.00
		END=2009.00
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 08 - 01 JAN 09"'
		
	elif [ ${i} == 4 ]
	then 
		SEGMENT=04
		START=2009.00
		END=2010.00
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 09 - 01 JAN 10"'
		
	elif [ ${i} == 5 ]
	then 
		SEGMENT=05
		START=2010.00
		END=2010.41
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 10 - 30 MAY 10"'
		
	elif [ ${i} == 6 ]
	then 
		SEGMENT=06
		START=2010.41
		END=2010.80
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 30 MAY 10 - 19 OCT 10"'
		
	elif [ ${i} == 7 ]
	then
		SEGMENT=07 
		START=2010.80
		END=2011.50
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 19 OCT 10 - 02 JUL 11"'
		
	elif [ ${i} == 8 ]
	then 
		SEGMENT=08
		START=2011.50
		END=2012.02
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 02 JUL 11 - 06 JAN 12"'
		
	elif [ ${i} == 9 ]
	then 
		SEGMENT=09
		START=2012.02
		END=2012.40
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 06 JAN 12 - 26 MAY 12"'
		
	elif [ ${i} == 10 ]
	then
		SEGMENT=10 
		START=2012.40
		END=2013.50
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 26 MAY 12 - 01 JUL 13"'

	elif [ ${i} == 11 ]
	then 
		SEGMENT=11
		START=2013.50
		END=2014.00
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JUL 13 - 01 JAN 14"'

	elif [ ${i} == 12 ]
	then 
		SEGMENT=12
		START=2014.00
		END=2015.30
		MESSAGE='"Segment '${SEGMENT}' - GPS Displacements from 01 JAN 14 - 11 APR 15"'
		
	fi


echo "----------------------------"
echo "Processing: S${SEGMENT}, ${COMP}, ${MODEL}..."

#====================================================================================

if [ ${fNf} == "FI" ]
	then modelVelos=../Data/SegmentedTS/Analysis/Analysis/${MODEL}/resultsFixed/S${SEGMENT}_dModels.rsl

elif [ ${fNf} == "NF" ]
	then modelVelos=../Data/SegmentedTS/Analysis/Analysis/${MODEL}/resultsFree/S${SEGMENT}_dModels.rsl
fi

outputEN=../Data/SegmentedTS/ModelVelocities/S${SEGMENT}_${MODEL}ENvelos${fNf}.dat  	# output file
outputUP=../Data/SegmentedTS/ModelVelocities/S${SEGMENT}_${MODEL}UPvelos${fNf}.dat  	# output file
stations=../Data/SierraNegraStations/stationLocations.dat

# Join files on 'station name' column (i.e., only gives lat and long of stations represented in file)

# Cuts header off of matlab output and prints to a temp file
awk 'NR>7' ${modelVelos} > tempModelVelos.dat
join -1 3 -2 1 $stations tempModelVelos.dat > tempVelos.dat

# Writes new files for EN and UP vectors
awk -v OFS='\t' '{ print $2, $3, $7*1000, $10*1000, 0, 0, $1 }' tempVelos.dat > $outputEN
awk -v OFS='\t' '{ print $2, $3, 0, $13*1000, 0, 0, $1 }' tempVelos.dat > $outputUP

echo "Removing temporary velocity files (tempVelo.dat & tempModelVelos.dat)..."
rm tempVelos.dat
rm tempModelVelos.dat

done