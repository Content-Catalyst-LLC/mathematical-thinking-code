program sequence_audit
  implicit none

  integer, parameter :: nmax = 20
  integer :: n, k
  integer(kind=8) :: computed_sum
  integer(kind=8) :: formula_sum
  integer :: cycle_value

  print *, "Triangular number finite evidence audit"
  print *, "n computed_sum formula_sum agrees"

  do n = 1, nmax
     computed_sum = 0
     do k = 1, n
        computed_sum = computed_sum + k
     end do
     formula_sum = n * (n + 1) / 2
     print *, n, computed_sum, formula_sum, computed_sum == formula_sum
  end do

  print *, "Cycle pattern n mod 4"
  print *, "n value"
  do n = 0, 15
     cycle_value = mod(n, 4)
     print *, n, cycle_value
  end do

  print *, "Finite evidence supports pattern recognition; proof gives general justification."

end program sequence_audit
