workspace "Entrada Mercadoria" "Processo de entrada de mercadoria" {
    model {
    vendorPerson = person "Operador SAP Vendor" "Usuário que faz a integração dos fornecedores" "Person"
    nfPerson = person "Operador SAP NF" "Usuário que faz a integração das notas fiscais de entrada de mercadoria" "Person"
        enterprise "Alpargatas"{
            
             
            sap = softwaresystem "SAP" "" "Existing System"{
                group "Dados mestres" {
                      materialSAP = container "materialSAP" "Cadastro de materiais no SAP" "SAP RFC"
                      materialFile = container "materialFile" "Arquivos de materiais extraído do SAP" "arquivo" "arquivo"
                      vendorSAP = container "vendorSAP" "Cadastro de forncedor no SAP" "SAP RFC"
                }
                group "Entrada de Mercadorias" {

                      egrSAP = container "E-GR" "" "SAP RFC"
                      pwSAP = container "PW" "" "SAP RFC"
                      YMMI05 = container "YMMI05" "interface YMMI05" "SAP RFC"
                      YMME23 = container "YMME23" "interface YMME23" "SAP RFC"
                      nfCabFile = container "Arquivo NF Cab" "Arquivos CAB" "arquivo" "arquivo"
                      nfItmFile = container "Arquivo NF Itm" "Arquivos ITM" "arquivo" "arquivo"
                }
                group "Inventário" {
                    YMM150_22 = container "YMM150_22" "interface YMM150_22" "SAP RFC"
                    posicaoEstoqueSAP = container "Posição Estoque" "" "SAP RFC"{
                         qualidadeSAP = component "Qualidade SAP" "" ""
                        livreSAP = component "Livre SAP" "" ""
                        divergenciaSAP = component "Divergência SAP" "" ""
                        avariaSAP = component "Avaria SAP" "" ""
                    }
                }
            }
            
        }
        

        wms = softwaresystem "WMS" "" "Existing System"{
            group "Dados mestres" {
                materialWMS = container "materialWMS" "" "SAP RFC"
                vendorWMS = container "vendorWMS" "" "SAP RFC"
            }
            group "Entrada de Mercadorias" {

                recebeMateriaisWMS = container "Recebe Materiais" "" "SAP RFC"
                inspecaMateriaisWMS = container "Inspeção materiais" "" "SAP RFC"
                estoqueWMS = container "Estoque WMS" "" "SAP RFC"{
                    qualidadeWMS = component "Qualidade WMS" "" ""
                    livreWMS = component "Livre WMS" "" ""
                    divergenciaWMS = component "Divergência WMS" "" ""
                    avariaWMS = component "Avaria WMS" "" ""
                }
                movimentaEstoqueWMS = container "Movimenta estoque" "" "SAP RFC"
                

                movFile = container "Arquivo MOV" "Arquivos MOV" "arquivo" "arquivo"
            }
            group "Inventário" {
                inventarioWMS = container "Inventário WMS" "" "SAP RFC"{
                    contagemWMS = component "Contagem WMS" "" ""
                    diferencasWMS = component "Diferenças WMS" "" ""
                    baixaitemWMS = component "Baixa Item WMS" "" ""

                }
                invFile = container "Arquivo INV" "Arquivos INV" "arquivo" "arquivo"

            }
        }
        
        materialSAP -> materialFile "Geração de arquivo" "SFTP" "Risk"
        materialFile -> materialWMS "Envio de arquivo" "SFTP" "Risk"
        vendorPerson -> vendorSAP "Le as informacoes de novos fornecedores" "SAP" "Risk"
        vendorPerson -> vendorWMS "Atualiza as informações de fornecedores" "SAP" "Risk"
        nfPerson -> egrSAP "Registro de entrada de NF de mercadoria" "SAP"
        nfPerson -> pwSAP  "Registro de entrada de NF de mercadoria" "SAP"
        egrSAP -> YMMI05 "" "SAP"
        pwSAP -> YMMI05 "" "SAP"
        YMMI05 -> nfCabFile " Geração de arquivo CAB" "SFTP" "Risk"
        YMMI05 -> nfItmFile " Geração de arquivo ITM" "SFTP" "Risk"
        nfCabFile -> recebeMateriaisWMS "Envio de Arquivo" "SAP" "Risk"
        nfItmFile -> recebeMateriaisWMS "Envio de Arquivo" "SAP" "Risk"
        recebeMateriaisWMS -> inspecaMateriaisWMS "" "SAP"
        inspecaMateriaisWMS -> qualidadeWMS "" "SAP"
        inspecaMateriaisWMS -> livreWMS "" "SAP"
        inspecaMateriaisWMS -> divergenciaWMS "" "SAP"
        inspecaMateriaisWMS -> avariaWMS "" "SAP"
        estoqueWMS -> movFile "Geração de arquivo MOV" "SFTP" "Risk"
        movimentaEstoqueWMS -> movFile "Geração de arquivo MOV" "SFTP" "Risk"
        estoqueWMS -> movimentaEstoqueWMS "" "SAP"
        movFile -> YMME23 "Envio de Arquivo" "SAP" "Risk" 
        inventarioWMS -> invFile "Geração de arquivo INV" "SFTP" "Risk"
        YMM150_22 -> posicaoEstoqueSAP "Processamento de arquivo INV" "SAP" "Risk"
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
        
        component estoqueWMS "ComponentWms" {
            include *

            autoLayout
        }
        
                component inventarioWMS "ComponentSAP" {
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
            /*element "Customer" {
                background #08427b
            }
            element "Bank Staff" {
                background #999999
            }*/
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
            /*element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }*/
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
                
                color #FF0000
                colour #FF0000
                dashed false

            }
        }
            themes "https://raw.githubusercontent.com/luizfbicalho/structurizr/master/theme/alpargatas.json"

    }
}