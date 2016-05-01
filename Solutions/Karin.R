dataset <- read.csv("C:/Users/david/Desktop/CodeCats/dataset.csv", sep=";")

ds <- dataset[2:3]
ds[,2] <- as.Date(ds[,2])
ds <- ds[with(ds, order(ds[,1],ds[,2])), ] #inital sort to ensure order by target and then by date

counting <- function(x){ #counting vector added to inital dataset
count <- 1 # first value of the new variable (vector)
d <- x
ref <- d[1,2] # inintial reference value
for (i in 2:nrow(d)){

if(d[i,1]!=d[i-1,1]){ # if new target set 1
  count <- rbind(count,1)
  ref <- d[i,2] # new ref value
} else{

  if(as.integer(d[i,2]-ref)<=60) #if same target but less than 60 days
  {
    count <- rbind(count,0)
  } else { # if same target and more than 60 days
    count <- rbind(count,1)
    ref <- d[i,2]
  }
}
}
return(cbind(x,count))
}

t0 <- Sys.time()
t <- counting(ds)
Sys.time()-t0
