program unity_mode_matrix
  implicit none

  integer, parameter :: ideas = 5
  integer, parameter :: modes = 5
  integer :: matrix(ideas, modes)
  integer :: i, j

  character(len=16), dimension(ideas) :: idea_names
  character(len=16), dimension(modes) :: mode_names

  idea_names = (/ 'Quantity        ', 'Proportion      ', 'Proof           ', 'Structure       ', 'Computation     ' /)
  mode_names = (/ 'Pattern         ', 'Relation        ', 'Transform       ', 'Invariant       ', 'Evidence        ' /)

  matrix = reshape((/ &
      1,1,0,1,0, &
      1,1,1,1,0, &
      0,1,1,1,1, &
      1,1,1,1,1, &
      0,1,1,1,1 /), shape(matrix))

  print *, 'Unity-mode matrix scaffold'
  do i = 1, ideas
     write(*,'(A16,2X,5(I2,1X))') idea_names(i), (matrix(i,j), j=1,modes)
  end do

  print *, 'Columns: Pattern, Relation, Transformation, Invariant, Evidence'
  print *, 'Interpretation: synthetic teaching matrix, not a ranking of ideas.'

end program unity_mode_matrix
