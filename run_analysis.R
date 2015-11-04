library(data.table)
library(dplyr)

path <- "UCI HAR Dataset"
pathVariableNames <- "features.txt"
pathActivityNames <- "activity_labels.txt"

pathTest <- "test"
pathTrain <- "train"

pathOutput <- "tidy_data.txt"

## Read information for a given data set from related text files on disk.
## The function expects "UCI HAR Dataset" folder to be present in the current
## working directory.
##
## dataset - either "test" or "train"
##
## Returns a processed data frame. The data frame contains variable names,
## observations, subject ids.
readDataSet <- function(dataset) {
    # read observations from a text file
    observations <- fread(file.path(
        path,
        dataset,
        paste("X_", dataset, ".txt", sep="")))
    
    variableNames <- fread(file.path(path, pathVariableNames))
    activityIds <- fread(file.path(
        path,
        dataset,
        paste("y_", dataset, ".txt", sep="")))
    subjectIds <- fread(file.path(
        path,
        dataset,
        paste("subject_", dataset, ".txt", sep="")))
    
    # assign column names from labels df
    names(observations) <- variableNames[, V2]
    # bind column with activity ids
    observations <- cbind(observations, activityIds)
    names(observations)[562] <- "activity_id"
    # bind column with subject ids
    observations <- cbind(observations, subjectIds)
    names(observations)[563] <- "subject_id"
    # keep only the columns we need
    observations <- observations %>% select(
        contains("mean()"), contains("std()"), activity_id, subject_id)
    observations
}

# read 2 datasets
testDataSet <- readDataSet(pathTest)
trainDataSet <- readDataSet(pathTrain)
# merge them together
cleanDataSet <- rbind(testDataSet, trainDataSet)

# read activity names and create a new column
activityNames <- fread(file.path(path, pathActivityNames))
names(activityNames) <- c("activity_id", "activity_name")
cleanDataSet <- cleanDataSet %>% left_join(activityNames)

# create tidy data set
tidyDataSet <- cleanDataSet %>%
    select(-activity_id) %>%
    group_by(subject_id, activity_name) %>%
    summarize_each(funs(mean)) %>%
    arrange(subject_id, activity_name)

# write the tidy dataset to disk
write.table(tidyDataSet, file=pathOutput, row.names=FALSE)