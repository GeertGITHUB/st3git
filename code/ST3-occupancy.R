### PLOT SETTINGS
ptSize <- 6
ptAlpha <- 0.8
chartWidth <- 12
chartHeight <- 6
ebWidth <- 0.5 # error bar width

## OCCUPANCY
chartWidth <- 9
chartHeight <- 6
selWG <- "Occupant and appliance heat gain"
selData <- data %>%
    filter(Method != "xReference",
           Method != "LR") %>%
    filter(WG == selWG)

myseed = set.seed(1234)
p <- selData %>%
    ggplot(mapping = aes(x = Approach, y = Estimate)) +
    geom_errorbar(aes(ymin=Estimate-`Standard deviation`, ymax=Estimate+`Standard deviation`), width=ebWidth) +
    facet_grid(`Test case` ~ Method, scales = "free") +
    geom_point(size = ptSize, alpha = ptAlpha)
    ## geom_jitter(position = position_jitter(width = 0, seed = myseed), size = 2)##  +
## geom_text(mapping = aes(label = Estimate), position = position_jitter(height = 1), size = 2)

pref <- geom_hline(data = selData,
                   aes(yintercept = HLCref))

## selData[which(!grepl("No intercept", data_tmp$Intercept)), "Estimate"] <- NA
p2 <- geom_point(data = selData %>%
                     filter(grepl("No intercept", Intercept)),
    ## position = position_jitter(width = 0, seed = myseed), 
    colour = "white", size = ptSize*0.8)    

p + p2 + pref

## OCCUPANCY - %DIFF
p <- selData %>%
    ggplot(mapping = aes(x = Approach, y = diffEstimate)) +
    facet_grid(`Test case` ~ Method, scales = "free_x") +
    geom_point(size = ptSize, alpha = ptAlpha) +
    geom_hline(yintercept = 0)

p2 <- geom_point(data = selData %>%
                     filter(grepl("No intercept", Intercept)),
                 colour = "white", size = ptSize*0.8)

p + p2
