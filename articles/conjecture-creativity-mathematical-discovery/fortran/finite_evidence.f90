program finite_evidence
  implicit none

  integer, parameter :: nmax = 50
  integer :: n, k
  integer(kind=8) :: computed_sum
  integer(kind=8) :: formula_sum
  logical :: agrees

  print *, "n computed_sum formula_sum agrees evidence_status"

  do n = 1, nmax
     computed_sum = 0
     do k = 1, n
        computed_sum = computed_sum + k
     end do
     formula_sum = n * (n + 1) / 2
     agrees = computed_sum == formula_sum
     print *, n, computed_sum, formula_sum, agrees, "finite evidence"
  end do

  print *, "Finite agreement supports conjecture; induction proves the theorem."

end program finite_evidence
