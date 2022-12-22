resource "proxmox_vm_qemu" "k3s-master" {
  name = "k3s-master"
  desc = "Kubernetes Master Node"
  vmid = "100"
  target_node = "pve"
  agent = 1
  clone = var.proxmox_clone_name
  cores = 1
  sockets = 2
  memory = 2048

  network {
    bridge = "vmbr0"
    model = "virtio"
    macaddr = "6E:36:14:93:8E:FD"
  }

  disk {
    storage = "local"
    type = "scsi0"
    size = "50G"
    ssd = 1
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.1.150,gw=192.168.1.1"
  nameserver = "192.168.1.1"
  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBPRAVWah7elev/oe+BcdTfeRG0AaYdyr0J5zmsRneKknGRq/tG+Pxq80SaGxeJERbTihQnCLCyyYP+3q8jieri/td9yQEOdlDyWPOlATEv8m3gdJib2oXlGUZCawY5bkY3TH753xTsbDCkLUf2xq8CtGeWpYD3a1zrVQZtmemC1bLzcqtJgXW++h4kV6bWSugn0fUoWi3ASyOt15yItSqBwjpAMoROVW+9AAPPt6lTX+5WU1fXE/GeQ/c9uTssU8x2i1f84wfFUHmnhpuV250DR6PR2R/uE0v8H/MxKDFGuhqaMusjENGxvI8syK7CvWeGY8SxUsHb3qe5jvleZeIVqGWmtolRxV92H9a5jfNbbtY0rIFybGdfKoXKzVmRa8PBYI9f/dBzcDH8VLKWwCOp7K7i36qpVAxU/RqVtdkNmzL55d9ZMLBYfoCloYKoxiaehY8bP4rGHg7+LgUn30IO6zkKLde8yno2e/5pAOLOVK/lEh52h7/pfFfPS8IdLjLwDK1rTwB9ibqyNEJWeWfMCb7lenUAKSlVJgsgu7Rx2OoV6RWtot5ytaxRINWYyTn25EwuoMtonkXIoLb7wAUrIhxu4IE0VJhSeGC1vLKNjEWPVNSpVIX7mMNs1qXt0/TNtZGcxv2hdICow64Oes1Z1W5dMu0h/NpaEIax1hwsQ== toxictoast@ToxicToast
  EOF
}