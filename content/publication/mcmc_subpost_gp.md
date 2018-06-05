+++
title = "Merging MCMC Subposteriors through Gaussian-Process Approximations"
date = 2018-06-01T00:00:00

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Nemeth, C.", "Sherlock, C."]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference proceedings
# 2 = Journal
# 3 = Work in progress
# 4 = Technical report
# 5 = Book
# 6 = Book chapter
publication_types = ["2"]

# Publication name and optional abbreviated version.
publication = "*Bayesian Analysis* 13(2):507-530"
publication_short = "*Bayesian Analysis* 13(2):507-530"

# Abstract and optional shortened version.
abstract =" Markov chain Monte Carlo (MCMC) algorithms have become powerful tools for Bayesian inference. However, they do not scale well to large-data problems. Divide-and-conquer strategies, which split the data into batches and, for each batch, run independent MCMC algorithms targeting the corresponding subposterior, can spread the computational burden across a number of separate computer cores. The challenge with such strategies is in recombining the subposteriors to approximate the full posterior. By creating a Gaussian-process approximation for each log-subposterior density we create a tractable approximation for the full posterior. This approximation is exploited through three methodologies: firstly a Hamiltonian Monte Carlo algorithm targeting the expectation of the posterior density provides a sample from an approximation to the posterior; secondly, evaluating the true posterior at the sampled points leads to an importance sampler that, asymptotically, targets the true posterior expectations; finally, an alternative importance sampler uses the full Gaussian-process distribution of the approximation to the log-posterior density to re-weight any initial sample and provide both an estimate of the posterior expectation and a measure of the uncertainty in it."
abstract_short = ""


# Featured image thumbnail (optional)
image_preview = ""

# Is this a selected publication? (true/false)
selected = false

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
# projects = ["deep-learning"]

# Links (optional).
url_pdf = "https://projecteuclid.org/download/pdfview_1/euclid.ba/1502265628"
url_preprint = "https://arxiv.org/abs/1605.08576"
#url_code = "https://github.com/STOR-i/sgmcmc"
#url_blog = "https://xianblog.wordpress.com/2016/06/08/merging-mcmc-subposteriors/"

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#url_custom = [{name = "Custom Link", url = "http://example.org"}]

# Does the content use math formatting?
math = true

# Does the content use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
#image = "headers/bubbles-wide.jpg"
#caption = "My caption :smile:"

+++


