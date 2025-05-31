# audilen.yazi
Yazi Plugin to calculate total duration of all selected mp3 files. It required yazi version 25.5.31 or above and [mediainfo](https://mediaarea.net/en/MediaInfo/Download) to work.

### Working

Create ~/.config/yazi/keymap.toml if it dosen't exist and add the following lines.
```
    [[mgr.prepend_keymap]]
    on = [".", "l"]
    run = "plugin audiolen"
    desc = "Audio length plugin"
```
You can also change the keymap to what you want currently it is set to ```.```+```l```

Enter selection mode in yazi and use the keymap set above after selecting the audio files.

## Contact

*   [**Discord**](HTTPS://discordapp.com/users/399257188138483713) (English only)
