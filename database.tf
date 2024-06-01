# resource "aws_db_parameter_group" "default" {
#   name   = "default"
#   family = "mysql8.0"

#   parameter {
#     name  = "character_set_database"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
# }

# resource "aws_db_option_group" "default" {
#   name                 = "default"
#   engine_name          = "mysql"
#   major_engine_version = "8.0"
#   option {
#     option_name = "MARIADB_AUDIT_PLUGIN"
#   }
# }

# resource "aws_db_subnet_group" "default" {
#   name       = "example"
#   subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
# }

# resource "aws_db_instance" "default" {
#   identifier                 = "default"
#   engine                     = "mysql"
#   engine_version             = "8.0"
#   instance_class             = "db.t3.small"
#   allocated_storage          = 20
#   max_allocated_storage      = 100
#   storage_type               = "gp2"
#   storage_encrypted          = true
#   kms_key_id                 = aws_kms_key.default.arn
#   username                   = "root"
#   password                   = "password"
#   multi_az                   = true
#   publicly_accessible        = false
#   backup_window              = "09:10-09:40"
#   backup_retention_period    = 30
#   maintenance_window         = "mon:10:10-mon:10:40"
#   auto_minor_version_upgrade = false
#   deletion_protection        = false
#   skip_final_snapshot        = true
#   port                       = 3306
#   apply_immediately          = false
#   vpc_security_group_ids     = [module.mysql_sg.security_group_id]
#   parameter_group_name       = aws_db_parameter_group.default.name
#   option_group_name          = aws_db_option_group.default.name
#   db_subnet_group_name       = aws_db_subnet_group.default.name

#   lifecycle {
#     ignore_changes = [password]
#   }
# }

# module "mysql_sg" {
#   source      = "./security_group"
#   name        = "mysql-sg"
#   vpc_id      = aws_vpc.default.id
#   port        = 3306
#   cidr_blocks = [aws_vpc.default.cidr_block]
# }

# resource "aws_elasticache_parameter_group" "default" {
#   name   = "example"
#   family = "redis5.0"
#   parameter {
#     name  = "cluster-enabled"
#     value = "no"
#   }
# }

# resource "aws_elasticache_subnet_group" "default" {
#   name       = "example"
#   subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
# }

# resource "aws_elasticache_replication_group" "default" {
#   replication_group_id       = "example"
#   description                = "Cluster Disabled"
#   engine                     = "redis"
#   engine_version             = "5.0.4"
#   num_cache_clusters         = 3
#   node_type                  = "cache.t3.micro"
#   snapshot_window            = "09:10-10:10"
#   snapshot_retention_limit   = 7
#   maintenance_window         = "mon:10:40-mon:11:40"
#   automatic_failover_enabled = true
#   port                       = 6379
#   apply_immediately          = false
#   security_group_ids         = [module.redis_sg.security_group_id]
#   parameter_group_name       = aws_elasticache_parameter_group.default.name
#   subnet_group_name          = aws_elasticache_subnet_group.default.name
# }

# module "redis_sg" {
#   source      = "./security_group"
#   name        = "redis-sg"
#   vpc_id      = aws_vpc.default.id
#   port        = 6379
#   cidr_blocks = [aws_vpc.default.cidr_block]
# }
