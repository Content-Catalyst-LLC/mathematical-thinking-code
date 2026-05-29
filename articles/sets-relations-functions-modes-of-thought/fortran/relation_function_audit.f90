program relation_function_audit
  implicit none

  integer, parameter :: n = 4
  integer :: domain(n)
  logical :: rel(n,n)
  integer :: i, j
  logical :: reflexive, symmetric, transitive

  domain = (/ 1, 2, 3, 4 /)

  do i = 1, n
     do j = 1, n
        rel(i,j) = mod(domain(i), 2) == mod(domain(j), 2)
     end do
  end do

  reflexive = .true.
  do i = 1, n
     if (.not. rel(i,i)) reflexive = .false.
  end do

  symmetric = .true.
  do i = 1, n
     do j = 1, n
        if (rel(i,j) .and. (.not. rel(j,i))) symmetric = .false.
     end do
  end do

  transitive = .true.
  do i = 1, n
     do j = 1, n
        if (rel(i,j)) then
           if (.not. transitive_from(i,j,rel,n)) transitive = .false.
        end if
     end do
  end do

  print *, "mod2 relation properties"
  print *, "reflexive:", reflexive
  print *, "symmetric:", symmetric
  print *, "transitive:", transitive
  print *, "Interpretation: finite relation matrices support relation-property audits."

contains

  logical function transitive_from(i, j, rel, n)
    integer, intent(in) :: i, j, n
    logical, intent(in) :: rel(n,n)
    integer :: k

    transitive_from = .true.
    do k = 1, n
       if (rel(j,k) .and. (.not. rel(i,k))) transitive_from = .false.
    end do
  end function transitive_from

end program relation_function_audit
