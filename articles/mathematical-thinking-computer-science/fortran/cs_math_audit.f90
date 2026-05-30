program cs_math_audit
  implicit none

  integer :: n
  real(8), dimension(2,2) :: A
  real(8), dimension(2) :: x, y

  A = reshape((/ 2.0_8, 0.0_8, 0.0_8, 3.0_8 /), shape(A))
  x = (/ 4.0_8, 5.0_8 /)
  y = matmul(A, x)

  print *, "n log_proxy linear quadratic exponential_proxy"
  do n = 1, 20
     print *, n, log(real(n,8))/log(2.0_8), n, n*n, 2**min(n,30)
  end do

  print *, "matrix transform y = A x"
  print *, y

  print *, "merge sort recurrence costs"
  do n = 0, 10
     print *, 2**n, merge_sort_cost(2**n)
  end do

contains

  integer recursive function merge_sort_cost(n) result(cost)
    integer, intent(in) :: n
    if (n <= 1) then
       cost = 1
    else
       cost = 2 * merge_sort_cost(n / 2) + n
    end if
  end function merge_sort_cost

end program cs_math_audit
