source("global.R")


#####---------------- 
# map
mapp <- material_row(
  material_column(
    width = 2,
    material_card(
      title = "",
      depth = 4,
      material_text_box("feed", "Enter feed: "),
      material_radio_button(
        input_id = "plot_theme",
        label = "Theme",
        choices = 
          c("Open Street" = "osm",
            "Stamen Toner" = "stoner",
            "ESRI Nat Geo" = "natgeo") 
      ),
      tags$br(),
      material_row(tags$p("Click on a marker for details."))
    )
  ),
  material_column(
    width = 9,
    material_card(
      depth = 4,
      leafletOutput("map")
    )
  )
)


####--------------------
# data and details
texto <- tags$body("This simple app was built with R, using the ", 
  tags$a(href = "https://github.com/RobertMyles/tidyRSS", "tidyRSS"), ", ",
  tags$a(href = "https://rstudio.github.io/leaflet/", "leaflet"), ", and ",
  tags$a(href = "https://ericrayanderson.github.io/shinymaterial/", "shinymaterial"), 
  " packages, with, of course, Shiny.")

dd <- material_row(
  material_column(width = 1),
  material_column(width = 11,
                  tags$h3("About"),
                  tags$p(texto),
                  tags$br(),
                  downloadButton("downloadData", "Download"),
                  DT::dataTableOutput("table")
                  )
)


####----------------
ui <- material_page(
  nav_bar_color = "#00695c teal darken-1",
  title = "mapping GeoRSS feeds with R",
  tags$br(),
  
  
  material_tabs(
    color = "#009688 teal",
    tabs = c(
      "Map" = "first_tab",
      "Data & Details" = "second_tab"
    )
  ),
  # Define tab content
  material_tab_content(
    tab_id = "first_tab",
    mapp
  ),
  material_tab_content(
    tab_id = "second_tab",
    dd
  )
)


