resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "properties" = {
            "contactId" = {
                "type" = "string"
            },
            "contactListId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "description" = "Returns Contact List Entry",
        "properties" = {
            "data.CustomerName" = {
                "description" = "Example contact column",
                "title" = "Customer Name",
                "type" = "string"
            }
        },
        "title" = "Get Info from Contact List",
        "type" = "object"
    })
    
    config_request {
        request_template     = ""
        request_type         = "GET"
        request_url_template = "/api/v2/outbound/contactlists/$${input.contactlistId}/contacts/$${input.contactId}"
        headers = {
			Content-Type = "application/json"
		}
    }

    config_response {
        success_template = "$${rawResult}"
    }
}