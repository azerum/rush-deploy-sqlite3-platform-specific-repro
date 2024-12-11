# Main issue

1. `rush install`
2. Try `cd app; node src/main.js` - prints `Yes!`
3. `rush deploy -p @local/app --overwrite`
4. Change `platform` in `./docker-compose.yml` to platform other than
of your host
1. `docker compose up --build` - prints message:

```
app-1  | node:internal/modules/cjs/loader:1586
app-1  |   return process.dlopen(module, path.toNamespacedPath(filename));
app-1  |                  ^
app-1  | 
app-1  | Error: Error loading shared library /deploy/common/temp/node_modules/.pnpm/sqlite3@5.1.7/node_modules/sqlite3/build/Release/node_sqlite3.node: Exec format error
app-1  |     at Module._extensions..node (node:internal/modules/cjs/loader:1586:18)
app-1  |     at Module.load (node:internal/modules/cjs/loader:1288:32)
app-1  |     at Module._load (node:internal/modules/cjs/loader:1104:12)
app-1  |     at Module.require (node:internal/modules/cjs/loader:1311:19)
app-1  |     at require (node:internal/modules/helpers:179:18)
app-1  |     at bindings (/deploy/common/temp/node_modules/.pnpm/bindings@1.5.0/node_modules/bindings/bindings.js:112:48)
app-1  |     at Object.<anonymous> (/deploy/common/temp/node_modules/.pnpm/sqlite3@5.1.7/node_modules/sqlite3/lib/sqlite3-binding.js:1:37)
app-1  |     at Module._compile (node:internal/modules/cjs/loader:1469:14)
app-1  |     at Module._extensions..js (node:internal/modules/cjs/loader:1548:10)
app-1  |     at Module.load (node:internal/modules/cjs/loader:1288:32) {
app-1  |   code: 'ERR_DLOPEN_FAILED'
app-1  | }
app-1  | 
app-1  | Node.js v20.18.1
app-1 exited with code 1
```

# Overriding works for `rush install`, breaks locally

1. Run in shell:

> Note: change `npm_config_platform` and `npm_config_arch` to something
> other than your host
>
> For list of supported platforms, see file names at https://github.com/TryGhost/node-sqlite3/releases/tag/v5.1.7
>
> Format is:
> 
> {name}-v{version}-{runtime}-v{abi}-{platform}{libc}-{arch}.tar.gz
>
> npm_config_target is {abi}

> Details: npm_config_libc=musl since Dockerfile is alpine-based

```shell
npm_config_target=6 \
npm_config_platform=linux \
npm_config_libc=musl \
npm_config_arch=x64 \
rush install --purge
```

2. Try `cd app; node src/main.js` - get error similar to the one above

3. `rush deploy -p @local/app --overwrite`

4. `docker compose up --build` - prints `Yes!`

# Overriding does not do anything for `rush deploy`

> If you walked through previous section, reinstall sqlite3 for your
> host using:
>
> `rush install --purge`

1. You can again verify that `cd app; node src/main.js` prints `Yes!`

2. Run in shell:

```shell
npm_config_target=6 \
npm_config_platform=linux \
npm_config_libc=musl \
npm_config_arch=x64 \
rush deploy -p @local/app --overwrite
```

3. `docker compose up --build` - get the same error
