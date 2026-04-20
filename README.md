# cgit Docker
ホスト側:

```text
/home/git/repos/
└── f2b-out-gen
## 起動

```bash
docker compose up -d --build
```

- ホストポート: `8080`
- コンテナ内 repo パス: `/var/lib/git/repos`

```text
http://localhost:8080/
```

## environment variables

```bash
CGIT_PORT=8080
GIT_REPOS_PATH=/home/git/repos
CGIT_TITLE="Git"
CGIT_DESC="Hosted by cgit"
CGIT_CLONE_BASE_URL="https://git.soulminingrig.com"
docker compose up -d --build
```
