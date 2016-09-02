#!/bin/bash
#
# Plots velocity vectors on Sierra Negra volcano
# Plots BOTH EN and UP vectors

# ===================================================================================== 

#echo "Enter segment number (01-10):"
#read SEGMENT	# Enter segment number 01 - 10

#echo "Enter component (EN or UP):"
#read COMP	# Enter component (EN or UP)

COMP=UP
MODEL=Sill

echo "Starting loop..."

for i in 8
do
	if [ ${i} == 1 ]
	then 
		SEGMENT=01
		YR1=2005.80
		YR2=2006.48
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="28 OCT 05 - 24 JUN 06"
		VSCALE=0.0065
		VSCALEUP=0.0065 #0.01
		velScale=250

	elif [ ${i} == 2 ]
	then 
		SEGMENT=02
		YR1=2006.48
		YR2=2008.00
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="24 JUN 06 - 01 JAN 08"
		VSCALE=0.011 #0.01
		VSCALEUP=0.006 #0.01
		velScale=100
		
	elif [ ${i} == 3 ]
	then 
		SEGMENT=03
		YR1=2008.00
		YR2=2009.00
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="01 JAN 08 - 01 JAN 09"
		VSCALE=0.015
		VSCALEUP=0.015 #0.01
		velScale=100
		
	elif [ ${i} == 4 ]
	then 
		SEGMENT=04
		YR1=2009.00
		YR2=2010.00
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="01 JAN 09 - 01 JAN 10"
		VSCALE=0.015 #0.01
		VSCALEUP=0.0075 #0.01
		velScale=100
		
	elif [ ${i} == 5 ]
	then 
		SEGMENT=05
		YR1=2010.00
		YR2=2010.41
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="01 JAN 10 - 30 MAY 10"
		VSCALE=0.009 #0.01
		VSCALEUP=0.005 #0.01
		velScale=100
		
	elif [ ${i} == 6 ]
	then 
		SEGMENT=06
		YR1=2010.41
		YR2=2010.80
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="30 MAY 10 - 19 OCT 10"
		VSCALE=0.008 #0.01
		VSCALEUP=0.006 #0.01
		velScale=100
		
	elif [ ${i} == 7 ]
	then 
		SEGMENT=07
		YR1=2010.80
		YR2=2011.50
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="19 OCT 10 - 02 JUL 11"
		VSCALE=0.015 #0.01
		VSCALEUP=0.012 #0.01
		velScale=100
				
	elif [ ${i} == 8 ]
	then 
		SEGMENT=08
		YR1=2011.50
		YR2=2012.02
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="02 JUL 11 - 06 JAN 12"
		VSCALE=0.1 #0.01
		VSCALEUP=0.1 #0.01
		velScale=10
		
	elif [ ${i} == 9 ]
	then 
		SEGMENT=09
		YR1=2012.02
		YR2=2012.40
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="06 JAN 12 - 26 MAY 12"
		VSCALE=0.011 #0.01
		VSCALEUP=0.011 #0.01
		velScale=100
		
	elif [ ${i} == 10 ]
	then 
		SEGMENT=10
		YR1=2012.40
		YR2=2013.50
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="26 MAY 12 - 01 JUL 13"
		VSCALE=0.025 #0.01
		VSCALEUP=0.025 #0.01
		velScale=50
		
	elif [ ${i} == 11 ]
	then 
		SEGMENT=11
		YR1=2013.50
		YR2=2014.00
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="01 JUL 13 - 01 JAN 14"
		VSCALE=0.004 #0.01
		VSCALEUP=0.003 #0.01
		velScale=250
		
	elif [ ${i} == 12 ]
	then 
		SEGMENT=12
		YR1=2014.00
		YR2=2015.30
		FOLDER=${YR1}-${YR2}
		MESSAGE1="Segment ${SEGMENT} - ${MODEL}"
		MESSAGE2="01 JAN 14 - 11 APR 15"
		VSCALE=0.015 #0.01
		VSCALEUP=0.013 #0.01
		velScale=100
		
	fi

echo "----------------------------"
echo "Processing: S${SEGMENT}, ${COMP}, ${MODEL}..."	
	
# ===================================================================================== 

velos=../Data/SegmentedTS/Velocities/S${SEGMENT}adjustedVelos${COMP}.dat
fixed=../Data/SegmentedTS/ModelVelocities/S${SEGMENT}_${MODEL}${COMP}VelosFI.dat
basic=../Data/SegmentedTS/ModelVelocities/S${SEGMENT}_${MODEL}${COMP}VelosNF.dat


