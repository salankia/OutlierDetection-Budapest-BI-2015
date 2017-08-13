library(reshape2)
library(ggplot2)
library(plyr)
library(dplyr)

## source of the raw data is: http://pisa2012.acer.edu.au/downloads.php
load("data/pisa/raw/student2012.rda")

math.and.reading.by.cnt <- student2012 %>%
  group_by(CNT) %>%
  summarise(med.math = median(PV1MATH),
            med.read = median(PV1READ))

write.csv(math.and.reading.by.cnt,
          file="data/pisa/pisa.reduced.csv", row.names = F)
  
