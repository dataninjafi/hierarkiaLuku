library(shiny)

shinyUI(fluidPage(
    titlePanel("Hierarkioiden ja avainten tarkastus. xlsx-tiedostoina ilman sarakenimiä."),
    sidebarLayout(
        sidebarPanel(
            fileInput("file1", "Lataa uusi hierarkia",
                      accept=c(".xlsx")),
            fileInput("file2", "Lataa vanha hierarkia",
                      accept=c(".xlsx")),
            fileInput("file3", "Lataa avaimet",
                      accept=c(".xlsx"))
        ),
        mainPanel(
            tableOutput("contents")
        )
    )
))