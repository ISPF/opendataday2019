source("functions/Functions.R")

DataGouv_ConfigureAPI(APIURL = "https://www.data.gouv.fr/api/1",
                      ORGANIZATIONID = "56a29970c751df2a1cade714",
                      APIKEY = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiNTZhMjk5MDdjNzUxZGYyYTFjYWRlNzEzIiwidGltZSI6MTU1MDE5MjE3Mi41MTM4MjN9.mYlcZ38Hx6GDFzSpHm-qewTIwMNMlZMncQqtVYJZm4o")

#############################
##DETAIL DE L'ORGANISATION
#############################

ispf <- content(DataGouv_GetDetailOrganisation())
exportJSON <- jsonlite::toJSON(ispf, pretty = T)
write(exportJSON, file="ispf.json")

####################################
#DETAIL D'UN DATATSET EN PARTICULIER
####################################
numDS <- 3
ispf$data[[numDS]]$title
ispf$data[[numDS]]$last_modified
ispf$data[[numDS]]$description
resource <- ispf$data[[numDS]]$resources[[1]]
resource$title
resource$url

#############################
#RECUPERATION D'UNE RESSOURCE
#############################
dt <- DataGouv_GetResource(11)