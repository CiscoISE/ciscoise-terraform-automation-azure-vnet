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

# Azure Vnet Setup related variables:
ise_func_subnet = "ise_func_subnet"
ise_func_subnet_cidr = [
  "10.0.14.0/26"
]
ise_resource_group = "Cisco_ISE_RG"
location           = "East US"

# Enter the Subnet CIDR for Private Subnets 
private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
  "10.0.13.0/24"
]

# Enter the Subnet CIDR for Public Subnets 
public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

# Enter the subscription and Network variables
subscription = "a8b4411b-d161-41bf-82f5-7d80b0f9aa35"
vnet_address = "10.0.0.0/16"
vnet_name    = "ise_vnet"
