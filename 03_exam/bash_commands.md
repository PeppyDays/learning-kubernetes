# Useful Bash Commands

replace white space to new line

```bash
k config view -o jsonpath='{.contexts[*].name}' | tr " " "\n"
```

replace string

```bash
cat ~/.kube/config | grep current | sed -e "s/current-context: //"
```

check system logs

```bash
journalctl -u kubelet
```
