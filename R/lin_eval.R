#' Computes average deviation from linearity adl
#'
#' @param predicted.poly vector of predicted values from best-fitting polynomial model
#' @param predicted.poly vector of predicted values from linear model
#' @return value for average deviation from linearity as a percentage
#'
#' @export
calculate_adl <- function(predicted.poly, predicted.lm){
  return(mean(abs((predicted.lm - predicted.poly)/predicted.lm) * 100))
}

#' Establishes if relationship between two vectors is linear or nonlinear
#' Does not return any value. Prints details of the relationship between x and y.
#' @param y vector of response values
#' @param x vector of predictor values
#' @param threshold optional argument. Threshold percentage value for average deviation from linearity. Defaults to 5.
#'
#' @export
poly_eval <- function(y, x, threshold){

  # Fit linear model
  linear.model <- lm(y ~ x)
  # Extract p-value of lm
  pval.lm <- broom::glance(linear.model)$p.value

  # Fit 2nd order polynomial model
  poly.2.model <- lm(y ~ x + I(x ^ 2))
  # Extract p-value of 2nd order model
  pval.poly2 <- broom::glance(poly.2.model)$p.value

  # Fit 3nd order polynomial model
  poly.3.model <- lm(y ~ x + I(x ^ 2) + I(x ^ 3))
  # Extract p-value of 3rd order model
  pval.poly3 <- broom::glance(poly.3.model)$p.value

  # Find best fitting model
  # Best-fitting model has lowest p-value
  bfm <- min(pval.lm, pval.poly2, pval.poly3)

  # Vector to store the results
  res <- list()
  res$p1 <- pval.lm
  res$p2 <- pval.poly2
  res$p3 <- pval.poly3

  # Case 1 - linear model is best fitting
  if (bfm == pval.lm) {
    cat("Best fitting model is linear since linear model has lowest p-value\n")
    cat("Linearity established - Linear 1\n")
    cat("No further testing required\n")
    # Silently return the results
    invisible(res)
  }

  # Case 2 - second order polynomial model is best fitting
  else if(bfm == pval.poly2){
    cat("Best fitting model is second-order polynomial.\n")
    cat("Computing average deviation from linearity...\n")

    # Compute adl value
    predicted.poly.2 <- predict(poly.2.model)
    predicted.lm <- predict(linear.model)
    adl.2 <- calculate_adl(predicted.poly = predicted.poly.2, predicted.lm = predicted.lm)
    cat(paste0("Average Deviation from Linearity: ", round(adl.2, 2), " %\n"))

    # Add the value of adl to the result vector
    res$adl <- adl.2

    # Case 2 - Part 1
    # threshold argument not provided - work with default value of 5
    if (missing(threshold)){
      # if adl is greater than or equal to default threshold value of 5
      if (adl.2 >= 5){
        cat("Since, average deviation from linearity is greater than 5, nonlinearity is established.\n")
        cat("The relationship between the two input vectors is best described by a second order polynomial\n")
      }
      # adl is smaller than default threshold value of 5
      else{
        cat(paste0("Although the best fitting model is nonlinear, since average deviation from linearity is ", round(adl.2, 2), "; which is less than or equal to 5
                   linearity is established. We call this linearity type as Linear 2\n"))
      }
      }

    # Case 2 - Part 2
    # threshold argument provided
    else{
      # if adl is greater than or equal to threshold value
      if (adl.2 > threshold){
        cat(paste0("Since, average deviation from linearity is greater than ", threshold, ", nonlinearity is established.\n"))
        cat("The relationship between the two input vectors is best described by a second order polynomial\n")
      }
      # adl is smaller than threshold value
      else{
        cat(paste0("Although the best fitting model is nonlinear, since average deviation from linearity is ", round(adl.2, 2), "; which is less than or equal to ", threshold,
                   "; linearity is established. We call this linearity type as Linear 2\n"))
      }
    }
    # Silently return the results
    invisible(res)
    }

  # Case 3 - third order polynomial model is best fitting
  else{
    cat("Best fitting model is third-order polynomial.\n")
    cat("Computing average deviation from linearity:\n")

    # Compute adl value
    predicted.poly.3 <- predict(poly.3.model)
    predicted.lm <- predict(linear.model)
    adl.3 <- calculate_adl(predicted.poly = predicted.poly.3, predicted.lm = predicted.lm)
    cat(paste0("Average Deviation from Linearity: ", round(adl.3, 2), " %\n"))

    # Add the value of adl to the result vector
    res$adl <- adl.3

    # Case 3 - Part 1
    # threshold argument not provided - work with default value of 5
    if (missing(threshold)){
      # if adl is greater than or equal to default threshold value of 5
      if (adl.3 > 5){
        cat("Since, average deviation from linearity is greater than 5, nonlinearity is established.\n")
        cat("The relationship between the two input vectors is best described by a third order polynomial\n")
      }
      # adl is smaller than default threshold value of 5
      else{
        cat(paste0("Although the best fitting model is nonlinear, since average deviation from linearity is ", round(adl.3, 2), "; which is less than or equal to 5
                   linearity is established. We call this linearity type as Linear 2\n"))
      }
      }

    # Case 3 - Part 2
    # threshold argument provided
    else{
      # if adl is greater than or equal to threshold value
      if (adl.3 > threshold){
        cat(paste0("Since, average deviation from linearity is greater than ", threshold, ", nonlinearity is established.\n"))
        cat("The relationship between the two input vectors is best described by a third order polynomial\n")
      }
      # adl is smaller than default threshold value
      else{
        cat(paste0("Although the best fitting model is nonlinear, since average deviation from linearity is ", round(adl.3, 2), "; which is less than or equal to ", threshold,
                   "; linearity is established. We call this linearity type as Linear 2\n"))
      }
    }
    # Silently return the results
    invisible(res)
    }
}
