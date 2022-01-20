workspace "OpenPath 2" {

    model {
        external_hmis = softwareSystem "External HMIS" "A third-party HMIS system"

        enterprise "OpenPath" {
            hmis = softwareSystem "HMIS" "OpenPath HMIS" {
                !include hmis.dsl
            }
            warehouse = softwareSystem "Warehouse" "OpenPath analytic warehouse"
            clearinghouse = softwareSystem "Clearinghouse" "OpenPath warehouse client clearinghouse"

            external_hmis -> hmis "Include third-party client data for case management"
            hmis -> warehouse "Include client data for analysis"
            external_hmis -> warehouse "Include third-party client data for analysis"

            warehouse -> clearinghouse "Identify clients in federated warehouses"
            warehouse -> warehouse "Share clients between federated warehouses"
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

        systemContext warehouse {
            include *
            autoLayout
        }

        systemContext clearinghouse {
            include *
            autoLayout
        }

        theme default
    }
}
