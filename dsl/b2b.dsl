workspace "B2B" "Processo B2B" {
    model {
    geraPedido = person "Gera Pedido" "Geração do Pedido" "Web Browser"

        enterprise "Alpargatas"{
            
             
            sap = softwaresystem "SAP" "" "Existing System"{
                geraOV = container "Gera OV" "" "SAP RFC"
                liberaCredito = container "Libera Crédito" "" "SAP RFC"
                alocaRemessa = container "Aloca e Gera Remessa" "" "SAP RFC"
                enviaRemessa = container "Envia Remessa" "" "SAP RFC"
                nfCabFile = container "Arquivo NF Cab" "Arquivos CAB" "arquivo" "arquivo"
                nfItmFile = container "Arquivo NF Itm" "Arquivos ITM" "arquivo" "arquivo"

                recebeSolFat = container "Recebe Sol. FAT" "" "SAP RFC"
                pickpackSmFat = container "PICK/PACK/SM/FAT" "" "SAP RFC"
                geraNF = container "Gera Nota Fiscal" "" "SAP RFC"
                enviaNF = container "Envia Doc. Fat./NF" "" "SAP RFC"
                
                nfPdfFile = container "Arquivo NF PDF" "Arquivos PDF" "arquivo" "arquivo"


                importaColeta = container "Importa Coleta" "" "SAP RFC"
                criaDT = container "Cria DT" "" "SAP RFC"

                group "GNFE-NF" {
                    validaNF = container "Valida Nota Fiscal" "" "SAP RFC"
                    enviaNFDir = container "Envia Nota Fiscal para Diretorio" "" "SAP RFC"
                    nfDir = container "Diretorio NF" "Diretorio NF" "arquivo" "arquivo"
                }
            }


            
        }
        wms = softwaresystem "WMS" "" "Existing System"{
                recebeRemessa = container "Recebe Remessa" "" "SAP RFC"
                geraOnda = container "Gera Onda" "" "SAP RFC"
                pickingPacking = container "Picking Packing" "" "SAP RFC"
                solicitaFaturamento = container "Solicita Faturamento" "" "SAP RFC"
                anfFile = container "Arquivo ANF" "Arquivos ANF" "arquivo" "arquivo"
                adtFile = container "Arquivo ADT" "Arquivos ADT" "arquivo" "arquivo"
                coletaFile = container "Arquivo ***" "Arquivos ***" "arquivo" "arquivo"

                despachoMercadoria = container "Despacho Mercadoria" "" "SAP RFC"
                enviaColeta = container "Envia Coleta" "" "SAP RFC"
                imprimeNf = container "Imprime Nota Fiscal" "" "SAP RFC"
        }

        geraPedido -> geraOV "" "SAP"
        geraOV -> liberaCredito "" "SAP"
        liberaCredito -> alocaRemessa "" "SAP"
        alocaRemessa -> enviaRemessa "" "SAP"
        enviaRemessa -> nfCabFile "Geração de arquivo" "SFTP" "Risk"
        enviaRemessa -> nfItmFile "Geração de arquivo" "SFTP" "Risk"
        nfCabFile -> recebeRemessa "Importação de arquivo" "SFTP" "Risk"
        nfItmFile -> recebeRemessa "Importação de arquivo" "SFTP" "Risk"
        recebeRemessa -> geraOnda "" "SAP"
        geraOnda  -> pickingPacking "" "SAP"
        pickingPacking  -> solicitaFaturamento "" "SAP"
        solicitaFaturamento -> anfFile "Importação de arquivo" "SFTP" "Risk"
        solicitaFaturamento -> adtFile "Importação de arquivo" "SFTP" "Risk"
        solicitaFaturamento  ->  despachoMercadoria "" "SAP"
        anfFile -> recebeSolFat "Importação de arquivo" "SFTP" "Risk"
        adtFile -> recebeSolFat "Importação de arquivo" "SFTP" "Risk"
        recebeSolFat -> pickpackSmFat "" "SAP"
        pickpackSmFat -> geraNF "" "SAP"
        geraNF -> enviaNF  "" "SAP"
        geraNF -> validaNF "" "SAP"
        enviaNF -> nfPdfFile "Geração de arquivo" "SFTP" "Risk"
        nfPdfFile -> imprimeNf "Importação de arquivo" "SFTP" "Risk"
        imprimeNf -> despachoMercadoria "" "SAP"
        despachoMercadoria -> enviaColeta "" "SAP"
        enviaColeta -> coletaFile "Geração de arquivo" "SFTP" "Risk"
        coletaFile -> importaColeta "Importação de arquivo" "SFTP" "Risk"
        importaColeta -> criaDT "" "SAP"

        validaNF -> enviaNFDir "Geração de arquivo" "SFTP" "Risk"
        enviaNFDir -> nfDir  "Envio de arquivo" "SFTP" "Risk"

    }
    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }
        

        
          container sap "ContainersSAp" {
            include *

            autoLayout
        }
       systemcontext wms "SystemContextWms" {
            include *
            autoLayout
        }
        
          container wms "ContainersWms" {
            include *

            autoLayout
        }
        
       styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
                background #999999
            }
/*            element "Customer" {
                background #08427b
            }
            element "Bank Staff" {
                background #999999
            }
            */
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            /*element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            */
            element "arquivo" {
                shape Folder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            /*element "Failover" {
                opacity 25
            }*/

            relationship "Risk" {
                thickness 2
                color #FF0000
                colour #FF0000
                dashed false

            }
        }
    }
}