# Simulation and verification demo for:
# "Mathematical Thinking in an Age of Automation"

function euler_decay(k, y0, dt, steps)
    y = y0
    values = Float64[]
    for _ in 1:steps
        push!(values, y)
        y = y + dt * (-k * y)
    end
    return values
end

k = 0.5
y0 = 1.0

runs = [
    ("dt_0_5", 0.5, 20),
    ("dt_0_25", 0.25, 40),
    ("dt_0_1", 0.1, 100)
]

println("Numerical simulation sensitivity demo")
for (label, dt, steps) in runs
    values = euler_decay(k, y0, dt, steps)
    println((run=label, dt=dt, final_value=last(values)))
end

println("\nInterpretation: automated simulation should be reviewed for step size sensitivity, stability, assumptions, and validation.")
