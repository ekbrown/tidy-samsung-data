# run_analysis.R
# Script to complete the Course Project for Getting and Cleaning Data

# clears memory
rm(list = ls(all = T))

setwd("/Users/earlbrown/coursera/clean_data/UCI HAR Dataset")
library("tidyr")
library("dplyr")

## Step 1

# loads training set, activities, and subjects, and combines them and renames columns
training <- read.table("train/X_train.txt")
training.act <- read.table("train/y_train.txt")
training.sub <- read.table("train/subject_train.txt")
training <- cbind(training.sub, training.act, training)
colnames(training) <- c("Sub", "Act", paste0("V", 1:(length(training) - 2)))

# loads test set and test set activities (numbers only), and combines (cbind) them and renames columns
test <- read.table("test/X_test.txt")
test.act <- read.table("test/y_test.txt")
test.sub <- read.table("test/subject_test.txt")
test <- cbind(test.sub, test.act, test)
colnames(test) <- c("Sub", "Act", paste0("V", 1:(length(test) - 2)))

# merges (rbind) training and test sets
both <- rbind(training, test)

## Step 2

# loads features (info about columns) and excludes columns of 'both' that don't have 'mean()' or 'std()'
feat <- read.table("features.txt", stringsAsFactors = F)
keep <- grep("^.*(mean\\(\\)|std\\(\\)).*$", feat$V2)
both <- both[, c(1, 2, keep + 2)]

## Step 3

# loads descriptors for activities and joins them to 'both'
act.labels <- read.table("activity_labels.txt", col.names = c("ActNum", "ActLabel"))
both <- left_join(both, act.labels, by = c("Act" = "ActNum"))

## Step 4

# makes variable names more descriptive
colnames(both) <- c("Sub", "Act", feat$V2[keep], "ActLabel")

## Step 5

# pipeline to create a tidy data set that summarizes the measurements
both <- both %>% 
  gather(variable, value, contains("tBodyAcc-mean()-X"):contains("fBodyBodyGyroJerkMag-std()")) %>% 
  rename(Subject = Sub, Activity = ActLabel, Variable = variable) %>% 
  group_by(Subject, Activity, Variable) %>% 
  summarise(Average_value = mean(value))

# saves tidy data set to hard drive
write.table(both, file = "tidy_data_set.txt", quote = F, sep = "\t", row.names = F)
