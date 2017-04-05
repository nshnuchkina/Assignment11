---
title: "Readme2"
author: "Nadya Green"
date: "4/5/2017"
output: html_document
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Assignment 11

This is an R Markdown document for Assignment 11 of Doing Data Science course. 
https://github.com/nshnuchkina/Assignment11

Install packages if you don't have them already installed
```{r install packages}
install.packages("tseries", repos = 'http://cran.us.r-project.org')
library(tseries)
```
## S&P 500 (^GSPC)
### SNP - SNP Real Time Price. Currency in USD
#### TODO: Download the data of SP500 '^gspc'.
```{r code}
SNPdata <- get.hist.quote('^gspc',quote="Close")
```

#### TODO: Calculate the log returns, which is the subtractration of log(lag(SNPdata)) and log(SNPdata)
```{r SNPret}
SNPret <- log(lag(SNPdata)) - log(SNPdata)
```

#### TODO: Calculate volatility measure that is to multiply sd(SNPret),sqrt(250), 100
```{r sd}
SNPvol <- sd(SNPret) * sqrt(250) * 100
```

##### Define getVol function for volatility
```{r getVol}
getVol <- function(d, logrets) {
	var = 0
	lam = 0
	varlist <- c()

	for (r in logrets) {
		lam = lam*(1 - 1/d) + 1
	  var = (1 - 1/lam)*var + (1/lam)*r^2
		varlist <- c(varlist, var)
	}

	sqrt(varlist)
}
```

#### Calculate volatility over entire length of series for various three different decay factors: 10 30. 100

#### TODO: call getVol function with the parameters: 10,SNPret
```{r 10}
volest <- getVol(10, SNPret)
```

#### TODO: call getVol function with the parameters: 30,SNPret
```{r 30}
volest2 <- getVol(30, SNPret)
```

#### TODO: call getVol function with the parameters: 100,SNPret
```{r 100}
volest3 <- getVol(100, SNPret)
```

#### Plot the results, overlaying the volatility curves on the data, just as was done in the S&P example.
#### TODO: Add connected line segments for volest2 with the parameters: type="l",col="red"
#### TODO: Add connected line segments for volest3 with the parameters: type="l",col="blue"
```{r plot}
plot(volest,type="l")
lines(volest2, type="l",col="red")
lines(volest3, type="l",col="blue")
```
