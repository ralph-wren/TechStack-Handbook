# Project Structure & Organization

## Root Directory Layout

```
├── 1.其他                           # Miscellaneous notes and references
├── 2.网络知识.md                    # Network knowledge and protocols
├── 3.clickhouse.md                  # ClickHouse database documentation
├── 4.hadoop.md                     # Hadoop ecosystem guide
├── 5.hive.md                       # Apache Hive data warehouse
├── 6.Java.md                       # Java programming language
├── 7.python.md                     # Python programming guide
├── 8.shell.md                      # Shell scripting reference
├── 9.k8s.md                        # Kubernetes orchestration
├── 10.markdown.md                  # Markdown syntax guide
├── 11.nebula.md                    # Nebula graph database
├── 12.spark.md                     # Apache Spark framework
├── 12.1.spark源码解析.md           # Spark source code analysis
├── 13.html.md                      # HTML/CSS web development
├── 14.iterm2.md                    # Terminal configuration
├── 15.springBoot注解指南.md        # Spring Boot annotations
├── 16.react.md                     # React frontend framework
├── 17.SpringBoot.md                # Spring Boot framework
├── 18.logback.md                   # Logback logging framework
├── 19.git.md                       # Git version control
├── 20.hbase.md                     # HBase NoSQL database
├── 21.flink.md                     # Apache Flink streaming
├── 21.1.flink源码解析.md           # Flink source code analysis
├── 22.redis.md                     # Redis in-memory database
├── 23.mysql.md                     # MySQL relational database
├── 24.算法与数据结构.md            # Algorithms and data structures
├── 25.数据仓库.md                  # Data warehouse concepts
├── 26.kafka.md                     # Apache Kafka messaging
├── 27.大模型技术指南.md            # Large Language Model guide
├── 28.scala.md                     # Scala programming language
├── 29.hudi.md                      # Apache Hudi data lakes
├── 30.软考高级系统架构师（上）.md   # System architect certification (Part 1)
├── 31.软考高级系统架构师（下）.md   # System architect certification (Part 2)
└── assets/                         # Supporting files and images
```

## Configuration Directories

```
├── .git/                           # Git version control metadata
├── .history/                       # File change history tracking
├── .idea/                          # IDE configuration files
├── .kiro/                          # Kiro AI assistant configuration
├── .qoder/                         # Qoder tool configuration
├── .vscode/                        # VS Code editor settings
└── .claude/                        # Claude AI configuration
```

## File Naming Conventions

### Main Documentation Files
- **Pattern**: `{number}.{technology/topic}.md`
- **Language**: Mixed Chinese and English
- **Numbering**: Sequential from 1-31 for main topics
- **Extensions**: Specialized files use `.1` suffix for deep-dive content

### Special Files
- **1.其他**: General notes and miscellaneous information
- **Source Code Analysis**: Files ending with `源码解析.md` for detailed code walkthroughs
- **Certification Materials**: Files with `软考` prefix for professional certification content

## Content Organization Principles

### Hierarchical Structure
- Each file contains comprehensive table of contents with anchor links
- Topics progress from basic concepts to advanced implementations
- Cross-references between related technologies

### Documentation Depth
- **Level 1**: Basic concepts and introduction
- **Level 2**: Practical implementation and examples
- **Level 3**: Advanced features and optimization
- **Level 4**: Source code analysis and internals

### Technology Groupings
- **Big Data Stack**: Files 3-5, 12, 20-26, 29 (ClickHouse, Hadoop, Hive, Spark, HBase, Flink, Redis, MySQL, Kafka, Hudi)
- **Programming Languages**: Files 6-8, 28 (Java, Python, Shell, Scala)
- **Infrastructure**: Files 9, 19 (Kubernetes, Git)
- **Web Development**: Files 13, 16-18 (HTML, React, Spring Boot, Logback)
- **Specialized Topics**: Files 24-27, 30-31 (Algorithms, Data Warehouse, LLM, Certification)

## Asset Management
- Supporting files stored in `assets/` directory
- Images, diagrams, and supplementary materials
- Referenced from main documentation files

## Version Control Strategy
- Extensive history tracking in `.history/` directory
- Timestamped file versions for change tracking
- Git-based version control for collaboration