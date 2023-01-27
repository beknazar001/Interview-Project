/******************************************
  Create Container Cluster node pools
 *****************************************/

resource "google_container_node_pool" "current" {
  for_each           = var.node_pools
  project            = var.project_id
  cluster            = google_container_cluster.gke.id
  name               = each.key
  location           = google_container_cluster.gke.location
  node_locations     = lookup(each.value, "node_locations", null)
  initial_node_count = lookup(each.value, "initial_node_count", 1)

  dynamic "autoscaling" {
    for_each = lookup(each.value, "autoscaling", true) ? [each.value] : []
    content {
      min_node_count = lookup(autoscaling.value, "min_count", 1)
      max_node_count = lookup(autoscaling.value, "max_count", 10)
    }
  }

  upgrade_settings {
    max_surge       = lookup(each.value, "max_surge", 1)
    max_unavailable = lookup(each.value, "max_unavailable", 0)
  }

  management {
    auto_repair  = lookup(each.value, "auto_repair", true)
    auto_upgrade = lookup(each.value, "auto_upgrade", false)
  }

  node_config {
    local_ssd_count  = lookup(each.value, "local_ssd_count", 0)
    disk_size_gb     = lookup(each.value, "disk_size_gb", 100)
    disk_type        = lookup(each.value, "disk_type", "pd-standard")
    min_cpu_platform = lookup(each.value, "min_cpu_platform", "")
    image_type       = lookup(each.value, "image_type", "COS_CONTAINERD")
    machine_type     = lookup(each.value, "machine_type", "e2-medium")
    preemptible      = lookup(each.value, "preemptible", false)
    # spot             = lookup(each.value, "spot", false)
    shielded_instance_config {
      enable_secure_boot          = lookup(each.value, "enable_secure_boot", false)
      enable_integrity_monitoring = lookup(each.value, "enable_integrity_monitoring", true)
    }
  }
  lifecycle {
    ignore_changes = [initial_node_count]
  }
}
