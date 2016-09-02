#!/bin/bash
#
# Splits time series files into smaller segments based on input

# Location of time series data
tseries01=../Data/SierraNegraGPS/GV01.tseries
tseries02=../Data/SierraNegraGPS/GV02.tseries
tseries03=../Data/SierraNegraGPS/GV03.tseries
tseries04=../Data/SierraNegraGPS/GV04.tseries
tseries05=../Data/SierraNegraGPS/GV05.tseries
tseries06=../Data/SierraNegraGPS/GV06.tseries
tseries07=../Data/SierraNegraGPS/GV07.tseries
tseries08=../Data/SierraNegraGPS/GV08.tseries
tseries09=../Data/SierraNegraGPS/GV09.tseries
tseries10=../Data/SierraNegraGPS/GV10.tseries
tseries11=../Data/SierraNegraGPS/GLPS.tseries

echo "Enter start year"
read START #2012.45

echo "Enter end year"
read END   #2013.30

# Set working di
newFolder=../Data/SegmentedTS/${START}-${END}

if [ ! -d "${newFolder}" ]; then
    mkdir ${newFolder}
fi

for i in 1 2 3 4 5 6 7 8 9 10 11
do
    if [ ${i} == 1 ]
        then tseries=${tseries01}; ps=${newFolder}/GV01.tseries;
    elif [ ${i} == 2 ]
        then tseries=${tseries02}; ps=${newFolder}/GV02.tseries;
    elif [ ${i} == 3 ]
        then tseries=${tseries03}; ps=${newFolder}/GV03.tseries;
    elif [ ${i} == 4 ]
        then tseries=${tseries04}; ps=${newFolder}/GV04.tseries;
    elif [ ${i} == 5 ]
        then tseries=${tseries05}; ps=${newFolder}/GV05.tseries;
    elif [ ${i} == 6 ]
        then tseries=${tseries06}; ps=${newFolder}/GV06.tseries;
    elif [ ${i} == 7 ]
        then tseries=${tseries07}; ps=${newFolder}/GV07.tseries;
    elif [ ${i} == 8 ]
        then tseries=${tseries08}; ps=${newFolder}/GV08.tseries;
    elif [ ${i} == 9 ]
        then tseries=${tseries09}; ps=${newFolder}/GV09.tseries;
    elif [ ${i} == 10 ]
        then tseries=${tseries10}; ps=${newFolder}/GV10.tseries;
    elif [ ${i} == 11 ]
        then tseries=${tseries11}; ps=${newFolder}/GLPS.tseries;
    fi

    for line in $tseries
    do
        awk '{ if($1 >= '${START}' && $1 < '${END}' ) print $1, $2, $3, $4, $5, $6, $7}' ${line} >> $ps
    done
done
echo "Done!"