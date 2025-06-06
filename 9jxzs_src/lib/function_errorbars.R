# plot SEs direct task
errorbars <- function(x, y, error)
{
  arrows(
       x,
       y - error,
       x,
       y + error,
       angle = 90, code = 3, length = 0.05)
}