module "aci_management_access_policy" {
  source = "netascode/management-access-policy/aci"

  name                         = "MAP1"
  description                  = "My Description"
  telnet_admin_state           = true
  telnet_port                  = 2023
  ssh_admin_state              = true
  ssh_password_auth            = true
  ssh_port                     = 2022
  ssh_aes128_ctr               = false
  ssh_aes128_gcm               = false
  ssh_aes192_ctr               = false
  ssh_aes256_ctr               = false
  ssh_chacha                   = false
  ssh_hmac_sha1                = false
  ssh_hmac_sha2_256            = false
  ssh_hmac_sha2_512            = false
  https_admin_state            = true
  https_client_cert_auth_state = false
  https_port                   = 2443
  https_dh                     = 2048
  https_tlsv1                  = true
  https_tlsv1_1                = true
  https_tlsv1_2                = false
  https_keyring                = "KR1"
  http_admin_state             = true
  http_port                    = 2080
}
