-- bitmap or and 操作，求大小

select code,bitmapCardinality(groupBitmapOrState(gid_index_bitmap)) num
from  glab_gid_info.region_appear_ids_local where startsWith(code,'310') and day>=20250101 
group by code
order by num desc;

-- 将bitmap转数组,获取前几位
select arraySlice(bitmapToArray(gid_index_bitmap),1,3),bitmap_segment_number,gid_index_bitmap_cardinality,ts 
  from tag_bitmap where tag_md5=lower(hex(MD5('g30126')));

-- 导出查询结果到hdfs
hadoop fs -mkdir -p hdfs://gt-ga-xs/tmp/data/ck/rename/result.parquet
hadoop fs -chmod -R 777 hdfs://gt-ga-xs/tmp/data/ck/rename/result.parquet
INSERT INTO FUNCTION hdfs('hdfs://gt-ga-xs/tmp/data/ck/rename/result.parquet', 'Parquet')
SELECT * FROM glab_gid_info.appinfo_v2 where all_sen_category_name='vpn';

insert into glab_gid_info.appinfo_v2 select * from hdfs('','Parquet');

-- index和gid互转
select * from glab_gid_info.gid2index where gid='';
select * from glab_gid_info.index2gid where gid_index='25660327541';


-- 查询app安装gid
select tag, bitmapToArray(gid_index_bitmap)[1] from   
glab_gid_info.app_bitmap where tag_md5=lower(hex(MD5('im.xzjkrhrftd.messenger'))) \G;


-- 行转列
select arrayJoin(gid_index) gid_index from 
  (select arraySlice(bitmapToArray(gid_index_bitmap),1,30)  gid_index
    from tag_bitmap where tag_md5=lower(hex(MD5('g30126'))) 
      and bitmap_segment_number=15) t1;

-- 将一个字段转为数组
select groupArray(tagid) from app_tagid_category where startsWith(tagid,'XZ');

-- 数组合并arrayConcat  数组去重 arrayDistinct
select duplication_flag,geo6s,geo5s,geo4s from (select geohash,geo_list,arrayDistinct(arrayMap(x->substr(x,1,6),arrayConcat([geohash],arrayMap(x->splitByChar('#',x)[1],splitByChar(',',geo_list))))) geo6s,arrayDistinct(arrayMap(x->substr(x,1,5),arrayConcat([geohash],arrayMap(x->splitByChar('#',x)[1],splitByChar(',',geo_list))))) geo5s,arrayDistinct(arrayMap(x->substr(x,1,4),arrayConcat([geohash],arrayMap(x->splitByChar('#',x)[1],splitByChar(',',geo_list))))) geo4s,
duplication_flag from essid_info_local limit 30000) t1 where duplication_flag='1' limit 30 ;

-- 判断字符串包含多个字符串
SELECT * FROM some_table WHERE match(column_name, 'MG|XZ');

-- 切割字符串 
select length(splitByChar(',','r,r'));  splitByChar，第一个参数是分隔符，第二个是要分割的字符串

-- with查询结果当做变量在select语句使用
WITH (SELECT AVG(value) FROM some_table) AS avg_value
SELECT id, value, avg_value
FROM some_table
WHERE value > avg_value;

--  arrayStringConcat
select concat('\'',arrayStringConcat(arraySlice(bitmapToArray(gid_index_bitmap),1,30),'\',\''),'\'') gid_index
from tag_bitmap where tag_md5=lower(hex(MD5('g30126'))) and bitmap_segment_number=15);


-- 
SELECT arrayMap(x -> x * 2, [1, 2, 3, 4, 5]) AS result;  对数组做map处理
-- 字符串包含
select match('aftvf','a');

-- 数组join
select arrayIntersect([1,2,3,4],[4,5,6]); 
返回数组 [4]

-- 数组去重 
arrayDistinct()

-- 数组聚合
groupUniqArray  聚合一列去重生成数组
groupArray  聚合一列不进行去重

-- 对数组添加元素
SELECT arrayPushBack([1, 2, 3], 4) AS updated_array;

