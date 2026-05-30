program foundation_structure_matrix
  implicit none

  integer, parameter :: views = 5
  integer, parameter :: structures = 5
  integer :: matrix(views, structures)
  integer :: i, j

  character(len=16), dimension(views) :: view_names
  character(len=16), dimension(structures) :: structure_names

  view_names = (/ 'SetTheoretic    ', 'Formalist       ', 'Intuitionist    ', 'Structural      ', 'Computational   ' /)
  structure_names = (/ 'Set             ', 'FormalSystem    ', 'Construction    ', 'Structure       ', 'Algorithm       ' /)

  matrix = reshape((/ &
      1,0,0,1,0, &
      0,1,0,1,0, &
      0,0,1,0,1, &
      1,1,0,1,0, &
      0,1,0,1,1 /), shape(matrix))

  print *, 'Foundation-structure matrix scaffold'
  do i = 1, views
     write(*,'(A16,2X,5(I2,1X))') view_names(i), (matrix(i,j), j=1,structures)
  end do

  print *, 'Columns: Set, FormalSystem, Construction, Structure, Algorithm'
  print *, 'Interpretation: synthetic teaching matrix, not a philosophical ranking.'

end program foundation_structure_matrix
