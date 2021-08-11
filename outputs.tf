output "dn" {
  value       = aci_rest.commPol.id
  description = "Distinguished name of `commPol` object."
}

output "name" {
  value       = aci_rest.commPol.content.name
  description = "Management access policy name."
}
