library(readr)
library(CircStats)
library(ggplot2)
require(circular)

input.file = read_csv("author_times.csv")

hconv = 2*pi/24 

# row_idx = 8


# output.file = file("bots_hour_circular_stats.csv", "w")
for (row_idx in 1:nrow(input.file)){
  row = input.file[row_idx,]
  row_freq = as.numeric(row[2:length(row)])
  row_logFreq = log2(row_freq + 1)
  row_rad = 0:23*hconv 
  
  total = as.integer(sum(row_freq))
  
  if (total< 1000){
    next
  }
  
  h = c()
  h.log = c()
  z = c()

  for(i in 1:24){
    nrep = ceiling(row_freq[i])
    nrep.log = ceiling(row_logFreq[i])
    if(nrep > 0){
      h = c(h, rep(row_rad[i], nrep))
      h.log = c(h.log, rep(row_rad[i], nrep.log))
      z = c(z, rep(i, nrep))
    }
  }

  hsumm = circ.disp(row_rad) #, rads = TRUE, plot = TRUE) 
  hsumm.log = circ.disp(h.log) #, rads = TRUE, plot = TRUE)
  
   
  d = data.frame(Hour=z)
  d$Workday <- d$Hour %in% seq(9, 16)
  title = row[1]
  
  # pdf(file=sprintf("bot-plots/%d.pdf", row_idx), width=4, height=4.2)
  # par(mar=c(1,1,1,4))
  
  ggplot(d, aes(x = Hour, fill = Workday)) + 
    geom_histogram(breaks = seq(0, 24), binwidth = 1, colour = "grey") + 
    coord_polar(start = 0) + theme_minimal() + 
    scale_fill_brewer() + ylab("") + ggtitle(title) +
    scale_x_continuous("", limits = c(0, 24), breaks = seq(0, 24), 
                       labels = seq(0,24))+
    scale_y_continuous("") + 
    theme(axis.text.y=element_blank(),axis.ticks.y=element_blank(),
          axis.title.y=element_blank(),legend.position="none",
          plot.title = element_text(size=18), 
          axis.text=element_text(size=25))
  ggsave(paste("bot-plots/", row_idx, ".png", sep=""))
  # dev.off()
  # print(hsumm)
  # break
}
# close(output.file)


