# Load tidyvers
library(tidyverse)

# Load igraph
library(igraph)


# Create the friends1_edges tibble
name1_25 <- c("Joe", "Joe", "Joe", "Erin", "Kelley", "Ronald", "Ronald", "Ronald",
              "Michael", "Michael", "Michael", "Valentine", "Troy", "Troy", "Jasmine", "Jasmine",
              "Juan", "Carey", "Frankie", "Frankie", "Michael", "Michael", "Keith", "Keith", "Gregory")

name2_25 <- c("Ronald", "Michael", "Troy", "Kelley", "Valentine", "Troy", "Perry", "Jasmine", "Troy",
              "Jasmine", "Juan", "Perry", "Jasmine", "Juan", "Juan", "Carey", "Demetrius", "Frankie",
              "Michael", "Merle", "Merle", "Alex", "Gregory", "Marion", "Marion")

hours_25 <- c(1, 3, 2, 3, 5, 1, 3, 5, 2, 1, 3, 5, 3, 2, 6, 1, 2, 2, 1, 1, 2, 1, 1, 3, 2)

# Rename columns to match prev ex
friends1_edges <- tibble(name1 = name1_25, name2 = name2_25, hours = hours_25)

# Create the friends1_nodes tibble
name <- c("Joe", "Erin", "Kelley", "Ronald", "Michael", "Valentine", "Troy", "Jasmine",
          "Juan", "Carey", "Frankie", "Keith", "Gregory", "Perry", "Demetrius",
          "Merle", "Alex", "Marion")

gender <- c("M", "F", "F", "M", "M", "F", "M", "F", "M", "F", "M", "M", "M", "M",
            "M", "M", "F", "F")

friends1_nodes <- tibble(name, gender)

# Create an igraph object with attributes directly from dataframes
g1 <- graph_from_data_frame(d = friends1_edges, vertices = friends1_nodes, directed = FALSE)


# Subset edges greater than or equal to 5 hours
E(g1)[[hours >= 5]]  

# Set vertex color by gender
# "orange" for females and "dodgerblue" for males
V(g1)$color <- ifelse(V(g1)$gender == "F", "orange", "dodgerblue")

# Plot the graph
plot(g1, vertex.label.color = "black")

# Plot the graph object g1 in a circle layout
plot(g1, vertex.label.color = "black", layout = layout_in_circle(g1))

# Plot the graph object g1 in a Fruchterman-Reingold layout 
plot(g1, vertex.label.color = "black", layout = layout_with_fr(g1))

# Plot the graph object g1 in a Tree layout 
m <- layout_as_tree(g1)
plot(g1, vertex.label.color = "black", layout = m)

# Plot the graph object g1 using igraph's chosen layout 
m1 <- layout_nicely(g1)
plot(g1, vertex.label.color = "black", layout = m1)

# Visualizing edges

# Create a vector of weights based on the number of hours each pair spend together
w1 <- E(g1)$hours

# Plot the network varying edges by weights
m1 <- layout_nicely(g1)
plot(g1, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = w1,
     layout = m1)


# Create a new igraph object by deleting edges that are less than 2 hours long 
g2 <- delete_edges(g1, E(g1)[hours< 2])


# Plot the new graph 
w2 <- E(g2)$hours
m2 <- layout_nicely(g2)

plot(g2, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = w2,
     layout = m2)



