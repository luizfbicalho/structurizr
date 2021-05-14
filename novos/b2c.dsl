workspace "B2C" "Processo B2C" {
    model {
    compraSite = person "Compra Site/Alpashop" "Compra Site/Alpashop" "Web Browser"
    group "Linx" {
      linx = softwaresystem "LINX" "" "Existing System"{
              geraVenda = container "Gera Venda" "" ""
      }
    }

        enterprise "Alpargatas"{
            
          
            sap = softwaresystem "SAP" "" "Existing System"{

                geraOV = container "Gera OV" "" "SAP RFC"
                transfMat = container "Transf Mat A297-A298" "" "SAP RFC" {
                    reservaEstoque = component "Reserva Estoque OMN" "" ""
                    geraNFTransf = component "Gera NF Transf" "" ""
                }
                alocaMat = container "Aloca Material" "" "SAP RFC"
                alocaRuptura = container "Aloca Ruptura Prévia" "" "SAP RFC"
                geraRemessa = container "Gera Remessa" "" "SAP RFC"
                geraFatura = container "Gera Fatura" "" "SAP RFC"
                enviaRemessaNf = container "Envia Remessa e Nota fiscal" "" "SAP RFC"
                montaPacoteArquivos = container "Monta Pacote Arquivos" "" "SAP RFC"

                nfINFFile = container "Arquivo NF Cab" "Arquivos INF" "arquivo" "arquivo"
                nfIdtFile = container "Arquivo NF Itm" "Arquivos IDT" "arquivo" "arquivo"
                nfPdfFile = container "Arquivo NF PDF" "Arquivos PDF" "arquivo" "arquivo"

              
                leituraColeta = container "Leitura Arquivos Coleta" "" "SAP RFC"
                geraDT = container "Gera DT" "" "SAP RFC"

                group "GNF" {
                    validaNF = container "Valida Nota Fiscal" "" "SAP RFC"
                    enviaNFDir = container "Envia Nota Fiscal para Diretorio" "" "SAP RFC"
                    nfDir = container "Diretorio NF" "Diretorio NF" "arquivo" "arquivo"
                }
            }


            
        }
        wms = softwaresystem "WMS" "" "Existing System"{
                expedicao = container "Expedição" "" "SAP RFC"
                coleta = container "Coleta" "" "SAP RFC"
                coletaFile = container "Arquivo ***" "Arquivos ***" "arquivo" "arquivo"

        }

        compraSite -> geraVenda "" "SAP"
        geraVenda -> geraOV "" "SAP"
        geraOV -> transfMat "" "SAP"
        
        transfMat -> alocaMat "" "SAP"
        reservaEstoque -> geraNFTransf "" "SAP"



        alocaMat -> alocaRuptura "" "SAP"
        alocaRuptura -> geraRemessa "" "SAP"
        geraRemessa -> geraFatura "" "SAP"
        geraFatura -> enviaRemessaNf "" "SAP"
        enviaRemessaNf -> montaPacoteArquivos "" "SAP"
        geraFatura -> validaNF "" "SAP"





        montaPacoteArquivos -> nfINFFile "Geração de arquivo" "SFTP" "Risk"
        montaPacoteArquivos -> nfIdtFile "Geração de arquivo" "SFTP" "Risk"
        montaPacoteArquivos -> nfPdfFile "Geração de arquivo" "SFTP" "Risk"



        nfINFFile -> expedicao "Importação de arquivo" "SFTP" "Risk"
        nfIdtFile -> expedicao "Importação de arquivo" "SFTP" "Risk"
        nfPdfFile -> expedicao "Importação de arquivo" "SFTP" "Risk"


        expedicao -> coletaFile "Geração de arquivo" "SFTP" "Risk"
        coletaFile -> leituraColeta "Importação de arquivo" "SFTP" "Risk"


        expedicao -> coleta "" "SAP"
        leituraColeta -> geraDT "" "SAP"




        validaNF -> enviaNFDir "Geração de arquivo" "SFTP" "Risk"
        enviaNFDir -> nfDir  "Envio de arquivo" "SFTP" "Risk"

    }
    views {
        systemlandscape "SystemLandscape" "Landscape" {
            include *
            autoLayout lr
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

        component transfMat "ComponentSAP" {
            include *

            autoLayout
        }
        
       styles {

        }
            themes "https://raw.githubusercontent.com/luizfbicalho/structurizr/master/theme/alpargatas.json"

    }
}