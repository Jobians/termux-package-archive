# Termux Overrides

> Customize or patch Termux packages during CI builds.

This folder allows you to apply custom scripts to any Termux package before it is built. Overrides are useful for:

- Fixing bugs in historical package versions  
- Applying patches not yet merged upstream  
- Modifying build behavior or dependencies  

All scripts are executed automatically by the **“Apply Termux Overrides”** workflow step.

---

## Directory Structure

Overrides are organized by package and version:

```text
termux-overrides/
└── <package_name>/
    ├── <exact_version>/   # e.g., 8.4.0
    │   └── script.sh
    ├── <minor_version>.x/ # e.g., 8.4.x
    │   └── script.sh
    └── <major_version>.x/ # e.g., 8.x
        └── script.sh
````

**Matching order:**

1. Exact version (e.g., 8.4.1)
2. Minor version wildcard (e.g., 8.4.x)
3. Major version wildcard (e.g., 8.x)

The workflow chooses the most specific matching folder for the package version being built.

---

## Writing Override Scripts

* Must be Bash (`.sh`) scripts
* Should be **idempotent** (safe to run multiple times)
* Run inside the override folder — relative paths work correctly

**Example:** `termux-overrides/php/8.4.x/update-apache2-srcurl.sh`

```bash
#!/usr/bin/env bash

APACHE2_BUILD="$GITHUB_WORKSPACE/termux-packages/packages/apache2/build.sh"

# Replace downloads.apache.org with archive.apache.org/dist in TERMUX_PKG_SRCURL
sed -i '/^TERMUX_PKG_SRCURL=/ s|downloads.apache.org|archive.apache.org/dist|' "$APACHE2_BUILD"

# Display updated URL
grep "^TERMUX_PKG_SRCURL=" "$APACHE2_BUILD"
```

This script updates the `TERMUX_PKG_SRCURL` for the `apache2` package to use the archive URL instead of the default downloads server.

---

## Tips

* Only scripts in the chosen override folder are executed. Other files are ignored.
* Use overrides for experimental changes or temporary fixes. Permanent fixes should go upstream to [termux/termux-packages](https://github.com/termux/termux-packages).
* Check the workflow logs under **Actions → Build and Release Termux Package** to see which override scripts were run.

---

## FAQ

**Q: Can I override multiple packages at once?**
A: Yes, just create folders for each package under `termux-overrides/`.

**Q: What happens if no override exists?**
A: The workflow continues normally without running any scripts.

**Q: Can I override a minor version instead of exact version?**
A: Yes. Use `x` wildcards for minor (e.g., `8.4.x`) or major (e.g., `8.x`) versions.
