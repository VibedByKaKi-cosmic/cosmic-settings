# COSMIC Settings APT repository

Binary packages for COSMIC Settings built automatically from commits on `master`.

```sh
echo "deb [trusted=yes] https://raw.githubusercontent.com/VibedByKaKi-cosmic/cosmic-settings/refs/heads/apt stable main" | sudo tee /etc/apt/sources.list.d/cosmic-settings.list
sudo apt update
sudo apt install cosmic-settings
```
