program historical_understanding_matrix
  implicit none

  integer, parameter :: practices = 5
  integer, parameter :: dimensions = 4
  integer :: matrix(practices, dimensions)
  integer :: i, j

  character(len=18), dimension(practices) :: practice_names
  character(len=18), dimension(dimensions) :: dimension_names

  practice_names = (/ 'ScribalCalc       ', 'EuclideanGeometry ', 'SymbolicAlgebra   ', 'Modeling          ', 'ProofAssistant    ' /)
  dimension_names = (/ 'Object            ', 'Medium            ', 'Method            ', 'Meaning           ' /)

  matrix = reshape((/ &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1 /), shape(matrix))

  print *, 'Historical understanding matrix scaffold'
  do i = 1, practices
     write(*,'(A18,2X,4(I2,1X))') practice_names(i), (matrix(i,j), j=1,dimensions)
  end do

  print *, 'Columns: Object, Medium, Method, Meaning'
  print *, 'Interpretation: every mathematical practice should be interpreted across all four dimensions.'

end program historical_understanding_matrix
