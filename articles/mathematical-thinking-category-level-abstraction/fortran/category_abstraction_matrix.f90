program category_abstraction_matrix
  implicit none

  integer, parameter :: stages = 5
  integer, parameter :: dimensions = 4
  integer :: matrix(stages, dimensions)
  integer :: i, j

  character(len=16), dimension(stages) :: stage_names
  character(len=18), dimension(dimensions) :: dimension_names

  stage_names = (/ 'Objects         ', 'Arrows          ', 'Structure       ', 'Universality    ', 'Responsibility  ' /)
  dimension_names = (/ 'Definition        ', 'Examples          ', 'ProofRole         ', 'RiskReview        ' /)

  matrix = reshape((/ &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1 /), shape(matrix))

  print *, 'Category-level abstraction workflow matrix scaffold'
  do i = 1, stages
     write(*,'(A16,2X,4(I2,1X))') stage_names(i), (matrix(i,j), j=1,dimensions)
  end do

  print *, 'Columns: Definition, Examples, ProofRole, RiskReview'
  print *, 'Interpretation: category-level abstraction needs examples, proof roles, and responsible review.'

end program category_abstraction_matrix
