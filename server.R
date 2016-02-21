library(shiny)
library(readxl)
library(dplyr)
library(xlsx)
source("toiminnallisuus.R")

shinyServer(function(input, output) {
    output$contents <- renderTable({
        
        inFile <- input$file1
        inFile2 <- input$file2
        inFile3 <- input$file3
        
        if (is.null(input$file1)) {
            return(NULL)
        }
        

            
        ext <- tools::file_ext(inFile$name)
        file.rename(inFile$datapath,
                    paste(inFile$datapath, ext, sep="."))
        

        hierarkia <- read_excel(paste(inFile$datapath, ext, sep="."), 
                                col_names = F)
        
        

        palaute <- data.frame(palaute = c(
                paste("Uudessa hierarkiassa tyhjiä rivejä:",
                      tyhjatRivit(hierarkia), "kpl."),
                paste("Uudessa hierarkiassa",
                      vieraatMerkit(hierarkia)),
                paste("Hierarkiasta löytyvä duplikaattinimet:", duplikaattiNimi(hierarkia))
            ))

        if (!is.null(inFile2) & !is.null(inFile3)) {
            
            ext2 <- tools::file_ext(inFile2$name)
            ext3 <- tools::file_ext(inFile3$name)
            file.rename(inFile2$datapath,
                        paste(inFile2$datapath, ext2, sep="."))
            file.rename(inFile3$datapath,
                        paste(inFile3$datapath, ext3, sep="."))
        
            
            avaimet <- read_excel(paste(inFile2$datapath, ext2, sep="."), 
                                  col_names = F) %>%
                select(1:2)
            hierarkiaVanha <- read_excel(paste(inFile3$datapath, ext3, sep="."),
                                         col_names = F)
            vanha <- data.frame(palaute = c(
                paste("Vanhassa hierarkiassa duplikaatteja:",
                      duplikaattiNimi(hierarkiaVanha)),
                paste("Uudet avaimet:",
                      eiLoydyVastinetta(hierarkia, avaimet[[1]])),
                paste("Vanhat avaimet:",
                      eiLoydyVastinetta(hierarkiaVanha, avaimet[[2]]))
            ))

            palaute <- rbind(palaute, vanha)
        }

        palaute


        
        
        
    })
})