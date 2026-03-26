# termux-package-archive

> Build and download older versions of any Termux package using GitHub Actions.

Termux always ships the latest version of packages — there is no official way to install an older one. This repo lets you build any Termux package at any historical version by pointing it at the exact upstream commit, then downloading the resulting `.deb` directly from GitHub Releases.

No local setup required. Just fork, run, and install.

---

## How It Works

1. You fork this repo
2. You trigger the workflow with a package name and version
3. The workflow finds the matching upstream commit in [termux/termux-packages](https://github.com/termux/termux-packages)
4. It builds the `.deb` for `aarch64` and publishes it as a GitHub Release
5. You download and install it in Termux

---

## Usage

### 1. Fork this repository

Click **Fork** at the top right of this page.

### 2. Run the workflow

Go to **Actions → Build and Release Termux Package → Run workflow** and fill in:

| Input | Description | Example |
|---|---|---|
| `package_name` | The Termux package to build | `postgresql` |
| `target_version` | Version prefix to search for | `17` |
| `custom_commit` | *(Optional)* Exact upstream commit SHA | `a1b2c3d` |

> **Tip:** Leave `custom_commit` empty and the workflow will automatically find the right commit for your target version.

### 3. Download and install

Once the workflow completes, go to **Releases** and follow the install instructions included in each release.

---

## Installation (from a Release)

Releases are not pre-built — packages are built **on demand**. If you need a specific package version:

- **Fork this repo** and run the workflow yourself, or
- **Open an issue** requesting a specific package and version and it may be built and published here

Once a release exists, install it in Termux:

### Option 1: Quick Install (Individual .deb)

```bash
curl -L -O https://github.com/Jobians/termux-package-archive/releases/download/PACKAGE-VERSION/PACKAGE_VERSION_aarch64.deb
dpkg -i ./PACKAGE_VERSION_aarch64.deb
```

If you get a dependency error, run:

```bash
apt --fix-broken install
```

### Option 2: Full Bundle (includes all dependencies)

```bash
# Download the full bundle
curl -L -O https://github.com/Jobians/termux-package-archive/releases/download/PACKAGE-VERSION/PACKAGE-VERSION-aarch64-bundle.zip

# Unzip and install everything
unzip PACKAGE-VERSION-aarch64-bundle.zip
dpkg -i ./*.deb
```

---

## FAQ

**Why can't I just use `apt install package=version`?**  
Termux's package repos only keep the latest version. Older versions are not retained.

**Will this work for any package?**  
It works for any package available in [termux/termux-packages](https://github.com/termux/termux-packages) that has a `build.sh` with a matching version in its commit history.

**What if the build fails?**  
Try providing an exact `custom_commit` SHA instead of relying on automatic version search. You can browse the commit history of a specific package at:  
`https://github.com/termux/termux-packages/commits/master/packages/PACKAGE_NAME/build.sh`

---

## License

MIT
