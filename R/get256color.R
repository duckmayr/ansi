#' Find the closest color in the 256 color system
#'
#' The 256 color system is made of an initial 16 terminal-dependent colors,
#' a 6 by 6 by 6 block of combinations of red, green, and blue values,
#' and 24 grayscale colors. This function respects selection of system or
#' grayscale block colors but translates any other color into the closest
#' match in the set of 256 colors.
#'
#' @param color Anything that base::col2rgb() recognizes as a color,
#'   or the numbers 0 to 255 inclusive
#'
#' @examples
#' get256color(c("black", "white", "#bf5700", rgb(0.1, 0.3, 0.9), 3, 244))
#'
#' @returns A named numeric vector of the translated colors.
#'   The elements are the number from 0 to 255 identifying the color.
#'   (If the number of a 256 color is given, it stays unchanged).
#'   The names are the Xterm names for the colors.
#'
#' @export
get256color = function(color) {
    preserve = suppressWarnings(as.numeric(color)) %in% 0:255
    tmp = unname(col2rgb(ifelse(preserve, "white", color)))
    tmp = round(ifelse(tmp < 95, tmp / 95, 1 + (tmp - 95) / 40))
    res = ifelse(preserve, color, 16 + tmp[1,] * 36 + tmp[2,] * 6 + tmp[3,])
    pal = ansi::palette256
    res = setNames(as.numeric(res), names(pal)[match(res, pal)])
    return(res)
}
