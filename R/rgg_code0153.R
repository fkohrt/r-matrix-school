set.seed( 1 ) # for reproducibility of this exact graph

require(network) # network
require(sna) # plot.network
require(Hmisc) # largest.empty
  
# Create some data.

con <- textConnection("name,age,jobyrs,inc,saved,int,chld,addryrs
Adam,21,1,46,110,3.9,2.62,16.46
Ben,32,6,82,110,3.9,2.875,17.02
Chris,22,2,38,93,3.85,2.32,18.61
David,46,16,158,110,3.08,3.215,19.44
Elvin,58,4,110,175,3.15,3.44,17.02
Fred,18,1,25,105,2.76,3.46,20.22
Greg,23,1,60,245,3.21,3.57,15.84
Henry,44,12,46,62,3.69,3.19,20
Ivan,32,2,40,95,3.92,3.15,22.9
James,29,5,67,123,3.92,3.44,18.3
Kevin,27,10,67,123,3.92,3.44,18.9
Luke,46,18,75,180,3.07,4.07,17.4")
nodelist <-read.csv(con)
close( con ) 

con <- textConnection("from,to
Adam,Ben
Adam,Chris
Chris,David
Chris,Elvin
David,Fred
Fred,Greg
Greg,Henry
Henry,James
Henry,Ivan
James,Kevin
Ivan,Kevin
Kevin,Luke")

edgelist <- read.csv(con)
close( con )

nodes <- levels(as.factor(nodelist[[1]]))

# Create a matrix to represent the network.

m <- matrix(data = 0, nrow=length(nodes), ncol=length(nodes))
rownames(m) <- colnames(m) <- nodes

apply(edgelist, 1, function(x) m[x[[1]], x[[2]]] <<- 1)

graph <- network(m, matrix.type="adjacency")

# Now plot the network, without the nodes.

par(xpd=TRUE)
xy <- plot(graph, vertex.cex=5, vertex.col="white", vertex.border=0)

# Get the some other data from the nodes and generate a plot for
# each node and place them onto the network. Include a Key at some
# empty space.

kl <- largest.empty(xy[,1], xy[,2], 2, 2)

stars(nodelist[-1], labels=nodelist[[1]], locations=xy, draw.segments=TRUE,
      key.loc=c(kl$x, kl$y), add=TRUE)
  
