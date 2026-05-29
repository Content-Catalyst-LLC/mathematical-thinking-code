program truth_tables
  implicit none

  logical, dimension(2) :: values
  logical :: p, q, implication, contrapositive
  integer :: i, j

  values = (/ .false., .true. /)

  print *, "P Q P_implies_Q not_Q_implies_not_P equivalent"

  do i = 1, 2
     do j = 1, 2
        p = values(i)
        q = values(j)
        implication = (.not. p) .or. q
        contrapositive = q .or. (.not. p)
        print *, p, q, implication, contrapositive, implication .eqv. contrapositive
     end do
  end do

  print *, "Truth tables inspect propositional form."

end program truth_tables
