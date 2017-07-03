#!/bin/bash
#

# The following line causes bash to exit at any point if there is any error
# and to output each line as it is executed -- useful for debugging
set -e -x -o pipefail

#
# Download inputs
#
dx-download-all-inputs  --parallel

# capture the pan number
to_remove="data.bed"
pannum=$(echo $bedfile_name | sed "s/$to_remove//")

#name log file and bed file
logfile=/home/dnanexus/out/RPKM_bedfile/${pannum}_RPKM_logfile.txt
RPKM_bed=${pannum}_RPKM.bed

#make output dir
mkdir -p /home/dnanexus/out/RPKM_bedfile/

#write to logfile
echo "Creating bedfile for RPKM analysis for $pannum" > $logfile

#remove the header lines
sed -i '/^#/ d' $bedfile_path

#write to logfile
echo "Removing header line with command:">> $logfile
echo "sed -i '/^#/ d' $bedfile_path">> $logfile

#take first 4 columns
awk '{ print $1"\t"$2"\t"$3"\t"$4 }' $bedfile_path > $RPKM_bed

#write to logfile
echo "Taking first four columns only:">> $logfile
echo "awk '{ print \$1\t\$2\t\$3\t\$4 }' $bedfile_path > $RPKM_bed" >> $logfile

# $RPKM_bedfile is the version number. Files for each option,with the extension .txt are in the home dir..


if [[ $CNV_control_regions ]]
	then
	# write to logfile
 	echo "Appending additional bedfiles to bedfile:" >> $logfile

	# loop through any additional bed files to add and append them to the bed file
	for input in /home/dnanexus/in/CNV_control_regions/*; do
	if [ -d "$input" ];  then 
	 	file=$(ls $input)
	 	cat $input/$file >> $RPKM_bed
	 	echo "cat $input/$file >> $RPKM_bed" >> $logfile
	 fi
	done
else
	# write to logfile
 	echo "No additonal bed files to be added" >> $logfile	
fi

#cat ${CNV_control_regions}.txt >> $RPKM_bed

# echo "cat ${CNV_control_regions}.txt >> $RPKM_bed" >> $logfile

#move files to output
mv $RPKM_bed /home/dnanexus/out/RPKM_bedfile/$RPKM_bed

# Upload results
dx-upload-all-outputs
