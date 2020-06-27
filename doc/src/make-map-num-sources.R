## make-map-num-sources.R
##
## Usage
##
## $ Rscript src/make-map-num-sources.R <path/to/data> <path/to/output>
##
## ChangeLog
##
## - 2020-06-27
##   + First draft
##


num_sources <- function(df, countrycode_str) {
    country_df <- df[df$countrycode == countrycode_str,]
    length(unique(country_df$source))
}


main <- function(data_dir, output_csv) {
    if (!dir.exists(data_dir)) {
        stop("Cannot find input directory: ", data_dir)
    }

    data_csvs <- list.files(data_dir, full.names = TRUE)

    x <- do.call(rbind, lapply(data_csvs, function(d_csv) read.csv(d_csv, stringsAsFactors = FALSE)))

    result <- data.frame(ISO = unique(x$countrycode),
                         VALUE = sapply(unique(x$countrycode), function(cd) num_sources(x,cd)))

    write.csv(result, output_csv, row.names = FALSE)
}

if (!interactive()) {
    args <- commandArgs(trailingOnly = TRUE)
    if (length(args) < 2) {
        stop("Invalid arguments.")
    } else {
        main(args[1], args[2])
    }
}
