## Two functions that cache matrix definition and its inverse

## TEST CASE

## Create a simple 2x2 matrix

# m <- matrix(c(1, -1/4, -1/4, 1), nrow=2, ncol=2) 
# > m
#       [,1]  [,2]
# [1,]  1.00 -0.25
# [2,] -0.25  1.00

## Build a cache matrix object

# > m_cache <- makeCacheMatrix(m)

## Test cacheSolve by calling it two times
## 1st call computes the inverse 
## 2md call retrieves inverse from cache

# > cacheSolve(m_cache)
#           [,1]      [,2]
# [1,] 1.0666667 0.2666667
# [2,] 0.2666667 1.0666667

# > cacheSolve(m_cache)
# getting cached data
#           [,1]      [,2]
# [1,] 1.0666667 0.2666667
# [2,] 0.2666667 1.0666667


## Getters and Setters for a matrix and its inverse
## get, set operations for matrix
## setinv, getinv for matrix inverse
makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
          x <<- y
          m <<- NULL
        }
        get <- function() x
        setinv <- function(solve) m <<- solve
        getinv <- function() m
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}


## Operates on CacheMatrix object,
## calls solve function on matrix to compute inverse 
## and stores the solution with CacheMatrix object
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getinv()
        if(!is.null(m)) {
          message("getting cached data")
          return(m)
        }
        data <- x$get()
        m <- solve(data, ...)
        x$setinv(m)
        m
}
