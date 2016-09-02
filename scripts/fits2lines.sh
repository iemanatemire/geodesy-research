#!/bin/bash
#

comp="u"
folder=../Data/SegmentedTS/LinearFits/Sites

for j in 1 2 3 4 5 6 7 8 9 10
do
	if [ ${j} == 1 ]
		then site="GV01"

	elif [ ${j} == 2 ]
		then site="GV02"

	elif [ ${j} == 3 ]
		then site="GV03"	

	elif [ ${j} == 4 ]
		then site="GV04"	

	elif [ ${j} == 5 ]
		then site="GV05"	

	elif [ ${j} == 6 ]
		then site="GV06"	

	elif [ ${j} == 7 ]
		then site="GV07"	

	elif [ ${j} == 8 ]
		then site="GV08"	

	elif [ ${j} == 9 ]
		then site="GV09"	

	elif [ ${j} == 10 ]
		then site="GV10"
fi
rm ../Data/SegmentedTS/LinearFits/${comp}${site}.dat
outFile=../Data/SegmentedTS/LinearFits/${comp}${site}.dat
echo "Site:" $site

for i in 1 2 3 4 5 6 7 8 9 10 11 12
do
	if [ ${i} == 1 ]
		then seg="S01"

	elif [ ${i} == 2 ]
		then seg="S02"

	elif [ ${i} == 3 ]
		then seg="S03"	

	elif [ ${i} == 4 ]
		then seg="S04"	

	elif [ ${i} == 5 ]
		then seg="S05"	

	elif [ ${i} == 6 ]
		then seg="S06"	

	elif [ ${i} == 7 ]
		then seg="S07"	

	elif [ ${i} == 8 ]
		then seg="S08"	

	elif [ ${i} == 9 ]
		then seg="S09"	

	elif [ ${i} == 10 ]
		then seg="S10"

	elif [ ${i} == 11 ]
		then seg="S11"

	elif [ ${i} == 12 ]
		then seg="S12"
fi
echo "seg: " $seg
# i determines from which file numbers are pulled
file=${folder}/${seg}${comp}.dat

# Print dates and displacements to file
awk -v site="${site}" '{ if ($1 == site) {print $2, $4} }' $file >> $outFile
awk -v site="${site}" '{ if ($1 == site) {print $3, $5} }' $file >> $outFile

done

done