# ===================================================================================== 
# set file directories
ps=../Plots/ps/veloFields/S${SEGMENT}_${MODEL}s${COMP}.ps
pic=../Plots/png/veloFields/S${SEGMENT}_${MODEL}s${COMP}.png

stations=../Data/SierraNegraStations/stationLocations.dat
mSource=../Data/SierraNegraStations/source.dat
grid=../Data/DEM/w001001.grd
# =====================================================================================

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
#gmt psxy $mSource -R -Jm${JLong} -Sg0.16 -Gyellow -W0.75 -P -O -K >> $ps # bottom half

gmt pstext $stations -R -J -D0.2c/0 -F+f6p+jLM -O -K -N >> $ps

# ===================================================================================== 
# Plot boxes for cities
#gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -Sc0.21 -Gyellow -W0.75 -P -O -K << END >> $ps
#-91.1766	-0.796
#END

# Plot misc names in standard font
#gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f8p+jLM -O -N -K << END >> $ps 
#-91.1912	-0.796	Fixed Source
#END


# plot velocity vector scale to show model colors
gmt psvelo -Jm${JLong} -R -Se0.03/0.90/8 -P -O -K -D1.0 -Gblack -W0.5 >> $ps << END
# long lat E  W Eu Wu C  label  
-91.18 -0.781 20 0 0 0 0 GPS
END

# plot velocity vector scale to show model colors
gmt psvelo -Jm${JLong} -R -Se0.03/0.90/8 -P -O -K -D1.0 -Gred -W0.5 >> $ps << END
# lat    long E  W Eu Wu C  label  
-91.18 -0.786 20 0 0 0 0 Fixed Model
END

# plot velocity vector scale to show model colors
gmt psvelo -Jm${JLong} -R -Se0.03/0.90/8 -P -O -K -D1.0 -Gblue -W0.5 >> $ps << END
# lat    long E  W Eu Wu C  label  
-91.18 -0.791 20 0 0 0 0 Free Model
END

# Plot velocity scale text label (black text)
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f14p+jLM -O -K -N << END >> $ps 
-91.195 -0.862	${velScale} mm/yr
END

# Plot message (black text) at top left of plot
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f10p+jLM -O -K -N << END >> $ps 
-91.196	-0.775	${MESSAGE1}
-91.196	-0.77	${MESSAGE2}
END

# create scale
gmt psbasemap -Jm${JLong} -R -L-91.08/-0.86/0/5+l -P -O -K >> $ps # bottom half

# ===================================================================================== 
echo "vectors and scales..."
if [ ${COMP} == EN ]
then 

# draw velocity vectors 
gmt psvelo $velos -Jm${JLong} -R -Se${VSCALE}/0.90/0 -D1.0 -P -O -K -Gblack -W0.5 >> $ps
gmt psvelo $fixed -Jm${JLong} -R -Se${VSCALEUP}/0.90/0 -D1.0 -P -O -K -Gred -W0.5 >> $ps
gmt psvelo $basic -Jm${JLong} -R -Se${VSCALEUP}/0.90/0 -D1.0 -P -O -K -Gblue -W0.5 >> $ps
		
# plot velocity vector scale (EN)
gmt psvelo -Jm${JLong} -R -Se${VSCALE}/0.90/12 -P -O -K -D1.0 -Gblack -W0.5 >> $ps << END
# long lat E  W Eu Wu C  label  
-91.19 -0.856	${velScale}	0 0 0 0
END
	
elif [ ${COMP} == UP ]
then 
		
# draw velocity vectors 
gmt psvelo $velos -Jm${JLong} -R -Se${VSCALEUP}/0.90/0 -D1.0 -P -O -K -Gblack -W0.5 >> $ps
gmt psvelo $fixed -Jm${JLong} -R -Se${VSCALEUP}/0.90/0 -D1.0 -P -O -K -Gred -W0.5 -X-0.1 >> $ps
gmt psvelo $basic -Jm${JLong} -R -Se${VSCALEUP}/0.90/0 -D1.0 -P -O -K -Gblue -W0.5 -X0.2 >> $ps

# plot velocity vector scale (UP)
gmt psvelo -Jm${JLong} -R -Se${VSCALEUP}/0.90/12 -P -O -K -D1.0 -Gblack -W0.5 >> $ps << END
# lat    long E  W Eu Wu C  label  
-91.19 -0.856	0	${velScale} 0 0 0
END
	
fi

# ===================================================================================== 
echo "saving as .png image..."
convert -trim -density 300 $ps $pic
#open $ps

done