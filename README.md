## concrete5 wrapper script

This repository contains two shell script (`c5` for POSIX shells, `c5.bat` for Windows) that you can place in a directory of your path (for example `/usr/local/bin` for POSIX shells, `C:\Windows\System32` for Windows).

Once you do it, you can run the concrete5 CLI commands by simply invoking `c5` from your shells.
In order to detect the location of concrete5, the current working directory can be any of the following:
- the concrete5 webroot
- any sub-directory of the concrete5 webroot
- the parent directory of the concrete5 webroot (provided that the concrete5 webroot is a folder named `public` or `web`)

For example, if concrete5 is installed in the `/var/sites/example/public`, `c5` will detect concrete5 when the current directory is any of the following:

- `/var/sites/example`
- `/var/sites/example/public`
- `/var/sites/example/public/packages`
- `/var/sites/example/public/packages/my_package/blocks/my_block`

(the same will valid for Windows)


### POSIX-specific details

#### Running concrete5 as a different user

You can let `c5` execute the concrete5 CLI commands as another user (requires that the `sudo` command is available) by using the `C5_SUDOAS` environment variable.

For example:

```sh
C5_SUDOAS=www-data c5 c5:info
```

#### *Sourcing* the script

Instead of copying the `c5` script in a directory of your path, you can also *source* it (that is, preload it), for example in your shell initialization script (`~/.bashrc` for bash):

```sh
. /path/to/c5
```

Once you do it, you'll have the `c5` function available in your shell.