-- 多个数组打平
arrayFlatten(groupArray(values))  某一列是数组，聚合后还是一个数组，而不是二元数组

arrayFilter(x -> x > 3, [1, 2, 3, 4, 5])  对数组过滤 
select arrayJoin([1,2,3]); 一行变多行

countIf(x->x>3) 统计满足条件的行

--查看 待合并分区、文件数量
select partition_num,unmerged_partition_num,files_num from 
(select 1 flag , count() unmerged_partition_num from 
(select partition,count() counts  
from system.parts where database='glab_lbs' and table ='wifi_history_loc_local' and active=1 
group by partition having counts>1  )) t1  join 
(select 1 flag, count(distinct partition) partition_num, count() files_num
from system.parts where database='glab_lbs' and table ='wifi_history_loc_local' and active=1 ) t2 on t1.flag=t2.flag;


--查看表数据大小
 SELECT  database,table,  sum(rows) AS `总行数`, formatReadableSize(sum(data_uncompressed_bytes)) AS `原始大小`, formatReadableSize(sum(data_compressed_bytes)) AS `压缩大小`,
  round((sum(data_compressed_bytes) / sum(data_uncompressed_bytes)) * 100, 0) AS `压缩率`
  FROM system.parts where database  not in('test','default') and table='wifi_history_loc_local' group by database,table  order by sum(data_compressed_bytes) desc;

--查看失败查询日志
SELECT
    event_date,
    query_id,
    query,
    exception,
FROM system.query_log
WHERE exception <> '' 
and event_date='2024-07-11' limit 10;


特性	   |ORDER BY|	PRIMARY KEY
-|-|-
定义位置 |	必须在建表时定义	|可选，通常与 ORDER BY 一起定义
控制数据物理存储顺序|	是|	否
作用|决定数据存储的物理排序顺序，影响压缩效率	|用于加速查询，生成稀疏索引
关系|	PRIMARY KEY 是 ORDER BY 的一个子集或相同|	PRIMARY KEY 的字段必须在 ORDER BY 字段中
影响范围查询性能	|是，数据按顺序存储能加快范围查询	|是，通过索引跳表可以加速范围查询
去重功能	|无|	在特定引擎下可以（如 ReplacingMergeTree）

-- 查看表分区大小
 select  partition_id, partition as  `所属分区`, name as `part名字`, marks,rows,
 formatReadableSize(data_compressed_bytes) as  `压缩文件大小`, formatReadableSize(secondary_indices_compressed_bytes) as `二级索引压缩大小`,
 modification_time `修改时间`, min_block_number, max_block_number,
 formatReadableSize(primary_key_bytes_in_memory) `内存中主键大小`, database, table
 from system.parts where table ='wifi_ssid_search_v3_local' and active=1 order by data_compressed_bytes desc limit 10;



-- 查看正在执行的查询
SELECT query_id,substr(query,1,50), elapsed,read_rows,total_rows_approx, formatReadableSize(memory_usage) FROM system.processes
WHERE query NOT LIKE '%SELECT query, elapsed, memory_usage FROM system.processes%'
and query like '%wifi_wide%'
ORDER BY elapsed DESC ;

SELECT * FROM system.processes
WHERE query NOT LIKE '%SELECT query, elapsed, memory_usage FROM system.processes%'
ORDER BY elapsed DESC LIMIT 3 \G

--获取内存使用情况
SELECT * FROM system.metrics WHERE metric LIKE 'Memory.%';

-- 查询常驻内存大小
SELECT value FROM system.metrics WHERE metric = 'Memory.Resident'

--  通过上面指令获取到进程相关信息后，可以用query_id条件kill进程
KILL QUERY WHERE query_id 
in ('8c568e1b-c641-420c-86af-cbb038eed1f3','a3b2cbf2-8da5-4fc5-b93b-1113176d00d9');

-- 杀死进程
KILL QUERY WHERE query_id in
(select  query_id from system.processes
where query_kind='Insert' 
and query like '%insert into glab_gid_info.wifi_ssid_search_v3_local%'
and query like '%20240323%');

