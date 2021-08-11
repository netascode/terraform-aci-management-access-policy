terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "MAP1"
  ssh = {
    aes128_gcm = false
    chacha     = false
  }
}

data "aci_rest" "commPol" {
  dn = "uni/fabric/comm-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "commPol" {
  component = "commPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest.commPol.content.name
    want        = module.main.name
  }
}
