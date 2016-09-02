#!/bin/bash
#
# Sierra Negra Volcano in equitorial context
#

ps=try.ps

stations=Data/SierraNegraStations/stationLocations.dat

grid=Data/DEM/w001001.grd

outgrd1=g_intens.grd
outgrd2=t_intens.grd

#title="Sierra Negra, Gal\341pagos, Ecuador"
title=""

# set map extent and vector scale
west=-91.2 #-91.25
east=-91.05 #-91.00
south=-0.87
north=-0.765

JLong=100
tickBig=0.05
tickGrid=0

lon_min=-92
lon_max=-90.5
lat_min=-1.5
lat_max=0.5


gmt gmtset 	MAP_LABEL_OFFSET = 0.2c 	\
			MAP_TITLE_OFFSET = 0.3c		\
			FONT_ANNOT_PRIMARY = 8p,Helvetica,black	\
			FONT_ANNOT_SECONDARY = 8p,Helvetica,black	\
			FONT_LABEL = 8p,Helvetica,black	\
			FONT_LOGO = 8p,Helvetica,black	\
			FONT_TITLE = 8p,Helvetica,black

# Draw basemap
gmt psbasemap -Jm${JLong} -R${west}/${east}/${south}/${north} -B${tickBig}g${tickGrid}:."${title}": -X2.0 -Y2.0 -P -K > $ps

# apply DEM (from Gorki Ruiz)
gmt grdimage $grid -Jm${JLong} -R${west}/${east}/${south}/${north} -E400 -M -B${tickBig}g${tickGrid}:."${title}": -P -O -K >> $ps

# plot stations icons (circles)
gmt psxy $stations -R -Jm${JLong} -Sc0.2 -G250 -W0.75 -P -O -K >> $ps

# Plot station labels next to station icons
gmt pstext $stations -R -J -D0.2c/0 -F+f8p,Helvetica-Bold+jLM -O -K -N >> $ps

# Creates illumination grdfile
#gmt grdgradient $grid -Ne0.5 -A -fg -Gw001illum.grd

# create scale for big map
gmt psbasemap -Jm${JLong} -R -L-91.075/-0.86/0/4+l -P -O -K >> $ps # bottom half



# Plot title for inset map
#gmt pstext -Jm35 -R${lon_min}/${lon_max}/${lat_min}/${lat_max} -F+f6p+jLM -O -K -N << END >> $ps 
#-91.175	-0.772	Sierra Negra Caldera
#END

# Plot scale on inset map
#gmt psbasemap -Jm35 -R -L-91.102/-0.85/0/4+l -P -O -K >> $ps

# plot stations and station labels on inset map
#gmt psxy $stations -R -Jm35 -Sc0.1 -G190 -W0.75 -P -O -K >> $ps
#gmt pstext $stations -R -Jm35 -D0.1c/0 -F+f4p+jLM -O -K -N >> $ps

pic=Plots/FigurePictures/SharedFigures/figure2.png
convert -trim -density 400 $ps $pic
gs $ps
