download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', dest='data.zip', method='curl')
unzip('data.zip')

# Get and clean labels.
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt',
                              col.names=c('id', 'name'),
                              row.names=1)
activity_labels$name <- gsub('[_-]', '', tolower(activity_labels$name))
labels <- read.table('UCI HAR Dataset/features.txt',
                     col.names=c('id', 'name'),
                     row.names=1)
labels_filter <- grepl('([Mm]ean|std)', labels$name)
labels <- tolower(gsub('\\(\\)', '', labels[labels_filter,]))

# Get main data.
train_df <- read.table('UCI HAR Dataset/train/X_train.txt')[,labels_filter]
colnames(train_df) <- labels
train_df <- cbind(
    data.frame(
        activity=read.table('UCI HAR Dataset/train/y_train.txt')[,1],
        subject=read.table('UCI HAR Dataset/train/subject_train.txt')[,1]),
    train_df)

test_df <- read.table('UCI HAR Dataset/test/X_test.txt')[,labels_filter]
colnames(test_df) <- labels
test_df <- cbind(
    data.frame(
        activity=read.table('UCI HAR Dataset/test/subject_test.txt')[,1],
        subject=read.table('UCI HAR Dataset/test/y_test.txt')[,1]),
    test_df)

df <- merge(train_df, test_df, all=TRUE)

# Map activity labels.
df$activity = sapply(df$activity, function(i) activity_labels[i,])

# Mean by activity and subject.
df <- aggregate(. ~ activity + subject, df, mean)

df <- df[order(df$activity, df$subject),]

write.table(df, file='dataset.txt')
