program algorithm_growth_audit
  implicit none

  integer :: n

  print *, "n log_proxy linear quadratic exponential_proxy merge_sort_cost"
  do n = 1, 20
     print *, n, log(real(n,8))/log(2.0_8), n, n*n, 2**min(n,30), merge_sort_cost(n)
  end do

  print *, "Interpretation: complexity analysis compares growth patterns under an abstract cost model."

contains

  integer recursive function merge_sort_cost(n) result(cost)
    integer, intent(in) :: n
    if (n <= 1) then
       cost = 1
    else
       cost = 2 * merge_sort_cost(n / 2) + n
    end if
  end function merge_sort_cost

end program algorithm_growth_audit
