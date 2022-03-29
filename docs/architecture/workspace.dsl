workspace "OpenPath 2" {

    model {
        external_hmis = softwareSystem "External HMIS" "A third-party HMIS system"
        external_datasource = softwareSystem "External Datasource" "A third-party source of extended client data (e.g., Healthcare, Storm Mitigation, Youth, VA)"
        external_openpath = softwareSystem "External OpenPath Warehouse Instance"

        enterprise "OpenPath" {
            hmis = softwareSystem "OpenPath HMIS" {
                ui = container "HMIS UI" {
                    react_app = component "React App"
                }
            }
            warehouse = softwareSystem "Warehouse" "OpenPath analytic warehouse" {
                warehouse_database = container "Warehouse Database" {
                    hmis_api = component "HMIS Client Data API"
                    workflow_api = component "Workflow API"
                    aggregated_client_api = component "Agreggated Client Data API"
                    access_control_api = component "Access Control API"
                }
            }

            workflow_api -> react_app "Provides workflow information"

            hmis -> warehouse "Sends client data" "HMIS CSV"
            hmis -> warehouse "Sends non HMIS-data" "GraphQL"
            warehouse -> hmis "Sends client data" "GraphQL"

            aggregated_client_api -> ui "Provides Agreggated Client Data" "GraphQL"
            react_app -> hmis_api "Consumes HMIS Client Data" "GraphQL"
            react_app -> access_control_api "Obey Access Controls" "GraphQL"
            hmis_api -> react_app "Provides HMIS Client Data" "GraphQL"

            external_hmis -> warehouse "Include third-party client data" "HMIS CSV"
            external_hmis -> warehouse "Sends extended client data" "GraphQL"
            external_openpath -> warehouse "Sends client PII"

            external_datasource -> warehouse "Sends extended client data" "API"
        }
    }

    views {
        systemLandscape "OpenPath-2" "The OpenPath 2 System Landscape" {
            include *
            autoLayout
        }

        systemContext hmis {
            include *
            autoLayout
        }

        // systemContext warehouse {
        //     include *
        //     autoLayout
        // }

        container warehouse {
            include *
            autoLayout
        }

        container hmis {
            include *
            autoLayout
        }

        component ui {
            include *
            autoLayout
        }

        component warehouse_database {
            include *
            autoLayout
        }

        theme default
    }
}
