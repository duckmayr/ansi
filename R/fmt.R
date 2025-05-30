#' Decorate Text Printed to Console Using ANSI Escape Codes
#'
#' ANSI escape codes can be used to change the foreground color, background
#' color, and other graphical features of text printed to the console
#'
#' @param x A character vector giving the text to format
#' @param fg What color should the foreground (text) be?
#'   Anything R recognizes as a color can be specified.
#'   System colors can be accessed by the numbers 0-15,
#'   and similarly for the 256-color grayscale block and the numbers 232-255.
#'   If `NA` (the default), the foreground color is not changed.
#' @param bg What color should the background be?
#'   Anything R recognizes as a color can be specified.
#'   System colors can be accessed by the numbers 0-15,
#'   and similarly for the 256-color grayscale block and the numbers 232-255.
#'   If `NA` (the default), the background color is not changed.
#' @param bf Should the text be boldface? The default is `FALSE`.
#' @param ul Should the text be underlined? The default is `FALSE`.
#' @param it Should the text be italic? The default is `FALSE`.
#'
#' @examples
#' cat(fmt("Normal text"))
#' cat(fmt("fg = 'system red' (which may not be red)", fg = 9))
#' cat(fmt("fg = #ffd700 (close to Tango palette Butter)", fg = "#edd400"))
#' cat(fmt("fg = navy, bg = sky blue", fg = "#000080", bg = "#87ceeb"))
#' cat(fmt("bold", bf = TRUE))
#' cat(fmt("bold and italic", bf = TRUE, it = TRUE))
#' cat(fmt("bold, italic, and underlined", bf = TRUE, it = TRUE, ul = TRUE))
#'
#' @returns The text encased in the relevant ANSI escape code.
#'
#' @export
fmt = function(x, fg = NA, bg = NA, bf = FALSE, it = FALSE, ul = FALSE) {
    fg = ifelse(is.na(fg), 39, paste0("38;5;", get256color(fg)))
    bg = ifelse(is.na(bg), 49, paste0("48;5;", get256color(bg)))
    misc = paste0(";1"[bf], ";3"[it], ";4"[ul])
    return(paste0("\033[", fg, ";", bg, misc, "m", x, "\033[0m"))
}
