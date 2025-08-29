# TechStack-Handbook

> 个人技术知识库 | Personal Technical Knowledge Base

一个涵盖现代软件工程技术栈的综合性文档库，旨在为工作中的技术问题提供快速参考和深度指南。

## 📚 项目简介

这是一个持续更新的技术文档集合，包含了从基础概念到高级实现的全方位技术指南。无论你是在寻找快速解决方案，还是需要深入理解某项技术，这里都能找到你需要的答案。

### 🎯 定位
- **技术指南** - 系统性的学习路径和最佳实践
- **个人词典** - 技术术语和概念的快速查阅
- **知识库** - 深度技术文档和实战经验
- **速查手册** - 常用命令和配置的即时参考

## 🗂️ 文档结构

### 大数据生态系统
- [ClickHouse](3.clickhouse.md) - 列式数据库查询优化与存储引擎
- [Hadoop](4.hadoop.md) - 分布式存储与计算框架
- [Hive](5.hive.md) - 数据仓库与SQL-on-Hadoop
- [Spark](12.spark.md) + [源码解析](12.1.spark源码解析.md) - 大数据处理引擎
- [HBase](20.hbase.md) - NoSQL分布式数据库
- [Flink](21.flink.md) + [源码解析](21.1.flink源码解析.md) - 流处理框架
- [Kafka](26.kafka.md) - 分布式消息流平台
- [Hudi](29.hudi.md) - 数据湖存储框架

### 编程语言
- [Java](6.Java.md) - 企业级开发语言
- [Python](7.python.md) - 数据科学与自动化
- [Scala](28.scala.md) - 函数式编程与大数据
- [Shell](8.shell.md) - 系统管理与自动化脚本

### 基础设施与运维
- [Kubernetes](9.k8s.md) - 容器编排平台
- [Git](19.git.md) - 版本控制系统
- [网络知识](2.网络知识.md) - 网络协议与架构

### Web开发框架
- [Spring Boot](17.SpringBoot.md) + [注解指南](15.springBoot注解指南.md) - Java Web框架
- [React](16.react.md) - 前端开发框架
- [HTML/CSS](13.html.md) - Web前端基础

### 数据存储
- [Redis](22.redis.md) - 内存数据库
- [MySQL](23.mysql.md) - 关系型数据库
- [Nebula](11.nebula.md) - 图数据库

### 专业领域
- [算法与数据结构](24.算法与数据结构.md) - 计算机科学基础
- [数据仓库](25.数据仓库.md) - 数据架构设计
- [大模型技术指南](27.大模型技术指南.md) - AI/ML前沿技术
- [系统架构师认证](30.软考高级系统架构师（上）.md) - 专业认证指南

### 工具与配置
- [Markdown](10.markdown.md) - 文档编写语法
- [iTerm2](14.iterm2.md) - 终端工具配置
- [Logback](18.logback.md) - 日志框架

## 🚀 快速开始

### 浏览文档
```bash
# 查看所有文档列表
ls *.md

# 搜索特定技术
grep -r "关键词" *.md

# 查看文档目录结构
find . -name "*.md" | sort
```

### 文档导航
每个文档都包含详细的目录结构，支持快速跳转：
- 使用 `Ctrl+F` 搜索特定内容
- 点击目录链接快速定位
- 利用锚点链接在章节间跳转

## 📖 使用指南

### 学习路径建议
1. **新手入门**: 从基础语言开始 (Java/Python → Shell → Git)
2. **大数据方向**: Hadoop → Spark → Flink → Kafka → ClickHouse
3. **Web开发**: HTML → React → Spring Boot
4. **运维方向**: Shell → K8s → 网络知识

### 最佳实践
- 结合实际项目需求选择相关文档
- 理论学习与实践操作并重
- 定期回顾和更新知识点
- 建立自己的学习笔记体系

## 🔄 更新计划

### 即将添加的内容
- [ ] Docker 容器化技术
- [ ] Elasticsearch 搜索引擎
- [ ] MongoDB 文档数据库
- [ ] Nginx 反向代理
- [ ] Jenkins CI/CD
- [ ] AWS/阿里云服务

### 持续优化
- 定期更新技术版本信息
- 补充实战案例和最佳实践
- 优化文档结构和导航
- 增加图表和示例代码

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来完善这个知识库：

1. **内容建议**: 提出需要补充的技术领域
2. **错误修正**: 指出文档中的错误或过时信息
3. **经验分享**: 贡献实战经验和最佳实践
4. **结构优化**: 建议更好的文档组织方式

## 📄 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE) 文件。

## 📞 联系方式

如有问题或建议，欢迎通过以下方式联系：
- 提交 GitHub Issue
- 发起 Pull Request
- 邮件联系（请在 Issue 中留言）

---

**持续学习，持续进步** 🚀

> 最后更新: 2025年8月