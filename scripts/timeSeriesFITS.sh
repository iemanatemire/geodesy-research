#!/bin/bash
#
# Time series data showing deformation on equal scales
# CURRENT FILE

# Title
title="Sierra Negra Time Series Linear"
segs=lines.dat

# Time scale variables
timeMin=2005.5; timeMax=2016; TBT=1.0; TST=0.5;

# East displacement settings
eastMin=-1250; eastMax=1250; EBT=250; EST=125;

# North displacement variables
northMin=-1250; northMax=1250; NBT=250; NST=125;

# Vertical displacement variables
upMin=-1250; upMax=1250; UBT=250; UST=125;

# Output file locations
ps=../Plots/ps/timeSeriesFits${timeMin}-${timeMax}.ps
pic=../Plots/png/timeSeriesFits${timeMin}-${timeMax}.png

# scalars
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

# Location of linear fit line files
gv01e=../Data/SegmentedTS/LinearFits/eGV01.dat
gv01n=../Data/SegmentedTS/LinearFits/nGV01.dat
gv01u=../Data/SegmentedTS/LinearFits/uGV01.dat
gv02e=../Data/SegmentedTS/LinearFits/eGV02.dat
gv02n=../Data/SegmentedTS/LinearFits/nGV02.dat
gv02u=../Data/SegmentedTS/LinearFits/uGV02.dat
gv03e=../Data/SegmentedTS/LinearFits/eGV03.dat
gv03n=../Data/SegmentedTS/LinearFits/nGV03.dat
gv03u=../Data/SegmentedTS/LinearFits/uGV03.dat
gv04e=../Data/SegmentedTS/LinearFits/eGV04.dat
gv04n=../Data/SegmentedTS/LinearFits/nGV04.dat
gv04u=../Data/SegmentedTS/LinearFits/uGV04.dat
gv05e=../Data/SegmentedTS/LinearFits/eGV05.dat
gv05n=../Data/SegmentedTS/LinearFits/nGV05.dat
gv05u=../Data/SegmentedTS/LinearFits/uGV05.dat
gv06e=../Data/SegmentedTS/LinearFits/eGV06.dat
gv06n=../Data/SegmentedTS/LinearFits/nGV06.dat
gv06u=../Data/SegmentedTS/LinearFits/uGV06.dat
gv07ea=../Data/SegmentedTS/LinearFits/eGV07a.dat
gv07na=../Data/SegmentedTS/LinearFits/nGV07a.dat
gv07ua=../Data/SegmentedTS/LinearFits/uGV07a.dat
gv08ea=../Data/SegmentedTS/LinearFits/eGV08a.dat
gv08na=../Data/SegmentedTS/LinearFits/nGV08a.dat
gv08ua=../Data/SegmentedTS/LinearFits/uGV08a.dat
gv09ea=../Data/SegmentedTS/LinearFits/eGV09a.dat
gv09na=../Data/SegmentedTS/LinearFits/nGV09a.dat
gv09ua=../Data/SegmentedTS/LinearFits/uGV09a.dat
gv07eb=../Data/SegmentedTS/LinearFits/eGV07b.dat
gv07nb=../Data/SegmentedTS/LinearFits/nGV07b.dat
gv07ub=../Data/SegmentedTS/LinearFits/uGV07b.dat
gv08eb=../Data/SegmentedTS/LinearFits/eGV08b.dat
gv08nb=../Data/SegmentedTS/LinearFits/nGV08b.dat
gv08ub=../Data/SegmentedTS/LinearFits/uGV08b.dat
gv09eb=../Data/SegmentedTS/LinearFits/eGV09b.dat
gv09nb=../Data/SegmentedTS/LinearFits/nGV09b.dat
gv09ub=../Data/SegmentedTS/LinearFits/uGV09b.dat
gv10e=../Data/SegmentedTS/LinearFits/eGV10.dat
gv10n=../Data/SegmentedTS/LinearFits/nGV10.dat
gv10u=../Data/SegmentedTS/LinearFits/uGV10.dat
glpse=../Data/SegmentedTS/LinearFits/eGLPS.dat
glpsn=../Data/SegmentedTS/LinearFits/nGLPS.dat
glpsu=../Data/SegmentedTS/LinearFits/uGLPS.dat

# Common arguments for all psxy calls
args='-R -J -O -K -P' 

# Up
# ====================================================
rangeUp="-R${timeMin}/${timeMax}/${upMin}/${upMax}"		# Set x- and y-axis boundaries
scaleUp="-Jx${JT}/${JU}"								# Set basemap scale
argsUp='-X3.0 -Y4.0 -Sc0.05 -K -P'						# Set arguments

