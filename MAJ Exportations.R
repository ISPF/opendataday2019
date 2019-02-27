#############################
# MISE A JOUR D'UNE RESSOURCE
#############################

source("functions/Functions.R")
DataGouv_ConfigureAPI(APIURL = "https://www.data.gouv.fr/api/1",
                      ORGANIZATIONID = "56a29970c751df2a1cade714",
                      APIKEY = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiNTZhMjk5MDdjNzUxZGYyYTFjYWRlNzEzIiwidGltZSI6MTU1MDE5MjE3Mi41MTM4MjN9.mYlcZ38Hx6GDFzSpHm-qewTIwMNMlZMncQqtVYJZm4o")

i <- 7
t(Tableaux[i,.(Titre, FileName,DatasetID, ResourceID)])
DataGouv_UpdateResource(i)
DataGouv_UpdateMetaData(i, "title", "Exportations en Polynésie française - 2019")
DataGouv_UpdateMetaData(i, "description", "Demo Amphi CCISM")
