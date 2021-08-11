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

  name        = "MAP1"
  description = "My Description"
  telnet = {
    admin_state = true
    port        = 2023
  }
  ssh = {
    admin_state   = true
    password_auth = true
    port          = 2022
    aes128_ctr    = false
    aes128_gcm    = false
    aes192_ctr    = false
    aes256_ctr    = false
    chacha        = false
    hmac_sha1     = false
    hmac_sha2_256 = false
    hmac_sha2_512 = false
  }
  https = {
    admin_state            = true
    client_cert_auth_state = false
    port                   = 2443
    dh                     = 2048
    tlsv1                  = true
    tlsv1_1                = true
    tlsv1_2                = false
    keyring                = "KR1"
  }
  http = {
    admin_state = true
    port        = 2080
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

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.commPol.content.descr
    want        = "My Description"
  }
}

data "aci_rest" "commTelnet" {
  dn = "${data.aci_rest.commPol.id}/telnet"

  depends_on = [module.main]
}

resource "test_assertions" "commTelnet" {
  component = "commTelnet"

  equal "name" {
    description = "name"
    got         = data.aci_rest.commTelnet.content.name
    want        = "telnet"
  }

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.commTelnet.content.adminSt
    want        = "enabled"
  }

  equal "port" {
    description = "port"
    got         = data.aci_rest.commTelnet.content.port
    want        = "2023"
  }
}

data "aci_rest" "commSsh" {
  dn = "${data.aci_rest.commPol.id}/ssh"

  depends_on = [module.main]
}

resource "test_assertions" "commSsh" {
  component = "commSsh"

  equal "name" {
    description = "name"
    got         = data.aci_rest.commSsh.content.name
    want        = "ssh"
  }

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.commSsh.content.adminSt
    want        = "enabled"
  }

  equal "passwordAuth" {
    description = "passwordAuth"
    got         = data.aci_rest.commSsh.content.passwordAuth
    want        = "enabled"
  }

  equal "port" {
    description = "port"
    got         = data.aci_rest.commSsh.content.port
    want        = "2022"
  }

  equal "sshCiphers" {
    description = "sshCiphers"
    got         = data.aci_rest.commSsh.content.sshCiphers
    want        = ""
  }

  equal "sshMacs" {
    description = "sshMacs"
    got         = data.aci_rest.commSsh.content.sshMacs
    want        = ""
  }
}

data "aci_rest" "commHttps" {
  dn = "${data.aci_rest.commPol.id}/https"

  depends_on = [module.main]
}

resource "test_assertions" "commHttps" {
  component = "commHttps"

  equal "name" {
    description = "name"
    got         = data.aci_rest.commHttps.content.name
    want        = "https"
  }

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.commHttps.content.adminSt
    want        = "enabled"
  }

  equal "clientCertAuthState" {
    description = "clientCertAuthState"
    got         = data.aci_rest.commHttps.content.clientCertAuthState
    want        = "disabled"
  }

  equal "dhParam" {
    description = "dhParam"
    got         = data.aci_rest.commHttps.content.dhParam
    want        = "2048"
  }

  equal "port" {
    description = "port"
    got         = data.aci_rest.commHttps.content.port
    want        = "2443"
  }

  equal "sslProtocols" {
    description = "sslProtocols"
    got         = data.aci_rest.commHttps.content.sslProtocols
    want        = "TLSv1,TLSv1.1"
  }

  equal "visoreAccess" {
    description = "visoreAccess"
    got         = data.aci_rest.commHttps.content.visoreAccess
    want        = "enabled"
  }
}

data "aci_rest" "commRsKeyRing" {
  dn = "${data.aci_rest.commHttps.id}/rsKeyRing"

  depends_on = [module.main]
}

resource "test_assertions" "commRsKeyRing" {
  component = "commRsKeyRing"

  equal "tnPkiKeyRingName" {
    description = "tnPkiKeyRingName"
    got         = data.aci_rest.commRsKeyRing.content.tnPkiKeyRingName
    want        = "KR1"
  }
}

data "aci_rest" "commHttp" {
  dn = "${data.aci_rest.commPol.id}/http"

  depends_on = [module.main]
}

resource "test_assertions" "commHttp" {
  component = "commHttp"

  equal "name" {
    description = "name"
    got         = data.aci_rest.commHttp.content.name
    want        = "http"
  }

  equal "adminSt" {
    description = "adminSt"
    got         = data.aci_rest.commHttp.content.adminSt
    want        = "enabled"
  }

  equal "port" {
    description = "port"
    got         = data.aci_rest.commHttp.content.port
    want        = "2080"
  }

  equal "visoreAccess" {
    description = "visoreAccess"
    got         = data.aci_rest.commHttp.content.visoreAccess
    want        = "enabled"
  }
}
