program geometry_audit
  implicit none

  real(kind=8) :: ax, ay, bx, by, cx, cy
  real(kind=8) :: ab, bc, ca, orient, area
  real(kind=8) :: rx, ry
  real(kind=8) :: norm_before, norm_after

  ax = 0.0d0
  ay = 0.0d0
  bx = 4.0d0
  by = 0.0d0
  cx = 0.0d0
  cy = 3.0d0

  ab = sqrt((bx-ax)**2 + (by-ay)**2)
  bc = sqrt((cx-bx)**2 + (cy-by)**2)
  ca = sqrt((ax-cx)**2 + (ay-cy)**2)

  orient = (bx-ax)*(cy-ay) - (by-ay)*(cx-ax)
  area = abs(orient) / 2.0d0

  rx = -by
  ry = bx
  norm_before = bx*bx + by*by
  norm_after = rx*rx + ry*ry

  print *, "AB distance:", ab
  print *, "BC distance:", bc
  print *, "CA distance:", ca
  print *, "Orientation:", orient
  print *, "Area:", area
  print *, "Rotate90 B:", rx, ry
  print *, "Squared norm preserved:", abs(norm_before - norm_after) < 1.0d-10
  print *, "Geometry links coordinate computation to visual reasoning and verification."

end program geometry_audit
