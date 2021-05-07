rm(list=ls())
#install.packages("tidyverse")
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
Boletim_curitibanos_dia <- muni_sc("CURITIBANOS", 1000, -0.4712)
Boletim_florianopolis_dia <- muni_sc("FLORIANOPOLIS", 1.8, -27.6025)
Boletim_urussanga_dia <- muni_sc("URUSSANGA",48 ,-28.53249999)
Boletim_saojoaquim_dia <- muni_sc("SAO JOAQUIM", 1410, -28.27555554)
Boletim_novohorizonte <- muni_sc("NOVO HORIZONTE", 960, -26.40694444)
Boletim_indaial <- muni_sc("INDAIAL_A817", 86.13, -26.91361111)
Boletim_joacaba_dia <- muni_sc("JOACABA")
Boletim_bomjardimdaserra_dia <- muni_sc("BOM JARDIM DA SERRA",)
Boletim_dionisiocerqueira_dia <- muni_sc("DIONISIO CERQUEIRA", )
Boletim_itapoa_dia <- muni_sc("ITAPOA", )
Boletim_saomigueldooeste_dia <- muni_sc("SAO MIGUEL DO OESTE",)
Boletim_xanxere_dia <- muni_sc("XANXERE", )
Boletim_cacador_dia <- muni_sc("CACADOR")
Boletim_riodocampo_dia <- muni_sc("RIO DO CAMPO")
Boletim_rionegrinho_dia <- muni_sc("RIO NEGRINHO")
Boletim_ituporanga_dia <- muni_sc("ITUPORANGA")
Boletim_majorvieira_dia <- muni_sc("MAJOR VIEIRA")
Boletim_lages_dia <- muni_sc("LAGES")
Boletim_laguna_dia <- muni_sc("Laguna - Farol de Santa Marta")
Boletim_ararangua_dia <- muni_sc("ARARANGUA")
Boletim_itajai_dia <- muni_sc("ITAJAI")
Boletim_ranchoqueimado_dia <- muni_sc("RANCHO QUEIMADO")
Boletim_chapeco_dia <- muni_sc("CHAPECO")
Boletim_camposnovos_dia <- muni_sc("CAMPOS NOVOS")

x <- Boletim_curitibanos_dia


## salvar xlsx ####
rio::export(Boletim_indaial_dia, "public/Boletim_indaial_dia.xlsx")



