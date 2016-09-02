### Volcano Geodesy Research

A bunch of spaghetti shell scripts I wrote for research I did in college.
Someday I'd like to clean this up.


#### Tools

I looked at data from [UNAVCO](https://www.unavco.org/) processed with
[GIPSY-OASIS](https://gipsy-oasis.jpl.nasa.gov/), using
[dModels](http://pubs.usgs.gov/tm/13/b1/) for physical modeling and
[GMT 5](http://gmt.soest.hawaii.edu/) for making maps and plots.


#### Workflow Summary

I took linear segments of the gps time series, calculated velocities, fed them 
into dModels to get best-fit estimates of magma flux, and summed everything up.
