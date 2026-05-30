program proof_style_matrix
  implicit none

  integer, parameter :: traditions = 5
  integer, parameter :: styles = 4
  integer :: matrix(traditions, styles)
  integer :: i, j

  character(len=16), dimension(traditions) :: tradition_names
  character(len=16), dimension(styles) :: style_names

  tradition_names = (/ 'Mesopotamian    ', 'Greek           ', 'Chinese         ', 'Analysis        ', 'Computer        ' /)
  style_names = (/ 'Procedural      ', 'Deductive       ', 'Analytic        ', 'MachineChecked  ' /)

  matrix = reshape((/ &
      1,0,0,0, &
      0,1,0,0, &
      1,0,0,0, &
      0,0,1,0, &
      0,0,0,1 /), shape(matrix))

  print *, 'Proof-style matrix scaffold'
  do i = 1, traditions
     write(*,'(A16,2X,4(I2,1X))') tradition_names(i), (matrix(i,j), j=1,styles)
  end do

  print *, 'Columns: Procedural, Deductive, Analytic, MachineChecked'
  print *, 'Interpretation: synthetic classification, not historical ranking.'

end program proof_style_matrix
