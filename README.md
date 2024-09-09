# Kobo-Rclone-Menu v0.4

A set of scripts to synchronize a kobo e-reader with popular cloud services, using [rclone](https://rclone.org).

Some example supported cloud services:

- Dropbox
- Google Drive
- NextCloud/OwnCloud
- pCloud
- Box

There are many more - see <https://rclone.org/docs/> for the full list.

## <a name="installation"></a>Installation

Download the latest `KoboRoot.tgz` from the Release page (or using [this direct link](https://github.com/pietvo/Kobo-Rclone-Menu/releases/latest)).

Copy it into the Kobo device:

- Connect the Kobo device and mount it (you should be able to access to the kobo filesystem)
- Copy the .tgz archive in the `.kobo` directory(1) of your device
- Unplug and restart your Kobo device

(1) It is a hidden directory, so you have to enable the visualization of hidden files

**Note for Mac/Safari users:** Safari automatically unpacks `KoboRoot.tgz` into `KoboRoot.tar` after downloading. Please make sure that you transfer the `.tgz` file to your Kobo, and **not** the `.tar`. Either use a different browser to download the package, or re-pack it (using `gzip`) before transferring.

The installation procedure will also install `NickelDBus`, `NickelMenu`, and `rclone`. Sometimes the installation may fail, for example if Wifi is not available. **So make sure your Kobo is connected to Wifi.** Then restart your Kobo.

## Configuration

After the installation process:

1. [Download](https://rclone.org/downloads/) rclone to your computer
2. Run `rclone config` to create a config file and add your remote Cloud services ([detailed instructions](https://rclone.org/remote_setup/#configuring-by-copying-the-config-file)).
    - You can add as many remote Cloud services as you need, but note the name you give each remote.
3. Plug your Kobo back into the computer.
4. Run `rclone config file` on your computer to find the rclone config file. Copy that file to `.add/kobo-rclone-menu/rclone.conf`
5. Edit the configuration file located at `.add/kobo-rclone-menu/kobo-rclonerc` on your Kobo, and add each remote:directory pair (one per line) as illustrated below.

## Configuration example

(Note: this is after going through the configuraton steps above)

```
# Lines starting with '#' are ignored
# Google drive:
my_google_drive:foldername

# Dropbox:
my_dropbox:other/folder/name
```

`rclone` supports many, many other remote types. See <https://rclone.org/docs/> for the full list.

### Matching remote server

To delete files from library when they are no longer in the remote server:

- Edit the `kobo-rclonerc` file so it contains the phrase `REMOVE_DELETED` in a single line (all capital, no spaces before or after).
- Restart your Kobo.

The next time the Kobo is connected to the internet, it will delete any files (it will not delete directories) that are not in the remote server.

(This works by running `rclone sync` instead of `rclone copy`.)

## Usage

The installation will provide a new menu item `Download Books` in the NickelMenu menu. The new files (ebooks) will be downloaded when you click this menu. Sometimes a few minutes are needed after the sync process for the device to recognize and import new downloaded content.

## Log Files

The log files of both the setup procedure and the last download can be found in the directory `.add/kobo-rclone-menu/kobo-rclonerc` on your Kobo. These logs are also collected in an "Ebook" (TXT file) called `Kobo-Rclone-Menu-Log` in the root of your Kobo. The first time you may have to reboot to make it visible. In this way you can inspect the logs without having to connect your Kobo to a computer. This file is cumulative, so you might occasionally remove it to start a fresh one.

## Uninstallation

To properly uninstall Kobo-Rclone-Menu:

- Edit the `kobo-rclonerc` file mentioned above so that it contains the word `UNINSTALL` in a single line (all capital, no spaces before or after)
- Restart your Kobo

The next time the Kobo is connected to the Internet, the program will delete itself. `NickelDBus` and `NickelMenu` will not be uninstalled, but `rclone` will.

To also uninstall `NickelMenu`, just create a new file named `uninstall` in `.adds/nm/` on your Kobo. To uninstall `NickelDBus`,  delete the file called `nickeldbus` in the `.adds` directory. After this, restart your Kobo.

Note: The downloaded ebooks in the folder `.add/kobo-rclone-menu` will not be deleted: after connecting the device to a computer, you should move the files from the `Library` subfolder in order not to lose your content, and delete the whole kobo-rclone-menu directory manually.


## Installation from source code

To install Kobo-Rclone-Menu from source code:

- Download this repository
- Compile the code into an archive format (instructions below)
- Follow [installation](#installation) instructions

### Compiling

- Move to the project directory root
- Open the configuration file located at `src/usr/local/kobo-rclone-menu/kobo-rclonerc.tmpl`
- Add the links to the cloud services (see the configuration example that follow below)
- Run `sh ./makeKoboRoot.sh`

The last command will create a `KoboRoot.tgz` archive.

Now you can follow [installation](#installation) instructions.

## Troubleshooting

Kobo-Rclone-Menu keeps a log of the installation process in the `.add/kobo-rclone-menu/setup.log` file and for the download session in the `.add/kobo-rclone-menu/get.log` file. If something goes wrong, useful information can be found there. Please send a copy of this file with every bug report.

## Known issues

* Some versions of Kobo make the same book appear twice in the library. This is because it scans the internal directory where the files are saved as well as the "official" folders. To solve this problem find the `Kobo eReader.conf` file inside your `.kobo/Kobo` folder and make sure the following line (which prevents the syncing of dotfiles and dotfolders) is set in the `[FeatureSettings]` section:
```
  [FeatureSettings]
  ExcludeSyncFolders=\\\.(?!add|adobe).*?
```

## Acknowledgment

Kobo-Rclone-Menu installs [NickelDBus](https://github.com/shermp/NickelDBus) if not present. Thanks to shermp for providing this.

It also installs [NickelMenu](https://pgaskin.net/NickelMenu/) if not present. Thanks to Patrick Gaskin for providing this.

Thanks to the [`rclone`](https://rclone.org) developers for providing `rclone`.

This work was built upon work by [fsantini](https://github.com/fsantini/KoboCloud) and [Mark N](https://github.com/marklar423/KoboCloud-rclone). Thanks to both for developing the code.
