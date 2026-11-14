[![](https://shields.kaki87.net/badge/github.com-main-blue?style=flat&logo=github)](https://github.com/VibedByKaKi-cosmic/cosmic-settings)
[![](https://shields.kaki87.net/github/stars/VibedByKaKi-cosmic/cosmic-settings)](https://github.com/VibedByKaKi-cosmic/cosmic-settings)

# COSMIC Settings, AI-augmented

Original `README.md`:
- [on `master` branch of this fork](https://github.com/VibedByKaKi-cosmic/cosmic-settings/blob/master/README.md);
- [on `master` branch from upstream](https://github.com/pop-os/cosmic-settings/blob/master/README.md).

## Exclusive features

### APT repository

For Pop!_OS 24.04 (x86_64), add `cosmic-settings` to APT for automated updates:

```bash
echo "deb [trusted=yes] https://raw.githubusercontent.com/VibedByKaKi-cosmic/cosmic-settings/refs/heads/apt stable main" | sudo tee /etc/apt/sources.list.d/cosmic-settings.list
sudo apt update
sudo apt install cosmic-settings
```

### GitHub Releases

From the [latest release](https://github.com/VibedByKaKi-cosmic/cosmic-settings/releases/latest), download:

| Architecture \ Package type | DEB package                   |
| --------------------------- | ----------------------------- |
| **`amd64`/`x86-64`**        | `cosmic-settings_*_amd64.deb` |

## Fixes

_Nothing documented yet._
