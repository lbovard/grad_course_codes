pdf("foo.pdf")
x<-scan("x_coords")
y<-scan("y_coords")
library(gplots);
hist2d(x,y,nbins=100,col=c("white",heat.colors(12)),xlim=c(-2,2),ylim=c(0,3), ann=FALSE)
dev.off()
