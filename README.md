# ORBIT · 选题星球

个人创意选题库。把散落的灵感整理成下一件值得完成的作品。

**纯前端单文件应用**：无后端、无构建、无第三方依赖、不加载任何 CDN 资源。双击 `index.html` 即可运行，也可以直接丢到任意静态托管。

---

## 快速开始

### 本地运行

```bash
# 方式一：直接双击 index.html

# 方式二：起一个本地服务（推荐，localStorage 行为更一致）
python3 -m http.server 4173
# 打开 http://127.0.0.1:4173
```

### 部署

| 平台 | 做法 |
| --- | --- |
| Netlify | 拖拽整个文件夹到 Netlify 的 Deploy 区，或连接 Git 仓库，仓库里已带 `netlify.toml` |
| Vercel | 导入仓库，Framework 选 Other，Output Directory 填 `.` |
| GitHub Pages | 仓库 Settings → Pages → Deploy from branch，根目录即可 |
| 自有服务器 | 把 `index.html` 丢进任意目录，Nginx/Apache 静态托管 |

没有构建步骤，改完 `index.html` 刷新即生效。

---

## 功能

### 选题管理
- 卡片列表，按分类 / 状态（灵感中 · 进行中 · 已完成）筛选
- 排序：最近编辑 / 最近创建 / 优先级 / 标题
- 全文搜索（标题、简介、标签、笔记、自定义区块），`⌘K` 聚焦
- 多选批量删除
- 右侧抽屉编辑：标题、分类、状态、优先级、计划时间、标签、内容笔记、任意数量的自定义区块
- 所有改动自动保存

### 分类
- 自定义分类名称与识别色（8 色）
- 双击分类名重命名
- 删除分类时强制指定选题转移去向，不会丢数据

### AI 选题（三种方式）
1. **粘贴整理** — 把 ChatGPT / Claude / Codex 的回答整段粘进来，一键拆成选题卡片。支持 `1. 2. 3.`、`-`、`##`、「标题：」等格式，`#标签` 与 `【】` 自动识别为标签。
2. **AI 生成** — 接入自己的 API（OpenAI / Claude / 任何 OpenAI 兼容接口），按"品牌设计 / 活动设计 / 运营设计 / 自媒体内容 / 包装设计 / 个人作品"方向直接生成。
3. **本地模板** — 12 个角度模板随机组合，离线可用。

生成结果可勾选后批量存入指定分类。

### 数据
- 全部存在浏览器 `localStorage`，键名 `orbit-ideas-v3`
- 导出 / 导入 JSON 备份
- 内置 46 条「插画风格选题策划手册 V3 / V5」选题，首次打开自动合并（按标题去重，只跑一次）

### 界面
- 自动 / 日间 / 夜间三套主题，深色模式有独立色板
- 顶部色块可点击，直接筛选对应状态
- 响应式：桌面多列、平板两列、手机单列，侧栏变抽屉

### 快捷键
| 按键 | 作用 |
| --- | --- |
| `⌘K` / `Ctrl+K` | 聚焦搜索 |
| `⌘J` / `Ctrl+J` | 新建选题 |
| `Esc` | 逐层关闭弹窗 / 抽屉 / 多选模式 |
| `Enter` | 标签输入框中添加标签 |
| `Backspace` | 标签输入框为空时删除上一个标签 |

---

## 接入自己的模型

顶栏 `API` 按钮：

| 服务商 | 接口地址 | 模型示例 |
| --- | --- | --- |
| OpenAI | `https://api.openai.com/v1` | `gpt-4o-mini` |
| Claude | `https://api.anthropic.com/v1` | `claude-sonnet-4-5` |
| 兼容接口 | 自填 base url | 自填模型名 |

- Key 只写入本机浏览器的 `localStorage`，请求由浏览器直连服务商，不经过任何中间服务
- Claude 官方接口已带 `anthropic-dangerous-direct-browser-access` 头
- 若中转站不允许跨域（浏览器报 CORS），改用兼容接口地址

> ⚠️ Key 目前是明文存储。公用电脑上用完请在 API 面板点「清除」。

---

## 目录结构

```
.
├── index.html               # 整个应用（HTML + CSS + JS，单文件）
├── data/
│   └── manual-topics.json   # 46 条手册选题的源数据（已内置进 index.html，此文件供查阅与再加工）
├── netlify.toml             # Netlify 静态托管配置
├── LICENSE                  # MIT
└── README.md
```

`index.html` 内部结构：

```
<style>   设计令牌（颜色 / 圆角 / 动效曲线）→ 布局 → 组件 → 响应式
<body>    侧栏 → 顶栏 → 色块控制区 → 页头 → 工具栏 → 卡片网格 → 抽屉 → 弹窗
<script>  状态与存储 → 主题 → 渲染 → 交互 → 抽屉 → 弹窗 → 导入导出 → AI → 启动
```

---

## 设计系统

```
底色      #EFEFED        文字  #111113        卡片  #FFFFFF
蓝 #2F5BFF   橙 #FF6B2C   黄 #FFD400   绿 #00C27A
紫 #7A5CFF   粉 #FF4D97   青 #00C2E0   黑 #111113
```

每支颜色都有配对的浅色版（`--s-*`）用于标签底色。改色只需替换 `:root` 里的 `--k-*` 与 `--s-*` 两组变量，深色模式在 `html[data-theme="dark"]` 内单独定义。

卡片右上角的几何图形有 6 种（同心圆、圆环、半圆拼色、胶囊套圆、四分之一圆弧、圆角方块十字），按分类色轮换，定义在 `shapeSVG()` 里。

---

## 数据格式

```jsonc
{
  "v": 3,
  "theme": "auto",
  "onboard": true,
  "packImported": true,
  "ai": { "provider": "openai", "base": "", "model": "", "key": "" },
  "categories": [
    { "id": "...", "name": "品牌设计", "color": "blue" }
  ],
  "topics": [
    {
      "id": "...",
      "title": "城市咖啡品牌视觉升级",
      "note": "一句话简介",
      "categoryId": "...",
      "status": "idea | doing | done",
      "priority": "low | mid | high",
      "due": "2026-11-01",
      "tags": ["品牌设计", "VI"],
      "blocks": [{ "id": "...", "title": "策划手册", "body": "..." }],
      "createdAt": 1793000000000,
      "updatedAt": 1793000000000
    }
  ]
}
```

导出的备份就是这个结构，可以直接用脚本加工后再导入。

---

## 已知限制

- 数据只存在当前浏览器：换设备、换域名、无痕模式、清除站点数据都不会同步，靠导出备份迁移
- API Key 明文存储
- 导出备份依赖浏览器下载，部分内嵌预览环境会拦截，部署到正式域名后正常

---

## License

MIT
