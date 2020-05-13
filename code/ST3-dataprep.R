## don't forget to set your working directory first!
setwd("~/Annex71/2004-trondheim/")

load("data/data.RData")

## DATA WRANGLING (not always beautiful, I know)
data <- data %>% unnest(Method)

data$Intercept <- "Intercept"
data[which(grepl("No intercept", data$Comments)), "Intercept"] <- "No intercept"
data[which(grepl(", no intercept", data$Comments)), "Intercept"] <- "No intercept"

data$Qi <- "with Qi"
data[which(grepl("without Qi", data$Comments)), "Qi"] <- "without Qi"

data[which(grepl("LR1: Linear regression approach 1", data$Method)), "Method"] <- "LR1"
data[which(grepl("LR1b", data$Method)), "Method"] <- "LR1"
data[which(grepl("LR1a", data$Method)), "Method"] <- "LR1"
data[which(grepl("LR2: Linear regression approach 2", data$Method)), "Method"] <- "LR2"
data[which(grepl("LR2a", data$Method)), "Method"] <- "LR2"
data[which(grepl("LR2b", data$Method)), "Method"] <- "LR2"
data[which(grepl("Avg: Average", data$Method)), "Method"] <- "AVG"
data[which(grepl("LR3: Linear regression approach 3", data$Method)), "Method"] <- "LR3"
data[which(grepl("LR3$", data$Method)), "Method"] <- "LR3"
data[which(grepl("SS: State space modeling", data$Method)), "Method"] <- "SS"

data$HLCref <- 0
data[which(grepl("Twins", data$`Test case`)), "HLCref"] <- 107.38
data[which(grepl("Ukulele", data$`Test case`)), "HLCref"] <- 106.3
data[which(grepl("LBORO", data$`Test case`)), "HLCref"] <- 375
data[which(grepl("GBORO", data$`Test case`)), "HLCref"] <- 39.63

data$gAref <- 0
data[which(grepl("Twins", data$`Test case`)), "gAref"] <- 10.21
data[which(grepl("Ukulele", data$`Test case`)), "gAref"] <- 5.92
data[which(grepl("LBORO", data$`Test case`)), "gAref"] <- 5.3
data[which(grepl("GBORO", data$`Test case`)), "gAref"] <- 3.6

data <- data %>% filter(`Estimate name` == "HLC")

data <- data %>%
    mutate(diffEstimate = ((Estimate - HLCref)/HLCref)*100)
