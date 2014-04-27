## Download the file from the project data source url
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "UCIData.zip", method="curl")

## unzip the files
unzip("UCIData.zip")

# Create vectors containing the paths to the filenames in training and test sets
trainFileSet <- list.files("UCI HAR Dataset/train/", recursive=TRUE)
testFileSet <- list.files("UCI HAR Dataset/test/", recursive=TRUE)

# number of files datasets to be merged
numFilesToMerge <- length(trainFileSet)

# Create a new directory, combined. combined should have the same directory 
# structure as the train and test directories
if(file.exists("UCI HAR Dataset/combined/")) {
        if(!file.exists("UCI HAR Dataset/combined/Inertial Signals")){
                dir.create("UCI HAR Dataset/combined/Inertial Signals")
        }
} else {
        dir.create("UCI HAR Dataset/combined/")
        dir.create("UCI HAR Dataset/combined/Inertial Signals")
}

# Combine train and test data for all the files stored in the train and test
# directories. Write the combined datasets to the combined directory. The 
# filenames in combined directory will follow the same naming rules as the files
# inside train and test directories
for(i in 1:numFilesToMerge) {
        ftrain <- read.table(paste("UCI HAR Dataset/train/",trainFileSet[i],sep=""))
        ftest <- read.table(paste("UCI HAR Dataset/test/",testFileSet[i], sep=""))
        combinedDataSet <- rbind.data.frame(ftrain, ftest)
        write.table(combinedDataSet, file=gsub("train","combined", paste("UCI HAR Dataset/combined/",trainFileSet[i],sep="")))
}

## Read feature.txt and map the feature names to the columns in X_combined.txt
featureDf <- read.table("UCI HAR Dataset/features.txt")
featureVect <- as.character(featureDf[[2]])

## Read the X_combined.txt file
combinedXDataSet <- read.table("UCI HAR Dataset/combined/X_combined.txt")
colnames(combinedXDataSet) <- featureVect
columnsToBeExtracted <- featureVect[grepl("mean|std", featureVect)]

## Extract mean and standard deviation measurements from the combined data
extractedDataSet <- combinedXDataSet[,columnsToBeExtracted]

# Write the average of each measurement in extractedDataSet to tidydata.txt in 
# the combined directory.
write.table(colMeans(extractedDataSet), file="UCI HAR Dataset/combined/tidydata.txt")


