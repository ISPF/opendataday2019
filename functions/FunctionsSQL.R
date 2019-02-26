getTablesFromSQL <- function(tableName, schema="dbo"){
  con <- dbConnect(odbc::odbc(),Driver = "SQL Server",Server = "sql",Database = "OpenData")
  dt <- tbl(con, in_schema(schema, tableName)) %>% collect() %>% as.data.table()
  dbDisconnect(con)
  dt
}

actualiseTableFromSQL <- function(i){
  tableName <- Tableaux[i,]$TableName
  fileName <- Tableaux[i,]$FileName
  cat(sprintf("Récupération de la table\t%s\t...", tableName))
  dt <- getTablesFromSQL(Tableaux[i,]$TableName)
  cat(sprintf("OK.. Ecriture du fichier \t%s", fileName))
  
  
  if (tableName=="vEmploi")
    colnames(dt)<-c("NAF004", "NAF021", "Sexe", "Mois",
                    "Nombre de salariés", "Effectifs équivalent temps plein", "Salaire moyen",
                    "Salaire moyen équivalent temps plein", "Heures", "Horaire moyen",
                    "Nombre employeurs", "Age moyen")
  if (tableName=="vRP2012")
    colnames(dt)<-c("Subdivision", "Commune", "Commune associée", "Quartier 2000",
                    "Individus", "Individus des résidences principales",
                    "Individus entre 15 et 64 ans","Actifs","Chomeurs","Emploi","Inactifs",
                    "Taux de chomage","Taux d'emploi","Taux d'emploi des 15-64 ans",
                    "Taux d'activite","Taux d'activité des 15-64 ans",
                    "Logements","Résidences principales")
  if (tableName=="vEBF")
    colnames(dt)<-c("Subdivision","Division","Groupe","Classe","Taille Du Menage",
                    "Dépenses","Autoconsommation","Ménages",
                    "Dépenses moyennes par ménage","Dépenses moyennes par ménage répondant",
                    "Dépenses moyennes mensuelles par ménage",
                    "Dépenses moyennes mensuelles par ménage répondant",
                    "Dépenses moyennes par UC", 
                    "Dépenses moyennes par UC répondant",
                    "Dépenses moyennes mensuelles par UC",
                    "Dépenses moyennes mensuelles par UC répondant")
  if (tableName=="vEFH")
    colnames(dt)<-c("Mois","Archipel","Classe", "Chambres offertes","Chambres vendues","CMR","RevPar","RMC")
  
  
  
  fwrite(dt,fileName,quote = T, sep = ";", row.names = F, dec=",")
  cat(" OK\n")
}

actualiseTables <- function(ids)
{
  invisible(lapply(ids,actualiseTableFromSQL))
}