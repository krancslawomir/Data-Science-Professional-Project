
#### Adding labels to factor.

AddMyLabels <- function(text){
  
  return(factor(text, levels = c(101, 
                                 102, 
                                 103, 
                                 104, 
                                 105, 
                                 106, 
                                 107, 
                                 108,
                                 109,
                                 110
),
                labels = c("Borowik",
                           "Czubajka",
                           "Gąska",
                           "Podgrzybek",
                           "Koźlarz",
                           "Maślak",
                           "Opieńka",
                           "Gołąbek",
                           "Boczniak",
                           "Pieczarka"
)
  ))
}