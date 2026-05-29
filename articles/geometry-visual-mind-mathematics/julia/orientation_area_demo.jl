# Orientation and area demo for:
# "Geometry and the Visual Mind in Mathematics"

struct Point2D
    x::Float64
    y::Float64
end

function distance(a::Point2D, b::Point2D)
    return sqrt((b.x - a.x)^2 + (b.y - a.y)^2)
end

function orientation(a::Point2D, b::Point2D, c::Point2D)
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
end

function triangle_area(a::Point2D, b::Point2D, c::Point2D)
    return abs(orientation(a, b, c)) / 2
end

function rotate90(p::Point2D)
    return Point2D(-p.y, p.x)
end

a = Point2D(0.0, 0.0)
b = Point2D(4.0, 0.0)
c = Point2D(0.0, 3.0)

println("Side AB: ", distance(a, b))
println("Side BC: ", distance(b, c))
println("Side CA: ", distance(c, a))
println("Orientation determinant: ", orientation(a, b, c))
println("Triangle area: ", triangle_area(a, b, c))
println("Rotated B: ", rotate90(b))
println("Interpretation: orientation encodes signed area and visual left/right turn structure.")
