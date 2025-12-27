> 本文件由 Cursor 生成

# Dotfiles

个人配置文件管理仓库，用于统一管理和同步各种应用程序的配置文件。

## 功能特性

- 📦 集中管理多个应用程序的配置文件
- 🔄 支持双向同步（从系统到仓库，从仓库到系统）
- ⚙️ 灵活的配置规则（包含/排除文件、仅文件/仅文件夹）
- 🎯 支持选择性同步特定配置项

## 项目结构

```
dotfiles/
├── config.toml      # 配置文件同步规则
├── tool.py          # 同步工具脚本
├── dependencies.txt # 依赖软件包列表
├── Configs/         # 存储的配置文件目录
└── README.md        # 本文件
```

## 使用方法

### 基本命令

```bash
# 列出所有配置项
python tool.py list

# 从系统同步到仓库（更新仓库中的配置）
python tool.py update

# 从仓库同步到系统（设置系统配置）
python tool.py set

# 同步特定配置项
python tool.py update --target fish
python tool.py set --target nvim

# 强制同步（忽略 update/set 标志）
python tool.py update --target nvim --force
```

### 配置文件说明

`config.toml` 文件定义了每个应用程序的同步规则：

```toml
[name]
src_path = "~/.config/name/"      # 源路径，默认为 ~/.config/name/
des_path = "./Configs/.config/name" # 目标路径，默认为 ./Configs/.config/name
include = ["file1", "file2"]       # 包含的文件列表，默认包含所有
exclude = ["file3", "file4"]       # 排除的文件列表，默认为空
file_only = false                  # 是否仅复制文件，默认为 false
folder_only = false                # 是否仅复制文件夹，默认为 false
update = true                      # 是否在 update 模式下同步，默认为 true
set = true                         # 是否在 set 模式下同步，默认为 true
```

### 当前管理的配置

本仓库管理以下应用程序的配置：

- **Shell**: fish
- **终端**: kitty, ghostty, wezterm
- **编辑器**: nvim (AstroNvim 配置)
- **窗口管理器**: hyprland, waybar, niri
- **启动器**: rofi, tofi, quickshell
- **文件管理器**: yazi
- **输入法**: fcitx, fcitx5
- **其他**: starship, git, gtk-3.0, gtk-4.0, fontconfig, Code (VSCode)

## 依赖安装

查看 `dependencies.txt` 文件获取需要安装的软件包列表。

主要依赖包括：
- Python 3
- toml 库（用于解析配置文件）

安装 Python 依赖：

```bash
pip install toml
```

## 子模块

本项目使用 Git 子模块管理 nvim 配置：

```bash
# 初始化子模块
git submodule init
git submodule update

# 或克隆时同时初始化子模块
git clone --recursive <repository-url>
```

## 注意事项

1. **备份**: 使用 `set` 模式时，系统原有配置会被备份到 `./backup/` 目录
2. **路径**: 所有路径中的 `~` 会被自动展开为用户主目录
3. **符号链接**: 复制目录时会保留符号链接
4. **安全**: 在同步配置前，建议先查看 `config.toml` 确认同步规则

## 许可证

本项目为个人使用，无特定许可证。
