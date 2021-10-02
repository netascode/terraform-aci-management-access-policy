resource "aci_rest" "commPol" {
  dn         = "uni/fabric/comm-${var.name}"
  class_name = "commPol"
  content = {
    name  = var.name
    descr = var.description
  }
}

resource "aci_rest" "commTelnet" {
  dn         = "${aci_rest.commPol.id}/telnet"
  class_name = "commTelnet"
  content = {
    name    = "telnet"
    adminSt = var.telnet_admin_state == true ? "enabled" : "disabled"
    port    = var.telnet_port
  }
}

resource "aci_rest" "commSsh" {
  dn         = "${aci_rest.commPol.id}/ssh"
  class_name = "commSsh"
  content = {
    name         = "ssh"
    adminSt      = var.ssh_admin_state == false ? "disabled" : "enabled"
    passwordAuth = var.ssh_password_auth == false ? "disabled" : "enabled"
    port         = var.ssh_port
    sshCiphers   = join(",", concat(var.ssh_aes128_ctr == true ? ["aes128-ctr"] : [], var.ssh_aes128_gcm == true ? ["aes128-gcm@openssh.com"] : [], var.ssh_aes192_ctr == true ? ["aes192-ctr"] : [], var.ssh_aes256_ctr == true ? ["aes256-ctr"] : [], var.ssh_chacha == true ? ["chacha20-poly1305@openssh.com"] : []))
    sshMacs      = join(",", concat(var.ssh_hmac_sha1 == true ? ["hmac-sha1"] : [], var.ssh_hmac_sha2_256 == true ? ["hmac-sha2-256"] : [], var.ssh_hmac_sha2_512 == true ? ["hmac-sha2-512"] : []))
  }
}

resource "aci_rest" "commHttps" {
  dn         = "${aci_rest.commPol.id}/https"
  class_name = "commHttps"
  content = {
    name                = "https"
    adminSt             = var.https_admin_state == false ? "disabled" : "enabled"
    clientCertAuthState = var.https_client_cert_auth_state == true ? "enabled" : "disabled"
    dhParam             = var.https_dh
    port                = var.https_port
    sslProtocols        = join(",", concat(var.https_tlsv1 == true ? ["TLSv1"] : [], var.https_tlsv1_1 == true ? ["TLSv1.1"] : [], var.https_tlsv1_2 == true ? ["TLSv1.2"] : []))
    visoreAccess        = "enabled"
  }
}

resource "aci_rest" "commRsKeyRing" {
  dn         = "${aci_rest.commHttps.id}/rsKeyRing"
  class_name = "commRsKeyRing"
  content = {
    tnPkiKeyRingName = var.https_keyring != "" ? var.https_keyring : "default"
  }
}

resource "aci_rest" "commHttp" {
  dn         = "${aci_rest.commPol.id}/http"
  class_name = "commHttp"
  content = {
    name         = "http"
    adminSt      = var.http_admin_state == true ? "enabled" : "disabled"
    port         = var.http_port
    visoreAccess = "enabled"
  }
}
