program proof_assistant_matrix
  implicit none

  integer, parameter :: stages = 5
  integer, parameter :: dimensions = 4
  integer :: matrix(stages, dimensions)
  integer :: i, j

  character(len=16), dimension(stages) :: stage_names
  character(len=16), dimension(dimensions) :: dimension_names

  stage_names = (/ 'Define          ', 'State           ', 'Prove           ', 'Check           ', 'Interpret       ' /)
  dimension_names = (/ 'HumanRole       ', 'MachineRole     ', 'TrustBoundary   ', 'RiskReview      ' /)

  matrix = reshape((/ &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1 /), shape(matrix))

  print *, 'Proof-assistant workflow matrix scaffold'
  do i = 1, stages
     write(*,'(A16,2X,4(I2,1X))') stage_names(i), (matrix(i,j), j=1,dimensions)
  end do

  print *, 'Columns: HumanRole, MachineRole, TrustBoundary, RiskReview'
  print *, 'Interpretation: every proof-assistant stage needs human and machine role separation.'

end program proof_assistant_matrix
