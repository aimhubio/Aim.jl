using Aim
using Test
using PyPlot

@testset "Aim.jl" begin
	run = Aim.Run(repo = ".tmp_julia", experiment = "julia_experiment")

	run.set(("hparams", "lr"), 0.001)

	for i in 1:5
		run.track(i, name = "test_metric")
	end
end
