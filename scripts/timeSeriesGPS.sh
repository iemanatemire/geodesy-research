#!/bin/bash
#
# Time series data showing deformation on equal scales
# CURRENT FILE

# Title
title="Sierra Negra Time Series"
segs=lines.dat

# Time scale variables
timeMin=2005.5  # x Min
timeMax=2016	# x Max
TBT=1.0			# Time big tick
TST=0.5         # Time small tick

# East displacement variables
eastMin=-1250   # y min
eastMax=1250    # y max
EBT=250     	# big tick interval
EST=125     	# small tick interval

# North displacement variables
northMin=-1250
northMax=1250
NBT=250
NST=125

# Vertical displacement ariables
upMin=-1250
upMax=1250
UBT=250
UST=125

# File locations
ps=../Plots/ps/timeSeriesSpread${timeMin}-${timeMax}.ps
pic=../Plots/png/timeSeriesSpread${timeMin}-${timeMax}.png

# scale
JT=`echo ${timeMin}  ${timeMax}  | awk '{print 17/($2-$1)}'`  # time-scale
JE=`echo ${eastMin}  ${eastMax}  | awk '{print 7/($2-$1)}'`   # east-scale
JN=`echo ${northMin} ${northMax} | awk '{print 7/($2-$1)}'`   # north-scale
JU=`echo ${upMin}    ${upMax}    | awk '{print 7/($2-$1)}'`   # up-scale


# GMT Code
gmt gmtset 	MAP_LABEL_OFFSET = 0.2c 	\
			MAP_TITLE_OFFSET = 0.3c		\
			MAP_TICK_LENGTH_PRIMARY = 0.1c		\
			MAP_TICK_LENGTH_SECONDARY = -0.5c		\
			FONT_ANNOT_PRIMARY = 12p,Helvetica,black	\
			FONT_ANNOT_SECONDARY = 12p,Helvetica,black	\
			FONT_LABEL = 14p,Helvetica,black	\
			FONT_LOGO = 12p,Helvetica,black	\
			FONT_TITLE = 14p,Helvetica,black



# Location of time series data
# ====================================================
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

# Up
# ====================================================
rangeUp="-R${timeMin}/${timeMax}/${upMin}/${upMax}"		# Set x- and y-axis boundaries
scaleUp="-Jx${JT}/${JU}"								# Set basemap scale
argsUp='-X3.0 -Y4.0 -Sc0.05 -K -P'							# Set arguments

gmt psbasemap ${rangeUp} ${scaleUp} -Bpxa${TBT}f${TST}o+l"Decimal Year" -Bpya${UBT}f${UST}+l"Up (mm)" -BWSen+gwhite ${argsUp} > $ps

echo plotting up/down displacements...
#-gx0.00549316 makes a line break when more than two days are missing
args='-Sc0.05 -R -J -O -K -P' 
awk '{print $1, (1000*$4)+1250, 3*1000*$7}' ${tseries01} | gmt psxy -Gred 		${args} >> $ps
awk '{print $1, (1000*$4)+325, 3*1000*$7}' ${tseries02} | gmt psxy -Gblue   	${args} >> $ps
awk '{print $1, (1000*$4)+450, 3*1000*$7}' ${tseries03} | gmt psxy -Ggreen  	${args} >> $ps
awk '{print $1, (1000*$4)-175, 3*1000*$7}' ${tseries04} | gmt psxy -Gblack	 	${args} >> $ps
awk '{print $1, (1000*$4)-250, 3*1000*$7}' ${tseries05} | gmt psxy -Glightblue  ${args} >> $ps
awk '{print $1, (1000*$4)-250, 3*1000*$7}' ${tseries06} | gmt psxy -Gbrown  	${args} >> $ps
awk '{print $1, (1000*$4)-650, 3*1000*$7}' ${tseries07} | gmt psxy -Ggray   	${args} >> $ps
awk '{print $1, (1000*$4)-775, 3*1000*$7}' ${tseries08} | gmt psxy -Gpurple 	${args} >> $ps
awk '{print $1, (1000*$4)-950, 3*1000*$7}' ${tseries09} | gmt psxy -Gorange 	${args} >> $ps
awk '{print $1, (1000*$4)-1050, 3*1000*$7}' ${tseries10} | gmt psxy -Gdarkgreen 	${args} >> $ps
awk '{print $1, (1000*$4)-1150, 3*1000*$7}' ${tseries11} | gmt psxy -Gblack  	${args} >> $ps

