
Play Hopf Fiberation
----

> Based on [Quatrefoil](https://github.com/Quatrefoil-GL/quatrefoil).

Demo https://r.tiye.me/Quatrefoil-GL/play-hopf/

The existing web-entry deployment remains at its current rsync path. GitHub
Actions also uploads the frontend `dist/` assets to
`https://cos-sh.tiye.me/Quatrefoil-GL/play-hopf/`, with pull-request previews
under `/pr/<number>/<run>/<attempt>/`. Vite writes JS, CSS, and manifest URLs against that CDN base;
the COS action verifies the uploaded files through their public URLs.

COS Action 使用正式 v1.3.0，唯一上传校验为 `public-base-url` 内置 verify；不增加额外脚本。
上传按事件/分支排队，job/上传分别限制为 15/10 分钟。原生产前缀与 rsync 路径不变，
保留 strict Caps 和类型门禁；开发环境使用正式 Calcit/procs 0.38.0、Caps 0.1.1、Node 24 和 Yarn 4.18.0。
移除未使用的旧 alpha 包 `@quatrefoil/meshline`；实际发布模块已使用正式 `meshline`。

### Calcit 0.38.0 使用说明

使用正式 Calcit 与 `@calcit/procs` 0.38.0、Quatrefoil 0.3.4 和 Touch Control 0.0.39。升级后重新安装依赖并构建。控件状态以 `HopfControlValue` union 表达数字、布尔值和数字列表。移动设备检测按可空字符串处理。

生成 JS 验证了位置和半径控件。回环 Chrome 验证了实际 WebGL 首帧，以及桌面和手机标识的检测结果。

### 历史：0.34.2 迁移

使用者需配对 Calcit CLI/procs 0.34.2；HopfCircle 的 center/vx/vy 和圆周采样结果
现在明确为三个 Number 的 Tuple，手工构造时需提供恰好三个分量。原三维公式、采样密度、
材质、相机、控制回调、HUD、应用版本和部署路径保持。真实异构 UI 状态仍在原入口检查，
不以伪 union 或 unsafe 隐藏 Dynamic，不放宽类型门禁。

官方格式迁移之外，对照全部 22 个原定义，只有 HopfCircle 的三个字段和 StructDef 元数据、
四处三项字面量的类型标注，以及 lowed-circle-fn 返回合同变化。候选已通过全部 228 个定义、
完整 strict、dynamic-method 检查和前端构建；项目没有原附着测试，不把零选择称作套件通过。

临时 Vite 内存验收通过圆周三个采样点、颜色表，以及实际 Three 默认 11 条管线和非零
spiral 关闭/开启各 10 条管线：坐标有限，非零 spiral 的几何确实不同。此验收仅为几何数据，
为模块初始化提供 div 和键盘监听占位；并记录 Vite WebSocket 绑定限制和重复 Three 警告。
它不证明 DOM 控件交互、WebGL 绘制或旧可见性问题 #64 修复，未合并或部署本应用。

正式 Quatrefoil 0.3.0 / Touch Control 0.0.36 的 Caps 严格安装、不可变安装、工具链配对、
全部定义、完整 strict、dynamic-method 检查及构建已重新通过；最终 PR CI 仍待远端执行。

### 本轮 0.32.1 使用者影响与验收

请配对升级 CLI/procs 0.32.1、重新安装模块并刷新。严格 Caps 使用已发布 Quatrefoil 0.2.0、
Touch Control 0.0.35、JS-FFI 0.2.9、Quaternion 0.2.19、Pointed Prompt 0.0.24 五个模块，
不依赖本地候选或绕过版本冲突。Three 仍是原 0.166.1；本次应用源码只经官方事务迁移旧类型形式，
原公式、相机、材质、采样、回调、HUD 与应用版本保持。npm 等待期明确为维护者授权的一小时。
三处 Action SHA 改为经核对对应原 commit 的精确正式 tag，按维护者选择接受 tag 可移动风险；
原权限、门禁、COS 内置校验和生产路径/条件不变。

228 个定义、22 个公开项目定义、完整 strict、不可变安装、工具链配对与构建通过；
deprecated call / dynamic method 均为 0。项目没有原附着测试，不把空测试选择称作测试套件通过。
实际 IAB 页面 spiral 开关从暗变亮再变暗，受光曲线和控制点始终可见；a 键相机旋转及刷新恢复
通过，浏览器无警告或错误。没有清缓存或强制重建场景绕过旧问题。

这只支持当前环境默认场景暂未复现 #64，**不证明本轮升级修复旧问题**；此前旧、新图在同环境
均暂未复现，所以上游 [Quatrefoil #64](https://github.com/Quatrefoil-GL/quatrefoil/issues/64) 保持开放。
默认 delta-r=0，开关反馈不证明非零螺旋参数正确。实际组合控件、VR/gamepad、多点触控、
原 Lambert 最小场景和跨 GPU 尚未复验；不把 CI 成功当作这些行为均已通过，不合并或部署生产。

### 此前 0.30.1 迁移状态与已知限制

使用者影响：本轮同步正式 Calcit CLI / JS runtime 0.30.1 与已发布模块图：Quatrefoil 0.1.9、Touch Control 0.0.31、js-ffi 0.2.3、
Quaternion 0.2.16、Pointed Prompt 0.0.19。Quatrefoil 0.1.9 的 `update-states` 会拒绝缺失的第二项 payload，显式 nil 仍保留；当前派发继续传入 cursor 与 payload 两项，不为绕过依赖冲突而放宽 Caps。保持原有 Three 0.166.1、相机、场景缩放、
公式、采样参数和应用版本 0.0.6；Vite 升级到 8，配置使用 `.mjs`。

旧 Option / watch / Ref / case 写法已迁移。5 处 unsafe 强转改为真实检查：
状态值经过 Bool / Number / List 解码，Math.atan 的结果解码为 Number，mobile-detect
对象经过 external trait 检查，其 nullable String 返回值通过 `non-nil?` 转为 Bool，
不再声明宿主直接返回 Bool。组件及三个几何回调使用名义 Component / Shape 类型。

此前 0.30.0 图的本地 228 个定义、22 个公开项目定义、完整 strict（225 个可达定义）、JS / CDN 构建、
immutable install 通过。这是旧配对的记录，不代表正式 0.30.1 已验收；本轮以当前提交 CI 与浏览器验收为准。项目没有附着测试，不把零测试视为测试套件通过。
忽略目录中的数学探针在旧 0.27.0/旧正式模块图与新 native 图通过六个断言，
检查 xyz 坐标、四分之一圆弧和颜色表；旧 CLI 使用原来的 numeric case 写法。

**旧交互问题尚未确认解决，不应仅凭 CI 合并部署。** 原 0.27.0 页面启动报
`&map:to-list expected a Map`；新图首次渲染恢复，但打开 spiral 开关后其余受光几何
消失，关闭恢复，无浏览器异常。隔离 diff 只替换开关球体，场景节点与灯光保留；
不含 Hopf 公式的 Lambert 材质最小场景也复现，而 Basic 材质不复现。
Three 0.166.1 / 0.168.0 对照均复现，根因仍待定位，未添加强制重建/清缓存绕过。
见 [Quatrefoil #64](https://github.com/Quatrefoil-GL/quatrefoil/issues/64)。本轮已对照实际 CI 原始构建：0.30.1 / Quatrefoil 0.1.9 与旧 main 的 0.30.0 / 0.1.8，在同一浏览器环境实际打开 spiral 后均保留其他几何、控制台无错误。因为旧图也暂未复现，不能归因于本轮升级或宣布 #64 已修复；该 issue 保持开放。默认 delta-r 为 0，按现有公式切换 spiral 不应改变曲线。尝试鼠标拖动数值球没有可观察变化，这些控件的完整控制器/触控验收、VR 与跨 GPU 视觉回归仍未完成，不把首次渲染和 CI 绿灯冒充全部交互通过。

### About

Using similar rules from Hopf https://www.youtube.com/watch?v=AKotMPGFJYk but not exactly use it's equations. It's hard to solve equations. So this is just a simplified verison:

![image](https://user-images.githubusercontent.com/449224/124225327-d6e6c980-db39-11eb-80c6-0ca83a9317b5.png)
![image](https://user-images.githubusercontent.com/449224/124225338-dcdcaa80-db39-11eb-8f90-f025e1794a0a.png)
![image](https://user-images.githubusercontent.com/449224/124225358-e6661280-db39-11eb-8e23-eafb4bafba12.png)
![image](https://user-images.githubusercontent.com/449224/124225368-eb2ac680-db39-11eb-8381-290066c23dd3.png)
![image](https://user-images.githubusercontent.com/449224/124225388-f41b9800-db39-11eb-8369-e2749f3dd7f8.png)
![image](https://user-images.githubusercontent.com/449224/124225395-f7168880-db39-11eb-92b0-7ed20b975767.png)
![image](https://user-images.githubusercontent.com/449224/124225379-efef7a80-db39-11eb-9f1c-a4c3d039f9fa.png)
![image](https://user-images.githubusercontent.com/449224/124225406-fbdb3c80-db39-11eb-865d-d7e0ef92a83d.png)
![image](https://user-images.githubusercontent.com/449224/124225414-fed62d00-db39-11eb-8db3-c340474d33c8.png)

### Workflow

https://github.com/Quatrefoil-GL/quatrefoil-workflow

### License

MIT
