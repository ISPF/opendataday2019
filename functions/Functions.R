library(dplyr)
library(dbplyr)
library(DBI)
library(data.table)
library(httr)

DataGouv_ConfigureAPI <- function(APIURL, ORGANIZATIONID, APIKEY){
  APIURL <<- APIURL
  ORGANIZATIONID <<- ORGANIZATIONID
  APIKEY <<- APIKEY
}

DataGouv_GetDetailOrganisation <- function(){
  ispf <- GET(sprintf("%s/organizations/%s/datasets/",APIURL, ORGANIZATIONID))
  cat("Liste des datasets\n")
  invisible(lapply(content(ispf)$data, FUN <- function(x) { cat(sprintf("%s \n",x$title))  }))
  ispf
}

DataGouv_UpdateResource <- function(numTableau, verbose=FALSE){
  DatasetID <- Tableaux[numTableau,DatasetID]
  ResourceID <- Tableaux[numTableau,ResourceID]
  file <- paste0("files/",Tableaux[numTableau,FileName])
  
  cat(sprintf("Mise à jour sur Data.gouv.fr\nRessource\t:%s\nDataset  \t:%s\nFichier  \t:%s\n",
              ResourceID, DatasetID, file))
  
  if (verbose)
    p <- POST(
      url = sprintf('%s/datasets/%s/resources/%s/upload/',APIURL,DatasetID, ResourceID),
      config=list(type="main"),
      add_headers("X-Api-Key" = APIKEY),
      body=list(file=upload_file(path=file,type="text/csv")),
      verbose())
  else
    p <- POST(
      url = sprintf('%s/datasets/%s/resources/%s/upload/',APIURL,DatasetID, ResourceID),
      config=list(type="main"),
      add_headers("X-Api-Key" = APIKEY),
      body=list(file=upload_file(path=file,type="text/csv")))
  p
}

DataGouv_UpdateMetaData <- function(numTableau, cle, valeur, verbose=FALSE){
  
  DatasetID <- Tableaux[numTableau,DatasetID]
  ResourceID <- Tableaux[numTableau,ResourceID]
  file <- paste0("files/",Tableaux[numTableau,FileName])
  l <- list(cle=valeur)
  names(l) <- cle
  
  if (verbose)
    p <- PUT(
      url = sprintf('%s/datasets/%s/resources/%s/',APIURL,DatasetID, ResourceID),
      add_headers("X-Api-Key" = APIKEY,
                  "Content-Type" = "application/json"),
      body = jsonlite::toJSON(l),
      #body=jsonlite::toJSON(list("title"=valeur)),
      verbose())
  else
    p <- PUT(
      url = sprintf('%s/datasets/%s/resources/%s/',APIURL,DatasetID, ResourceID),
      add_headers("X-Api-Key" = APIKEY,
                  "Content-Type" = "application/json"),
      body = jsonlite::toJSON(l))
  p
}

getTable <- function(i){
  tableName <- Tableaux[i,]$TableName
  fileName <- paste0("files/",Tableaux[i,]$FileName)
  cat(sprintf("Lecture du fichier %s\t...", fileName))
  dt <- fread(file = fileName, encoding = "UTF-8")
  cat(" OK\n")
  dt
}