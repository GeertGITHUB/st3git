### PLOT SETTINGS
ptSize <- 6
ptAlpha <- 0.8
chartWidth <- 12
chartHeight <- 6
ebWidth <- 0.5 # error bar width

## INDOOR TEMPERATURE
chartWidth <- 9
chartHeight <- 6
selWG <- "Indoor temperature"
selData <- data %>%
    filter(Method != "xReference",
           Method != "LR") %>%
    filter(WG == selWG)

myseed = set.seed(1234)
p <- selData %>%
    ggplot(mapping = aes(x = Approach, y = Estimate)) +
    facet_grid(`Test case` ~ Method, scales = "free") +
    geom_errorbar(aes(ymin=Estimate-`Standard deviation`, ymax=Estimate+`Standard deviation`), width=ebWidth) +
    geom_point(size = ptSize, alpha = ptAlpha)

pref <- geom_hline(data = selData,
                   aes(yintercept = HLCref))

p2 <- geom_point(data = selData %>%
                     filter(grepl("No intercept", Intercept)),
    colour = "white", size = ptSize*0.8)    

p + p2 + pref

## INDOOR TEMPERATURE - %DIFF
p <- selData %>%
    ggplot(mapping = aes(x = Approach, y = diffEstimate)) +
    facet_grid(`Test case` ~ Method, scales = "free_x") +
    geom_point(size = ptSize, alpha = ptAlpha) +
    geom_hline(yintercept = 0)

p2 <- geom_point(data = selData %>%
                     filter(grepl("No intercept", Intercept)),
                 colour = "white", size = ptSize*0.8)

p + p2
