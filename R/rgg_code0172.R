require(ggplot2)

x = c(6, 7, 5, 6, 7, 8, 9, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 9, 10, 11, 12, 
    1, 2, 3, 10, 11, 12, 1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 13, 14, 1, 2, 3, 4, 
    9, 10, 11, 12, 13, 14, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 2, 
    6, 7, 11, 12, 2, 6, 7, 11, 12, 2, 6, 7, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 
    9, 10, 11, 12, 13, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 6, 
    7, 5, 6, 7, 8, 3, 5, 8, 10, 4, 5, 9, 10, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
    12)

y = c(4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 8, 
    8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 
    10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
    12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 15, 15, 15, 
    15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16, 
    16, 16, 16, 16, 16, 16, 16, 9, 9, 10, 10, 10, 10, 12, 12, 12, 12, 13, 13, 
    13, 13, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17)

color = c("burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "Maroon", "Maroon", "Maroon", "Maroon", "Maroon", "Maroon", 
    "Maroon", "Maroon", "Maroon", "Maroon", "Maroon", "Maroon", "Maroon", "Maroon", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2", 
    "burlywood2", "burlywood2", "burlywood2", "burlywood2", "burlywood2")
    
goldy = data.frame(Gopher = x, Goldy = y, color = color)

ggplot(data = goldy) + 
    geom_tile(aes(x = Gopher, y = Goldy, fill = color, width = 1)) + 
    scale_fill_identity() + 
    theme_bw()
