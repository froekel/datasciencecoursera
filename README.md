##The goal of this script is to clean the HARUS dataset 
To get more information about the data please go to this site 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

You can also check out the codebook in this repository.

This script assumes that you have extracted the dataset in a data subfolder in you R working directory

The high level flow through the code is :


## First step : File header 
This step generates the file header, cleans the column names and prepares the indexes to subset only the needed
columns

## Second step : Read all files from disc.
This is done using table.read and rbind to add the files together.


## Step three : 
using the indexes created in step one we can use these to select only the needed columns.
after only the needed columns are selected, we use the aggregate function to create the column means.

## Step four : 
use the activity labels to describe the factor


## Step Five :
write  the file to disk

