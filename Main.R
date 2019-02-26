source("functions/Functions.R")

Tableaux <- fread("files/Tableaux.csv", stringsAsFactors = F)

DataGouv_ConfigureAPI(APIURL = "https://www.data.gouv.fr/api/1",
                      ORGANIZATIONID = "56a29970c751df2a1cade714",
                      APIKEY = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiNTZhMjk5MDdjNzUxZGYyYTFjYWRlNzEzIiwidGltZSI6MTU1MDE5MjE3Mi41MTM4MjN9.mYlcZ38Hx6GDFzSpHm-qewTIwMNMlZMncQqtVYJZm4o")


##DETAIL DE L'ORGANISATION
ispf <- DataGouv_GetDetailOrganisation()
ispf_content <- content(ispf)

i <- 7
Tableaux[i,]
getTable(i)
DataGouv_UpdateResource(i)
DataGouv_UpdateMetaData(i, "title", Tableaux[i,Titre])


##VERBOSE
# p <- DataGouv_UpdateResource(i, verbose = TRUE)
# cp <- content(p)
# cp
# cp$success
# 
# p2 <- DataGouv_UpdateMetaData(i, "title", Tableaux[i,Titre], verbose = TRUE)
# cp2 <- content(p2)
# 
