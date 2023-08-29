# load libraries needed for script
library(readr) # this loads the functions we'll use to load the data
library(ggplot2) # this loads the functions, etc. needed for us to plot
library(dplyr) # this loads the functions, etc. needed for us to work with the data


# load the data
armagh <- read_csv('data/armaghdata.csv')

# select only years between 1871 and 2020
armagh <- armagh[armagh$yyyy %in% 1871:2020, ]

# add a period variable
armagh$period <- case_when(
    armagh$yyyy %in% 1871:1920 ~ '1871-1920', # years between 1871 and 1920
    armagh$yyyy %in% 1921:1970 ~ '1921-1970', # years between 1921 and 1970
    armagh$yyyy %in% 1971:2020 ~ '1971-2020' #years between 1971 and 2020
)

# add a season variable
armagh$season <- case_when(
    armagh$mm %in% c(1, 2, 12) ~ 'winter', # if month is 1, 2, or 12, set it to winter
    armagh$mm %in% 3:5 ~ 'spring', # if month is 3, 4, 5, set it to spring
    armagh$mm %in% 6:8 ~ 'summer', # if month is 6, 7, 8, set it to summer
    armagh$mm %in% 9:11 ~ 'autumn', # if month is 9, 10, 11, set it to autumn
)

# create a figure to plot the density distribution of tmin for each period in its own panel
tmin_density_plot_multi <- ggplot(data=armagh, mapping=aes(x=tmin, color=season, fill=season)) + 
    geom_density(alpha=0.4, linewidth=1) + 
    facet_wrap(~period) + 
    xlab('monthly minimum temperature (°C)') + 
    ylab('density') + 
    theme(
        axis.text=element_text(size=18),
        axis.title=element_text(size=18)
    )

# create a figure to plot the density distribution of tmin for each period in the same panel, colored by the period (using fill)
tmin_density_plot_single <- ggplot(data=armagh, mapping=aes(x=tmin, color=period, fill=period)) + 
    geom_density(alpha=0.4, linewidth=1) + # add a density plot with transparency of 0.4 and lines of width 1
    xlab('monthly minimum temperature (°C)') + # set x label
    ylab('density') + # set y label 
    theme( # set appropriate font size
        axis.text=element_text(size=18),
        axis.title=element_text(size=18)
    )

# save each plot to its own file
ggsave('tmin_density_onepanel.png', plot=tmin_density_plot_single) # save the plot to a file
ggsave('tmin_density_threepanel.png', plot=tmin_density_plot_multi, width=12, height=5) # save the plot to a file
