library(readxl)
library(dplyr)
mortality <- read_excel("C:/Users/Joseph/Desktop/Grad studies MSc and Applications/AsthmaCEA2022/AsthmaCEA_Markov_2022_v4.xlsx", 
                                       sheet = "Sheet1")

mdf <- mortality %>% slice(rep(1:n(),52)) %>% arrange(Age)
  mdf$o.SCS_AF <- mdf$p.SCS_AF/(1-mdf$p.SCS_AF)
  mdf$o.ED_AF <- mdf$p.ED_AF/(1-mdf$p.ED_AF)
  mdf$o.HOSP_AF <- mdf$p.HOSP_AF/(1-mdf$p.HOSP_AF)

OR <- 2.6
  mdf$oSp.SCS_AF <- mdf$o.SCS_AF * OR
  mdf$oSp.ED_AF <- mdf$o.ED_AF * OR
  mdf$oSp.HOSP_AF <- mdf$p.HOSP_AF * OR
  
#Spitzer Probability
  mdf$pSp.SCS_AF <- mdf$oSp.SCS_AF/(1+mdf$oSp.SCS_AF)
  mdf$pSp.ED_AF <- mdf$oSp.ED_AF/(1+mdf$oSp.ED_AF)
  mdf$pSp.HOSP_AF <- mdf$oSp.HOSP_AF/(1+mdf$oSp.HOSP_AF)

mdf <- mdf %>% select(Age, b_mortality, p.SCS_AF, p.ED_AF, p.HOSP_AF, pSp.SCS_AF, pSp.ED_AF, pSp.HOSP_AF)
# mdf <- 1 - (1-mdf)^(1/52)
write.csv(mdf,"C:\\Users\\Joseph\\Desktop\\Grad studies MSc and Applications\\AsthmaCEA2022\\ASTHMA-CEA-2022\\mortality.csv")
