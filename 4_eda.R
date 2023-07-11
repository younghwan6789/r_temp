# https://r-graph-gallery.com/boxplot.html

draw_box_flot <- function() {
    ggplot(mtcars, aes(x = as.factor(cyl), y = mpg)) +
        geom_boxplot(fill = "slateblue", alpha = 0.2) +
        xlab("cyl")
}

draw_geom_line <- function(df) {
    ggplot(df, aes(x = datetime, y = rent)) +
        geom_line() +
        xlab("Date") +
        ylab("Rental") +
        ggtitle("Rental per Day")
}

draw_geom_histogram <- function(df) {
    ggplot(df, aes(x = high_temperature)) +
        geom_histogram(fill = "#ff9999", color = "black", bins = 10) +
        labs(x = "최고 기온", y = "빈도") +
        ggtitle("최고 기온 히스토그램")
}
