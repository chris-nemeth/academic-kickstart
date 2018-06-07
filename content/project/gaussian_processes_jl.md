+++
# Date this page was created.
date = 2016-06-05T00:00:00

# Project title.
title = "GaussianProcesses.jl"

# Project summary to display on homepage.
summary = "A nonparametric Bayes package for the Julia language."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "poisson_gp.png"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = [""]

# Optional external URL for project (replaces project detail page).
external_link = "https://github.com/STOR-i/GaussianProcesses.jl"

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
#image = ""
#caption = ""

+++

A Gaussian process package for the Julia language. Gaussian processes are a family of stochastic processes which provide a flexible nonparametric tool for modelling data. The package allows for the modelling of Gaussian and non-Gaussian data, where in the case of Gaussian data, the posterior Gaussian process posterior distribution is derived analytically. For non-Gaussian data (e.g. classification), MCMC is used to sample from the non-analytic posterior distribution.