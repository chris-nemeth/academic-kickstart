+++
title = "Control Variates for Stochastic Gradient MCMC"
date = 2017-06-16T00:00:00

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Baker, J.", "Fearnhead, P.", "Fox, E.B.", "Nemeth, C."]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference proceedings
# 2 = Journal
# 3 = Work in progress
# 4 = Technical report
# 5 = Book
# 6 = Book chapter
publication_types = ["4"]

# Publication name and optional abbreviated version.
publication = "ArXiv *(in submission)*."
publication_short = "ArXiv *(in submission)*."

# Abstract and optional shortened version.
abstract = "It is well known that Markov chain Monte Carlo (MCMC) methods scale poorly with dataset size. A popular class of methods for solving this issue is stochastic gradient MCMC. These methods use a noisy estimate of the gradient of the log posterior, which reduces the per iteration computational cost of the algorithm. Despite this, there are a number of results suggesting that stochastic gradient Langevin dynamics (SGLD), probably the most popular of these methods, still has computational cost proportional to the dataset size. We suggest an alternative log posterior gradient estimate for stochastic gradient MCMC, which uses control variates to reduce the variance. We analyse SGLD using this gradient estimate, and show that, under log-concavity assumptions on the target distribution, the computational cost required for a given level of accuracy is independent of the dataset size. Next we show that a different control variate technique, known as zero variance control variates can be applied to SGMCMC algorithms for free. This post-processing step improves the inference of the algorithm by reducing the variance of the MCMC output. Zero variance control variates rely on the gradient of the log posterior; we explore how the variance reduction is affected by replacing this with the noisy gradient estimate calculated by SGMCMC."
abstract_short = ""

# Featured image thumbnail (optional)
image_preview = ""

# Is this a selected publication? (true/false)
selected = false

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
projects = ["deep-learning"]

# Links (optional).
url_pdf = ""
url_preprint = "https://arxiv.org/abs/1706.05439"
url_code = "https://github.com/STOR-i/sgmcmc"
url_dataset = ""
url_project = ""
url_slides = ""
url_video = ""
url_poster = ""
url_source = ""

# Does the content use math formatting?
math = true

# Does the content use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = ""
caption = ""

+++


