# Technology Stack & Build System

## Documentation Format
- **Primary Format**: Markdown (.md files)
- **Language**: Mixed Chinese and English content
- **Structure**: Hierarchical with detailed table of contents

## File Organization
- Numbered files (1-31) for main technical topics
- Descriptive naming convention: `{number}.{technology}.md`
- Comprehensive coverage from basic concepts to advanced implementations

## Key Technologies Documented

### Big Data & Analytics
- **Apache Spark**: Core concepts, RDD operations, DataFrame/Dataset APIs, source code analysis
- **Apache Flink**: Stream processing, DataStream API, architecture patterns
- **Apache Kafka**: Message streaming, distributed architecture, performance tuning
- **ClickHouse**: Columnar database, query optimization, storage engines
- **Hadoop Ecosystem**: HDFS, MapReduce, cluster management
- **HBase**: NoSQL database operations, schema design
- **Apache Hive**: Data warehousing, SQL-on-Hadoop

### Programming Languages
- **Java**: Advanced features, JVM internals, concurrency, design patterns
- **Python**: Language fundamentals, libraries, best practices
- **Scala**: Functional programming, type system, Spark integration
- **Shell Scripting**: System administration, text processing, automation

### Infrastructure & DevOps
- **Kubernetes**: Container orchestration, deployment patterns
- **Git**: Version control workflows, branching strategies
- **Docker**: Containerization (referenced in context)

### Development Tools
- **Markdown**: Documentation standards and syntax
- **HTML/CSS**: Web development basics
- **React**: Frontend framework patterns
- **Spring Boot**: Java application framework, annotations

## Documentation Standards
- Use detailed table of contents with anchor links
- Include practical examples and code snippets
- Provide both theoretical concepts and implementation details
- Maintain consistent formatting across all documents
- Use Chinese for main content with English technical terms

## Common Commands & Operations
Since this is a documentation repository, common operations include:

```bash
# View documentation
cat {number}.{technology}.md
grep -r "keyword" *.md

# Search specific topics
find . -name "*.md" -exec grep -l "search_term" {} \;

# Navigate file structure
ls -la *.md
```

## Version Control
- Git-based version control with extensive history tracking
- Files stored in `.history/` directory for change tracking
- Regular updates and revisions to technical content