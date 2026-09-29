# Neo4j 部署 + 图谱复现

## 前置要求

- Docker Desktop
- WSL2（Windows 用户）
- Git

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/你的用户名/hpv-vax-kg.git
cd hpv-vax-kg/neo4j
```

### 2. 启动 Neo4j

```bash
docker-compose up -d
```

### 3. 导入图谱数据

```bash
bash scripts/import_graph.sh
```

### 4. 查看图谱

浏览器打开 <http://localhost:7474。>

- Username: neo4j
- Password: password

登录后，在查询框里输入：

```cypher
MATCH (n)-[r]->(m) RETURN n, r, m LIMIT 100
```

就能看到完整的图谱。

## 日常使用命令

| 操作           | 命令                                                                              |
| ------------ | ------------------------------------------------------------------------------- |
| 启动           | docker-compose up -d                                                            |
| 停止           | docker-compose stop                                                             |
| 查看容器状态       | docker ps                                                                       |
| 重置数据（清空重新导入） | docker-compose down -v && docker-compose up -d && bash scripts/import\_graph.sh |

