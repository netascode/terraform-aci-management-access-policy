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
    adminSt = var.telnet.admin_state == true ? "enabled" : "disabled"
    port    = var.telnet.port != null ? var.telnet.port : 23
  }
}

resource "aci_rest" "commSsh" {
  dn         = "${aci_rest.commPol.id}/ssh"
  class_name = "commSsh"
  content = {
    name         = "ssh"
    adminSt      = var.ssh.admin_state == false ? "disabled" : "enabled"
    passwordAuth = var.ssh.password_auth == false ? "disabled" : "enabled"
    port         = var.ssh.port != null ? var.ssh.port : 22
    sshCiphers   = join(",", concat(var.ssh.aes128_ctr != false ? ["aes128-ctr"] : [], var.ssh.aes128_gcm != false ? ["aes128-gcm@openssh.com"] : [], var.ssh.aes192_ctr != false ? ["aes192-ctr"] : [], var.ssh.aes256_ctr != false ? ["aes256-ctr"] : [], var.ssh.chacha != false ? ["chacha20-poly1305@openssh.com"] : []))
    sshMacs      = join(",", concat(var.ssh.hmac_sha1 != false ? ["hmac-sha1"] : [], var.ssh.hmac_sha2_256 != false ? ["hmac-sha2-256"] : [], var.ssh.hmac_sha2_512 != false ? ["hmac-sha2-512"] : []))
  }
}

resource "aci_rest" "commHttps" {
  dn         = "${aci_rest.commPol.id}/https"
  class_name = "commHttps"
  content = {
    name                = "https"
    adminSt             = var.https.admin_state == false ? "disabled" : "enabled"
    clientCertAuthState = var.https.client_cert_auth_state == true ? "enabled" : "disabled"
    dhParam             = var.https.dh != null ? var.https.dh : "none"
    port                = var.https.port != null ? var.https.port : 443
    sslProtocols        = join(",", concat(var.https.tlsv1 == true ? ["TLSv1"] : [], var.https.tlsv1_1 != false ? ["TLSv1.1"] : [], var.https.tlsv1_2 != false ? ["TLSv1.2"] : []))
    visoreAccess        = "enabled"
  }
}

resource "aci_rest" "commRsKeyRing" {
  dn         = "${aci_rest.commHttps.id}/rsKeyRing"
  class_name = "commRsKeyRing"
  content = {
    tnPkiKeyRingName = var.https.keyring != null ? var.https.keyring : "default"
  }
}

resource "aci_rest" "commHttp" {
  dn         = "${aci_rest.commPol.id}/http"
  class_name = "commHttp"
  content = {
    name         = "http"
    adminSt      = var.http.admin_state == true ? "enabled" : "disabled"
    port         = var.http.port != null ? var.http.port : 80
    visoreAccess = "enabled"
  }
}
