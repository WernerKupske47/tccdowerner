rm(list=ls())
install.packages("tidyverse")
library(tidyverse)
library(lubridate)

#files <- list.files("dados")
#
#for (files in 1:length(files)) {
#    switch (files,
#            "CURITIBANOS" = files.curitibanos <- list.files(path="dados", pattern = "CURITIBANOS")
#    )
#
#}   

#print(list.files(path="dados", pattern = "CURITIBANOS"))

###DADOS DIARIOS CURITIBANOS###
#criar uma tabela de 3 colunas com os parametro e percorrer e gerar os boletins
#gera os boletim dos munícipios atraves dos seguintes parametros: (Nome, alt, lat)
Boletim_curitibanos_dia <- muni_sc("CURITIBANOS", 860, -27.2886111)
Boletim_florianopolis_dia <- muni_sc("FLORIANOPOLIS", 1.8, -27.6025)
Boletim_urussanga_dia <- muni_sc("URUSSANGA",48 ,-28.53249999)
Boletim_saojoaquim_dia <- muni_sc("SAO JOAQUIM", 1410, -28.27555554)
Boletim_novohorizonte <- muni_sc("NOVO HORIZONTE", 960, -26.40694444)
Boletim_indaial_dia <- muni_sc("INDAIAL", 72.24, -26,913704)
Boletim_joacaba_dia <- muni_sc("JOACABA", 776, -27.16944443)
Boletim_bomjardimdaserra_dia <- muni_sc("BOM JARDIM DA SERRA", 1790.38, -28,126992)
Boletim_dionisiocerqueira_dia <- muni_sc("DIONISIO CERQUEIRA", 807.54 ,-26.286562)
Boletim_itapoa_dia <- muni_sc("ITAPOA", 2,-26.0811111)
Boletim_saomigueldooeste_dia <- muni_sc("SAO MIGUEL DO OESTE", 654.51, -26.77666666)
Boletim_xanxere_dia <- muni_sc("XANXERE", 878.74, -26.938666)
Boletim_cacador_dia <- muni_sc("CACADOR", 944.26, -26.819156)
Boletim_riodocampo_dia <- muni_sc("RIO DO CAMPO", 591.67, -26.937526)
Boletim_rionegrinho_dia <- muni_sc("RIO NEGRINHO", 856.89, -26.248411)
Boletim_ituporanga_dia <- muni_sc("ITUPORANGA", 479.79, -27.41841)
Boletim_majorvieira_dia <- muni_sc("MAJOR VIEIRA", 799.58, -26.393664)
Boletim_lages_dia <- muni_sc("LAGES", 952.7, -27.802228)
Boletim_laguna_dia <- muni_sc("Laguna - Farol de Santa Marta", 34.36, -28.604414)
Boletim_ararangua_dia <- muni_sc("ARARANGUA", 2, -28.931353)
Boletim_itajai_dia <- muni_sc("ITAJAI", 9.76, -26.950924)
Boletim_ranchoqueimado_dia <- muni_sc("RANCHO QUEIMADO", 881, -27.678507)
Boletim_chapeco_dia <- muni_sc("CHAPECO", 680, -27.95527777)
Boletim_camposnovos_dia <- muni_sc("CAMPOS NOVOS", 963, -27.3886111)

## salvar xlsx ####
rio::export(Boletim_curitibanos_dia, "public/Boletim_curitibanos_dia.xlsx")



