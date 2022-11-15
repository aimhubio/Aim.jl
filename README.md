# Aim

A Julia wrapper around the [Aim open-source experiment tracker](https://aimstack.readthedocs.io/en/latest/):

Aim logs your training runs, enables a beautiful UI to compare them and an API to query them programmatically.

For a quick start of the library and to see how you can download the package and get started with it, you can read the [Get stated with Aim](https://aimstack.readthedocs.io/en/latest/quick_start/setup.html).

To see the code or report a bug, please visit the [GitHub repository](https://github.com/aimhubio/aim).

# Installation and usage

>Note: This Julia wrapper does not expose all of the functions in the [Aim API](https://aimstack.readthedocs.io/en/latest/refs/sdk.html) and it is limited to the Run API.

You need to have a Python distribution installed with the `aim` Python package. If you do not already have it, run `pip install aim` form the command line.


# Get started

It takes two steps to integrate Aim into your training script.

Step 1: Explicitly import the `Aim` module.

```julia
using Aim
```

Step 2: Initialize a new `Aim.Run` and start recording your hyperparameters and tracking your metrics.

```julia
run = aim.Run(repo = ".tmp_julia", experiment = "julia_experiment")
```

Check out a simple tracking example [here](https://github.com/aimhubio/aim/blob/main/examples/julia_track.jl).
