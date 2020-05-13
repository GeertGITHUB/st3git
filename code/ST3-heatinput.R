### PLOT SETTINGS
ptSize <- 6
ptAlpha <- 0.8
chartWidth <- 12
chartHeight <- 6
ebWidth <- 0.5 # error bar width

## HEAT INPUT - VALUES
selWG <- "Heat input"
selData <- data %>%
    filter(Method != "xReference",
           Method != "LR") %>%
    filter(WG == selWG)

# points with internal gains
p <- selData %>% filter(Qi == "with Qi") %>%
    ggplot(mapping = aes(x = Approach, y = Estimate)) +
    facet_grid(`Test case` ~ Method, scales = "free") +
    geom_errorbar(aes(ymin=Estimate-`Standard deviation`, ymax=Estimate+`Standard deviation`), width=ebWidth) +
    geom_point(size = ptSize, alpha = ptAlpha)

pref <- geom_hline(data = selData,
                   aes(yintercept = HLCref))

# points without internal gains
p2 <- geom_errorbar(data = selData %>% filter(Qi == "without Qi"),
                    aes(ymin=Estimate-`Standard deviation`, ymax=Estimate+`Standard deviation`), width=ebWidth)

p3 <- geom_point(data = selData %>% filter(Qi == "without Qi"),
                 size = ptSize, alpha = 0.5)

p4 <- geom_point(data = selData %>%
                     filter(grepl("No intercept", Intercept)),
                 colour = "white", size = ptSize*0.8)

p + p2 + p3 + p4 + pref

## HEAT INPUT - %DIFF
p <- selData %>% filter(Qi == "with Qi") %>%
    ggplot(mapping = aes(x = Approach, y = diffEstimate)) +
    facet_grid(`Test case` ~ Method, scales = "free_x") +
    geom_point(size = ptSize, alpha = ptAlpha) +
    geom_hline(yintercept = 0)

p2 <- geom_point(data = selData %>% filter(Qi == "without Qi"),
                 size = ptSize, alpha = 0.5)
                 
p3 <- geom_point(data = selData %>%
                     filter(grepl("No intercept", Intercept)),
                 colour = "white", size = ptSize*0.8)

p + p2 + p3
