# AGENTS.md

Hugo + Stack 主题的中文个人博客，push 到 `main` 由 Actions 构建并发布到 GitHub Pages。
线上地址 <https://robot210.github.io/blog/>。

## 改动前先看这三处

- `config.yaml` — 站点配置。调外观、菜单、widgets 先在这里找现成开关
- `themes/hugo-theme-stack/layouts/` — 模板。不要直接改，要覆盖就复制到站点根目录同名路径
- `README.md` — 部署流程、钩子参数都在这里，不重复写

## 这个项目特有的坑

- **主题是随仓库提交的普通目录，不是子模块。** 别引入 `.gitmodules`、别 `git submodule`，升级靠整目录替换。
- **仓库里没有 `layouts/`、`assets/`、`static/`。** Hugo 会回落到主题内的同名目录。要覆盖时才新建，空目录不用建。
- **文章所在目录不决定 URL。** `permalinks.post = /p/:slug/`，所以 `content/post/2023/随笔.md` 发布后是 `/p/随笔/`；改文件名会改链接。
- **`baseurl` 带子路径 `/blog/`。** 写站内链接用 `relURL`，别写死 `/xxx/`，否则 Pages 上 404。
- **`params.comments.enabled` 是 `false`。** 没配置评论服务前别打开，否则文章底部渲染一个空白框。
- **`params.sidebar.avatar.enabled` 是 `false`。** 没有头像文件，开着就是裂图。
- **本机没装 hugo**（需要 extended 版才能编 SCSS），本地预览和构建都跑不了；验证靠 push 后看 Actions。

## 提交

- 被 `.githooks/pre-commit` 拒了 → 按报错的提示把那个文件按功能拆开再提交，**不要 `--no-verify`**
- `public/`、`resources/` 是构建产物，已在 `.gitignore` 里，别提交
- 新写配置项、新写函数前，先搜 `config.yaml` 和主题 `layouts/` 有没有现成的，别重复实现

## 常用命令

```bash
hugo new post/2026/名字.md   # 新建草稿（draft = true）
sh deploy.sh serve           # 本地预览
sh deploy.sh                 # 构建到 public/
```
