# This project is archived!

Please see https://github.com/concrete5/console for current active development on the Concrete console.

-----

## concrete5 wrapper

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

### Windows-specific details

At least under Windows 7, the c5 script is recognized when in `C:\Windows\System32` but it doesn't necessarily work for the composerpkg script (*see below for details about composerpkg*)

The first issue is that the script might be locked by the system.

**Click on the composerpkg script and bring up the properties screen. At the bottom you should see an option to unlock it if it's locked.**

Generally speaking, it is probably better to put both your scripts in a custom folder, make sure neither composerpkg or c5 are locked by the system, and add your custom folder to your path.

For instance:

- Add c5, c5.bat, composerpkg and composerpkg.bat to `C:\Dev\Util\Bin` (create the folder)
- Then add your folder `C:\Dev\Util\Bin` to your path.

You can [find out how to add a folder to your Path on this page](https://www.java.com/en/download/help/path.xml "Add a folder to your Windows Path") (it's Java specific but the process is the same for any folder) 

## composer wrapper for package dependencies

When writing packages for concrete5, you may require composer libraries.
When using a composer-based concrete5 installation, this is not a problem, since composer will handle flawlessly your dependencies, and create an autoloader for you.

Problems arise when your package is going to be installed without composer, and you need to provide the composer libraries together with your package.

For example, let's assume that you have in your package `composer.json` file these requirements:

```json
{
    "require": {
        "concrete5/core": "^8.5.1",
        "some_vendor/some_package": "1"
    }
}
```

This is totally legal: you are telling composer that your package requires concrete5 version 8.5.1 (or any later 8.x version), and that you need the `some_vendor/some_package` package.
By the way, if you run a `composer install` because you want to distribute your package, composer will download concrete5 and install it in your vendor directory, which of course you don't want to.

Another problem arises when your package requires (directly or indirectly) a library that's already included in concrete5 vendor directory.
That leads to having to having two running copies of the same library (one in the concrete5 vendor directory, and one in your package vendor directory). This is a waste of space, and the actual version being used may be undetermined.

To avoid these problems, you can run the `composerpkg` command included in this repository (for Windows users, you'll also need the `composerpkg.bat` file - to be saved in the same directory as the `composerpkg` file).
`composerpkg` accepts the same arguments accepted by the plain `composer` command, but when you install/update the dependencies, you won't have duplicated stuff in your vendor directory.