echo "2005.8	-1500	-1500	-1500" > $segs
echo "2005.8	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2006.48	-1500	-1500	-1500" > $segs
echo "2006.48	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2008	-1500	-1500	-1500" > $segs
echo "2008	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2009	-1500	-1500	-1500" > $segs
echo "2009	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010	-1500	-1500	-1500" > $segs
echo "2010	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010.41	-1500	-1500	-1500" > $segs
echo "2010.41	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010.8	-1500	-1500	-1500" > $segs
echo "2010.8	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2011.5	-1500	-1500	-1500" > $segs
echo "2011.5	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2012.02	-1500	-1500	-1500" > $segs
echo "2012.02	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2012.4	-1500	-1500	-1500" > $segs
echo "2012.4	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2013.5	-1500	-1500	-1500" > $segs
echo "2013.5	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2014	-1500	-1500	-1500" > $segs
echo "2014	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2015.3	-1500	-1500	-1500" > $segs
echo "2015.3	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

# North
# ====================================================
rangeNorth="-R$timeMin/$timeMax/$northMin/$northMax"
scaleNorth="-Jx${JT}/${JN}"
argsNorth="-X0.0 -Y8.0 -Sc0.05 -O -K -P"

gmt psbasemap ${rangeNorth} ${scaleNorth} -Bpxa${TBT}f${TST}o -Bpya${NBT}f${NST}+l"North (mm)" -BWSen+gwhite ${argsNorth} >> $ps

echo plotting north/south displacements...
awk '{print $1, (1000*$3)+1000, 2*1000*$6}' ${tseries01} | gmt psxy -Gred    ${args} >> $ps
awk '{print $1, (1000*$3)+850, 2*1000*$6}' ${tseries02} | gmt psxy -Gblue   ${args} >> $ps
awk '{print $1, (1000*$3)+400, 2*1000*$6}' ${tseries03} | gmt psxy -Ggreen  ${args} >> $ps
awk '{print $1, (1000*$3)+300, 2*1000*$6}' ${tseries04} | gmt psxy -Gblack  ${args} >> $ps
awk '{print $1, (1000*$3)+200, 2*1000*$6}' ${tseries05} | gmt psxy -Glightblue   ${args} >> $ps
awk '{print $1, (1000*$3)+170, 2*1000*$6}' ${tseries06} | gmt psxy -Gbrown  ${args} >> $ps
awk '{print $1, (1000*$3)+350, 2*1000*$6}' ${tseries07} | gmt psxy -Ggray   ${args} >> $ps
awk '{print $1, (1000*$3)+300, 2*1000*$6}' ${tseries08} | gmt psxy -Gpurple ${args} >> $ps
awk '{print $1, (1000*$3)-100, 2*1000*$6}' ${tseries09} | gmt psxy -Gorange ${args} >> $ps
awk '{print $1, (1000*$3)-700, 2*1000*$6}' ${tseries10} | gmt psxy -Gdarkgreen ${args} >> $ps
awk '{print $1, (1000*$3)-1050, 2*1000*$6}' ${tseries11} | gmt psxy -Gblack  ${args} >> $ps

echo "2005.8	-1500	-1500	-1500" > $segs
echo "2005.8	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2006.48	-1500	-1500	-1500" > $segs
echo "2006.48	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2008	-1500	-1500	-1500" > $segs
echo "2008	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2009	-1500	-1500	-1500" > $segs
echo "2009	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010	-1500	-1500	-1500" > $segs
echo "2010	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010.41	-1500	-1500	-1500" > $segs
echo "2010.41	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010.8	-1500	-1500	-1500" > $segs
echo "2010.8	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2011.5	-1500	-1500	-1500" > $segs
echo "2011.5	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2012.02	-1500	-1500	-1500" > $segs
echo "2012.02	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2012.4	-1500	-1500	-1500" > $segs
echo "2012.4	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2013.5	-1500	-1500	-1500" > $segs
echo "2013.5	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2014	-1500	-1500	-1500" > $segs
echo "2014	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2015.3	-1500	-1500	-1500" > $segs
echo "2015.3	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

# East
# ====================================================
rangeEast="-R$timeMin/$timeMax/$eastMin/$eastMax"
scaleEast="-Jx${JT}/${JE}"
argsEast="-X0.0 -Y8.0 -O -K -P"

