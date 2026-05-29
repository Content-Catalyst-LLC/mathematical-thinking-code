program algebraic_equivalence
  implicit none

  integer :: x
  integer :: expanded
  integer :: factored
  real(kind=8) :: candidate
  real(kind=8) :: residual
  integer :: i
  real(kind=8), dimension(3) :: candidates

  print *, "x expanded factored agrees"
  do x = -10, 10
     expanded = 2*x + 6
     factored = 2*(x + 3)
     print *, x, expanded, factored, expanded == factored
  end do

  candidates = (/ 4.0d0, 5.0d0, 6.0d0 /)

  print *, "candidate residual passes"
  do i = 1, 3
     candidate = candidates(i)
     residual = 3.0d0*candidate + 2.0d0 - 17.0d0
     print *, candidate, residual, abs(residual) < 1.0d-10
  end do

  print *, "Finite audits support algebraic equivalence and verification; proof establishes identity."

end program algebraic_equivalence
