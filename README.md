# dnanexus_RPKM_bedfile - v1.0

## What does this app do?
This app takes a bedfile generated by mokabed and creates a bedfile suitable for use with the DNA nexus RPKM app.

## What data are required for this app to run?
The app requires a bedfile as an input and version number of the CNV control sites which are to be appended.

1. BED file
This app requires the PanXdata.bed bedfile generated by Mokabed.
  * This file will have two header lines starting with #. These lines are removed by the app
  * The chromosome numbers in the bedfile should not include 'chr' eg 1 NOT Chr1

2. CNV control site verison number
The version number should be selected from the drop down.
These are files packaged within the app in the required format.
If no control sites are required use the 'None' option.


## What does this app output?
This app produces two outputs:

1. PanX_RPKM.bed
This bed file can be used by the RPKM app

2. PanX_LogFile.txt
Contains all the commands and instructions used to create this bed file.


## Limitations of the App
The control sites must be packages within the app.
These files must be in the format 
chromosome start stop name
with no headers 
and 'chr' not present

## Created by
This app was created within the Viapath Genome Informatics section

