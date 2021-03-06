library(TSCAN)
library(ggplot2)
my.TSCAN =  function(count, cellLabels){
  colnames(count) = c(1:ncol(count))
  procdata <- TSCAN::preprocess(count)
  lpsmclust <- TSCAN::exprmclust(procdata)
  
  lpsorder <- TSCAN::TSCANorder(lpsmclust, orderonly=F)
  
  Pseudotime = lpsorder$Pseudotime[match(colnames(count),lpsorder$sample_name)]
  cor.kendall = cor(Pseudotime, as.numeric(cellLabels), method = "kendall", use = "complete.obs")
  subpopulation <- data.frame(cell = colnames(count), sub = as.numeric(cellLabels)-1)
  POS <- orderscore(subpopulation, lpsorder)[1]
  out = list(cor.kendall=abs(cor.kendall), POS=abs(POS))
  out
  #Pseudotime
}
plotmclust2 <- function (mclustobj,cellLabels, x = 1, y = 2, MSTorder = NULL, show_tree = T, 
                         show_cell_names = F, cell_name_size = 3, markerexpr = NULL) 
{
  color_by = 'cellLabels' # color_by = "State"
  lib_info_with_pseudo <- data.frame(State = mclustobj$clusterid, 
                                     sample_name = names(mclustobj$clusterid),
                                     cellLabels = cellLabels)
  lib_info_with_pseudo$State <- factor(lib_info_with_pseudo$State)
  S_matrix <- mclustobj$pcareduceres
  pca_space_df <- data.frame(S_matrix[, c(x, y)])
  colnames(pca_space_df) <- c("pca_dim_1", "pca_dim_2")
  pca_space_df$sample_name <- row.names(pca_space_df)
  edge_df <- merge(pca_space_df, lib_info_with_pseudo, by.x = "sample_name", 
                   by.y = "sample_name")
  edge_df$markerexpr <- markerexpr[edge_df$sample_name]
  if (!is.null(markerexpr)) {
    g <- ggplot(data = edge_df, aes(x = pca_dim_1, y = pca_dim_2, 
                                    size = markerexpr))
    g <- g + geom_point(aes_string(color = color_by), na.rm = TRUE)
  }
  else {
    g <- ggplot(data = edge_df, aes(x = pca_dim_1, y = pca_dim_2))
    g <- g + geom_point(aes_string(color = color_by), na.rm = TRUE, 
                        size = 3)
  }
  if (show_cell_names) {
    g <- g + geom_text(aes(label = sample_name), size = cell_name_size)
  }
  if (show_tree) {
    clucenter <- mclustobj$clucenter[, c(x, y)]
    clulines <- NULL
    if (is.null(MSTorder)) {
      allsp <- shortest.paths(mclustobj$MSTtree)
      longestsp <- which(allsp == max(allsp), arr.ind = T)
      MSTorder <- get.shortest.paths(mclustobj$MSTtree, 
                                     longestsp[1, 1], longestsp[1, 2])$vpath[[1]]
    }
    for (i in 1:(length(MSTorder) - 1)) {
      clulines <- rbind(clulines, c(clucenter[MSTorder[i], 
                                              ], clucenter[MSTorder[i + 1], ]))
    }
    clulines <- data.frame(x = clulines[, 1], xend = clulines[, 
                                                              3], y = clulines[, 2], yend = clulines[, 4])
    g <- g + geom_segment(aes_string(x = "x", xend = "xend", 
                                     y = "y", yend = "yend", size = NULL), data = clulines, 
                          size = 1)
    clucenter <- data.frame(x = clucenter[, 1], y = clucenter[, 
                                                              2], id = 1:nrow(clucenter))
    #g <- g + geom_text(aes_string(label = "id", x = "x", 
    #y = "y", size = NULL), data = clucenter, size = 10)
  }
  g <- g + guides(colour = guide_legend(override.aes = list(size = 5))) + 
    xlab(paste0("PCA_dimension_", x)) + ylab(paste0("PCA_dimension_", 
                                                    y)) + theme(panel.border = element_blank(), axis.line = element_line()) + 
    theme(panel.grid.minor.x = element_blank(), panel.grid.minor.y = element_blank()) + 
    theme(panel.grid.major.x = element_blank(), panel.grid.major.y = element_blank()) + 
    theme(legend.position = "right", legend.key.size = unit(0.3, 
                                                          "in"), legend.text = element_text(size = 10), legend.title = element_text(size = 10)) + 
    theme(legend.key = element_blank()) + theme(panel.background = element_rect(fill = "white")) + 
    theme(axis.text.x = element_text(size = 17, color = "darkred"), 
          axis.text.y = element_text(size = 17, color = "black"), 
          axis.title.x = element_text(size = 20, vjust = -1), 
          axis.title.y = element_text(size = 20, vjust = 1), 
          plot.margin = unit(c(1, 1, 1, 1), "cm"))
  g
}