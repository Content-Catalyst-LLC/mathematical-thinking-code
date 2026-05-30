program quantification_ethics_matrix
  implicit none

  integer, parameter :: stages = 5
  integer, parameter :: dimensions = 4
  integer :: matrix(stages, dimensions)
  integer :: i, j

  character(len=16), dimension(stages) :: stage_names
  character(len=18), dimension(dimensions) :: dimension_names

  stage_names = (/ 'Define          ', 'Measure         ', 'Contextualize   ', 'Govern          ', 'Justice         ' /)
  dimension_names = (/ 'Validity          ', 'Uncertainty      ', 'Incentives       ', 'Contestability   ' /)

  matrix = reshape((/ &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1 /), shape(matrix))

  print *, 'Quantification ethics workflow matrix scaffold'
  do i = 1, stages
     write(*,'(A16,2X,4(I2,1X))') stage_names(i), (matrix(i,j), j=1,dimensions)
  end do

  print *, 'Columns: Validity, Uncertainty, Incentives, Contestability'
  print *, 'Interpretation: responsible quantification needs validity, uncertainty, incentive review, contestability, and justice.'

end program quantification_ethics_matrix
