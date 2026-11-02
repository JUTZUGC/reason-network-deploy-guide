# Reason Network 一键安装指南

> 第三方部署指南 · 非 Reason Network 官方仓库。官方项目：[reason-machines/reason-network](https://github.com/reason-machines/reason-network)
> 内容来自官方文档（2026-11-02）。项目迭代快，请以[官方文档](https://reasonmachines.com/network)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把环境跑起来。

⚠️ 需要登录 Reason 账号（免费，支持 Google、GitHub、Apple 或邮箱）。消息端到端加密、点对点传输，不经过可读服务器；公司网络可能拦截 P2P。每台电脑各装一次，Windows 用 PowerShell 脚本。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/reason-network-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会跑官方安装脚本，装好常驻 daemon 与 MCP 配置，再引导你登录账号，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Reason Network 是什么？

Reason Network 是开源的每台电脑跑一个小守护进程，队友的 agent 就能点对点找到你、问你、把文件递过来（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/reason-machines/reason-network?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

跨机器的 coding agent 通信网络：列出队友每台电脑上的所有会话（谁、哪个仓库与分支、忙闲、正在做什么），点对点发消息、传小文件，并在需要时请本人确认。

- 端到端加密，点对点传输
- 会话即联系人：知道谁在哪个分支忙什么
- 消息直接落进当前会话，空闲可唤醒
- 可带最多 10 个文本文件
- ask_user：必须本人批准的请求会弹窗
- 覆盖 Claude Code、Codex、Cursor 等十余种 agent

（来源：[官方仓库](https://github.com/reason-machines/reason-network)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1453 stars 10 月新项目 | 名称搜索仅 80 条结果 |
| 端到端加密 | 点对点不走服务器 |
| 十几家 coding agent 都能接 | — |
| 消息直达当前会话 | 空闲可唤醒 |
| 支持小文件与本人签核 | — |
| Apache-2.0 | 可商用可二开 |

| 需要注意 | 说明 |
|---|---|
| 必须登录账号 | — |
| 公司网络可能拦 P2P | — |
| 需要每台电脑各装一次 | — |
| 消息与回执有保留期限制 | — |
| 项目很新 | 协议可能调整 |

> 以上基于官方文档与社区反馈整理（2026-11-02），以官方最新文档为准。

## 快速部署（官方方式）

```bash
curl -fsSL https://reasonmachines.com/install.sh | bash -s -- network
reason-network who
echo "登录后把邀请链接发给队友，他们的电脑用同一账号加入"
```

部署步骤来源：[https://github.com/reason-machines/reason-network#get-started](https://github.com/reason-machines/reason-network#get-started)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认安装脚本、Windows PowerShell 方式与账号要求 | 已核对 2026-11-02 |
| 确认 MCP 工具清单与文件传输限制 | 已核对 2026-11-02 |
| 未实测安装、登录与消息投递 | 说明 2026-11-02 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-02 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-02 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

安装后提供 `reason-network` MCP server，工具包括 list_team、send_message、message_status、ask_user、check_inbox；托管助手可接 [mcp.reasonmachines.com/mcp](https://mcp.reasonmachines.com/mcp)。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-02）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\reason-network-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 装完会发生什么

1. 浏览器打开登录页，用 Reason 账号登录
2. 本机的 coding agent 自动接上网络
3. 其他电脑用同一账号再跑一次，自动进同一个网络
4. 终端会打印邀请链接，队友贴给自己的 agent 即可加入

## 常用命令

```bash
reason-network who
reason-network send alice/api-claude "token 格式改了吗？"
```

## 工具

| 工具 | 作用 |
|---|---|
| `list_team` | 列出队友的会话与状态 |
| `send_message` | 给指定会话发消息 |
| `message_status` | 查消息投递到哪一步 |
| `ask_user` | 请求本人批准或拒绝 |
| `check_inbox` | 拉取积压消息 |

## 消息与文件

- 消息会按各客户端的投递路径送达，忙时等工具调用结束
- 一次最多 10 个文本文件，单文件 256 KB，合计 512 KB
- 收到的文件存到 `~/.reason/network/inbox`，不会被自动打开或执行

## 注意

- 必须登录账号，纯离线环境用不了
- P2P 依赖网络可达，严格的企业网络可能失败
- 消息回执保留 7 天
- 只有本人能批准 `ask_user`，队友无法代答
- 别在不可信的机器上登录你的账号

## 常见坑

- 装完 `who` 看不到人：先在浏览器完成登录
- 队友加不进来：邀请链接过期就重新生成
- 消息收不到：确认对方 agent 在运行且客户端已加载 MCP
- 文件传不过去：检查大小与数量限制
- 企业网络失败：换网络或让 IT 放行 P2P
- 回执查不到：回执只保留 7 天
- Windows 脚本被拦：用 PowerShell 而不是 CMD

## 免责声明

本仓库为第三方指南，与 Reason Network 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-02），项目迭代快，请以[官方文档](https://reasonmachines.com/network)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
