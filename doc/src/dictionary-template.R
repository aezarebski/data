## dictionary-template.R
##
## Usage
##
## $ Rscript src/dictionary-template.R <path/to/data> <path/to/output>
##
## ChangeLog
##
## - 2020-06-27
##   + First draft
##

header <- c("| Variable | Description | Distinct values | Completeness |")
h_line <- c("|----------|-------------|-----------------|--------------|")

percent_true <- function(xs, predicate) {
    100 * sum(predicate(xs)) / length(xs)
}

not_na_pred <- function(xs) {
    !(is.na(xs))
}

number_distinct_values <- function(xs) {
    length(unique(xs))
}

table_row <- function(df, col_name, not_missing_predicate) {
    sprintf("| %s | TBC | %d | %f |",
            col_name,
            number_distinct_values(df[,col_name]),
            percent_true(df[,col_name], not_missing_predicate))
}

main <- function(data_dir, output_txt) {
    if (!dir.exists(data_dir)) {
        stop("Cannot find input directory: ", data_dir)
    }

    data_csvs <- list.files(data_dir, full.names = TRUE)

    x <- do.call(rbind, lapply(data_csvs, function(d_csv) read.csv(d_csv, stringsAsFactors = FALSE)))

    writeLines(text = c(header, h_line, sapply(names(x), function(cn) table_row(x, cn, not_na_pred))),
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
