## rm(list=ls())

library(purrr)
library(magrittr)
library(dplyr)
library(stringr)

epi_data_header <- "source,date,country,countrycode,adm_area_1,adm_area_2,adm_area_3,tested,confirmed,recovered,dead,hospitalised,hospitalised_icu,quarantined,gid"


source_name_from_filepath <- function(filepath) {
    source_regex <- "covid19db-epidemiology-([a-zA-Z0-9_]+).csv$"
    str_match(string = filepath,
              pattern = source_regex)[,2]
}

get_single_source_df <- function(filepath, source_name) {
    read.csv(filepath, stringsAsFactors = FALSE) %>%
        mutate(date = as.Date(date)) %>%
        group_by(source,country,countrycode,adm_area_1,adm_area_2,adm_area_3,gid) %>%
        summarise(confirmed = head(confirmed,1),
                  tested = head(tested,1),
                  date = head(date,1))
}

get_all_data <- function(data_directory) {
    data_filepaths <- list.files(data_directory, full.names = TRUE)
    source_names <- map(data_filepaths, source_name_from_filepath)
    map2(data_filepaths,
         source_names,
         get_single_source_df) %>% bind_rows
}



data_directory <- "data-epidemiology/"
data_df <- get_all_data(data_directory)
all_countries <- unique(data_df$country)

num_sources_with_confirmed <- function(country_ix) {
    with_confirmed_data <- filter(data_df, country == country_ix, !is.na(confirmed))
    num_sources <- with_confirmed_data %>% use_series("source") %>% unique %>% length
    country_code <- unique(with_confirmed_data$countrycode)
    data.frame(adm0_a3 = country_code, num_sources = num_sources)
}

coverage_df <- map(all_countries, num_sources_with_confirmed) %>% bind_rows


library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
world <- ne_countries(scale = "medium", returnclass = "sf")

world_coverage <- left_join(world, coverage_df, by = "adm0_a3")
coverage_map <- ggplot(world_coverage) +
    geom_sf(aes(fill = as.factor(num_sources))) +
    labs(fill = "Number of data sources",
         title = "Database coverage",
         subtitle = "The number of distinct sources reporting confirmed cases for each country")


ggsave(".out/coverage-plot-01.png", coverage_map, height = 15, width = 20, units = "cm")



main <- function(output_file) {
}

if (!interactive()) {
    args <- commandArgs(trailingOnly = TRUE)
    output_file <- args[1]
    main(output_file)
} else {
    cat("Loading functions from make-data-tree.R...\n")
}
