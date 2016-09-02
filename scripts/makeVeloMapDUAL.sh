#!/bin/bash
#
# Plots velocity vectors on Sierra Negra volcano
# Plots BOTH EN and UP vectors

# ===================================================================================== 

echo "Enter segment number (01-10):"
read SEGMENT	# Enter segment number 01 - 10

# ===================================================================================== 

	if [ ${SEGMENT} == 01 ]
	then 
		YR1=2008
		YR2=2009
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="01 JAN 08 - 31 DEC 08"
		VSCALE=0.015
		VSCALEUP=0.015 #0.01
		velScale=100

	elif [ ${SEGMENT} == 02 ]
	then 
		YR1=2009
		YR2=2010
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="01 JAN 09 - 31 DEC 09"
		VSCALE=0.011 #0.01
		VSCALEUP=0.0075 #0.01
		velScale=100
		
	elif [ ${SEGMENT} == 03 ]
	then 
		YR1=2010
		YR2=2010.41
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="01 JAN 10 - 27 MAY 10"
		VSCALE=0.009 #0.01
		VSCALEUP=0.005 #0.01
		velScale=100
		
	elif [ ${SEGMENT} == 04 ]
	then 
		YR1=2010.41
		YR2=2010.8
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="27 MAY 10 - 19 OCT 10"
		VSCALE=0.006 #0.01
		VSCALEUP=0.006 #0.01
		velScale=100
		
	elif [ ${SEGMENT} == 05 ]
	then 
		YR1=2010.8
		YR2=2011.5
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="19 OCT 10 - 02 JUL 11"
		VSCALE=0.015 #0.01
		VSCALEUP=0.012 #0.01
		velScale=100
		
	elif [ ${SEGMENT} == 06 ]
	then 
		YR1=2011.5
		YR2=2012
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="02 JUL 11 - 31 DEC 11"
		VSCALE=0.01 #0.01
		VSCALEUP=0.01 #0.01
		velScale=100
		
	elif [ ${SEGMENT} == 07 ]
	then 
		YR1=2012
		YR2=2012.4
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="01 JAN 12 - 26 MAY 12"
		VSCALE=0.011 #0.01
		VSCALEUP=0.011 #0.01
		velScale=100
				
	elif [ ${SEGMENT} == 08 ]
	then 
		YR1=2012.4
		YR2=2013.5
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="26 MAY 12 - 01 JUL 13"
		VSCALE=0.025 #0.01
		VSCALEUP=0.025 #0.01
		velScale=50
		
	elif [ ${SEGMENT} == 09 ]
	then 
		YR1=2013.5
		YR2=2014
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="01 JUL 13 - 31 DEC 13"
		VSCALE=0.004 #0.01
		VSCALEUP=0.003 #0.01
		velScale=250
		
	elif [ ${SEGMENT} == 10 ]
	then 
		YR1=2014
		YR2=2015
		FOLDER=S${SEGMENT}_${START}-${END}
		MESSAGE1="Segment ${SEGMENT}"
		MESSAGE2="01 JAN 14 - 31 DEC 14"
		VSCALE=0.012 #0.01
		VSCALEUP=0.012 #0.01
		velScale=100
		
	fi

# ===================================================================================== 

# set file directories
ps=Data/Segmented10/Plots/S${SEGMENT}_${YR1}-${YR2}.ps
stations=Data/SierraNegraStations/stationLocations.dat
mSource=Data/SierraNegraStations/source.dat
ENvelos=Data/Segmented10/S${SEGMENT}_${YR1}-${YR2}/Output/EN${YR1}-${YR2}.dat
UPvelos=Data/Segmented10/S${SEGMENT}_${YR1}-${YR2}/Output/UP${YR1}-${YR2}.dat
grid=Data/DEM/w001001.grd

# make folder for plots if it doesn't already exist
#if [ ! -d "$folder" ]; then
#    mkdir Data/Segmented10/Plots/S${SEGMENT}_${YR1}-${YR2}/
#fi

# set map extent and vector scale
west=-91.2 #-91.25
east=-91.05 #-91.00
south=-0.87
north=-0.765
JLong=90
tickBig=0.05
tickGrid=0

# set plot title
#title="Segment ${SEGMENT} (${VSCALE}) - GPS Velocities (${YR1}-${YR2})"

# set default fonts
gmt set FONT_TITLE 12p,Helvetica FONT 12p,Helvetica

# Draw basemap
gmt psbasemap -Jm${JLong} -R${west}/${east}/${south}/${north} -B${tickBig}g${tickGrid}:."${title}": -X2.0 -Y2.0 -P -K > $ps

# apply DEM (from Gorki Ruiz)
gmt grdimage $grid -Jm${JLong} -R${west}/${east}/${south}/${north} -E600 -M -B${tickBig}g${tickGrid}:."${title}": -P -O -K >> $ps

# plot stations and station labels
gmt psxy $stations -R -Jm${JLong} -Sc0.16 -G190 -W0.75 -P -O -K >> $ps # bottom half
#gmt psxy $mSource -R -Jm${JLong} -Sg0.16 -W1 -P -O -K >> $ps # bottom half

gmt pstext $stations -R -J -D0.2c/0 -F+f6p+jLM -O -K -N >> $ps

# draw velocity vectors 
gmt psvelo $ENvelos -Jm${JLong} -R -Se${VSCALE}/0.90/0 -D1.0 -P -O -K -Gred -W0.5 >> $ps
gmt psvelo $UPvelos -Jm${JLong} -R -Se${VSCALEUP}/0.90/0 -D1.0 -P -O -K -Gblue -W0.5 >> $ps

# plot velocity vector scale (EN)
gmt psvelo -Jm${JLong} -R -Se${VSCALE}/0.90/12 -P -O -K -D1.0 -Gred -W0.5 >> $ps << END
# lat    long E  W Eu Wu C  label  
-91.19 -0.856 ${velScale} 0 0 0 0
END

# plot velocity vector scale (UP)
gmt psvelo -Jm${JLong} -R -Se${VSCALEUP}/0.90/12 -P -O -K -D1.0 -Gblue -W0.5 >> $ps << END
# lat    long E  W Eu Wu C  label  
-91.19 -0.856 0 ${velScale} 0 0 0
END

# Plot velocity scale text label (black text)
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f14p+jLM -O -K -N << END >> $ps 
-91.195 -0.862	${velScale} mm/yr
END

# Plot message (black text)
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f10p+jLM -O -K -N << END >> $ps 
-91.196	-0.775	${MESSAGE1}
-91.196	-0.77	${MESSAGE2}
END

# create scale
gmt psbasemap -Jm${JLong} -R -L-91.08/-0.86/0/5+l -P -O >> $ps # bottom half

echo "saving as .png image..."
convert -trim -density 300 $ps Plots/FigurePictures/S${SEGMENT}_map.png
open $ps