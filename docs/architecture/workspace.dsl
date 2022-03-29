workspace "OpenPath 2" {

    model {
        external_hmis = softwareSystem "External HMIS" "A third-party HMIS system"
        external_datasource = softwareSystem "External Datasource" "A third-party source of extended client data (e.g., Healthcare, Storm Mitigation, Youth, VA)"
        external_openpath = softwareSystem "External OpenPath Warehouse Instance"

        enterprise "OpenPath" {
            hmis = softwareSystem "OpenPath HMIS" {
                hmis_server = container "HMIS Server-side"
                ui = container "HMIS UI"
            }
            warehouse = softwareSystem "Warehouse" "OpenPath analytic warehouse" {
                warehouse_database = container "Warehouse Database" {
                    hmis_api = component "Client Data API"
                    workflow_api = component "Workflow API"
                }
            }

            ui -> hmis_api "Care-coordination"
            ui -> workflow_api "More care-coordination"

            hmis -> warehouse "Sends client data (HMIS CSV)"
            hmis -> warehouse "Sends non HMIS-data (API)"
            warehouse -> hmis "Transmits aggregated client data (API)"

            external_hmis -> warehouse "Include third-party client data (HMIS CSV)"
            external_hmis -> warehouse "Sends extended client data (API)"
            external_openpath -> warehouse "Sends client PII"
            
            external_datasource -> warehouse "Sends extended client data (API)"
        }
    }

    views {
        # systemLandscape "OpenPath-2" "The OpenPath 2 System Landscape" {
        #     include *
        #     autoLayout
        # }

        systemContext hmis {
            include *
            autoLayout
        }

        systemContext warehouse {
            include *
            autoLayout
        }

        container warehouse {
            include *
            autoLayout
        }

        container hmis {
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
