program combinatorics_audit
  implicit none

  integer :: n, k

  print *, "Pascal row values through n=12"
  do n = 0, 12
     write(*,'(A,I2,A)', advance='no') "n=", n, ": "
     do k = 0, n
        write(*,'(I8)', advance='no') binomial(n, k)
     end do
     print *
  end do

  print *, "Fibonacci tiling counts"
  do n = 0, 20
     print *, n, fibonacci_tilings(n)
  end do

  print *, "Inclusion-exclusion multiples of 2 or 3 through 100:"
  print *, 100 / 2 + 100 / 3 - 100 / 6

contains

  integer(kind=8) function factorial(n)
    integer, intent(in) :: n
    integer :: i
    factorial = 1
    do i = 2, n
       factorial = factorial * i
    end do
  end function factorial

  integer(kind=8) function binomial(n, k)
    integer, intent(in) :: n, k
    binomial = factorial(n) / (factorial(k) * factorial(n - k))
  end function binomial

  integer(kind=8) function fibonacci_tilings(n)
    integer, intent(in) :: n
    integer :: i
    integer(kind=8) :: previous, current, next_value

    if (n == 0 .or. n == 1) then
       fibonacci_tilings = 1
       return
    end if

    previous = 1
    current = 1

    do i = 2, n
       next_value = previous + current
       previous = current
       current = next_value
    end do

    fibonacci_tilings = current
  end function fibonacci_tilings

end program combinatorics_audit
