#CABEÇALHO
rm(list = ls()) #limpar tudo

# #necessário 
# install.packages("openxlsx")
library(openxlsx)


##############################

#ler o intervalo de dias
data.inicial <-   "01/01/2017"
data.final   <-   "03/01/2017"

##############################

#definir o intervalo das datas
ini <- as.Date(data.inicial, "%d/%m/%Y")
fim <- as.Date(data.final, "%d/%m/%Y")
intervalo <- as.Date(as.numeric(ini):as.numeric(fim), origin="1970-01-01") #define o intervalo

#ler a sequencia de arquivos
arq <- c()
for (i in 1:length(intervalo)) {
    date <-
        unlist(strsplit(as.character(format(
            intervalo[i], "%y-%m-%d"
        )), "-"))
    date2 <-
        paste0("originais.csv/L0", date[1], date[2], date[3], ".csv")
    arq <-
        rbind(arq,
              read.csv(
                  date2,
                  head = FALSE,
                  skip = 2,
                  stringsAsFactors = FALSE
              ))
}

#cabeçalho das colunas
cab <-
    read.csv(date2,
             head = FALSE,
             nrows = 2,
             stringsAsFactors = FALSE)
cab2 <- paste(cab[1, ], cab[2, ])
colnames(arq) <- cab2

#procurar dados inválidos e substituir por NA
for (i in seq(3, 85, 2)) {
    inv <- grepl("INVALID", arq[, i])
    for (j in 1:length(inv)) {
        if (inv[j] == TRUE) {
            arq[j, i + 1] = NA
        }
    }
}

#eliminar as colunas status
arq <- arq[, -seq(3, 85, 2)]

#melhorar a formatação das horas
dh2 <-
    as.POSIXct(paste(arq[, 1], arq[, 2]), format = "%m/%d/%y %I:%M:%OS %p")
dias <- format(dh2, "%d-%m-%y")
horas <- format(dh2, "%H:%M")
arq[, 1] <- dias
arq[, 2] <- horas

#melhorar os nomes do cabeçalho
a1 <- rep(c("_media", "_max", "_min"), 13)
a2 <-
    rep(
        c(
            "PA",
            "TA",
            "UR",
            "RG",
            "US_20",
            "US_60",
            "US_40",
            "TS_20",
            "TS_60",
            "TS_40",
            "UF",
            "VNT_dir",
            "VNT_vel"
        ),
        e = 3
    )
a3 <- paste0(a2, a1)
colnames(arq) <- c("data", "hora", a3, "P", "DC")

#reordenar as variáveis
arq <- arq[c(1,2,42,6,7,8,9,10,11,24,25,26,30,31,32,27,28,29,15,16,17,21,
             22,23,18,19,20,3,4,5,12,13,14,33,34,35,36,37,38,39,40,41,43)]

#coloca 10 para a umidade foliar acima de 333 e 0 para abaixo disso
for(u in (34:36)) {
    rd <- arq[, u]
    for (f in 1:length(rd)) {
        if (arq[f, u] > 333) {
            arq[f, u] <- 10/60
        } else{
            arq[f, u] <- 0
        }
    }
}

#gravar um csv separado por ;
write.table(
    arq,
    file = paste0(
        "output/",
        format(ini, "%d%m%y"),
        "-",
        format(fim, "%d%m%y"),
        "-10min.csv"
    ),
    sep = ";",
    row.names = FALSE
)

#gravar um excel .xlsx
write.xlsx(
    arq,
    file = paste0(
        "output/",
        format(ini, "%d%m%y"),
        "-",
        format(fim, "%d%m%y"),
        "-10min.xlsx"
    ),
    showNA = FALSE,
    row.names = FALSE
)

##############################

####DADOS POR HORA####
arq.h <- c()
for (i in seq(1, length(arq[, 1]), 6)) {
    #cada período de 10 minutos (são 6 em uma hora)
    arq.temp <- (arq[i:(i + 5),])
    arq.h <- rbind(arq.h,
                   c(
                       arq[i, 1:2],
                       sapply(arq.temp[seq(4, 43, 3)], mean, na.rm = TRUE),
                       sapply(arq.temp[seq(5, 41, 3)], max, na.rm = TRUE),
                       sapply(arq.temp[seq(6, 42, 3)], min, na.rm = TRUE),
                       sapply(arq.temp[c(3)], sum, na.rm = TRUE)
                   ))
}
#colunas médias # 4,7,10,13,16,19,22,25,28,31,34,37,40,43
#colunas máxima # 5,8,11,14,17,20,23,26,29,32,35,38,41
#colunas mínima # 6,9,12,15,18,21,24,27,30,33,36,39,42
#colunas soma # 3

#ordenar as variáveis
ordem <- rep(3:15,e=3) + c(0,14,27)
arq.h <- arq.h[,c(1,2,43,ordem,16)]

#gravar um csv separado por ;
write.table(
    arq.h,
    file = paste0(
        "output/",
        format(ini, "%d%m%y"),
        "-",
        format(fim, "%d%m%y"),
        "-hora.csv"
    ),
    sep = ";",
    row.names = FALSE
)

#gravar um excel .xlsx
write.xlsx(
    arq.h,
    file = paste0(
        "output/",
        format(ini, "%d%m%y"),
        "-",
        format(fim, "%d%m%y"),
        "-hora.xlsx"
    ),
    row.names = FALSE
)


##############################

####DADOS POR DIA####
arq.d <- c()
for (i in seq(1, length(arq[, 1]), 6 * 24)) {
    #cada período de 10 minutos (são 6*24 em uma hora)
    arq.temp <- (arq[i:(i + 143), ])
    arq.d <- rbind(arq.d, c(
        arq[i, 1:2],
        sapply(arq.temp[seq(4, 43, 3)], mean, na.rm = TRUE),
        sapply(arq.temp[seq(5, 41, 3)], max, na.rm = TRUE),
        sapply(arq.temp[seq(6, 42, 3)], min, na.rm = TRUE),
        sapply(arq.temp[c(3)], sum, na.rm = TRUE)
    ))
}

#ordenar as variáveis
arq.d <- arq.d[,c(1,2,43,ordem,16)]

#eliminar a coluna da hora
# arq.d <- arq.d[,-2]
arq.d[,2] <- ""

#CALCULO ETO
TMax <- unlist(arq.d[,5])
TMin <- unlist(arq.d[,6])
TMed <- unlist(arq.d[,4])
UR <- unlist(arq.d[,7])
Vv <- unlist(arq.d[,40])
Rn <- unlist(arq.d[,31])

arq.d <- cbind(arq.d, ETO = ETOCalc(TMax, TMin, TMed, UR, Vv, Rn, alt = 1000, zv=2, lat = -0.4712))

#gravar um csv separado por ;
write.table(
    arq.d,
    file = paste0(
        "output/",
        format(ini, "%d%m%y"),
        "-",
        format(fim, "%d%m%y"),
        "-dia.csv"
    ),
    sep = ";",
    row.names = FALSE
)
#gravar um excel .xlsx
write.xlsx(
    arq.d,
    file = paste0(
        "output/",
        format(ini, "%d%m%y"),
        "-",
        format(fim, "%d%m%y"),
        "-dia.xlsx"
    ),
    row.names = FALSE
)



