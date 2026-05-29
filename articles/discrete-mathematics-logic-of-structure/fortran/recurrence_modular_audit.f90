program recurrence_modular_audit
  implicit none

  integer, parameter :: nmax = 20
  integer :: n
  integer(kind=8) :: previous, current, next_value
  integer(kind=8) :: fib_values(0:nmax)

  fib_values(0) = 0
  fib_values(1) = 1
  previous = 0
  current = 1

  do n = 2, nmax
     next_value = previous + current
     fib_values(n) = next_value
     previous = current
     current = next_value
  end do

  print *, "n fibonacci residue_mod_7"
  do n = 0, nmax
     print *, n, fib_values(n), mod(n, 7)
  end do

  print *, "Boolean truth table P Q AND OR IMPLIES"
  call print_boolean_table()

contains

  subroutine print_boolean_table()
    logical :: p, q
    integer :: i, j

    do i = 0, 1
       p = (i == 1)
       do j = 0, 1
          q = (j == 1)
          print *, p, q, (p .and. q), (p .or. q), ((.not. p) .or. q)
       end do
    end do
  end subroutine print_boolean_table

end program recurrence_modular_audit
