# 220's Blog

Hugo + [Stack](https://github.com/CaiJimmy/hugo-theme-stack) 主题的个人站点。
推送到 `main` 后由 GitHub Actions 自动构建并发布到 GitHub Pages。

线上地址：<https://robot210.github.io/blog/>

## 目录

| 路径 | 作用 |
| --- | --- |
| `content/` | 文章（Markdown） |
| `themes/hugo-theme-stack/` | 主题，随仓库提交（不是子模块） |
| `config.yaml` | 站点配置：标题、语言、`baseurl` |
| `.githooks/pre-commit` | 提交前的体积检查 |
| `.github/workflows/deploy.yml` | 自动部署 |
| `AGENTS.md` | 给 AI / 新人的项目约定 |

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
Pages 的 Source 已设为 `gh-pages` 分支的 `/ (root)`。

### 本机网络：只能走 SSH

这台机器的 `github.com:443` 被运营商黑洞（TLS 握手直接超时），https 的 `git push` / `git fetch` 用不了；
`github.com:22` 正常。所以本仓库的 remote 指向 SSH：

```bash
git remote set-url origin ssh://git@github.com/robot210/blog.git
```

认证靠 `~/.ssh/id_ed25519_blog`，它已注册成这个仓库的 deploy key（`dsh-push-deploy-key`，有写权限）。
换机器时要重新配 key，或者改回 https。

deploy key 不能创建或修改 `.github/workflows/` 下的文件（GitHub 的策略），
要改 CI 得用带 `workflow` scope 的 token 推一次。

## 约定

- `public/`、`resources/` 是构建产物，已 gitignore，不要提交
- 主题文件直接进仓库，升级时手动替换 `themes/hugo-theme-stack/`
- `layouts/`、`assets/`、`static/` 默认不存在；要覆盖主题文件时再新建同名路径
- 2026-11 从 OneDrive 迁出并重建历史（原仓库 `git init` 后从未提交）

## 待办

- [x] 首次 `git push` 并打开 Pages（2026-11-09，gh-pages 已发布）
- [ ] 写第一篇正式文章：现在 `content/post/` 里两篇都是 `draft = true`，线上文章列表是空的
- [ ] 想开评论：配好服务后把 `params.comments.enabled` 改成 `true`
- [ ] 想显示头像：图片放 `assets/img/avatar.png`，再把 `params.sidebar.avatar.enabled` 改成 `true`
