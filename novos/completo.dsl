workspace "Completo" "Processo B2B" {
    model {
        geraPedido = person "Gera Pedido" "Geração do Pedido" "SistemaExterno"
            compraSite = person "Compra Site/Alpashop" "Compra Site/Alpashop" "SistemaExterno"
        
        vendorPerson = person "Operador SAP Vendor" "Usuário que faz a integração dos fornecedores" "Usuario"
    nfPerson = person "Operador SAP NF" "Usuário que faz a integração das notas fiscais de entrada de mercadoria" "Job"

        group "Linx" {
            linx = softwaresystem "LINX" "" "SistemaExterno"{
                geraVenda = container "Gera Venda" "" ""
            }
        }
         enterprise "Alpargatas"{
            
             
            sap = softwaresystem "SAP" "" "SAP" {
                group "B2B"{
                geraOV = container "Gera OV" "" "SAP,Legado"
                liberaCredito = container "Libera Crédito" "" "SAP,Legado"
                alocaRemessa = container "Aloca e Gera Remessa" "" "SAP,Legado"
                enviaRemessa = container "Envia Remessa" "" "SAP,Legado"
                nfCabFile = container "Arquivo NF Cab" "Arquivos CAB" "arquivo" "Arquivo"
                nfItmFile = container "Arquivo NF Itm" "Arquivos ITM" "arquivo" "Arquivo"

                recebeSolFat = container "Recebe Sol. FAT" "" "SAP,Legado"
                pickpackSmFat = container "PICK/PACK/SM/FAT" "" "SAP,Legado"
                geraNF = container "Gera Nota Fiscal" "" "SAP,Legado"
                enviaNF = container "Envia Doc. Fat./NF" "" "SAP,Legado"
                



                importaColeta = container "Importa Coleta" "" "SAP,Legado"
                criaDT = container "Cria DT" "" "SAP,Legado"
                }

                group "B2C"         {
               
                transfMat = container "Transf Mat A297-A298" "" "SAP,Legado" {
                    reservaEstoque = component "Reserva Estoque OMN" "" "Form"
                    geraNFTransf = component "Gera NF Transf" "" "Report"
                }
                alocaMat = container "Aloca Material" "" "SAP,Legado"
                alocaRuptura = container "Aloca Ruptura Prévia" "" "SAP,Legado"
                geraRemessa = container "Gera Remessa" "" "SAP,Legado"
                geraFatura = container "Gera Fatura" "" "SAP,Legado"
                enviaRemessaNf = container "Envia Remessa e Nota fiscal" "" "SAP,Legado"
                montaPacoteArquivos = container "Monta Pacote Arquivos" "" "SAP,Legado"

                nfINFFile = container "Arquivo NF Inf" "Arquivos INF" "arquivo" "Arquivo"
                nfIdtFile = container "Arquivo NF Idt" "Arquivos IDT" "arquivo" "Arquivo"
                nfPdfFile = container "Arquivo NF PDF" "Arquivos PDF" "arquivo" "Arquivo"

              
                leituraColeta = container "Leitura Arquivos Coleta" "" "SAP,Legado"
                geraDT = container "Gera DT" "" "SAP,Legado"

                }
                group "GNFE-NF" {
                    validaNF = container "Valida Nota Fiscal" "" "SAP,Legado"
                    enviaNFDir = container "Envia Nota Fiscal para Diretorio" "" "SAP,Legado"
                    nfDir = container "Diretorio NF" "Diretorio NF" "arquivo" "Arquivo"
                }

                  group "Dados mestres" {
                      materialSAP = container "materialSAP" "Cadastro de materiais no SAP" "SAP,Legado"
                      materialFile = container "materialFile" "Arquivos de materiais extraído do SAP" "arquivo" "arquivo"
                      vendorSAP = container "vendorSAP" "Cadastro de forncedor no SAP" "SAP,Legado"
                }
                group "Entrada de Mercadorias" {

                      egrSAP = container "E-GR" "" "SAP,Legado"
                      pwSAP = container "PW" "" "SAP,Legado"
                      YMMI05 = container "YMMI05" "interface YMMI05" "SAP,Legado"
                      YMME23 = container "YMME23" "interface YMME23" "SAP,Legado"
                      //nfCabFile = container "Arquivo NF Cab" "Arquivos CAB" "arquivo" "arquivo"
                      //nfItmFile = container "Arquivo NF Itm" "Arquivos ITM" "arquivo" "arquivo"
                }
                group "Inventário" {
                    YMM150_22 = container "YMM150_22" "interface YMM150_22" "SAP,Legado"
                    posicaoEstoqueSAP = container "Posição Estoque" "" "SAP,Legado"{
                         qualidadeSAP = component "Qualidade SAP" "" ""
                        livreSAP = component "Livre SAP" "" ""
                        divergenciaSAP = component "Divergência SAP" "" ""
                        avariaSAP = component "Avaria SAP" "" ""
                    }
                }
            }


            
        }

          wms = softwaresystem "WMS" "" "WMS"{
                recebeRemessa = container "Recebe Remessa" "" "" "WMS"
                geraOnda = container "Gera Onda" "" "" "WMS"
                pickingPacking = container "Picking Packing" "" "" "WMS"
                solicitaFaturamento = container "Solicita Faturamento" "" "" "WMS"
                anfFile = container "Arquivo ANF" "Arquivos ANF" "arquivo" "Arquivo,WMS"
                adtFile = container "Arquivo ADT" "Arquivos ADT" "arquivo" "Arquivo,WMS"
                coletaFile = container "Arquivo ***" "Arquivos ***" "arquivo" "Arquivo,WMS"

                despachoMercadoria = container "Despacho Mercadoria" "" "" "WMS"
                enviaColeta = container "Envia Coleta" "" "" "WMS"
                imprimeNf = container "Imprime Nota Fiscal" "" "" "WMS"
                 expedicao = container "Expedição" "" "" "WMS"
                coleta = container "Coleta" "" "" "WMS"

                 group "Dados mestres" {
                materialWMS = container "materialWMS" "" "" "WMS"
                vendorWMS = container "vendorWMS" "" "" "WMS"
            }
            group "Entrada de Mercadorias" {

                recebeMateriaisWMS = container "Recebe Materiais" "" "" "WMS"
                inspecaMateriaisWMS = container "Inspeção materiais" "" "" "WMS"
                estoqueWMS = container "Estoque WMS" "" "" "WMS"{
                    qualidadeWMS = component "Qualidade WMS" "" ""
                    livreWMS = component "Livre WMS" "" ""
                    divergenciaWMS = component "Divergência WMS" "" ""
                    avariaWMS = component "Avaria WMS" "" ""
                }
                movimentaEstoqueWMS = container "Movimenta estoque" "" "" "WMS"
                

                movFile = container "Arquivo MOV" "Arquivos MOV" "arquivo" "Arquivo"
            }
            group "Inventário" {
                inventarioWMS = container "Inventário WMS" "" "" "WMS"{
                    contagemWMS = component "Contagem WMS" "" ""
                    diferencasWMS = component "Diferenças WMS" "" ""
                    baixaitemWMS = component "Baixa Item WMS" "" ""

                }
                invFile = container "Arquivo INV" "Arquivos INV" "arquivo" "Arquivo"

            }
        }
// b2b
        geraPedido -> geraOV "" "Sincrono"
        geraOV -> liberaCredito "" "Sincrono"
        liberaCredito -> alocaRemessa "" "Sincrono"
        alocaRemessa -> enviaRemessa "" "Sincrono"
        enviaRemessa -> nfCabFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        enviaRemessa -> nfItmFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        nfCabFile -> recebeRemessa "Importação de arquivo" "SFTP" "Risco,Assincrono"
        nfItmFile -> recebeRemessa "Importação de arquivo" "SFTP" "Risco,Assincrono"
        recebeRemessa -> geraOnda "" "Sincrono"
        geraOnda  -> pickingPacking "" "Sincrono"
        pickingPacking  -> solicitaFaturamento "" "Sincrono"
        solicitaFaturamento -> anfFile "Importação de arquivo" "SFTP" "Risco,Assincrono"
        solicitaFaturamento -> adtFile "Importação de arquivo" "SFTP" "Risco,Assincrono"
        solicitaFaturamento  ->  despachoMercadoria "" "SAP"
        anfFile -> recebeSolFat "Importação de arquivo" "SFTP" "Risco,Assincrono"
        adtFile -> recebeSolFat "Importação de arquivo" "SFTP" "Risco,Assincrono"
        recebeSolFat -> pickpackSmFat "" "Sincrono"
        pickpackSmFat -> geraNF "" "Sincrono"
        geraNF -> enviaNF  "" "Sincrono"
        geraNF -> validaNF "" "Sincrono"
        enviaNF -> nfPdfFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        nfPdfFile -> imprimeNf "Importação de arquivo" "SFTP" "Risco,Assincrono"
        imprimeNf -> despachoMercadoria "" "Sincrono"
        despachoMercadoria -> enviaColeta "" "Sincrono"
        enviaColeta -> coletaFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        coletaFile -> importaColeta "Importação de arquivo" "SFTP" "Risco,Assincrono"
        importaColeta -> criaDT "" "Sincrono"

        validaNF -> enviaNFDir "Geração de arquivo" "SFTP" "Risco,Assincrono"
        enviaNFDir -> nfDir  "Envio de arquivo" "SFTP" "Risco,Assincrono"


 //b2c

     compraSite -> geraVenda "" "Sincrono"
        geraVenda -> geraOV "" "Sincrono"
        geraOV -> transfMat "" "Sincrono"
        
        transfMat -> alocaMat "" "Sincrono"
        reservaEstoque -> geraNFTransf "" "Sincrono"



        alocaMat -> alocaRuptura "" "Sincrono"
        alocaRuptura -> geraRemessa "" "Sincrono"
        geraRemessa -> geraFatura "" "Sincrono"
        geraFatura -> enviaRemessaNf "" "Sincrono"
        enviaRemessaNf -> montaPacoteArquivos "" "Sincrono"
        geraFatura -> validaNF "" "Sincrono"





        montaPacoteArquivos -> nfINFFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        montaPacoteArquivos -> nfIdtFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        montaPacoteArquivos -> nfPdfFile "Geração de arquivo" "SFTP" "Risco,Assincrono"



        nfINFFile -> expedicao "Importação de arquivo" "SFTP" "Risco,Assincrono"
        nfIdtFile -> expedicao "Importação de arquivo" "SFTP" "Risco,Assincrono"
        nfPdfFile -> expedicao "Importação de arquivo" "SFTP" "Risco,Assincrono"


        expedicao -> coletaFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        coletaFile -> leituraColeta "Importação de arquivo" "SFTP" "Risco,Assincrono"


        expedicao -> coleta "" "Sincrono"
        leituraColeta -> geraDT "" "Sincrono"




        validaNF -> enviaNFDir "Geração de arquivo" "SFTP" "Risco,Assincrono"
        enviaNFDir -> nfDir  "Envio de arquivo" "SFTP" "Risco,Assincrono"  

//material


        materialSAP -> materialFile "Geração de arquivo" "SFTP" "Risco,Assincrono"
        materialFile -> materialWMS "Envio de arquivo" "SFTP" "Risco,Assincrono"
        vendorPerson -> vendorSAP "Le as informacoes de novos fornecedores" "SAP" "Risco,Assincrono"
        vendorPerson -> vendorWMS "Atualiza as informações de fornecedores" "SAP" "Risco,Assincrono"
        nfPerson -> egrSAP "Registro de entrada de NF de mercadoria" "SAP" "Sincrono"
        nfPerson -> pwSAP  "Registro de entrada de NF de mercadoria" "SAP" "Sincrono"
        egrSAP -> YMMI05 "" "SAP" "Sincrono"
        pwSAP -> YMMI05 "" "SAP" "Sincrono"
        YMMI05 -> nfCabFile " Geração de arquivo CAB" "SFTP" "Risco,Assincrono"
        YMMI05 -> nfItmFile " Geração de arquivo ITM" "SFTP" "Risco,Assincrono"
        nfCabFile -> recebeMateriaisWMS "Envio de Arquivo" "SAP" "Risco,Assincrono"
        nfItmFile -> recebeMateriaisWMS "Envio de Arquivo" "SAP" "Risco,Assincrono"
        recebeMateriaisWMS -> inspecaMateriaisWMS "" "SAP" "Sincrono"
        inspecaMateriaisWMS -> qualidadeWMS "" "SAP" "Sincrono"
        inspecaMateriaisWMS -> livreWMS "" "SAP" "Sincrono"
        inspecaMateriaisWMS -> divergenciaWMS "" "SAP" "Sincrono"
        inspecaMateriaisWMS -> avariaWMS "" "SAP" "Sincrono"
        estoqueWMS -> movFile "Geração de arquivo MOV" "SFTP" "Risco,Assincrono"
        movimentaEstoqueWMS -> movFile "Geração de arquivo MOV" "SFTP" "Risco,Assincrono"
        estoqueWMS -> movimentaEstoqueWMS "" "SAP" "Sincrono"
        movFile -> YMME23 "Envio de Arquivo" "SAP" "Risco,Assincrono" 
        inventarioWMS -> invFile "Geração de arquivo INV" "SFTP" "Risco,Assincrono"
        YMM150_22 -> posicaoEstoqueSAP "Processamento de arquivo INV" "SAP" "Risco,Assincrono"
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

        

        
        

        component transfMat "ComponentSAP" {
            include *

            autoLayout
        }


        

        
        component estoqueWMS "ComponentWms" {
            include *

            autoLayout
        }
        
                component inventarioWMS "ComponentSAPMaterial" {
            include *

            autoLayout
        }

       styles {

       }
            themes "https://raw.githubusercontent.com/luizfbicalho/structurizr/master/theme/alpargatas.json"
        
    }
}