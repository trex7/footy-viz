## shotMapCreate from StatsBomb on tutorial

## https://statsbomb.com/wp-content/uploads/2021/11/Working-with-R.pdf page 51

#' Creating a shot plot for Statsbomb data using ggplot2
#'
#' @param df The data source to draw from (data frame)
#' @param t A string denoting the title of the graphic
#' @param st A string denoting the subtitle of the graphic
#' @param xG A boolean denoting if the graph should focus on xG or goals scored.
#' @return A plot of the pitch
#' @export

create_Shot_Map <- function(df, t, st, xG_and_footedness = FALSE, vanilla = FALSE, xG_for_Scale = FALSE) {
  library(ggplot2)
  
  shotmapxgcolors <- c("#192780", "#2a5d9f", "#40a7d0", "#87cdcf", "#e7f8e6", "#f4ef95", "#FDE960", "#FCDC5F",
                       "#F5B94D", "#F0983E", "#ED8A37", "#E66424", "#D54F1B", "#DC2608", "#BF0000", "#7F0000", "#5F0000")
  
  p <- ggplot() +
    annotate("rect",xmin = 0, xmax = 120, ymin = 0, ymax = 80, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 0, xmax = 60, ymin = 0, ymax = 80, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 18, xmax = 0, ymin = 18, ymax = 62, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 102, xmax = 120, ymin = 18, ymax = 62, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 0, xmax = 6, ymin = 30, ymax = 50, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 120, xmax = 114, ymin = 30, ymax = 50, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 120, xmax = 120.5, ymin =36, ymax = 44, fill = NA, colour = "black", size = 0.6) +
    annotate("rect",xmin = 0, xmax = -0.5, ymin =36, ymax = 44, fill = NA, colour = "black", size = 0.6) +
    annotate("segment", x = 60, xend = 60, y = -0.5, yend = 80.5, colour = "black", size = 0.6) +
    annotate("segment", x = 0, xend = 0, y = 0, yend = 80, colour = "black", size = 0.6) +
    annotate("segment", x = 120, xend = 120, y = 0, yend = 80, colour = "black", size = 0.6) +
    theme(rect = element_blank(),
          line = element_blank()) +
    # add penalty spot right
    annotate("point", x = 108 , y = 40, colour = "black", size = 1.05) +
    annotate("path", colour = "black", size = 0.6,
             x=60+10*cos(seq(0,2*pi,length.out=2000)),
             y=40+10*sin(seq(0,2*pi,length.out=2000))) +
    # add center spot
    annotate("point", x = 60 , y = 40, colour = "black", size = 1.05) +
    annotate("path", x=12+10*cos(seq(-0.3*pi,0.3*pi,length.out=30)), size = 0.6,
             y=40+10*sin(seq(-0.3*pi,0.3*pi,length.out=30)), col="black") +
    annotate("path", x=107.84-10*cos(seq(-0.3*pi,0.3*pi,length.out=30)), size = 0.6,
             y=40-10*sin(seq(-0.3*pi,0.3*pi,length.out=30)), col="black") +
    theme(axis.text.x=element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          plot.caption=element_text(size=13, hjust=0.5, vjust=0.5),
          plot.subtitle = element_text(size = 18, hjust = 0.5),
          axis.text.y=element_blank(),
          legend.position = "top",
          legend.title=element_text(size=22),
          legend.text=element_text(size=20),
          legend.margin = margin(c(20, 10, -85, 50)),
          legend.key.size = unit(1.5, "cm"),
          plot.title = element_text(margin = margin(r = 10, b = 10), face="bold",size = 32.5, colour = "black", hjust = 0.5),
          legend.direction = "horizontal",
          axis.ticks=element_blank(),
          aspect.ratio = c(65/100),
          plot.background = element_rect(fill = "white"),
          strip.text.x = element_text(size=13)) +
    labs(title = t, subtitle = st) +
    coord_flip(xlim = c(85, 125)) 
  
    if(xG_and_footedness == TRUE) {
      print("TRUE")
      p <- p + geom_point(data = df, aes(x = location.x, y = location.y, fill = shot.statsbomb_xg, shape = shot.body_part.name),
                   size = 6, alpha = 0.8) +
        scale_fill_gradientn(colours = shotmapxgcolors, limit = c(0,0.8), oob=scales::squish, name = "Expected Goals Value") +
        scale_shape_manual(values = c("Head" = 21, "Right Foot" = 23, "Left Foot" = 24), name ="") + 
        guides(fill = guide_colourbar(title.position = "top"), shape = guide_legend(override.aes = list(size = 7, fill = "black")))
    } else if (vanilla == TRUE) {
      print("FALSE")
      p <- p + geom_point(data = df, aes(x = location.x, y = location.y, color = goal_or_no_goal),
                          size = 6, alpha = 0.8) +
        scale_color_manual(values = c("#56B4E9", "#999999"))
    } else if (xG_for_Scale == TRUE) {
      p <- p +   geom_point(data = hk_shots_smaller, aes(x = location.x, y = location.y,
                                                         color = goal_or_no_goal, size = shot.statsbomb_xg),
                            alpha = 0.8) +
        scale_color_manual(values = c("#56B4E9", "#999999"))
    }
  
  return(p)
}
