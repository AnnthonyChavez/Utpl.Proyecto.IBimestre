workspace "Sistema de gestión de pedidos - TURCONAGRO" {
    description "Plataforma para gestión de pedidos de insumos agrícolas"

    model {
        cliente = person "Cliente agricultor"
        admin = person "Administrador de pedidos"
        bodega = person "Responsable de bodega"

        sistema = softwareSystem "Sistema de Gestión de Pedidos" {
            tags "SistemaGestion"

            portalCliente = container "Portal del Cliente" {
                tags "AppWeb"
                cliente -> this "Realiza pedidos de insumos"
            }

            portalAdmin = container "Portal de Administración" {
                tags "AppWeb"
                admin -> this "Aprueba y gestiona pedidos"
                bodega -> this "Visualiza pedidos para despacho"
            }

            apiPedidos = container "API de Pedidos" {
                tags "Api"
                portalCliente -> this "Envía pedido"
                portalAdmin -> this "Consulta/Aprueba pedido"
                this -> baseDatos "Consulta y modifica datos"

                componenteAuth = component "Componente de Autenticación" "Permite el acceso seguro de usuarios"
                componenteCorreo = component "Componente de Notificaciones" "Envía correos de confirmación de pedidos"
            }

            baseDatos = container "Base de Datos" {
                tags "Database"
                apiPedidos -> this "CRUD de pedidos, usuarios, stock"
            }
        }
    }

    views {
        systemContext sistema {
            include *
            autolayout lr
        }

        container sistema {
            include *
            autolayout lr
        }

        component apiPedidos "Componentes API" {
            include *
            autolayout lr
        }

        styles {
            element "SistemaGestion" {
                shape RoundedBox
                background #19b92a
                color #000000
            }

            element "AppWeb" {
                shape WebBrowser
                background #f9c846
            }

            element "Api" {
                shape Hexagon
                background #ff8c00
            }

            element "Database" {
                shape Cylinder
                background #b6d7a8
            }
        }

        theme "https://srv-si-001.utpl.edu.ec/REST_PRO_ERP/Recursos/Imagenes/themeAZ_2023.json"
    }
}