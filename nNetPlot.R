# function to plot Neural Network
#
# Args:
#   nodes:  specifies the number of nodes in each layer
#           length(nodes) gives the total number of layers
#           (including input and output layers)
#
# Returns:
#           Plots the neural network connections diagram

nNetPlot <- function(nodes){
    
    nLayers <- length(nodes)
    
    nodeSum <- sapply( 1:length(nodes), function(x) sum(nodes[1:x]) )
    nodeSum <- c(0, nodeSum)
    
    # positions of layers along x
    
    xNnT <- seq(0, 1, length.out = (nLayers+2))
    
    xNn <- xNnT[2:(length(xNnT)-1)]
    
    xBn <- xNnT[2:(length(xNnT)-2)]
    
    # positions of nodes along y.
    
    xPos <- rep(0, sum(nodes))
    yPos <- rep(0, sum(nodes))
    yBn <- rep(0, length(nodes)-1)
    for (k in 1:length(nodes)){
        
        i <- nodes[k]
        
        yNnT <- seq(0, 1, length.out = (i+3))
        
        yNn <- yNnT[2:(length(yNnT)-2)]
        
        # postion of bias node along y
        if(k < length(nodes)){
            yBn[k] <- yNnT[(length(yNnT)-1)]
        }
        
        ind <- (nodeSum[k]+1):nodeSum[k+1]
        
        xPos[ind] <- rep(xNn[k], i)
        
        yPos[ind] <- yNn
        
    }
    
    
    # Plotting
    
    temp <- par()
    actMar <- temp$mar
    
    par(mar = c(0.1, 0.1, 0.1, 0.1))
    
    plot(1, type = "n", xlim = c(0,1), ylim = c(0,1))
    
    for (i in 1:(length(nodes)-1)){
        
        # plot lines 
        # from: node j in layer i
        # to:   node k in layer i+1
        for (j in 1:nodes[i]){
            
            ind1 <- (nodeSum[i]+j)
            
            for (k in 1:nodes[i+1]){
            
                ind2 <- nodeSum[i+1] + k
                ind <- c(ind1 , ind2)
                lines(xPos[ind], yPos[ind])    
            }
            
            
        }
        
        # plot bias node lines
        for (k in 1:nodes[i+1]){
            
            ind <- nodeSum[i+1] + k
            
            lines(c(xBn[i], xPos[ind]), 
                  c(yBn[i], yPos[ind])
                  )    
        }
        
    }
        
    # plot all nodes
    points(xPos, yPos, 
           pch = 21, 
           cex = 3, 
           lwd = 3,
           col = rgb(0, 0, 0),
           bg  = rgb(1, 1, 1)
           )
    
    # plot bias nodes
    points(xBn, yBn, 
           pch = 21, 
           cex = 3, 
           lwd = 3,
           col = rgb(0, 0, 0, 0.5),
           bg  = rgb(1, 1, 1)
           )
    
}
