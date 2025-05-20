## lambda 
**Collectors.groupingBy**
```
   Map<String, Set<String>> resultMap = originalMap.entrySet().stream()
            .collect(Collectors.groupingBy(
                Map.Entry::getKey, // 按 key 分组
                Collectors.mapping(
                    Map.Entry::getValue, // 提取 value
                    Collectors.toSet()   // 聚合为 Set
                )
            ));
```

**Predicate**
```
Predicate<Integer> isEven = x -> x % 2 == 0;
System.out.println(isEven.test(4)); // true
```
**Function<String, Integer>**
```
Function<String, Integer> stringLength = str -> str.length();
System.out.println(stringLength.apply("Lambda")); // 6
```

**Consumer<T>**
> 用于消费一个值（没有返回值）。
```
Consumer<String> print = message -> System.out.println(message);
print.accept("Hello, Lambda!"); // Hello, Lambda!
```

**Supplier<T>**
> 用于提供一个值（无输入，返回一个值）。
```
Supplier<Double> randomValue = () -> Math.random();
System.out.println(randomValue.get()); // 0.8457812（随机数）
```

**UnaryOperator<T>**
个输入一个输出，输入和输出类型相同（Function<T, T> 的特例）。

**BinaryOperator<T>**

两个输入一个输出，输入和输出类型相同（BiFunction<T, T, T> 的特例）。

**BiFunction<T, U, R>**
接收两个参数并返回一个结果。

## 异步操作


### 创建方式

| 方法                             | 描述                          | 是否异步 | 是否有返回值 |
|----------------------------------|-------------------------------|----------|----------------|
| `new CompletableFuture<>()`      | 创建空任务，手动完成           | ❌       | ✅             |
| `supplyAsync(Supplier)`          | 异步执行，有返回值             | ✅       | ✅             |
| `runAsync(Runnable)`             | 异步执行，无返回值             | ✅       | ❌             |
| `completedFuture(T value)`       | 直接返回已完成任务             | ❌       | ✅             |

---

### then 系列（链式处理）

| 方法                                  | 描述                                 | 返回类型                | 是否依赖前一步结果 |
|---------------------------------------|--------------------------------------|-------------------------|--------------------|
| `thenApply(Function)`                 | 处理并返回新值                       | `CompletableFuture<U>` | ✅                 |
| `thenAccept(Consumer)`                | 消费前一步结果，无返回               | `CompletableFuture<Void>` | ✅             |
| `thenRun(Runnable)`                   | 不依赖结果，仅执行下个任务           | `CompletableFuture<Void>` | ❌             |
| `thenCompose(Function)`               | 返回嵌套的 CompletableFuture（扁平化）| `CompletableFuture<U>` | ✅                 |
| `thenCombine(CompletableFuture, BiFunction)` | 两任务都完成后合并结果         | `CompletableFuture<U>` | ✅                 |
| `thenAcceptBoth(CompletableFuture, BiConsumer)` | 两任务都完成后消费结果       | `CompletableFuture<Void>` | ✅             |
| `runAfterBoth(CompletableFuture, Runnable)` | 两任务都完成后执行任务        | `CompletableFuture<Void>` | ❌             |

---

### 异常处理

| 方法                     | 描述                                | 返回类型                | 说明                    |
|--------------------------|-------------------------------------|-------------------------|-------------------------|
| `exceptionally(Function)`| 异常时返回默认值                    | `CompletableFuture<T>` | 可恢复                  |
| `handle(BiFunction)`     | 成功或失败都可处理                  | `CompletableFuture<U>` | 全面兜底                |
| `whenComplete(BiConsumer)`| 成功或失败都执行（无结果修改）      | `CompletableFuture<T>` | 用于记录日志、监控等    |

---

### 任务组合

| 方法                                   | 描述                              | 返回类型              | 用途                     |
|----------------------------------------|-----------------------------------|------------------------|--------------------------|
| `allOf(CompletableFuture...)`          | 所有任务完成才继续（无结果）     | `CompletableFuture<Void>` | 聚合多个任务 |
| `anyOf(CompletableFuture...)`          | 任意一个任务完成就继续           | `CompletableFuture<Object>` | 获取最快任务结果 |

---

### 其他常用方法

| 方法                         | 描述                      | 是否异步 | 说明             |
|------------------------------|---------------------------|----------|------------------|
| `complete(T value)`          | 手动设置返回值并完成      | ❌       | 适用于手动控制     |
| `join()`                     | 阻塞等待返回值            | ❌       | 抛异常为 `Unchecked` |
| `get()`                      | 阻塞获取结果              | ❌       | 抛 `Checked Exception` |
| `isDone()`                   | 判断是否完成              | ❌       | 返回 `boolean`    |
| `cancel(boolean mayInterrupt)` | 取消任务                | ❌       |                   |

<details>
<summary>折叠代码（点击展开）</summary>

```java
import java.util.concurrent.*;
import java.util.function.*;

public class CompletableFutureDemo {

    public static void main(String[] args) throws InterruptedException {

        ExecutorService pool = Executors.newFixedThreadPool(5);

        CompletableFuture<String> userFuture = CompletableFuture.supplyAsync(() -> {
            sleep(500); // 模拟延迟
            System.out.println("👤 查询用户信息完成");
            return "用户A";
        }, pool);

        CompletableFuture<Boolean> stockFuture = CompletableFuture.supplyAsync(() -> {
            sleep(800); // 模拟延迟
            System.out.println("📦 检查库存完成");
            return true;
        }, pool);

        CompletableFuture<Boolean> couponFuture = CompletableFuture.supplyAsync(() -> {
            sleep(300);
            System.out.println("🎫 校验优惠券完成");
            if (Math.random() < 0.3) {
                throw new RuntimeException("优惠券无效");
            }
            return true;
        }, pool).exceptionally(ex -> {
            System.out.println("⚠️ 优惠券校验失败: " + ex.getMessage());
            return false; // fallback
        });

        // 所有异步任务都完成后处理
        CompletableFuture<Void> all = CompletableFuture.allOf(userFuture, stockFuture, couponFuture);

        CompletableFuture<String> orderFuture = all.thenApply(v -> {
            String user = userFuture.join(); // join 比 get 更简洁
            boolean inStock = stockFuture.join();
            boolean couponValid = couponFuture.join();

            if (inStock) {
                String order = String.format("✅ 订单已创建：用户=%s，优惠=%s", user, couponValid);
                System.out.println(order);
                return order;
            } else {
                return "❌ 库存不足，订单创建失败";
            }
        });

        // 完成后记录日志（无论成功失败）
        orderFuture.whenComplete((result, ex) -> {
            if (ex != null) {
                System.out.println("📛 订单处理异常：" + ex.getMessage());
            } else {
                System.out.println("📒 订单流程日志：" + result);
            }
        });

        // 阻塞等待
        orderFuture.join();

        pool.shutdown();
    }

    private static void sleep(long ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException ignored) {}
    }
}
```

</details>



运行代码报错  
scala: ## Exception when compiling 201 sources to /Users/huangg/IdeaProjects/namespace/java-project/target/classes
java.lang.NullPointerException
sbt.internal.inc.classpath.DualLoader.getResources(DualLoader.scala:100)
sbt clean
rm -rf ~/.ivy2/cache
rm -rf ~/.sbt/boot 