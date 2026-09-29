# llm-graph-builder 使用（可选）

这一步完成后，你可以用自然语言对图谱提问，或者继续上传文件补充图谱。

## 前置要求

- 已完成 [Neo4j 部署 + 图谱复现](../part1-neo4j/README.md)
- DeepSeek API Key（LLM）
- 阿里云百炼 API Key（Embedding）

## 快速开始

### 1. 克隆 llm-graph-builder

在 `llm-graph-builder/` 目录下执行：

```bash
git clone https://github.com/neo4j-labs/llm-graph-builder.git
```

### 2. 配置环境变量

```bash
cp .env.example llm-graph-builder/backend/.env
```

编辑 llm-graph-builder/backend/.env，填入你的 DeepSeek 和百炼密钥。

### 3. 解决构建时的网络问题

如果你的网络无法直连 Hugging Face 和 NLTK，需要提前下载好再 COPY 进镜像。

#### 3.1 下载 Hugging Face 模型

```bash
cd llm-graph-builder/backend

export HF_ENDPOINT=https://hf-mirror.com

python -c "
from transformers import AutoTokenizer, AutoModel
name = 'sentence-transformers/all-MiniLM-L6-v2'
tok = AutoTokenizer.from_pretrained(name)
mod = AutoModel.from_pretrained(name)
tok.save_pretrained('./local_model')
mod.save_pretrained('./local_model')
"
```

#### 3.2 下载 NLTK 数据

```bash
python -c "import nltk; nltk.download('punkt'); nltk.download('averaged_perceptron_tagger')"
cp -r ~/nltk_data ./nltk_data
```

#### 3.3 修改 backend/Dockerfile

把在线下载命令替换为 COPY：

```dockerfile
COPY local_model ./local_model
COPY nltk_data /usr/local/nltk_data
```

### 4. 构建并启动

```bash
cd ..
docker-compose up -d
```

### 5. 访问网页

浏览器打开 <http://localhost:8080。>

连接 Neo4j：

- URI: bolt://neo4j:7687
- Username: neo4j
- Password: password

### 6. 使用

- 上传文件构建图谱：左侧面板选择数据源，上传文件，选择 DeepSeek 模型，点击 "Generate Graph"
- 与图谱对话：在聊天框里用自然语言提问

## 日常使用命令

| 操作     | 命令                             |
| ------ | ------------------------------ |
| 启动     | docker-compose up -d           |
| 停止     | docker-compose stop            |
| 看日志    | docker-compose logs -f backend |
| 改代码后重建 | docker-compose up -d --build   |

