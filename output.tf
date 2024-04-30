# Copyright 2024 Cisco Systems, Inc. and its affiliates
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

output "resource_group" {
  value = module.vnet.resource_group
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "ise_lb_subnet_name" {
  value = module.vnet.ise_lb_subnet_name
}

output "ise_vm_subnet_name" {
  value = module.vnet.ise_vm_subnet_name
}

# output "ise_func_subnet_name" {
#   value = module.vnet.ise_func_subnet_name
# }

output "public_subnet_ids" {
  value = module.vnet.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vnet.private_subnet_ids
}

output "public_nsg_ids" {
  value = module.vnet.public_nsg_ids
}

output "private_nsg_ids" {
  value = module.vnet.private_nsg_ids
}

output "public_ip_ids" {
  value = module.vnet.public_ip_ids
}


output "ise_func_subnet" {
  value = module.vnet.ise_func_subnet
}