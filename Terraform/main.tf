 terraform {
   required_version = ">= 1.3.0"

   required_providers {
     proxmox = {
       source = "telmate/proxmox"
       version = "2.9.11"
     }
   }
 }

 variable "proxmox_url" {
   type = string
 }

 variable "proxmox_token_id" {
   type = string
   sensitive = true
 }

 variable "proxmox_token_secret" {
   type = string
   sensitive = true
 }

 variable "proxmox_clone_name" {
   type = string
 }

 variable "proxmox_clone_id" {
   type = string
 }

 variable "proxmox_worker_mac" {
   type = list(string)
 }

 variable "proxmox_worker_vmid" {
   type = list(string)
 }

 variable "proxmox_worker_ipcfg" {
   type = list(string)
 }