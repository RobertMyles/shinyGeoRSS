#' @import shinymaterial
#' @importFrom shiny tags
#' @importFrom shiny reactive
#' @importFrom shiny validate
#' @importFrom shiny need
#' @importFrom tidyRSS tidyfeed
#' @importFrom shiny downloadButton
#' @importFrom DT dataTableOutput
#' @importFrom DT renderDataTable
#' @importFrom leaflet leafletOutput
#' @importFrom leaflet renderLeaflet
#' @importFrom leaflet awesomeIcons
#' @importFrom leaflet leaflet
#' @importFrom leaflet addProviderTiles
#' @importFrom leaflet providerTileOptions
#' @importFrom leaflet addAwesomeMarkers
#' @importFrom htmltools htmlEscape
#' @title runApp
#' @description runs the shiny app contained in this micro-package
#' @export
runApp <- function() {
  app <- system.file("app", package = "shinyGeoRSS")
  shiny::runApp(app, display.mode = "normal")
}