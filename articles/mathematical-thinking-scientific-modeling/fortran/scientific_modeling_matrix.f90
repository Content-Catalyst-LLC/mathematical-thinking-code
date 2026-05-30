program scientific_modeling_matrix
  implicit none

  integer, parameter :: stages = 5
  integer, parameter :: dimensions = 4
  integer :: matrix(stages, dimensions)
  integer :: i, j

  character(len=16), dimension(stages) :: stage_names
  character(len=18), dimension(dimensions) :: dimension_names

  stage_names = (/ 'Represent       ', 'Relate          ', 'Test            ', 'Revise          ', 'Responsibility  ' /)
  dimension_names = (/ 'Assumptions      ', 'Data             ', 'Uncertainty      ', 'Validation       ' /)

  matrix = reshape((/ &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1 /), shape(matrix))

  print *, 'Scientific modeling workflow matrix scaffold'
  do i = 1, stages
     write(*,'(A16,2X,4(I2,1X))') stage_names(i), (matrix(i,j), j=1,dimensions)
  end do

  print *, 'Columns: Assumptions, Data, Uncertainty, Validation'
  print *, 'Interpretation: scientific modeling needs assumptions, evidence, uncertainty, validation, and responsible review.'

end program scientific_modeling_matrix
