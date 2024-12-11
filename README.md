1. rush install
2. Try `cd app; node src/main.js` - program exits without errors
3. rush deploy -p @local/app --overwrite
4. Change `platform` in `./docker-compose.yml` to platform other than
of your host
5. docker compose up - prints message:

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
