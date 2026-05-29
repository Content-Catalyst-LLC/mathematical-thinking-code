program induction_audit
  implicit none

  integer, parameter :: nmax = 50
  integer :: n, k
  integer(kind=8) :: computed_sum
  integer(kind=8) :: formula_value
  logical :: agrees

  print *, "n computed_sum formula_value agrees"

  do n = 1, nmax
     computed_sum = 0
     do k = 1, n
        computed_sum = computed_sum + k
     end do
     formula_value = n * (n + 1) / 2
     agrees = computed_sum == formula_value
     print *, n, computed_sum, formula_value, agrees
  end do

  print *, "Finite agreement supports the theorem; induction supplies the proof."

end program induction_audit
