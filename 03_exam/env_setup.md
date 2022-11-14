# Environment Setup

.vimrc

```bash
set tabstop=2
set expandtab
set shiftwidth=2
```

.bashrc

```bash
alias ka='kubectl apply -f'
alias kn='kubectl config set-context --current --namespace '

export do="--dry-run=client -o yaml"
export rn="--force --grace-period 0"
```
