
<!-- README.md is generated from README.Rmd. Please edit that file -->

![](www/ka_logo.jpg)

<hr>

# Introduction to {echarts4r} <img src="https://raw.githubusercontent.com/JohnCoene/echarts4r/master/man/figures/logo.png" align="right" height="200"/>

<!-- badges: start -->
<!-- badges: end -->

This repository is complementary to the talk given to the [Edmonton R
Users Group on
2022-04-28](https://www.meetup.com/edmonton-r-user-group-yegrug/events/284835558/).

## Resources

-   [{echarts4r} website](https://echarts4r.john-coene.com/index.html)
-   [{echarts4r} GitHub
    repository](https://github.com/JohnCoene/echarts4r)
-   [Apache ECharts website](https://echarts.apache.org/en/index.html)

## Apache ECharts <img src="https://echarts.apache.org/en/images/logo.png" align="right" height="100"/>

**Apache ECharts** is an open source JavaScript data visualization
library, with [a bunch of built in types of visuals to choose
from](https://echarts.apache.org/examples/en/index.html).

The [cheat sheet](https://echarts.apache.org/en/cheat-sheet.html) can be
a great landing place to dig into the specific theming elements for your
chart that you have access to manipulate via the *hundreds* of
formatting arguments offered.

You can even [edit a chart on the fly in the
browser](https://echarts.apache.org/examples/en/editor.html?c=heatmap-cartesian)
to watch the chart change as you manipulate the JavaScript code
directly.

### The {echarts4r} R package

### The Case for {echarts4r}

-   Interactivity that you can’t get from {ggplot2}
-   Syntax that is as simple as {dplyr}
-   Aesthetics that are *cleaner* and *smoother* than
    [plotly](https://plotly.com/r/) (e.g., no big toolbar above the
    chart with widgets that no one ever uses…)

### Standout Capabilities

Some of my other favorite things about {echarts4r} include:

-   [sliders for *“zooming”* the x- and/or
    y-axis](https://echarts4r.john-coene.com/articles/brush.html#sliders)
-   

## Reproducibility

If you would like to reproduce these charts yourself, we recommend
taking advantage of the [{renv}
package](https://rstudio.github.io/renv/articles/renv.html) to ensure
the package versions you are using are consistent with this repository /
talk. You can do so by following these steps:

1.  Clone this repository to your local machine

2.  Open the [echarts4r-intro.Rproj](echarts4r-intro.Rproj) file from
    the directory on your local machine where you cloned this
    repository. This should install the {renv} package if you do not
    already have it installed, but if you don’t see that happen in the
    console, run `install.packages("renv")`.

3.  Run `renv::restore()` to install the [dependencies](renv.lock)
    needed to run this app successfully

4.  Run the scripts in the [examples](examples/) directory

## Session Info

``` r
utils::sessionInfo()
#> R version 4.1.1 (2021-08-10)
#> Platform: x86_64-w64-mingw32/x64 (64-bit)
#> Running under: Windows 10 x64 (build 19044)
#> 
#> Matrix products: default
#> 
#> locale:
#> [1] LC_COLLATE=English_United States.1252 
#> [2] LC_CTYPE=English_United States.1252   
#> [3] LC_MONETARY=English_United States.1252
#> [4] LC_NUMERIC=C                          
#> [5] LC_TIME=English_United States.1252    
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices datasets  utils     methods   base     
#> 
#> loaded via a namespace (and not attached):
#>  [1] compiler_4.1.1  magrittr_2.0.3  fastmap_1.1.0   cli_3.3.0      
#>  [5] htmltools_0.5.2 tools_4.1.1     rstudioapi_0.13 yaml_2.3.5     
#>  [9] stringi_1.7.6   rmarkdown_2.14  knitr_1.38      stringr_1.4.0  
#> [13] xfun_0.30       digest_0.6.29   rlang_1.0.2     renv_0.15.2    
#> [17] evaluate_0.15
```
