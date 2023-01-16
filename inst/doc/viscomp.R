## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----setup--------------------------------------------------------------------
library(viscomp)
data("MACE")

## ---- message = FALSE, warning=FALSE------------------------------------------
library(netmeta)
data_NMA <- pairwise(studlab = Study, 
                      treat = list(treat1, treat2, treat3, treat4),
                      n = list(n1, n2, n3, n4), 
                      event = list(event1, event2, event3, event4), 
                      data = MACE,
                      sm = "OR" )

net <- netmeta(TE = TE, 
               seTE = seTE, 
               studlab = studlab, 
               treat1 = treat1,
               treat2 = treat2, 
               data = data_NMA, 
               small.values = "good",
               ref = "UC")

## ---- fig.width = 8.5, fig.height = 6, out.width="100%"-----------------------
compdesc(net)

## ---- fig.width = 7.5, fig.height = 6, out.width="100%"-----------------------
compGraph(net, mostF = 10, title = "")

## ---- fig.width = 7.5, fig.height = 6, out.width="100%"-----------------------
compGraph(net, mostF = 10, title = "", excl = "UC")

## ---- fig.width = 7.2, fig.height = 6-----------------------------------------
heatcomp(net)

## ---- fig.width=10, out.width="100%", fig.height = 7.5------------------------
specc(net)

## ---- fig.width = 8, out.width="100%", fig.height = 7.5-----------------------
specc(net, combination = c("A", "A + B", "A + B + C"))

## ---- fig.width = 7.2, fig.height = 7.5, out.width="100%"---------------------
specc(net, components_number = TRUE)

## ---- fig.width = 7.2, fig.height = 7.5, out.width="100%"---------------------
specc(net, components_number = TRUE, groups = c(1, 2, "1-2", "2+"))

## ---- fig.width = 7.2, fig.height = 6-----------------------------------------
denscomp(net, combination = "A+B")

## ---- fig.width = 7.2, fig.height = 6-----------------------------------------
denscomp(net, combination = c("A", "A + B", "A + B + C"))

## ---- fig.width = 7.2, fig.height = 6-----------------------------------------
loccos(net, combination = "A", histogram = FALSE)

## ---- fig.width = 7.2, fig.height = 6-----------------------------------------
watercomp(net, combination = "A")

## ---- eval = TRUE-------------------------------------------------------------
t1 <- c("A", "B", "C", "A+B", "A+C", "B+C", "A")
t2 <- c("C", "A", "A+C", "B+C", "A", "B", "B+C")

TE1 <- c(2.12, 3.24, 5.65, -0.60, 0.13, 0.66, 3.28)
TE2 <- c(4.69, 2.67, 2.73, -3.41, 1.79, 2.93, 2.51)

seTE1 <- rep(0.1, 7)
seTE2 <- rep(0.2, 7)

study <- paste0("study_", 1:7)

data1 <- data.frame("TE" = TE1, 
                    "seTE" = seTE1, 
                    "treat1" = t1, 
                    "treat2" = t2, 
                    "studlab" = study,
                    stringsAsFactors = FALSE)

data2 <- data.frame("TE" = TE2, 
                    "seTE" = seTE2, 
                    "treat1" = t1, 
                    "treat2" = t2, 
                    "studlab" = study,
                    stringsAsFactors = FALSE)

net1 <- netmeta(TE = TE, 
                seTE = seTE, 
                studlab = studlab, 
                treat1 = treat1,
                treat2 = treat2, 
                data = data1, 
                ref = "A")

net2 <- netmeta::netmeta(TE = TE, 
                         seTE = seTE, 
                         studlab = studlab, 
                         treat1 = treat1,
                         treat2 = treat2, 
                         data = data2, 
                         ref = "A")

## ---- fig.width = 7.2, fig.height = 6, out.width="100%"-----------------------
rankheatplot(list(net1, net2))

