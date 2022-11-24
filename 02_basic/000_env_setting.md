# Environment Setting

Set `~/.vimrc`.

```bash
set expandtab
set tabstop=2
set shiftwidth=2
set nowrap
set number
```

Set `~/.bashrc`.

```bash
alias k='kubectl'
alias ka='kubectl apply -f'
alias kn='kubectl config set-context --current --namespace'
export do='--dry-run client -o yaml'
export rn='--force --grace-period 0'
```
