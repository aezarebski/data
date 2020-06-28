library(ggplot2)
library(ggspatial)
library(GADMTools)
library(purrr)
library(dplyr)
library(cowplot)
library(reshape2)

my_breaks <- seq(from = 2000, to = 10000, by = 1000)

my_cols <- hcl.colors(n = length(my_breaks) - 1, palette = "viridis", alpha = NULL, rev = FALSE, fixup = TRUE)


italy_sf <- gadm_sf_loadCountries("ITA", level = 1)$sf

epi_df <- read.csv("../data-epidemiology/covid19db-epidemiology-ITA_PC.csv", stringsAsFactors = FALSE) %>%
    filter(adm_area_2 == "") %>%
    select(date, adm_area_1, adm_area_2, dead)


trento_mask <- epi_df$adm_area_1 == "Trento"
epi_df[trento_mask, ]$adm_area_1 <- "Trentino-Alto Adige"
epi_df <- rename(epi_df, NAME_1 = adm_area_1)

date_index_1 <- "01-04-2020"
plot_sf_1 <- left_join(italy_sf, filter(epi_df, date == date_index_1), by = "NAME_1")
g_1 <- ggplot() +
    geom_sf(data = plot_sf_1, mapping = aes(fill = dead)) +
    scale_fill_stepsn(breaks = my_breaks,
                      colors = my_cols,
                      limits = range(my_breaks))


date_index_2 <- "01-05-2020"
plot_sf_2 <- left_join(italy_sf, filter(epi_df, date == date_index_2), by = "NAME_1")
g_2 <- ggplot() +
    geom_sf(data = plot_sf_2, mapping = aes(fill = dead)) +
    scale_fill_stepsn(breaks = seq(from = 2000, to = 10000, by = 1000),
                      colors = my_cols,
                      limits = range(my_breaks))


date_index_3 <- "01-06-2020"
plot_sf_3 <- left_join(italy_sf, filter(epi_df, date == date_index_3), by = "NAME_1")

g_3 <- ggplot() +
    geom_sf(data = plot_sf_3, mapping = aes(fill = dead)) +
    scale_fill_stepsn(breaks = my_breaks,
                      colors = my_cols,
                      limits = range(my_breaks))


italy_legend <- get_legend(g_1 + theme(legend.position = "top", legend.box.margin = margin(0, 0, 0, 0)))

g_maps <- plot_grid(g_1 + theme(legend.position = "none"),
                    g_2 + theme(legend.position = "none"),
                    g_3 + theme(legend.position = "none"),
                    italy_legend,
                    ncol = 1,
                    rel_heights = c(1,1,1,0.3))

plot_epi_df <- epi_df %>%
    group_by(date) %>%
    summarise(total_dead = sum(dead)) %>%
    mutate(date = as.Date(date, format = "%d-%m-%Y"))




plot_gov_df <- read.csv("../data-government-response/covid19db-government-response-GOVTRACK.csv", stringsAsFactors = FALSE) %>%
    filter(country == "Italy") %>%
    select(date, stringency_indexfordisplay) %>%
    mutate(date = as.Date(date, format = "%d-%m-%Y"))

plot_ts_df <- left_join(plot_epi_df, plot_gov_df, by = "date") %>%
    melt(id.vars = "date")

g_epi <- ggplot() +
    geom_line(data = filter(plot_ts_df, variable == "total_dead"),
              mapping = aes(x = date, y = value)) +
    geom_vline(xintercept = as.Date(c(date_index_1, date_index_2, date_index_3), format = "%d-%m-%Y"),
               linetype = "dashed") +
    labs(x = "Date", y = "Cumulative deaths")

g_gov <- ggplot() +
    geom_line(data = filter(plot_ts_df, variable == "stringency_indexfordisplay"),
              mapping = aes(x = date, y = value)) +
    labs(x = "Date", y = "Intervention stringency")

g_ts <- plot_grid(g_epi,
                  g_gov,
                  ncol = 1,
                  labels = c("A", "B"))


g_final <- plot_grid(g_ts,
                     g_maps,
                     ncol = 2,
                     rel_widths = c(0.7,1),
                     labels = c("","C"))

ggsave("out/demo-combination-plot.png", g_final, width = 2 * 14.8, height = 2 * 10.5, units = "cm")
