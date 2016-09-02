#!/bin/bash
#
# Plots velocity vectors on Sierra Negra volcano
# Plots BOTH EN and UP vectors

# set file directories
ps=Plots/isabelaMap.ps
stations=Data/SierraNegraStations/stationLocations.dat
mSource=Data/SierraNegraStations/source.dat
grid=Data/DEM/ETOPO1.grd
grd=Data/DEM/GalaDEM.grd
cpt=Data/DEM/etopo1.cpt
cpt2=Data/DEM/etopo1b.cpt

# make folder for plots if it doesn't already exist
#if [ ! -d "$folder" ]; then
#    mkdir Data/Segmented10/Plots/S${SEGMENT}_${YR1}-${YR2}/
#fi

# set map extent and vector scale
west=-91.85 #-91.25
east=-90.1 #-91.00
south=-1.15
north=0.3

# set map inset extent
insetW=-93
insetE=-78
insetS=-3
insetN=3



JLong=9
VSCALE=0.0075 #0.01
VSCALEUP=0.015 #0.01
tickBig=0.5
tickGrid=0.0

# set plot title
#title="Isabela Island, Gal\341pagos, Ecuador"
title=""

gmt gmtset 	MAP_LABEL_OFFSET = 0.2c 	\
			MAP_TITLE_OFFSET = 0.3c		\
			FONT_ANNOT_PRIMARY = 8p,Helvetica,black	\
			FONT_ANNOT_SECONDARY = 8p,Helvetica,black	\
			FONT_LABEL = 8p,Helvetica,black	\
			FONT_LOGO = 8p,Helvetica,black	\
			FONT_TITLE = 8p,Helvetica,black


# set default fonts
#gmt set FONT_TITLE 12p,Helvetica FONT 12p,Helvetica

# Draw basemap
gmt psbasemap -Jm${JLong} -R${west}/${east}/${south}/${north} -B${tickBig}g${tickGrid}:."${title}": -X2.0 -Y2.0 -P -K > $ps
#gmt grdimage $grid -Jm${JLong} -R${west}/${east}/${south}/${north} -C$cpt -E300 -P -O -K >> $ps

gmt grdimage $grd -Jm${JLong} -R${west}/${east}/${south}/${north} -IgalaGrd.grd -P -M -O -K -E1000 >> $ps

gmt pscoast -Jm${JLong} -R -A1 -N1 -Df -S198/236/255 -B${tickBig}g${tickGrid}:."${title}": -W0.0 -P -O -K >> $ps

# Plot boxes for cities
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -Ss0.21 -G255 -W0.75 -P -O -K << END >> $ps
-90.96		-0.95
-90.3036	-0.7427
END

# Plot misc names in standard font
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f8p+jLM -O -N -K << END >> $ps 
-90.43	-0.8	Puerto Ayora, GLPS
-90.99	-0.98   Puerto Villamil
-91.17	-0.89	Fig. 2
END

# Plot island names in Bold
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f8p,Helvetica-Bold+jLM -O -N -K << END >> $ps 
-90.45   -0.63    Santa Cruz
-90.80   -0.26    Santiago
-91.06   -0.65    Isabela
-91.6    -0.44    Fernandina
END

# Draw lines connecting names to features - GLPS
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-90.26		-0.780	
-90.299  	-0.748
END

# Draw lines connecting names to features - CERRO AZUL
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.39  	-0.915	
-91.5  		-0.96
END

# Draw lines connecting names to features - DARWIN
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.29  	-0.19
-91.15  	-0.16
END

# Draw lines connecting names to features - WOLF
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.34  	0.018
-91.25  	0.1
END

# Draw lines connecting names to features - ECUADOR
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.55  	-0.02
-91.6  		0.05
END

# Draw lines connecting names to features - ALCEDO
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.12  	-0.42
-90.99  	-0.35
END

# Draw lines connecting names to features - FERNANDINA
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.54  	-0.37
-91.57 		-0.26
END

# Draw lines connecting names to features - SIERRA NEGRA
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -O -K -W0.5 << END >> $ps
-91.13  	-0.813
-91.055		-0.813
END

# ------------------------------------------------------------------------------------
# Plot volcano names in italics ------------------------------------------------------
gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f8p,Helvetica-Oblique+jLM -O -N -K << END >> $ps 
-91.05  -0.812  Sierra Negra
-91.67  -0.96   Cerro Azul
-91.65  -0.235  Fernandina
-91.245  0.115  Wolf
-91.14  -0.155  Darwin
-91.66   0.075  Ecuador
-90.98  -0.33   Alcedo
END