-- 查看进程还在不
select  query_id from system.processes
where query_kind='Insert' 
and query like '%insert into glab_gid_info.wifi_ssid_search_v3_local%' 
and query like '%20240323%';



-- 查看正在进行的合并 
SELECT  database, table, num_parts, formatReadableSize(total_size_bytes_compressed) total_size_bytes_compressed ,total_size_marks, rows_read, rows_written, columns_written, memory_usage FROM system.merges;

--查看历史执行sql
select event_time,query_duration_ms/1000 as `耗时(秒)`, read_rows as `读取行数`, result_rows  as `返回行数`, formatReadableSize(result_bytes) `返回数据大小`,
 formatReadableSize(memory_usage) `内存使用` , substr(query,1,40), databases, tables from system.query_log 
 where  query not like '%*%'
 and  event_time>='2025-01-21 19:00:00' and query_kind='Select' 
 order by query_duration_ms desc  limit 10 \G


select event_time,query_duration_ms/1000 as `耗时(秒)`, read_rows as `读取行数`, result_rows  as `返回行数`, formatReadableSize(result_bytes) `返回数据大小`,
 formatReadableSize(memory_usage) `内存使用` , query, databases, tables from system.query_log 
 where  query not like '%*%'
 and  event_time>='2025-01-21 19:00:00' and query_kind='Select' 
 order by query_duration_ms desc  limit 10  \G


--统计表查询次数 
 select  tables,count() counts from system.query_log where  event_date='2024-06-18' and event_time>'2024-06-18 19:30:00'
 group by tables order by counts desc limit 100;

--查看表字段大小
with t1 ( select  ) SELECT column AS `字段名`, any(type) AS `类型`, formatReadableSize(sum(column_data_uncompressed_bytes)) AS `原始大小`,
formatReadableSize(sum(column_data_compressed_bytes)) AS `压缩大小`, sum(rows) AS `行数` FROM system.parts_columns
WHERE database = 'glab_gid_info' AND table = 'appinfo_v2_local' GROUP BY column ORDER BY sum(column_data_uncompressed_bytes) DESC;



-- optimize table
optimize table glab_gid_info.gid_uninstall_applist_v2_local partition 'ANDROID-2a9' final;
-- 向ck中插入文件
insert into glab_gid_info.gid_uninstall_applist_v2_local select gid,applist,uninstall_detail,mau,pt,ts 
	from hdfs("hdfs://gt-ga-xs/data_result/fz/ck/uninstall_apps_calc_sort/ck/6/20230316/*.parquet","Parquet","gid String,applist String,uninstall_detail String,mau String,pt String,ts DateTime") ;
-- 向ck插入文件
clickhouse-client -m --port 9000 --user default --database glab_gid_info --password xxxxx
 --host hzxs-ga-ck-xs6 --max_insert_block_size=536970912 --max_insert_threads=4 
 -q ' insert into glab_gid_info.gid_uninstall_applist_v2_local select gid,applist,uninstall_detail,mau,pt,ts 
 	from hdfs("hdfs://gt-ga-xs/data_result/fz/ck/uninstall_apps_calc_sort/ck/6/20230317/*.parquet","Parquet") ;'
-- 统计某一天数据条数
select count() from glab_gid_info.gid_uninstall_applist_v2_local where toDate(ts)=toDate('20230329');




-- xw合并
104机器  
cd /home/log/xub2/ck  
source ck_util.sh
mergeTablePartition hzxs-ga-newck-xs1 glab_gid_info wifi_ssid_search_v3_local 5 &
mergeTablePartition hzxs-ga-newck-xs2 glab_gid_info wifi_ssid_search_v3_local 5 &
mergeTablePartition hzxs-ga-newck-xs3 glab_gid_info wifi_ssid_search_v3_local 5 &
mergeTablePartition hzxs-ga-newck-xs4 glab_gid_info wifi_ssid_search_v3_local 5 &
mergeTablePartition hzxs-ga-newck-xs5 glab_gid_info wifi_ssid_search_v3_local 5 &
mergeTablePartition hzxs-ga-newck-xs6 glab_gid_info wifi_ssid_search_v3_local 5 &

