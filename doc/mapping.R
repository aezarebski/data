library(ggplot2)
library(ggspatial)
library(GADMTools)
library(purrr)
library(dplyr)
library(cowplot)
library(reshape2)

my_breaks <- seq(from = 0, to = 20000, by = 5000)

my_cols <- hcl.colors(n = length(my_breaks) - 1, palette = "reds 3", alpha = NULL, rev = TRUE, fixup = TRUE)

map_country_line_colour <- "#FFFFFF"

map_plot_background <- element_rect(colour = "#FFFFFF", fill = "#f0f0f0")


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
    geom_sf(data = plot_sf_1, mapping = aes(fill = dead), colour = map_country_line_colour) +
    scale_fill_gradientn(breaks = my_breaks,
                         colors = my_cols,
                         limits = range(my_breaks)) +
    theme_nothing() +
    theme(plot.background = map_plot_background)


date_index_2 <- "01-05-2020"
plot_sf_2 <- left_join(italy_sf, filter(epi_df, date == date_index_2), by = "NAME_1")
g_2 <- ggplot() +
    geom_sf(data = plot_sf_2, mapping = aes(fill = dead), colour = map_country_line_colour) +
    scale_fill_gradientn(breaks = my_breaks,
                      colors = my_cols,
                      limits = range(my_breaks)) +
    theme_nothing() +
    theme(plot.background = map_plot_background)


date_index_3 <- "01-06-2020"
plot_sf_3 <- left_join(italy_sf, filter(epi_df, date == date_index_3), by = "NAME_1")

g_3 <- ggplot() +
    geom_sf(data = plot_sf_3, mapping = aes(fill = dead), colour = map_country_line_colour) +
    scale_fill_gradientn(breaks = my_breaks,
                      colors = my_cols,
                      limits = range(my_breaks)) +
    theme_nothing() +
    theme(plot.background = map_plot_background)

italy_legend <- get_legend(g_1 +
                           labs(fill = "Cumulative deaths") +
                           theme(legend.position = "left",
                                 legend.box.margin = margin(0, 0, 0, 0),
                                 legend.key.height = unit(2, units = "cm")))

g_maps_without_legend <- plot_grid(g_1 + theme(legend.position = "none"),
                                   g_2 + theme(legend.position = "none"),
                                   g_3 + theme(legend.position = "none"),
                                   ncol = 1)

g_maps <- plot_grid(g_maps_without_legend,
                    italy_legend,
                    ncol = 2,
                    rel_widths = c(1,0.5))

plot_epi_df <- epi_df %>%
    group_by(date) %>%
    summarise(total_dead = sum(dead)) %>%
    mutate(date = as.Date(date, format = "%d-%m-%Y"))


plot_mobility_df <- read.csv("../data-mobility/covid19db-mobility-GOOGLE_MOBILITY.csv", stringsAsFactors = FALSE) %>%
    filter(country == "Italy", adm_area_1 == "") %>%
    select(date, workplace) %>%
    mutate(date = as.Date(date, format = "%d-%m-%Y"))

plot_gov_df <- read.csv("../data-government-response/covid19db-government-response-GOVTRACK.csv", stringsAsFactors = FALSE) %>%
    filter(country == "Italy") %>%
    select(date, stringency_indexfordisplay) %>%
    mutate(date = as.Date(date, format = "%d-%m-%Y"))

plot_ts_df <- left_join(plot_epi_df, plot_gov_df, by = "date") %>%
    left_join(plot_mobility_df, by = "date") %>%
    melt(id.vars = "date")

g_epi <- ggplot() +
    geom_line(data = filter(plot_ts_df, variable == "total_dead"),
              mapping = aes(x = date, y = value)) +
    geom_vline(xintercept = as.Date(c(date_index_1, date_index_2, date_index_3), format = "%d-%m-%Y"),
               linetype = "dashed") +
    labs(x = "Date", y = "Cumulative deaths") +
    theme_classic()


g_gov <- ggplot() +
    geom_step(data = filter(plot_ts_df, variable == "stringency_indexfordisplay"),
              mapping = aes(x = date, y = value)) +
    labs(x = "Date", y = "Intervention stringency") +
    theme_classic()

g_mob <- ggplot() +
    geom_step(data = filter(plot_ts_df, variable == "workplace"),
              mapping = aes(x = date, y = value)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    labs(x = "Date", y = "Relative workplace mobility") +
    theme_classic()


g_ts <- plot_grid(g_epi,
                  g_gov,
                  g_mob,
                  ncol = 1,
                  labels = c("A", "B", "C"))


g_final <- plot_grid(g_ts,
                     g_maps,
                     ncol = 2,
                     rel_widths = c(0.7,1.0),
                     labels = c("","D"))

ggsave("out/demo-combination-plot.png", g_final, width = 2 * 14.8, height = 2 * 10.5, units = "cm")