# Sierra Negra Box
lon_min=-91.19
lon_max=-91.07
lat_min=-0.86
lat_max=-0.755

#Plot box around Sierra Negra to match zoomed-in portion
gmt psxy -Jm${JLong} -R${west}/${east}/${south}/${north} -L -O -K -W1 << END >> $ps
$lon_min	$lat_min
$lon_min	$lat_max
$lon_max	$lat_max
$lon_max	$lat_min
END
# apply DEM (from Gorki Ruiz)
#gmt grdimage $grid -Jm${JLong} -R${west}/${east}/${south}/${north} -E1000 -M -B${tickBig}g${tickGrid}:."${title}": -P -O -K >> $ps

# plot stations and station labels
#gmt psxy $stations -R -Jm${JLong} -Sc0.16 -Gblack -W0.75 -P -O -K >> $ps # bottom half
#gmt psxy $mSource -R -Jm${JLong} -Sg0.16 -Gyellow -W1 -P -O -K >> $ps # bottom half

#gmt pstext $stations -R -J -D0.2c/0 -F+f8p+jLM -O -K -N >> $ps

# create scale
gmt psbasemap -Jm${JLong} -R -L-90.4/-1.0/0/40+l -P -O -K >> $ps # bottom half

#n=0.3
#s=-1.15
#e=-90.6
#w=-91.85



# -----------------------------------------------------------------------------------
# INSET -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------------
Jinset=0.6

# -Dwesn+g255
# Create Isabela inset map
gmt psbasemap -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -D${insetW}/${insetE}/${insetS}/${insetN}+p2  -P -O -K -X2.648i -Y3.685i >> $ps
gmt grdimage $grid -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -C$cpt2 -E300 -P -O -K >> $ps
gmt pscoast -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -A1 -N1 -Df -W0.5 -P -O -K >> $ps

# Galapagos Spreading Center Data (Bird 2002)
gmt psxy -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -L -O -K -W2 -Wmaroon << END >> $ps
-99.7389	2.26882
-99.657	2.19007
-98.9175	2.11218
-98.8886	2.21253
-98.3674	2.14463
-97.8463	2.07656
-97.5512	2.08841
-97.5851	1.89824
-96.88		1.88568
-96.175		1.87283
-96.1202	2.23785
-95.2241	2.22175
-95.1982	2.50694
-94.4044	2.43994
-93.6107	2.37248
-92.9279	2.29988
-92.2451	2.22695
-92.0902	2.19975
-92.1183	1.99009
-91.5376	2.01117
-91.5608	1.81659
-90.6973	1.73615
-90.6632	1.12041
-89.7836	1.0729
-88.9041	1.02514
-88.0245	0.977144
-87.145		0.928909
-86.2656	0.880462
-85.3861	0.831804
-85.3494	1.64441
-84.5759	1.59812
-84.5713	2.06618
-84.5667	2.53424
-84.4671	3.11226
-83.9225	3.13869
-83.3779	3.16485
-82.8064	3.11792
-82.875		3.5949
-82.875		4.07188
-82.875		4.56303
-82.875		5.05417
-82.875		5.83296
-82.875		6.56231
-82.8749	7.11804
-82.8748	7.36639
END

# Galapagos box
lon_min=-91.85 
lon_max=-90.1
lat_min=-1.15
lat_max=0.3

west=-91.2 #-91.25
east=-91.05 #-91.00
south=-0.87
north=-0.765

#Plot box around Sierra Negra to match zoomed-in portion
gmt psxy -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -L -O -K -W1,black << END >> $ps
$lon_min	$lat_min
$lon_min	$lat_max
$lon_max	$lat_max
$lon_max	$lat_min
END

# Plot text labels
gmt pstext -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -F+f8p,black+jLM -O -K -N << END >> $ps 
-92.50	-1.9	Gal\341pagos Islands
-90.00	2.00	Cocos Plate
-86.00	-1.0	Nazca Plate
-80.00	-1.0	Ecuador
END

gmt pstext -Jm${Jinset} -R${insetW}/${insetE}/${insetS}/${insetN} -F+f8p,black+jLM -O -K -N << END >> $ps 
-80.00	-1.0	Ecuador
END

# Plot text labels
#gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f14p+jLM -O -K -N << END >> $ps 
#-91.087	-0.842	a)
#END

#gmt pstext -Jm${JLong} -R${west}/${east}/${south}/${north} -F+f14p,Helvetica,White+jLM -O -K -N << END >> $ps 
#-91.159	-0.842	b)
#END

pic=Plots/FigurePictures/SharedFigures/figure1.png
convert -trim -density 400 $ps $pic
open $ps
