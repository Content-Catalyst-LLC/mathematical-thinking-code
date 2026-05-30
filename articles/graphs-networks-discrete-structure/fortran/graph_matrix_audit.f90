program graph_matrix_audit
  implicit none

  integer, parameter :: n = 5
  integer :: adjacency(n,n)
  integer :: degree(n)
  integer :: i, j
  character(len=1), dimension(n) :: labels

  labels = (/ 'A', 'B', 'C', 'D', 'E' /)
  adjacency = 0

  call add_edge(adjacency, 1, 2)
  call add_edge(adjacency, 1, 3)
  call add_edge(adjacency, 2, 4)

  do i = 1, n
     degree(i) = 0
     do j = 1, n
        degree(i) = degree(i) + adjacency(i,j)
     end do
  end do

  print *, "vertex degree"
  do i = 1, n
     print *, labels(i), degree(i)
  end do

  print *, "degree_sum", sum(degree)
  print *, "twice_edge_count", 2 * 3
  print *, "Interpretation: adjacency matrices encode finite graph structure."

contains

  subroutine add_edge(matrix, a, b)
    integer, intent(inout) :: matrix(n,n)
    integer, intent(in) :: a, b
    matrix(a,b) = 1
    matrix(b,a) = 1
  end subroutine add_edge

end program graph_matrix_audit
