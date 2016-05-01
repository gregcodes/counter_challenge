# load packages
library(data.table)
library(dplyr)

#import data
dataset <- read.csv2("dataset.csv", header = TRUE)
dataset <- data.table(dataset)

time_start <- Sys.time()

## Multiple bids (bidding contests)
#convert all dates into R-recognized date format

dataset$Date.Announced.Fixed <- ifelse(dataset$Date.Announced!=0, as.Date(as.character(dataset$Date.Announced), "%Y-%m-%d"), 0)

#subset duplicates 
duplicates <- dataset[duplicated(dataset$Target.Name) | duplicated(dataset$Target.Name, fromLast=TRUE)]

# sort by CUSIP, Date Announced & Deal Number (increasing)
duplicates <- duplicates[order(Target.Name, Date.Announced.Fixed, decreasing=FALSE)]

# for each company, set the oldest bid to -1
index_dupl <- NROW(duplicates)
for(i in 2:index_dupl)
{
  duplicates$Count[i] <- ifelse(duplicates$Target.Name[i]==duplicates$Target.Name[i-1], 0, -1)
}
# fix first company in set to -1
duplicates$Count[1] <- -1

# algorithm that sets every other bid that is in range of 60 days of a first bid to 0
for(i in 1:index_dupl)
{
  if(duplicates$Count[i]==-1)
  {
    duplicates$Count[i] <- 1
    index_co <- NROW(duplicates[Target.Name==duplicates$Target.Name[i]])
    index_co <- index_co-1
    pos <- 0
    while (pos < index_co)
    {
      if(duplicates$Count[i+pos]==1) 
      {
        remaining <- index_co-pos
        for(co in 1:remaining)
        {
          date_current <- duplicates$Date.Announced.Fixed[i+pos]
          date_below <- duplicates$Date.Announced.Fixed[i+co+pos]
          duplicates$Count[i+co+pos] <- ifelse(date_below-date_current<=60, 0, 1) 
        }
      }
      pos <- pos+1
    }
  }
}

time_end <- Sys.time()
print(time_end-time_start)

# manually check if the algorithm worked correctly
des_columns <- c(2:5)
check_data <- duplicates[, des_columns, with = FALSE]
print(check_data[0:100])
