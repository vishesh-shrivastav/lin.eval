# lin.eval
R package for polynomial evaluation of linearity.

## About  
`lin.eval` is a R package for performing polynomial evaluation of linearity.

## Installation  

Installing through CRAN:  

```r
install.packages('lin.eval')
```

Installing through Github:

```r
if (!require(devtools)) {  
    install.packages('devtools')  
}  
devtools::install_github('vishesh-shrivastav/lin.eval')
```
  
## How it works

Polynomial evaluation of linearity is a technique of assessing if the best way to describe the relationship between two vectors.

1) Fit three models - linear, second-order polynomial and third-order polynomial
2) Find out best-fitting model among the three by comparing their p-values. Model with the lowest p-value out of the three is the best-fitting one.
3) If the best-fitting model is linear, linearity is established and no further steps need to be carried out. This is called Linear 1 type.
4) Else, best-fitting model is either second or third order polynomoal model. In this case, calculate average deviation from linearity (adl). This is given by:  

      <a href="https://www.codecogs.com/eqnedit.php?latex=adl&space;=&space;\frac{1}{n}&space;*&space;(\sum_{1}^{n}\left&space;|&space;\frac{l_{i}&space;-&space;p_{i}}{l_{i}}&space;\right&space;|&space;*&space;100)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?adl&space;=&space;\frac{1}{n}&space;*&space;(\sum_{1}^{n}\left&space;|&space;\frac{l_{i}&space;-&space;p_{i}}{l_{i}}&space;\right&space;|&space;*&space;100)" title="adl = \frac{1}{n} * (\sum_{1}^{n}\left | \frac{l_{i} - p_{i}}{l_{i}} \right | * 100)" /></a>

    where, `l` is the vector of predictions from linear model and `p` is the vector of predictions from best-fitting polynomial model.

5) If `adl` is greater than or equal to the threshold value for deviation from linearity, conclude that the relationship is non-linear.
6) Else if `adl` is less than the threshold value for deviation from linearity, conclude that although the best-fitting model is not linear, deviation from linearity is not significant and hence, it is still a linear relationship. This is called a Linear 2 type.

## Usage  
Call the `poly_eval()` function with the following parameters:  
`y`: vector of response values  
`x`: vector of predictor values  
`threshold`: threshold value for average deviation from linearity as percentage. Defaults to 5.

```r
> library("lin.eval")
> foo <- c(165.3929, 165.3929, 1119.5714, 1119.5714, 2073.7500, 2073.7500, 3027.9286, 3027.9286, 3982.1071, 3982.1071, 4936.2857, 4936.2857, 5890.4643, 5890.4643)
> bar <- c(386.2143,  386.2143, 840.6548, 840.6548, 1829.6905, 1829.6905, 3074.4048, 3074.4048, 4295.8810, 4295.8810, 5215.2024, 5215.2024, 5553.4524, 5553.4524)
> derp <- poly_eval(bar, foo, 30)
Best fitting model is third-order polynomial.
Computing average deviation from linearity:
Average Deviation from Linearity: 27.28 %
Although the best fitting model is nonlinear, since average deviation from linearity is 27.28; which is less than or equal to 30; linearity is established. We call this linearity type as Linear 2
```  

You can check the values stored in the result variable:  
```r
> derp$p1
[1] 8.851095e-12
> derp$p2
[1] 2.514044e-10
> derp$p3
[1] 1.930392e-78
> derp$adl
[1] 27.28302
```

## More examples 

Usage without passing in optional argument for adl:  
```r
> xx <- c(0, 1, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29, 30)
> yy <- c(126.6, 101.8, 71.6, 101.6, 68.1, 62.9, 45.5, 41.9, 46.3, 34.1, 38.2, 41.7, 24.7, 41.5, 36.6, 19.6, 22.8, 29.6, 23.5, 15.3, 13.4, 26.8, 9.8, 18.8, 25.9, 19.3)
> poly_eval(yy, xx)
Best fitting model is second-order polynomial.
Computing average deviation from linearity...
Average Deviation from Linearity: 70.42 %
Since, average deviation from linearity is greater than 5, nonlinearity is established.
The relationship between the two input vectors is best described by a second order polynomial
```