mergeTablePartition hzxs-ga-newck-xs2 glab_gid_info gid2index_local 10 &
mergeTablePartition hzxs-ga-newck-xs3 glab_gid_info gid2index_local 10 &
mergeTablePartition hzxs-ga-newck-xs4 glab_gid_info gid2index_local 10 &
mergeTablePartition hzxs-ga-newck-xs5 glab_gid_info gid2index_local 10 &
mergeTablePartition hzxs-ga-newck-xs6 glab_gid_info gid2index_local 10 &




single 7-12   172.18.69.206-211   bi
batch  1-6    172.18.69.199-204   jm

172.18.69.198  hzxs-ga-ck-xs-single-vip
jm 172.18.69.199  hzxs-ga-ck-xs13  hzxs-ga-newck-xs1
jm 172.18.69.200  hzxs-ga-ck-xs14  hzxs-ga-newck-xs2
jm 172.18.69.201  hzxs-ga-ck-xs15  hzxs-ga-newck-xs3
jm 172.18.69.202  hzxs-ga-ck-xs16  hzxs-ga-newck-xs4
jm 172.18.69.203  hzxs-ga-ck-xs17  hzxs-ga-newck-xs5
jm 172.18.69.204  hzxs-ga-ck-xs18  hzxs-ga-newck-xs6

172.18.69.205  hzxs-ga-ck-xs-batch-vip
bi 172.18.69.206  hzxs-ga-ck-xs19  hzxs-ga-newck-xs7
bi 172.18.69.207  hzxs-ga-ck-xs20  hzxs-ga-newck-xs8
bi 172.18.69.208  hzxs-ga-ck-xs21  hzxs-ga-newck-xs9
bi 172.18.69.209  hzxs-ga-ck-xs22  hzxs-ga-newck-xs10
bi 172.18.69.210  hzxs-ga-ck-xs23  hzxs-ga-newck-xs11
bi 172.18.69.211  hzxs-ga-ck-xs24  hzxs-ga-newck-xs12


-- 查看查询耗时
select 
query_id,query_duration_ms ds,read_rows,memory_usage,result_rows rst, length(thread_ids) ids_len,ProfileEvents['RealTimeMicroseconds'] as real_ts,
ProfileEvents['UserTimeMicroseconds'] as user_ts,
ProfileEvents['OSCPUWaitMicroseconds'] as cpu_wait_ts,
ProfileEvents['OSCPUVirtualTimeMicroseconds'] as cpu_vir_ts,
ProfileEvents['OSIOWaitMicroseconds'] as read_ts, 
ProfileEvents['NetworkSendElapsedMicroseconds'] as net_send_ts, 
ProfileEvents['SystemTimeMicroseconds'] as sys_ts, 
ProfileEvents['OSIOWaitMicroseconds'] as read_ts
  from system.query_log where event_date='2024-06-22' and type!=1 and query_kind='Select' 
and query_id in (
    'f6ea5ca1-729e-486d-8cc4-9d746751a251','9c3aec08-49b6-421a-864a-f10490a6896d','c96e637c-ebcb-42ef-89ea-37f5dc18dada','f24906b0-4f71-424b-ad59-cb8db069b39e'
)  settings max_threads=1;



optimize table glab_ip_info.ipv6_attribution on cluster glab_cluster_batch  final ;


explain  indexes=1
select wifimac,
       ssid,
       concat(geohash8, argMax(geohash_end, log_date)) as geohash,
       argMax(flag, log_date)                             flag,
       argMax(source, log_date)                           source,
       toUnixTimestamp(log_date) * 1000                   logDate
from glab_lbs.wifi_history_loc_local t
where (wifimac_md5 ,ssid) in [(MD5('3c67fdf8f7a7'),'MIFI-F7A7'),(MD5('3c67fdf8f7a7'),'MIFI-F7A7')]
  and (t.source = 'gt' or (jw_flag = 1 and diff_day >= 90))
  and log_date >= '1970-01-01'
  and log_date <= '2286-11-21'
group by wifimac, ssid, geohash8, log_date
order by log_date desc, geohash8 desc
limit 1000 by wifimac;