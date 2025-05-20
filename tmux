tmux 是一个终端复用工具，它允许你在一个终端窗口中创建和管理多个会话，并在这些会话之间切换。以下是 tmux 的一些基本使用教程：

启动 tmux：

在终端中输入 tmux 命令启动一个新的 tmux 会话。
如果你想给会话命名，可以使用 tmux new-session -s session_name 命令。
tmux 快捷键：
创建 tmux new -s huangg
进入 tmux a -t huangg
离开 crtl b d

Ctrl+b ：所有 tmux 命令的前缀键，即按下该键后再输入其他命令。
Ctrl+b c ：创建一个新窗口。
Ctrl+b x ：关闭切分窗口。
Ctrl+b n ：切换到下一个窗口。
Ctrl+b p ：切换到上一个窗口。
Ctrl+b d ：分离当前会话（退出 tmux，但会话仍在后台运行）。

tmux ls ：列出当前存在的 tmux 会话。
tmux attach-session -t session_name ：附加到指定的 tmux 会话。
tmux switch -t session_name ：切换到指定的 tmux 会话。
