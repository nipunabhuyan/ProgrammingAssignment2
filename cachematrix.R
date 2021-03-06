## This is to Create a cache marix object that can be used such that the next time the user 
## attempts to calculate the matrix inverse, the previously saved value is returned avoiding
## repeated calculation.

## This function creates a special "matrix" object, which is really a list 
## containing a function to
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
    ## create a matrix object x and some associated sub-functions/methods

    ## define the cache m
   m <- NULL
   set <- function(y) {
           x <<- y ## assign the input matrix y to the variable x in the parent environment

           m <<- NULL ## re-initialize m in the parent environment to null
   }
   get <- function() x ## return the matrix x
   setinverse <- function(inverse) m <<- inverse ## set the cache m equal to the inverse of the matrix x
   getinverse <- function() m ## return the cached inverse of x
   list(set = set, get = get,
      setinverse = setinverse,
      getinverse = getinverse)
}






## The following function returns the inverse of the "matrix" created
## with the above function by checking if the inverse is already been calculated.
## It helps skip the computation if already calculated and if not it calculates the matrix inverse
## and sets the value of the inverse in the cache using 'setinverse' function.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'

  m <- x$getinverse()
  if(!is.null(m)) {
      message("getting cached data")
      return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}
