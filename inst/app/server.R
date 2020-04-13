source("global.R")

serv <- function(input, output) {
  geo <- reactive({
    validate(
      need(nchar(input$feed) > 1, "Please enter an url for the geoRSS feed. 
           If you don't have one, \n https://inciweb.nwcg.gov/feeds/rss/incidents/ \n
           is a good one. It shows wildfires.")
    )
    url <- trimws(input$feed)
    g <- tidygeo(url) %>% sf::st_as_sf()
    g_coords <- sf::st_coordinates(g) %>%
      dplyr::as_tibble() %>% 
      dplyr::rename(long = Y, lat = X)
    g <- dplyr::bind_cols(g, g_coords)
    g
  })

  output$map <- renderLeaflet({
    icons <- awesomeIcons(
      icon = "glyphicon-fire",
      iconColor = "black",
      library = "glyphicon",
      markerColor = "#ee5622"
    )

    lmap <- leaflet(data = geo()) %>%
      addAwesomeMarkers(~long, ~lat,
        icon = icons,
        popup = ~ htmlEscape(item_title)
      )


    if (input$plot_theme == "osm") {
      lmap <- lmap %>%
        addProviderTiles(providers$OpenStreetMap,
          options = providerTileOptions(noWrap = TRUE)
        )
    } else if (input$plot_theme == "stoner") {
      lmap <- lmap %>%
        addProviderTiles(providers$Stamen.TonerLite,
          options = providerTileOptions(noWrap = TRUE)
        )
    } else if (input$plot_theme == "natgeo") {
      lmap <- lmap %>%
        addProviderTiles(providers$Esri.NatGeoWorldMap,
          options = providerTileOptions(noWrap = TRUE)
        )
    }

    lmap
  })

  geo2 <- reactive({
    validate(
      need(nchar(input$feed) > 1, "")
    )
    url <- trimws(input$feed)
    g <- tidygeo(url)
    g
  })
  output$downloadData <- downloadHandler(
    filename <- paste0("geoRSSfeedData-", Sys.Date(), ".csv"),
    content = function(file) {
      write.csv(geo2(), file, row.names = FALSE)
    }
  )
  output$table <- DT::renderDataTable(geo2())
}
