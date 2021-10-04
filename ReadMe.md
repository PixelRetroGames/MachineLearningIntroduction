## Numerical Methods and Machine Learning
Every part can be checked using its checkers called like "checker_part_x".
### Part 1 
 It was about implementing basic uninteresting stuff so I won't upload it. I will keep the other parts numbered from 2 in order to not modify the checkers.
### Part 2: K-Means
 Implementation of K-Means clustering algorithm using Forgy initialization. After intialization, I calculate a new set of centroids while they change. Every point is assigned to the cluster detemined by the closest centroid and after every point is assigned to a cluster, I recalculate the centroids. I also implemented a 2D representation that can be enabled by setting the variable draw to true.
### Part 3: Householder prediction
 Program that learns to distinquish between photos that contain cats and photos that don't. For a given dataset, the program will use either the RGB histogram or the HSV one and learn to recognize cat photos. It does so by using the Householder QR factorization. The precision is more than 85% for the test datasets.
### Part 4: Gradient Descent prediciton
 Iterative gradient descend implementation that solves a linear system Ax = b, used for recognizing cat photos too. Precision is more than 55%.
