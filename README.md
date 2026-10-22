# nanobox 📦

> **Single-file Linux process & filesystem isolation using native kernel namespaces. Zero Docker. Zero Podman. Zero Daemons.**

Docker is great for production, but massive bloat for running quick throwaway scripts, isolated build jobs, or testing untrusted code on low-resource machines.

`nanobox` is a ~60-line pure POSIX shell script that levers Linux `unshare`, mount namespaces, and `chroot` to provide instant process isolation without running background services or eating gigabytes of RAM.

---

## ⚡ Quickstart

```bash
# 1. Download single executable script
curl -O https://raw.githubusercontent.com/rekalnx/nanobox/main/nanobox.sh
chmod +x nanobox.sh
sudo mv nanobox.sh /usr/local/bin/nanobox

# 2. Spawn a scratch container directory
nanobox spawn my-sandbox

# 3. Execute isolated shell
nanobox run ~/.nanobox/my-sandbox /bin/sh
```

---

## 📄 License
MIT © [Reihan Valentino (rekalnx)](https://github.com/rekalnx)
