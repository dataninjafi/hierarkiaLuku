


kaikkiNa <- function(vector){
    is.na(vector) %>% 
        all()
}

tyhjatRivit <- function(df){
   df %>% 
        apply(1, kaikkiNa) %>%
        sum()
}

eiLoydyVastinetta <- function(df, avaimet){
    result <- df %>% 
        t %>% 
        as.vector() %>% 
        setdiff(avaimet, .) %>% 
        ifelse(length(.)==0, NA, .)
    if( is.na(result)){
        c("Avaimet ok!")  
    } else {
        paste("Tässä virhe:",result)
    }
}

vieraatMerkit <- function(df){
    df %>% 
        t %>% 
        as.vector() %>% 
        .[!is.na(.)] %>% 
        paste0(collapse="") %>% 
        gsub("[a-zA-Z0-9äöÄÖ]","",.) %>% 
        strsplit("") %>% 
        flatten() %>% 
        unique() %>% 
        paste0(., collapse="") %>% 
        paste0("vieraat merkit: ",.)
}

duplikaattiNimi <- function(df){
    df %>% 
        t %>% 
        as.vector() %>% 
        .[!is.na(.)] %>% 
        .[duplicated(.)] %>% 
        paste(., collapse=", ")
}
