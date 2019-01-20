# Load tidyvers
library(tidyverse)

# Load igraph
library(igraph)

# Create the friends tibble (dataframe)
name1 = c("Jessie", "Jessie", "Sidney", "Sidney", "Karl", "Sidney", "Britt", "Shayne",
          "Sidney", "Sidney", "Jessie", "Donnie", "Sidney", "Rene", "Shayne", "Jessie",
          "Rene", "Elisha", "Eugene", "Berry", "Odell", "Odell", "Britt", "Elisha", "Lacy", "Britt", "Karl")

name2 = c("Sidney", "Britt", "Britt", "Donnie", "Berry", "Rene", "Rene", "Sidney", "Elisha",
          "Whitney", "Whitney", "Odell", "Odell", "Whitney", "Donnie", "Lacy", "Lacy", "Eugene",
          "Jude", "Odell", "Rickie", "Karl", "Lacy", "Jude", "Whitney", "Whitney", "Tommy")

friends <- tibble(
  name1,
  name2
)

# Convert friends dataframe to a matrix
friends.mat <- as.matrix(friends)

# Convert friends matrix to an igraph object
g <- graph.edgelist(friends.mat, directed = FALSE)

# Make a very basic plot of the network
plot(g)

# Subset vertices and edges
V(g)
E(g)

# Count number of edges
gsize(g)

# Count number of vertices
gorder(g)

# Create vertex attributes
genders <- c("M", "F", "F", "M", "M", "M", "F", "M", "M", "F", "M", "F", "M", "F", "M", "M")
ages <- c(18, 19, 21, 20, 22, 18, 23, 21, 22, 20, 20, 22, 21, 18, 19, 20)

# Inspect the objects 'genders' and 'ages'
genders
ages

# Create new vertex attribute called 'gender'
g <- set_vertex_attr(g, "gender", value = genders)

# Create new vertex attribute called 'age'
g <- set_vertex_attr(g, "age", value = ages)

# View all vertex attributes in a list
vertex_attr(g)

# View attributes of first five vertices in a dataframe
V(g)[[1:5]]

# Create edge attribute
hours <- c(1, 2, 2, 1, 2, 5, 5, 1, 1, 3, 2, 1, 1, 5, 1, 2, 4, 1, 3, 1, 1, 1, 4, 1, 3, 3, 4)

# Create new edge attribute called 'hours'
g <- set_edge_attr(g, "hours", value = hours)

# View edge attributes of graph object
edge_attr(g)

# Find all edges that include "Britt"
E(g)[[inc('Britt')]]  

# Find all pairs that spend 4 or more hours together per week
E(g)[[hours >= 4]] 


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