gmt psbasemap ${rangeUp} ${scaleUp} -Bpxa${TBT}f${TST}o+l"Decimal Year" -Bpya${UBT}f${UST}+l"Up (mm)" -BWSen+gwhite ${argsUp} > $ps

echo plotting up/down displacements...
awk '{print $1, ($2)+1250}' ${gv01u} | gmt psxy -Wthicker,red ${args} >> $ps
awk '{print $1, ($2)+0325}' ${gv02u} | gmt psxy -Wthicker,blue ${args} >> $ps
awk '{print $1, ($2)+0450}' ${gv03u} | gmt psxy -Wthicker,green ${args} >> $ps
awk '{print $1, ($2)-0175}' ${gv04u} | gmt psxy -Wthicker,black ${args} >> $ps
awk '{print $1, ($2)-0250}' ${gv05u} | gmt psxy -Wthicker,lightblue ${args} >> $ps
awk '{print $1, ($2)-0255}' ${gv06u} | gmt psxy -Wthicker,brown ${args} >> $ps
awk '{print $1, ($2)-0650}' ${gv07ua} | gmt psxy -Wthicker,gray ${args} >> $ps
awk '{print $1, ($2)-0775}' ${gv08ua} | gmt psxy -Wthicker,purple ${args} >> $ps
awk '{print $1, ($2)-0950}' ${gv09ua} | gmt psxy -Wthicker,orange ${args} >> $ps
awk '{print $1, ($2)-0650}' ${gv07ub} | gmt psxy -Wthicker,gray ${args} >> $ps
awk '{print $1, ($2)-0775}' ${gv08ub} | gmt psxy -Wthicker,purple ${args} >> $ps
awk '{print $1, ($2)-0950}' ${gv09ub} | gmt psxy -Wthicker,orange ${args} >> $ps
awk '{print $1, ($2)-1050}' ${gv10u} | gmt psxy -Wthicker,darkgreen ${args} >> $ps
awk '{print $1, ($2)-1150}' ${glpsu} | gmt psxy -W1p/,- -R -J -O -K -P >> $ps

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
awk '{print $1, ($2)+1000}' ${gv01n} | gmt psxy -Wthicker,red -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0850}' ${gv02n} | gmt psxy -Wthicker,blue -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0400}' ${gv03n} | gmt psxy -Wthicker,green -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0300}' ${gv04n} | gmt psxy -Wthicker,black -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0200}' ${gv05n} | gmt psxy -Wthicker,lightblue -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0170}' ${gv06n} | gmt psxy -Wthicker,brown -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0350}' ${gv07na} | gmt psxy -Wthicker,gray -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0300}' ${gv08na} | gmt psxy -Wthicker,purple -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0100}' ${gv09na} | gmt psxy -Wthicker,orange -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0350}' ${gv07nb} | gmt psxy -Wthicker,gray -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0300}' ${gv08nb} | gmt psxy -Wthicker,purple -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0100}' ${gv09nb} | gmt psxy -Wthicker,orange -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0700}' ${gv10n} | gmt psxy -Wthicker,darkgreen -R -J -O -K -P >> $ps
awk '{print $1, ($2)-1050}' ${glpsn} | gmt psxy -W1p/,- -R -J -O -K -P >> $ps

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
awk '{print $1, ($2)+0400}' ${gv01e} | gmt psxy -Wthicker,red -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0400}' ${gv02e} | gmt psxy -Wthicker,blue -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0425}' ${gv03e} | gmt psxy -Wthicker,green -R -J -O -K -P >> $ps
awk '{print $1, ($2)+0370}' ${gv04e} | gmt psxy -Wthicker,black -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0100}' ${gv05e} | gmt psxy -Wthicker,lightblue -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0140}' ${gv06e} | gmt psxy -Wthicker,brown -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0250}' ${gv07ea} | gmt psxy -Wthicker,gray -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0650}' ${gv08ea} | gmt psxy -Wthicker,purple -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0600}' ${gv09ea} | gmt psxy -Wthicker,orange -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0250}' ${gv07eb} | gmt psxy -Wthicker,gray -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0650}' ${gv08eb} | gmt psxy -Wthicker,purple -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0600}' ${gv09eb} | gmt psxy -Wthicker,orange -R -J -O -K -P >> $ps
awk '{print $1, ($2)-0750}' ${gv10e} | gmt psxy -Wthicker,darkgreen -R -J -O -K -P >> $ps
awk '{print $1, ($2)-1200}' ${glpse} | gmt psxy -W1p/,- -R -J -O -K -P >> $ps

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

# ==== Station Names ==========================================================
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

# ==== Segment Numbers ==========================================================
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

