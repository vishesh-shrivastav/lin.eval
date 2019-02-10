# lin.eval
R package for performing polynomial evaluation of linearity.

**About**
`lin.eval` is a R package for performing polynomial evaluation of linearity.

**Installation**  
`lin.eval` can be installed via Github:

```{r}
if (!require(devtools)) {  
    install.packages('devtools')  
}  
devtools::install_github('vishesh-shrivastav/lin.eval')
```  
  
**How it works**

Polynomial evaluation of linearity is a technique of assessing if the best way to describe the relationship between two vectors.

1) Fit three models - linear, second-order polynomial and third-order polynomial
2) Find out best-fitting model among the three by comparing their p-values. Model with the lowest p-value out of the three is the best-fitting one.
3) If the best-fitting model is linear, linearity is established and no further steps need to be carried out. This is called Linear 1 type.
4) Else, best-fitting model is either second or third order polynomoal model. In this case, calculate average deviation from linearity (adl). This is given by:  

                    <a href="https://www.codecogs.com/eqnedit.php?latex=adl&space;=&space;\frac{1}{n}&space;*&space;(\sum_{1}^{n}\left&space;|&space;\frac{l_{i}&space;-&space;p_{i}}{l_{i}}&space;\right&space;|&space;*&space;100)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?adl&space;=&space;\frac{1}{n}&space;*&space;(\sum_{1}^{n}\left&space;|&space;\frac{l_{i}&space;-&space;p_{i}}{l_{i}}&space;\right&space;|&space;*&space;100)" title="adl = \frac{1}{n} * (\sum_{1}^{n}\left | \frac{l_{i} - p_{i}}{l_{i}} \right | * 100)" /></a>

5) If adl is greater than or equal to the threshold value for deviation from linearity, conclude that the relationship is non-linear.
6) Else if adl is less than the threshold value for deviation from linearity, conclude that although the best-fitting model is not linear, deviation from linearity is not significant and hence, it is still a linear relationship. This is called a Linear 2 type.
