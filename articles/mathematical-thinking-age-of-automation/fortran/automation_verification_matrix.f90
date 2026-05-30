program automation_verification_matrix
  implicit none

  integer, parameter :: tasks = 5
  integer, parameter :: stages = 4
  integer :: matrix(tasks, stages)
  integer :: i, j

  character(len=18), dimension(tasks) :: task_names
  character(len=18), dimension(stages) :: stage_names

  task_names = (/ 'Calculation       ', 'SymbolicCAS       ', 'Simulation        ', 'AIAssistant       ', 'ProofAssistant    ' /)
  stage_names = (/ 'Specify           ', 'Compute           ', 'Verify            ', 'Interpret         ' /)

  matrix = reshape((/ &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1, &
      1,1,1,1 /), shape(matrix))

  print *, 'Automation verification matrix scaffold'
  do i = 1, tasks
     write(*,'(A18,2X,4(I2,1X))') task_names(i), (matrix(i,j), j=1,stages)
  end do

  print *, 'Columns: Specify, Compute, Verify, Interpret'
  print *, 'Interpretation: every automated mathematical output should pass through all four stages.'

end program automation_verification_matrix
