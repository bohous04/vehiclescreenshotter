# propscreenshotter

Edited script for FiveM that takes screenshots of vehicles, and processes the images.

### Deps
- [rembg](https://github.com/danielgatis/rembg)
- [ox_lib](https://github.com/overextended/ox_lib)
- [screenshot-basic](https://github.com/citizenfx/screenshot-basic)
- [NodeJS](https://nodejs.org/)
- [pnpm](https://overextended.dev/guides/pnpm)

### Instaling rembg
- Download latest [release version](https://github.com/danielgatis/rembg/releases)
- Open and instal rembg-cli-installer.exe
- Open windows terminal and insert this command ```pip install rembg```
- Next command ```pip install "rembg[cli]"```

### Usage
- Start rembg with command into windows terminal ```rembg s --host 0.0.0.0 --port 5000 --log_level info```
- Navigate to `src/server` and run `pnpm install & pnpm start`
- Enter FiveM and run `/screenvehicle <model name>` or `/screenCurrVeh` or `/screenallvehicles`
- Find the ouptut in `src/server/uploads`

- If you are using screenallvehicles your game will propably crash, just after you reconnect use command `/saveVehicles` after that you can restart the script and you won't take pictures that are already taken

- If the vehicle doesn't fit in the picture you can edit value of variable `distanceMultiplier`
