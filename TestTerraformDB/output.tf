output "cluster_endpoint" {
  value = aws_docdb_cluster.test_cluster.endpoint
}

output "cluster_reader_endpoint" {
  value = aws_docdb_cluster.test_cluster.reader_endpoint
}