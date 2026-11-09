#!/bin/sh
# 本地构建 / 预览。部署由 push 到 main 触发 Actions 完成，见 README「部署」。
#   sh deploy.sh          构建到 public/
#   sh deploy.sh serve    起本地服务器（改文件自动刷新）

set -e

if ! command -v hugo >/dev/null 2>&1; then
    printf '× 没找到 hugo，先装：https://gohugo.io/installation/windows/\n' >&2
    printf '  （需要 extended 版本，Stack 主题依赖 SCSS 编译）\n' >&2
    exit 1
fi

case "${1:-}" in
    serve)
        hugo server -D --navigateToChanged
        ;;
    *)
        hugo --minify --gc
        printf '\n✓ 构建完成 -> public/\n'
        printf '  本地预览：sh deploy.sh serve\n'
        ;;
esac
