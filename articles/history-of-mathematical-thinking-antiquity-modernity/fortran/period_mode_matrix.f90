program period_mode_matrix
  implicit none

  integer, parameter :: periods = 5
  integer, parameter :: modes = 5
  integer :: matrix(periods, modes)
  integer :: i, j

  character(len=16), dimension(periods) :: period_names
  character(len=16), dimension(modes) :: mode_names

  period_names = (/ 'Antiquity       ', 'Classical       ', 'Medieval        ', 'Modern          ', 'Contemporary    ' /)
  mode_names = (/ 'Procedural      ', 'Deductive       ', 'Algebraic       ', 'Structural      ', 'FormalVerified  ' /)

  matrix = reshape((/ &
      1,0,0,0,0, &
      0,1,0,0,0, &
      1,0,1,0,0, &
      0,1,1,1,0, &
      0,0,0,1,1 /), shape(matrix))

  print *, 'Period-mode matrix scaffold'
  do i = 1, periods
     write(*,'(A16,2X,5(I2,1X))') period_names(i), (matrix(i,j), j=1,modes)
  end do

  print *, 'Columns: Procedural, Deductive, Algebraic, Structural, FormalVerified'
  print *, 'Interpretation: synthetic classification, not historical ranking.'

end program period_mode_matrix
