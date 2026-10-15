
Play Hopf Fiberation
----

> Based on [Quatrefoil](https://github.com/Quatrefoil-GL/quatrefoil).

Demo https://r.tiye.me/Quatrefoil-GL/play-hopf/

The existing web-entry deployment remains at its current rsync path. GitHub
Actions also uploads the frontend `dist/` assets to
`https://cos-sh.tiye.me/Quatrefoil-GL/play-hopf/`, with pull-request previews
under `/pr/<number>/<run>/<attempt>/`. Vite writes JS, CSS, and manifest URLs against that CDN base;
the COS action verifies the uploaded files through their public URLs.

COS Action 使用正式 v1.2.0，唯一上传校验为 `public-base-url` 内置 verify；不增加额外脚本。
上传按事件/分支排队，job/上传分别限制为 15/10 分钟。原生产前缀与 rsync 路径不变，
保留 strict Caps 和类型门禁；开发环境使用 Calcit/procs 0.30.0、Caps 0.1.1、Node 24 和 Yarn 4.18.0。
移除未使用的旧 alpha 包 `@quatrefoil/meshline`；实际发布模块已使用正式 `meshline`。

### 迁移状态与已知限制

正式 Calcit 模块为 Quatrefoil 0.1.8、Touch Control 0.0.31、js-ffi 0.2.3、
Quaternion 0.2.14、Pointed Prompt 0.0.19。保持原有 Three 0.166.1、相机、场景缩放、
公式、采样参数和应用版本 0.0.6；Vite 升级到 8，配置使用 `.mjs`。

旧 Option / watch / Ref / case 写法已迁移。5 处 unsafe 强转改为真实检查：
状态值经过 Bool / Number / List 解码，Math.atan 的结果解码为 Number，mobile-detect
对象经过 external trait 检查，其 nullable String 返回值通过 `non-nil?` 转为 Bool，
不再声明宿主直接返回 Bool。组件及三个几何回调使用名义 Component / Shape 类型。

本地 228 个定义、22 个公开项目定义、完整 strict（225 个可达定义）、JS / CDN 构建、
immutable install 通过。项目没有附着测试，不把零测试视为测试套件通过。
忽略目录中的数学探针在旧 0.27.0/旧正式模块图与新 native 图通过六个断言，
检查 xyz 坐标、四分之一圆弧和颜色表；旧 CLI 使用原来的 numeric case 写法。

**交互验收尚未完成，不应据此合并部署。** 原 0.27.0 页面启动报
`&map:to-list expected a Map`；新图首次渲染恢复，但打开 spiral 开关后其余受光几何
消失，关闭恢复，无浏览器异常。隔离 diff 只替换开关球体，场景节点与灯光保留；
不含 Hopf 公式的 Lambert 材质最小场景也复现，而 Basic 材质不复现。
Three 0.166.1 / 0.168.0 对照均复现，根因仍待定位，未添加强制重建/清缓存绕过。
VR、多点触控和完整视觉回归未完成。PR CI 成功也不能替代这个运行时门禁。

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
