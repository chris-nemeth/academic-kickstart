+++
title = "Parameter Estimation for State Space Models using Sequential Monte Carlo Algorithms"
date = 2014-11-01T00:00:00

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Nemeth, C."]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference proceedings
# 2 = Journal
# 3 = Work in progress
# 4 = Technical report
# 5 = Book
# 6 = Book chapter
publication_types = ["5"]

# Publication name and optional abbreviated version.
publication = "*Thesis*"
publication_short = "*Thesis*"

# Abstract and optional shortened version.
abstract = "State space models represent a flexible class of Bayesian time series models which can be applied to model latent state stochastic processes. Sequential Monte Carlo (SMC) algorithms, also known as particle filters, are perhaps the most widely used methodology for inference in such models, particularly when the model is nonlinear and cannot be evaluated analytically. The SMC methodology allows for the sequential analysis of state space models in online settings for fast inference, but can also be applied to study offline problems. This area of research has grown rapidly over the past 20 years and has lead to the development of important theoretical results. This thesis builds upon the SMC framework to address problems of parameter estimation for state space models. Due to the nonlinearity of some models, maximising the likelihood function of a state space model cannot be done analytically. This thesis proposes a new methodology for performing parameter estimation based on a gradient ascent algorithm, where the gradient is approximated using a particle filter. This new approach is shown to estimate parameters both online and offline and with a computational cost that is linear in the number of particles. This is an improvement over previously proposed approaches which either display quadratically increasing variance in the estimate of the gradient, or carry a computational cost which scales quadratically with the number of particles. Combining the advantages of SMC and Markov chain Monte Carlo (MCMC) the recently proposed particle MCMC methodology can be applied to estimate parameters. This thesis proposes a new class of efficient proposal distributions which take account of the geometry of the target density. This is achieved by using particle approximations of the gradient of the target within the proposal mechanism. Finally, a new algorithm is introduced for estimating piecewise time-varying parameters for target tracking problems."
abstract_short = ""

# Featured image thumbnail (optional)
image_preview = ""

# Is this a selected publication? (true/false)
selected = false

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
#projects = ["deep-learning"]

# Links (optional).
url_pdf = "local_files/Thesis.pdf"
url_preprint = ""
url_code = ""
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


