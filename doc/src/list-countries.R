## list-countries.R
##
## Usage
##
## $ Rscript src/list-countries.R <path/to/data> <path/to/output>
##
## ChangeLog
##
## - 2020-06-27
##   + First draft
##

header <- c("| Country | Sources |")
h_line <- c("|---------|---------|")

table_row <- function(df, country_name) {
    country_df <- df[df$country == country_name,]
    unique_sources <- paste0(unique(country_df$source), collapse = ", ")
    sprintf("| %s | %s |", country_name, unique_sources)
}


main <- function(data_dir, output_txt) {
    if (!dir.exists(data_dir)) {
        stop("Cannot find input directory: ", data_dir)
    }

    data_csvs <- list.files(data_dir, full.names = TRUE)

    x <- do.call(rbind, lapply(data_csvs, function(d_csv) read.csv(d_csv, stringsAsFactors = FALSE)))

    unique(x$country)
    writeLines(text = c(header, h_line, sapply(unique(x$country), function(cn) table_row(x, cn))),
               output_txt)
}

if (!interactive()) {
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) < 2) {
        stop("Invalid arguments.")
    } else {
        main(args[1], args[2])
    }
}
