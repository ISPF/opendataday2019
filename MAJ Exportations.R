
#############################
# MISE A JOUR D'UNE RESSOURCE
#############################

i <- 7
Tableaux[i,]
dtFichier <- getTable(i)
dtViaAPI <- DataGouv_GetResource(i)

DataGouv_UpdateResource(i)
DataGouv_UpdateMetaData(i, "title", Tableaux[i,Titre])
DataGouv_UpdateMetaData(i, "description", "Exportations 2018 de la Polynésie française")