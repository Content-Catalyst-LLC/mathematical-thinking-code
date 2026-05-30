program recurrence_audit
  implicit none

  integer :: n

  print *, "n factorial fibonacci arithmetic geometric"
  do n = 0, 20
     print *, n, factorial(n), fibonacci_iter(n), 3 + 5*n, 2 * 3**n
  end do

  print *, "merge sort recurrence costs for powers of two"
  do n = 0, 10
     print *, 2**n, merge_sort_cost(2**n)
  end do

contains

  integer(kind=8) function factorial(n)
    integer, intent(in) :: n
    integer :: i
    factorial = 1
    do i = 2, n
       factorial = factorial * i
    end do
  end function factorial

  integer(kind=8) function fibonacci_iter(n)
    integer, intent(in) :: n
    integer :: i
    integer(kind=8) :: previous, current, next_value

    if (n == 0) then
       fibonacci_iter = 0
       return
    end if

    if (n == 1) then
       fibonacci_iter = 1
       return
    end if

    previous = 0
    current = 1
    do i = 2, n
       next_value = previous + current
       previous = current
       current = next_value
    end do

    fibonacci_iter = current
  end function fibonacci_iter

  integer(kind=8) recursive function merge_sort_cost(n) result(cost)
    integer, intent(in) :: n
    if (n <= 1) then
       cost = 1
    else
       cost = 2 * merge_sort_cost(n / 2) + n
    end if
  end function merge_sort_cost

end program recurrence_audit