gmt psbasemap ${rangeEast} ${scaleEast} -Bpxa${TBT}f${TST}o -Bpya${EBT}f${EST}+l"East (mm)" -BWSen+gwhite ${argsEast}>> $ps

echo plotting east/west displacements...
awk '{print $1, (1000*$2)+400, 2*1000*$5}' ${tseries01} | gmt psxy -Gred    ${args} >> $ps
awk '{print $1, (1000*$2)-400, 2*1000*$5}' ${tseries02} | gmt psxy -Gblue   ${args} >> $ps
awk '{print $1, (1000*$2)+425, 2*1000*$5}' ${tseries03} | gmt psxy -Ggreen  ${args} >> $ps
awk '{print $1, (1000*$2)+370, 2*1000*$5}' ${tseries04} | gmt psxy -Gblack  ${args} >> $ps
awk '{print $1, (1000*$2)-100, 2*1000*$5}' ${tseries05} | gmt psxy -Glightblue   ${args} >> $ps
awk '{print $1, (1000*$2)-140, 2*1000*$5}' ${tseries06} | gmt psxy -Gbrown  ${args} >> $ps
awk '{print $1, (1000*$2)-250, 2*1000*$5}' ${tseries07} | gmt psxy -Ggray   ${args} >> $ps
awk '{print $1, (1000*$2)-650, 2*1000*$5}' ${tseries08} | gmt psxy -Gpurple ${args} >> $ps
awk '{print $1, (1000*$2)-600, 2*1000*$5}' ${tseries09} | gmt psxy -Gorange ${args} >> $ps
awk '{print $1, (1000*$2)-750, 2*1000*$5}' ${tseries10} | gmt psxy -Gdarkgreen ${args} >> $ps
awk '{print $1, (1000*$2)-1200, 2*1000*$5}' ${tseries11} | gmt psxy -Gblack  ${args} >> $ps

echo "2005.8	-1500	-1500	-1500" > $segs
echo "2005.8	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2006.48	-1500	-1500	-1500" > $segs
echo "2006.48	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2008	-1500	-1500	-1500" > $segs
echo "2008	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2009	-1500	-1500	-1500" > $segs
echo "2009	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010	-1500	-1500	-1500" > $segs
echo "2010	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010.41	-1500	-1500	-1500" > $segs
echo "2010.41	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2010.8	-1500	-1500	-1500" > $segs
echo "2010.8	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2011.5	-1500	-1500	-1500" > $segs
echo "2011.5	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2012.02	-1500	-1500	-1500" > $segs
echo "2012.02	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2012.4	-1500	-1500	-1500" > $segs
echo "2012.4	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2013.5	-1500	-1500	-1500" > $segs
echo "2013.5	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2014	-1500	-1500	-1500" > $segs
echo "2014	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

echo "2015.3	-1500	-1500	-1500" > $segs
echo "2015.3	1500	1500	1500" >> $segs
gmt psxy -R -J $segs -Wthinnest -O -K >> $ps
rm $segs

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,red+jLM -O -N -K << END >> $ps 
2015.4		1050		GV01
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,blue+jLM -O -N -K << END >> $ps 
2015.4		750		GV02
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,green+jLM -O -N -K << END >> $ps 
2015.4		560		GV03
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2015.4		425		GV04
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,lightblue+jLM -O -N -K << END >> $ps 
2015.4		325		GV05
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,brown+jLM -O -N -K << END >> $ps 
2015.4		225		GV06
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,gray+jLM -O -N -K << END >> $ps 
2015.4		-060	GV07
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,purple+jLM -O -N -K << END >> $ps 
2015.4		-175	GV08
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,orange+jLM -O -N -K << END >> $ps 
2015.4		-380	GV09
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,darkgreen+jLM -O -N -K << END >> $ps 
2015.4		-500	GV10
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2015.4		-600	GLPS
END

# ==== Segment Numbers ===============================================================

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2006.1		1125	1
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2007.25		1125	2
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2008.5		1125	3
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2009.5		1125	4
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2010.15		1125	5
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2010.55		1125	6		
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2011.1		1125	7
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2011.70		1125	8
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2012.15		1125	9
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2012.85		1125	10
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2013.65		1125	11
END

gmt pstext -Jx ${rangeNorth} -F+f09p,Helvetica,black+jLM -O -N -K << END >> $ps 
2014.55		1125	12
END

convert -trim -density 300 $ps $pic

echo "done!"
open $ps