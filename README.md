# 220's Blog

Hugo + [Stack](https://github.com/CaiJimmy/hugo-theme-stack) 主题的个人站点。
推送到 `main` 后由 GitHub Actions 自动构建并发布到 GitHub Pages。

线上地址：<https://robot210.github.io/blog/>

## 目录

| 路径 | 作用 |
| --- | --- |
| `content/` | 文章（Markdown） |
| `layouts/` `assets/` `static/` | 站点级的覆盖文件与静态资源 |
| `themes/hugo-theme-stack/` | 主题，随仓库提交（不是子模块） |
| `config.yaml` | 站点配置：标题、语言、`baseurl` |
| `.githooks/pre-commit` | 提交前的体积检查 |
| `.github/workflows/deploy.yml` | 自动部署 |

## 日常操作

新建文章：

```bash
hugo new post/2026/文章名.md
```

本地预览（改文件自动刷新）：

```bash
sh deploy.sh serve
```

只构建到 `public/`：

```bash
sh deploy.sh
```

提交推送：

```bash
git add -A
git commit -m "post: 文章名"
git push
```

## 提交钩子

`.githooks/pre-commit` 会拦下超过 **20 KB** 的代码文件。lockfile、压缩产物、
`dist/` `generated/` 这类目录、带 `@generated` / `DO NOT EDIT` 标记的文件自动放行。

被拦时按提示按功能拆分。确实要提交这一次：

```bash
SKIP_SIZE_CHECK=1 git commit -m "..."   # 只跳过体积检查
git commit --no-verify                  # 跳过所有钩子
```

改阈值或永久放行某个路径：

```bash
git config hooks.maxFileSizeKB 40
git config --add hooks.sizeCheck.exclude 'src/legacy/*'
```

## 部署

`main` 分支一 push 就会自动构建，产物推到 `gh-pages` 分支。
仓库 Settings → Pages 的 Source 需要设为 `gh-pages` 分支的 `/ (root)`。

## 约定

- `public/`、`resources/` 是构建产物，已 gitignore，不要提交
- 主题文件直接进仓库，升级时手动替换 `themes/hugo-theme-stack/`
- 2026-11 从 OneDrive 迁出并重建历史（原仓库 `git init` 后从未提交）

## 待办

- [ ] 首次 `git push` 并打开 Pages
- [ ] 清理 `config.yaml` 里 `en` / `ar` 的模板占位文案
