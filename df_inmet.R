## Função para extrair dados dos arquivos INMET

df_inmet <- function(x, path=".") {
  col <- c("data", "hora","prec","patm","patm.max","patm.min",
           "rg","tar","tpo","tar.max","tar.min","tpo.max","tpo.min",
           "ur.max","ur.min","ur","vento.dir","vento.raj","vento.vel","drop")
  
  df <- c()
  for (i in x) {
    df <- rbind(df, rio::import(paste0(path, i),
                                skip = 8,
                                dec = ",",
                                col.names=col
    )) 
  }
  
  df <- df %>%
    mutate(data = ymd_hm(paste(data, hora), tz = "UTC")) %>%
    mutate(data = with_tz(data, tzone="America/Sao_Paulo")) %>%
    select(-c(hora, drop))
  
  return(tibble(df))
}

muni_sc  <- function(x, alt, lat) {
  x <- list.files(path="dados", pattern = x) %>%
    df_inmet(path = "dados/") %>%
    na_if(-9999) %>%
    group_by(date(data)) %>%
    summarise(
      prec = sum(prec),
      tar = mean(tar),
      tar.min = min(tar.min),
      tar.max = max(tar.max),
      ur = mean(ur),
      vento.vel = mean(vento.vel),
      rg = sum(rg, na.rm = TRUE)
    )  %>%
    mutate(rg = case_when(is.na(prec) ~ NA_real_, TRUE ~ rg))  #rg= NA baseado na prec
  
  ## INSERIR EVAPOTRANSPIRAÇAO
  TMax <- unlist(x[,5])
  TMin <- unlist(x[,4])
  TMed <- unlist(x[,3])
  UR <- unlist(x[,6])
  Vv <- unlist(x[,7])
  Rg <- unlist(x[,8])
  
  #adiciona a coluna da ETO        
  x <- cbind(x, ETO = ETOCalc(TMax, TMin, TMed, UR, Vv, Rg, alt, zv=2, lat))
}
