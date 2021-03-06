getTablesFromSQL <- function(tableName, schema="dbo"){
  con <- dbConnect(odbc::odbc(),Driver = "SQL Server",Server = "sql",Database = "OpenData")
  dt <- tbl(con, in_schema(schema, tableName)) %>% collect() %>% as.data.table()
  dbDisconnect(con)
  dt
}

actualiseTableFromSQL <- function(i){
  tableName <- Tableaux[i,]$TableName
  fileName <- Tableaux[i,]$FileName
  cat(sprintf("R�cup�ration de la table\t%s\t...", tableName))
  dt <- getTablesFromSQL(Tableaux[i,]$TableName)
  cat(sprintf("OK.. Ecriture du fichier \t%s", fileName))
  
  
  if (tableName=="vEmploi")
    colnames(dt)<-c("NAF004", "NAF021", "Sexe", "Mois",
                    "Nombre de salari�s", "Effectifs �quivalent temps plein", "Salaire moyen",
                    "Salaire moyen �quivalent temps plein", "Heures", "Horaire moyen",
                    "Nombre employeurs", "Age moyen")
  if (tableName=="vRP2012")
    colnames(dt)<-c("Subdivision", "Commune", "Commune associ�e", "Quartier 2000",
                    "Individus", "Individus des r�sidences principales",
                    "Individus entre 15 et 64 ans","Actifs","Chomeurs","Emploi","Inactifs",
                    "Taux de chomage","Taux d'emploi","Taux d'emploi des 15-64 ans",
                    "Taux d'activite","Taux d'activit� des 15-64 ans",
                    "Logements","R�sidences principales")
  if (tableName=="vEBF")
    colnames(dt)<-c("Subdivision","Division","Groupe","Classe","Taille Du Menage",
                    "D�penses","Autoconsommation","M�nages",
                    "D�penses moyennes par m�nage","D�penses moyennes par m�nage r�pondant",
                    "D�penses moyennes mensuelles par m�nage",
                    "D�penses moyennes mensuelles par m�nage r�pondant",
                    "D�penses moyennes par UC", 
                    "D�penses moyennes par UC r�pondant",
                    "D�penses moyennes mensuelles par UC",
                    "D�penses moyennes mensuelles par UC r�pondant")
  if (tableName=="vEFH")
    colnames(dt)<-c("Mois","Archipel","Classe", "Chambres offertes","Chambres vendues","CMR","RevPar","RMC")
  
  
  
  fwrite(dt,fileName,quote = T, sep = ";", row.names = F, dec=",")
  cat(" OK\n")
}

actualiseTables <- function(ids)
{
  invisible(lapply(ids,actualiseTableFromSQL))
}