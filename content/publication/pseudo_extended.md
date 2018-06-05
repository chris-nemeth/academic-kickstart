+++
title = "Pseudo-extended Makov chain Monte Carlo"
date = 2017-08-17T00:00:00

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Nemeth, C.", "Lindsten, F.", "Filippone, M.","Hensman, J."]

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
publication = "ArXiv *(in submission)*"
publication_short = "ArXiv *(in submission)*"

# Abstract and optional shortened version.
abstract = "Sampling from the posterior distribution using Markov chain Monte Carlo (MCMC) methods can require an exhaustive number of iterations to fully explore the correct posterior. This is often the case when the posterior of interest is multi-modal, as the MCMC sampler can become trapped in a local mode for a large number of iterations. In this paper, we introduce the pseudo-extended MCMC method as an approach for improving the mixing of the MCMC sampler in complex posterior distributions. The pseudo-extended method augments the state-space of the posterior using pseudo-samples as auxiliary variables, where on the extended space, the MCMC sampler is able to easily move between the well-separated modes of the posterior. We apply the pseudo-extended method within an Hamiltonian Monte Carlo sampler and show that by using the No U-turn algorithm (Hoffman and Gelman, 2014), our proposed sampler is completely tuning free. We compare the pseudo-extended method against well-known tempered MCMC algorithms and show the advantages of the new sampler on a number of challenging examples from the statistics literature."
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
url_pdf = ""
url_preprint = "https://arxiv.org/abs/1708.05239"
url_code = "https://github.com/chris-nemeth/pseudo-extended-mcmc-code"
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


