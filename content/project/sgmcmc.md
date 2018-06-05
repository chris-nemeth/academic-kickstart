+++
# Date this page was created.
date = 2016-06-05T00:00:00

# Project title.
title = "Stochastic gradient MCMC"

# Project summary to display on homepage.
summary = "An R package for stochastic gradient Markov chain Monte Carlo sampling."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = ""

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
#tags = ["deep-learning"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = ""
caption = ""

+++

An R package for stochastic gradient Markov chain Monte Carlo. The package implements a number of popular algorithms including SGLD, SGHMC and SGNHT. The package uses automatic differentiation, via the Tensorflow library, where all differentiation needed for the methods is calculated automatically. Control variate methods can be used in order to improve the efficiency of the methods as proposed in our paper Control variates for stochastic gradient MCMC.