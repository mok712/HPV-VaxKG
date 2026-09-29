#!/bin/bash
# 导入图谱数据

NEO4J_CONTAINER="neo4j"
NEO4J_USER="neo4j"
NEO4J_PASSWORD="${NEO4J_PASSWORD:-password}"
IMPORT_FILE="hpv_vax_kg.cypher"

echo "正在导入图谱数据..."

docker exec -it $NEO4J_CONTAINER cypher-shell -u $NEO4J_USER -p $NEO4J_PASSWORD \
  -f /var/lib/neo4j/import/$IMPORT_FILE

echo "导入完成！"