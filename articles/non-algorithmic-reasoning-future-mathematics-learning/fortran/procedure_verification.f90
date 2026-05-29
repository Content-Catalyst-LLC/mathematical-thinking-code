program procedure_verification
  implicit none

  real(kind=8), dimension(3) :: candidates
  real(kind=8) :: x
  real(kind=8) :: residual
  integer :: i

  candidates = (/ 2.0d0, 3.0d0, 4.0d0 /)

  print *, "x residual passes"
  do i = 1, 3
     x = candidates(i)
     residual = x*x - 5.0d0*x + 6.0d0
     print *, x, residual, abs(residual) < 1.0d-10
  end do

  print *, "Procedure gives candidates; verification checks the original equation."

end program procedure_verification
