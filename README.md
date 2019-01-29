## concrete5 wrapper script

This repository contains two shell scripts (`c5` for POSIX shells, `c5.bat` for Windows) that you can place in a directory of your path (for example `/usr/local/bin` for POSIX shells, or `C:\Windows\System32` for Windows).

Once you do it, you can run the concrete5 CLI commands by simply invoking `c5` from your shells.
In order to detect the location of concrete5, the current working directory can be any of the following:
- the concrete5 webroot
- any sub-directory of the concrete5 webroot
- the parent directory of the concrete5 webroot (provided that the concrete5 webroot is a folder named `public` or `web`)

For example, if concrete5 is installed in `/var/sites/example/public`, `c5` will detect concrete5 if the current directory is any of the following locations:

- `/var/sites/example`
- `/var/sites/example/public`
- `/var/sites/example/public/packages`
- `/var/sites/example/public/packages/my_package/blocks/my_block`

(the same principle applies to Windows)


### POSIX-specific details

#### Running concrete5 as a different user

You can let `c5` execute the concrete5 CLI commands as another user by using the `C5_SUDOAS` environment variable. It requires that the `sudo` command is available.

For example:

```sh
C5_SUDOAS=www-data c5 c5:info
```

#### *Sourcing* the script

Instead of copying the `c5` script to a directory of your path, you can also *source* it (that is, preload it), for example in your shell initialization script (`~/.bashrc` for bash):

```sh
. /path/to/c5
```

Once you have reloaded your shell, you'll have the `c5` function available.
