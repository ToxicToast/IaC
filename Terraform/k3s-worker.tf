resource "proxmox_vm_qemu" "k3s-worker" {
  count = 1
  name = "k3s-worker-${count.index}"
  desc = "Kubernetes Worker Node"
  vmid = var.proxmox_worker_vmid[count.index]
  target_node = "pve"
  agent = 1
  clone = var.proxmox_clone_name
  cores = 1
  sockets = 2
  memory = 2048

  network {
    bridge = "vmbr0"
    model = "virtio"
    macaddr = var.proxmox_worker_mac[count.index]
  }

  disk {
    storage = "local"
    type = "scsi0"
    size = "32G"
  }

  os_type = "cloud-init"
  ipconfig0 = var.proxmox_worker_ipcfg[count.index]
  nameserver = "192.168.1.1"
}